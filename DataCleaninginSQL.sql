/*

CLEANING DATA IN MS SQL SERVER

*/

select *
from Projects.dbo.NashvilleHousing

-- Formate SaleDate from Datetime format to Date Format

ALTER TABLE Projects.dbo.NashvilleHousing
ADD SaleDateConverted Date

UPDATE Projects.dbo.NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

-- To confirm that the update was successful

select SaleDate, SaleDateConverted
from Projects.dbo.NashvilleHousing

-- Populate Property Address Data
select PropertyAddress
from Projects.dbo.NashvilleHousing
where PropertyAddress is null


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from Projects.dbo.NashvilleHousing a
JOIN Projects.dbo.NashvilleHousing b
  ON a.ParcelID = b.ParcelID
  AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null 


update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from Projects.dbo.NashvilleHousing a
JOIN Projects.dbo.NashvilleHousing b
  ON a.ParcelID = b.ParcelID
  AND a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null


  -- Seperating Propertyaddress into individual columns (Address, state and city)

  select PropertyAddress
  from projects.dbo.NashvilleHousing

  select 
  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
  SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as State
  from projects.dbo.NashvilleHousing

ALTER TABLE Projects.dbo.NashvilleHousing
ADD PropertySplitAddress text

UPDATE Projects.dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE Projects.dbo.NashvilleHousing
ADD PropertySplitCity text

UPDATE Projects.dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

select PropertySplitCity, PropertySplitAddress
from Projects.dbo.NashvilleHousing

--Seperating OwnerAddress into Address,city and state

select owneraddress
from Projects.dbo.NashvilleHousing

select
PARSENAME(REPLACE(owneraddress,',', '.'), 3),
PARSENAME(REPLACE(owneraddress,',', '.'), 2),
PARSENAME(REPLACE(owneraddress,',', '.'), 1)
from Projects.dbo.NashvilleHousing


ALTER TABLE Projects.dbo.NashvilleHousing
ADD OwnerSplitAddress text

UPDATE Projects.dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(owneraddress,',', '.'), 3)

ALTER TABLE Projects.dbo.NashvilleHousing
ADD OwnerSplitCity text

UPDATE Projects.dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(owneraddress,',', '.'), 2)

ALTER TABLE Projects.dbo.NashvilleHousing
ADD OwnerSplitState text

UPDATE Projects.dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(owneraddress,',', '.'), 1)


-- Change Y and N to "Yes" and "No" in "SoldAsVacant"
select SoldAsVacant,
case
  when SoldAsVacant = 'Y' THEN 'Yes'
  when SoldAsVacant = 'N' THEN 'No'
  Else SoldAsVacant
END
From Projects.dbo.NashvilleHousing

UPDATE Projects.dbo.NashvilleHousing
SET SoldAsVacant = case
  when SoldAsVacant = 'Y' THEN 'Yes'
  when SoldAsVacant = 'N' THEN 'No'
  Else SoldAsVacant
END

SELECT DISTINCT(SoldAsVacant)
from Projects.dbo.NashvilleHousing

-- Remove Duplicates
WITH RowNumCTE AS(
select *,
       ROW_NUMBER() OVER (
	   PARTITION BY ParcelID, 
	                PropertyAddress, 
					SalePrice, 
					SaleDate, 
					LegalReference
	                ORDER BY 
					UniqueID 
					) row_num

from Projects.dbo.NashvilleHousing
)
Delete 
from RowNumCTE
where row_num > 1


-- Remove unused columns
ALTER TABLE Projects.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, PropertyAddress, SaleDate


   

  
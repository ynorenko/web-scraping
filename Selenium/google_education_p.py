from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException 
import time
import csv
import re


driver = webdriver.Chrome()
time.sleep(3)

driver.get('https://play.google.com/store/search?q=education&c=apps&price=2')

match=False
lenOfPage = driver.execute_script("window.scrollTo(0, document.body.scrollHeight);var lenOfPage=document.body.scrollHeight;return lenOfPage;")
while match ==False:
	try:
		lastCount = lenOfPage
		driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")	
		time.sleep(2)
		lenOfPage = driver.execute_script("window.scrollTo(0, document.body.scrollHeight);var lenOfPage=document.body.scrollHeight;return lenOfPage;")
		if lastCount==lenOfPage:
			match=True
		more_button = driver.find_element_by_xpath('//*[@id="show-more-button"]')
		more_button.click()

	except:
		continue

csv_file = open('education_paid.csv', 'w')
writer = csv.writer(csv_file)

app_urls = driver.find_elements_by_xpath('.//a[@class = "title"]')
print (len(app_urls))

app_urls_1 = [x.get_attribute('href') for x in app_urls]

for url in app_urls_1:
	driver.get(url)


	app_info= {}


	if driver.find_element_by_xpath('.//span[2][@class = "T32cc UAO9ie"]/a').text == 'Education':
		name = driver.find_element_by_xpath('.//h1[@class = "AHFaub"]/span').text
		category = driver.find_element_by_xpath('.//span[2][@class = "T32cc UAO9ie"]/a').text
		developer =  driver.find_element_by_xpath('.//span[1][@class = "T32cc UAO9ie"]/a').text
		try:
			ads = driver.find_element_by_xpath('.//div[@class = "rxic6"]').text
		except:
			ads = ""
		try:
			numberOfreviews = re.search(r'\d*\,*\d*\,+\d*|\d*\,?\d+', driver.find_element_by_xpath(".//span[@class = 'AYi5wd TBRnV']/span").get_attribute('aria-label')).group(0)
		except:
			numberOfreviews = ""

		if numberOfreviews != "":
			try:
				rating = re.search(r'\d*\.?\d+', driver.find_element_by_xpath('.//div[@class = "pf5lIe"]/div').get_attribute('aria-label')).group(0)
			except:
				rating = ""
		else:
			rating = ""

		try: 
			if re.search('.k', driver.find_element_by_xpath('.//div[3]/span[@class = "htlgb"]/div/span').text) !=None:
				size = int((re.search(r'\d*\,*\d*\,+\d*|\d*\.?\d+', driver.find_element_by_xpath('.//div[3]/span[@class = "htlgb"]/div/span').text).group(0).replace(',','')))/1000
			elif re.search('.M', driver.find_element_by_xpath('.//div[3]/span[@class = "htlgb"]/div/span').text) != None:
				size = re.search(r'\d*\,*\d*\,+\d*|\d*\.?\d+', driver.find_element_by_xpath('.//div[3]/span[@class = "htlgb"]/div/span').text).group(0)
			else:
				size = ""
		except:
			size = ""

		if size != "" or re.search(r'[a-z]', driver.find_element_by_xpath('.//div[3]/span[@class = "htlgb"]/div/span').text).group(0) !=None:
			try:
				installs = re.search(r'\d*\,*\d*\,+\d*|\d*\,?\d+', driver.find_element_by_xpath('.//div[4]/span[@class = "htlgb"]/div/span').text).group(0)
			except:
				installs = ""
		else:
			try:
				installs = re.search(r'\d*\,*\d*\,+\d*|\d*\,?\d+', driver.find_element_by_xpath('.//div[3]/span[@class = "htlgb"]/div/span').text).group(0)
			except:
				installs = ""	

		try:
			price = re.search(r'\d*\.?\d+', driver.find_element_by_xpath('.//span[@class = "oocvOe"]/button').get_attribute('aria-label')).group(0)
		except:
			price = ""
	else:
		continue
	

	app_info['name'] = name
	app_info['category'] = category
	app_info['developer'] = developer
	app_info['ads'] = ads
	app_info['rating'] = rating
	app_info['numberOfreviews'] = numberOfreviews
	app_info['size'] = size
	app_info['installs'] = installs
	app_info['price'] = price
	writer.writerow(app_info.values())


csv_file.close()
driver.close()

















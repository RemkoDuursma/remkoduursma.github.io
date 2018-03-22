

```{r, eval=F, echo=F}

# Notes

Singapore bulk fuel price determines base petrol price in Australia
https://bulkfuel.com.au/news/96-the-singapore-benchmark-how-australia-prices-fuel

More on what determines petrol price
https://bulkfuel.com.au/news/86-facts-about-the-bulk-fuel-market-and-prices


[ACCC will investigate petrol price cycle](https://www.9news.com.au/national/2018/03/02/06/31/accc-launch-probe-into-petrol-price-cycle)


[Reporting on petrol price cycles is dodgy at best](https://www.9news.com.au/national/2018/01/10/19/51/the-reason-why-petrol-30-cents-more-expensive-in-some-sydney-suburbs)

[Price gouging not illegal; "no evidence of price hiking during christmas"](https://thenewdaily.com.au/money/your-budget/2017/12/21/scott-morrison-promise-end-petrol-price-gouging/)


[Nine News petrol saving guide](https://www.9saver.com.au/saving-guide/petrol-savings-guide)

see github issue (fuelpricensw)
reporting cycle might be interesting: unmanned stations perhaps only report after a price change (and reports that those stations keep the same price all month!) 
therefore sd(price) should be correlated with reporting cycle


Collective bargaining is not allowed

https://www.accc.gov.au/business/pricing-surcharging/setting-prices
https://www.accc.gov.au/business/anti-competitive-behaviour

but is ok for small businesses

https://www.accc.gov.au/publications/small-business-collective-bargaining-notifications-the-competition-and-consumer-act

# ok so a service station owner in McGrath Hill has a small business, but the vast majority is franchised by a large corporation (BP, Caltex, etc)
# the exceptions are 'independent', 'budget' (?) and 'Metro' (?) - *the cheapest of the brands in sydney*.



australians (NSW) spend $150 on fuel per month
https://www.canstarblue.com.au/vehicles/how-much-we-pay-for-petrol/
  
  
  the automobile association does not even mention the cycles; monthly reports hide price setting:
  http://www.aaa.asn.au/latest-fuel-prices/
  ```


```{r, eval=FALSE}

#We have evidence that the magnitude of the price hike varies by brand:

brand_colours <- RColorBrewer::brewer.pal(7,"Set3")

group_by(cycsyd_a, Brand2) %>%
  filter(n() > 25) %>% ungroup %>%
  mutate(Brand = reorder(Brand2, price_hike_median, 
                         function(x)-median(x, na.rm=TRUE))) %>%
  ggplot(aes(x=Brand, y=price_hike_median, fill=Brand2)) +
  geom_boxplot() + 
  theme_tufte() +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x="", y="Median price hike ($ cent)") + 
  ylim(c(0,40)) +
  scale_fill_manual(values=brand_colours)

```




```{r, eval=F, echo=F}
# map of stations coloured by brand
ggmap(syd_map) + 
  geom_polygon(aes(x=lon,y=lat), data=syd_vert, alpha=0.15) +
  geom_point(aes(x=lon, y=lat, fill=Brand2), 
             col="dimgrey",
             data=cycsyd_a, size=3, shape=21) + 
  scale_fill_manual(values=RColorBrewer::brewer.pal(7,"Set3")) 

```


```{r, eval=FALSE}
# Median price just before the price hike (bottom price)
cycsyd_a_2 <- filter(cycsyd_a, price_low_median < 125)
ggmap(syd_map) + 
  geom_polygon(aes(x=lon,y=lat), data=syd_vert, alpha=0.15) +
  geom_point(aes(x=lon, y=lat, size=price_low_median, fill=price_low_median), 
             col="dimgrey",
             data=cycsyd_a_2, shape=21) + 
  guides(color= guide_legend(), size="none") +
  scale_fill_gradientn(colours=rev(heat.colors(10)),
                       name="Median \nbottom price (c)") 

```


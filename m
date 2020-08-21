Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A219C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D9C20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT9c5r+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHUSgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHUSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:36:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A1C06179A;
        Fri, 21 Aug 2020 11:29:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x6so1377371pgx.12;
        Fri, 21 Aug 2020 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Bt6z66I01y6R+MC1lpHyARTzFhlNekN+fweHpFeiRY=;
        b=nT9c5r+Q6fDehXqVZ/+uTpIZGgpq5nhijpywnWh7GU9ASwhKa1F3JaCokPiFhddRAG
         3UwVyd+hPhAMg79BUcaMk/ZiE8xMb9RRtXo2/+HaYRSt4wvxQKhMkSJeDHJByvmi9dBQ
         R7yXMUiJJLHQBEirWO7jVkb8YjgCRBiLPzyDfGXbaRR85I9/pmMDdLdKAz2/HNCDN4js
         UUEYEfnMuMHaOGnzBLQ/7g04RH6bstvrCviRTcpwT/0sr8DRffxm3Y9CW0mY+Qy5MZGR
         OxnLAP4l29UZvV0n8aq6roysj4teUIDuDsZ6Hk+hixBNxlMl/pU+aXUKbSibjHR4ypHe
         5wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Bt6z66I01y6R+MC1lpHyARTzFhlNekN+fweHpFeiRY=;
        b=eIApBCahwgCCpJTpHuIIy33BgWxau/g0zqROP5J2LxQQHTTvYoBTeMzC+uBpObTuV1
         4dqt7vUcjsBQlXBj4eQAeXwiS4bRp2dYYjNhH5hZglTXcx85GXNZIwnDJl31bIaqoVsg
         SuGNZtzWTBFC2lvY6kbK249oiFsdGhHtZRSxwyeYnd0PaQZqLxAcDqZXdTSDk2lJAnnO
         iBX+FWj7PAhsz+XQ1nxWLr0+v5j264f7sQ7OC9sYH2Zf4wNjsJSsXNbmgniLWb3wgqVm
         JKLtP+kVf4jZf7BGYsGAgn3jErdG7EyBmEqE2DvU/mFPNG6rHqtGSXuE/0zol7EI1hEK
         ov2Q==
X-Gm-Message-State: AOAM532JC1LNyibH3WDre7zp3wOzuF3YZpEUwuBd1IJFSwkv23NB0Dmc
        RQDXmC494dg8qmNby4uC3B+BEGS8h6Q=
X-Google-Smtp-Source: ABdhPJyrjHoD4PTfhL9LxNfoHoiNJ605iO5FR5xgDRpd0asbp22NLAZliZJ8j2+1CBR2INmCwlvYkA==
X-Received: by 2002:a05:6a00:c9:: with SMTP id e9mr3485560pfj.224.1598034559865;
        Fri, 21 Aug 2020 11:29:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z26sm2656806pgc.44.2020.08.21.11.29.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:29:19 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:29:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: use simple i2c probe function
Message-ID: <20200821182918.GA26770@roeck-us.net>
References: <20200821160354.594715-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821160354.594715-1-steve@sk2.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:03:54PM +0200, Stephen Kitt wrote:
> Many hwmon drivers don't use the id information provided by the old
> i2c probe function, and the remainder can easily be adapted to the new
> form ("probe_new") by calling i2c_match_id explicitly.
> 
> This avoids scanning the identifier tables during probes.
> 
> Drivers which didn't use the id are converted as-is; drivers which did
> are modified to call i2c_match_id() with the same level of
> error-handling (if any) as before.
> 
> This patch wraps up the transition for hwmon, with four stragglers not
> included in the previous large patch.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/adc128d818.c | 5 ++---
>  drivers/hwmon/ads7828.c    | 9 +++++----
>  drivers/hwmon/lm87.c       | 4 ++--
>  drivers/hwmon/w83795.c     | 9 +++++----
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
> index f9edec195c35..80511d316845 100644
> --- a/drivers/hwmon/adc128d818.c
> +++ b/drivers/hwmon/adc128d818.c
> @@ -427,8 +427,7 @@ static int adc128_init_client(struct adc128_data *data)
>  	return 0;
>  }
>  
> -static int adc128_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int adc128_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct regulator *regulator;
> @@ -524,7 +523,7 @@ static struct i2c_driver adc128_driver = {
>  		.name	= "adc128d818",
>  		.of_match_table = of_match_ptr(adc128_of_match),
>  	},
> -	.probe		= adc128_probe,
> +	.probe_new	= adc128_probe,
>  	.remove		= adc128_remove,
>  	.id_table	= adc128_id,
>  	.detect		= adc128_detect,
> diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
> index d895b73fde6f..7246198f0901 100644
> --- a/drivers/hwmon/ads7828.c
> +++ b/drivers/hwmon/ads7828.c
> @@ -99,8 +99,9 @@ static const struct regmap_config ads2830_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> -static int ads7828_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static const struct i2c_device_id ads7828_device_ids[];
> +
> +static int ads7828_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct ads7828_platform_data *pdata = dev_get_platdata(dev);
> @@ -141,7 +142,7 @@ static int ads7828_probe(struct i2c_client *client,
>  		chip = (enum ads7828_chips)
>  			of_device_get_match_data(&client->dev);
>  	else
> -		chip = id->driver_data;
> +		chip = i2c_match_id(ads7828_device_ids, client)->driver_data;
>  
>  	/* Bound Vref with min/max values */
>  	vref_mv = clamp_val(vref_mv, ADS7828_EXT_VREF_MV_MIN,
> @@ -207,7 +208,7 @@ static struct i2c_driver ads7828_driver = {
>  	},
>  
>  	.id_table = ads7828_device_ids,
> -	.probe = ads7828_probe,
> +	.probe_new = ads7828_probe,
>  };
>  
>  module_i2c_driver(ads7828_driver);
> diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> index ad501ac4a594..24cb8a1c3381 100644
> --- a/drivers/hwmon/lm87.c
> +++ b/drivers/hwmon/lm87.c
> @@ -912,7 +912,7 @@ static int lm87_init_client(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static int lm87_probe(struct i2c_client *client)
>  {
>  	struct lm87_data *data;
>  	struct device *hwmon_dev;
> @@ -994,7 +994,7 @@ static struct i2c_driver lm87_driver = {
>  		.name	= "lm87",
>  		.of_match_table = lm87_of_match,
>  	},
> -	.probe		= lm87_probe,
> +	.probe_new	= lm87_probe,
>  	.id_table	= lm87_id,
>  	.detect		= lm87_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
> index 44f68b965aec..9cff2e399f1d 100644
> --- a/drivers/hwmon/w83795.c
> +++ b/drivers/hwmon/w83795.c
> @@ -2134,8 +2134,9 @@ static void w83795_apply_temp_config(struct w83795_data *data, u8 config,
>  	}
>  }
>  
> -static int w83795_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static const struct i2c_device_id w83795_id[];
> +
> +static int w83795_probe(struct i2c_client *client)
>  {
>  	int i;
>  	u8 tmp;
> @@ -2148,7 +2149,7 @@ static int w83795_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	i2c_set_clientdata(client, data);
> -	data->chip_type = id->driver_data;
> +	data->chip_type = i2c_match_id(w83795_id, client)->driver_data;
>  	data->bank = i2c_smbus_read_byte_data(client, W83795_REG_BANKSEL);
>  	mutex_init(&data->update_lock);
>  
> @@ -2256,7 +2257,7 @@ static struct i2c_driver w83795_driver = {
>  	.driver = {
>  		   .name = "w83795",
>  	},
> -	.probe		= w83795_probe,
> +	.probe_new	= w83795_probe,
>  	.remove		= w83795_remove,
>  	.id_table	= w83795_id,
>  

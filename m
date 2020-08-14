Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D35C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA42420855
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esDUeljz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgHNPMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:12:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0463BC061384;
        Fri, 14 Aug 2020 08:12:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ha11so4523820pjb.1;
        Fri, 14 Aug 2020 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UzUH45d1fZdzKKTRs2BiNeFppHZ9E3GD3spJunBoAcs=;
        b=esDUeljzV+KMigFLbkUYEzZba3LPO9WxlA3TutwOQdt47K0nBv2F1bYMS9iAKv5T8y
         oHpurRiNLChzN99gPGv5ZG6qoVwNQXaYUL2AlI2Ljoi+EYmu3O2gcutn3ewgppAMwh6A
         6mMtiNBYycN9kCfmbZsW9oAh3wyUhayRp0njSgZVQmzRhzpVirlctSxiIb2K+qFPRSUc
         lSPuUBI2j5bWC+XBz1cVae8IN4MGmeASN6/nKExAsN1jGfIm3cZUAFm67SmJYQ7v96Y2
         FtI4rxMDMLIjhehZ2eyVin6KVQLGwIrFHq7pc19fQUhq2U5B5lFOdYL40bMDaEPoNcGf
         yTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UzUH45d1fZdzKKTRs2BiNeFppHZ9E3GD3spJunBoAcs=;
        b=FMrTXpFv40+hoHhPwrjBdZvXHkKOuAoNaDgeAbbSV2KqVoF+PNqa0M5tjGWkDP1oZ7
         oHjq3FtwMmib6O/vZCLgBe8ooKMJC3wK/mzhDUZ0g2G1Km49vJEDudABGQcCi5xTl+J6
         kfTgSfmiZoMY4ZqIaPcXOeJ772RH9/OAeHUFJKlAtqtsxbV5bbPLmKrSwYEIFoISow+K
         6OPyaGMBtxfpR+oD+QmgnUyzlOYNqT84A5RcmV1FdjtElO7MMrYnpFtD4C0VA9a0CTL1
         eJs7VLneyMVF2Xu5bm3qRcxlruIDpZQqvsxBJ4Uy3sOY08ISYsFsh671ggpgS6QdMVPK
         xidA==
X-Gm-Message-State: AOAM531749XX1BjPLHsuc8lkqDveEaKGdhH/FsFe0UdMvOY9Pva8S5pd
        jcoe+SpkImVS9ZReG66sNnA=
X-Google-Smtp-Source: ABdhPJxuWSfgE2yz55+okrd86Wis6T1hS8WC+BNQePBCM5tDqJo4rmt5G6ZS66sSp6F3LNgX7CSdLA==
X-Received: by 2002:a17:90a:e643:: with SMTP id ep3mr2731890pjb.18.1597417934451;
        Fri, 14 Aug 2020 08:12:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3sm8705868pgj.4.2020.08.14.08.12.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Aug 2020 08:12:13 -0700 (PDT)
Date:   Fri, 14 Aug 2020 08:12:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: use simple i2c probe function
Message-ID: <20200814151212.GA256305@roeck-us.net>
References: <20200813160222.1503401-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813160222.1503401-1-steve@sk2.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:02:22PM +0200, Stephen Kitt wrote:
> Many hwmon drivers don't use the id information provided by the old
> i2c probe function, and the remainder can easily be adapted to the new
> form ("probe_new") by calling i2c_match_id explicitly.
> 
> This avoids scanning the identifier tables during probes.
> 
> Drivers which didn't use the id are converted as-is; drivers which did
> are modified as follows:
> 
> * if the information in i2c_client is sufficient, that's used instead
>   (client->name);
> * anything else is handled by calling i2c_match_id() with the same
>   level of error-handling (if any) as before.
> 
> A few drivers aren't included in this patch because they have a
> different set of maintainers. They will be covered by other patches.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ad7414.c      |  5 ++---
>  drivers/hwmon/ad7418.c      |  9 +++++----
>  drivers/hwmon/adm1021.c     |  9 +++++----
>  drivers/hwmon/adm1025.c     |  5 ++---
>  drivers/hwmon/adm1026.c     |  5 ++---
>  drivers/hwmon/adm1031.c     |  9 +++++----
>  drivers/hwmon/adm9240.c     |  5 ++---
>  drivers/hwmon/adt7410.c     |  5 ++---
>  drivers/hwmon/adt7411.c     |  5 ++---
>  drivers/hwmon/adt7462.c     |  5 ++---
>  drivers/hwmon/adt7470.c     |  5 ++---
>  drivers/hwmon/adt7475.c     |  6 +++---
>  drivers/hwmon/amc6821.c     |  5 ++---
>  drivers/hwmon/asb100.c      |  8 +++-----
>  drivers/hwmon/atxp1.c       |  5 ++---
>  drivers/hwmon/ds1621.c      |  9 +++++----
>  drivers/hwmon/ds620.c       |  5 ++---
>  drivers/hwmon/emc1403.c     |  8 +++++---
>  drivers/hwmon/emc6w201.c    |  5 ++---
>  drivers/hwmon/fschmd.c      | 10 ++++------
>  drivers/hwmon/ftsteutates.c |  4 ++--
>  drivers/hwmon/g760a.c       |  5 ++---
>  drivers/hwmon/g762.c        |  4 ++--
>  drivers/hwmon/gl518sm.c     |  5 ++---
>  drivers/hwmon/gl520sm.c     |  5 ++---
>  drivers/hwmon/hih6130.c     |  5 ++---
>  drivers/hwmon/ina209.c      |  5 ++---
>  drivers/hwmon/ina2xx.c      |  9 +++++----
>  drivers/hwmon/ina3221.c     |  5 ++---
>  drivers/hwmon/jc42.c        |  4 ++--
>  drivers/hwmon/lineage-pem.c |  5 ++---
>  drivers/hwmon/lm63.c        |  9 +++++----
>  drivers/hwmon/lm75.c        |  9 +++++----
>  drivers/hwmon/lm77.c        |  4 ++--
>  drivers/hwmon/lm78.c        |  9 +++++----
>  drivers/hwmon/lm80.c        |  5 ++---
>  drivers/hwmon/lm83.c        |  9 +++++----
>  drivers/hwmon/lm85.c        |  8 +++++---
>  drivers/hwmon/lm90.c        |  7 +++----
>  drivers/hwmon/lm92.c        |  5 ++---
>  drivers/hwmon/lm93.c        |  5 ++---
>  drivers/hwmon/lm95234.c     |  9 +++++----
>  drivers/hwmon/lm95241.c     |  5 ++---
>  drivers/hwmon/lm95245.c     |  5 ++---
>  drivers/hwmon/ltc2945.c     |  5 ++---
>  drivers/hwmon/ltc2990.c     |  5 ++---
>  drivers/hwmon/ltc4151.c     |  5 ++---
>  drivers/hwmon/ltc4215.c     |  5 ++---
>  drivers/hwmon/ltc4222.c     |  5 ++---
>  drivers/hwmon/ltc4245.c     |  5 ++---
>  drivers/hwmon/ltc4260.c     |  5 ++---
>  drivers/hwmon/ltc4261.c     |  5 ++---
>  drivers/hwmon/max16065.c    |  8 +++++---
>  drivers/hwmon/max1619.c     |  5 ++---
>  drivers/hwmon/max1668.c     |  9 +++++----
>  drivers/hwmon/max31730.c    |  4 ++--
>  drivers/hwmon/max31790.c    |  5 ++---
>  drivers/hwmon/max6621.c     |  5 ++---
>  drivers/hwmon/max6639.c     |  5 ++---
>  drivers/hwmon/max6642.c     |  5 ++---
>  drivers/hwmon/max6650.c     | 10 ++++++----
>  drivers/hwmon/max6697.c     |  9 +++++----
>  drivers/hwmon/mcp3021.c     |  9 +++++----
>  drivers/hwmon/nct7802.c     |  5 ++---
>  drivers/hwmon/nct7904.c     |  5 ++---
>  drivers/hwmon/occ/p8_i2c.c  |  5 ++---
>  drivers/hwmon/pcf8591.c     |  5 ++---
>  drivers/hwmon/powr1220.c    |  5 ++---
>  drivers/hwmon/sht21.c       |  5 ++---
>  drivers/hwmon/sht3x.c       |  9 +++++----
>  drivers/hwmon/shtc1.c       |  9 +++++----
>  drivers/hwmon/smm665.c      |  9 +++++----
>  drivers/hwmon/smsc47m192.c  |  5 ++---
>  drivers/hwmon/stts751.c     |  5 ++---
>  drivers/hwmon/tc654.c       |  5 ++---
>  drivers/hwmon/tc74.c        |  5 ++---
>  drivers/hwmon/thmc50.c      |  9 +++++----
>  drivers/hwmon/tmp102.c      |  5 ++---
>  drivers/hwmon/tmp103.c      |  5 ++---
>  drivers/hwmon/tmp108.c      |  5 ++---
>  drivers/hwmon/tmp401.c      |  7 +++----
>  drivers/hwmon/tmp421.c      |  7 +++----
>  drivers/hwmon/w83773g.c     |  5 ++---
>  drivers/hwmon/w83781d.c     |  9 +++++----
>  drivers/hwmon/w83792d.c     |  7 +++----
>  drivers/hwmon/w83l785ts.c   |  8 +++-----
>  drivers/hwmon/w83l786ng.c   |  4 ++--
>  87 files changed, 250 insertions(+), 285 deletions(-)
> 
> diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
> index a529f2efc790..6a765755d061 100644
> --- a/drivers/hwmon/ad7414.c
> +++ b/drivers/hwmon/ad7414.c
> @@ -169,8 +169,7 @@ static struct attribute *ad7414_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(ad7414);
>  
> -static int ad7414_probe(struct i2c_client *client,
> -			const struct i2c_device_id *dev_id)
> +static int ad7414_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct ad7414_data *data;
> @@ -222,7 +221,7 @@ static struct i2c_driver ad7414_driver = {
>  		.name	= "ad7414",
>  		.of_match_table = of_match_ptr(ad7414_of_match),
>  	},
> -	.probe	= ad7414_probe,
> +	.probe_new = ad7414_probe,
>  	.id_table = ad7414_id,
>  };
>  
> diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
> index 74542b8ad8ef..d618f6b2f382 100644
> --- a/drivers/hwmon/ad7418.c
> +++ b/drivers/hwmon/ad7418.c
> @@ -230,8 +230,9 @@ static void ad7418_init_client(struct i2c_client *client)
>  	}
>  }
>  
> -static int ad7418_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static const struct i2c_device_id ad7418_id[];
> +
> +static int ad7418_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct i2c_adapter *adapter = client->adapter;
> @@ -254,7 +255,7 @@ static int ad7418_probe(struct i2c_client *client,
>  	if (dev->of_node)
>  		data->type = (enum chips)of_device_get_match_data(dev);
>  	else
> -		data->type = id->driver_data;
> +		data->type = i2c_match_id(ad7418_id, client)->driver_data;
>  
>  	switch (data->type) {
>  	case ad7416:
> @@ -305,7 +306,7 @@ static struct i2c_driver ad7418_driver = {
>  		.name	= "ad7418",
>  		.of_match_table = ad7418_dt_ids,
>  	},
> -	.probe		= ad7418_probe,
> +	.probe_new	= ad7418_probe,
>  	.id_table	= ad7418_id,
>  };
>  
> diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
> index c45046241a1c..71deb2cd20f5 100644
> --- a/drivers/hwmon/adm1021.c
> +++ b/drivers/hwmon/adm1021.c
> @@ -425,8 +425,9 @@ static void adm1021_init_client(struct i2c_client *client)
>  	i2c_smbus_write_byte_data(client, ADM1021_REG_CONV_RATE_W, 0x04);
>  }
>  
> -static int adm1021_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static const struct i2c_device_id adm1021_id[];
> +
> +static int adm1021_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct adm1021_data *data;
> @@ -437,7 +438,7 @@ static int adm1021_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data->client = client;
> -	data->type = id->driver_data;
> +	data->type = i2c_match_id(adm1021_id, client)->driver_data;
>  	mutex_init(&data->update_lock);
>  
>  	/* Initialize the ADM1021 chip */
> @@ -472,7 +473,7 @@ static struct i2c_driver adm1021_driver = {
>  	.driver = {
>  		.name	= "adm1021",
>  	},
> -	.probe		= adm1021_probe,
> +	.probe_new	= adm1021_probe,
>  	.id_table	= adm1021_id,
>  	.detect		= adm1021_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
> index ae7b96945185..cc27338446b4 100644
> --- a/drivers/hwmon/adm1025.c
> +++ b/drivers/hwmon/adm1025.c
> @@ -517,8 +517,7 @@ static void adm1025_init_client(struct i2c_client *client)
>  					  (reg&0x7E)|0x01);
>  }
>  
> -static int adm1025_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adm1025_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -560,7 +559,7 @@ static struct i2c_driver adm1025_driver = {
>  	.driver = {
>  		.name	= "adm1025",
>  	},
> -	.probe		= adm1025_probe,
> +	.probe_new	= adm1025_probe,
>  	.id_table	= adm1025_id,
>  	.detect		= adm1025_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
> index e0f630c64152..a48fc56c86d3 100644
> --- a/drivers/hwmon/adm1026.c
> +++ b/drivers/hwmon/adm1026.c
> @@ -1816,8 +1816,7 @@ static void adm1026_init_client(struct i2c_client *client)
>  	}
>  }
>  
> -static int adm1026_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adm1026_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -1860,7 +1859,7 @@ static struct i2c_driver adm1026_driver = {
>  	.driver = {
>  		.name	= "adm1026",
>  	},
> -	.probe		= adm1026_probe,
> +	.probe_new	= adm1026_probe,
>  	.id_table	= adm1026_id,
>  	.detect		= adm1026_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index 7723a338446d..b538ace2d292 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -1022,8 +1022,9 @@ static void adm1031_init_client(struct i2c_client *client)
>  	data->update_interval = update_intervals[i];
>  }
>  
> -static int adm1031_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static const struct i2c_device_id adm1031_id[];
> +
> +static int adm1031_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -1035,7 +1036,7 @@ static int adm1031_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, data);
>  	data->client = client;
> -	data->chip_type = id->driver_data;
> +	data->chip_type = i2c_match_id(adm1031_id, client)->driver_data;
>  	mutex_init(&data->update_lock);
>  
>  	if (data->chip_type == adm1030)
> @@ -1068,7 +1069,7 @@ static struct i2c_driver adm1031_driver = {
>  	.driver = {
>  		.name = "adm1031",
>  	},
> -	.probe		= adm1031_probe,
> +	.probe_new	= adm1031_probe,
>  	.id_table	= adm1031_id,
>  	.detect		= adm1031_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
> index 496d47490e10..16364dee1794 100644
> --- a/drivers/hwmon/adm9240.c
> +++ b/drivers/hwmon/adm9240.c
> @@ -704,8 +704,7 @@ static void adm9240_init_client(struct i2c_client *client)
>  	}
>  }
>  
> -static int adm9240_probe(struct i2c_client *new_client,
> -			 const struct i2c_device_id *id)
> +static int adm9240_probe(struct i2c_client *new_client)
>  {
>  	struct device *dev = &new_client->dev;
>  	struct device *hwmon_dev;
> @@ -741,7 +740,7 @@ static struct i2c_driver adm9240_driver = {
>  	.driver = {
>  		.name	= "adm9240",
>  	},
> -	.probe		= adm9240_probe,
> +	.probe_new	= adm9240_probe,
>  	.id_table	= adm9240_id,
>  	.detect		= adm9240_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 80f8a4673315..9d80895d0266 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -39,8 +39,7 @@ static const struct adt7x10_ops adt7410_i2c_ops = {
>  	.write_byte = adt7410_i2c_write_byte,
>  };
>  
> -static int adt7410_i2c_probe(struct i2c_client *client,
> -	const struct i2c_device_id *id)
> +static int adt7410_i2c_probe(struct i2c_client *client)
>  {
>  	if (!i2c_check_functionality(client->adapter,
>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> @@ -67,7 +66,7 @@ static struct i2c_driver adt7410_driver = {
>  		.name	= "adt7410",
>  		.pm	= ADT7X10_DEV_PM_OPS,
>  	},
> -	.probe		= adt7410_i2c_probe,
> +	.probe_new	= adt7410_i2c_probe,
>  	.remove		= adt7410_i2c_remove,
>  	.id_table	= adt7410_ids,
>  	.address_list	= I2C_ADDRS(0x48, 0x49, 0x4a, 0x4b),
> diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
> index 5a839cc2ed1c..fad74aa62b64 100644
> --- a/drivers/hwmon/adt7411.c
> +++ b/drivers/hwmon/adt7411.c
> @@ -666,8 +666,7 @@ static const struct hwmon_chip_info adt7411_chip_info = {
>  	.info = adt7411_info,
>  };
>  
> -static int adt7411_probe(struct i2c_client *client,
> -				   const struct i2c_device_id *id)
> +static int adt7411_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct adt7411_data *data;
> @@ -707,7 +706,7 @@ static struct i2c_driver adt7411_driver = {
>  	.driver		= {
>  		.name		= "adt7411",
>  	},
> -	.probe  = adt7411_probe,
> +	.probe_new = adt7411_probe,
>  	.id_table = adt7411_id,
>  	.detect = adt7411_detect,
>  	.address_list = normal_i2c,
> diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
> index 319a0519ebdb..5dcc501b13cc 100644
> --- a/drivers/hwmon/adt7462.c
> +++ b/drivers/hwmon/adt7462.c
> @@ -1787,8 +1787,7 @@ static int adt7462_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int adt7462_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adt7462_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct adt7462_data *data;
> @@ -1820,7 +1819,7 @@ static struct i2c_driver adt7462_driver = {
>  	.driver = {
>  		.name	= "adt7462",
>  	},
> -	.probe		= adt7462_probe,
> +	.probe_new	= adt7462_probe,
>  	.id_table	= adt7462_id,
>  	.detect		= adt7462_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index a30f34cf512c..740f39a54ab0 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -1217,8 +1217,7 @@ static void adt7470_init_client(struct i2c_client *client)
>  	}
>  }
>  
> -static int adt7470_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adt7470_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct adt7470_data *data;
> @@ -1276,7 +1275,7 @@ static struct i2c_driver adt7470_driver = {
>  	.driver = {
>  		.name	= "adt7470",
>  	},
> -	.probe		= adt7470_probe,
> +	.probe_new	= adt7470_probe,
>  	.remove		= adt7470_remove,
>  	.id_table	= adt7470_id,
>  	.detect		= adt7470_detect,
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 054080443b47..9d5b019651f2 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1539,8 +1539,7 @@ static int adt7475_set_pwm_polarity(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static int adt7475_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adt7475_probe(struct i2c_client *client)
>  {
>  	enum chips chip;
>  	static const char * const names[] = {
> @@ -1554,6 +1553,7 @@ static int adt7475_probe(struct i2c_client *client,
>  	struct device *hwmon_dev;
>  	int i, ret = 0, revision, group_num = 0;
>  	u8 config3;
> +	const struct i2c_device_id *id = i2c_match_id(adt7475_id, client);
>  
>  	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
>  	if (data == NULL)
> @@ -1728,7 +1728,7 @@ static struct i2c_driver adt7475_driver = {
>  		.name	= "adt7475",
>  		.of_match_table = of_match_ptr(adt7475_of_match),
>  	},
> -	.probe		= adt7475_probe,
> +	.probe_new	= adt7475_probe,
>  	.id_table	= adt7475_id,
>  	.detect		= adt7475_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 013fb056b1d0..6b1ce2242c61 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -900,8 +900,7 @@ static int amc6821_init_client(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static int amc6821_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int amc6821_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct amc6821_data *data;
> @@ -940,7 +939,7 @@ static struct i2c_driver amc6821_driver = {
>  	.driver = {
>  		.name	= "amc6821",
>  	},
> -	.probe = amc6821_probe,
> +	.probe_new = amc6821_probe,
>  	.id_table = amc6821_id,
>  	.detect = amc6821_detect,
>  	.address_list = normal_i2c,
> diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
> index 4c609e23a4ef..ba9fcf6f9264 100644
> --- a/drivers/hwmon/asb100.c
> +++ b/drivers/hwmon/asb100.c
> @@ -205,8 +205,7 @@ struct asb100_data {
>  static int asb100_read_value(struct i2c_client *client, u16 reg);
>  static void asb100_write_value(struct i2c_client *client, u16 reg, u16 val);
>  
> -static int asb100_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id);
> +static int asb100_probe(struct i2c_client *client);
>  static int asb100_detect(struct i2c_client *client,
>  			 struct i2c_board_info *info);
>  static int asb100_remove(struct i2c_client *client);
> @@ -224,7 +223,7 @@ static struct i2c_driver asb100_driver = {
>  	.driver = {
>  		.name	= "asb100",
>  	},
> -	.probe		= asb100_probe,
> +	.probe_new	= asb100_probe,
>  	.remove		= asb100_remove,
>  	.id_table	= asb100_id,
>  	.detect		= asb100_detect,
> @@ -775,8 +774,7 @@ static int asb100_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int asb100_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int asb100_probe(struct i2c_client *client)
>  {
>  	int err;
>  	struct asb100_data *data;
> diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
> index 79b8df258371..1e08a5431f12 100644
> --- a/drivers/hwmon/atxp1.c
> +++ b/drivers/hwmon/atxp1.c
> @@ -244,8 +244,7 @@ static struct attribute *atxp1_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(atxp1);
>  
> -static int atxp1_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id)
> +static int atxp1_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct atxp1_data *data;
> @@ -288,7 +287,7 @@ static struct i2c_driver atxp1_driver = {
>  	.driver = {
>  		.name	= "atxp1",
>  	},
> -	.probe		= atxp1_probe,
> +	.probe_new	= atxp1_probe,
>  	.id_table	= atxp1_id,
>  };
>  
> diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
> index 541bed8732b7..e1d742bfc74c 100644
> --- a/drivers/hwmon/ds1621.c
> +++ b/drivers/hwmon/ds1621.c
> @@ -342,8 +342,9 @@ static const struct attribute_group ds1621_group = {
>  };
>  __ATTRIBUTE_GROUPS(ds1621);
>  
> -static int ds1621_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static const struct i2c_device_id ds1621_id[];
> +
> +static int ds1621_probe(struct i2c_client *client)
>  {
>  	struct ds1621_data *data;
>  	struct device *hwmon_dev;
> @@ -355,7 +356,7 @@ static int ds1621_probe(struct i2c_client *client,
>  
>  	mutex_init(&data->update_lock);
>  
> -	data->kind = id->driver_data;
> +	data->kind = i2c_match_id(ds1621_id, client)->driver_data;
>  	data->client = client;
>  
>  	/* Initialize the DS1621 chip */
> @@ -383,7 +384,7 @@ static struct i2c_driver ds1621_driver = {
>  	.driver = {
>  		.name	= "ds1621",
>  	},
> -	.probe		= ds1621_probe,
> +	.probe_new	= ds1621_probe,
>  	.id_table	= ds1621_id,
>  };
>  
> diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
> index 8f1fc83ac37b..9ec722798c4a 100644
> --- a/drivers/hwmon/ds620.c
> +++ b/drivers/hwmon/ds620.c
> @@ -211,8 +211,7 @@ static struct attribute *ds620_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(ds620);
>  
> -static int ds620_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id)
> +static int ds620_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -246,7 +245,7 @@ static struct i2c_driver ds620_driver = {
>  	.driver = {
>  		   .name = "ds620",
>  	},
> -	.probe = ds620_probe,
> +	.probe_new = ds620_probe,
>  	.id_table = ds620_id,
>  };
>  
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index cf0962f7a020..f68d77beb932 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -386,11 +386,13 @@ static const struct regmap_config emc1403_regmap_config = {
>  	.volatile_reg = emc1403_regmap_is_volatile,
>  };
>  
> -static int emc1403_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static const struct i2c_device_id emc1403_idtable[];
> +
> +static int emc1403_probe(struct i2c_client *client)
>  {
>  	struct thermal_data *data;
>  	struct device *hwmon_dev;
> +	const struct i2c_device_id *id = i2c_match_id(emc1403_idtable, client);
>  
>  	data = devm_kzalloc(&client->dev, sizeof(struct thermal_data),
>  			    GFP_KERNEL);
> @@ -452,7 +454,7 @@ static struct i2c_driver sensor_emc1403 = {
>  		.name = "emc1403",
>  	},
>  	.detect = emc1403_detect,
> -	.probe = emc1403_probe,
> +	.probe_new = emc1403_probe,
>  	.id_table = emc1403_idtable,
>  	.address_list = emc1403_address_list,
>  };
> diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
> index df0f7292e214..ec5c98702bf5 100644
> --- a/drivers/hwmon/emc6w201.c
> +++ b/drivers/hwmon/emc6w201.c
> @@ -444,8 +444,7 @@ static int emc6w201_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int emc6w201_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int emc6w201_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct emc6w201_data *data;
> @@ -475,7 +474,7 @@ static struct i2c_driver emc6w201_driver = {
>  	.driver = {
>  		.name	= "emc6w201",
>  	},
> -	.probe		= emc6w201_probe,
> +	.probe_new	= emc6w201_probe,
>  	.id_table	= emc6w201_id,
>  	.detect		= emc6w201_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
> index 4136643d8e0c..5191cd85a8d1 100644
> --- a/drivers/hwmon/fschmd.c
> +++ b/drivers/hwmon/fschmd.c
> @@ -214,8 +214,7 @@ static const int FSCHMD_NO_TEMP_SENSORS[7] = { 3, 3, 4, 3, 5, 5, 11 };
>   * Functions declarations
>   */
>  
> -static int fschmd_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id);
> +static int fschmd_probe(struct i2c_client *client);
>  static int fschmd_detect(struct i2c_client *client,
>  			 struct i2c_board_info *info);
>  static int fschmd_remove(struct i2c_client *client);
> @@ -242,7 +241,7 @@ static struct i2c_driver fschmd_driver = {
>  	.driver = {
>  		.name	= "fschmd",
>  	},
> -	.probe		= fschmd_probe,
> +	.probe_new	= fschmd_probe,
>  	.remove		= fschmd_remove,
>  	.id_table	= fschmd_id,
>  	.detect		= fschmd_detect,
> @@ -1081,15 +1080,14 @@ static int fschmd_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int fschmd_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int fschmd_probe(struct i2c_client *client)
>  {
>  	struct fschmd_data *data;
>  	const char * const names[7] = { "Poseidon", "Hermes", "Scylla",
>  				"Heracles", "Heimdall", "Hades", "Syleus" };
>  	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
>  	int i, err;
> -	enum chips kind = id->driver_data;
> +	enum chips kind = i2c_match_id(fschmd_id, client)->driver_data;
>  
>  	data = kzalloc(sizeof(struct fschmd_data), GFP_KERNEL);
>  	if (!data)
> diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
> index 371ce7745f5e..ef88a156efc2 100644
> --- a/drivers/hwmon/ftsteutates.c
> +++ b/drivers/hwmon/ftsteutates.c
> @@ -752,7 +752,7 @@ static int fts_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static int fts_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static int fts_probe(struct i2c_client *client)
>  {
>  	u8 revision;
>  	struct fts_data *data;
> @@ -819,7 +819,7 @@ static struct i2c_driver fts_driver = {
>  		.name = "ftsteutates",
>  	},
>  	.id_table = fts_id,
> -	.probe = fts_probe,
> +	.probe_new = fts_probe,
>  	.remove = fts_remove,
>  	.detect = fts_detect,
>  	.address_list = normal_i2c,
> diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
> index 31beedcb420f..a692f7b2f6f7 100644
> --- a/drivers/hwmon/g760a.c
> +++ b/drivers/hwmon/g760a.c
> @@ -170,8 +170,7 @@ ATTRIBUTE_GROUPS(g760a);
>   * new-style driver model code
>   */
>  
> -static int g760a_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int g760a_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct g760a_data *data;
> @@ -207,7 +206,7 @@ static struct i2c_driver g760a_driver = {
>  	.driver = {
>  		.name	= "g760a",
>  	},
> -	.probe	  = g760a_probe,
> +	.probe_new = g760a_probe,
>  	.id_table = g760a_id,
>  };
>  
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> index 5f0f34631580..64a0599b2da5 100644
> --- a/drivers/hwmon/g762.c
> +++ b/drivers/hwmon/g762.c
> @@ -1033,7 +1033,7 @@ static inline int g762_fan_init(struct device *dev)
>  					 data->fan_cmd1);
>  }
>  
> -static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static int g762_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -1079,7 +1079,7 @@ static struct i2c_driver g762_driver = {
>  		.name = DRVNAME,
>  		.of_match_table = of_match_ptr(g762_dt_match),
>  	},
> -	.probe	  = g762_probe,
> +	.probe_new = g762_probe,
>  	.id_table = g762_id,
>  };
>  
> diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
> index 4964beeea542..7aaee5a48243 100644
> --- a/drivers/hwmon/gl518sm.c
> +++ b/drivers/hwmon/gl518sm.c
> @@ -611,8 +611,7 @@ static void gl518_init_client(struct i2c_client *client)
>  	gl518_write_value(client, GL518_REG_CONF, 0x40 | regvalue);
>  }
>  
> -static int gl518_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id)
> +static int gl518_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -653,7 +652,7 @@ static struct i2c_driver gl518_driver = {
>  	.driver = {
>  		.name	= "gl518sm",
>  	},
> -	.probe		= gl518_probe,
> +	.probe_new	= gl518_probe,
>  	.id_table	= gl518_id,
>  	.detect		= gl518_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
> index 4689e01cb56d..4ae1295cc3ea 100644
> --- a/drivers/hwmon/gl520sm.c
> +++ b/drivers/hwmon/gl520sm.c
> @@ -854,8 +854,7 @@ static void gl520_init_client(struct i2c_client *client)
>  	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
>  }
>  
> -static int gl520_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id)
> +static int gl520_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -896,7 +895,7 @@ static struct i2c_driver gl520_driver = {
>  	.driver = {
>  		.name	= "gl520sm",
>  	},
> -	.probe		= gl520_probe,
> +	.probe_new	= gl520_probe,
>  	.id_table	= gl520_id,
>  	.detect		= gl520_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
> index 018df6074f7b..d9394e19fea8 100644
> --- a/drivers/hwmon/hih6130.c
> +++ b/drivers/hwmon/hih6130.c
> @@ -204,8 +204,7 @@ static struct attribute *hih6130_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(hih6130);
>  
> -static int hih6130_probe(struct i2c_client *client,
> -				   const struct i2c_device_id *id)
> +static int hih6130_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct hih6130 *hih6130;
> @@ -250,7 +249,7 @@ static struct i2c_driver hih6130_driver = {
>  		.name = "hih6130",
>  		.of_match_table = of_match_ptr(hih6130_of_match),
>  	},
> -	.probe       = hih6130_probe,
> +	.probe_new   = hih6130_probe,
>  	.id_table    = hih6130_id,
>  };
>  
> diff --git a/drivers/hwmon/ina209.c b/drivers/hwmon/ina209.c
> index 70ad1efcb3de..69d6fc818a24 100644
> --- a/drivers/hwmon/ina209.c
> +++ b/drivers/hwmon/ina209.c
> @@ -531,8 +531,7 @@ static int ina209_init_client(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int ina209_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int ina209_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct ina209_data *data;
> @@ -597,7 +596,7 @@ static struct i2c_driver ina209_driver = {
>  		.name	= "ina209",
>  		.of_match_table = of_match_ptr(ina209_of_match),
>  	},
> -	.probe		= ina209_probe,
> +	.probe_new	= ina209_probe,
>  	.remove		= ina209_remove,
>  	.id_table	= ina209_id,
>  };
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 55d474ec7c35..9b0105d1751f 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -614,8 +614,9 @@ static const struct attribute_group ina226_group = {
>  	.attrs = ina226_attrs,
>  };
>  
> -static int ina2xx_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static const struct i2c_device_id ina2xx_id[];
> +
> +static int ina2xx_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct ina2xx_data *data;
> @@ -627,7 +628,7 @@ static int ina2xx_probe(struct i2c_client *client,
>  	if (client->dev.of_node)
>  		chip = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
>  	else
> -		chip = id->driver_data;
> +		chip = i2c_match_id(ina2xx_id, client)->driver_data;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -717,7 +718,7 @@ static struct i2c_driver ina2xx_driver = {
>  		.name	= "ina2xx",
>  		.of_match_table = of_match_ptr(ina2xx_of_match),
>  	},
> -	.probe		= ina2xx_probe,
> +	.probe_new	= ina2xx_probe,
>  	.id_table	= ina2xx_id,
>  };
>  
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index f335d0cb0c77..a62a38883fb9 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -822,8 +822,7 @@ static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
>  	return 0;
>  }
>  
> -static int ina3221_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ina3221_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct ina3221_data *ina;
> @@ -1016,7 +1015,7 @@ static const struct i2c_device_id ina3221_ids[] = {
>  MODULE_DEVICE_TABLE(i2c, ina3221_ids);
>  
>  static struct i2c_driver ina3221_i2c_driver = {
> -	.probe = ina3221_probe,
> +	.probe_new = ina3221_probe,
>  	.remove = ina3221_remove,
>  	.driver = {
>  		.name = INA3221_DRIVER_NAME,
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index e3f1ebee7130..4a03d010ec5a 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -458,7 +458,7 @@ static const struct hwmon_chip_info jc42_chip_info = {
>  	.info = jc42_info,
>  };
>  
> -static int jc42_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static int jc42_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -581,7 +581,7 @@ static struct i2c_driver jc42_driver = {
>  		.pm = JC42_DEV_PM_OPS,
>  		.of_match_table = of_match_ptr(jc42_of_ids),
>  	},
> -	.probe		= jc42_probe,
> +	.probe_new	= jc42_probe,
>  	.remove		= jc42_remove,
>  	.id_table	= jc42_id,
>  	.detect		= jc42_detect,
> diff --git a/drivers/hwmon/lineage-pem.c b/drivers/hwmon/lineage-pem.c
> index ce5b0598524c..c83eb2fd80eb 100644
> --- a/drivers/hwmon/lineage-pem.c
> +++ b/drivers/hwmon/lineage-pem.c
> @@ -417,8 +417,7 @@ static const struct attribute_group pem_fan_group = {
>  	.attrs = pem_fan_attributes,
>  };
>  
> -static int pem_probe(struct i2c_client *client,
> -		     const struct i2c_device_id *id)
> +static int pem_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct device *dev = &client->dev;
> @@ -512,7 +511,7 @@ static struct i2c_driver pem_driver = {
>  	.driver = {
>  		   .name = "lineage_pem",
>  		   },
> -	.probe = pem_probe,
> +	.probe_new = pem_probe,
>  	.id_table = pem_id,
>  };
>  
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index 60a817f58db9..50f67265c71d 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -1087,8 +1087,9 @@ static void lm63_init_client(struct lm63_data *data)
>  		(data->config_fan & 0x20) ? "manual" : "auto");
>  }
>  
> -static int lm63_probe(struct i2c_client *client,
> -		      const struct i2c_device_id *id)
> +static const struct i2c_device_id lm63_id[];
> +
> +static int lm63_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -1106,7 +1107,7 @@ static int lm63_probe(struct i2c_client *client,
>  	if (client->dev.of_node)
>  		data->kind = (enum chips)of_device_get_match_data(&client->dev);
>  	else
> -		data->kind = id->driver_data;
> +		data->kind = i2c_match_id(lm63_id, client)->driver_data;
>  	if (data->kind == lm64)
>  		data->temp2_offset = 16000;
>  
> @@ -1163,7 +1164,7 @@ static struct i2c_driver lm63_driver = {
>  		.name	= "lm63",
>  		.of_match_table = of_match_ptr(lm63_of_match),
>  	},
> -	.probe		= lm63_probe,
> +	.probe_new	= lm63_probe,
>  	.id_table	= lm63_id,
>  	.detect		= lm63_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ba0be48aeadd..e22f977942b4 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -542,8 +542,9 @@ static void lm75_remove(void *data)
>  	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
>  }
>  
> -static int
> -lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static const struct i2c_device_id lm75_ids[];
> +
> +static int lm75_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -554,7 +555,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if (client->dev.of_node)
>  		kind = (enum lm75_type)of_device_get_match_data(&client->dev);
>  	else
> -		kind = id->driver_data;
> +		kind = i2c_match_id(lm75_ids, client)->driver_data;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> @@ -893,7 +894,7 @@ static struct i2c_driver lm75_driver = {
>  		.of_match_table = of_match_ptr(lm75_of_match),
>  		.pm	= LM75_DEV_PM_OPS,
>  	},
> -	.probe		= lm75_probe,
> +	.probe_new	= lm75_probe,
>  	.id_table	= lm75_ids,
>  	.detect		= lm75_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
> index 671a962fde29..7570c9d50ddc 100644
> --- a/drivers/hwmon/lm77.c
> +++ b/drivers/hwmon/lm77.c
> @@ -315,7 +315,7 @@ static void lm77_init_client(struct i2c_client *client)
>  		lm77_write_value(client, LM77_REG_CONF, conf & 0xfe);
>  }
>  
> -static int lm77_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static int lm77_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -348,7 +348,7 @@ static struct i2c_driver lm77_driver = {
>  	.driver = {
>  		.name	= "lm77",
>  	},
> -	.probe		= lm77_probe,
> +	.probe_new	= lm77_probe,
>  	.id_table	= lm77_id,
>  	.detect		= lm77_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
> index 2119461ec43a..1aa35ca0c6fe 100644
> --- a/drivers/hwmon/lm78.c
> +++ b/drivers/hwmon/lm78.c
> @@ -627,8 +627,9 @@ static int lm78_i2c_detect(struct i2c_client *client,
>  	return -ENODEV;
>  }
>  
> -static int lm78_i2c_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static const struct i2c_device_id lm78_i2c_id[];
> +
> +static int lm78_i2c_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -639,7 +640,7 @@ static int lm78_i2c_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data->client = client;
> -	data->type = id->driver_data;
> +	data->type = i2c_match_id(lm78_i2c_id, client)->driver_data;
>  
>  	/* Initialize the LM78 chip */
>  	lm78_init_device(data);
> @@ -661,7 +662,7 @@ static struct i2c_driver lm78_driver = {
>  	.driver = {
>  		.name	= "lm78",
>  	},
> -	.probe		= lm78_i2c_probe,
> +	.probe_new	= lm78_i2c_probe,
>  	.id_table	= lm78_i2c_id,
>  	.detect		= lm78_i2c_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index 80520cef7617..ac4adb44b224 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -591,8 +591,7 @@ static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	return 0;
>  }
>  
> -static int lm80_probe(struct i2c_client *client,
> -		      const struct i2c_device_id *id)
> +static int lm80_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -641,7 +640,7 @@ static struct i2c_driver lm80_driver = {
>  	.driver = {
>  		.name	= "lm80",
>  	},
> -	.probe		= lm80_probe,
> +	.probe_new	= lm80_probe,
>  	.id_table	= lm80_id,
>  	.detect		= lm80_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
> index 8fefca9bbbb7..2ff5ecce608e 100644
> --- a/drivers/hwmon/lm83.c
> +++ b/drivers/hwmon/lm83.c
> @@ -317,8 +317,9 @@ static int lm83_detect(struct i2c_client *new_client,
>  	return 0;
>  }
>  
> -static int lm83_probe(struct i2c_client *new_client,
> -		      const struct i2c_device_id *id)
> +static const struct i2c_device_id lm83_id[];
> +
> +static int lm83_probe(struct i2c_client *new_client)
>  {
>  	struct device *hwmon_dev;
>  	struct lm83_data *data;
> @@ -338,7 +339,7 @@ static int lm83_probe(struct i2c_client *new_client,
>  	 * declare 1 and 3 common, and then 2 and 4 only for the LM83.
>  	 */
>  	data->groups[0] = &lm83_group;
> -	if (id->driver_data == lm83)
> +	if (i2c_match_id(lm83_id, new_client)->driver_data == lm83)
>  		data->groups[1] = &lm83_group_opt;
>  
>  	hwmon_dev = devm_hwmon_device_register_with_groups(&new_client->dev,
> @@ -363,7 +364,7 @@ static struct i2c_driver lm83_driver = {
>  	.driver = {
>  		.name	= "lm83",
>  	},
> -	.probe		= lm83_probe,
> +	.probe_new	= lm83_probe,
>  	.id_table	= lm83_id,
>  	.detect		= lm83_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index cff0aa505a78..c7bf5de7b70f 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -1544,7 +1544,9 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	return 0;
>  }
>  
> -static int lm85_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static const struct i2c_device_id lm85_id[];
> +
> +static int lm85_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -1559,7 +1561,7 @@ static int lm85_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if (client->dev.of_node)
>  		data->type = (enum chips)of_device_get_match_data(&client->dev);
>  	else
> -		data->type = id->driver_data;
> +		data->type = i2c_match_id(lm85_id, client)->driver_data;
>  	mutex_init(&data->update_lock);
>  
>  	/* Fill in the chip specific driver values */
> @@ -1696,7 +1698,7 @@ static struct i2c_driver lm85_driver = {
>  		.name   = "lm85",
>  		.of_match_table = of_match_ptr(lm85_of_match),
>  	},
> -	.probe		= lm85_probe,
> +	.probe_new	= lm85_probe,
>  	.id_table	= lm85_id,
>  	.detect		= lm85_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 7bdc664af55b..ebbfd5f352c0 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -1779,8 +1779,7 @@ static const struct hwmon_ops lm90_ops = {
>  	.write = lm90_write,
>  };
>  
> -static int lm90_probe(struct i2c_client *client,
> -		      const struct i2c_device_id *id)
> +static int lm90_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct i2c_adapter *adapter = client->adapter;
> @@ -1816,7 +1815,7 @@ static int lm90_probe(struct i2c_client *client,
>  	if (client->dev.of_node)
>  		data->kind = (enum chips)of_device_get_match_data(&client->dev);
>  	else
> -		data->kind = id->driver_data;
> +		data->kind = i2c_match_id(lm90_id, client)->driver_data;
>  	if (data->kind == adm1032) {
>  		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>  			client->flags &= ~I2C_CLIENT_PEC;
> @@ -1952,7 +1951,7 @@ static struct i2c_driver lm90_driver = {
>  		.name	= "lm90",
>  		.of_match_table = of_match_ptr(lm90_of_match),
>  	},
> -	.probe		= lm90_probe,
> +	.probe_new	= lm90_probe,
>  	.alert		= lm90_alert,
>  	.id_table	= lm90_id,
>  	.detect		= lm90_detect,
> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
> index 84347db5edf3..9bf278cf0bd0 100644
> --- a/drivers/hwmon/lm92.c
> +++ b/drivers/hwmon/lm92.c
> @@ -292,8 +292,7 @@ static int lm92_detect(struct i2c_client *new_client,
>  	return 0;
>  }
>  
> -static int lm92_probe(struct i2c_client *new_client,
> -		      const struct i2c_device_id *id)
> +static int lm92_probe(struct i2c_client *new_client)
>  {
>  	struct device *hwmon_dev;
>  	struct lm92_data *data;
> @@ -331,7 +330,7 @@ static struct i2c_driver lm92_driver = {
>  	.driver = {
>  		.name	= "lm92",
>  	},
> -	.probe		= lm92_probe,
> +	.probe_new	= lm92_probe,
>  	.id_table	= lm92_id,
>  	.detect		= lm92_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> index cea8ea323271..78d6dfaf145b 100644
> --- a/drivers/hwmon/lm93.c
> +++ b/drivers/hwmon/lm93.c
> @@ -2583,8 +2583,7 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	return 0;
>  }
>  
> -static int lm93_probe(struct i2c_client *client,
> -		      const struct i2c_device_id *id)
> +static int lm93_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct lm93_data *data;
> @@ -2636,7 +2635,7 @@ static struct i2c_driver lm93_driver = {
>  	.driver = {
>  		.name	= "lm93",
>  	},
> -	.probe		= lm93_probe,
> +	.probe_new	= lm93_probe,
>  	.id_table	= lm93_id,
>  	.detect		= lm93_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
> index 8a2a2a490496..ac169a994ae0 100644
> --- a/drivers/hwmon/lm95234.c
> +++ b/drivers/hwmon/lm95234.c
> @@ -677,8 +677,9 @@ static int lm95234_init_client(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static int lm95234_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static const struct i2c_device_id lm95234_id[];
> +
> +static int lm95234_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct lm95234_data *data;
> @@ -698,7 +699,7 @@ static int lm95234_probe(struct i2c_client *client,
>  		return err;
>  
>  	data->groups[0] = &lm95234_common_group;
> -	if (id->driver_data == lm95234)
> +	if (i2c_match_id(lm95234_id, client)->driver_data == lm95234)
>  		data->groups[1] = &lm95234_group;
>  
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> @@ -719,7 +720,7 @@ static struct i2c_driver lm95234_driver = {
>  	.driver = {
>  		.name	= DRVNAME,
>  	},
> -	.probe		= lm95234_probe,
> +	.probe_new	= lm95234_probe,
>  	.id_table	= lm95234_id,
>  	.detect		= lm95234_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> index 8d66d6e3c0fc..00dbc170c8c6 100644
> --- a/drivers/hwmon/lm95241.c
> +++ b/drivers/hwmon/lm95241.c
> @@ -432,8 +432,7 @@ static const struct hwmon_chip_info lm95241_chip_info = {
>  	.info = lm95241_info,
>  };
>  
> -static int lm95241_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int lm95241_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct lm95241_data *data;
> @@ -469,7 +468,7 @@ static struct i2c_driver lm95241_driver = {
>  	.driver = {
>  		.name	= DEVNAME,
>  	},
> -	.probe		= lm95241_probe,
> +	.probe_new	= lm95241_probe,
>  	.id_table	= lm95241_id,
>  	.detect		= lm95241_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
> index 057614e664e1..29388fcf5f74 100644
> --- a/drivers/hwmon/lm95245.c
> +++ b/drivers/hwmon/lm95245.c
> @@ -547,8 +547,7 @@ static const struct hwmon_chip_info lm95245_chip_info = {
>  	.info = lm95245_info,
>  };
>  
> -static int lm95245_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int lm95245_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct lm95245_data *data;
> @@ -598,7 +597,7 @@ static struct i2c_driver lm95245_driver = {
>  		.name	= "lm95245",
>  		.of_match_table = of_match_ptr(lm95245_of_match),
>  	},
> -	.probe		= lm95245_probe,
> +	.probe_new	= lm95245_probe,
>  	.id_table	= lm95245_id,
>  	.detect		= lm95245_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 2818276ed3d6..ba9c868a8641 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -445,8 +445,7 @@ static const struct regmap_config ltc2945_regmap_config = {
>  	.max_register = LTC2945_MIN_ADIN_THRES_L,
>  };
>  
> -static int ltc2945_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ltc2945_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -478,7 +477,7 @@ static struct i2c_driver ltc2945_driver = {
>  	.driver = {
>  		   .name = "ltc2945",
>  		   },
> -	.probe = ltc2945_probe,
> +	.probe_new = ltc2945_probe,
>  	.id_table = ltc2945_id,
>  };
>  
> diff --git a/drivers/hwmon/ltc2990.c b/drivers/hwmon/ltc2990.c
> index 53ff5051774c..78b191b26bb2 100644
> --- a/drivers/hwmon/ltc2990.c
> +++ b/drivers/hwmon/ltc2990.c
> @@ -200,8 +200,7 @@ static const struct attribute_group ltc2990_group = {
>  };
>  __ATTRIBUTE_GROUPS(ltc2990);
>  
> -static int ltc2990_i2c_probe(struct i2c_client *i2c,
> -			     const struct i2c_device_id *id)
> +static int ltc2990_i2c_probe(struct i2c_client *i2c)
>  {
>  	int ret;
>  	struct device *hwmon_dev;
> @@ -269,7 +268,7 @@ static struct i2c_driver ltc2990_i2c_driver = {
>  	.driver = {
>  		.name = "ltc2990",
>  	},
> -	.probe    = ltc2990_i2c_probe,
> +	.probe_new = ltc2990_i2c_probe,
>  	.id_table = ltc2990_i2c_id,
>  };
>  
> diff --git a/drivers/hwmon/ltc4151.c b/drivers/hwmon/ltc4151.c
> index 67a529b7ba18..321f54e237bd 100644
> --- a/drivers/hwmon/ltc4151.c
> +++ b/drivers/hwmon/ltc4151.c
> @@ -154,8 +154,7 @@ static struct attribute *ltc4151_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ltc4151);
>  
> -static int ltc4151_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ltc4151_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct device *dev = &client->dev;
> @@ -206,7 +205,7 @@ static struct i2c_driver ltc4151_driver = {
>  		.name	= "ltc4151",
>  		.of_match_table = of_match_ptr(ltc4151_match),
>  	},
> -	.probe		= ltc4151_probe,
> +	.probe_new	= ltc4151_probe,
>  	.id_table	= ltc4151_id,
>  };
>  
> diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
> index f783ac19675e..7cef3cb2962b 100644
> --- a/drivers/hwmon/ltc4215.c
> +++ b/drivers/hwmon/ltc4215.c
> @@ -218,8 +218,7 @@ static struct attribute *ltc4215_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ltc4215);
>  
> -static int ltc4215_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ltc4215_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct device *dev = &client->dev;
> @@ -256,7 +255,7 @@ static struct i2c_driver ltc4215_driver = {
>  	.driver = {
>  		.name	= "ltc4215",
>  	},
> -	.probe		= ltc4215_probe,
> +	.probe_new	= ltc4215_probe,
>  	.id_table	= ltc4215_id,
>  };
>  
> diff --git a/drivers/hwmon/ltc4222.c b/drivers/hwmon/ltc4222.c
> index d15485e93fb8..3efce6d1cb88 100644
> --- a/drivers/hwmon/ltc4222.c
> +++ b/drivers/hwmon/ltc4222.c
> @@ -177,8 +177,7 @@ static const struct regmap_config ltc4222_regmap_config = {
>  	.max_register = LTC4222_ADC_CONTROL,
>  };
>  
> -static int ltc4222_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ltc4222_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -211,7 +210,7 @@ static struct i2c_driver ltc4222_driver = {
>  	.driver = {
>  		   .name = "ltc4222",
>  		   },
> -	.probe = ltc4222_probe,
> +	.probe_new = ltc4222_probe,
>  	.id_table = ltc4222_id,
>  };
>  
> diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
> index 244a83d675cd..5088d28b3a7c 100644
> --- a/drivers/hwmon/ltc4245.c
> +++ b/drivers/hwmon/ltc4245.c
> @@ -440,8 +440,7 @@ static bool ltc4245_use_extra_gpios(struct i2c_client *client)
>  	return false;
>  }
>  
> -static int ltc4245_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ltc4245_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct ltc4245_data *data;
> @@ -480,7 +479,7 @@ static struct i2c_driver ltc4245_driver = {
>  	.driver = {
>  		.name	= "ltc4245",
>  	},
> -	.probe		= ltc4245_probe,
> +	.probe_new	= ltc4245_probe,
>  	.id_table	= ltc4245_id,
>  };
>  
> diff --git a/drivers/hwmon/ltc4260.c b/drivers/hwmon/ltc4260.c
> index 8b8fd4a313ee..d0beb43abf3f 100644
> --- a/drivers/hwmon/ltc4260.c
> +++ b/drivers/hwmon/ltc4260.c
> @@ -141,8 +141,7 @@ static const struct regmap_config ltc4260_regmap_config = {
>  	.max_register = LTC4260_ADIN,
>  };
>  
> -static int ltc4260_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ltc4260_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -174,7 +173,7 @@ static struct i2c_driver ltc4260_driver = {
>  	.driver = {
>  		   .name = "ltc4260",
>  		   },
> -	.probe = ltc4260_probe,
> +	.probe_new = ltc4260_probe,
>  	.id_table = ltc4260_id,
>  };
>  
> diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
> index c415829ffbf5..1dab84b52df5 100644
> --- a/drivers/hwmon/ltc4261.c
> +++ b/drivers/hwmon/ltc4261.c
> @@ -190,8 +190,7 @@ static struct attribute *ltc4261_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ltc4261);
>  
> -static int ltc4261_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ltc4261_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct device *dev = &client->dev;
> @@ -234,7 +233,7 @@ static struct i2c_driver ltc4261_driver = {
>  	.driver = {
>  		   .name = "ltc4261",
>  		   },
> -	.probe = ltc4261_probe,
> +	.probe_new = ltc4261_probe,
>  	.id_table = ltc4261_id,
>  };
>  
> diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
> index 49b7e0b6d1bb..a26226e7bc37 100644
> --- a/drivers/hwmon/max16065.c
> +++ b/drivers/hwmon/max16065.c
> @@ -493,8 +493,9 @@ static const struct attribute_group max16065_max_group = {
>  	.is_visible = max16065_secondary_is_visible,
>  };
>  
> -static int max16065_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static const struct i2c_device_id max16065_id[];
> +
> +static int max16065_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct max16065_data *data;
> @@ -504,6 +505,7 @@ static int max16065_probe(struct i2c_client *client,
>  	bool have_secondary;		/* true if chip has secondary limits */
>  	bool secondary_is_max = false;	/* secondary limits reflect max */
>  	int groups = 0;
> +	const struct i2c_device_id *id = i2c_match_id(max16065_id, client);
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
>  				     | I2C_FUNC_SMBUS_READ_WORD_DATA))
> @@ -598,7 +600,7 @@ static struct i2c_driver max16065_driver = {
>  	.driver = {
>  		.name = "max16065",
>  	},
> -	.probe = max16065_probe,
> +	.probe_new = max16065_probe,
>  	.id_table = max16065_id,
>  };
>  
> diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
> index 87c6665bab3a..8bd941cae4d1 100644
> --- a/drivers/hwmon/max1619.c
> +++ b/drivers/hwmon/max1619.c
> @@ -261,8 +261,7 @@ static void max1619_init_client(struct i2c_client *client)
>  					  config & 0xBF); /* run */
>  }
>  
> -static int max1619_probe(struct i2c_client *new_client,
> -			 const struct i2c_device_id *id)
> +static int max1619_probe(struct i2c_client *new_client)
>  {
>  	struct max1619_data *data;
>  	struct device *hwmon_dev;
> @@ -306,7 +305,7 @@ static struct i2c_driver max1619_driver = {
>  		.name	= "max1619",
>  		.of_match_table = of_match_ptr(max1619_of_match),
>  	},
> -	.probe		= max1619_probe,
> +	.probe_new	= max1619_probe,
>  	.id_table	= max1619_id,
>  	.detect		= max1619_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
> index fb6d17287365..5c41c78f0458 100644
> --- a/drivers/hwmon/max1668.c
> +++ b/drivers/hwmon/max1668.c
> @@ -391,8 +391,9 @@ static int max1668_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int max1668_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static const struct i2c_device_id max1668_id[];
> +
> +static int max1668_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct device *dev = &client->dev;
> @@ -407,7 +408,7 @@ static int max1668_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data->client = client;
> -	data->type = id->driver_data;
> +	data->type = i2c_match_id(max1668_id, client)->driver_data;
>  	mutex_init(&data->update_lock);
>  
>  	/* sysfs hooks */
> @@ -434,7 +435,7 @@ static struct i2c_driver max1668_driver = {
>  	.driver = {
>  		  .name	= "max1668",
>  		  },
> -	.probe = max1668_probe,
> +	.probe_new = max1668_probe,
>  	.id_table = max1668_id,
>  	.detect	= max1668_detect,
>  	.address_list = max1668_addr_list,
> diff --git a/drivers/hwmon/max31730.c b/drivers/hwmon/max31730.c
> index eb22a34dc36b..23598b8b8793 100644
> --- a/drivers/hwmon/max31730.c
> +++ b/drivers/hwmon/max31730.c
> @@ -292,7 +292,7 @@ static void max31730_remove(void *data)
>  }
>  
>  static int
> -max31730_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +max31730_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -427,7 +427,7 @@ static struct i2c_driver max31730_driver = {
>  		.of_match_table = of_match_ptr(max31730_of_match),
>  		.pm	= &max31730_pm_ops,
>  	},
> -	.probe		= max31730_probe,
> +	.probe_new	= max31730_probe,
>  	.id_table	= max31730_ids,
>  	.detect		= max31730_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index 117fb79ef294..86e6c71db685 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -448,8 +448,7 @@ static int max31790_init_client(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int max31790_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int max31790_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct device *dev = &client->dev;
> @@ -491,7 +490,7 @@ MODULE_DEVICE_TABLE(i2c, max31790_id);
>  
>  static struct i2c_driver max31790_driver = {
>  	.class		= I2C_CLASS_HWMON,
> -	.probe		= max31790_probe,
> +	.probe_new	= max31790_probe,
>  	.driver = {
>  		.name	= "max31790",
>  	},
> diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
> index a8bb5de14230..367855d5edae 100644
> --- a/drivers/hwmon/max6621.c
> +++ b/drivers/hwmon/max6621.c
> @@ -477,8 +477,7 @@ static const struct hwmon_chip_info max6621_chip_info = {
>  	.info = max6621_info,
>  };
>  
> -static int max6621_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int max6621_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct max6621_data *data;
> @@ -555,7 +554,7 @@ static struct i2c_driver max6621_driver = {
>  		.name = MAX6621_DRV_NAME,
>  		.of_match_table = of_match_ptr(max6621_of_match),
>  	},
> -	.probe		= max6621_probe,
> +	.probe_new	= max6621_probe,
>  	.id_table	= max6621_id,
>  };
>  
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 2d56e97aa5fa..b71899c641fa 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -516,8 +516,7 @@ static int max6639_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int max6639_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int max6639_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct max6639_data *data;
> @@ -581,7 +580,7 @@ static struct i2c_driver max6639_driver = {
>  		   .name = "max6639",
>  		   .pm = &max6639_pm_ops,
>  		   },
> -	.probe = max6639_probe,
> +	.probe_new = max6639_probe,
>  	.id_table = max6639_id,
>  	.detect = max6639_detect,
>  	.address_list = normal_i2c,
> diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
> index 5ab6fdb53b96..23d93142b0b3 100644
> --- a/drivers/hwmon/max6642.c
> +++ b/drivers/hwmon/max6642.c
> @@ -264,8 +264,7 @@ static struct attribute *max6642_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(max6642);
>  
> -static int max6642_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int max6642_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct max6642_data *data;
> @@ -302,7 +301,7 @@ static struct i2c_driver max6642_driver = {
>  	.driver = {
>  		.name	= "max6642",
>  	},
> -	.probe		= max6642_probe,
> +	.probe_new	= max6642_probe,
>  	.id_table	= max6642_id,
>  	.detect		= max6642_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
> index 3d9d371c35b5..cc7f2980fe83 100644
> --- a/drivers/hwmon/max6650.c
> +++ b/drivers/hwmon/max6650.c
> @@ -757,8 +757,9 @@ static const struct hwmon_chip_info max6650_chip_info = {
>  	.info = max6650_info,
>  };
>  
> -static int max6650_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static const struct i2c_device_id max6650_id[];
> +
> +static int max6650_probe(struct i2c_client *client)
>  {
>  	struct thermal_cooling_device *cooling_dev;
>  	struct device *dev = &client->dev;
> @@ -775,7 +776,8 @@ static int max6650_probe(struct i2c_client *client,
>  	data->client = client;
>  	i2c_set_clientdata(client, data);
>  	mutex_init(&data->update_lock);
> -	data->nr_fans = of_id ? (int)(uintptr_t)of_id->data : id->driver_data;
> +	data->nr_fans = of_id ? (int)(uintptr_t)of_id->data :
> +				i2c_match_id(max6650_id, client)->driver_data;
>  
>  	/*
>  	 * Initialize the max6650 chip
> @@ -817,7 +819,7 @@ static struct i2c_driver max6650_driver = {
>  		.name	= "max6650",
>  		.of_match_table = of_match_ptr(max6650_dt_match),
>  	},
> -	.probe		= max6650_probe,
> +	.probe_new	= max6650_probe,
>  	.id_table	= max6650_id,
>  };
>  
> diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
> index 64122eb38060..d00cbe84f004 100644
> --- a/drivers/hwmon/max6697.c
> +++ b/drivers/hwmon/max6697.c
> @@ -593,8 +593,9 @@ static int max6697_init_chip(struct max6697_data *data,
>  	return 0;
>  }
>  
> -static int max6697_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static const struct i2c_device_id max6697_id[];
> +
> +static int max6697_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct device *dev = &client->dev;
> @@ -612,7 +613,7 @@ static int max6697_probe(struct i2c_client *client,
>  	if (client->dev.of_node)
>  		data->type = (enum chips)of_device_get_match_data(&client->dev);
>  	else
> -		data->type = id->driver_data;
> +		data->type = i2c_match_id(max6697_id, client)->driver_data;
>  	data->chip = &max6697_chip_data[data->type];
>  	data->client = client;
>  	mutex_init(&data->update_lock);
> @@ -693,7 +694,7 @@ static struct i2c_driver max6697_driver = {
>  		.name	= "max6697",
>  		.of_match_table = of_match_ptr(max6697_of_match),
>  	},
> -	.probe = max6697_probe,
> +	.probe_new = max6697_probe,
>  	.id_table = max6697_id,
>  };
>  
> diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
> index 4e8f995dc773..ce2780768074 100644
> --- a/drivers/hwmon/mcp3021.c
> +++ b/drivers/hwmon/mcp3021.c
> @@ -100,8 +100,9 @@ static ssize_t in0_input_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(in0_input);
>  
> -static int mcp3021_probe(struct i2c_client *client,
> -				const struct i2c_device_id *id)
> +static const struct i2c_device_id mcp3021_id[];
> +
> +static int mcp3021_probe(struct i2c_client *client)
>  {
>  	int err;
>  	struct mcp3021_data *data = NULL;
> @@ -132,7 +133,7 @@ static int mcp3021_probe(struct i2c_client *client,
>  			data->vdd = MCP3021_VDD_REF_DEFAULT;
>  	}
>  
> -	switch (id->driver_data) {
> +	switch (i2c_match_id(mcp3021_id, client)->driver_data) {
>  	case mcp3021:
>  		data->sar_shift = MCP3021_SAR_SHIFT;
>  		data->sar_mask = MCP3021_SAR_MASK;
> @@ -197,7 +198,7 @@ static struct i2c_driver mcp3021_driver = {
>  		.name = "mcp3021",
>  		.of_match_table = of_match_ptr(of_mcp3021_match),
>  	},
> -	.probe = mcp3021_probe,
> +	.probe_new = mcp3021_probe,
>  	.remove = mcp3021_remove,
>  	.id_table = mcp3021_id,
>  };
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 570df8eb5272..604af2f6103a 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -1056,8 +1056,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
>  	return regmap_update_bits(data->regmap, REG_VMON_ENABLE, 0x03, 0x03);
>  }
>  
> -static int nct7802_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int nct7802_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct nct7802_data *data;
> @@ -1101,7 +1100,7 @@ static struct i2c_driver nct7802_driver = {
>  		.name = DRVNAME,
>  	},
>  	.detect = nct7802_detect,
> -	.probe = nct7802_probe,
> +	.probe_new = nct7802_probe,
>  	.id_table = nct7802_idtable,
>  	.address_list = nct7802_address_list,
>  };
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index b0425694f702..c129a58b69f1 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -1009,8 +1009,7 @@ static const struct watchdog_ops nct7904_wdt_ops = {
>  	.get_timeleft	= nct7904_wdt_get_timeleft,
>  };
>  
> -static int nct7904_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int nct7904_probe(struct i2c_client *client)
>  {
>  	struct nct7904_data *data;
>  	struct device *hwmon_dev;
> @@ -1172,7 +1171,7 @@ static struct i2c_driver nct7904_driver = {
>  	.driver = {
>  		.name = "nct7904",
>  	},
> -	.probe = nct7904_probe,
> +	.probe_new = nct7904_probe,
>  	.id_table = nct7904_id,
>  	.detect = nct7904_detect,
>  	.address_list = normal_i2c,
> diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
> index 76fb7870c7d3..0cf8588be35a 100644
> --- a/drivers/hwmon/occ/p8_i2c.c
> +++ b/drivers/hwmon/occ/p8_i2c.c
> @@ -203,8 +203,7 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd)
>  	return 0;
>  }
>  
> -static int p8_i2c_occ_probe(struct i2c_client *client,
> -			    const struct i2c_device_id *id)
> +static int p8_i2c_occ_probe(struct i2c_client *client)
>  {
>  	struct occ *occ;
>  	struct p8_i2c_occ *ctx = devm_kzalloc(&client->dev, sizeof(*ctx),
> @@ -245,7 +244,7 @@ static struct i2c_driver p8_i2c_occ_driver = {
>  		.name = "occ-hwmon",
>  		.of_match_table = p8_i2c_occ_of_match,
>  	},
> -	.probe = p8_i2c_occ_probe,
> +	.probe_new = p8_i2c_occ_probe,
>  	.remove = p8_i2c_occ_remove,
>  };
>  
> diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
> index b7a3a292123d..a97a51005c61 100644
> --- a/drivers/hwmon/pcf8591.c
> +++ b/drivers/hwmon/pcf8591.c
> @@ -179,8 +179,7 @@ static const struct attribute_group pcf8591_attr_group_opt = {
>   * Real code
>   */
>  
> -static int pcf8591_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int pcf8591_probe(struct i2c_client *client)
>  {
>  	struct pcf8591_data *data;
>  	int err;
> @@ -295,7 +294,7 @@ static struct i2c_driver pcf8591_driver = {
>  	.driver = {
>  		.name	= "pcf8591",
>  	},
> -	.probe		= pcf8591_probe,
> +	.probe_new	= pcf8591_probe,
>  	.remove		= pcf8591_remove,
>  	.id_table	= pcf8591_id,
>  };
> diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
> index 65997421ee3c..6473301b649b 100644
> --- a/drivers/hwmon/powr1220.c
> +++ b/drivers/hwmon/powr1220.c
> @@ -297,8 +297,7 @@ static struct attribute *powr1220_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(powr1220);
>  
> -static int powr1220_probe(struct i2c_client *client,
> -		const struct i2c_device_id *id)
> +static int powr1220_probe(struct i2c_client *client)
>  {
>  	struct powr1220_data *data;
>  	struct device *hwmon_dev;
> @@ -331,7 +330,7 @@ static struct i2c_driver powr1220_driver = {
>  	.driver = {
>  		.name	= "powr1220",
>  	},
> -	.probe		= powr1220_probe,
> +	.probe_new	= powr1220_probe,
>  	.id_table	= powr1220_ids,
>  };
>  
> diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
> index bc70c8332d9a..53055385ecb6 100644
> --- a/drivers/hwmon/sht21.c
> +++ b/drivers/hwmon/sht21.c
> @@ -250,8 +250,7 @@ static struct attribute *sht21_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(sht21);
>  
> -static int sht21_probe(struct i2c_client *client,
> -	const struct i2c_device_id *id)
> +static int sht21_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -286,7 +285,7 @@ MODULE_DEVICE_TABLE(i2c, sht21_id);
>  
>  static struct i2c_driver sht21_driver = {
>  	.driver.name = "sht21",
> -	.probe       = sht21_probe,
> +	.probe_new   = sht21_probe,
>  	.id_table    = sht21_id,
>  };
>  
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 7364764baaeb..3f279aa1cee5 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -662,8 +662,9 @@ static struct attribute *sts3x_attrs[] = {
>  ATTRIBUTE_GROUPS(sht3x);
>  ATTRIBUTE_GROUPS(sts3x);
>  
> -static int sht3x_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id)
> +static const struct i2c_device_id sht3x_ids[];
> +
> +static int sht3x_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct sht3x_data *data;
> @@ -715,7 +716,7 @@ static int sht3x_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	if (id->driver_data == sts3x)
> +	if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
>  		attribute_groups = sts3x_groups;
>  	else
>  		attribute_groups = sht3x_groups;
> @@ -742,7 +743,7 @@ MODULE_DEVICE_TABLE(i2c, sht3x_ids);
>  
>  static struct i2c_driver sht3x_i2c_driver = {
>  	.driver.name = "sht3x",
> -	.probe       = sht3x_probe,
> +	.probe_new   = sht3x_probe,
>  	.id_table    = sht3x_ids,
>  };
>  
> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
> index a0078ccede03..288fd0b4c4d3 100644
> --- a/drivers/hwmon/shtc1.c
> +++ b/drivers/hwmon/shtc1.c
> @@ -185,15 +185,16 @@ static void shtc1_select_command(struct shtc1_data *data)
>  	}
>  }
>  
> -static int shtc1_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id)
> +static const struct i2c_device_id shtc1_id[];
> +
> +static int shtc1_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	u16 id_reg;
>  	char id_reg_buf[2];
>  	struct shtc1_data *data;
>  	struct device *hwmon_dev;
> -	enum shtcx_chips chip = id->driver_data;
> +	enum shtcx_chips chip = i2c_match_id(shtc1_id, client)->driver_data;
>  	struct i2c_adapter *adap = client->adapter;
>  	struct device *dev = &client->dev;
>  
> @@ -259,7 +260,7 @@ MODULE_DEVICE_TABLE(i2c, shtc1_id);
>  
>  static struct i2c_driver shtc1_i2c_driver = {
>  	.driver.name  = "shtc1",
> -	.probe        = shtc1_probe,
> +	.probe_new    = shtc1_probe,
>  	.id_table     = shtc1_id,
>  };
>  
> diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
> index af01f763f7d1..b6cbe9810a1b 100644
> --- a/drivers/hwmon/smm665.c
> +++ b/drivers/hwmon/smm665.c
> @@ -562,8 +562,9 @@ static struct attribute *smm665_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(smm665);
>  
> -static int smm665_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static const struct i2c_device_id smm665_id[];
> +
> +static int smm665_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct smm665_data *data;
> @@ -585,7 +586,7 @@ static int smm665_probe(struct i2c_client *client,
>  	mutex_init(&data->update_lock);
>  
>  	data->client = client;
> -	data->type = id->driver_data;
> +	data->type = i2c_match_id(smm665_id, client)->driver_data;
>  	data->cmdreg = i2c_new_dummy_device(adapter, (client->addr & ~SMM665_REGMASK)
>  				     | SMM665_CMDREG_BASE);
>  	if (IS_ERR(data->cmdreg))
> @@ -694,7 +695,7 @@ static struct i2c_driver smm665_driver = {
>  	.driver = {
>  		   .name = "smm665",
>  		   },
> -	.probe = smm665_probe,
> +	.probe_new = smm665_probe,
>  	.remove = smm665_remove,
>  	.id_table = smm665_id,
>  };
> diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
> index 6cbb119e3d0e..03a87aa2017a 100644
> --- a/drivers/hwmon/smsc47m192.c
> +++ b/drivers/hwmon/smsc47m192.c
> @@ -587,8 +587,7 @@ static int smsc47m192_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int smsc47m192_probe(struct i2c_client *client,
> -			    const struct i2c_device_id *id)
> +static int smsc47m192_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -629,7 +628,7 @@ static struct i2c_driver smsc47m192_driver = {
>  	.driver = {
>  		.name	= "smsc47m192",
>  	},
> -	.probe		= smsc47m192_probe,
> +	.probe_new	= smsc47m192_probe,
>  	.id_table	= smsc47m192_id,
>  	.detect		= smsc47m192_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/stts751.c b/drivers/hwmon/stts751.c
> index 35b353c2b0a1..6928be6dbe4e 100644
> --- a/drivers/hwmon/stts751.c
> +++ b/drivers/hwmon/stts751.c
> @@ -762,8 +762,7 @@ static struct attribute *stts751_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(stts751);
>  
> -static int stts751_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int stts751_probe(struct i2c_client *client)
>  {
>  	struct stts751_priv *priv;
>  	int ret;
> @@ -822,7 +821,7 @@ static struct i2c_driver stts751_driver = {
>  		.name	= DEVNAME,
>  		.of_match_table = of_match_ptr(stts751_of_match),
>  	},
> -	.probe		= stts751_probe,
> +	.probe_new	= stts751_probe,
>  	.id_table	= stts751_id,
>  	.detect		= stts751_detect,
>  	.alert		= stts751_alert,
> diff --git a/drivers/hwmon/tc654.c b/drivers/hwmon/tc654.c
> index 3e3b8c61bd76..a52ca72af120 100644
> --- a/drivers/hwmon/tc654.c
> +++ b/drivers/hwmon/tc654.c
> @@ -446,8 +446,7 @@ ATTRIBUTE_GROUPS(tc654);
>   * device probe and removal
>   */
>  
> -static int tc654_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id)
> +static int tc654_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct tc654_data *data;
> @@ -488,7 +487,7 @@ static struct i2c_driver tc654_driver = {
>  	.driver = {
>  		   .name = "tc654",
>  		   },
> -	.probe = tc654_probe,
> +	.probe_new = tc654_probe,
>  	.id_table = tc654_id,
>  };
>  
> diff --git a/drivers/hwmon/tc74.c b/drivers/hwmon/tc74.c
> index fcf638ed16a9..ace55da97fc2 100644
> --- a/drivers/hwmon/tc74.c
> +++ b/drivers/hwmon/tc74.c
> @@ -103,8 +103,7 @@ static struct attribute *tc74_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(tc74);
>  
> -static int tc74_probe(struct i2c_client *client,
> -		      const struct i2c_device_id *dev_id)
> +static int tc74_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct tc74_data *data;
> @@ -161,7 +160,7 @@ static struct i2c_driver tc74_driver = {
>  	.driver = {
>  		.name	= "tc74",
>  	},
> -	.probe	= tc74_probe,
> +	.probe_new = tc74_probe,
>  	.id_table = tc74_id,
>  };
>  
> diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
> index 3f5a983d9289..fde5e2d0825a 100644
> --- a/drivers/hwmon/thmc50.c
> +++ b/drivers/hwmon/thmc50.c
> @@ -377,8 +377,9 @@ static void thmc50_init_client(struct thmc50_data *data)
>  	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
>  }
>  
> -static int thmc50_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static const struct i2c_device_id thmc50_id[];
> +
> +static int thmc50_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct thmc50_data *data;
> @@ -390,7 +391,7 @@ static int thmc50_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data->client = client;
> -	data->type = id->driver_data;
> +	data->type = i2c_match_id(thmc50_id, client)->driver_data;
>  	mutex_init(&data->update_lock);
>  
>  	thmc50_init_client(data);
> @@ -419,7 +420,7 @@ static struct i2c_driver thmc50_driver = {
>  	.driver = {
>  		.name = "thmc50",
>  	},
> -	.probe = thmc50_probe,
> +	.probe_new = thmc50_probe,
>  	.id_table = thmc50_id,
>  	.detect = thmc50_detect,
>  	.address_list = normal_i2c,
> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
> index 5fe35e5b2f73..e867a0c2e539 100644
> --- a/drivers/hwmon/tmp102.c
> +++ b/drivers/hwmon/tmp102.c
> @@ -189,8 +189,7 @@ static const struct regmap_config tmp102_regmap_config = {
>  	.use_single_write = true,
>  };
>  
> -static int tmp102_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int tmp102_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -304,7 +303,7 @@ static struct i2c_driver tmp102_driver = {
>  	.driver.name	= DRIVER_NAME,
>  	.driver.of_match_table = of_match_ptr(tmp102_of_match),
>  	.driver.pm	= &tmp102_dev_pm_ops,
> -	.probe		= tmp102_probe,
> +	.probe_new	= tmp102_probe,
>  	.id_table	= tmp102_id,
>  };
>  
> diff --git a/drivers/hwmon/tmp103.c b/drivers/hwmon/tmp103.c
> index 49851533935e..a7e202cc8323 100644
> --- a/drivers/hwmon/tmp103.c
> +++ b/drivers/hwmon/tmp103.c
> @@ -109,8 +109,7 @@ static const struct regmap_config tmp103_regmap_config = {
>  	.volatile_reg = tmp103_regmap_is_volatile,
>  };
>  
> -static int tmp103_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int tmp103_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -172,7 +171,7 @@ static struct i2c_driver tmp103_driver = {
>  		.of_match_table = of_match_ptr(tmp103_of_match),
>  		.pm	= &tmp103_dev_pm_ops,
>  	},
> -	.probe		= tmp103_probe,
> +	.probe_new	= tmp103_probe,
>  	.id_table	= tmp103_id,
>  };
>  
> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> index fe587d4f9b2d..5435664c3f6e 100644
> --- a/drivers/hwmon/tmp108.c
> +++ b/drivers/hwmon/tmp108.c
> @@ -323,8 +323,7 @@ static const struct regmap_config tmp108_regmap_config = {
>  	.use_single_write = true,
>  };
>  
> -static int tmp108_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int tmp108_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -433,7 +432,7 @@ static struct i2c_driver tmp108_driver = {
>  		.pm	= &tmp108_dev_pm_ops,
>  		.of_match_table = of_match_ptr(tmp108_of_ids),
>  	},
> -	.probe		= tmp108_probe,
> +	.probe_new	= tmp108_probe,
>  	.id_table	= tmp108_i2c_ids,
>  };
>  
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index fa361d9949db..9dc210b55e69 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -683,8 +683,7 @@ static int tmp401_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int tmp401_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int tmp401_probe(struct i2c_client *client)
>  {
>  	static const char * const names[] = {
>  		"TMP401", "TMP411", "TMP431", "TMP432", "TMP435", "TMP461"
> @@ -700,7 +699,7 @@ static int tmp401_probe(struct i2c_client *client,
>  
>  	data->client = client;
>  	mutex_init(&data->update_lock);
> -	data->kind = id->driver_data;
> +	data->kind = i2c_match_id(tmp401_id, client)->driver_data;
>  
>  	/* Initialize the TMP401 chip */
>  	status = tmp401_init_client(data, client);
> @@ -736,7 +735,7 @@ static struct i2c_driver tmp401_driver = {
>  	.driver = {
>  		.name	= "tmp401",
>  	},
> -	.probe		= tmp401_probe,
> +	.probe_new	= tmp401_probe,
>  	.id_table	= tmp401_id,
>  	.detect		= tmp401_detect,
>  	.address_list	= normal_i2c,
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index 83a4fab151d2..ede66ea6a730 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -279,8 +279,7 @@ static const struct hwmon_ops tmp421_ops = {
>  	.read = tmp421_read,
>  };
>  
> -static int tmp421_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int tmp421_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -296,7 +295,7 @@ static int tmp421_probe(struct i2c_client *client,
>  		data->channels = (unsigned long)
>  			of_device_get_match_data(&client->dev);
>  	else
> -		data->channels = id->driver_data;
> +		data->channels = i2c_match_id(tmp421_id, client)->driver_data;
>  	data->client = client;
>  
>  	err = tmp421_init_client(client);
> @@ -327,7 +326,7 @@ static struct i2c_driver tmp421_driver = {
>  		.name	= "tmp421",
>  		.of_match_table = of_match_ptr(tmp421_of_match),
>  	},
> -	.probe = tmp421_probe,
> +	.probe_new = tmp421_probe,
>  	.id_table = tmp421_id,
>  	.detect = tmp421_detect,
>  	.address_list = normal_i2c,
> diff --git a/drivers/hwmon/w83773g.c b/drivers/hwmon/w83773g.c
> index 96b695b32572..88d11dc5feb9 100644
> --- a/drivers/hwmon/w83773g.c
> +++ b/drivers/hwmon/w83773g.c
> @@ -259,8 +259,7 @@ static const struct regmap_config w83773_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> -static int w83773_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int w83773_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -296,7 +295,7 @@ static struct i2c_driver w83773_driver = {
>  		.name	= "w83773g",
>  		.of_match_table = of_match_ptr(w83773_of_match),
>  	},
> -	.probe = w83773_probe,
> +	.probe_new = w83773_probe,
>  	.id_table = w83773_id,
>  };
>  
> diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> index 015f1ea31966..1826345768b0 100644
> --- a/drivers/hwmon/w83781d.c
> +++ b/drivers/hwmon/w83781d.c
> @@ -1192,8 +1192,9 @@ static void w83781d_remove_files(struct device *dev)
>  	sysfs_remove_group(&dev->kobj, &w83781d_group_other);
>  }
>  
> -static int
> -w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static const struct i2c_device_id w83781d_ids[];
> +
> +static int w83781d_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct w83781d_data *data;
> @@ -1207,7 +1208,7 @@ w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	mutex_init(&data->lock);
>  	mutex_init(&data->update_lock);
>  
> -	data->type = id->driver_data;
> +	data->type = i2c_match_id(w83781d_ids, client)->driver_data;
>  	data->client = client;
>  
>  	/* attach secondary i2c lm75-like clients */
> @@ -1575,7 +1576,7 @@ static struct i2c_driver w83781d_driver = {
>  	.driver = {
>  		.name = "w83781d",
>  	},
> -	.probe		= w83781d_probe,
> +	.probe_new	= w83781d_probe,
>  	.remove		= w83781d_remove,
>  	.id_table	= w83781d_ids,
>  	.detect		= w83781d_detect,
> diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> index 7fc8a1160c8f..abd5c3a722b9 100644
> --- a/drivers/hwmon/w83792d.c
> +++ b/drivers/hwmon/w83792d.c
> @@ -286,8 +286,7 @@ struct w83792d_data {
>  	u8 sf2_levels[3][4];	/* Smart FanII: Fan1,2,3 duty cycle levels */
>  };
>  
> -static int w83792d_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id);
> +static int w83792d_probe(struct i2c_client *client);
>  static int w83792d_detect(struct i2c_client *client,
>  			  struct i2c_board_info *info);
>  static int w83792d_remove(struct i2c_client *client);
> @@ -310,7 +309,7 @@ static struct i2c_driver w83792d_driver = {
>  	.driver = {
>  		.name = "w83792d",
>  	},
> -	.probe		= w83792d_probe,
> +	.probe_new	= w83792d_probe,
>  	.remove		= w83792d_remove,
>  	.id_table	= w83792d_id,
>  	.detect		= w83792d_detect,
> @@ -1359,7 +1358,7 @@ w83792d_detect(struct i2c_client *client, struct i2c_board_info *info)
>  }
>  
>  static int
> -w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +w83792d_probe(struct i2c_client *client)
>  {
>  	struct w83792d_data *data;
>  	struct device *dev = &client->dev;
> diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
> index 6f6d925cf017..656a77102ca6 100644
> --- a/drivers/hwmon/w83l785ts.c
> +++ b/drivers/hwmon/w83l785ts.c
> @@ -62,8 +62,7 @@ static const unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
>   * Functions declaration
>   */
>  
> -static int w83l785ts_probe(struct i2c_client *client,
> -			   const struct i2c_device_id *id);
> +static int w83l785ts_probe(struct i2c_client *client);
>  static int w83l785ts_detect(struct i2c_client *client,
>  			    struct i2c_board_info *info);
>  static int w83l785ts_remove(struct i2c_client *client);
> @@ -85,7 +84,7 @@ static struct i2c_driver w83l785ts_driver = {
>  	.driver = {
>  		.name	= "w83l785ts",
>  	},
> -	.probe		= w83l785ts_probe,
> +	.probe_new	= w83l785ts_probe,
>  	.remove		= w83l785ts_remove,
>  	.id_table	= w83l785ts_id,
>  	.detect		= w83l785ts_detect,
> @@ -163,8 +162,7 @@ static int w83l785ts_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int w83l785ts_probe(struct i2c_client *client,
> -			   const struct i2c_device_id *id)
> +static int w83l785ts_probe(struct i2c_client *client)
>  {
>  	struct w83l785ts_data *data;
>  	struct device *dev = &client->dev;
> diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
> index ce98ec8794e2..542afff1423b 100644
> --- a/drivers/hwmon/w83l786ng.c
> +++ b/drivers/hwmon/w83l786ng.c
> @@ -706,7 +706,7 @@ static void w83l786ng_init_client(struct i2c_client *client)
>  }
>  
>  static int
> -w83l786ng_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +w83l786ng_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct w83l786ng_data *data;
> @@ -752,7 +752,7 @@ static struct i2c_driver w83l786ng_driver = {
>  	.driver = {
>  		   .name = "w83l786ng",
>  	},
> -	.probe		= w83l786ng_probe,
> +	.probe_new	= w83l786ng_probe,
>  	.id_table	= w83l786ng_id,
>  	.detect		= w83l786ng_detect,
>  	.address_list	= normal_i2c,

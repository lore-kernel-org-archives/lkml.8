Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7C6C2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1EE20719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB7lUP9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCYWri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:47:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45396 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCYWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:47:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id j10so1771482pfi.12;
        Wed, 25 Mar 2020 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFZkZFYwqHSJOQ7bUJW/pNMrxyJVkQUkj+x8ql4yZG8=;
        b=YB7lUP9TWiiBjqOLGSr0PdPg4LgPmjwYOdoEedAUexvqR0t42sZ5iV20FhdwhPXXuh
         kFxNWUHiPMwU7EQvEekywFyufVCM7lmTfJpNzaSE8uII8Ra0kIYNyBgmcfTU7F3X1UeI
         VRU+FegjBWcPkW78EKNF29y9Ut9SnrJYo6y845LOtRHQZUUJri8XaWQJTIgooJTvgBK7
         xqRcOqtckfVpW78vMqfTy3XKhTtIet7R1lQ/3p7aGZF3rVPwEG/OFIYq9nYsOqe2Axgs
         HirixG5K6d6KijNoAEqF0b4yKL3Xd5WlcvYmUHIejnCLhqmC0hf4JDWhE961gIymZoAX
         NExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFZkZFYwqHSJOQ7bUJW/pNMrxyJVkQUkj+x8ql4yZG8=;
        b=Gg96kVlUNfVObzb/Z/7c6PyYMLbbivrHPNJXEH6fdskX2mAX1oLGGIj05RoFTR+B3H
         GzHKHxwvNYRuNHXQgDUYa+0iQ4R8kbGFOd6RiEIaLZzxi5ovKUdKbFbgOct5k71MtFBV
         eIU1IR1k1XlNM4Yn9KO5ZnoRO8PySQOQVzs3jkxRvSTrmiVwg6tB8EDqD6usovaHTxcl
         fKtLkiYA1mUv/nUFa4QovL+gb/RGWvjmUfRUtdo2pphVAb29RI51F4KXpWvhWpf5f4TU
         t+zVfPJGede+K9cetY0jjXF8fNL1qJCYUJKQDgVkdwgwbZQTAsXEqBUwI2y402jzqlNA
         34iw==
X-Gm-Message-State: ANhLgQ32T2nyoRE7ElRJSec/X342N/mrC0bnF9mq9VWxtz3x03YVn1IB
        19cvPYwqavxOtzNkjIK0f2U=
X-Google-Smtp-Source: ADFU+vs8B2e6bsKr3WAAuIl7C+ayAZEU3Nj/PoyldYaIQm84cYxYJZ6tle14GBriNUcCpnIxeIdt5w==
X-Received: by 2002:a63:1d52:: with SMTP id d18mr5139656pgm.443.1585176455855;
        Wed, 25 Mar 2020 15:47:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w4sm158594pfc.57.2020.03.25.15.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Mar 2020 15:47:34 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:47:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     yuechao.zhao@advantech.com.cn
Cc:     345351830@qq.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        amy.shih@advantech.com.tw, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, shengkui.leng@advantech.com.cn
Subject: Re: [v2,1/1] hwmon: (nct7904) Add watchdog function
Message-ID: <20200325224733.GA27706@roeck-us.net>
References: <20200325082237.7002-1-yuechao.zhao@advantech.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325082237.7002-1-yuechao.zhao@advantech.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:22:37AM +0000, yuechao.zhao@advantech.com.cn wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> implement watchdong functionality into the "hwmon/nct7904.c"
> 
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> ---
> v2:
> - Modify dependency of NC7904 into "drivers/hwmon/Kconfig".
> ---
>  drivers/hwmon/Kconfig   |   6 +-
>  drivers/hwmon/nct7904.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 160 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 05a3083..cd0ae82 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1340,10 +1340,12 @@ config SENSORS_NCT7802
>  
>  config SENSORS_NCT7904
>  	tristate "Nuvoton NCT7904"
> -	depends on I2C
> +	depends on I2C && WATCHDOG
> +	select WATCHDOG_CORE
>  	help
>  	  If you say yes here you get support for the Nuvoton NCT7904
> -	  hardware monitoring chip, including manual fan speed control.
> +	  hardware monitoring chip, including manual fan speed control
> +	  and support for the integrated watchdog.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nct7904.
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 1f5743d..137199c 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -8,6 +8,9 @@
>   * Copyright (c) 2019 Advantech
>   * Author: Amy.Shih <amy.shih@advantech.com.tw>
>   *
> + * Copyright (c) 2020 Advantech
> + * Author: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> + *
>   * Supports the following chips:
>   *
>   * Chip        #vin  #fan  #pwm  #temp  #dts  chip ID
> @@ -20,6 +23,7 @@
>  #include <linux/i2c.h>
>  #include <linux/mutex.h>
>  #include <linux/hwmon.h>
> +#include <linux/watchdog.h>
>  
>  #define VENDOR_ID_REG		0x7A	/* Any bank */
>  #define NUVOTON_ID		0x50
> @@ -87,18 +91,39 @@
>  #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
>  #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
>  
> +#define WDT_LOCK_REG		0xE0	/* W/O Lock Watchdog Register */
> +#define WDT_EN_REG		0xE1	/* R/O Watchdog Enable Register */
> +#define WDT_STS_REG		0xE2	/* R/O Watchdog Status Register */
> +#define WDT_TIMER_REG		0xE3	/* R/W Watchdog Timer Register */
> +#define WDT_SOFT_EN		0x55	/* Enable soft watchdog timer */
> +#define WDT_SOFT_DIS		0xAA	/* Disable soft watchdog timer */
> +
>  #define VOLT_MONITOR_MODE	0x0
>  #define THERMAL_DIODE_MODE	0x1
>  #define THERMISTOR_MODE		0x3
>  
>  #define ENABLE_TSI	BIT(1)
>  
> +#define WATCHDOG_TIMEOUT	1	/* 1 minute default timeout */

> +static int ping_timeout = WATCHDOG_TIMEOUT; /* default feeding timeout */

Please no static variables; at least in theory there could be multiple
NCT7904 in the system. Just use wdt->timeout / 60.

> +
> +static int timeout = WATCHDOG_TIMEOUT;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
> +			__MODULE_STRING(WATCHODOG_TIMEOUT) ".");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started once started (default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
>  static const unsigned short normal_i2c[] = {
>  	0x2d, 0x2e, I2C_CLIENT_END
>  };
>  
>  struct nct7904_data {
>  	struct i2c_client *client;
> +	struct watchdog_device wdt;
>  	struct mutex bank_lock;
>  	int bank_sel;
>  	u32 fanin_mask;
> @@ -889,6 +914,91 @@ static int nct7904_detect(struct i2c_client *client,
>  	.info = nct7904_info,
>  };
>  
> +/*
> + * Wathcdog Function
> + */
> +static int nct7904_wdt_start(struct watchdog_device *wdt)
> +{
> +	int ret;
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +
> +	/* Disable soft watchdog timer first */
> +	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
> +	if (ret < 0)
> +		return ret;
> +
Is that really necessary ?

> +	/* Enable soft watchdog timer */
> +	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_EN);
> +	return ret;

Just return immediately here, without assigning to ret.

> +}
> +
> +static int nct7904_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +	int ret;
> +
> +	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
> +
> +	return ret;

Same here. 'ret' is unnecessary.

> +}
> +
> +static int nct7904_wdt_set_timeout(struct watchdog_device *wdt,
> +				   unsigned int timeout)
> +{
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +
> +	ping_timeout = timeout / 60;

The code should update wdt->timeout, and then use wdt->timeout as basis for
setting the chip timeout.

> +
> +	return nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, ping_timeout);
> +}
> +
> +static int nct7904_wdt_ping(struct watchdog_device *wdt)
> +{
> +	/*
> +	 * Note:
> +	 * NCT7904 is not supported refresh WDT_TIMER_REG register when the

"does not support refreshing ..." if I understand correctly.

> +	 * watchdog is actiove. Please disable watchdog before fedding the

s/actiove/active/
s/fedding/feeding/

> +	 * watchdog and enable it again.
> +	 */
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +	int ret;
> +
> +	/* Disable soft watchdog timer */
> +	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
> +	if (ret < 0)
> +		goto ping_err;
> +
> +	/* feed watchdog */
> +	ret = nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, ping_timeout);

This should use wdt->timeout / 60 (see above).

Is it necessary to update the timeout ? The datasheet doesn't describe it well.

If the timer register is updated, you could possibly implement
a get_timeout function.

> +	if (ret < 0)
> +		goto ping_err;
> +
> +	/* Enable soft watchdog timer */
> +	ret = nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, WDT_SOFT_EN);
> +	if (ret < 0)
> +		goto ping_err;
> +
> +	return 0;
> +
> +ping_err:
> +	pr_err("nct7904 ping error\n");

I am a concerned about this; if the error is persistent, it would
clog up the log. Please just return the error.

> +	return ret;
> +}
> +
> +static const struct watchdog_info nct7904_wdt_info = {
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> +				WDIOF_MAGICCLOSE,
> +	.identity	= "nct7904 watchdog",
> +};
> +
> +static const struct watchdog_ops nct7904_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= nct7904_wdt_start,
> +	.stop		= nct7904_wdt_stop,
> +	.ping		= nct7904_wdt_ping,
> +	.set_timeout	= nct7904_wdt_set_timeout,
> +};
> +
>  static int nct7904_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1012,7 +1122,51 @@ static int nct7904_probe(struct i2c_client *client,
>  	hwmon_dev =
>  		devm_hwmon_device_register_with_info(dev, client->name, data,
>  						     &nct7904_chip_info, NULL);
> -	return PTR_ERR_OR_ZERO(hwmon_dev);
> +	ret = PTR_ERR_OR_ZERO(hwmon_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Watchdog initialization */
> +	data->wdt.ops = &nct7904_wdt_ops;
> +	data->wdt.info = &nct7904_wdt_info;
> +
> +	data->wdt.timeout = timeout * 60; /* in seconds */
> +	data->wdt.min_timeout = 1;
> +	data->wdt.max_timeout = 15300;

Please make it 60 * 255 (or use a respective define) to clarify
where the number comes from.

> +	data->wdt.parent = &client->dev;
> +
> +	watchdog_init_timeout(&data->wdt, timeout, &client->dev);
> +	watchdog_set_nowayout(&data->wdt, nowayout);
> +	watchdog_set_drvdata(&data->wdt, data);
> +
> +	i2c_set_clientdata(client, data);
> +
> +	ret = watchdog_register_device(&data->wdt);
> +	if (ret)
> +		return ret;

Please use devm_watchdog_register_device()

> +
> +	dev_info(&client->dev, "NCT7904 HWMON and Watchdog device probed\n");
> +
I am not in favor of such noise.

> +	return ret;
> +}
> +
> +static int nct7904_remove(struct i2c_client *client)
> +{
> +	/*
> +	 * HWMON use devm_hwmon_device_register_with_info() register. So, do
> +	 * not need unregister it manually.
> +	 */
> +	struct nct7904_data *data = i2c_get_clientdata(client);
> +
> +	/* disable watchdog */
> +	if (!nowayout)
> +		nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);

Please use watchdog_stop_on_unregister().

> +
> +	watchdog_unregister_device(&data->wdt);
> +
> +	dev_info(&client->dev, "NCT7904 driver removed\n");
> +

Please no such noise.

> +	return 0;
>  }
>  
>  static const struct i2c_device_id nct7904_id[] = {
> @@ -1030,6 +1184,7 @@ static int nct7904_probe(struct i2c_client *client,
>  	.id_table = nct7904_id,
>  	.detect = nct7904_detect,
>  	.address_list = normal_i2c,
> +	.remove = nct7904_remove,
>  };
>  
>  module_i2c_driver(nct7904_driver);
> -- 
> 1.8.3.1
> 

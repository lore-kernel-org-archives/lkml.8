Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B3C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C529220776
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2y8NTr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgC3PcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:32:21 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36982 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3PcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:32:21 -0400
Received: by mail-pj1-f67.google.com with SMTP id o12so7492701pjs.2;
        Mon, 30 Mar 2020 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s90eZg+WweKgB83wmVOKof9bzIaX2B9IyDZDTed6HWA=;
        b=M2y8NTr9cgdR8AQoZ6z2xP9A9WinnnZbPHyA6GHqOr14e4L1+qa1wCKa08vVCuipk8
         LwL3I7vmvP6vPTQpd308AyvB0MWd2EJlu235+tpTBhHXLPCVYBTxlHSIKZQNeX+4til9
         +1sKCwHXvY+YWqeSGyVs+X7BvW0kcI12f12ZKkjoY36b6H6g9hOVGOkRMxE11gwsg8Si
         Z/bX+lkJWZd6mvjmaaF7N3FhpNTQQKdvz0QgXZhyCQ5Sw1MUx7LcOowF5qCvtouIIAmB
         Mzdp/k62+uWzAPUxOhX5wrvPZWIRwmgl9gfR0uUTfUZ0nOalwr15LQriZWBMoluIm/RF
         UKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s90eZg+WweKgB83wmVOKof9bzIaX2B9IyDZDTed6HWA=;
        b=VUIcUn8ge8dYkfhZCNRsVDVzKV+1wHsloT6vNTVRb8VCAcNz+C3votH6mIKZQCn3GD
         OX4lSCqmM1wTMk2001qso2JuUHoYbJcj2Xp8dMAVqEdLr0Zf0l3noL4sBF9MCp9p63G3
         ApfIQ7r0E0X4EV35E8iD8FOIPQ8R5+obPkUOfyzZiZAd06FeMRRKZX7iABXBqGq2L6ag
         Cv/3UA3jb3lAoLEl5AajAjDUBgga0hAWx5LXd/i1mLmURIpTBPjg70S9Tgj570h8Koe9
         dm2ja+d/eJxc2URMVZkQ8XGm71NjjpNBw5CIeaoC2mj7efayjWB2fpoZI8UwwipiaGuM
         GH1w==
X-Gm-Message-State: ANhLgQ36g2VZtWvsJvbJARuqsQmWfYrGIvkE8CE/7uO9X80v/SQb47pg
        G4N88g1q+wEifORSj94xOxY=
X-Google-Smtp-Source: ADFU+vuWNUNlYfJ1ZdZdtelzDfevKIwgkpDdtCAmGl1gGL6BhiYj99Cu3MshkRlMR93NIgu8tSDwxQ==
X-Received: by 2002:a17:90a:1503:: with SMTP id l3mr16050741pja.87.1585582339196;
        Mon, 30 Mar 2020 08:32:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q19sm7027163pgh.11.2020.03.30.08.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 08:32:18 -0700 (PDT)
Subject: Re: [v3,1/1] hwmon: (nct7904) Add watchdog function
To:     yuechao.zhao@advantech.com.cn, 345351830@qq.com
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, amy.shih@advantech.com.tw,
        oakley.ding@advantech.com.tw, jia.sui@advantech.com.cn,
        shengkui.leng@advantech.com.cn
References: <20200330095912.10827-1-yuechao.zhao@advantech.com.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <1cd1e048-71b2-b3e9-e22a-d0aae7129072@roeck-us.net>
Date:   Mon, 30 Mar 2020 08:32:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330095912.10827-1-yuechao.zhao@advantech.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 2:59 AM, yuechao.zhao@advantech.com.cn wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> implement watchdong functionality into the "hwmon/nct7904.c"
> 
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> ---
> v2:
> - Modify dependency of NC7904 into "drivers/hwmon/Kconfig".
> 
> v3:
> - Delete useless message(noise).
> - Delete useless variable 'ret'.
> - Delete 'ping_timeout'.
> - Use 'wdt->timeout' as basis for setting the chip timeout
> - Implement a get_timeout function
> - Use devm_watchdog_register_device() instead of watchdog_register_device().
> - Use watchdog_stop_on_unregister() when driver remove.
> - Delete nct7904_remove() function.
> - Fix typos. 
> ---
>  drivers/hwmon/Kconfig   |   6 ++-
>  drivers/hwmon/nct7904.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 135 insertions(+), 3 deletions(-)
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
> index 1f5743d..13ac880 100644
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
> @@ -87,18 +91,42 @@
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
> +
> +/*The timeout range is 1-255 minutes*/
> +#define MIN_TIMEOUT		(1 * 60)
> +#define MAX_TIMEOUT		(255 * 60)
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
> @@ -889,6 +917,87 @@ static int nct7904_detect(struct i2c_client *client,
>  	.info = nct7904_info,
>  };
>  
> +/*
> + * Watchdog Function
> + */
> +static int nct7904_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +
> +	/* Enable soft watchdog timer */
> +	return nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_EN);
> +}
> +
> +static int nct7904_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +
> +	return nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
> +}
> +
> +static int nct7904_wdt_set_timeout(struct watchdog_device *wdt,
> +				   unsigned int timeout)
> +{
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +
> +	wdt->timeout = timeout;

wdt->timeout needs to match the actual timeout selected.
For example, if the user configures a timeout of 119 seconds,
the actual timeout will be 60 seconds. wdt->timeout must then
be set to 60 seconds. So this needs to be
	wdt->timeout = timeout / 60 * 60;

> +
> +	return nct7904_write_reg(data, BANK_0, WDT_TIMER_REG,
> +				 wdt->timeout / 60);
> +}
> +
> +static int nct7904_wdt_ping(struct watchdog_device *wdt)
> +{
> +	/*
> +	 * Note:
> +	 * NCT7904 does not support refreshing WDT_TIMER_REG register when
> +	 * the watchdog is active. Please disable watchdog before feeding
> +	 * the watchdog and enable it again.
> +	 */
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +	int ret;
> +
> +	/* Disable soft watchdog timer */
> +	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* feed watchdog */
> +	ret = nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, wdt->timeout / 60);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable soft watchdog timer */
> +	return nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, WDT_SOFT_EN);
> +}
> +
> +static unsigned int nct7904_wdt_get_timeleft(struct watchdog_device *wdt)
> +{
> +	struct nct7904_data *data = watchdog_get_drvdata(wdt);
> +	int ret;
> +
> +	ret = nct7904_read_reg(data, BANK_0, WDT_TIMER_REG);
> +	if (ret < 0)
> +		return 0;
> +
> +	return (unsigned int)ret;

The returned value is the time left in minutes, thus
	return ret * 60;

The typecast is unnecessary.

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
> +	.get_timeleft	= nct7904_wdt_get_timeleft,
> +};
> +
>  static int nct7904_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1012,7 +1121,28 @@ static int nct7904_probe(struct i2c_client *client,
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
> +	data->wdt.min_timeout = MIN_TIMEOUT;
> +	data->wdt.max_timeout = MAX_TIMEOUT;
> +	data->wdt.parent = &client->dev;
> +
> +	watchdog_init_timeout(&data->wdt, timeout * 60, &client->dev);
> +	watchdog_set_nowayout(&data->wdt, nowayout);
> +	watchdog_set_drvdata(&data->wdt, data);
> +
> +	watchdog_stop_on_unregister(&data->wdt);
> +
> +	i2c_set_clientdata(client, data);

Unless I am missing something, this is not needed.

> +
> +	return devm_watchdog_register_device(dev, &data->wdt);
>  }
>  
>  static const struct i2c_device_id nct7904_id[] = {
> 


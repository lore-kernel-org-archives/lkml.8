Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EC0C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2D420848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpVx0TfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgCaPig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:38:36 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37933 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:38:35 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so1230808pje.3;
        Tue, 31 Mar 2020 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RuP8IPvlcqE2U71M0ePRKjlt8xs7un60IJP4O0uryZQ=;
        b=IpVx0TfQfbT7InUk9qBDR0CTSaCMN/LK0fdN2wwLeWw30JTQArEn6aUGd3BLBNnevU
         xKaFCmLw6DX9qFHVzH9YfVojMOQc+HVTexqbkArMbKNK0v7GE3PKjTdZbVDxZQogOD+P
         rh7mT4iJvOhDv4thB8S2Wy47A/OO7HUUPuKf+ovQjPK6iO03QV2dJY3jPhWrCHzlXpci
         rQoM7IP4BHbB82jMYyXibZT5zxlQreZ3AHZj5BNSvGCn9zkNpc75LekOq9VmhgV5Mw0Z
         +G6waTPwdfu7p3PKBT617osa6auHjtM9YTqyoHInxBohkU1YA/JT6PvTmU9LgNL+VHgh
         MZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuP8IPvlcqE2U71M0ePRKjlt8xs7un60IJP4O0uryZQ=;
        b=gquemZy614CQ9nVvQv3dWVe7W39PKUvtDxl+BOVCR8uVcuZVCs7Btb3Iuv9QijdaTj
         BqyHQt5G9L6KjcMLApQcFFKn3rx6EP8N7GlVsEATsIzls21YOZS5SfaDaTAi9sH+b5K0
         uOdsATdz82SWZHoPA2U70LYKVjTiyVksel64zhXfTfHmMA2aAgb1U78LTPkHmEUPTWpL
         HgBCr9oG4TIc4JPf0Ojuyax2L8skPenzXQ2zgAtZhGH9EMs9qjwgeq+sl7+rQaP3pyeQ
         5MrHD6pTLRGGE7fI+nowOW1LAOKRHbTg/dDqQbUAEwecHjhoqd3Ypwo+XbzCAEiK06x+
         nI4A==
X-Gm-Message-State: AGi0PuYMGP64Ee7yh6OzR9cOX7ZgEtFNAKG0TwQVwU+k9DiIdIEmvGw2
        ZC5Gocmb9MLbau7CIL6M+dOQk5co
X-Google-Smtp-Source: APiQypKdMIgPdLC6+OnkbvFsZxuqvqtBdZmt4WrOGgFdDSFsU7C0LfNkDzn3ccOdehgO+leudiNGzg==
X-Received: by 2002:a17:90b:23ce:: with SMTP id md14mr4614792pjb.147.1585669113728;
        Tue, 31 Mar 2020 08:38:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u21sm2252446pjy.8.2020.03.31.08.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 08:38:32 -0700 (PDT)
Date:   Tue, 31 Mar 2020 08:38:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     yuechao.zhao@advantech.com.cn
Cc:     345351830@qq.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        amy.shih@advantech.com.tw, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, shengkui.leng@advantech.com.cn
Subject: Re: [v4,1/1] hwmon: (nct7904) Add watchdog function
Message-ID: <20200331153831.GA186077@roeck-us.net>
References: <20200331052850.5419-1-yuechao.zhao@advantech.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331052850.5419-1-yuechao.zhao@advantech.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:28:50AM +0000, yuechao.zhao@advantech.com.cn wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> implement watchdong functionality into the "hwmon/nct7904.c"

s/watchdong/watchdog/

No need to resend; I fixed it up.

> 
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v4:
> - Set "wdt->timeout" to actual timeout
> - Modify nct7904_wdt_get_timeleft return value
> - Remove code 'i2c_set_clientdata(client, data)'
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
> 
> v2:
> - Modify dependency of NC7904 into "drivers/hwmon/Kconfig".
> ---
>  drivers/hwmon/Kconfig   |   6 ++-
>  drivers/hwmon/nct7904.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 141 insertions(+), 3 deletions(-)
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
> index 1f5743d..571a649 100644
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
> @@ -889,6 +917,95 @@ static int nct7904_detect(struct i2c_client *client,
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
> +	/*
> +	 * The NCT7904 is very special in watchdog function.
> +	 * Its minimum unit is minutes. And wdt->timeout needs
> +	 * to match the actual timeout selected. So, this needs
> +	 * to be: wdt->timeout = timeout / 60 * 60.
> +	 * For example, if the user configures a timeout of
> +	 * 119 seconds, the actual timeout will be 60 seconds.
> +	 * So, wdt->timeout must then be set to 60 seconds.
> +	 */
> +	wdt->timeout = timeout / 60 * 60;
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
> +	return ret * 60;
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
> @@ -1012,7 +1129,26 @@ static int nct7904_probe(struct i2c_client *client,
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
> +	return devm_watchdog_register_device(dev, &data->wdt);
>  }
>  
>  static const struct i2c_device_id nct7904_id[] = {

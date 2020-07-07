Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79673C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5514820771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1qEte5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGNfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgGGNfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:35:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492F7C061755;
        Tue,  7 Jul 2020 06:35:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so8186613pfh.0;
        Tue, 07 Jul 2020 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rba0+/EuRhhUcr8Ye+cdIuQHVXXU4BWfVIEg0RcA/xA=;
        b=Y1qEte5JG5fzV82+gBU9bc3hrKeZorMmLDq7pEgrLd9mme+lzJZRhmMXNSj6EUzeLv
         yEYtaQdLrr0wFR+jTu15NwGhcx2CiPY4BgoQiOJTURPSXXS6SbTlr+WmYg6tcOFYtNsD
         y3nDJIm2kEtlFDyX/BFxxj4s/Ed14puOliFKtIwAjQHNb6o5tq4FLUyWRXSEasMAltEO
         slgPy92HZjtZmjsrL/VX6LtMCT3zWe451iaL9OjXP/fx2xDbnpqfVveRk1h1ajom75+a
         VVBV4PokEhSMLHS3JXKMVZThCOJPXtYTK3bDn+d0LjTrCGpy4da0GKakVwWFAld3HQW6
         rj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=rba0+/EuRhhUcr8Ye+cdIuQHVXXU4BWfVIEg0RcA/xA=;
        b=XuzSL0mjynQdBUuI0ijIwJan8gLUQ9rREZc1E8HVsCmE0AcAnk85ddULZIui+2VWyj
         SNKrf4t9Kz9CLz81X1BkfdNruqW7AAvgHUApoRa5I4ejFva8nSBPd4XsJKrMUf3k22GV
         HPl+0M6tObtYuDioZPIt5WAQDuFHhqUj0DAWK5INzEwH4LJIBJIF6bBx94baxJ8FmPpl
         uXe9kWA8jDmGJqiA1MO/NlIN63sytJfAfHmcG338Bm+bFWfIbNjsHoZwSKpqNUiwqJX3
         7lbm2cDZToFqwaRZIvObH/kpv4ddV0+6HZ+jb5mp8i0Jyc8dizjMnZfj1luq13Tqts42
         Qv3A==
X-Gm-Message-State: AOAM533jKJA3/1ICgMr366Cq+tuSeAgYvLx4LSsskbPz/J2J1s/mWaKc
        giA7lWJ3gEP06VzXmakE/NQ1RyI/3yU=
X-Google-Smtp-Source: ABdhPJw0dQGABhNhgS80LTpC36GJ6Ye3Td8BkZvAzetm7euWK+rnJ6CMWQmgTZfVScLrVdkJ3vZcRA==
X-Received: by 2002:a62:2641:: with SMTP id m62mr19970062pfm.263.1594128939869;
        Tue, 07 Jul 2020 06:35:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10sm1019289pgp.47.2020.07.07.06.35.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 06:35:39 -0700 (PDT)
Date:   Tue, 7 Jul 2020 06:35:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: shtc1: add support for device tree bindings
Message-ID: <20200707133538.GA217605@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:01:02PM +0800, Chris Ruehl wrote:
> Add support for DTS bindings for the sensirion shtc1,shtw1 and shtc3.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Waiting for feedback/approval from DT maintainers.

Thanks,
Guenter

> ---
>  drivers/hwmon/shtc1.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
> index a0078ccede03..827d421b2b8f 100644
> --- a/drivers/hwmon/shtc1.c
> +++ b/drivers/hwmon/shtc1.c
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/platform_data/shtc1.h>
> +#include <linux/of.h>
>  
>  /* commands (high precision mode) */
>  static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
> @@ -196,6 +197,7 @@ static int shtc1_probe(struct i2c_client *client,
>  	enum shtcx_chips chip = id->driver_data;
>  	struct i2c_adapter *adap = client->adapter;
>  	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
>  
>  	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
>  		dev_err(dev, "plain i2c transactions not supported\n");
> @@ -233,8 +235,14 @@ static int shtc1_probe(struct i2c_client *client,
>  	data->client = client;
>  	data->chip = chip;
>  
> -	if (client->dev.platform_data)
> -		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
> +	if (np) {
> +		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking_io");
> +		data->setup.high_precision = !of_property_read_bool(np, "sensicon,low_precision");
> +	} else {
> +		if (client->dev.platform_data)
> +			data->setup = *(struct shtc1_platform_data *)dev->platform_data;
> +	}
> +
>  	shtc1_select_command(data);
>  	mutex_init(&data->update_lock);
>  
> @@ -257,8 +265,19 @@ static const struct i2c_device_id shtc1_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, shtc1_id);
>  
> +static const struct of_device_id shtc1_of_match[] = {
> +	{ .compatible = "sensirion,shtc1" },
> +	{ .compatible = "sensirion,shtw1" },
> +	{ .compatible = "sensirion,shtc3" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, shtc1_of_match);
> +
>  static struct i2c_driver shtc1_i2c_driver = {
> -	.driver.name  = "shtc1",
> +	.driver = {
> +		.name = "shtc1",
> +		.of_match_table = shtc1_of_match,
> +	},
>  	.probe        = shtc1_probe,
>  	.id_table     = shtc1_id,
>  };
> -- 
> 2.20.1
> 

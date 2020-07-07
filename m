Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA06C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3462053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxLfwtp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGGDx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGGDx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:53:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6F6C061755;
        Mon,  6 Jul 2020 20:53:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so3527986pjq.5;
        Mon, 06 Jul 2020 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqpSOjTQuG5ymSzOUk0oJSbSIqIGYeuMo1AwRtryaSo=;
        b=GxLfwtp8fc89kG3kTSi8OQO3CgvkVIBCvZMSP0JWgxAI6L2f7ByJM4Inbb0wQVPr+C
         SU2+ABf7oOAtx/E+W1Cg2grVfXHx2VGjm8lZw49+Meg/bycrC3AbtggpQx6gUPRQOmZ7
         EFNG8VcFa65rhqCHgO+lsXTvmIxJ1BhmT3ZKhndr27QqZijOVyFVxUInDIgC+2DaokoO
         dRg8A8N0XCS/m0+Fna+Ua+V83ki7CnTqZ9cYMkM63HwVqzqYIZfSgfLLv7cdRFNvmuji
         7rCrQjTf+6lF7LGblw+Y5HtsTGzlJzK0HRLZnsdlWB9pfpN+iyhP3oC+6A/IaE4G3mhf
         FDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqpSOjTQuG5ymSzOUk0oJSbSIqIGYeuMo1AwRtryaSo=;
        b=Sl2PXMS8+byYNUCw/dCfTK7I5l7DOQv+LwoQjUULHzHs2h8hRo42ROFd/d7X+61PiG
         dLYRHxW/0rgMPTfjho11w66eSERxZ3ZUkg8PC0TwpslwcUKPs+oeVW1On9JVTxRlhm0l
         VqxXxt4wdqF67TREHOOZhudvmgU2rkCLwavp1JIk+ejGqacmZwXFoZ4XMaJGrB1V6QDH
         4Wrtn9CTNAxc+m3Blf40g5TFvKA2M4B70828V3Qqdl8wbefCtbGo9U+aZtySzzr8Cuck
         PMrBpQnAQQtrFs+BagpIcbeffYw9lrUTjySweg/T0kK+qlhzv+17ceyw2sRSKJhmeezL
         3xpQ==
X-Gm-Message-State: AOAM5313mcvoObQePN/nVcS+SYiZCPGU6gSjxQtqDH/gpDcv2puZ9Ldp
        z5GYxJIXzfZFBqhqTxB4RUY=
X-Google-Smtp-Source: ABdhPJyywd+pfOapQUulsD5T/A6ysUBh2Xg10xFydCzg3m9sVazu7t8QGhlgTJKABVj4iJW6HkAUdg==
X-Received: by 2002:a17:90a:26c6:: with SMTP id m64mr2196779pje.215.1594094008064;
        Mon, 06 Jul 2020 20:53:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ia13sm841874pjb.42.2020.07.06.20.53.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 20:53:27 -0700 (PDT)
Date:   Mon, 6 Jul 2020 20:53:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: shtc1: add support for device tree bindings
Message-ID: <20200707035326.GA212456@roeck-us.net>
References: <20200705034727.1429-1-chris.ruehl@gtsys.com.hk>
 <20200705034727.1429-2-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705034727.1429-2-chris.ruehl@gtsys.com.hk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 11:47:25AM +0800, Chris Ruehl wrote:
> Add support for DTS bindings for the sensirion shtc1,shtw1 and shtc3.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/hwmon/shtc1.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
> index a0078ccede03..61e9275eb666 100644
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
> @@ -233,8 +235,13 @@ static int shtc1_probe(struct i2c_client *client,
>  	data->client = client;
>  	data->chip = chip;
>  
> -	if (client->dev.platform_data)
> +	if (np) {
> +		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking_io");
> +		data->setup.high_precision = of_property_read_bool(np, "sensicon,low_precision");

Just noticed. Presumably that would have to be:

		data->setup.high_precision = !of_property_read_bool(np, "sensicon,low_precision");

> +	}
> +	else if (client->dev.platform_data)
>  		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
> +
>  	shtc1_select_command(data);
>  	mutex_init(&data->update_lock);
>  
> @@ -257,8 +264,19 @@ static const struct i2c_device_id shtc1_id[] = {
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

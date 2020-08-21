Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B870EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF5C20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNmJIDej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHUSjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHUSjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:39:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB0C061575;
        Fri, 21 Aug 2020 11:39:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so1407464pgl.3;
        Fri, 21 Aug 2020 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Wed+2KJiJXbDusUkvqx9osbk9K/bLB8+KZ5CEx8UTo=;
        b=iNmJIDej7pY5YB0Gkj2suBA3Jwl9t7ZD0OZiL9fSPDX24XiLDEM0e95Wyn/8DSpqfX
         zz7BjmOcvExJ8GwToRQ/le6hkexWWAnQqw8uvs2UDOBYyFUzEqPLT1AL1ErNxKqezEoe
         LLm8hIFrN0NhqhkQOC/F2g0+GXhFbFfZnlkkTZzfYmnclUc2eJ1v2U9xTMLMViGVtm1j
         RzF/tQwAqQhmBA4hQPqDgSH8gDK4RCI6dgEHI4JnH4guOiQEJ8U0kBA7K7xWwkVKY+zv
         J52bpXUFixeHW5YG3B/Kb+ctBXeZArUrQO/f4pOdcUVCRpdMrYrt8pDfUw9heiB5BVLr
         BaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Wed+2KJiJXbDusUkvqx9osbk9K/bLB8+KZ5CEx8UTo=;
        b=aRzdelHFp3ZyUcgW35z9YCJfaPywJAlaEOFRIh7PSUfDohZ2jhBBvg0NnVCDokpjy+
         2H8oLLM+AOVkg7Y0jp2x8R4OFp/yclqQL6lp1yYzaCPZWxVVO8IrwMzAOM6y35cttUL4
         WTL80AVHkxpLpWwXhTT1ydh760ynu9YonoGaV1P2vU3Xy2kkLgffYWFX8EXmB0fsBj4u
         umoC3Om3Cy5gUxoCAOqHIAMh57OXSlfXGEreJCut8P0UcyhHcYTa8f8qMo5fZHOEXaoL
         TMQ0aGyftW6sA04BSMZ5w1a9CetmYS3MvPgQxfVNcZBm+SM9zfDESGPKkAs3P83RD11A
         eP1A==
X-Gm-Message-State: AOAM53306pQcr8+TnLlgML8lYmnPk6xndgKnh+cyWH3DxHFqASG56n0T
        DNTOc8/IINt+n8UC/AzJKV3gmOp+FUM=
X-Google-Smtp-Source: ABdhPJwC0gExCDD5JxS1RpIHUTpceynmzw1eAoWQwOyTleiFyrZ/PfXx94gZCIzS9MB/9eaST4SHRg==
X-Received: by 2002:a63:4557:: with SMTP id u23mr3120859pgk.197.1598035173716;
        Fri, 21 Aug 2020 11:39:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h193sm2843300pgc.42.2020.08.21.11.39.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:39:33 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:39:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] hwmon: shtc1: add support for device tree bindings
Message-ID: <20200821183931.GA245345@roeck-us.net>
References: <20200815012227.32538-1-chris.ruehl@gtsys.com.hk>
 <20200815012227.32538-2-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815012227.32538-2-chris.ruehl@gtsys.com.hk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 09:22:26AM +0800, Chris Ruehl wrote:
> Add support for DTS bindings for the sensirion shtc1,shtw1 and shtc3.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ---
>  v8: no change
> 
>  drivers/hwmon/shtc1.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
> index a0078ccede03..7993a5ff8768 100644
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
> +		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking-io");
> +		data->setup.high_precision = !of_property_read_bool(np, "sensicon,low-precision");
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

Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27462C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BEE20771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAQ3NNZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGCFsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCFsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:48:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03690C08C5C1;
        Thu,  2 Jul 2020 22:48:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x3so7997095pfo.9;
        Thu, 02 Jul 2020 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xggNeQQkKQTMcykW7pls8KqjnSbZo3eU0HBpywIP0Oo=;
        b=iAQ3NNZtzHZJsUVnV6xvw5rLLHcrLPrpLBNSnPFDcHccUhrpy+2bn/nL/1C99XUGBw
         g/Xvrp5XV20/VkAQqpTRZ1rDvJIu/F37GSBn2iAcrrOPjoo2a2Xhz2RInBOXPqwdgP51
         JgCuvqvFzaTwR8JUN/erwRBYJlTIPehQFPBc8unMMtB+iBEZfvrxnQmbw18EJ7PhNeFc
         eA+FDyG2d6+HNFg9YVksLXC2tsqe36/1ykDGqLvGl+2ldmeiDGCsoD1hGvOWVJnQUXcG
         s80uM7X9CJL/lj8sHL4COK3YT0EmYelEsIsjSWch2vTvfM4xoMzZKd1yOG49biZNxk96
         /UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xggNeQQkKQTMcykW7pls8KqjnSbZo3eU0HBpywIP0Oo=;
        b=Fzw880kZfQH3bWMSrX9aRM1ictbHPEk54+YtRAv6zzubB4N1V1zrfXzzaamXbN5gx4
         ZZJrRRz+ojOdjh+o8vwBfKBkzg6AGQljCfsiAd1p6AD4ay0I1lhPDDsHPM0FIeW/NeT6
         seI4BfautgrX7cfepR9YTE1YxV0OlEWbvgF0nOp02R2n96Iu+6Otgtc2N+Prya3BXDv5
         L6RuS4zubV8ucI//kaBQ38NwScKaZggUf+CKEwI+VMYu0ZgGUlFriBeTlwWc+Xx8inQ6
         jb2H9HSPP9ylYIo76MqKXdvZ4Ngt5gNvpUIryw1Ls8DGAZcX8gq4b/UbZwCgtqQ4inPg
         Px3g==
X-Gm-Message-State: AOAM533okHX4JFM4+nVZuLb37Ni3Webcpc/YMtsZ2BaGrIrcY3O5nDRj
        AthUghkwO3dmSjt0PuUMghKgnL/iLdo=
X-Google-Smtp-Source: ABdhPJxandp0SqaiKJ6v16u8uYdHi68WYcJyPtjvXPax47gf97Oxdgr7/9JgzXuNTBFd3HF4/BMwog==
X-Received: by 2002:a63:fc59:: with SMTP id r25mr4650294pgk.336.1593755332242;
        Thu, 02 Jul 2020 22:48:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14sm10197381pgk.86.2020.07.02.22.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 22:48:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: shtc1: add support for device tree bindings
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200703034856.12846-1-chris.ruehl@gtsys.com.hk>
 <20200703034856.12846-2-chris.ruehl@gtsys.com.hk>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <94043e67-1899-8e80-064c-50489cf7e4b2@roeck-us.net>
Date:   Thu, 2 Jul 2020 22:48:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703034856.12846-2-chris.ruehl@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 8:48 PM, Chris Ruehl wrote:
> Add support for DTS bindings to the shtc driver, use CONFIG_OF
> to compile in the code if needed.
> 

Ah, here it is. The introducing patch should say something like "[PATCH 0/2]".

> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/hwmon/shtc1.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
> index a0078ccede03..3bcabc1cbce8 100644
> --- a/drivers/hwmon/shtc1.c
> +++ b/drivers/hwmon/shtc1.c
> @@ -14,6 +14,9 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/platform_data/shtc1.h>
> +#ifdef CONFIG_OF

No. Please no conditional includes.

> +#include <linux/of.h>
> +#endif
>  
>  /* commands (high precision mode) */
>  static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
> @@ -196,6 +199,10 @@ static int shtc1_probe(struct i2c_client *client,
>  	enum shtcx_chips chip = id->driver_data;
>  	struct i2c_adapter *adap = client->adapter;
>  	struct device *dev = &client->dev;
> +#ifdef CONFIG_OF
> +	struct device_node *np = dev->of_node;
> +	u8 value;
> +#endif
>  
>  	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
>  		dev_err(dev, "plain i2c transactions not supported\n");
> @@ -235,6 +242,20 @@ static int shtc1_probe(struct i2c_client *client,
>  
>  	if (client->dev.platform_data)
>  		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
> +
> +#ifdef CONFIG_OF

Unnecessary ifdef. Selection of devicetree data or not can be made
based on np != NULL. Also, if devictree data is available, platform
data should be ignored to avoid confusion.

> +	if (np) {
> +		if (of_property_read_bool(np, "sensirion,blocking_io")) {
> +			of_property_read_u8(np, "sensirion,blocking_io", &value);
> +			data->setup.blocking_io = (value > 0) ? true : false;
> +		}
Why this complexity, and why not just make the property a boolean ?

> +		if (of_property_read_bool(np, "sensicon,high_precision")) {
> +			of_property_read_u8(np, "sensirion,high_precision", &value);
> +			data->setup.high_precision = (value > 0) ? true : false;

"sensicon,high_precision" should also be a boolean.

> +		}
> +	}
> +#endif
> +
>  	shtc1_select_command(data);
>  	mutex_init(&data->update_lock);
>  
> @@ -257,6 +278,15 @@ static const struct i2c_device_id shtc1_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, shtc1_id);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id shtc1_of_match[] = {
> +	{ .compatible = "sensirion,shtc1" },
> +	{ .compatible = "sensirion,shtw1" },
> +	{ .compatible = "sensirion,shtc3" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, shtc1_of_match);
> +#endif
>  static struct i2c_driver shtc1_i2c_driver = {
>  	.driver.name  = "shtc1",
>  	.probe        = shtc1_probe,
> 
Not sure how this works without setting of_match_table. I guess it just works
accidentally because .id_table also provides a devicetree match. Still,
of_match_table should be set.

Guenter


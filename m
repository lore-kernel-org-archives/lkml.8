Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC8C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C05C2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8IIZE34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgAXE4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:56:03 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52690 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgAXE4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:56:02 -0500
Received: by mail-pj1-f68.google.com with SMTP id a6so492379pjh.2;
        Thu, 23 Jan 2020 20:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HfqVz/MdooTXU0NNZcyHQMGb/c7xUmQ2Qp5V87UvDjs=;
        b=G8IIZE34k3YFkJMiYrAJf0jZzmGvUuiDgm79WGoSHK98upyKy4VV5D9i/GoaCIFjp+
         M4MKkgaFWIHO/Rg6wA+Ug2zkTrwHNGQ5FagS7GcOpKRhvIEt02HHeKZzBe99elgHc+Mb
         8oPMT3Rr8DF7FOyHlgxNQw06+FCldQqJirttMo09lzKQF0GB9g0luCBiQ2DT2KYqOcj2
         65oWiha41nXOxKvVBOMYNSy5IAXNYsvkXg+s1QPG8F16PmgKgcjHNl+wgQbyqI2zM8Bb
         CGfxW/hJrqy5WL7hz8A1klPZmLwbxNI+88pAUsW6aV8rm0do28LjQKYQf+Y2X8nOhhlP
         cfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HfqVz/MdooTXU0NNZcyHQMGb/c7xUmQ2Qp5V87UvDjs=;
        b=gzKWfs3Jp8z76dkk5SagT0tZCEUgGTvc+oxEwYhMJm2hOCMCDT6u4pNKVeDnjWDbxH
         obIM7IfaufkKezYPaVXTONVWrn9EOXrEZE3milgYPkTCYoIYUTqTjw6m6H2MPjp1tQHm
         Kq8DeJFJAbhEQlokisioPu2Wi+l0yiuQ1HSoZ+kZbq/2UQRE1SlRiK4RbtaB0GOYM7Wy
         jqJlSyqp6Ph0YFDCg9Urz5rXOxiXvJmn1L2OPtMIMdKt1gEktZBU0Fxv7nB/J0KNLb0M
         QT5SqxEb7UEt4k5YI6o/YMbR9SpNs7CIPvQxPOwm4YXF+JW7bFuJsz2VbuzxV9DpQ5Cw
         8X2A==
X-Gm-Message-State: APjAAAUzPA1+y1lTfvZ0DoMEFS7HJIZDmTmx8PrgJKImY3QW5yETn6bx
        1b3TBMi7zCUSozcHXZpv3rQ=
X-Google-Smtp-Source: APXvYqwWTQ80PO5xCV96BsrT7k5vaE0WQkxGov0WfkaTAi271H9ZeAKDX+NoLbYYDJ8I37rpcUcpXA==
X-Received: by 2002:a17:902:fe0d:: with SMTP id g13mr1722494plj.124.1579841761640;
        Thu, 23 Jan 2020 20:56:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e19sm2865155pgn.86.2020.01.23.20.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 20:56:00 -0800 (PST)
Subject: Re: [PATCH v5 1/2] hwmon: (adt7475) Added attenuator bypass support
To:     Logan Shaw <logan.shaw@alliedtelesis.co.nz>, jdelvare@suse.com,
        robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz
References: <20200123220533.2228-1-logan.shaw@alliedtelesis.co.nz>
 <20200123220533.2228-2-logan.shaw@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d8d1e0db-6e2d-8523-923a-df6c6dca0e89@roeck-us.net>
Date:   Thu, 23 Jan 2020 20:55:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123220533.2228-2-logan.shaw@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/20 2:05 PM, Logan Shaw wrote:
> Added support for reading DTS properties to set attenuators on
> device probe for the ADT7473, ADT7475, ADT7476, and ADT7490.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> ---
> ---
>   drivers/hwmon/adt7475.c | 68 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6c64d50c9aae..8afc5a89ec92 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -19,6 +19,7 @@
>   #include <linux/hwmon-vid.h>
>   #include <linux/err.h>
>   #include <linux/jiffies.h>
> +#include <linux/of.h>
>   #include <linux/util_macros.h>
>   
>   /* Indexes for the sysfs hooks */
> @@ -1457,6 +1458,70 @@ static int adt7475_update_limits(struct i2c_client *client)
>   	return 0;
>   }
>   
> +/**

I am still at loss why you think it would make sense to mark those
comments for the kernel documentation. This doesn't have value outside
this driver.

> + * Sets or clears the given bit in the config depending on the value of the
> + * given dts property. Non-zero value sets, zero value clears. No change if
> + * the property is absent.
> + */
> +static void modify_config(const struct i2c_client *client, char *property,
> +				u8 *config, u8 bit_index)
> +{
> +	u32 prop_value = 0;
> +	int ret = of_property_read_u32(client->dev.of_node, property,
> +					&prop_value);
> +
> +	if (!ret) {
> +		if (prop_value)
> +			*config |= (1 << bit_index);
> +		else
> +			*config &= ~(1 << bit_index);
> +	}
> +}
> +
> +/**
> + * Configures the attenuator bypasses for voltage inputs, depening on
> + * properties in the dts.
> +.*
> + * The adt7473 and adt7475 only support bypassing in1.
> + *
> + * Returns a negative error code if there was an error writing to the register.
> + */
> +static int load_attenuators(const struct i2c_client *client, int chip,
> +				u8 *config2, u8 *config4)
> +{
> +	u8 conf_copy;
> +	int ret = 0;

Unnecessary assignment.

> +
> +	if (chip == adt7476 || chip == adt7490) {
> +		conf_copy = *config4;
> +
> +		modify_config(client, "bypass-attenuator-in0", &conf_copy, 4);
> +		modify_config(client, "bypass-attenuator-in1", &conf_copy, 5);
> +		modify_config(client, "bypass-attenuator-in3", &conf_copy, 6);
> +		modify_config(client, "bypass-attenuator-in4", &conf_copy, 7);
> +
> +		ret = i2c_smbus_write_byte_data(client, REG_CONFIG4,
> +			conf_copy);
> +		if (ret < 0)
> +			return ret;
> +
> +		*config4 = conf_copy;
> +	} else if (chip == adt7473 || chip == adt7475) {
> +		conf_copy = *config2;
> +
> +		modify_config(client, "bypass-attenuator-in1", &conf_copy, 5);
> +
> +		ret = i2c_smbus_write_byte_data(client, REG_CONFIG2,
> +			conf_copy);
> +		if (ret < 0)
> +			return ret;
> +
> +		*config2 = conf_copy;
> +	}
> +
> +	return 0;
> +}
> +
>   static int adt7475_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
> @@ -1546,6 +1611,9 @@ static int adt7475_probe(struct i2c_client *client,
>   
>   	/* Voltage attenuators can be bypassed, globally or individually */
>   	config2 = adt7475_read(REG_CONFIG2);
> +	if (load_attenuators(client, chip, &config2, &(data->config4)) < 0)
> +		dev_warn(&client->dev, "Error setting bypass attenuators\n");
> +
>   	if (config2 & CONFIG2_ATTN) {
>   		data->bypass_attn = (0x3 << 3) | 0x3;
>   	} else {
> 
CHECK: Alignment should match open parenthesis
#45: FILE: drivers/hwmon/adt7475.c:1467:
+static void modify_config(const struct i2c_client *client, char *property,
+				u8 *config, u8 bit_index)

CHECK: Alignment should match open parenthesis
#68: FILE: drivers/hwmon/adt7475.c:1490:
+static int load_attenuators(const struct i2c_client *client, int chip,
+				u8 *config2, u8 *config4)

CHECK: Alignment should match open parenthesis
#82: FILE: drivers/hwmon/adt7475.c:1504:
+		ret = i2c_smbus_write_byte_data(client, REG_CONFIG4,
+			conf_copy);

CHECK: Alignment should match open parenthesis
#93: FILE: drivers/hwmon/adt7475.c:1515:
+		ret = i2c_smbus_write_byte_data(client, REG_CONFIG2,
+			conf_copy);

CHECK: Unnecessary parentheses around data->config4
#110: FILE: drivers/hwmon/adt7475.c:1614:
+	if (load_attenuators(client, chip, &config2, &(data->config4)) < 0)

None of those is beneficial. Please fix.

Thanks,
Guenter


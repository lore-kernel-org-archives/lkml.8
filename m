Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B237C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578E221734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONmdKs9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAVPD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:03:59 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52627 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:03:59 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so1635pjh.2;
        Wed, 22 Jan 2020 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=honzR1UFYcS5KDzHuxhgOGMS3nFjZMwaX7yvDQgux5I=;
        b=ONmdKs9BqADGWbE9asU8kLdt+kDIKlUDgJzFNmct4VuHHY+Jmsi7/TyEbBM+f0YxAs
         S1FV/tuRjZO0Kgf6mael0xqtN2n7b6xjuu/41D8RY3zB5Pr1WMsI5AjGeQDspr6FJPlE
         XaiEFx7k7IEY4+xDe1SmwMdBCjMZMG7zf439qOTccPOOl4FTmATRggdX7mfrlEVU3tdd
         E4n7saSRtjbo2xxG1UQqldK/MVfJMbjb6FbyGnVmVngMouO/fhe90TtlQPMntQeaPw2F
         6wJ66n5f3hDsBFUitDytL1OatmkafyL+v5O3YPg02vfMlVY2agHfN40Q+jlynaGE6g9y
         baug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=honzR1UFYcS5KDzHuxhgOGMS3nFjZMwaX7yvDQgux5I=;
        b=aUvz/HaiyzVkZPuGNOP5rh6kXKLFbRCoppEeiyN7vanv+smQ3vnNVjcOIJkBhbRn29
         ymKcAjCToef9Hlg7Bamne6HjNuWCcr1oCBpjo0bf0NQqOv9Q2s6TPkLYJuR/yMB2gCQy
         awGXoNAYG3i5NYDZ1SbWQBA2zHleDevpY0DinyRTQUhY12kvIyrv8B+5ndvLj4jmsRe/
         BbHlaNV1QLFQqLQBxVMbnwBk903EqX0DqEFwSvUpJov127EYG+WybMOY1GhXNkZjvq1R
         +V6wA0ND2bbyDqPnSjJNTMYvcgTXOUzuMTQlCkBIWIsOHajKLQDmw9zBI9mtAa9RiIC2
         NOWw==
X-Gm-Message-State: APjAAAUxEabtNPERHIRTy2Y/tfGpaBs1oiaewGk1/5xiTmbPzpKekeXS
        pAhq+UUdLm3riGZdDeYZWc0Hkhlg
X-Google-Smtp-Source: APXvYqxBdRKT3fansVhN9CRONYZuCImJK0uGVCTlqdj1qZmwZ5JVUdobcmoXlUDM0gWs7vAHeJ2pHQ==
X-Received: by 2002:a17:90a:c708:: with SMTP id o8mr3636388pjt.104.1579705438079;
        Wed, 22 Jan 2020 07:03:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q64sm4171922pjb.1.2020.01.22.07.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 07:03:57 -0800 (PST)
Subject: Re: [PATCH v4 1/2] hwmon: (adt7475) Added attenuator bypass support
To:     Logan Shaw <logan.shaw@alliedtelesis.co.nz>, jdelvare@suse.com,
        robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz
References: <20200120001703.9927-1-logan.shaw@alliedtelesis.co.nz>
 <20200120001703.9927-2-logan.shaw@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <09750637-1b1c-9bf0-2a52-5dfd77fb3450@roeck-us.net>
Date:   Wed, 22 Jan 2020 07:03:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120001703.9927-2-logan.shaw@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/20 4:17 PM, Logan Shaw wrote:
> Added support for reading DTS properties to set attenuators on
> device probe for the ADT7473, ADT7475, ADT7476, and ADT7490.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> ---
> ---
>   drivers/hwmon/adt7475.c | 76 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6c64d50c9aae..2bb787acb363 100644
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
> @@ -1457,6 +1458,76 @@ static int adt7475_update_limits(struct i2c_client *client)
>   	return 0;
>   }
>   
> +/**

I don't see the point of adding this private comment into the documentation.

> + * Attempts to read a u32 property from the DTS, if there is no error and
> + * the properties value is zero then the bit given by parameter bit_index
> + * is cleared in the parameter config. If the value is non-zero then the bit
> + * is set.
> + *
> + * If reading the dts property returned an error code then it is returned and
> + * the config parameter is not modified.
> + */
> +static int modify_config_from_dts_prop(const struct i2c_client *client,
> +								char *dts_property, u8 *config, u8 bit_index) {

Alignment is far off. Please run "checkpatch --strict" and fix all problems
it reports.

total: 6 errors, 12 warnings, 9 checks, 94 lines checked

is a bit much.

modify_config_from_dts_prop and dts_property are unnecessary long and result
in multi-line code. Please use shorter function/parameter names.

> +	u32 is_attenuator_bypassed = 0;
> +	int ret = of_property_read_u32(client->dev.of_node, dts_property,
> +									&is_attenuator_bypassed);
> +
> +	if (! ret) {
> +			if (is_attenuator_bypassed)
> +		*config |= (1 << bit_index);
> +	else
> +		*config &= ~(1 << bit_index);
> +	}
> +
> +	return ret;

This return value is never used. Please drop it.

> +}
> +
> +/**
> + * Reads all individual voltage input bypass attenuator properties from the
> + * DTS, and if the property is present the corresponding bit is set in the
> + * register.
> +
> + * Properties are in the form of "bypass-attenuator-inx", where x is an
> + * integer from the set {0, 1, 3, 4} (can not bypass in2 attenuator).
> +.*
> + * The adt7473 and adt7475 only support bypassing in1.
> + *
> + * Returns a negative error code if there was an error writing to the register.
> + */
> +static int load_all_bypass_attenuators(const struct i2c_client *client,
> +					      int chip, u8 *config2, u8 *config4)
> +{
> +	u8 config2_copy = *config2;
> +	u8 config4_copy = *config4;
> +
Two "copy" variables are unnecessary, as only one is ever used.

> +	if (chip == adt7476 || chip == adt7490) {
> +		modify_config_from_dts_prop(client, "bypass-attenuator-in0",
> +									&config4_copy, 4);
> +		modify_config_from_dts_prop(client, "bypass-attenuator-in1",
> +									&config4_copy, 5);
> +		modify_config_from_dts_prop(client, "bypass-attenuator-in3",
> +									&config4_copy, 6);
> +		modify_config_from_dts_prop(client, "bypass-attenuator-in4",
> +									&config4_copy, 7);
> +
> +		if (i2c_smbus_write_byte_data(client, REG_CONFIG4, config4_copy) < 0)
> +			return -EREMOTEIO;
> +
> +		*config4 = config4_copy;
> +	} else if (chip == adt7473 || chip == adt7475) {
> +		modify_config_from_dts_prop(client, "bypass-attenuator-in1",
> +									&config2_copy, 5);
> +
> +		if (i2c_smbus_write_byte_data(client, REG_CONFIG2, config2_copy) < 0)
> +			return -EREMOTEIO;

Please do not override error codes.

> +
> +		*config2 = config2_copy;
> +	}
> +
> +	return 0;
> +}
> +
>   static int adt7475_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
> @@ -1546,6 +1617,11 @@ static int adt7475_probe(struct i2c_client *client,
>   
>   	/* Voltage attenuators can be bypassed, globally or individually */
>   	config2 = adt7475_read(REG_CONFIG2);
> +	if (load_all_bypass_attenuators(client, chip,
> +						&config2, &(data->config4)) < 0)
> +		dev_warn(&client->dev,
> +			 "Error setting bypass attenuator bits\n");
> +
>   	if (config2 & CONFIG2_ATTN) {
>   		data->bypass_attn = (0x3 << 3) | 0x3;
>   	} else {
> 


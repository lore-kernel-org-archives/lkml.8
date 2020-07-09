Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51964C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2815320739
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i44fmG+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGIAd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGIAd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 20:33:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73DC061A0B;
        Wed,  8 Jul 2020 17:33:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so96920pll.3;
        Wed, 08 Jul 2020 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GTTUBcRAq7maBJE6Xq/2iqskDvrNZ73+l5asKTOZeVo=;
        b=i44fmG+LKHaClGar/PRZiIFvxGOX74nGMzAzsXoQ+LVZHTiOkka1a1saRDJUqqCCwf
         0yJn/7vo0HkebD8Lqrd35abZ8TNGc7T5YfrocqKwpNsMKAbIllDLBhUscExEHPZPTaAB
         0mU0saBBAVn0s4aF3ObCVlhc0Fm4WyIeB3KKKcOylY6UkL910RE9YrjEHdKImPFwLOtQ
         SAjFEHbt/wJwUFoUCRVDsDlGLVrsEgzwKTPQmVh19XNkhx7wf8Tu9dvtKMDQhQUc7Y3C
         qCyxa0xt2Kc0Ttc7k57gH2BW038Fvyfqbd3ai46WeMomjcAMhIID6A0BgIpSwabesNQr
         omXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GTTUBcRAq7maBJE6Xq/2iqskDvrNZ73+l5asKTOZeVo=;
        b=GdLz+toHS6t58EhjEVz6bpxcIvbOlmLYFRrwh25IoushUBxKSolIohc3JIdX/uqyDg
         xiTN/59PuKbt9R3bVqVqrITa9um3fOhPeUmrXpqVGKK/avl+lBRtCCk28+AiAfJs+fGK
         kn0vCZqV5Y/dfubd7LP/aTEvLf86bVM7glpv92z2JJu+B+/Vv4yYqOebByWjs0OwxGwm
         jDBQV5cj1OxCvkMA55L+chzkzpacECd8XhboxpEiezziQTmZccWifryh8auyRQInfHWs
         l887KfE/1FpkPi7XyxZ2f/+k2fi+QBjUAwyQORnpDcP8txy5TyFokX8G1EyshDy1Ncob
         BqFA==
X-Gm-Message-State: AOAM532QU4X6sdSCfWNl8paBjJl/l14SfrJtTEFSleeacCcPYA/tw8Oz
        Vm/cKcfBdNgJDiTVC21BMQs=
X-Google-Smtp-Source: ABdhPJwhUfc1hUesowajnjOLKMZvIRZfH4qFyUk6V78F7MGfXSB4d3QzbhdXut1nIn0DrIhnl/FSMw==
X-Received: by 2002:a17:90b:24a:: with SMTP id fz10mr11962813pjb.36.1594254807737;
        Wed, 08 Jul 2020 17:33:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n22sm581893pjq.25.2020.07.08.17.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 17:33:27 -0700 (PDT)
Subject: Re: [PATCH] hwmon: adm1275: Make sure we are reading enough data for
 different chips
To:     Chu Lin <linchuyuan@google.com>
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
References: <20200708235306.3854404-1-linchuyuan@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a219c4ba-23ec-f6a0-1bbb-593e54dd11be@roeck-us.net>
Date:   Wed, 8 Jul 2020 17:33:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708235306.3854404-1-linchuyuan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 4:53 PM, Chu Lin wrote:
> Issue:
> When binding adm1272 to the adm1275 driver, PEC error is reported.
> See blow:

s/blow/below/

Also, unless I am missing something, the error is only seen if PEC is
enabled.

> adm1275: probe of xxxx failed with error -74
> 
> Diagnosis:
> Per the datasheet of adm1272 and adm1278 (www.analog.com),
> PMON_CONFIG (0xd4) is 16bits wide. On the other hand,
> PMON_CONFIG (0xd4) for adm1275 is 8bits wide.
> The driver should not assume everything is 8bits wide and read only
> 8bits from it.
> 
> Solution:
> if it is adm1272 or adm1278, use i2c_read_word. Else, use i2c_read_byte
> 

See below for more chips with 16-bit configuration registers.

> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
>  drivers/hwmon/pmbus/adm1275.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index e25f541227da..a0d547d20358 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -472,6 +472,7 @@ static int adm1275_probe(struct i2c_client *client,
>  	struct adm1275_data *data;
>  	const struct i2c_device_id *mid;
>  	const struct coefficients *coefficients;
> +	s32 (*config_read_fn_ptr)(const struct i2c_client *client, u8 reg);

_ptr is really not needed here and redundant. A variable pointing to a function
is always a pointer.

>  	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
>  	int tindex = -1;
>  	u32 shunt;
> @@ -510,14 +511,6 @@ static int adm1275_probe(struct i2c_client *client,
>  			   "Device mismatch: Configured %s, detected %s\n",
>  			   id->name, mid->name);
>  
> -	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
> -	if (config < 0)
> -		return config;
> -
> -	device_config = i2c_smbus_read_byte_data(client, ADM1275_DEVICE_CONFIG);
> -	if (device_config < 0)
> -		return device_config;
> -

The reason for doing this here was to avoid the memory allocation failure
on error. I don't really see the point of moving the code block.

>  	data = devm_kzalloc(&client->dev, sizeof(struct adm1275_data),
>  			    GFP_KERNEL);
>  	if (!data)
> @@ -532,6 +525,21 @@ static int adm1275_probe(struct i2c_client *client,
>  
>  	data->id = mid->driver_data;
>  
> +	/* adm1272 and adm1278 supports temperature monitoring.  The config and device config
> +	 * are 16bits wide for these two devices. On the other hand, other devices are 8 bits wide
> +	 */

Standard multi-line comments, please. Also, the destinction is really
based on have_power_sampling, though that is set only later.

> +	if (data->id == adm1272 || data->id == adm1278)
> +		config_read_fn_ptr = &i2c_smbus_read_word_data;

Function pointers don't need &.
For ADM1293 and ADM1294, the registers are also 16 bit wide
(again, see use of have_power_sampling).

Thanks,
Guenter

> +	else
> +		config_read_fn_ptr = &i2c_smbus_read_byte_data;
> +	config = config_read_fn_ptr(client, ADM1275_PMON_CONFIG);
> +	if (config < 0)
> +		return config;
> +
> +	device_config = config_read_fn_ptr(client, ADM1275_DEVICE_CONFIG);
> +	if (device_config < 0)
> +		return device_config;
> +
>  	info = &data->info;
>  
>  	info->pages = 1;
> 


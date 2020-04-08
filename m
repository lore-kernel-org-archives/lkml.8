Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF0AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F5B20748
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOXqIwIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDHCs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:48:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34961 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDHCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:48:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id c12so1999045plz.2;
        Tue, 07 Apr 2020 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CVVMrOtOUJzsx2drtrkCJ83PaKET950PyeDv0OYif3g=;
        b=hOXqIwIQhYTtaaEp+LQxtLdaCOEXCEFW+poIvX+trNXLgmcNTSyQ1LJ7U1f1dRjx6f
         /K5R4Xoezt00KERaTWliqNNLUifeL5m7SqGhAYxnfJPSzUkRd9y/BBESfCKzJVr3NpS/
         6SGUH5nRWexoSnLLRcRekn21tgc59KA0b6ZWZdBmMlYkd8DcTXsEmlwaCd5+4y7QSRpR
         jWh7BsDqm7QJQV1a6u9fiUV2DhX4AHaju6wf7Xxro53iMJqmOByxuliIj8JsNwdvhXP9
         GuoMVigDXEH8Wfo+eV9CXLjN59vdlhy6K05snCv1UGsiaI8urRkxzQCWORf5D2kOTvuj
         bNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CVVMrOtOUJzsx2drtrkCJ83PaKET950PyeDv0OYif3g=;
        b=YDWgf8DqoY4A/MWRySNgD3dQColpbzenZScA4+urCXIMzXOZpqKLPTL3tnTPXINrdO
         0GLYO/Sn70aAYg/m9H5jpop4o+HSPf765OoeG9dlK73EPLAsJtKEeIpJJ4aakV/28l4a
         Gz4cXgJLbkJbbEAMAxcCzA28E3vGEPgh44f5G/V3sMc5+qYZ3y8eATL3Z6SKejasIGuj
         SJYF7pItgkwDGdDYDNccC9X1nirN/X2zV9ddxi/k7w9Dj0VTVxK4AeyirmEqytr8dXG9
         ZvQi20cN18+0z0Tp4AjPEGm7NRBpxBxay06NxSj0sYU04qNYq5i1UI53LFaUlpZJDMdb
         qGlA==
X-Gm-Message-State: AGi0PuZc8+4ilVXcOGVEJ2prcVr6wDmjOjRBRNPiUK2stWEe835Dkjsk
        RzqpI0CaImT0pY/oXIZIhGyiRAOK
X-Google-Smtp-Source: APiQypKFyc+NJo8J3P/PfJkYIV6n5m7g1IFua5B90buSjDMH2Mc2FdehFgKhpCr9AO03R5R6kPxzXQ==
X-Received: by 2002:a17:902:107:: with SMTP id 7mr5043824plb.302.1586314132072;
        Tue, 07 Apr 2020 19:48:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f64sm15972916pfb.72.2020.04.07.19.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 19:48:51 -0700 (PDT)
Subject: Re: [PATCH v2] hwmon: (dell-smm) Use one DMI match for all XPS models
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Thomas Hebb <tommyhebb@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
References: <5d7e498b83e89ce7c41a449b61919c65d0770b73.1586033337.git.tommyhebb@gmail.com>
 <20200407102238.zweh7s7t6rn5cwhf@pali>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c830927d-3365-4b58-9bea-6c99ca2d9edb@roeck-us.net>
Date:   Tue, 7 Apr 2020 19:48:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407102238.zweh7s7t6rn5cwhf@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 3:22 AM, Pali Rohár wrote:
> Hi!
> 
> On Saturday 04 April 2020 16:49:00 Thomas Hebb wrote:
>> Currently, each new XPS has to be added manually for module autoloading
>> to work. Since fan multiplier autodetection should work fine on all XPS
>> models, just match them all with one block like is done for Precision
>> and Studio.
> 
> It makes sense. We already load driver for all Inspirion, Latitude,
> Precision, Vostro and Studio models so I do not see reason why not to
> load it also for all XPS models. I doubt that Dell uses one base
> firmware for all mentioned models and second one specially for XPS.
> 
>> The only match we replace that doesn't already use autodetection is
>> "XPS13" which, according to Google, only matches the XPS 13 9333. (All
>> other XPS 13 models have "XPS" as its own word, surrounded by spaces.)
>> According to the thread at [1], autodetection works for the XPS 13 9333,
>> meaning this shouldn't regress it. I do not own one to confirm with,
>> though.
>>
>> Tested on an XPS 13 9350 and confirmed the module now autoloads and
>> reports reasonable-looking data. I am using BIOS 1.12.2 and do not see
>> any freezes when querying fan speed.
>>
>> [1] https://lore.kernel.org/patchwork/patch/525367/
> 
> I guess that these two tests are enough based on the fact that lot of
> XPS models are already whitelisted.
> 
> Guenter, it is fine for you now? Or is something else needed?
> 

I still have my reservations, but ...

>> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> 
> Acked-by: Pali Rohár <pali@kernel.org>
> 
I'll apply it to linux-next with your approval. After all, the entire driver
is a mess to start with. We'll see if it blows up in our face.

Guenter

>> ---
>>
>> Changes in v2:
>> - Remove another now-redundant XPS entry that I'd missed.
>>
>>  drivers/hwmon/dell-smm-hwmon.c | 26 ++------------------------
>>  1 file changed, 2 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
>> index d4c83009d625..ca30bf903ec7 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -1072,13 +1072,6 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro"),
>>  		},
>>  	},
>> -	{
>> -		.ident = "Dell XPS421",
>> -		.matches = {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS L421X"),
>> -		},
>> -	},
>>  	{
>>  		.ident = "Dell Studio",
>>  		.matches = {
>> @@ -1087,14 +1080,6 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>>  		},
>>  		.driver_data = (void *)&i8k_config_data[DELL_STUDIO],
>>  	},
>> -	{
>> -		.ident = "Dell XPS 13",
>> -		.matches = {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS13"),
>> -		},
>> -		.driver_data = (void *)&i8k_config_data[DELL_XPS],
>> -	},
>>  	{
>>  		.ident = "Dell XPS M140",
>>  		.matches = {
>> @@ -1104,17 +1089,10 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>>  		.driver_data = (void *)&i8k_config_data[DELL_XPS],
>>  	},
>>  	{
>> -		.ident = "Dell XPS 15 9560",
>> -		.matches = {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9560"),
>> -		},
>> -	},
>> -	{
>> -		.ident = "Dell XPS 15 9570",
>> +		.ident = "Dell XPS",
>>  		.matches = {
>>  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS"),
>>  		},
>>  	},
>>  	{ }
>> -- 
>> 2.25.2
>>


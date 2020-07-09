Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86444C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644502073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qpfoa8fC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGIOF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgGIOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:05:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0737AC08C5CE;
        Thu,  9 Jul 2020 07:05:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so1166371pjb.2;
        Thu, 09 Jul 2020 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NwEhvbErLu/V10VrYepwaUe6PTwu2578knvAWxKcwIE=;
        b=Qpfoa8fCSn6XqJ2sn3lwIOfOzdzMf9zCa32Jm7zpYhLZhqk7CSwulNF7PmzSfdPWcy
         3qJgYRubgywQp//y2pOfqI8VUZlBokueynM7BmvffndliAknMDwVukOGiFWOvQf6ABUi
         LLU5U2wbv8vlRqKdWXQFypPPnlLY61oJ1R+spLv26EQRnefdZuiaCYh4uIySVufNGYbQ
         8rvOV+ghiXk9rZbmLmB9s/wWnHlOXxDgdfnnjIwc878tB6wZyqkvDdTT6MchhP52KjBd
         LN7L937iZxtG9Tfcwwxve7HFz4Wwfu1s6cMAYjKTvmRYuyzKXRhxhTZCKPI1tMVvIUey
         NQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NwEhvbErLu/V10VrYepwaUe6PTwu2578knvAWxKcwIE=;
        b=NfP/yh0hWQWYLQOmiOxTwR2I/pZG9BtNU00e+OyXv8tnLVit428tmJ3DYFt4YqXZjK
         gK04Di4u3p5jHrGLoBFLe6OQEtG2Z/Hv8NwodQBJ8+g6lGgPiv50Z8RPN8m+1PtX0S2H
         cI1nFWuU4KtK3pcAKbPFcgyw2s1hLnPO6wvCA2UOdUEogGWJDYG1gb2Dew6ytYCSmMeo
         422pdFo8Yq2kdzfWXC7BbzWBhJn/epvedx9HM7XAl4+10pe2Xva+0wGU7qe7h6tvXhFT
         1vFNSMbHZ6SI2pare962Hl51wYzZnR/Rgo5z9LciNU+Fd4glQp1+4RU8UFUFWqHK6uav
         wZCg==
X-Gm-Message-State: AOAM530W3GSW4Cbo0sphwgyYM3AcCNDYTaL+cHAQLeqj/+Pov+yFYDYM
        QE/WBUmBZTI8r0nGoznBErU=
X-Google-Smtp-Source: ABdhPJxvV9B0/d/CooREw9Ze/1q44n+0kuGdm1qO1kmBE3ej7pRSdlQEmgo3R+PWGgYz16lLpQVQsA==
X-Received: by 2002:a17:90a:2a4d:: with SMTP id d13mr126753pjg.195.1594303554585;
        Thu, 09 Jul 2020 07:05:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v197sm3076905pfc.35.2020.07.09.07.05.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jul 2020 07:05:54 -0700 (PDT)
Date:   Thu, 9 Jul 2020 07:05:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
Subject: Re: [PATCH v2] hwmon: adm1275: Make sure we are reading enough data
 for different chips
Message-ID: <20200709140553.GA62629@roeck-us.net>
References: <20200709040612.3977094-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709040612.3977094-1-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:06:12AM +0000, Chu Lin wrote:
> Issue:
> When PEC is enabled, binding adm1272 to the adm1275 would
> fail due to PEC error. See below:
> adm1275: probe of xxxx failed with error -74
> 
> Diagnosis:
> Per the datasheet of adm1272, adm1278, adm1293 and amd1294,
> PMON_CONFIG (0xd4) is 16bits wide. On the other hand,
> PMON_CONFIG (0xd4) for adm1275 is 8bits wide. The driver should not
> assume everything is 8bits wide and read only 8bits from it.
> 
> Solution:
> If it is adm1272, adm1278, adm1293 and adm1294, use i2c_read_word.
> Else, use i2c_read_byte
> 
> Testing:
> Binding adm1272 to the driver.
> The change is only tested on adm1272.
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>

Applied.

Thanks a lot for analyzing and fixing the problem.

Guenter

> ---
> 
> ChangeLog v1 -> v2
>   - Rename config_read_fn_ptr to config_read_fn
>   - Move config_read_fn to the first line as it is the longest
>     variable declaration
>   - Include adm1293 and adm1294
>   - Remove the inline comment as I think the purpose is obvious
> 
> 
>  drivers/hwmon/pmbus/adm1275.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index e25f541227da..19317575d1c6 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -465,6 +465,7 @@ MODULE_DEVICE_TABLE(i2c, adm1275_id);
>  static int adm1275_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> +	s32 (*config_read_fn)(const struct i2c_client *client, u8 reg);
>  	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
>  	int config, device_config;
>  	int ret;
> @@ -510,11 +511,16 @@ static int adm1275_probe(struct i2c_client *client,
>  			   "Device mismatch: Configured %s, detected %s\n",
>  			   id->name, mid->name);
>  
> -	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
> +	if (mid->driver_data == adm1272 || mid->driver_data == adm1278 ||
> +	    mid->driver_data == adm1293 || mid->driver_data == adm1294)
> +		config_read_fn = i2c_smbus_read_word_data;
> +	else
> +		config_read_fn = i2c_smbus_read_byte_data;
> +	config = config_read_fn(client, ADM1275_PMON_CONFIG);
>  	if (config < 0)
>  		return config;
>  
> -	device_config = i2c_smbus_read_byte_data(client, ADM1275_DEVICE_CONFIG);
> +	device_config = config_read_fn(client, ADM1275_DEVICE_CONFIG);
>  	if (device_config < 0)
>  		return device_config;
>  

Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5381FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202742075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmath.org header.i=@bitmath.org header.b="pvHkTpb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgHTVNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:13:44 -0400
Received: from mailrelay3-2.pub.mailoutpod1-cph3.one.com ([46.30.212.2]:50513
        "EHLO mailrelay3-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgHTVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=jtemrB4zsoa7mVFISpNS3LnmcTerk053X3gyJVZ91Ho=;
        b=pvHkTpb5n5+xriE/BvwhCvErqEBlKs7CDgpSTkj/53k0nO9xUAEUfWTFHYb8OHoOj9sqzKPe+sOME
         q3w/fGiSEIB1OQnrKfzYYMN/zKEcb5vb7eIuIgyM1TY/Nbwq5lFhFlvsEOG5C27iOc/Ed9nAX0VlL1
         or3CjpEsrRlbrI4gLkBrwmLW/INWl1tJRto4DGhXUaJkpq9EeIpR+9t9PiM+66xQeyLihSyGTP2kWi
         y7dZEkFAdGUNuwdMa38+JfAjCJVSg2oy2MKHat5Ro2TzMQhP3gGDbt7BaNVSLRHjRh1vCpA68zqAiw
         Chh5phSqB+0iUO1Go4VCH4r9itHLKjg==
X-HalOne-Cookie: 0ca3df440a60ca828b012abdaf5a091513d39283
X-HalOne-ID: c6582f4f-e327-11ea-86ed-d0431ea8bb03
Received: from [192.168.19.13] (h-98-128-166-229.na.cust.bahnhof.se [98.128.166.229])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c6582f4f-e327-11ea-86ed-d0431ea8bb03;
        Thu, 20 Aug 2020 20:57:36 +0000 (UTC)
Subject: Re: [PATCH] hwmon: applesmc: check status earlier.
To:     trix@redhat.com, jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200820131932.10590-1-trix@redhat.com>
From:   Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <4e6435d4-4fa7-1430-528e-e3188cd3e207@bitmath.org>
Date:   Thu, 20 Aug 2020 22:57:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820131932.10590-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this representative problem
> 
> applesmc.c:758:10: warning: 1st function call argument is an
>    uninitialized value
>          left = be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> buffer is filled by the earlier call
> 
> 	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, ...
> 
> This problem is reported because a goto skips the status check.
> Other similar problems use data from applesmc_read_key before checking
> the status.  So move the checks to before the use.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/hwmon/applesmc.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 316618409315..a18887990f4a 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -753,15 +753,18 @@ static ssize_t applesmc_light_show(struct device *dev,
>   	}
>   
>   	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, buffer, data_length);
> +	if (ret)
> +		goto out;
>   	/* newer macbooks report a single 10-bit bigendian value */
>   	if (data_length == 10) {
>   		left = be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
>   		goto out;
>   	}
>   	left = buffer[2];
> +
> +	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, data_length);
>   	if (ret)
>   		goto out;
> -	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, data_length);
>   	right = buffer[2];
>   
>   out:
> @@ -810,12 +813,11 @@ static ssize_t applesmc_show_fan_speed(struct device *dev,
>   		  to_index(attr));
>   
>   	ret = applesmc_read_key(newkey, buffer, 2);
> -	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
> -
>   	if (ret)
>   		return ret;
> -	else
> -		return snprintf(sysfsbuf, PAGE_SIZE, "%u\n", speed);
> +
> +	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
> +	return snprintf(sysfsbuf, PAGE_SIZE, "%u\n", speed);
>   }
>   
>   static ssize_t applesmc_store_fan_speed(struct device *dev,
> @@ -851,12 +853,11 @@ static ssize_t applesmc_show_fan_manual(struct device *dev,
>   	u8 buffer[2];
>   
>   	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
> -	manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
> -
>   	if (ret)
>   		return ret;
> -	else
> -		return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", manual);
> +
> +	manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
> +	return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", manual);
>   }
>   
>   static ssize_t applesmc_store_fan_manual(struct device *dev,
> @@ -872,10 +873,11 @@ static ssize_t applesmc_store_fan_manual(struct device *dev,
>   		return -EINVAL;
>   
>   	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
> -	val = (buffer[0] << 8 | buffer[1]);
>   	if (ret)
>   		goto out;
>   
> +	val = (buffer[0] << 8 | buffer[1]);
> +
>   	if (input)
>   		val = val | (0x01 << to_index(attr));
>   	else
> @@ -951,13 +953,12 @@ static ssize_t applesmc_key_count_show(struct device *dev,
>   	u32 count;
>   
>   	ret = applesmc_read_key(KEY_COUNT_KEY, buffer, 4);
> -	count = ((u32)buffer[0]<<24) + ((u32)buffer[1]<<16) +
> -						((u32)buffer[2]<<8) + buffer[3];
> -
>   	if (ret)
>   		return ret;
> -	else
> -		return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", count);
> +
> +	count = ((u32)buffer[0]<<24) + ((u32)buffer[1]<<16) +
> +						((u32)buffer[2]<<8) + buffer[3];
> +	return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", count);
>   }
>   
>   static ssize_t applesmc_key_at_index_read_show(struct device *dev,
> 

Looks good, thank you.

     Reviewed-by: Henrik Rydberg <rydberg@bitmath.org>

Henrik

Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B054C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEC420724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXevgdg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHUSd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgHUSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:33:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051CCC061573;
        Fri, 21 Aug 2020 11:33:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u20so1498299pfn.0;
        Fri, 21 Aug 2020 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c0IYmtPlTYdcWM4v9Z24Y/LKv93Em9VatSn2LIsOk08=;
        b=oXevgdg2uRH/KC9bvFkJU7+ztru1Li73wtw4bjDpVTVu832bWDlGsSMsHUtVySWSvg
         NHjSlazuS4RCnTkMPbGvc8R5RStBnszAumbGrkCqb5zNQD9zICLGm2V3cTtxyRivsCUs
         oeUF03Y0fyO5F86DReTXkoNNoFewpW4rDwZFMTaXyLFMjqU/b2cveXwNzn5q/3ZEk5u+
         RtVrd7lJlRGFNdzvuk/0B1fh2DYVMGzpNT9LSxhQUSGC0G/GaZr/4yws8e3PwpGLg6L5
         VjUKV0G9sGs/30k7wxfefeLkzsMRBAUBRY2J4ohdqI506EECno6Xuz8NxB1G0HP6Z0Vi
         WvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c0IYmtPlTYdcWM4v9Z24Y/LKv93Em9VatSn2LIsOk08=;
        b=nmeFz+2ju76qar5/nzwgzAYUU+13ZhBpJll+wQJh6smZNNA4ItVoL5i/1ZD64feNNu
         rb/vN12ttblm9YwM3sKpTU+3LK5rjQKKPPgWbNvw94ipdfVtNgrybdR7wKSetY+OjgTc
         JpO2zmVmKmobquLaMWxNqQ7Lg6r37CwzYAat8+OjgMdykmBrp8qrqDMzEMF423QP1eiV
         pkSY+BzHTItEtfJC6wmOjk2d5+AisQBx4FboGg5Gq1x4TtCQLCyNlq+aFWmJUK0wgEqD
         W2f6ZfX0LxtKYSKVeSg0AFBZpAaeRaZHYfwcP64mtkHnS4rDNi1LIdhOUJ7QzGQ5cxJA
         8qkw==
X-Gm-Message-State: AOAM530y2axrKkDi150itPyzzWB+vzvupOXvZuWYC5F2u8gNp6mzKZrp
        IL0IVDAZjyYT1WPQEM+dV2U=
X-Google-Smtp-Source: ABdhPJxlIumpirHMvSBxiTfmK6kO1Kw8bTcK0sfHdwMsy7+kyET/4vjtzvAjkZ8nobd1eZ+1+y+P1w==
X-Received: by 2002:aa7:93ad:: with SMTP id x13mr3359105pff.33.1598034792345;
        Fri, 21 Aug 2020 11:33:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f17sm3368582pfq.67.2020.08.21.11.33.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:33:11 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:33:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     trix@redhat.com
Cc:     rydberg@bitmath.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: applesmc: check status earlier.
Message-ID: <20200821183311.GA138863@roeck-us.net>
References: <20200820131932.10590-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820131932.10590-1-trix@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 06:19:32AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this representative problem
> 
> applesmc.c:758:10: warning: 1st function call argument is an
>   uninitialized value
>         left = be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/applesmc.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 316618409315..a18887990f4a 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -753,15 +753,18 @@ static ssize_t applesmc_light_show(struct device *dev,
>  	}
>  
>  	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, buffer, data_length);
> +	if (ret)
> +		goto out;
>  	/* newer macbooks report a single 10-bit bigendian value */
>  	if (data_length == 10) {
>  		left = be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
>  		goto out;
>  	}
>  	left = buffer[2];
> +
> +	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, data_length);
>  	if (ret)
>  		goto out;
> -	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, data_length);
>  	right = buffer[2];
>  
>  out:
> @@ -810,12 +813,11 @@ static ssize_t applesmc_show_fan_speed(struct device *dev,
>  		  to_index(attr));
>  
>  	ret = applesmc_read_key(newkey, buffer, 2);
> -	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
> -
>  	if (ret)
>  		return ret;
> -	else
> -		return snprintf(sysfsbuf, PAGE_SIZE, "%u\n", speed);
> +
> +	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
> +	return snprintf(sysfsbuf, PAGE_SIZE, "%u\n", speed);
>  }
>  
>  static ssize_t applesmc_store_fan_speed(struct device *dev,
> @@ -851,12 +853,11 @@ static ssize_t applesmc_show_fan_manual(struct device *dev,
>  	u8 buffer[2];
>  
>  	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
> -	manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
> -
>  	if (ret)
>  		return ret;
> -	else
> -		return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", manual);
> +
> +	manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
> +	return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", manual);
>  }
>  
>  static ssize_t applesmc_store_fan_manual(struct device *dev,
> @@ -872,10 +873,11 @@ static ssize_t applesmc_store_fan_manual(struct device *dev,
>  		return -EINVAL;
>  
>  	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
> -	val = (buffer[0] << 8 | buffer[1]);
>  	if (ret)
>  		goto out;
>  
> +	val = (buffer[0] << 8 | buffer[1]);
> +
>  	if (input)
>  		val = val | (0x01 << to_index(attr));
>  	else
> @@ -951,13 +953,12 @@ static ssize_t applesmc_key_count_show(struct device *dev,
>  	u32 count;
>  
>  	ret = applesmc_read_key(KEY_COUNT_KEY, buffer, 4);
> -	count = ((u32)buffer[0]<<24) + ((u32)buffer[1]<<16) +
> -						((u32)buffer[2]<<8) + buffer[3];
> -
>  	if (ret)
>  		return ret;
> -	else
> -		return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", count);
> +
> +	count = ((u32)buffer[0]<<24) + ((u32)buffer[1]<<16) +
> +						((u32)buffer[2]<<8) + buffer[3];
> +	return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", count);
>  }
>  
>  static ssize_t applesmc_key_at_index_read_show(struct device *dev,

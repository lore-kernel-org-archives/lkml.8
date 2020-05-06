Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8775C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BE220708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar4xFgar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgEFP5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgEFP5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:57:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E592C061A0F;
        Wed,  6 May 2020 08:57:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so1286871pgg.2;
        Wed, 06 May 2020 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mKpCjuzdZCHjolVpdDfscU7qJJTtSQZ+t9VhNB43JSw=;
        b=ar4xFgarysgBLcmwqP6yPq87M4Mk0brn0FOWV1bGn5/a7Ohmi2D4WL7MSiwJLQ99wh
         7aD+BsOqsENG1cjrXegl6Ig/SvWxVL+mNBQ1Uj+OoCKN5GbXBDaSC2H83Osrb2KLmXCa
         kZ0N7rQiAFuFIMPrPuS1C3riz9BalKRJ4B/UPUoT9v0CzX1wT2cSGSV9gtH83AXauEX6
         bJkuvrAxsnZVxv/G++H99E3hLQdohyPHuNEn/9UgshIM2kx+PXnUchpAXrd7oIAW8gkH
         cU8rz2/F9wNTD7m+f6W8lWEAOavifuXnJRf6bBq4W+kXBeEQptxW+8WnEA9/l2/F8fj4
         NYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKpCjuzdZCHjolVpdDfscU7qJJTtSQZ+t9VhNB43JSw=;
        b=bdndrDOAOPXCI+N51AQEt7bjGG+aWTCgf41HRQyr+oP0xC69Dsn3AqHRnwJF6wj7Kt
         sp/ZFysCuwwVaM7UjWN97BbGwi0R/33zLDUCney1/l6X8eIxC9z0RzyB3wVo+tPGZIlg
         o5g3Ct99cWbC7xGbqF9MMxp+CGPXg9TjEGeh1b6kb+cumLCVOP8RJHhRMnfbxtG7yZIJ
         EiJpfFrki033pfYg7sXHVYrQ8WRldH2LDjX6sxIo/XVZwhNa2oSroM1v6UqLlMznTh89
         ue0PhNEODGSC22DexocCw+z43SExY+V13cAShJITWZa5fftjt5n0gZ30agBosTEYVUmf
         uZGg==
X-Gm-Message-State: AGi0PuY0kiSYxGuXvOyegoqZ3fC24NQW7nLglsbroW+XFHlNseFi0Qvb
        B1xhFVcO0kk7ubdlia3+BxY=
X-Google-Smtp-Source: APiQypLHWEH0TX+GBg4gqAGKHl+cYN4HAp8NxlHV/fTPVtwLI8bM2al958mRCqE+bbvl+uPLsoSycA==
X-Received: by 2002:a63:150:: with SMTP id 77mr7231734pgb.136.1588780626809;
        Wed, 06 May 2020 08:57:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r31sm1912232pgl.86.2020.05.06.08.57.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 08:57:06 -0700 (PDT)
Date:   Wed, 6 May 2020 08:57:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, robh+dt@kernel.org
Subject: Re: [PATCH 3/3] hwmon: (occ) Add new temperature sensor type
Message-ID: <20200506155704.GA30543@roeck-us.net>
References: <20200501150833.5251-1-eajames@linux.ibm.com>
 <20200501150833.5251-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501150833.5251-4-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:08:33AM -0500, Eddie James wrote:
> The latest version of the On-Chip Controller (OCC) has a different
> format for the temperature sensor data. Add a new temperature sensor
> version to handle this data.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

For my reference:

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume this depends on at least patch 2 of the series, so we'll have
to wait for that to be accepted.

Guenter

> ---
>  drivers/hwmon/occ/common.c | 75 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 30e18eb60da7..52af0e728232 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -41,6 +41,14 @@ struct temp_sensor_2 {
>  	u8 value;
>  } __packed;
>  
> +struct temp_sensor_10 {
> +	u32 sensor_id;
> +	u8 fru_type;
> +	u8 value;
> +	u8 throttle;
> +	u8 reserved;
> +} __packed;
> +
>  struct freq_sensor_1 {
>  	u16 sensor_id;
>  	u16 value;
> @@ -307,6 +315,60 @@ static ssize_t occ_show_temp_2(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
>  }
>  
> +static ssize_t occ_show_temp_10(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	int rc;
> +	u32 val = 0;
> +	struct temp_sensor_10 *temp;
> +	struct occ *occ = dev_get_drvdata(dev);
> +	struct occ_sensors *sensors = &occ->sensors;
> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +
> +	rc = occ_update_response(occ);
> +	if (rc)
> +		return rc;
> +
> +	temp = ((struct temp_sensor_10 *)sensors->temp.data) + sattr->index;
> +
> +	switch (sattr->nr) {
> +	case 0:
> +		val = get_unaligned_be32(&temp->sensor_id);
> +		break;
> +	case 1:
> +		val = temp->value;
> +		if (val == OCC_TEMP_SENSOR_FAULT)
> +			return -EREMOTEIO;
> +
> +		/*
> +		 * VRM doesn't return temperature, only alarm bit. This
> +		 * attribute maps to tempX_alarm instead of tempX_input for
> +		 * VRM
> +		 */
> +		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
> +			/* sensor not ready */
> +			if (val == 0)
> +				return -EAGAIN;
> +
> +			val *= 1000;
> +		}
> +		break;
> +	case 2:
> +		val = temp->fru_type;
> +		break;
> +	case 3:
> +		val = temp->value == OCC_TEMP_SENSOR_FAULT;
> +		break;
> +	case 4:
> +		val = temp->throttle * 1000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
> +}
> +
>  static ssize_t occ_show_freq_1(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> @@ -745,6 +807,10 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  		num_attrs += (sensors->temp.num_sensors * 4);
>  		show_temp = occ_show_temp_2;
>  		break;
> +	case 0x10:
> +		num_attrs += (sensors->temp.num_sensors * 5);
> +		show_temp = occ_show_temp_10;
> +		break;
>  	default:
>  		sensors->temp.num_sensors = 0;
>  	}
> @@ -844,6 +910,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
>  						     show_temp, NULL, 3, i);
>  			attr++;
> +
> +			if (sensors->temp.version == 0x10) {
> +				snprintf(attr->name, sizeof(attr->name),
> +					 "temp%d_max", s);
> +				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
> +							     show_temp, NULL,
> +							     4, i);
> +				attr++;
> +			}
>  		}
>  	}
>  

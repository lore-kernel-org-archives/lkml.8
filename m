Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339272071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb1mBqrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgH3PLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgH3PLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:11:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFCC061573;
        Sun, 30 Aug 2020 08:11:03 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h17so3271661otl.9;
        Sun, 30 Aug 2020 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eABizydsWlDpE/Ze04Xdta0L7OMTGzzMowhyaa0B8Hw=;
        b=sb1mBqrpsI6VATKEU1OUw02RFiNRQZ3igrpZweuj6eA7fR3A8YdiIvO22spK53jeCl
         8dFR7Mmb5B6pqN9TF7tehWSVgeDlOqybsvDm2zBddaYJkLljTQH7hiaB62iNuQPje8D+
         nw9xaz+0TrhfQWmeWjcLsEBhbNSYorJtIrFlAN56kOtikJzklqKwsZuJqdmPibbTbxxB
         84vK/Zgu08KZqSYha43onChH07ZEY7/ZOkWwby+PMRvOVek6AHQYp+2601IkAh8tb41F
         WeD8Pr5I0JjeAud2z9+lEa2GKV05NqBq/R4yIPg4eqkiS/j/0zE/1vD4R89EJrNVIs30
         id4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=eABizydsWlDpE/Ze04Xdta0L7OMTGzzMowhyaa0B8Hw=;
        b=BDZ3NlyUo7FIHsK+jAJzuac4C41NxL4KhJ3TDKXGvv+Ca+hf8gBQ5v7G8V3IaLFHgp
         RoNegeN9YvXjc1yNTNqPNeCOJiEENzn5erCYTMpe7lw9sZI0t8LVuZcsTVURLDQPVtoD
         LjJwBdjEiVv3m072eHOfNIGqm9BUzSj+ITj8nIx3UoATegGTy/FsVoaCFFG+kPuI0mmK
         CLzqhpV3hyR+oEF1o+7tYBDRgWyA1lJr+Mg8l842rNSWVQ+t8Xk8K0d3Kuk1tUWOvWBy
         33tn6rZh/ZB6X0gMW7w2cQdCdLkoNQYYGI0ZFFKK1hJIJCx8fkrjONmLXqOYphKqspbp
         jUVQ==
X-Gm-Message-State: AOAM530bBlicIYdOMpYwGz8yL3p4kj4L4MqtThEsf7inWI4U5+mYjanh
        iHx7Knv+YZqXlnsdjYI+hvXGnuShobU=
X-Google-Smtp-Source: ABdhPJz8KcZclke67/+nsfLsKTifU/5WF7cY8cdhVrvL/b1CprbC8amrOKfw8BtrFdptvAGZdZk7HA==
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr763754otn.89.1598800262135;
        Sun, 30 Aug 2020 08:11:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10sm1288045ooh.9.2020.08.30.08.11.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 08:11:01 -0700 (PDT)
Date:   Sun, 30 Aug 2020 08:11:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Robert Jones <rjones@gateworks.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: gsc-hwmon: add fan sensor
Message-ID: <20200830151100.GA168034@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 01:04:54PM -0700, Tim Harvey wrote:
> Add a fan sensor to report RPM's from a fan tach input.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied.

Thanks,
Guenter

> --

Note there is a '-' missing here, causing the version history to be added
to the commit log. I dropped that.

> v2:
>  - avoid unnecessary line split and fix opening brace location
> ---
>  drivers/hwmon/gsc-hwmon.c               | 32 +++++++++++++++++++++++++++++---
>  include/linux/platform_data/gsc_hwmon.h |  1 +
>  2 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index c6d4567..1fe3741 100644
> --- a/drivers/hwmon/gsc-hwmon.c
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -17,6 +17,7 @@
>  
>  #define GSC_HWMON_MAX_TEMP_CH	16
>  #define GSC_HWMON_MAX_IN_CH	16
> +#define GSC_HWMON_MAX_FAN_CH	16
>  
>  #define GSC_HWMON_RESOLUTION	12
>  #define GSC_HWMON_VREF		2500
> @@ -27,11 +28,14 @@ struct gsc_hwmon_data {
>  	struct regmap *regmap;
>  	const struct gsc_hwmon_channel *temp_ch[GSC_HWMON_MAX_TEMP_CH];
>  	const struct gsc_hwmon_channel *in_ch[GSC_HWMON_MAX_IN_CH];
> +	const struct gsc_hwmon_channel *fan_ch[GSC_HWMON_MAX_FAN_CH];
>  	u32 temp_config[GSC_HWMON_MAX_TEMP_CH + 1];
>  	u32 in_config[GSC_HWMON_MAX_IN_CH + 1];
> +	u32 fan_config[GSC_HWMON_MAX_FAN_CH + 1];
>  	struct hwmon_channel_info temp_info;
>  	struct hwmon_channel_info in_info;
> -	const struct hwmon_channel_info *info[3];
> +	struct hwmon_channel_info fan_info;
> +	const struct hwmon_channel_info *info[4];
>  	struct hwmon_chip_info chip;
>  };
>  
> @@ -155,6 +159,9 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  	case hwmon_temp:
>  		ch = hwmon->temp_ch[channel];
>  		break;
> +	case hwmon_fan:
> +		ch = hwmon->fan_ch[channel];
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -187,6 +194,9 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		/* adjust by uV offset */
>  		tmp += ch->mvoffset;
>  		break;
> +	case mode_fan:
> +		tmp *= 30; /* convert to revolutions per minute */
> +		break;
>  	case mode_voltage_24bit:
>  	case mode_voltage_16bit:
>  		/* no adjustment needed */
> @@ -211,6 +221,9 @@ gsc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
>  	case hwmon_temp:
>  		*buf = hwmon->temp_ch[channel]->name;
>  		break;
> +	case hwmon_fan:
> +		*buf = hwmon->fan_ch[channel]->name;
> +		break;
>  	default:
>  		return -ENOTSUPP;
>  	}
> @@ -304,7 +317,7 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
>  	struct gsc_hwmon_platform_data *pdata = dev_get_platdata(dev);
>  	struct gsc_hwmon_data *hwmon;
>  	const struct attribute_group **groups;
> -	int i, i_in, i_temp;
> +	int i, i_in, i_temp, i_fan;
>  
>  	if (!pdata) {
>  		pdata = gsc_hwmon_get_devtree_pdata(dev);
> @@ -324,7 +337,7 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
>  	if (IS_ERR(hwmon->regmap))
>  		return PTR_ERR(hwmon->regmap);
>  
> -	for (i = 0, i_in = 0, i_temp = 0; i < hwmon->pdata->nchannels; i++) {
> +	for (i = 0, i_in = 0, i_temp = 0, i_fan = 0; i < hwmon->pdata->nchannels; i++) {
>  		const struct gsc_hwmon_channel *ch = &pdata->channels[i];
>  
>  		switch (ch->mode) {
> @@ -338,6 +351,16 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
>  						     HWMON_T_LABEL;
>  			i_temp++;
>  			break;
> +		case mode_fan:
> +			if (i_fan == GSC_HWMON_MAX_FAN_CH) {
> +				dev_err(gsc->dev, "too many fan channels\n");
> +				return -EINVAL;
> +			}
> +			hwmon->fan_ch[i_fan] = ch;
> +			hwmon->fan_config[i_fan] = HWMON_F_INPUT |
> +						   HWMON_F_LABEL;
> +			i_fan++;
> +			break;
>  		case mode_voltage_24bit:
>  		case mode_voltage_16bit:
>  		case mode_voltage_raw:
> @@ -361,10 +384,13 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
>  	hwmon->chip.info = hwmon->info;
>  	hwmon->info[0] = &hwmon->temp_info;
>  	hwmon->info[1] = &hwmon->in_info;
> +	hwmon->info[2] = &hwmon->fan_info;
>  	hwmon->temp_info.type = hwmon_temp;
>  	hwmon->temp_info.config = hwmon->temp_config;
>  	hwmon->in_info.type = hwmon_in;
>  	hwmon->in_info.config = hwmon->in_config;
> +	hwmon->fan_info.type = hwmon_fan;
> +	hwmon->fan_info.config = hwmon->fan_config;
>  
>  	groups = pdata->fan_base ? gsc_hwmon_groups : NULL;
>  	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
> index 37a8f554d..281f499 100644
> --- a/include/linux/platform_data/gsc_hwmon.h
> +++ b/include/linux/platform_data/gsc_hwmon.h
> @@ -7,6 +7,7 @@ enum gsc_hwmon_mode {
>  	mode_voltage_24bit,
>  	mode_voltage_raw,
>  	mode_voltage_16bit,
> +	mode_fan,
>  	mode_max,
>  };
>  
> -- 
> 2.7.4
> 

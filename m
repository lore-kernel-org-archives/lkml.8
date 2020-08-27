Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE66AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB432087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCjzclLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgH0Tvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0Tvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:51:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C3C061264;
        Thu, 27 Aug 2020 12:51:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so3152098pjb.2;
        Thu, 27 Aug 2020 12:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HeJN9f1Z10RS6kmYpW2mlXYutbYxxEGXhrktNJI/FiI=;
        b=YCjzclLyWmOQtWConHJtmVuvFL2mO0/fGIrPjG8XYkkxS9gUnZAMRTb5xnjradovfO
         vD1U9H0iy0axqZxzLylhSMYXDIVA6lZ7GbYKcT5h+Lh4sve6wE4yI7DvyXhoMAuFIvKk
         ezD9veuDwDwXifdDRXopz8m7DCHv19EFGfeHkVUhlgTDoWax1ZLSHe8Jx4EXS0JkxDee
         5ay+dHUd13OBuDb0W0IyRLVa+RvsQigA3Igt24eKuK6IUYlBaJ/guVl+LclIjxGQY5sw
         Zbw9aiWpi2kVd4+nj+hJC/I6A90ojwU+fjHcIo3sYvsOLxuAMXG5/IHtbVkTmV2eDSvA
         zWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HeJN9f1Z10RS6kmYpW2mlXYutbYxxEGXhrktNJI/FiI=;
        b=D7cpthav4pLaMC0rI5wGJJ1ZuHvvvMitVpbgsI8+cenENFMfpDiiyGCJKrJ5/FDw4n
         Q7uwAHW0wa4Liy//Fi8OUijfWxFWpuBypzJw4FpPggfAP9M729pUxqxB/b2lFRMm1OFg
         xSts55DjhZmNZudB8cG7YP5Gd6UlpnICB6l2yjzGV/mI533Vu+EEFcv04DsHQ7EeBlYP
         Xl+8i5MUa45SY3+rtB6XFFiOODeXtWsNny43cx4e8UD2YcyYmBYqM+p/NsW9rOmgh3Nd
         vxbcNYqLmxrofKej0vZ1BCvmyhWFhYPjm45zwmwqt1SncgIuycqklpBx2OYGqS3tgfy7
         OyCA==
X-Gm-Message-State: AOAM5330w65iF8Tmf/iLE5g0pW8kcQvYQE9Uuf83Tku/u0zZBsRFwGJL
        /zL1tClLGX8e418Q+3HLRD8=
X-Google-Smtp-Source: ABdhPJyclDqGuxinp7ETmsLEuRXVIZoMOGRaL4uJ6MEPRwaptHLx1zF23RJqHQeBoieLl6ZDLBXWAw==
X-Received: by 2002:a17:90a:1862:: with SMTP id r89mr389135pja.59.1598557912308;
        Thu, 27 Aug 2020 12:51:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p20sm2977705pjz.49.2020.08.27.12.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 12:51:51 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:51:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Robert Jones <rjones@gateworks.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: gsc-hwmon: add fan sensor
Message-ID: <20200827195150.GA233489@roeck-us.net>
References: <1598548892-17103-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598548892-17103-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:21:32AM -0700, Tim Harvey wrote:
> Add a fan sensor to report RPM's from a fan tach input.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/hwmon/gsc-hwmon.c               | 34 ++++++++++++++++++++++++++++++---
>  include/linux/platform_data/gsc_hwmon.h |  1 +
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index c6d4567..a86a0e5 100644
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
> @@ -324,7 +337,9 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
>  	if (IS_ERR(hwmon->regmap))
>  		return PTR_ERR(hwmon->regmap);
>  
> -	for (i = 0, i_in = 0, i_temp = 0; i < hwmon->pdata->nchannels; i++) {
> +	for (i = 0, i_in = 0, i_temp = 0, i_fan = 0;
> +	     i < hwmon->pdata->nchannels; i++)
> +	{

ERROR: that open brace { should be on the previous line
#125: FILE: drivers/hwmon/gsc-hwmon.c:340:
+	for (i = 0, i_in = 0, i_temp = 0, i_fan = 0;
+	     i < hwmon->pdata->nchannels; i++)
+	{

Besides, the line length limit is now 100 columns, so the line split
is unnecessary.

Thanks,
Guenter

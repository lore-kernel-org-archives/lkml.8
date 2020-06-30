Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27355C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D13E20724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2FDMCan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbgF3R7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390531AbgF3R7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:59:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDADC061755;
        Tue, 30 Jun 2020 10:59:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bj10so3540010plb.11;
        Tue, 30 Jun 2020 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FF1CCKbtJtqt6Q/pYRKenLml0HvaHdcmKl2JhZVArNM=;
        b=T2FDMCanxrLjiStIVNFqHMes676MPRpLG5S6N5caQna9whxiW/FqrzPgIl6R481yy3
         f6fciCq2zxl1JC/JhDp0qygodCtFnzTzWBnJ7HEBgiHN0sSeYEyRsx53buUc2OyX2gOC
         P+6O4SuMULSXQtHyJKmM/uC336E+aE8tzkMlcP4AADVF4vQODda6Tet9hVnadbMbCFqW
         wzpHG6GLbHpwXojLfrf2pnKepTil4NTG590nuMFhUZ0OB+ZcikJkqxaNYakXZqZNYvYZ
         4KtXNumpZHRu03pR6zV1jUSDv2w+tExTRLQ3WFCcCcfb41MjLt5JXE3aj620Kf3DLuvD
         q6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FF1CCKbtJtqt6Q/pYRKenLml0HvaHdcmKl2JhZVArNM=;
        b=IM8W0eTfvbUx5wZexugCFAPOUfQg7PVdkuojgTKdR2X48Ol0g56G4yYGI+dih9KS/g
         BdEUQ7GFtrcQ38G+mzcDSpujoR54MAZ554z+7czQUg3LfU33UOykKof5CklEnzqnNKB/
         XeD8GBqNzMBd8YpAxVYAUvNzz/6B8m6o/jDdvrENgqJcUNggpVJVOYU7B+r7OC1gTe/K
         H3LyNuJ9rc2NBBn5ZbmKb51wiqvfWHEakFcZQTjqzu2n4SSewmt1L9xbWBmK4C69lGu3
         FBhlXM5rtCsdHTUK596VrKTVJ0N6/0iE+xSXaFRT7Fh9IJ7XQc8q7lkJxk96V2JArmwN
         RMkQ==
X-Gm-Message-State: AOAM5329UXai3h/xyI+rf2qvR/FvbXHS93FMj3NkJf6F+mYBM6zyEP/Z
        8OAxNadbXQAquP1TSKs7CJOn+3ww
X-Google-Smtp-Source: ABdhPJx9G5bEpO+CfPHgGFPB2meXHaGqAf+bkXDYsH/t9yhybRklN/TL2ddXax2r2Mpafaqja+/drg==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr20465792pjs.37.1593539950495;
        Tue, 30 Jun 2020 10:59:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t29sm3357251pfq.50.2020.06.30.10.59.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 10:59:10 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:59:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jasonling@google.com,
        belgaied@google.com, zhongqil@google.com
Subject: Re: [PATCH] hwmon:max6697: Allow max6581 to set temperature read
 offset
Message-ID: <20200630175908.GG629@roeck-us.net>
References: <linchuyuan@google.com>
 <20200630174350.2842555-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630174350.2842555-1-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 05:43:50PM +0000, Chu Lin wrote:
> Per max6581, reg 4d and reg 4e is used for temperature read offset.
> This patch will let the user specify the temperature read offset for
> max6581. This patch is tested on max6581 and only applies to max6581.
> 
> Testing:
> dts: temperature-read-offset = <0xde 0x0>;

This should not be implemented this way. Instead, the standard tempX_offset
attribute should be used, with appropriate code to determine affected
channels (since there is only one offset value, and since it can be enabled
per channel). A secondary question is if and how to set the temperature
offset via devicetree; that will have to be documented and approved by a
DT maintainer.  I would think, though, that the offset should be specified
in milli-degrees C and not as raw chip data.

Thanks,
Guenter

> 
> verify: iotools smbus_read8 <vbus> 0x4d 0x4e
> 0x6F
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
>  drivers/hwmon/max6697.c               | 19 +++++++++++++++++--
>  include/linux/platform_data/max6697.h |  4 ++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
> index 743752a2467a..16c0f0995a12 100644
> --- a/drivers/hwmon/max6697.c
> +++ b/drivers/hwmon/max6697.c
> @@ -493,8 +493,13 @@ static void max6697_get_config_of(struct device_node *node,
>  	}
>  	prop = of_get_property(node, "transistor-ideality", &len);
>  	if (prop && len == 2 * sizeof(u32)) {
> -			pdata->ideality_mask = be32_to_cpu(prop[0]);
> -			pdata->ideality_value = be32_to_cpu(prop[1]);
> +		pdata->ideality_mask = be32_to_cpu(prop[0]);
> +		pdata->ideality_value = be32_to_cpu(prop[1]);
> +	}
> +	prop = of_get_property(node, "temperature-read-offset", &len);
> +	if  (prop && len == 2 * sizeof(u32)) {
> +		pdata->offset_mask = be32_to_cpu(prop[0]);
> +		pdata->offset_value = be32_to_cpu(prop[1]);
>  	}
>  }
>  
> @@ -586,6 +591,16 @@ static int max6697_init_chip(struct max6697_data *data,
>  						pdata->ideality_mask >> 1);
>  		if (ret < 0)
>  			return ret;
> +		ret = i2c_smbus_write_byte_data(client,
> +						MAX6581_REG_OFFSET,
> +						pdata->offset_value);
> +		if (ret < 0)
> +			return ret;
> +		ret = i2c_smbus_write_byte_data(client,
> +						MAX6581_REG_OFFSET_SELECT,
> +						pdata->offset_mask >> 1);
> +		if (ret < 0)
> +			return ret;
>  	}
>  done:
>  	data->update_interval = factor * MAX6697_CONV_TIME;
> diff --git a/include/linux/platform_data/max6697.h b/include/linux/platform_data/max6697.h
> index 6fbb70005541..ff98adfe9d8d 100644
> --- a/include/linux/platform_data/max6697.h
> +++ b/include/linux/platform_data/max6697.h
> @@ -28,6 +28,10 @@ struct max6697_platform_data {
>  	u8 ideality_value;		/* transistor ideality as per
>  					 * MAX6581 datasheet
>  					 */
> +	u8 offset_mask;			/* set bit to 0 to disable */
> +	u8 offset_value;		/* temperature read offset as
> +					 * MAX6581 datasheet
> +					 */
>  };
>  
>  #endif /* MAX6697_H */
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 

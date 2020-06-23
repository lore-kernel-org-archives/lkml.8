Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609EFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFEC20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnuI8SD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbgFWOJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbgFWOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:09:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B6C061573;
        Tue, 23 Jun 2020 07:09:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j12so7926898pfn.10;
        Tue, 23 Jun 2020 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6CF8vjhhgIZo1ja5yF53YUskm9EJFxyNwTUyh8iFv+A=;
        b=OnuI8SD1XxdeCCoPEDw2wrjWMcFF5qMNpYB6vlmrEnu7zlyll4QOP127Qdmm8KQIEh
         2Y1AABJw2JnF9/ehclikoXg7Lvp+GXaZgImkhi/73U9Q/vGgVjawZhRqwxJPnD83ali8
         +JF2+mgQ+4XlwXPiGT/BLnK/9jfz3nUFJQ2TujstE5wL7T8iBSOejoumrNYtJ3YfYQo9
         3xxeOu2JoPvVG0lfYKQyXXv8SdTQwnFuYeUqcYSN4FSfO6TRUlxcd+/QzxdISqVrkdFd
         OnP9P2Rjk+gQ/groH+dkmTOHCZ1DQSKTVgn8zzjfvAalgACBpDwIuZ6MC7lJ+LfZqnpw
         RkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6CF8vjhhgIZo1ja5yF53YUskm9EJFxyNwTUyh8iFv+A=;
        b=KG7/w1cHtm9BqG/kTz9Jzvkfg1eJsBwBUsGvgfRRw84W6T5UUAa+h/rJwnCZzc6Qx/
         hxuYBMydGhBTbprmzgJg+a4tsi1VXecxFnfmjd0Ws1ziBE4nDyjoJJGW+De2e4r+Opql
         1/QRzZCp+nCCFBcbIrNPLjIvSJGGeCiit3X28l8LA7kTpGg7o1WJ5qonF3p5ogmKrdO4
         +ccJOoMIhNDVYQiLqRgrc2P9Lhpt7TkxiSEddE1GkcD5TTOIE6sBI+zM7rI8Kqy0xZhY
         yhQRiLsT3mAEzJotruugkvGguBUL68fXvowMO66lpfNdSyFtN3MSY/0brWIXRrFSgxBb
         fzJA==
X-Gm-Message-State: AOAM533KWDpD64k47hfhFN4lHZCxHX/zYbZ8fE5oBsGfHA4b1RZmqCfS
        Dsc6VFhc+5jUictq41Yk7Rc=
X-Google-Smtp-Source: ABdhPJyveVFQMmZZKi4ydYB3gHkJv2ByKJ5ijDsnuRsr9IqzbxFfDQ/e7dxZcZie/tEbLAwEZsCK9w==
X-Received: by 2002:a63:6741:: with SMTP id b62mr8226349pgc.58.1592921378639;
        Tue, 23 Jun 2020 07:09:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m9sm17034387pfo.200.2020.06.23.07.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 07:09:38 -0700 (PDT)
Date:   Tue, 23 Jun 2020 07:09:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (gsc): add 16bit pre-scaled voltage mode
Message-ID: <20200623140937.GA14394@roeck-us.net>
References: <1591714640-10332-1-git-send-email-tharvey@gateworks.com>
 <1591714640-10332-3-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591714640-10332-3-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 07:57:20AM -0700, Tim Harvey wrote:
> add a 16-bit pre-scaled voltage mode to adc and clarify that existing
> pre-scaled mode is 24bit.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/gsc-hwmon.c               | 8 +++++---
>  include/linux/platform_data/gsc_hwmon.h | 3 ++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index 2137bc6..3dfe2ca 100644
> --- a/drivers/hwmon/gsc-hwmon.c
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -159,7 +159,7 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	sz = (ch->mode == mode_voltage) ? 3 : 2;
> +	sz = (ch->mode == mode_voltage_24bit) ? 3 : 2;
>  	ret = regmap_bulk_read(hwmon->regmap, ch->reg, buf, sz);
>  	if (ret)
>  		return ret;
> @@ -186,7 +186,8 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		/* adjust by uV offset */
>  		tmp += ch->mvoffset;
>  		break;
> -	case mode_voltage:
> +	case mode_voltage_24bit:
> +	case mode_voltage_16bit:
>  		/* no adjustment needed */
>  		break;
>  	}
> @@ -336,7 +337,8 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
>  						     HWMON_T_LABEL;
>  			i_temp++;
>  			break;
> -		case mode_voltage:
> +		case mode_voltage_24bit:
> +		case mode_voltage_16bit:
>  		case mode_voltage_raw:
>  			if (i_in == GSC_HWMON_MAX_IN_CH) {
>  				dev_err(gsc->dev, "too many input channels\n");
> diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
> index ec1611a..37a8f554d 100644
> --- a/include/linux/platform_data/gsc_hwmon.h
> +++ b/include/linux/platform_data/gsc_hwmon.h
> @@ -4,8 +4,9 @@
>  
>  enum gsc_hwmon_mode {
>  	mode_temperature,
> -	mode_voltage,
> +	mode_voltage_24bit,
>  	mode_voltage_raw,
> +	mode_voltage_16bit,
>  	mode_max,
>  };
>  

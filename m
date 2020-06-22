Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F657C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EB020706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLtn236B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgFVLOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgFVLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:14:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1419C061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:14:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q2so13807644wrv.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F2NPYrA8TUG18okYjngm1OvmY6lDQ7IMqBV+pKwmot4=;
        b=nLtn236Bgp7j+T7xS0LPk9VLrZZImPxcZ6gFAZYJ3N1bHZSz1E5GQ4TEJT8G20RfCQ
         MS4aVbAniQ+9H72EomJ5hdm2NP4KrYJKH0RIZfN3WJMyfvqWUeznrda2MmXxlwj7btvI
         C8TBX5Ddskw+7yUhdwcaS7aDKYZxdhd+nUWhHt44lbCZlS2heyumAnbmfPD232tnhHa+
         RsdXX/TNDJFnk6DDrLmGI4McnKCRGp4PsEp3qy/unez3LfPOYhk0IyDouqfImTsg9Ci8
         puG3o8kGeuNaKf+NWdxVHjlu67/C8+8ZYasu8p3pIUoCipTdnEW+x3TVQssBDEuFKTHy
         OfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F2NPYrA8TUG18okYjngm1OvmY6lDQ7IMqBV+pKwmot4=;
        b=jsJMvH4Fg8/aAs+WvZRVm+8cfYaQk2J1Vah5byq+oMCeZzXfUEdqqeuet1Vw6Kuso4
         46j/B34be0vlpsYHJGUYpIDLxdYcAweepBWV1PvYH49Hh0VZhhvIjDa4qdYIgQQQkloA
         9VdjyJ0rIPg1hzGj5GtmigFZk2lmVjdTszqjfHbCgsbMRORZlRbwJyXrNUoYBT+ZsBNw
         y6FeusIAwG1ujckRRnuT7ehthcffosIBpLjev8q6swQUIGI7uM9OiewFAy6vev3N2/PO
         i1uZZIUtbH4zSW+ZaBAFvsTKTSqB2Zoy3NSMq9lzY3lnTk5FM9uW1CukKDhSIK6/zt4X
         eDFg==
X-Gm-Message-State: AOAM533D4dOqUUDtY9wBMnxpcxNem108dmo5HbDhPQA+AMNdJaPx+C56
        aGZ8QhghUdeeSpwtH4C05beYug==
X-Google-Smtp-Source: ABdhPJynq2QWsup2B5/k+Cvj+7u07Ik3g+ZkD7wIB2mFdHcEV2OSczDPFFH6HCrWh10XnRML412UBw==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr4101818wro.124.1592824455563;
        Mon, 22 Jun 2020 04:14:15 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id q1sm2904444wro.82.2020.06.22.04.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 04:14:15 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:14:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= 
        <JohnsonCH.Chen@moxa.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] mfd: ds1374: Introduce Dallas/Maxim DS1374 MFD core
 driver
Message-ID: <20200622111413.GV954398@dell>
References: <HK2PR01MB328111AB2520315A7D4A1172FA970@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK2PR01MB328111AB2520315A7D4A1172FA970@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020, Johnson CH Chen (陳昭勳) wrote:

> Dallas/Maxim DS1374 is a counter designed to continuously count
> time in seconds. It provides an I2C interface to the host to
> access RTC clock or Alarm/Watchdog timer.
> 
> Add MFD Core driver, supporting the I2C communication to RTC and
> Watchdog devices.
> 
> Signed-off-by: Johnson Chen <johnsonch.chen@moxa.com>
> ---
>  drivers/mfd/Kconfig  |  11 +++++
>  drivers/mfd/Makefile |   2 +
>  drivers/mfd/ds1374.c | 101 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 drivers/mfd/ds1374.c

Not sure I see the point of this driver.

How/where is the device part registered?

Is it DT only?  If not, what else?

Also where are the bindings?

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 687e9c848053w.d16031f4b487 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1980,6 +1980,17 @@ config MFD_STM32_LPTIMER
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32-lptimer.
>  
> +config MFD_DS1374
> +	tristate "Support for Dallas/Maxim DS1374"
> +	depends on I2C
> +	select MFD_CORE
> +	help
> +	  Say yes here to add support for Dallas/Maxim DS1374 Semiconductor.
> +	  This driver provides RTC and watchdog.
> +
> +	  This driver can also be built as a module. If so, module will be
> +	  called ds1374.
> +
>  config MFD_STM32_TIMERS
>  	tristate "Support for STM32 Timers"
>  	depends on (ARCH_STM32 && OF) || COMPILE_TEST

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

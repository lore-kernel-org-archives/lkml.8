Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31334C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CABF207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVWCPKGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgETJbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETJbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:31:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F204C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:31:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t8so2595064wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vnMYNrD5xFrqPZ12P+CUYTuQR/zTD6kL3bib8/4eAFA=;
        b=nVWCPKGtDsfqcZpiCWP93jC50VzOjkoDTLJHO/l0sfwdq/yYogmFoEhraSXDbBFYE3
         wKcBgirsp4/ZxSPX/9x9Qd3uP5i2daOEkdGL5tQoOINJACVZ+LWnepPZT+gWoTBxtraa
         dk2Pn6LRlufZs48w15o9mk3oLI/Q0HsZokX9jpG5fZPxATB8VX7bii5QUssKwrjdfPl4
         pi1qdiuAJ+9h/Xg0xLnsHEL14wJDeoeECXTSj3vhyWBcHTGO1SBqRJguYnyvVSlsKjLK
         /UHL/ViMeC5qdHjmGJ9rAv7gHkiQIiL+KUkWEE6fwnqyQsF8bHpiW7qV+K+PJ7mDQIYk
         wf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vnMYNrD5xFrqPZ12P+CUYTuQR/zTD6kL3bib8/4eAFA=;
        b=IgNd9KPDqAw0yx73k3Mf8D1Olq7yNJkt3jtHIj0QRgIeqKAJb06soPaWcbUypHdp9n
         m6x7oXvXfoXNWyIO8mSGKMCvRTzjfYaMmQur2ToTkWgV+5yw4FHKbgEuPCTnRiIys72n
         gv6o1IjsbJ0VMyzLNip5qGYK4Xq95jATfU4zoCy0n/DG8titTZ2jgHpbSjQdPXEGpGdV
         pb4/Ajmdluc0c/gEC2B1CPS4529oEvx24j6+jkCdFzTnfp+2okAITUsebOTQBPf0JIpt
         zClIppH/KlYlB3CYr+igbvnM6dsieodGjwzFkwdbsHUamcel7VQJUGKO2objdyOYKrRl
         NeWw==
X-Gm-Message-State: AOAM530XhI8cxULTFv9RuIxfBB4lnazLZLXix36Y3PCnbab+KOtzuHci
        BFzL3vTnkZyosohHscCHvJ2jGw==
X-Google-Smtp-Source: ABdhPJxndAFdMDpnRlOmd3ffH7tvbO+BIRPhKt4GQ3SNY1ddPhzylWyt34uhdI0/+WwoQFCJ//eB8A==
X-Received: by 2002:a1c:bd56:: with SMTP id n83mr1935210wmf.139.1589967063211;
        Wed, 20 May 2020 02:31:03 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id n7sm2184521wro.94.2020.05.20.02.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:31:02 -0700 (PDT)
Date:   Wed, 20 May 2020 10:31:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH 3/3] hwmon: add Gateworks System Controller support
Message-ID: <20200520093100.GH271301@dell>
References: <1589565428-28886-1-git-send-email-tharvey@gateworks.com>
 <1589565428-28886-4-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589565428-28886-4-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020, Tim Harvey wrote:

> The Gateworks System Controller has a hwmon sub-component that exposes
> up to 16 ADC's, some of which are temperature sensors, others which are
> voltage inputs. The ADC configuration (register mapping and name) is
> configured via device-tree and varies board to board.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v11:
> - no change
> 
> v10:
> - no change
> 
> v9:
> - use exported gsc_{read,write}
> - added Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> v8:
> - move regmap init to hwmon
> 
> v7:
> - fix whitespace in Kconfig
> - remove unnecessary device pointer in private data
> - change divider from mili-ohms to ohms
> - move fan base property to reg
> 
> v6:
> - fix size of info field
> - improve pwm output control documentation
> - include unit suffix in divider and offset
> - change subnode name to gsc-adc
> - change to fan subnode
> - fix voltage offset
> 
> v5:
> - fix various checkpatch issues
> - correct gsc-hwmon.rst in MAINTAINERS
> - encorporate Gunter's feedback:
>  - switch to SENSOR_DEVICE_ATTR_{RW,RO}
>  - use tmp value to avoid excessive pointer deference
>  - simplify shift operation
>  - scale voffset once
>  - simplify is_visible function
>  - remove empty line at end of file
> 
> v4:
> - adjust for uV offset from device-tree
> - remove unnecessary optional write function
> - remove register range check
> - change dev_err prints to use gsc dev
> - hard-code resolution/scaling for raw adcs
> - describe units of ADC resolution
> - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
> - ensure space before/after operators
> - remove unnecessary parens
> - remove more debugging
> - add default case and comment for type_voltage
> - remove unnecessary index bounds checks for channel
> - remove unnecessary clearing of struct fields
> - added Documentation/hwmon/gsc-hwmon.rst
> 
> v3:
> - add voltage_raw input type and supporting fields
> - add channel validation to is_visible function
> - remove unnecessary channel validation from read/write functions
> 
> v2:
> - change license comment style
> - remove DEBUG
> - simplify regmap_bulk_read err check
> - remove break after returns in switch statement
> - fix fan setpoint buffer address
> - remove unnecessary parens
> - consistently use struct device *dev pointer
> - change license/comment block
> - add validation for hwmon child node props
> - move parsing of of to own function
> - use strlcpy to ensure null termination
> - fix static array sizes and removed unnecessary initializers
> - dynamically allocate channels
> - fix fan input label
> - support platform data
> - fixed whitespace issues
> ---
>  Documentation/hwmon/gsc-hwmon.rst       |  53 +++++
>  Documentation/hwmon/index.rst           |   1 +
>  MAINTAINERS                             |   3 +
>  drivers/hwmon/Kconfig                   |   9 +
>  drivers/hwmon/Makefile                  |   1 +
>  drivers/hwmon/gsc-hwmon.c               | 390 ++++++++++++++++++++++++++++++++
>  include/linux/platform_data/gsc_hwmon.h |  44 ++++
>  7 files changed, 501 insertions(+)
>  create mode 100644 Documentation/hwmon/gsc-hwmon.rst
>  create mode 100644 drivers/hwmon/gsc-hwmon.c
>  create mode 100644 include/linux/platform_data/gsc_hwmon.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

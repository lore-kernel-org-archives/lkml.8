Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6225C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590862080C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rA7MZUNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgIIH3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgIIH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:29:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36950C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:29:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o5so1712638wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BZ8RXegySGeoJk+wN/2vvp3919c667CnLtuJwaGm4UI=;
        b=rA7MZUNgB6lDWQJvebD6M4MW4YI4i2epDptj4XITRyX8Jm4bal36uRAE2mdVW0iZ/h
         FVRBy9gYzA2XCQIZzjEuerRO/6xJPQka+R/aSrpgj8/hDxbDG2+KIXKhlwICIihSpCXc
         lUqdyqzm7+wfpos9rGiYoA0UWSDHiHFh2Y3/8/d5GH294KX2gCmrfHuK6IAN5diylxlH
         MKmddMPJYnfRIT3qS/7BstMiVRfBpfTGvKk7FO6A6jsADL9rX7SUOg0ddnpG0eNsCDIg
         8tC0BersILr8JWxelBgWcXkJ0bessSWA9yY92xsWdx95sFLvj4IXRMmAdaBBpCF2i7WY
         yfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BZ8RXegySGeoJk+wN/2vvp3919c667CnLtuJwaGm4UI=;
        b=GQhllO+hGTYDCER4ZvQGDbmbf+JXatQcgVnSxAdYkasKPKQodxRWxpd66c1O1p2Cn/
         ICEROHIlMtzR7dSYIeRuru/AWJm4W1jazwQSnbtK9CjV6QxBMnF9xl457kpvKmfdxF6O
         rcCd6bdESOwukzKZEv7QmB8Wu11m6wtuAhmkGKias6uS/ira/nuiJ76duOueDaf3ks4y
         dyQsiRXdfl7gZQow3aBzwS1pzGjRipduPkL4omtM8+yYlHdOjfOzMwvodbzrIxYN95+C
         k3LU1GtmPTZpalyse85Ww1IR9soRr2JrgnU9s2vrvHhHpmefUCW8jFgK1DwNXGQ641sO
         eCIA==
X-Gm-Message-State: AOAM5310kPrPFCfl8jqgr5XX2Mnu+ucmEXtphFVMDMAjqVg0YulwB5Ct
        5a0drryjBIs7CIJMo2Qi9/yDEQ==
X-Google-Smtp-Source: ABdhPJwdVGegoo/0XAhfDUhAZ8CcPYyvkfqzJEjkZuhFKvqxnC+YY8TpkgBcS64Cgt2j+4/WsWB0iA==
X-Received: by 2002:adf:9125:: with SMTP id j34mr2611297wrj.157.1599636538491;
        Wed, 09 Sep 2020 00:28:58 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id b76sm2583153wme.45.2020.09.09.00.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:28:57 -0700 (PDT)
Date:   Wed, 9 Sep 2020 08:28:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     SUNGOLD <suraajvashisht@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: drivers: mfd: lm3533: Support for DT bindings
Message-ID: <20200909072856.GB4400@dell>
References: <CAFiUnPa-6eRCPhz0omojCUi-OxQmCk3YoX3NF_n9mx3bz6fc7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFiUnPa-6eRCPhz0omojCUi-OxQmCk3YoX3NF_n9mx3bz6fc7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020, SUNGOLD wrote:

> Hi, I am a high school student and a Linux enthusiast and for my free time,
> I'm trying to mainline a spare device I had, it's a Xiaomi Mi 4i
> (xiaomi-ferrari), till now I've got some basic bringup (had to bring up
> touchscreen Atmel mXT336T using the downstream driver as the mainlined
> generic atmel_mxt_ts.c has no support, so committed a sin
> <https://github.com/SUNGOLDSV/msm8916-mainline-linux/commit/6280fdb9750b1dc40dd4d769118d8ba71cbb0a0d>
> ;)
> 
> I'm currently working on implementing backlight for my panel and it uses
> LM3533 for it's backlight and notification LEDS.
> 
> I tried to find any dt-bindings docs about it and I finally found a patch
> <http://patchwork.ozlabs.org/project/devicetree-bindings/patch/20161226181153.11271-1-bjorn.andersson@linaro.org/#1545653>
> that was rejected and I followed it in hopes of initialising the driver,
> and it didn't work out as it was not even initialising.
> 
> With me having almost no knowledge of C, I tried to understand the
> `lm3533-core.c` while reading some docs on building a linux driver, and my
> interpretation is that the driver was not written for devices that use DTS
> and it was actually written for devices that use a board config file such
> as imx arm based devices.
> 
> Now I request you to add support for devices that use DTS or I might have
> to commit another sin ;)
> 
> My Github repo <https://github.com/SUNGOLDSV/msm8916-mainline-linux>
> 
> Thanking you
> sungold
> p.s. just asking for advice and help, this is my first mail to a dev and a
> mailing list

Good morning,

Thanks for reaching out.

I think your best bet is to follow-up with Bjorn (now Cc'ed).

Keep up the good work.

Kind regards,
Lee

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

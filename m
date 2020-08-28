Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82C9C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6722080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nl6Y97MI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgH1JPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgH1JPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:15:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A195CC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:15:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w13so606507wrk.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DyS9aZq/xs6zouph/9AtxWEvp+h3V9CCefV4eIl9S4M=;
        b=nl6Y97MIFxIpC7Bk4tfVgBT8u4TJTbwxPVOzEh2b/lL3jk59hkL8h2bD6d5DGyQLR4
         47yuudgVUrS1gfMfr5poWFMS4lE7YLogH8T39HrlJ5F0jWICxo5srW7MrGYLuYbS9HAX
         cR+BmDZ9R01dYgUj7NG2Q7BoY6L1QE3HHd7I9+/8XC5T1TcREbDFA003y2hyNF/Hh/IZ
         hwyuT68VnNcXlmZRT62VFqD1MGT6ynuPg5lAqulypzAFkH5NXbyOp6DDBJQVGy8FoTFA
         e4i0HXyLEYncqy3hOAswyg+Dd+l2EvaekK++xgosQ+v7Q1iLoHYxLhc1llxHU++NVFvM
         7pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DyS9aZq/xs6zouph/9AtxWEvp+h3V9CCefV4eIl9S4M=;
        b=reSHG5LaCxQOSqM4yjVEdF73zp2ZKFAW7/UHfYLvABCkvawVWfHDWqNLcsBct0qvF2
         L8VSCmVG9GqqAIBU3ECZQ9153ZEnCMG9r4/54UEAuo7lqTTWO0QXrV7vnuQSGdkFXG4N
         COOj8XBIfMk5xkC0+zyglrda642LHq2dygS4m3QvQZATurgRm2gJggU8vjQltYSOlLQs
         WNQH0IF5/7IuVWjg/IltGumNk6HR9U8bj8yi8dBZ/A8mD1me/fZkbRYtvT0E8HGtTi3f
         BjBCBa2oTYHUzC4meIj933es6IyGXraCxJ4hRq1CU8cVzqb79ImzBIC7GE5ATk5F2nWS
         4GMA==
X-Gm-Message-State: AOAM533LAY7s3A4l1xuQF5MDGOFUtToIAP0DtZHz/uJfE+pjeBMFdVCc
        ln8P21856dvaeqjH4RCHbjmfHw+YTmLOVw==
X-Google-Smtp-Source: ABdhPJzPbwAdjzVQkwNrEAzUuWKOth9o/dWf66Vg0RWuqSAzGs0y1rEjdvHnIjI/xWHpDMOD+hOSCg==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr551838wrv.405.1598606123291;
        Fri, 28 Aug 2020 02:15:23 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id q7sm1001982wra.56.2020.08.28.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:15:22 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:15:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mfd: ene-kb3930: Add driver for ENE KB3930
 Embedded Controller
Message-ID: <20200828091521.GC1826686@dell>
References: <20200709231228.11564-1-lkundrak@v3.sk>
 <20200709231228.11564-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709231228.11564-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020, Lubomir Rintel wrote:

> This driver provides access to the EC RAM of said embedded controller
> attached to the I2C bus as well as optionally supporting its slightly weird
> power-off/restart protocol.
> 
> A particular implementation of the EC firmware can be identified by a
> model byte. If this driver identifies the Dell Ariel platform, it
> registers the appropriate cells.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v5:
> - Clarify the command in kb3930_off()
> - Remove an extraneous comment above the call to devm_mfd_add_devices()
> - s/pm_power_off == NULL/!pm_power_off/
> 
> Changes since v3:
> - Clarify that the power-off function is provided by this driver while
>   LEDS_ARIEL is necessary to drive the leds in Kconfig help text
> - s/kb3930_power_off/kb3930_pm_power_off/, s/global_kb3930/kb3930_power_off/
> - Don't fail with -EEXIST with more than one instance
> - s/ret < 0/ret/ for devm_mfd_add_devices() return value
> - Drop a \n between struct i2c_driver and module_i2c_driver()
> 
> Changes since v2:
> - Sort the includes
> - s/EC_MODEL_ID/EC_MODEL/
> - Add a couple of clarifying comments
> - Use #defines for values used in poweroff routine
> - Remove priority from a restart notifier block
> - s/priv/ddata/
> - s/ec_ram/ram_regmap/ for the regmap name
> - Fix the error handling when getting off gpios was not successful
> - Remove a useless dev_info at the end of probe()
> - Use i2c probe_new() callback, drop i2c_device_id
> - Modify the logic in checking the model ID
> ---
>  drivers/mfd/Kconfig      |  11 ++
>  drivers/mfd/Makefile     |   1 +
>  drivers/mfd/ene-kb3930.c | 212 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 drivers/mfd/ene-kb3930.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A5BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D529D20773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZse55qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390014AbgFYGnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbgFYGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:43:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568DDC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:43:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so2122941wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T1pmjhgsNTk091RaYm31ooGiGs4gpOBrKUYgQuZlqHM=;
        b=BZse55qAiC3YfYLdIQqPuA5+DPwgkKScMKNg/h4JVt+eNxqyzWzg+4RCgc/4QzK/de
         IT7Fiw5Y5C4YfW8JqtgaFLCQIDYLr4FXYuhOXWa87XKoXtsqr/RIGBBFVAzrxt3mgwhY
         fch0v4d6aC953Wk+oJVkIpH674JE+LnN9nG7shGGvszDdy8XoZfhkcyT84Oc7+GIZvct
         /l1i5gcArVlgaIVLpzU4vkyYb1vntwJKgoRrS1oBEqA7NNLDrlxfNAnzBMJ5xQsEatoN
         5Fv2efLoaQcaUOx7rPg/WjR8DkDlY3DftcCZpsrdL664AWHBiJazbGVFE3O47nZtfHgC
         OQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T1pmjhgsNTk091RaYm31ooGiGs4gpOBrKUYgQuZlqHM=;
        b=Z+4fKyRELlnxBcozVqu65UZS7yCbPOA53CQxfKg7wO7CbEozIEwgWzArnCryhvB3WN
         w71h4Wlmyvo1vpdaw/oJTMKBg9SsVxrIZev+iHH4E4Q/4P+2E0sSFGNyrzzmiLL4uTtP
         FHocABgRzhVp7BF8LCuwxJl9X9EuL1H/OydZVp6u9wM+OBflBO9GarlHC/CVxnfByQA9
         bWljgkKTROZsB5iqCmnITFCTm42gmvdJ2eTh9oBawxrwB2R+VpHqulmVz3eASbhGHlhj
         +y7Rzx4LiOGxsm1rU75h5UOUCcWL7wdk49w3O/XcvjHtkMGHtEtSuWLxyPUFrnLhm4Gv
         uyuA==
X-Gm-Message-State: AOAM532vi1FlL1j9rxP+OPcGKvfVJ/nvhTzpJlLn3nljMtQgYzwH2Fg7
        zFvkm7ENfo6QpCJpYXHBxtCsU5BNOtk=
X-Google-Smtp-Source: ABdhPJy1S/a+AMaeSQFU5/H9jGC6zRm2J783jA1FKw6ZOCKPHQ7SzwS9JmNv+hZp+cgOowTDDLCGwg==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr186414wrm.387.1593067409915;
        Wed, 24 Jun 2020 23:43:29 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f12sm40402wrj.48.2020.06.24.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:43:29 -0700 (PDT)
Date:   Thu, 25 Jun 2020 07:43:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 1/2] thermal: add support for the MCU controlled FAN
 on Khadas boards
Message-ID: <20200625064327.GL954398@dell>
References: <20200624161528.12664-1-narmstrong@baylibre.com>
 <20200624161528.12664-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624161528.12664-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Neil Armstrong wrote:

> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
> on-board microcontroller.
> 
> This implements the FAN control as thermal devices and as cell of the Khadas
> MCU MFD driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
> Hi Daniel,
> 
> Is it ok Lee applies this patch via the MFD tree since it depends on
> the linux/mfd/khadas-mcu.h header ?
> 
> Thanks,
> Neil
> 
>  drivers/thermal/Kconfig          |  11 +++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/khadas_mcu_fan.c | 162 +++++++++++++++++++++++++++++++
>  3 files changed, 174 insertions(+)
>  create mode 100644 drivers/thermal/khadas_mcu_fan.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

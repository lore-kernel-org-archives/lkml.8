Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF32C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86BA20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OawI+57Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgH1K54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgH1K4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:56:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840CC061235
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:54:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so85052wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lXtF9bbCATgKOcQQrLawl15aRDCqn7csOAK/tInxTck=;
        b=OawI+57Qp29KR7NQ10qS2S7D5MsB7PEAoqQA42/bCYhW77FiXwXbJ85u81nWbx4lG4
         QX73cCMmKknFGKyHz4Dl5mV6UYC720ElmlqK5EsZA0hUPHjDgooCkFj/hkLQOxYFqYjV
         hA1ToSuIwToPCGFK9FRLncszchC9FoR2FasPyCL4NwzsqtMqah12Nbrcyvt2iC+lwAN8
         gSgy/TCLPX+1/O6DKxIG3f2cO/H7foWjSLxpFV0OLlCmMEjokR9yeePmi58kblQneXa7
         nYBwQHAIUmhrXGtnuaokDJwO/CL8RihqfTJKUhT+i1lVRJTi5z70WJIdTEbQFLN61QqV
         9ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lXtF9bbCATgKOcQQrLawl15aRDCqn7csOAK/tInxTck=;
        b=KACwUkoq9JRmvwpmDs5LYgfSY2LklR2k6AfrjRPjSw9SVPBCduEoWLzEKV3WsjN+r6
         WaQLEVdFWSAyuIS5nbcJfbhdq83AMsoV24/j0JbJEb7vJIJYus19oGaFfcfRWwZfkIqY
         qlH3xZuDiqBN4S6xUPpFbwJcAE/g98GxAeQf8VioeG+DDkf5VnW289DQVaW7I2gj+Pug
         VG1c0nzjvyrld1jECsl4k+o07s73mTTowhugcyUcC4TxxX7gWSAG3y3pcCzSReKuHCBf
         GDqgogseopb0dMkLp9x+h7EnKo/I4Ci7SiBf7EMSYRaUZjeRQyeN71b/B7fZxbe09bzY
         tkyQ==
X-Gm-Message-State: AOAM530mfZdsl70eOZnQuIj/vbQVHXWKm+A1P9PUWlCX0nOKtocI26Aa
        OmcLIj6WU0/8fSb2Lt3gR02gzA==
X-Google-Smtp-Source: ABdhPJx9GGnD6owZ14uJV+jsVBABWaMPcIPeZyv6FfCVmNTKFDjPRE5yQEOh34lyF1kQDxKMTxy1pQ==
X-Received: by 2002:adf:ed05:: with SMTP id a5mr422004wro.364.1598612073121;
        Fri, 28 Aug 2020 03:54:33 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id y3sm1377779wrs.36.2020.08.28.03.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:54:32 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:54:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v3] mfd: sprd: Add wakeup capability for PMIC irq
Message-ID: <20200828105430.GT1826686@dell>
References: <20200818034158.28667-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200818034158.28667-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020, Chunyan Zhang wrote:

> From: Baolin Wang <baolin.wang7@gmail.com>
> 
> When changing to use suspend-to-idle to save power, the PMIC irq can not
> wakeup the system due to lack of wakeup capability, which will cause
> the sub-irqs (such as power key) of the PMIC can not wake up the system.
> Thus we can add the wakeup capability for PMIC irq to solve this issue,
> as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
> a wakeup source.
> 
> Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> Tested-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> Changes from v2:
> * rebased on v5.9-rc1;
> 
> Changes from v1:
> * addressed comments from Lee;
> * added tested-by from Chunyan.
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

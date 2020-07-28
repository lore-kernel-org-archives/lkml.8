Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66111C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452BA2177B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCVoNr4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgG1IBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgG1IBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:01:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:01:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so15830800wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cl2Y8+UeWIcQOUYHyUUm8iQ4vz6rg42HiHq1hxLCw94=;
        b=oCVoNr4kSknIwQv3QH4akfeIoF76h2vCWItpOPuXMROvtzNhlOUkNZRagI4gdLajNw
         RxjSKaXPQI4/t7yG0CrEaPLhKW/Jt9QeQpl/G86mVfsmRJyFnzLo/ne49H/CbXMaFpmD
         SWEIp154/Ts7nokLagaabgCoWku8W3STV9vKCANkJXhd1828B+jnGJCl7k9Ca3s3DPrJ
         C43BHQ6WnL3OgCABznwVyW0rVqxMVknS1QuVu0cMDmp2bWQN3F0fd7ksSDBa2VvWT7RG
         8LiWYi7kdneV8IQxoFsb5k/HU+BziWUyE4Gc6fZw/TcUojYHrwG136tTElP6HqIUyoSd
         EHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cl2Y8+UeWIcQOUYHyUUm8iQ4vz6rg42HiHq1hxLCw94=;
        b=r3h0i9w4DrdITeBoVnNoj2pu1dHyfhq5j7/xhysoxA+ISfuVc4sVJThdCqRerm7H9/
         JaM9WBiHQKS2jTC06dCZHbkWHpNVCVrY+pdYu7fyHlEbpfCatSrB0LVRs3vXXaODcycT
         hn8mYbdHsWjAKZwYSHDdh05Y1J/SCsIl2UVPq8kDk9fCDQ/H+X4LC6a8bH8vOtiIN1tO
         +R6eMXtaj/BjjOJRvq74HoyrbX5g4IFx9AO4Vo1a9tEW9l4CfZAr67bl9k8kOtqBfP1D
         rfn0hi/F9Wbb0xpSISpBKyo/JKPy8pkITE4MReR/l6XyScoMfW8bDWpLTDWHdwdEqH78
         fYzw==
X-Gm-Message-State: AOAM5300WCZu6C5Y+v8GiUt9crtbcDHEgZ6G2F+wRTNI2+mSsa5T7nmF
        YBWvRLQeg7/7iVOqP32e1NyRdw==
X-Google-Smtp-Source: ABdhPJy2s4pTiLQuSH77Tv8Uf2Ai9QVNv+BvYoHvXsKhFioKgFWMC0nrd5lw6fWG+BjGNFcqWsIu8g==
X-Received: by 2002:a1c:b156:: with SMTP id a83mr2930705wmf.189.1595923301783;
        Tue, 28 Jul 2020 01:01:41 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id t11sm15904778wrs.66.2020.07.28.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 01:01:41 -0700 (PDT)
Date:   Tue, 28 Jul 2020 09:01:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [RESEND PATCH v2] mfd: syscon: Use a unique name with
 regmap_config
Message-ID: <20200728080139.GI1850026@dell>
References: <20200727211008.24225-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727211008.24225-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020, Suman Anna wrote:

> The DT node full name is currently being used in regmap_config
> which in turn is used to create the regmap debugfs directories.
> This name however is not guaranteed to be unique and the regmap
> debugfs registration can fail in the cases where the syscon nodes
> have the same unit-address but are present in different DT node
> hierarchies. Replace this logic using the syscon reg resource
> address instead (inspired from logic used while creating platform
> devices) to ensure a unique name is given for each syscon.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> Hi Arnd,
> Lee is looking for your review on this patch. Can you please
> review and provide your comments.
> 
> This is a resend of the patch that was posted previously, rebased
> now onto latest kernel.
> 
> v2: https://patchwork.kernel.org/patch/11353355/
>  - Fix build warning reported by kbuild test bot
> v1: https://patchwork.kernel.org/patch/11346363/
> 
>  drivers/mfd/syscon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

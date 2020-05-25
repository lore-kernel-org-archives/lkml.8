Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5117AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224E72073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yg8gdfXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgEYJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:15:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D73C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:15:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c185so2822392qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HeEd+c60FRjGCeCKuVMamBqIVW2/NUYQpKTyT80oXTI=;
        b=Yg8gdfXs5pSQWW3x56xKtevqhewuVztrJEEaWdVsBMSME6Y4Ypd+c0CaOMO7MvTRyr
         g+JpjYkMg4Q3dkKT82pppC7RJ3yTmqWIUXQBMUdnx8jc9479XEnY16QMqC5bbWnCOcXz
         paO0kg2XqvfByl1uiK5D5/Kl8V3ms8mQJWyQzv6c7auJdXSfLnuCEcqInEuUbb0GFiBa
         kOM0sLLwClsMN0yrx5zwAH7APBAplrB1EskhAIzgaSv5Awtv3YR2vkQIJuQE4xSBgiQt
         1ZdeIYLDmKyQtjMy9QfLYhoHgClU1DbP1TVhfzlTJbkDhWMFpSz67Jcx/rCNFHgjUWsF
         Dz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HeEd+c60FRjGCeCKuVMamBqIVW2/NUYQpKTyT80oXTI=;
        b=mC/oCe47La1jZmbfyu2GUPln9TgolLlVa5HU21bamNxUyk/hXF+SkV4//SjGnOQgWO
         HT2Atf2aYj1tJ+0lB96EBDOZP9bJkwTyjPOuwUtB4dV7/sa88Xrq14dEHAy5twzyc5gZ
         /g6YP131uNcc7HVHUpWJa7LYwJbqo8UU40xyiXwe/ItKeoJdJO3G0EPbsi5MvSf7J+U9
         jiwNnvIp4bT0mSjFrD0svPlonmYt/92idcPr+vFeoxu0Fc3eln6zu2BpVfYkBJWWN1pv
         9gYSeWB0P+YgT37tKclr6ibzA+BM13kaNwejAUUAJSMyBn7LHeROiGoYG5yTOKtNELOB
         utTQ==
X-Gm-Message-State: AOAM5339TMdYluDtBP3lqGtCVDWyMhkUF16O8J0mvWx9snOg3nyqo+jb
        aAhU+Sh6UAGPVaBmF9lILKpi5lA0naxrEY8V68s6hA==
X-Google-Smtp-Source: ABdhPJzjF8ca/F3GtrPX5cQlziDTJ+OtNvbSnNvXlyUUOgKecmUmnXFY1qvK2H2gwGkFhjLE4WIVslhe6eabeLda+qQ=
X-Received: by 2002:a37:9487:: with SMTP id w129mr23848650qkd.21.1590398158172;
 Mon, 25 May 2020 02:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <1590120740-22912-1-git-send-email-yangtiezhu@loongson.cn> <1590120740-22912-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1590120740-22912-3-git-send-email-yangtiezhu@loongson.cn>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 May 2020 11:15:47 +0200
Message-ID: <CAMpxmJW9po_hp64yV73R4fLMQ3_5SbJuvE7Rva8hOvzjAFVHrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: pxa: Add COMPILE_TEST support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 22 maj 2020 o 06:12 Tiezhu Yang <yangtiezhu@loongson.cn> napisa=C5=82(=
a):
>
> Add COMPILE_TEST support to the PXA GPIO driver for better compile
> testing coverage.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 03c01f4..5e90aad 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -439,7 +439,7 @@ config GPIO_PMIC_EIC_SPRD
>
>  config GPIO_PXA
>         bool "PXA GPIO support"
> -       depends on ARCH_PXA || ARCH_MMP
> +       depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
>         help
>           Say yes here to support the PXA GPIO device
>
> --
> 2.1.0
>

Patch applied.

Bart

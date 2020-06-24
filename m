Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34A1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B37B20706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oXjREGJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbgFXKU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbgFXKUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:20:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF0FC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:20:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so1262436qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FRi5cLz2i8treGL656N0ByW0/+7y+778OS4JhAKmXLM=;
        b=oXjREGJgVU4dVMZOSXvMrbqFVvgENDSiVYKLTZJdkwdyGiW1I9KPHuAotyShS63LFA
         l4RS3K9+6w1z+0m1Ew8949PajoqeHkAoHlUXkvsmQdPQX5w1bSW/wDpRG9gWaiAnRe3a
         c9mP5+rWIQbqp1AmG0Fu5sQPc3rMdUpu6KSPCPVPBFUlgF+92t05BXwGtyAO4bOvclgh
         9icz0tsx7gJtMYyiDHBWx6xTFxAKB4fXyHWOohgyo9U0UyJmAma44G1w8Cl8U/d0u9lZ
         JROZGmUGMwjaB1Ls+vA4OZDSmCqK8qRfl/iG3Mz+SmVwcFwnoMohkDVF/+F8VZgHvAV5
         O2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FRi5cLz2i8treGL656N0ByW0/+7y+778OS4JhAKmXLM=;
        b=dezjNDPAawdLzFMJMd0AX46JazAygzsku7AG3kTJZ3D2hOFlzwjGC3Vzje6RvgrIOC
         9oyn4P0KwSOvyVWLnOPWJK3MtPoT9ZZtGc5uPlzVFLbWoBjjxqukTlIKsO4pRqtD2YGC
         1vyT2DoiQXXyZM9Gvd+vuifgoysY+LJL/8mxbXvdUlwN8Kfbi4JwFjm+FYnCGUNuIRfH
         Q7lK8m7cBjyTNCeCxHSwqmuEZK1q5peIMu4YDVMFOl5xWq0hzfL9AuKtgsG+PQjG0LLG
         SYm86K3svInqJDaFxyCd0mF8OFLJ8qABgCaySeAXDlMWABdDxj90RZUoe4qmPNAYjcTT
         t2Ng==
X-Gm-Message-State: AOAM532o/bIByy0Ck0YWcLpF0IrTSB8a4uez439w4zkyzs9wecFjKuwV
        6s/KQ9z5Ih8Z2KLNg+8PnsJW8JuRg2VTqZfQo6WUDv4h
X-Google-Smtp-Source: ABdhPJwKS25ektHXwijsC418SLiGujK4Z75iFhIUuaHDCUclTqCA+ql8Op77pL4RLiJdKqeut1RuieEwxb9qsyPoxGg=
X-Received: by 2002:a37:4ac6:: with SMTP id x189mr23699573qka.323.1592994021954;
 Wed, 24 Jun 2020 03:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200623144001.17052-1-geert+renesas@glider.be>
In-Reply-To: <20200623144001.17052-1-geert+renesas@glider.be>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 12:20:11 +0200
Message-ID: <CAMpxmJUr8_S16fPH5CWVzi+MRwpJFE2_T5BwdJaoute5n8g3Sg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop superfluous dependencies on GPIOLIB
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 16:40 Geert Uytterhoeven <geert+renesas@glider.be>
napisa=C5=82(a):
>
> All config options for GPIO drivers are inside a big "if GPIOLIB ...
> endif" block, so there is no reason for individual config options to
> have expicit dependencies on GPIOLIB.  Hence remove them.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpio/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index f875ec95ba8c3a7a..291bffb5c7e58d7f 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -411,7 +411,7 @@ config GPIO_MXS
>
>  config GPIO_OCTEON
>         tristate "Cavium OCTEON GPIO"
> -       depends on GPIOLIB && CAVIUM_OCTEON_SOC
> +       depends on CAVIUM_OCTEON_SOC
>         default y
>         help
>           Say yes here to support the on-chip GPIO lines on the OCTEON
> @@ -1118,7 +1118,7 @@ config GPIO_DLN2
>
>  config HTC_EGPIO
>         bool "HTC EGPIO support"
> -       depends on GPIOLIB && ARM
> +       depends on ARM
>         help
>           This driver supports the CPLD egpio chip present on
>           several HTC phones.  It provides basic support for input
> --
> 2.17.1
>

Applied, thanks!

Bartosz

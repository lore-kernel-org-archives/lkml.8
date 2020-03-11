Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921A9C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6B220873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wgPQQuMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgCKMgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:36:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44871 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgCKMgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:36:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id f198so1824758qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A2JAdo/ZGdZq7oAsk87CcGhLsAyVSDl8Hklf8ueXEq0=;
        b=wgPQQuMZanHLFj2mJqcSX3W583odW+PfyBhx+oB83ccqbeyp/tn2ub5mKFECqZa0Si
         jIwq7qZlEQ5kGwLMgTSiEoqV1qUGGPH4kYRduf0BtouMitKa7Kj1+uTePCaVxPUnuyOD
         oIUtFCxLdTOjxJSZGa5TqhD4dQeFNi3D/DALvmvVtA1gGFtPp5aL2glAhsEjt1YHC05L
         C/K7TJki+AYy+AvudHg1wEF4KB9uqVNtiwyU6XsoH2oaewfvs3SdWryJqH8gCGUbTpet
         vNCon0cKrHvTCT0A9FC/ZEYORA8Z5mIw4qz28t3XSpWFEVpN1KPT6Pl2FgGen2Lrca/A
         FvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A2JAdo/ZGdZq7oAsk87CcGhLsAyVSDl8Hklf8ueXEq0=;
        b=mrgp/e9HZeebfujtRTcuMWCGz+r9Dtc3zPp5Yau67Z/6gOX3BQYcxTCbnONnzky4Gc
         o5LhgQL7eQNCGizmwqPnDthHw16JVsJXrqzDoh8DCi+EgeKY2GY4pICMapUnwQ1wj3Wg
         u6T0WNnruevE7iXE8xb2h702gn8DUGGK+74t7kSIXJphH7593d0yfLhqOYTXKzICbZ8e
         yi5F7LC4aBY7UAvYHgdUj44llMG6ClT+RRX0B2qlOxSIkl+LDfdzVc+lsYGhVMcxlgyS
         ZauxqaQKEK1vq5uoneoe2+mA0CUFlPcGfHAN1S4teV1rdpgxaA7kjUsZ1Gvi+ohqnlUf
         x7nw==
X-Gm-Message-State: ANhLgQ1Rw02GFanVBRuS3HerllC+MjPlVdxzpqW/rPhPqwvJ4jh6RxOI
        2fVpdfMIbIzr+VuW2Q1Glft8PJAHhuucFPzDvRasSg==
X-Google-Smtp-Source: ADFU+vvI3YYQBWkmn8OFmWq6mlrvnzaHNr5OEC4rlUVY6+vpzh1cGiwciVD2yz9bUxl9LcLzbaVdyHUMxZzXdYvBNls=
X-Received: by 2002:a37:3c9:: with SMTP id 192mr2595902qkd.330.1583930171453;
 Wed, 11 Mar 2020 05:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <1583587917-7032-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583587917-7032-1-git-send-email-Anson.Huang@nxp.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Mar 2020 13:36:00 +0100
Message-ID: <CAMpxmJX6QPA-PZ=GGqp2B2prMEX3wAHCxMCijg2xdXztr9Rn=A@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: Add COMPILE_TEST support for GPIO_MXC
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 7 mar 2020 o 14:38 Anson Huang <Anson.Huang@nxp.com> napisa=C5=82(a):
>
> Add COMPILE_TEST support to GPIO_MXC driver for better compile
> testing coverage.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b8013cf..b411226 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -394,7 +394,7 @@ config GPIO_MVEBU
>
>  config GPIO_MXC
>         def_bool y
> -       depends on ARCH_MXC
> +       depends on ARCH_MXC || COMPILE_TEST
>         select GPIO_GENERIC
>         select GENERIC_IRQ_CHIP
>
> --
> 2.7.4
>

Patch applied, thanks!

Bartosz

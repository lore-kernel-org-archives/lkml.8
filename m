Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08124C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC783206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXOh5fqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgERLYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgERLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:23:59 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356F3C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:23:58 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id w65so2656069vsw.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1n7RaChAUzPNECEHRyp6u9VTopN+f5nbtpE0fDCMq8=;
        b=TXOh5fqt3PzSdEkqn0gmbPL2Fj+wG1uYXctS7zM6yfukcZOz8CFBhPbK1oKwFKlltp
         mKxibjK1f1hC7WtOnvZjancHQf62eEcv1j1jQoM0Vzd4gVXEXC8B59GQfsgcm7LLIWyF
         rdtnRX3dV/9/KLa/TscU4NPCmm+H+LWuFNZAa6somGpH1mpeKDHcPcSU08NwNM7kl5Dg
         o6NpcSOcU1fsUUG2dRNjSEY299Bbq741lkVY3FC6ei0TihPLO/aMEaaaHkg9roq1MoX4
         QQm23WpV8nf+wFMrzeGEfa4qYY0HW+YH042/VsTbjUJRXZCERrsoAGP1R8nn97c3dla2
         Y/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1n7RaChAUzPNECEHRyp6u9VTopN+f5nbtpE0fDCMq8=;
        b=piuTkMW7OLqkx7OqAgY0wgRO1YWcJozavdB+Hou5KfQVC8zn1dX0ug0F/DOOHlpVck
         lxQDny+ZZj7cu2d/TVvBun+yjTVLWtHhOF8waG+zniix3dcmy644FqhlKrRXBw/uRDjp
         qHiJ5nWAyiW61saLQ1zicd3RvaWlgRVPoFVa6H37VnRaLqVtJlzPYKiDNzhLXkRQJEEQ
         C7oJI1eekd6r5QccXk9b+ZpLtsXMXgJ4xqOhJlcF4rT/f4dMSFRUDCl5POnEvWc+Oxeb
         Fw2QqePtbLBGCicJarLeIIv0zeknou3VsaX3DEY80FP+N6+9oj3FtsmEksQVPqQId0pP
         qY4A==
X-Gm-Message-State: AOAM532s/j/eFqzCtd6iwNUxP2tXpMirCHb6CajioRirwSDpD9vwJZUv
        iRE/tDZ4ZcNurxTmohkcWOJWDW+er28axLIR8CNA+A==
X-Google-Smtp-Source: ABdhPJy/rVieaG/L0Ins0/4TimZHnSS+172dms9i2uqAz9mwkD0bpH2Dd9kkzn8P/9CsB4SXnTsL9pdOu6qVcNA3KK0=
X-Received: by 2002:a05:6102:82a:: with SMTP id k10mr2479811vsb.200.1589801037323;
 Mon, 18 May 2020 04:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200518060811.1499962-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200518060811.1499962-1-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 13:23:20 +0200
Message-ID: <CAPDyKFppf081TM6mympDMNGr0fgzQVgQ+gmnDXiCtGjBb7F34Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: meson-mx-sdhc: fix building with CONFIG_MMC_MESON_MX_SDHC=m
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 at 08:08, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> For an x86_64 allmodconfig build Stephen reports that building
> meson-mx-sdhc-clkc.o warns that MODULE_LICENSE is missing and when
> linking meson_mx_sdhc_register_clkc cannot be found.
>
> Compile the MMC controller driver together with the build-in clock
> controller driver into one module rather than using two separate
> modules to fix these issues.
>
> Fixes: 53ded1b676d199 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Makefile                                 | 3 ++-
>  drivers/mmc/host/{meson-mx-sdhc.c => meson-mx-sdhc-mmc.c} | 0
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  rename drivers/mmc/host/{meson-mx-sdhc.c => meson-mx-sdhc-mmc.c} (100%)
>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 8bcb420e071c..8f459259181e 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -68,7 +68,8 @@ obj-$(CONFIG_MMC_VUB300)      += vub300.o
>  obj-$(CONFIG_MMC_USHC)         += ushc.o
>  obj-$(CONFIG_MMC_WMT)          += wmt-sdmmc.o
>  obj-$(CONFIG_MMC_MESON_GX)     += meson-gx-mmc.o
> -obj-$(CONFIG_MMC_MESON_MX_SDHC)        += meson-mx-sdhc-clkc.o meson-mx-sdhc.o
> +meson-mx-sdhc-objs             := meson-mx-sdhc-clkc.o meson-mx-sdhc-mmc.o
> +obj-$(CONFIG_MMC_MESON_MX_SDHC)        += meson-mx-sdhc.o
>  obj-$(CONFIG_MMC_MESON_MX_SDIO)        += meson-mx-sdio.o
>  obj-$(CONFIG_MMC_MOXART)       += moxart-mmc.o
>  obj-$(CONFIG_MMC_SUNXI)                += sunxi-mmc.o
> diff --git a/drivers/mmc/host/meson-mx-sdhc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> similarity index 100%
> rename from drivers/mmc/host/meson-mx-sdhc.c
> rename to drivers/mmc/host/meson-mx-sdhc-mmc.c
> --
> 2.26.2
>

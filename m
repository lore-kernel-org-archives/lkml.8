Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF836C35675
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CFD214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgBWD0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:26:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33609 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBWD0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:26:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so7592571edq.0;
        Sat, 22 Feb 2020 19:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+CR/qJ4zb1qF8uhdGH5yBtOVB+m81/kR2txmUNet5o=;
        b=bPu6M6OclIt/PXwPkgB7Wl4vG6a3BMN7viN3I/acHpytsjorrmBj630Fk0GQiB0d/4
         BFrjDduI8vJ+44yrL1uIklik2tMEPbbuSDUdQhA/OAuTozDtIz9VakYkXVrQDmLXJkFg
         cNmjFYW+RsafkRdVB8T4ciQXs5QIr8iHjIOrR5Fa4McsefB35koF08d9pHSlx9PmDlQZ
         kQ2y9CC2xYxtwcDQZxJAq6QPnK6XuLxfLYwIfR8X1Hpn41HoonrSAT7soMDU4Z1K6ML+
         PItLiA2A88wi8Dl3GePfcUxAcSXvgGrirYPGhaHxjWb7pzTHpetaXmBV69EEp/lQNkWm
         i2eg==
X-Gm-Message-State: APjAAAU3OShX5oo8pkgufOLSiO2nriEpFRPUSomFNZwC51GNXaVCeYrG
        uTyWv7i/0gAPEP4z/AOaPNgxtJDJOBw=
X-Google-Smtp-Source: APXvYqy+WNRb6maw0MK6O2uZ3ITWdjaUkNTe6aqk1iO6EUzISUJ1vBvNkdFSgVQOL5y6xCG2RASn2Q==
X-Received: by 2002:aa7:d510:: with SMTP id y16mr41522929edq.214.1582428394590;
        Sat, 22 Feb 2020 19:26:34 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id d23sm601977ejt.53.2020.02.22.19.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 19:26:34 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id s10so5639825wmh.3;
        Sat, 22 Feb 2020 19:26:33 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr13650427wmd.77.1582428393666;
 Sat, 22 Feb 2020 19:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20200222223154.221632-1-megous@megous.com> <20200222223154.221632-2-megous@megous.com>
In-Reply-To: <20200222223154.221632-2-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 23 Feb 2020 11:26:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v67XwrYA8FLF9wpnngm9F-F9UV2m+rr+r3t+KUVv5-EMiw@mail.gmail.com>
Message-ID: <CAGb2v67XwrYA8FLF9wpnngm9F-F9UV2m+rr+r3t+KUVv5-EMiw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/4] ARM: dts: sun8i-a83t-tbs-a711: OOB WiFi
 interrupt doesn't work
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Sun, Feb 23, 2020 at 6:32 AM Ondrej Jirman <megous@megous.com> wrote:
>
> It just causes a constant rate of 5000 interrupts per second for both
> GPIO and MMC, even if nothing is happening. Rely on in-band interrupts
> instead.
>
> Fixes: 0e23372080def7bb ("arm: dts: sun8i: Add the TBS A711 tablet devicetree")
> Signed-off-by: Ondrej Jirman <megous@megous.com>

What WiFi chip/module does this use? It might be worth asking Broadcom
people to help with this and fix the driver.

ChenYu

> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> index 2fd31a0a0b344..ee5ce3556b2ad 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -214,9 +214,6 @@ &mmc1 {
>         brcmf: wifi@1 {
>                 reg = <1>;
>                 compatible = "brcm,bcm4329-fmac";
> -               interrupt-parent = <&r_pio>;
> -               interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 WL_WAKE_UP */
> -               interrupt-names = "host-wake";
>         };
>  };
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200222223154.221632-2-megous%40megous.com.

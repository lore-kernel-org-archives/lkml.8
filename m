Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005AAC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D204620659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgBWDX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:23:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33335 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBWDX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:23:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so7587898edq.0;
        Sat, 22 Feb 2020 19:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RS1myGQD4/DxcloU05LYheuFzcmTnlxgIJwQU+BLqtY=;
        b=MxI8FM2mm+dZFcmAVdQO8Lq728djsVIYKYj7ANjU90WqVOBTJUKEuJwApjk4ipExGp
         BRtNw9htGZS6Xi6xW/NHAqV8YmipiBlXN86fD2TH7xJn8PfIaCQdTRpET0hQ+Y3fPSy2
         v+9+pk2ht3ZRZGc10pKqqdCls0whoBut4YgxlQxTIqPhd2M3VoDsfCXkcijUmkRsJ1lL
         Logq8Ao1iLpnhCezCzLvMWoo1uXLjDJIJBaDZxt3aSje0K3XEA/9HGmW7g27Bby+r5YO
         kkkAdaKAlvNolD8Si0Vt6e/6lGGlAx6uh490F2vUkh6sS05MxXzYrQQuFDL7OBhCr/aq
         07Jg==
X-Gm-Message-State: APjAAAXnOCoZjXaSYij8JYRIUKgCFCqGbena04Y7KJK68/lry33+9/LV
        XKxQfKunGFhjP82OfvhwJvWtg+OAlS4=
X-Google-Smtp-Source: APXvYqwi+kjImUdTL0vzD3gf5zEKNMyj3eI9Fvxf+6hnbmTWovDebi924u/JV7IqYEuNJF+bBAMT7w==
X-Received: by 2002:aa7:cf81:: with SMTP id z1mr40883593edx.234.1582428207299;
        Sat, 22 Feb 2020 19:23:27 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id n11sm594532eje.86.2020.02.22.19.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 19:23:26 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id g3so6334598wrs.12;
        Sat, 22 Feb 2020 19:23:25 -0800 (PST)
X-Received: by 2002:a5d:484f:: with SMTP id n15mr57653500wrs.365.1582428205416;
 Sat, 22 Feb 2020 19:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20191020134229.1216351-3-megous@megous.com> <20191110124355.1569-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20191110124355.1569-1-rikard.falkeborn@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 23 Feb 2020 11:23:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v67piSbdmDPOU_w3QterPRk7iFnrMAZe05O5ypwraohssQ@mail.gmail.com>
Message-ID: <CAGb2v67piSbdmDPOU_w3QterPRk7iFnrMAZe05O5ypwraohssQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 RESEND] phy: allwinner: Fix GENMASK misuse
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 7:42 AM Ondrej Jirman <megous@megous.com> wrote:
>
> From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
>
> Arguments are supposed to be ordered high then low.
>
> Fixes: a228890f9458 ("phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Tested-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
> v1->v2: Add fixes tax. Add Ondrejs Tested-by. No functional change.
>
> This was last sent in Nov last year. I'm resending, because it probably
> got forgotten. The only change is adding my SoB, which I understand is
> required for the sender of the patch.
>
>  drivers/phy/allwinner/phy-sun50i-usb3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
> index 1169f3e83a6f..b1c04f71a31d 100644
> --- a/drivers/phy/allwinner/phy-sun50i-usb3.c
> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
> @@ -49,7 +49,7 @@
>  #define SUNXI_LOS_BIAS(n)              ((n) << 3)
>  #define SUNXI_LOS_BIAS_MASK            GENMASK(5, 3)
>  #define SUNXI_TXVBOOSTLVL(n)           ((n) << 0)
> -#define SUNXI_TXVBOOSTLVL_MASK         GENMASK(0, 2)
> +#define SUNXI_TXVBOOSTLVL_MASK         GENMASK(2, 0)
>
>  struct sun50i_usb3_phy {
>         struct phy *phy;
> --
> 2.24.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20191110124355.1569-1-rikard.falkeborn%40gmail.com.

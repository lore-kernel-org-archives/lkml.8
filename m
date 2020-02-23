Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A4DC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3AA2067D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBWEEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 23:04:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33787 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgBWED7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:03:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so7647530edq.0;
        Sat, 22 Feb 2020 20:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwEdqYydc8kdzSGTpNrqTMnSIQHLxOA+j53stoAmXIE=;
        b=AYn5m+1G10wSaRo1IWwIUeGU9gyPu6w0eVfT8R5p4QCPQNgyiLRYXfqC/natGksJ3R
         z4oA5oH2+OM7L02kX1Ug55K7cm0AhLmL33X0xe5E4augSwdECK7QkB2oleu/TrWIvt4a
         0NbSbfMNQysYBSyQRyUPAyiXmWMDo+/HsWH4dg0dnSWNg4lueXxwr5eYtC5gDfM8HiVV
         ZEUqeAe3DH1j4MdD17N4PJl/x96FY7YyOryHcprI6Y2KdQphg2f7kmOxH1qCG7fHBxPi
         8BPCLct1XZ0RH/YsuD/MkXXjSMdUZy0ku1Bmx06CPxaan7qZ2/9YwhDGuJd+0eaLawpx
         xQ0Q==
X-Gm-Message-State: APjAAAV8PvCjCMjJVOxi/cVn3X74nJtxU7brEvOhVgIzWLDVIA95xydc
        z4AVwHDECfbb+KGOtA3raV4lI3no07s=
X-Google-Smtp-Source: APXvYqzrGSKXsrUGEXvzayBJLLJsND9LjHZK33uvYbD3CrtB/5P33UQxvPC1QhwB/L2HmC6n3SNaAA==
X-Received: by 2002:a17:906:b2c5:: with SMTP id cf5mr41763793ejb.325.1582430637215;
        Sat, 22 Feb 2020 20:03:57 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id i11sm582047ejv.64.2020.02.22.20.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 20:03:56 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id n10so6439954wrm.1;
        Sat, 22 Feb 2020 20:03:56 -0800 (PST)
X-Received: by 2002:a5d:640d:: with SMTP id z13mr55885217wru.181.1582430636158;
 Sat, 22 Feb 2020 20:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20200222223154.221632-1-megous@megous.com> <20200222223154.221632-2-megous@megous.com>
 <CAGb2v67XwrYA8FLF9wpnngm9F-F9UV2m+rr+r3t+KUVv5-EMiw@mail.gmail.com>
In-Reply-To: <CAGb2v67XwrYA8FLF9wpnngm9F-F9UV2m+rr+r3t+KUVv5-EMiw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 23 Feb 2020 12:03:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v66G5P_souwFHodO0_NYhWyQ+dGE4fbqLLK3qd9ue7Kk9g@mail.gmail.com>
Message-ID: <CAGb2v66G5P_souwFHodO0_NYhWyQ+dGE4fbqLLK3qd9ue7Kk9g@mail.gmail.com>
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

On Sun, Feb 23, 2020 at 11:26 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi,
>
>
> On Sun, Feb 23, 2020 at 6:32 AM Ondrej Jirman <megous@megous.com> wrote:
> >
> > It just causes a constant rate of 5000 interrupts per second for both
> > GPIO and MMC, even if nothing is happening. Rely on in-band interrupts
> > instead.
> >
> > Fixes: 0e23372080def7bb ("arm: dts: sun8i: Add the TBS A711 tablet devicetree")
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
>
> What WiFi chip/module does this use? It might be worth asking Broadcom
> people to help with this and fix the driver.

Based on the comments in the device tree file, it uses an AP6210, which
is a BCM43362 inside for SDIO-based WiFi. There is a recent fix in 5.6-rc1
for this,

    8c8e60fb86a9 brcmfmac: sdio: Fix OOB interrupt initialization on brcm43362

which seems to fix things for me. Could you try it on your end?

ChenYu


> ChenYu
>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > index 2fd31a0a0b344..ee5ce3556b2ad 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > @@ -214,9 +214,6 @@ &mmc1 {
> >         brcmf: wifi@1 {
> >                 reg = <1>;
> >                 compatible = "brcm,bcm4329-fmac";
> > -               interrupt-parent = <&r_pio>;
> > -               interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 WL_WAKE_UP */
> > -               interrupt-names = "host-wake";
> >         };
> >  };
> >
> > --
> > 2.25.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200222223154.221632-2-megous%40megous.com.

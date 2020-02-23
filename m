Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8647EC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D07D206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="RMa8HcLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBWKC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:02:28 -0500
Received: from vps.xff.cz ([195.181.215.36]:41500 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWKC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 05:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582452145; bh=ZLOyODypymrlYWhAyRXBc5vQ3z2suv+ka0Ds1dIXppg=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=RMa8HcLbYgAb1fS1SFCnKRuGxHeANm6erMaQXhCMz6vy3LGJptsw8NeVlT51V6xjq
         Jo+GWZ56u2dY5+QGZnC3KaOuf6SRBsPKjEyfctS3mZGRfR1/dlXrTJTIkJrT1xtlmp
         BDnt13ikBk4X35zHfrGTVAl5+r7SXtPaZYYF9fgI=
Date:   Sun, 23 Feb 2020 11:02:25 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Chen-Yu Tsai <wens@csie.org>
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
Subject: Re: [linux-sunxi] [PATCH 1/4] ARM: dts: sun8i-a83t-tbs-a711: OOB
 WiFi interrupt doesn't work
Message-ID: <20200223100225.6e6n65mc3mj365wy@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Tomas Novotny <tomas@novotny.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20200222223154.221632-1-megous@megous.com>
 <20200222223154.221632-2-megous@megous.com>
 <CAGb2v67XwrYA8FLF9wpnngm9F-F9UV2m+rr+r3t+KUVv5-EMiw@mail.gmail.com>
 <CAGb2v66G5P_souwFHodO0_NYhWyQ+dGE4fbqLLK3qd9ue7Kk9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v66G5P_souwFHodO0_NYhWyQ+dGE4fbqLLK3qd9ue7Kk9g@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 12:03:46PM +0800, Chen-Yu Tsai wrote:
> On Sun, Feb 23, 2020 at 11:26 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi,
> >
> >
> > On Sun, Feb 23, 2020 at 6:32 AM Ondrej Jirman <megous@megous.com> wrote:
> > >
> > > It just causes a constant rate of 5000 interrupts per second for both
> > > GPIO and MMC, even if nothing is happening. Rely on in-band interrupts
> > > instead.
> > >
> > > Fixes: 0e23372080def7bb ("arm: dts: sun8i: Add the TBS A711 tablet devicetree")
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> >
> > What WiFi chip/module does this use? It might be worth asking Broadcom
> > people to help with this and fix the driver.
> 
> Based on the comments in the device tree file, it uses an AP6210, which
> is a BCM43362 inside for SDIO-based WiFi. There is a recent fix in 5.6-rc1
> for this,
> 
>     8c8e60fb86a9 brcmfmac: sdio: Fix OOB interrupt initialization on brcm43362
> 
> which seems to fix things for me. Could you try it on your end?

Interesting, thanks for finding out! I'll test it.

I think it will work, since my tablet started having overheating issue recently,
and I tracked it down to this.

regards,
	o.

> ChenYu
> 
> 
> > ChenYu
> >
> > > ---
> > >  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > > index 2fd31a0a0b344..ee5ce3556b2ad 100644
> > > --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > > +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > > @@ -214,9 +214,6 @@ &mmc1 {
> > >         brcmf: wifi@1 {
> > >                 reg = <1>;
> > >                 compatible = "brcm,bcm4329-fmac";
> > > -               interrupt-parent = <&r_pio>;
> > > -               interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 WL_WAKE_UP */
> > > -               interrupt-names = "host-wake";
> > >         };
> > >  };
> > >
> > > --
> > > 2.25.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200222223154.221632-2-megous%40megous.com.

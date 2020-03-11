Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFABEC3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61546206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583938021;
	bh=ruBwn5wDj74e/K+r4986L1gfq+eU0+k3w7VbVctWE10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0rp4q8rbm8SGyEMVBvMXypOEwua9glXbK+uMCnk9/LVIpHwgCrYzzOePa5uxrM+1J
	 /aVS/EHPUqo5PfMWTV7emBq06Qm5hNug4rkixmoPbR40fsAVIpypTiFqluDpYxrEVN
	 qxHEi515KcWrXSTS3rJxnmM7s5/XTlYS4AqQimms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgCKOrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgCKOrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:47:01 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 117C2206EB;
        Wed, 11 Mar 2020 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583938019;
        bh=ruBwn5wDj74e/K+r4986L1gfq+eU0+k3w7VbVctWE10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NzjBVMdxDd+Kl49LOjGaBd3WYnkCvYkNm1wU4P9GhVG5t0/K9oS+4AIwW69cVpoMV
         FPtGYDiYkuwXkUld5nRYYBRD3nWNrbrJGDY5/wC8JnVTMzsNRttYPblFKwfKsM7WD3
         T0z2XFq1FUMLJpWJd+zpaTrZ9ieDU6xdTQqMWoJI=
Received: by mail-wr1-f43.google.com with SMTP id d5so2619762wrc.2;
        Wed, 11 Mar 2020 07:47:00 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2VqtpSJHOVVtNYxMKjNo79jpup53wcZ/uPZnSk39/zha38kjTB
        pl8KiKyH5yaM7/UsDxZOJtX8Oe0Q2GEGsZzP8M8=
X-Google-Smtp-Source: ADFU+vs8B8EgCnwrcFOwMq4EMagcV8OTKEEHRsPEaHmM1MNKm2z5pWXx/gJgkDDoe/YZ41fGgMvzQ6EnRqYtBNoKsaY=
X-Received: by 2002:adf:97c1:: with SMTP id t1mr618684wrb.365.1583938018853;
 Wed, 11 Mar 2020 07:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200310174709.24174-1-wens@kernel.org> <20200310174709.24174-2-wens@kernel.org>
 <20200311105937.040cd947@donnerap.cambridge.arm.com>
In-Reply-To: <20200311105937.040cd947@donnerap.cambridge.arm.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 11 Mar 2020 22:46:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66dWGSJD0sS6BmbT6nb3J0xFex=3ATwm2s9Hot4ua4kcw@mail.gmail.com>
Message-ID: <CAGb2v66dWGSJD0sS6BmbT6nb3J0xFex=3ATwm2s9Hot4ua4kcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: sun8i: r40: Move AHCI device node based on
 address order
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 6:59 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Wed, 11 Mar 2020 01:47:07 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > When the AHCI device node was added, it was added in the wrong location
> > in the device tree file. The device nodes should be sorted by register
> > address.
> >
> > Move the device node to before EHCI1, where it belongs.
> >
> > Fixes: 41c64d3318aa ("ARM: dts: sun8i: r40: add sata node")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm/boot/dts/sun8i-r40.dtsi | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > index d5442b5b6fd2..b278686d0c22 100644
> > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > @@ -307,6 +307,17 @@ crypto: crypto@1c15000 {
> >                       resets = <&ccu RST_BUS_CE>;
> >               };
> >
> > +             ahci: sata@1c18000 {
> > +                     compatible = "allwinner,sun8i-r40-ahci";
> > +                     reg = <0x01c18000 0x1000>;
> > +                     interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > +                     resets = <&ccu RST_BUS_SATA>;
> > +                     reset-names = "ahci";
> > +                     status = "disabled";
> > +
>
> Did this empty line serve any particular purpose before? If not, you could remove it on the way.

Can't say there is. Removed when applied.

> With that fixed:
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>
> Thanks,
> Andre.

Thanks
ChenYu

> > +             };
> > +
> >               ehci1: usb@1c19000 {
> >                       compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
> >                       reg = <0x01c19000 0x100>;
> > @@ -733,17 +744,6 @@ spi3: spi@1c0f000 {
> >                       #size-cells = <0>;
> >               };
> >
> > -             ahci: sata@1c18000 {
> > -                     compatible = "allwinner,sun8i-r40-ahci";
> > -                     reg = <0x01c18000 0x1000>;
> > -                     interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > -                     clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > -                     resets = <&ccu RST_BUS_SATA>;
> > -                     reset-names = "ahci";
> > -                     status = "disabled";
> > -
> > -             };
> > -
> >               gmac: ethernet@1c50000 {
> >                       compatible = "allwinner,sun8i-r40-gmac";
> >                       syscon = <&ccu>;
>

Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0324BC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28C021775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujU5sENc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgGSOyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:54:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DBEC0619D2;
        Sun, 19 Jul 2020 07:54:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so15605649ejx.0;
        Sun, 19 Jul 2020 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nb0uS5rUYs5OsHb3nh5ZsQe3d7o5Fw3Gzq8fN1p4Aco=;
        b=ujU5sENc6qebHlyLdVTM2PAwq/9RI+ubx7ONdHFsZ7mxZ11cWsfoovqqTHZlgmgfHE
         58v3KM5E+e7LY1wGF+O5WuCyWjCYcJKwiMqxYyIRTTNvbzQa42xT0Vs7IZOQc45D4gPV
         JOw0lZEuOcMVBO0rf1j8VF9Y+u7mBjx3ouEbqnrH+h0aX9vJlvs1KXnuYZ731UIRYmuz
         bkPVutZeD7pUfsaQoEz0b2n+xw9GNSmbd/4wotK1Tb/YKNGeeFHZ6jVHa4CkvoRi+1P9
         Vo/QPUbcihDKwDkBBa3jfqwjNa422MaA8I/4w/OEAEbMqpcqXs5L5c7QvOHMazF+oqUQ
         Axfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nb0uS5rUYs5OsHb3nh5ZsQe3d7o5Fw3Gzq8fN1p4Aco=;
        b=GZxgdPP9gxjnDkLEUdsKabumdIdEP1nlZxWem8xGPVPDjm2kceW7vzxSs+FdWbvV8F
         P3Ge0sbcytFCtT8i6SFVA93CAW5v7k4Tni1gPn/3pkxNKRS3JTnHqo2G+5jHZgjB45ct
         zYyi09MJXzwHxuBa7u3GtQ7gxvOc9CcrxRCdcpI1YXOkyr79KBS4etoxoNu8LfByFyEP
         U+eqHcWa4y5PwCa9u1AFcrBMp7zrD7x2ZNkPZe3BB/AzykBdCeABp9a1gqpD/3x67iLI
         wVZvNUTQCUqcTBW3+6lPKFZWXXjjzuet/TB+m0I6NMeJjIDiCgYgbQJb2ImbNz8vM/zH
         UZMw==
X-Gm-Message-State: AOAM533EmppD4uoUUSmoGiPprOXnmPi+bvH+r0aIjVnFIpRm+BUGRy7L
        C6uAUBjmvyVUs8TkG0ADZEd9/1k/atms48Xkg34=
X-Google-Smtp-Source: ABdhPJwSKh/D3JDEsipnRi/eUQPch8BaQPbsfKw4isZg9Xd0Pr3vjFv8SBhrZYXcqL2rDUQXhOy5SkQ5c0SQCtcZ5DM=
X-Received: by 2002:a17:906:1356:: with SMTP id x22mr17534230ejb.429.1595170475998;
 Sun, 19 Jul 2020 07:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200702172714.158786-1-pop.adrian61@gmail.com>
 <20200702172714.158786-2-pop.adrian61@gmail.com> <CAPTRvHm0gX=myLBeztq-7q8hMGZ+a0pH_ZB8hH+RZtSSsqVGDw@mail.gmail.com>
In-Reply-To: <CAPTRvHm0gX=myLBeztq-7q8hMGZ+a0pH_ZB8hH+RZtSSsqVGDw@mail.gmail.com>
From:   Adrian Pop <pop.adrian61@gmail.com>
Date:   Sun, 19 Jul 2020 17:56:47 +0300
Message-ID: <CAP-HsdSshbE-fJrT631oXk375mhJwEbBLCujdAnk=Sw-936wTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: stm32: Enable MIPI DSI display support.
To:     Hua Dillon <dillonhua@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hua,

Thank you for your review,

On Tue, Jul 14, 2020 at 6:37 AM Hua Dillon <dillonhua@gmail.com> wrote:
>
> Hi, Adrian,
>
> Just one suggestion for you.
>
> Adrian Pop <pop.adrian61@gmail.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:30=E5=86=99=E9=81=93=EF=BC=9A
> >
> > STM32f769-disco features a 4" MIPI DSI display: add support for it.
> > On Cortex-M7 DMA can't use cached memory. For this reason I use a dedic=
ated
> > memory pool for DMA with no-cache attribute which is located at the end=
 of
> >  RAM.
> >
> > Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> > ---
> >  arch/arm/boot/dts/stm32f746.dtsi      | 34 +++++++++++++++++++
> >  arch/arm/boot/dts/stm32f769-disco.dts | 49 +++++++++++++++++++++++++++
> >  2 files changed, 83 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32=
f746.dtsi
> > index 93c063796780..577a812ca01c 100644
> > --- a/arch/arm/boot/dts/stm32f746.dtsi
> > +++ b/arch/arm/boot/dts/stm32f746.dtsi
> > @@ -48,6 +48,19 @@ / {
> >         #address-cells =3D <1>;
> >         #size-cells =3D <1>;
> >
> > +       reserved-memory {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +               ranges;
> > +
> > +               linux,dma {
> > +                       compatible =3D "shared-dma-pool";
> > +                       linux,dma-default;
> > +                       no-map;
> > +                       reg =3D <0xc0f00000 0x100000>;
> > +               };
> > +       };
> > +
> Christoph Hellwig was submit a patch for !CONFIG_MMU platforms to support=
 mmap.
> the patch is : 1fbf57d05302 dma-direct: re-enable mmap for !CONFIG_MMU
> i thought there is no need to create a reserved-memory for it.

Just tried with his patch, if I don't have the reserved-memory, I get:

[drm] Initialized stm 1.0.0 20170330 for 40016800.display-controller on min=
or 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5 at arch/arm/mm/dma-mapping-nommu.c:50 0xc000b8e9
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.8.0-rc1-next-20200616 #4
Hardware name: STM32 (Device Tree Support)
Workqueue: events 0xc0150fc1

This is the reason I added the reserved memory in the first place.

>
> >         clocks {
> >                 clk_hse: clk-hse {
> >                         #clock-cells =3D <0>;
> > @@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
> >         };
> >
> >         soc {
> > +               ltdc: display-controller@40016800 {
> > +                       compatible =3D "st,stm32-ltdc";
> > +                       reg =3D <0x40016800 0x200>;
> > +                       interrupts =3D <88>, <89>;
> > +                       resets =3D <&rcc STM32F7_APB2_RESET(LTDC)>;
> > +                       clocks =3D <&rcc 1 CLK_LCD>;
> > +                       clock-names =3D "lcd";
> > +                       status =3D "disabled";
> > +               };
> > +
> > +               dsi: dsi@40016c00 {
> > +                       compatible =3D "st,stm32-dsi";
> > +                       reg =3D <0x40016c00 0x800>;
> > +                       interrupts =3D <98>;
> > +                       clocks =3D <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
> > +                       clock-names =3D "pclk", "ref";
> > +                       resets =3D <&rcc STM32F7_APB2_RESET(DSI)>;
> > +                       reset-names =3D "apb";
> > +                       status =3D "disabled";
> > +               };
> > +
> >                 timer2: timer@40000000 {
> >                         compatible =3D "st,stm32-timer";
> >                         reg =3D <0x40000000 0x400>;
> > diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/=
stm32f769-disco.dts
> > index 1626e00bb2cb..a9e81b49809c 100644
> > --- a/arch/arm/boot/dts/stm32f769-disco.dts
> > +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> > @@ -153,3 +153,52 @@ &usbotg_hs {
> >         pinctrl-names =3D "default";
> >         status =3D "okay";
> >  };
> > +
> > +&dsi {
> > +       #address-cells =3D <1>;
> > +       #size-cells =3D <0>;
> > +       status =3D "okay";
> > +
> > +       ports {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +
> > +               port@0 {
> > +                       reg =3D <0>;
> > +                       dsi_in: endpoint {
> > +                               remote-endpoint =3D <&ltdc_out_dsi>;
> > +                       };
> > +               };
> > +
> > +               port@1 {
> > +                       reg =3D <1>;
> > +                       dsi_out: endpoint {
> > +                               remote-endpoint =3D <&dsi_in_panel>;
> > +                       };
> > +               };
> > +
> > +       };
> > +
> > +       panel: panel {
> > +               compatible =3D "orisetech,otm8009a";
> > +               reg =3D <0>;
> > +               reset-gpios =3D <&gpioj 15 GPIO_ACTIVE_LOW>;
> > +               status =3D "okay";
> > +
> > +               port {
> > +                       dsi_in_panel: endpoint {
> > +                               remote-endpoint =3D <&dsi_out>;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&ltdc {
> > +       status =3D "okay";
> > +
> > +       port {
> > +               ltdc_out_dsi: endpoint {
> > +                       remote-endpoint =3D <&dsi_in>;
> > +               };
> > +       };
> > +};
> > --
> > 2.27.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards,
Adrian

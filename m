Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD9DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C802080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubxc5Zi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGTDSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTDSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:18:08 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0E9C0619D2;
        Sun, 19 Jul 2020 20:18:08 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x9so12048932ila.3;
        Sun, 19 Jul 2020 20:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OWswHlb/FQeyYToYqgiOm+7uAJVRAxLTFOerT1JJ44U=;
        b=ubxc5Zi5Us4nRLynsw3CuoEEBiu3e+C1bp6XMRyxJR+teI2Jqte9VSeMqRdsGdqYUW
         dICQxWQf+1mbiFXZHo/XGNWVtfDOUmGZpLiWVKpD4Oyu8W8cPaMYcKfmDoT/IUH5UYJs
         mCt11rqew5IdrbrAbW2y7S/ARnWE3hWQKsaWkY/Ci6hyCPK7fc7H5qSwrWFwdaTB4vuW
         PlWlOcn1ImMknJ4BEhxy9qHJE7bZTPDetGxHAsXQ96XrUYPOWmaqJpD1k1muXPEoxLG9
         j23HHm+55REyPXdvdCWrUhTBFA6I1wA9a6b3AFx8jz3CcXRQOIuFeXiaMwFDl96P5Pcy
         irsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OWswHlb/FQeyYToYqgiOm+7uAJVRAxLTFOerT1JJ44U=;
        b=aLtb/MEqcDLapExGO19igFJ64LWVRFSriFQhy0hPskg3Sixu8NKGjfy66q8OQIIp/g
         il1QHxnyu93X/GefMSta3GNKCda6iEr52pf1jpyZPtSIm99xFlqOYnbWzOAqwAzdiZOi
         M17pPNcnQI3mHSnDplLJZoTBz8firXYjoCRFSME7JQ62Rjm8S3y0MmFiNRNxfImQuh5p
         8OFaJdK012zDUw5pyLYm9Be1LhawlWB6zkMTdKOBP2l7FTUnVlGUMdB9BfgA0N8LbJZt
         c1MyH6vLmME6JM+vtLMeZ0JeoBDTjLjKfD+0EkPqeSzePKNaObeQ3ABiQRKON903kpri
         0l+A==
X-Gm-Message-State: AOAM530wrDBurXc0zFIBOaap5rYenJcEllQpL4pXDmV7tfwodcpdrP+k
        hB2vs/92fwkJph4rpeAu+djBrIZZSpRYk6tGY4A=
X-Google-Smtp-Source: ABdhPJxCTeFwgyJ3++gg/F0LJkC5ZzOOJZeEX10Sgi6ZTwo0HKJwD8EvAnxxrldOn40IV0aQRoNM4hSefkapTqwrQAw=
X-Received: by 2002:a92:840b:: with SMTP id l11mr20967909ild.129.1595215087463;
 Sun, 19 Jul 2020 20:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200702172714.158786-1-pop.adrian61@gmail.com>
 <20200702172714.158786-2-pop.adrian61@gmail.com> <CAPTRvHm0gX=myLBeztq-7q8hMGZ+a0pH_ZB8hH+RZtSSsqVGDw@mail.gmail.com>
 <CAP-HsdSshbE-fJrT631oXk375mhJwEbBLCujdAnk=Sw-936wTA@mail.gmail.com>
In-Reply-To: <CAP-HsdSshbE-fJrT631oXk375mhJwEbBLCujdAnk=Sw-936wTA@mail.gmail.com>
From:   Hua Dillon <dillonhua@gmail.com>
Date:   Mon, 20 Jul 2020 11:17:56 +0800
Message-ID: <CAPTRvH=ZSZBhmtW5=eXensuStYX=6s9AoqZncOZvZU8kVZXw9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: stm32: Enable MIPI DSI display support.
To:     Adrian Pop <pop.adrian61@gmail.com>
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

Hi Adrian,

Adrian Pop <pop.adrian61@gmail.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8819=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:54=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Hua,
>
> Thank you for your review,
>
> On Tue, Jul 14, 2020 at 6:37 AM Hua Dillon <dillonhua@gmail.com> wrote:
> >
> > Hi, Adrian,
> >
> > Just one suggestion for you.
> >
> > Adrian Pop <pop.adrian61@gmail.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:30=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > STM32f769-disco features a 4" MIPI DSI display: add support for it.
> > > On Cortex-M7 DMA can't use cached memory. For this reason I use a ded=
icated
> > > memory pool for DMA with no-cache attribute which is located at the e=
nd of
> > >  RAM.
> > >
> > > Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/stm32f746.dtsi      | 34 +++++++++++++++++++
> > >  arch/arm/boot/dts/stm32f769-disco.dts | 49 +++++++++++++++++++++++++=
++
> > >  2 files changed, 83 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm=
32f746.dtsi
> > > index 93c063796780..577a812ca01c 100644
> > > --- a/arch/arm/boot/dts/stm32f746.dtsi
> > > +++ b/arch/arm/boot/dts/stm32f746.dtsi
> > > @@ -48,6 +48,19 @@ / {
> > >         #address-cells =3D <1>;
> > >         #size-cells =3D <1>;
> > >
> > > +       reserved-memory {
> > > +               #address-cells =3D <1>;
> > > +               #size-cells =3D <1>;
> > > +               ranges;
> > > +
> > > +               linux,dma {
> > > +                       compatible =3D "shared-dma-pool";
> > > +                       linux,dma-default;
> > > +                       no-map;
> > > +                       reg =3D <0xc0f00000 0x100000>;
> > > +               };
> > > +       };
> > > +
> > Christoph Hellwig was submit a patch for !CONFIG_MMU platforms to suppo=
rt mmap.
> > the patch is : 1fbf57d05302 dma-direct: re-enable mmap for !CONFIG_MMU
> > i thought there is no need to create a reserved-memory for it.
>
> Just tried with his patch, if I don't have the reserved-memory, I get:
>
> [drm] Initialized stm 1.0.0 20170330 for 40016800.display-controller on m=
inor 0
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5 at arch/arm/mm/dma-mapping-nommu.c:50 0xc000b8e9
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.8.0-rc1-next-20200616 #4
> Hardware name: STM32 (Device Tree Support)
> Workqueue: events 0xc0150fc1
>
> This is the reason I added the reserved memory in the first place.
>
Oh, sorry, i forget stm32f7 with cache inside. yes, you need a reserve
memory for that case.
but, "reg =3D <0xc0f00000 0x100000>;" should big enough for framebuffer,
as your know this is
a global reserve memory for all devices, it's might need more for
other devices, like camera etc.
or use per-device reserve memory region.

thanks.
> >
> > >         clocks {
> > >                 clk_hse: clk-hse {
> > >                         #clock-cells =3D <0>;
> > > @@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
> > >         };
> > >
> > >         soc {
> > > +               ltdc: display-controller@40016800 {
> > > +                       compatible =3D "st,stm32-ltdc";
> > > +                       reg =3D <0x40016800 0x200>;
> > > +                       interrupts =3D <88>, <89>;
> > > +                       resets =3D <&rcc STM32F7_APB2_RESET(LTDC)>;
> > > +                       clocks =3D <&rcc 1 CLK_LCD>;
> > > +                       clock-names =3D "lcd";
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > > +               dsi: dsi@40016c00 {
> > > +                       compatible =3D "st,stm32-dsi";
> > > +                       reg =3D <0x40016c00 0x800>;
> > > +                       interrupts =3D <98>;
> > > +                       clocks =3D <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
> > > +                       clock-names =3D "pclk", "ref";
> > > +                       resets =3D <&rcc STM32F7_APB2_RESET(DSI)>;
> > > +                       reset-names =3D "apb";
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > >                 timer2: timer@40000000 {
> > >                         compatible =3D "st,stm32-timer";
> > >                         reg =3D <0x40000000 0x400>;
> > > diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dt=
s/stm32f769-disco.dts
> > > index 1626e00bb2cb..a9e81b49809c 100644
> > > --- a/arch/arm/boot/dts/stm32f769-disco.dts
> > > +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> > > @@ -153,3 +153,52 @@ &usbotg_hs {
> > >         pinctrl-names =3D "default";
> > >         status =3D "okay";
> > >  };
> > > +
> > > +&dsi {
> > > +       #address-cells =3D <1>;
> > > +       #size-cells =3D <0>;
> > > +       status =3D "okay";
> > > +
> > > +       ports {
> > > +               #address-cells =3D <1>;
> > > +               #size-cells =3D <0>;
> > > +
> > > +               port@0 {
> > > +                       reg =3D <0>;
> > > +                       dsi_in: endpoint {
> > > +                               remote-endpoint =3D <&ltdc_out_dsi>;
> > > +                       };
> > > +               };
> > > +
> > > +               port@1 {
> > > +                       reg =3D <1>;
> > > +                       dsi_out: endpoint {
> > > +                               remote-endpoint =3D <&dsi_in_panel>;
> > > +                       };
> > > +               };
> > > +
> > > +       };
> > > +
> > > +       panel: panel {
> > > +               compatible =3D "orisetech,otm8009a";
> > > +               reg =3D <0>;
> > > +               reset-gpios =3D <&gpioj 15 GPIO_ACTIVE_LOW>;
> > > +               status =3D "okay";
> > > +
> > > +               port {
> > > +                       dsi_in_panel: endpoint {
> > > +                               remote-endpoint =3D <&dsi_out>;
> > > +                       };
> > > +               };
> > > +       };
> > > +};
> > > +
> > > +&ltdc {
> > > +       status =3D "okay";
> > > +
> > > +       port {
> > > +               ltdc_out_dsi: endpoint {
> > > +                       remote-endpoint =3D <&dsi_in>;
> > > +               };
> > > +       };
> > > +};
> > > --
> > > 2.27.0
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> Regards,
> Adrian

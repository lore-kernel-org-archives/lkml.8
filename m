Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F89C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48A3207D3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJiFmaO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEPIih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgEPIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:38:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAC5C061A0C;
        Sat, 16 May 2020 01:38:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s21so4318037ejd.2;
        Sat, 16 May 2020 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9ORqMPvwiPeuaiySbbL/RSXPYuFp2sjZBmBACSvVb4=;
        b=oJiFmaO9gqb7DS1dlpAacukIBF598UJA4Nt5ZUhceGhBnOdLi4ljWtFz8Fxiof/69A
         Fkr/ViVuvP/a+Vn13nKPzNjcsKwLxXlHyfZdBm7NVj4zxZPLN/Aiu4B2qY6zqVraUpfG
         WN/eiYpLK/Q6gnuKTtrtwbJ6ZHfIyYUvJLvR9ul233drEZqDJMograz/Bc5AgibvRNgJ
         +Txc9cvSHdp2JrTMQN5JNUdaM39aIcFHMWfky5Ex1FqaptXNqvPxuULv9bNZnL7s6JUH
         UtwvP+ch5XWhL52oNiU6yHzmmD6WtiCwCyn8xNJJOSnvcz4vySq2mYRqGWaAbL+7CwCu
         b81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9ORqMPvwiPeuaiySbbL/RSXPYuFp2sjZBmBACSvVb4=;
        b=huwgeJsC67Ahdm/sAdSimSaEbFxJwUXMJMr0RCl2dt8TgpZT2KEM/hMlv8for3I5nV
         CTw4ZywLvxbxifAPokf5oqIExCqNywoGDaP1F5EoE7dTeGkLRi92UJ3rQVKZbJHf2p90
         Soo2ZCqrqyGOTJZSKfBh0lBPcDkGjiD0c5lYVklGAmyPJxSvsD4/uslkrT3fmGhDZPQL
         13rIbuz64GQKYtJdD/joEpsMdxCyh8ZZ8gfnPeWot7Wqkknrhzpn8vR1inZefC+/CYCU
         pXFFfHtdDun+c522BdG9F2d2KfW0Ln0nmDQjA8soIvHumvWygdw5oUvPGvn+wzDp96Ps
         iKUA==
X-Gm-Message-State: AOAM531czYWORRbHIk2k5d6+zx7buIEdO7WuZFlLQtCQRev2Gn7OQuTy
        ZbBKKGt0TSH9T9txH6fFjSJmeiAzoRv6FA526f7GwbXRBIH6Zg==
X-Google-Smtp-Source: ABdhPJwgyqfhQZmST+qUmMJfbQH9nNG9wMTERbqLfZfDLKc6LtGT6612db5GWSq0gSN6itAjdhp4IWRS8xTO5tkXAQs=
X-Received: by 2002:a17:906:90c1:: with SMTP id v1mr6187140ejw.322.1589618314221;
 Sat, 16 May 2020 01:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200424182139.32190-1-pop.adrian61@gmail.com>
 <3efb57a1-283b-f2f0-66a4-97e88c6c02d6@st.com> <CAP-HsdS0rq4iCq1oqpTU=EXF8UWbfPivCJVZG-4b7jyvdHHXUw@mail.gmail.com>
 <39c59632-e395-f7ec-12b9-ca1d667651a6@st.com>
In-Reply-To: <39c59632-e395-f7ec-12b9-ca1d667651a6@st.com>
From:   Adrian Pop <pop.adrian61@gmail.com>
Date:   Sat, 16 May 2020 11:39:03 +0300
Message-ID: <CAP-HsdQLnu=_dZDHfHBmWfE3TBYt3MAB6=nkier-bpe9Jc7dVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: stm32f769-disco: Enable MIPI DSI display support
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello all,

a bit of a delayed response here, but:

On Tue, Apr 28, 2020 at 11:39 AM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Hi Adrian
>
> On 4/27/20 10:05 PM, Adrian Pop wrote:
> > Added lee.jones@linaro.org.
> >
> > First, thank you all for taking a look at my changes!
>
> no pb.
>
> >
> > Hello Alex,
> >
> > On Mon, Apr 27, 2020 at 11:28 AM Alexandre Torgue
> > <alexandre.torgue@st.com> wrote:
> >>
> >> Hi Adrian
> >>
> >> On 4/24/20 8:21 PM, Adrian Pop wrote:
> >>> STM32f769-disco features a 4" MIPI DSI display: add support for it.
> >>>
> >>> Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> >>> ---
> >>
> >> Commit title should be ARM: dts: stm32: ...
> >
> > Will fix in next version if that's ok.
> >
> >>
> >> Can you explain a bit more in your commit message why do you use a
> >> reserved memory pool for DMA and where this pool is located. (I assume
> >> it's linked to a story of DMA and cache memory attribute on cortexM7...)
> >
> > Need to look more into this, but if I remove it, /dev/fb0 is not
> > available anymore and I get a warning stating:
> > ...
> > [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> > [drm] Initialized stm 1.0.0 20170330 for 40016800.display-controller on minor 0
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 13 at arch/arm/mm/dma-mapping-nommu.c:50 0xc000b8ed
> > CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 5.6.0-next-20200412 #23
> > Hardware name: STM32 (Device Tree Support)
> > Workqueue: events 0xc014fa35
> > Function entered at [<c000b325>] from [<c000a487>]
> > ...
> >
> > When I looked in arch/arm/mm/dma-mapping-nommu.c:50, there is a comment stating:
> >
> >      /*
> >       * dma_alloc_from_global_coherent() may fail because:
> >       *
> >       * - no consistent DMA region has been defined, so we can't
> >       *   continue.
> >       * - there is no space left in consistent DMA region, so we
> >       *   only can fallback to generic allocator if we are
> >       *   advertised that consistency is not required.
> >       */
> >
> > This is the reason I added the reserved-memory.
>
> Note that on cortexM7 DMA can't use cached memory. For this reason you
> have to declare a dedicated memory area for DMA with no-cache attribute.
> It is done thanks to a "linux,dma" node plus a kernel config:
> CONFIG_ARM_MPU. I planed to declare this dedicated memeory region in
> sram. Can you check if add it for the same reason I explain and check if
> it works using sram ?
>

I did not have CONFIG_ARM_MPU enabled, enabled it now.

Just tried with SRAM:
reg = <0x20020000 0x60000>; /* SRAM1 368KB + SRAM2 16KB*/

but `arm_nommu_dma_alloc()` size parameter is 819200 (which is bigger
than the SRAM reserved memory), so the
`dma_alloc_from_global_coherent()` fails, so again I get the warning
stated above.

>
>
> >
> > About the location, does it need to be hardcoded? On my board
> > (STM32F769I-Disco, tftp boot) in boot log I get:
> > ...
> > Reserved memory: created DMA memory pool at 0xc0ef1000, size 1 MiB
> > OF: reserved mem: initialized node linux,dma, compatible id shared-dma-pool
> > ...
> >
> >>
> >> Did you try this configuration with XIP boot ?
> >
> > I did not try with XIP. Currently loading zImage from tftp to memory.
> > Will try with XIP as well, and get back with feedback.

Still trying to figure how to XIP :).

>
> Ok thanks.
>
> >
> >>
> >> regards
> >> alex
> >>
> >>>    arch/arm/boot/dts/stm32f746.dtsi      | 34 ++++++++++++++++++
> >>>    arch/arm/boot/dts/stm32f769-disco.dts | 50 +++++++++++++++++++++++++++
> >>>    2 files changed, 84 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> >>> index 93c063796780..202bb6edc9f1 100644
> >>> --- a/arch/arm/boot/dts/stm32f746.dtsi
> >>> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> >>> @@ -48,6 +48,19 @@ / {
> >>>        #address-cells = <1>;
> >>>        #size-cells = <1>;
> >>>
> >>> +     reserved-memory {
> >>> +             #address-cells = <1>;
> >>> +             #size-cells = <1>;
> >>> +             ranges;
> >>> +
> >>> +             linux,dma {
> >>> +                     compatible = "shared-dma-pool";
> >>> +                     linux,dma-default;
> >>> +                     no-map;
> >>> +                     size = <0x10F000>;
> >>> +             };
> >>> +     };
> >>> +
> >>>        clocks {
> >>>                clk_hse: clk-hse {
> >>>                        #clock-cells = <0>;
> >>> @@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
> >>>        };
> >>>
> >>>        soc {
> >>> +             ltdc: display-controller@40016800 {
> >>> +                     compatible = "st,stm32-ltdc";
> >>> +                     reg = <0x40016800 0x200>;
> >>> +                     interrupts = <88>, <89>;
> >>> +                     resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
> >>> +                     clocks = <&rcc 1 CLK_LCD>;
> >>> +                     clock-names = "lcd";
> >>> +                     status = "disabled";
> >>> +             };
> >>> +
> >>> +             dsi: dsi@40016c00 {
> >>> +                     compatible = "st,stm32-dsi";
> >>> +                     reg = <0x40016c00 0x800>;
> >>> +                     interrupts = <98>;
> >>> +                     clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
> >>> +                     clock-names = "pclk", "ref";
> >>> +                     resets = <&rcc STM32F7_APB2_RESET(DSI)>;
> >>> +                     reset-names = "apb";
> >>> +                     status = "disabled";
> >>> +             };
> >>> +
> >>>                timer2: timer@40000000 {
> >>>                        compatible = "st,stm32-timer";
> >>>                        reg = <0x40000000 0x400>;
> >>> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> >>> index 1626e00bb2cb..30ebbc193e82 100644
> >>> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> >>> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> >>> @@ -153,3 +153,53 @@ &usbotg_hs {
> >>>        pinctrl-names = "default";
> >>>        status = "okay";
> >>>    };
> >>> +
> >>> +&dsi {
> >>> +     #address-cells = <1>;
> >>> +     #size-cells = <0>;
> >>> +     status = "okay";
> >>> +
> >>> +     ports {
> >>> +             #address-cells = <1>;
> >>> +             #size-cells = <0>;
> >>> +
> >>> +             port@0 {
> >>> +                     reg = <0>;
> >>> +                     dsi_in: endpoint {
> >>> +                             remote-endpoint = <&ltdc_out_dsi>;
> >>> +                     };
> >>> +             };
> >>> +
> >>> +             port@1 {
> >>> +                     reg = <1>;
> >>> +                     dsi_out: endpoint {
> >>> +                             remote-endpoint = <&dsi_in_panel>;
> >>> +                     };
> >>> +             };
> >>> +
> >>> +     };
> >>> +
> >>> +     panel: panel {
> >>> +             compatible = "orisetech,otm8009a";
> >>> +             reg = <0>; /* dsi virtual channel (0..3) */
> >>> +             reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
> >>> +             status = "okay";
> >>> +
> >>> +             port {
> >>> +                     dsi_in_panel: endpoint {
> >>> +                             remote-endpoint = <&dsi_out>;
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&ltdc {
> >>> +     dma-ranges;
> >
> > Need to remove this, not needed and causes a warning.
> >
> >>> +     status = "okay";
> >>> +
> >>> +     port {
> >>> +             ltdc_out_dsi: endpoint {
> >>> +                     remote-endpoint = <&dsi_in>;
> >>> +             };
> >>> +     };
> >>> +};
> >>>
> >
> > Regards,
> > Adrian
> >

Regards,
Adrian

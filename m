Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6ABC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19AB206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD++08mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgD0UF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbgD0UF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:05:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCEEC0610D5;
        Mon, 27 Apr 2020 13:05:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s10so14506400edy.9;
        Mon, 27 Apr 2020 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yXU65+Kc2UcXPVHH+ETGSKy2NXXR26k4bx7MRK6hTc=;
        b=iD++08mifUw87PBkeoPTVMI7mbtR+i/1xKZuKo7UCCyKXSzoR+YFPV54sMxoT+YfT7
         R+XRVcH/4Jy7rCBcYSO6hiXrbCG1DU5ASjLZzgew3SdylK5Tvww/vbQMbZVFvDUifc2z
         viS/T9HH4P+Sx0N3bMYlM0ar+/Qzu/LJAvgS3mUS1DsENx6/YmDkiumtOJoz4FafSkx/
         tuYRhXkMd7+zBEZsPpiJbhEaXo8XL2yYFNFeoEo965qBen7ETP/t4koP0RR/CVA6Haai
         ts8fR3gjLyNWxt8wZv5sKqSsAoKc7TiMlDnWehYj4KEorjs266UydRf2uHipI07oJdNg
         OPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yXU65+Kc2UcXPVHH+ETGSKy2NXXR26k4bx7MRK6hTc=;
        b=ImVAxk8C/wzCS5Y8qULAafiADvdCpRjkWaCWzKO4zGSAJL28QJ6EUDXKOE3KKCf0CQ
         u3lVaTXJt10NBszGNKVu7/tUyYmdmpC32EkisnDZ7Hd8PGuNlP00QzQFidMfBbhU1Oh6
         /pE6K76kwmzTaEldcvPAZbHtEQbus/nBYEAZQxCeVL7dMzUI4WkYxA4O44AMFXccJxWj
         ivkO9gTPqvOwbQoFtkrShx5CrGKAjJfwZdu8j84C9nT4VIXxS34Zoz/5WuxBOUtiju9J
         e+Ie2CpAsEzdl1OZ3/GNtvHvpeMbaVAuaJB1jdgcZigYtr3eXwIM8jlrgLqWFO7qHfev
         WNTw==
X-Gm-Message-State: AGi0Pua+5SEbHMkCmYqXn8CdN4p3KeYAeXk37rBrl037uj+s2vwMl5Og
        knBT5c4m8c2nd4KmPxt52Yzs/vucXFmHSMltkvw=
X-Google-Smtp-Source: APiQypIY/zDA+cX9HGDQmCk+x1yevA/lfThelg1G0GWFZnD3MnNwgcSiaZezJPN3HQIKkIAKGXiuhtDyOOlj9uQzePY=
X-Received: by 2002:a05:6402:319c:: with SMTP id di28mr20908888edb.185.1588017956568;
 Mon, 27 Apr 2020 13:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200424182139.32190-1-pop.adrian61@gmail.com> <3efb57a1-283b-f2f0-66a4-97e88c6c02d6@st.com>
In-Reply-To: <3efb57a1-283b-f2f0-66a4-97e88c6c02d6@st.com>
From:   Adrian Pop <pop.adrian61@gmail.com>
Date:   Mon, 27 Apr 2020 23:05:54 +0300
Message-ID: <CAP-HsdS0rq4iCq1oqpTU=EXF8UWbfPivCJVZG-4b7jyvdHHXUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: stm32f769-disco: Enable MIPI DSI display support
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added lee.jones@linaro.org.

First, thank you all for taking a look at my changes!

Hello Alex,

On Mon, Apr 27, 2020 at 11:28 AM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Hi Adrian
>
> On 4/24/20 8:21 PM, Adrian Pop wrote:
> > STM32f769-disco features a 4" MIPI DSI display: add support for it.
> >
> > Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> > ---
>
> Commit title should be ARM: dts: stm32: ...

Will fix in next version if that's ok.

>
> Can you explain a bit more in your commit message why do you use a
> reserved memory pool for DMA and where this pool is located. (I assume
> it's linked to a story of DMA and cache memory attribute on cortexM7...)

Need to look more into this, but if I remove it, /dev/fb0 is not
available anymore and I get a warning stating:
...
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Initialized stm 1.0.0 20170330 for 40016800.display-controller on minor 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 13 at arch/arm/mm/dma-mapping-nommu.c:50 0xc000b8ed
CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 5.6.0-next-20200412 #23
Hardware name: STM32 (Device Tree Support)
Workqueue: events 0xc014fa35
Function entered at [<c000b325>] from [<c000a487>]
...

When I looked in arch/arm/mm/dma-mapping-nommu.c:50, there is a comment stating:

    /*
     * dma_alloc_from_global_coherent() may fail because:
     *
     * - no consistent DMA region has been defined, so we can't
     *   continue.
     * - there is no space left in consistent DMA region, so we
     *   only can fallback to generic allocator if we are
     *   advertised that consistency is not required.
     */

This is the reason I added the reserved-memory.

About the location, does it need to be hardcoded? On my board
(STM32F769I-Disco, tftp boot) in boot log I get:
...
Reserved memory: created DMA memory pool at 0xc0ef1000, size 1 MiB
OF: reserved mem: initialized node linux,dma, compatible id shared-dma-pool
...

>
> Did you try this configuration with XIP boot ?

I did not try with XIP. Currently loading zImage from tftp to memory.
Will try with XIP as well, and get back with feedback.

>
> regards
> alex
>
> >   arch/arm/boot/dts/stm32f746.dtsi      | 34 ++++++++++++++++++
> >   arch/arm/boot/dts/stm32f769-disco.dts | 50 +++++++++++++++++++++++++++
> >   2 files changed, 84 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> > index 93c063796780..202bb6edc9f1 100644
> > --- a/arch/arm/boot/dts/stm32f746.dtsi
> > +++ b/arch/arm/boot/dts/stm32f746.dtsi
> > @@ -48,6 +48,19 @@ / {
> >       #address-cells = <1>;
> >       #size-cells = <1>;
> >
> > +     reserved-memory {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             ranges;
> > +
> > +             linux,dma {
> > +                     compatible = "shared-dma-pool";
> > +                     linux,dma-default;
> > +                     no-map;
> > +                     size = <0x10F000>;
> > +             };
> > +     };
> > +
> >       clocks {
> >               clk_hse: clk-hse {
> >                       #clock-cells = <0>;
> > @@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
> >       };
> >
> >       soc {
> > +             ltdc: display-controller@40016800 {
> > +                     compatible = "st,stm32-ltdc";
> > +                     reg = <0x40016800 0x200>;
> > +                     interrupts = <88>, <89>;
> > +                     resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
> > +                     clocks = <&rcc 1 CLK_LCD>;
> > +                     clock-names = "lcd";
> > +                     status = "disabled";
> > +             };
> > +
> > +             dsi: dsi@40016c00 {
> > +                     compatible = "st,stm32-dsi";
> > +                     reg = <0x40016c00 0x800>;
> > +                     interrupts = <98>;
> > +                     clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
> > +                     clock-names = "pclk", "ref";
> > +                     resets = <&rcc STM32F7_APB2_RESET(DSI)>;
> > +                     reset-names = "apb";
> > +                     status = "disabled";
> > +             };
> > +
> >               timer2: timer@40000000 {
> >                       compatible = "st,stm32-timer";
> >                       reg = <0x40000000 0x400>;
> > diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> > index 1626e00bb2cb..30ebbc193e82 100644
> > --- a/arch/arm/boot/dts/stm32f769-disco.dts
> > +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> > @@ -153,3 +153,53 @@ &usbotg_hs {
> >       pinctrl-names = "default";
> >       status = "okay";
> >   };
> > +
> > +&dsi {
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +     status = "okay";
> > +
> > +     ports {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             port@0 {
> > +                     reg = <0>;
> > +                     dsi_in: endpoint {
> > +                             remote-endpoint = <&ltdc_out_dsi>;
> > +                     };
> > +             };
> > +
> > +             port@1 {
> > +                     reg = <1>;
> > +                     dsi_out: endpoint {
> > +                             remote-endpoint = <&dsi_in_panel>;
> > +                     };
> > +             };
> > +
> > +     };
> > +
> > +     panel: panel {
> > +             compatible = "orisetech,otm8009a";
> > +             reg = <0>; /* dsi virtual channel (0..3) */
> > +             reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
> > +             status = "okay";
> > +
> > +             port {
> > +                     dsi_in_panel: endpoint {
> > +                             remote-endpoint = <&dsi_out>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&ltdc {
> > +     dma-ranges;

Need to remove this, not needed and causes a warning.

> > +     status = "okay";
> > +
> > +     port {
> > +             ltdc_out_dsi: endpoint {
> > +                     remote-endpoint = <&dsi_in>;
> > +             };
> > +     };
> > +};
> >

Regards,
Adrian

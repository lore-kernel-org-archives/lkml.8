Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525EC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9892074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="PuqHGcgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgG1PfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbgG1PfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:35:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FCFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:35:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so259056wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vb051nwsz1oFDTdTE4PvPbZDMm4dY8V4dc54yc3QdHo=;
        b=PuqHGcghavxG+M+UxbDUYCDQiwxB7+25GHVYjurZ9tngk/RJ1pWDAOFY7K3ysgS9VQ
         B4BzobeVOmSQYj+He4fnx5XqId/M3UAmvDucszEo/pD4Ihi2ekoZRdlgB9c4x696mqZu
         79yq9H3z2M7dsYVRTwUxwa4YuM2o4BCFSaEzj3uWQNRFJfyrEYh8Tn46dNakZSS2nA9G
         ahM+sXx2tNzOp7wK9J4c4t+QRnjLBOR9l8bPglSjslXbwy8crsA4Hp1b1mOQzdzIJgAc
         v/VYtVLFzyTZxvwPW2RurRdWRdo9mdFhex9prNIf4d5cz1d2jxyLg6aUqhRDTazyymex
         1znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vb051nwsz1oFDTdTE4PvPbZDMm4dY8V4dc54yc3QdHo=;
        b=ewwE2WvJt1k+4bRrKvxmVqWVKteS4p+lpoyUIt10/CcT04nhMM9rHQXi89bhnsDIQp
         xg4px/7O+gWV265cjvl/CnZWjq5aVZf7T+PhhMfT49Dw3x6iZoQeMWaXvUSm74m7UyTe
         lRqXDgagXdf/64VbmJRSTyDYOnvSYCR5gdrqExtAa11xtJrecy4Wc3TzqlrdSR5jJgGF
         FLx8Is+rloDkWbqoW7izPz3JTxDFUdlg7VTpG9Z3qRdhTbNlzqVov32/4KbJWEWS7Ret
         87c0+3MTBAqLX+mdMSZKky1rTmMzeJ3y/ug/O1JT+rVet9izY6YjN7woRqZ4axyQ3a0o
         7j/w==
X-Gm-Message-State: AOAM531BASENBWpFjjFWNuFZDP+j10VjB8NVrDuqjbFwv6K9zN9C8iIH
        NrSsuGd1v9a5vn9j/tB5Tw8F4tg8QSNQGgJPGeMjaQ==
X-Google-Smtp-Source: ABdhPJxkm2v1Q9HSR+NTDmGwJ0bTshZraeUhWh/nyqG692TGcMn+DvulMQyNskb5tLiSZmwokmGYenx5lpXw9dARU5c=
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr2086622wmd.82.1595950521247;
 Tue, 28 Jul 2020 08:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <768aa056fded89f2ee59b4bdc32223955bb8ffe2.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <768aa056fded89f2ee59b4bdc32223955bb8ffe2.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 16:35:06 +0100
Message-ID: <CAPY8ntCa7C-1wcfduw2jqkWDFUYmtPZ=GdhduaidydRm_EUggA@mail.gmail.com>
Subject: Re: [PATCH v4 78/78] ARM: dts: bcm2711: Enable the display pipeline
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 8 Jul 2020 at 18:44, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Now that all the drivers have been adjusted for it, let's bring in the
> necessary device tree changes.

Possibly a comment to say that the VEC and PV3 are deliberately NOT
enabled as the VEC requires further very specific clock setup changes?

> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Otherwise
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  46 +++++++++++-
>  arch/arm/boot/dts/bcm2711.dtsi        | 115 ++++++++++++++++++++++++++-
>  2 files changed, 160 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index 222d7825e1ab..b93eb30e1ddb 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -68,6 +68,14 @@
>         };
>  };
>
> +&ddc0 {
> +       status = "okay";
> +};
> +
> +&ddc1 {
> +       status = "okay";
> +};
> +
>  &firmware {
>         firmware_clocks: clocks {
>                 compatible = "raspberrypi,firmware-clocks";
> @@ -163,6 +171,36 @@
>                           "RGMII_TXD3";
>  };
>
> +&hdmi0 {
> +       clocks = <&firmware_clocks 13>, <&dvp 0>;
> +       status = "okay";
> +};
> +
> +&hdmi1 {
> +       clocks = <&firmware_clocks 13>, <&dvp 1>;
> +       status = "okay";
> +};
> +
> +&hvs {
> +       clocks = <&firmware_clocks 4>;
> +};
> +
> +&pixelvalve0 {
> +       status = "okay";
> +};
> +
> +&pixelvalve1 {
> +       status = "okay";
> +};
> +
> +&pixelvalve2 {
> +       status = "okay";
> +};
> +
> +&pixelvalve4 {
> +       status = "okay";
> +};
> +
>  &pwm1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pwm1_0_gpio40 &pwm1_1_gpio41>;
> @@ -231,3 +269,11 @@
>  &vchiq {
>         interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  };
> +
> +&vc4 {
> +       status = "okay";
> +};
> +
> +&vec {
> +       status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> index 00bcaed1be32..e637378650f6 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -12,6 +12,11 @@
>
>         interrupt-parent = <&gicv2>;
>
> +       vc4: gpu {
> +               compatible = "brcm,bcm2711-vc5";
> +               status = "disabled";
> +       };
> +
>         clk_108MHz: clk-108M {
>                 #clock-cells = <0>;
>                 compatible = "fixed-clock";
> @@ -238,6 +243,27 @@
>                         status = "disabled";
>                 };
>
> +               pixelvalve0: pixelvalve@7e206000 {
> +                       compatible = "brcm,bcm2711-pixelvalve0";
> +                       reg = <0x7e206000 0x100>;
> +                       interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               pixelvalve1: pixelvalve@7e207000 {
> +                       compatible = "brcm,bcm2711-pixelvalve1";
> +                       reg = <0x7e207000 0x100>;
> +                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               pixelvalve2: pixelvalve@7e20a000 {
> +                       compatible = "brcm,bcm2711-pixelvalve2";
> +                       reg = <0x7e20a000 0x100>;
> +                       interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
>                 pwm1: pwm@7e20c800 {
>                         compatible = "brcm,bcm2835-pwm";
>                         reg = <0x7e20c800 0x28>;
> @@ -248,10 +274,25 @@
>                         status = "disabled";
>                 };
>
> -               hvs@7e400000 {
> +               pixelvalve4: pixelvalve@7e216000 {
> +                       compatible = "brcm,bcm2711-pixelvalve4";
> +                       reg = <0x7e216000 0x100>;
> +                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               hvs: hvs@7e400000 {
> +                       compatible = "brcm,bcm2711-hvs";
>                         interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> +               pixelvalve3: pixelvalve@7ec12000 {
> +                       compatible = "brcm,bcm2711-pixelvalve3";
> +                       reg = <0x7ec12000 0x100>;
> +                       interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
>                 dvp: clock@7ef00000 {
>                         compatible = "brcm,brcm2711-dvp";
>                         reg = <0x7ef00000 0x10>;
> @@ -259,6 +300,78 @@
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
>                 };
> +
> +               hdmi0: hdmi@7ef00700 {
> +                       compatible = "brcm,bcm2711-hdmi0";
> +                       reg = <0x7ef00700 0x300>,
> +                             <0x7ef00300 0x200>,
> +                             <0x7ef00f00 0x80>,
> +                             <0x7ef00f80 0x80>,
> +                             <0x7ef01b00 0x200>,
> +                             <0x7ef01f00 0x400>,
> +                             <0x7ef00200 0x80>,
> +                             <0x7ef04300 0x100>,
> +                             <0x7ef20000 0x100>;
> +                       reg-names = "hdmi",
> +                                   "dvp",
> +                                   "phy",
> +                                   "rm",
> +                                   "packet",
> +                                   "metadata",
> +                                   "csc",
> +                                   "cec",
> +                                   "hd";
> +                       clock-names = "hdmi", "clk-108M";
> +                       resets = <&dvp 0>;
> +                       ddc = <&ddc0>;
> +                       dmas = <&dma 10>;
> +                       dma-names = "audio-rx";
> +                       status = "disabled";
> +               };
> +
> +               ddc0: i2c@7ef04500 {
> +                       compatible = "brcm,bcm2711-hdmi-i2c";
> +                       reg = <0x7ef04500 0x100>, <0x7ef00b00 0x300>;
> +                       reg-names = "bsc", "auto-i2c";
> +                       clock-frequency = <97500>;
> +                       status = "disabled";
> +               };
> +
> +               hdmi1: hdmi@7ef05700 {
> +                       compatible = "brcm,bcm2711-hdmi1";
> +                       reg = <0x7ef05700 0x300>,
> +                             <0x7ef05300 0x200>,
> +                             <0x7ef05f00 0x80>,
> +                             <0x7ef05f80 0x80>,
> +                             <0x7ef06b00 0x200>,
> +                             <0x7ef06f00 0x400>,
> +                             <0x7ef00280 0x80>,
> +                             <0x7ef09300 0x100>,
> +                             <0x7ef20000 0x100>;
> +                       reg-names = "hdmi",
> +                                   "dvp",
> +                                   "phy",
> +                                   "rm",
> +                                   "packet",
> +                                   "metadata",
> +                                   "csc",
> +                                   "cec",
> +                                   "hd";
> +                       ddc = <&ddc1>;
> +                       clock-names = "hdmi", "clk-108M";
> +                       resets = <&dvp 1>;
> +                       dmas = <&dma 17>;
> +                       dma-names = "audio-rx";
> +                       status = "disabled";
> +               };
> +
> +               ddc1: i2c@7ef09500 {
> +                       compatible = "brcm,bcm2711-hdmi-i2c";
> +                       reg = <0x7ef09500 0x100>, <0x7ef05b00 0x300>;
> +                       reg-names = "bsc", "auto-i2c";
> +                       clock-frequency = <97500>;
> +                       status = "disabled";
> +               };
>         };
>
>         /*
> --
> git-series 0.9.1

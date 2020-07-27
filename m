Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBAEC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0367D20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="KiIBbWcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgG0XRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0XRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:17:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427DC061794;
        Mon, 27 Jul 2020 16:17:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dk23so6882148ejb.11;
        Mon, 27 Jul 2020 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDnv2u+7TDzJf6n14HBXmnArxjJaJEHjEbe0bHhRUEs=;
        b=KiIBbWcBZhyW+O5o7G4YzliTSdzRlHO3ORbQkKF7vDXDh+RKwoKsVS45CuN6sDhcwi
         MS6gtQ4SbOeq5N0U5rZO71owLxneWs+NmllXn5j9Yxmf5YXLh/ug6/MQNw66FQv3ZTm0
         +ys2uAAqEIS/PjtOWviT2taNv9v6u0vORAEU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDnv2u+7TDzJf6n14HBXmnArxjJaJEHjEbe0bHhRUEs=;
        b=sxhZKtd1aAXoQFEcSEfCiNJM/Vi1eHgxxAKPCIMGWU6QRYHlSLVEmfhlPwTba/llzW
         nU8o3XYQ0XEb0HTe66L2S0B1KZ+Vqfyhdvh+zddDr6GA3JWWHIrzG0pXOZxFj/11by7K
         eaVVQ4emIlPPlmHo7FJt5uoMCm01UqDyx3SJzmVMkfLq0KT1KXU/craM3VfJ9oqZPE2N
         wBfJy3pdQQzs8kcjSsrgyOiJRzaVn+F3wglw859MeSChf+lKLe6Wr3YrisseLaDDC7BP
         BVAm80ESxxk3ZBv1ulnCZtWAJrfYprRek7uhNcRRBzqBX/Xbop13+fbl3LlANiw2P7Hl
         whHg==
X-Gm-Message-State: AOAM531H3famPpru0ZyjR2MvnkVCKmaR31saiYPzgNgBgbj5nqa/edWg
        XrES5CgxOnL9mvtEWbdKPPXJpBhU146PHpzy4Js=
X-Google-Smtp-Source: ABdhPJxOcmWyKoA18jpAXsp32LtWuJw1BLE/bPSxZbhDgSL2NjTVUOG5rI+yrx1nsrMlE7eI1AugXL9kMzpILn9Lr7w=
X-Received: by 2002:a17:906:488:: with SMTP id f8mr13964940eja.215.1595891865841;
 Mon, 27 Jul 2020 16:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200724192818.68068-1-supreeth.venkatesh@amd.com>
In-Reply-To: <20200724192818.68068-1-supreeth.venkatesh@amd.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 27 Jul 2020 23:17:33 +0000
Message-ID: <CACPK8XcZCySQt_wVzkthciYWg_GfOY-7VAkFxu5TjuJRRMFRxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ARM:dts:aspeed: Initial device tree for AMD EthanolX
To:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 19:28, Supreeth Venkatesh
<supreeth.venkatesh@amd.com> wrote:
>
> Initial introduction of AMD EthanolX platform equipped with an
> Aspeed ast2500 BMC manufactured by AMD.
>
> AMD EthanolX platform is an AMD customer reference board with an
> Aspeed ast2500 BMC manufactured by AMD.
> This adds AMD EthanolX device tree file including the flash layout
> used by EthanolX BMC machines.
>
> This also adds an entry of AMD EthanolX device tree file in Makefile.
>
> Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>

Looks good! I've merged this to dt-for-5.9.

Cheers,

Joel

> ---
> Changes since v2:
> * Removed incorrect I2C0 and I2C1 Reg addresses
>
> Changes since v1:
> * Addressed review comment regarding SPDX License Identifier
> * Added I2c0 and I2c1 which cater to AMD's APML Interface
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 219 ++++++++++++++++++
>  2 files changed, 220 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d6dfdf73e66b..55ed881d2ebc 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1281,6 +1281,7 @@ dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
>  dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-ast2500-evb.dtb \
>         aspeed-ast2600-evb.dtb \
> +       aspeed-bmc-amd-ethanolx.dtb \
>         aspeed-bmc-arm-centriq2400-rep.dtb \
>         aspeed-bmc-arm-stardragon4800-rep2.dtb \
>         aspeed-bmc-facebook-cmm.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> new file mode 100644
> index 000000000000..60ba86f3e5bc
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2020 AMD Inc.
> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +       model = "AMD EthanolX BMC";
> +       compatible = "amd,ethanolx-bmc", "aspeed,ast2500";
> +
> +       memory@80000000 {
> +               reg = <0x80000000 0x20000000>;
> +       };
> +       aliases {
> +               serial0 = &uart1;
> +               serial4 = &uart5;
> +       };
> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=ttyS4,115200 earlyprintk";
> +       };
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               fault {
> +                       gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               identify {
> +                       gpios = <&gpio ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>;
> +       };
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               #include "openbmc-flash-layout.dtsi"
> +       };
> +};
> +
> +
> +&mac0 {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii1_default>;
> +       clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
> +                <&syscon ASPEED_CLK_MAC1RCLK>;
> +       clock-names = "MACCLK", "RCLK";
> +};
> +
> +&uart1 {
> +       //Host Console
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_txd1_default
> +                    &pinctrl_rxd1_default>;
> +};
> +
> +&uart5 {
> +       //BMC Console
> +       status = "okay";
> +};
> +
> +&adc {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_adc0_default
> +                    &pinctrl_adc1_default
> +                    &pinctrl_adc2_default
> +                    &pinctrl_adc3_default
> +                    &pinctrl_adc4_default>;
> +};
> +
> +//APML for P0
> +&i2c0 {
> +       status = "okay";
> +};
> +
> +//APML for P1
> +&i2c1 {
> +       status = "okay";
> +};
> +
> +// Thermal Sensors
> +&i2c7 {
> +       status = "okay";
> +
> +       lm75a@48 {
> +               compatible = "national,lm75a";
> +               reg = <0x48>;
> +       };
> +
> +       lm75a@49 {
> +               compatible = "national,lm75a";
> +               reg = <0x49>;
> +       };
> +
> +       lm75a@4a {
> +               compatible = "national,lm75a";
> +               reg = <0x4a>;
> +       };
> +
> +       lm75a@4b {
> +               compatible = "national,lm75a";
> +               reg = <0x4b>;
> +       };
> +
> +       lm75a@4c {
> +               compatible = "national,lm75a";
> +               reg = <0x4c>;
> +       };
> +
> +       lm75a@4d {
> +               compatible = "national,lm75a";
> +               reg = <0x4d>;
> +       };
> +
> +       lm75a@4e {
> +               compatible = "national,lm75a";
> +               reg = <0x4e>;
> +       };
> +
> +       lm75a@4f {
> +               compatible = "national,lm75a";
> +               reg = <0x4f>;
> +       };
> +};
> +
> +&kcs1 {
> +       status = "okay";
> +       kcs_addr = <0x60>;
> +};
> +
> +&kcs2 {
> +       status = "okay";
> +       kcs_addr = <0x62>;
> +};
> +
> +&kcs4 {
> +       status = "okay";
> +       kcs_addr = <0x97DE>;
> +};
> +
> +&lpc_snoop {
> +       status = "okay";
> +       snoop-ports = <0x80>;
> +};
> +
> +&lpc_ctrl {
> +       //Enable lpc clock
> +       status = "okay";
> +};
> +
> +&pwm_tacho {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pwm0_default
> +       &pinctrl_pwm1_default
> +       &pinctrl_pwm2_default
> +       &pinctrl_pwm3_default
> +       &pinctrl_pwm4_default
> +       &pinctrl_pwm5_default
> +       &pinctrl_pwm6_default
> +       &pinctrl_pwm7_default>;
> +
> +       fan@0 {
> +               reg = <0x00>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> +       };
> +
> +       fan@1 {
> +               reg = <0x01>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x01>;
> +       };
> +
> +       fan@2 {
> +               reg = <0x02>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x02>;
> +       };
> +
> +       fan@3 {
> +               reg = <0x03>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x03>;
> +       };
> +
> +       fan@4 {
> +               reg = <0x04>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x04>;
> +       };
> +
> +       fan@5 {
> +               reg = <0x05>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x05>;
> +       };
> +
> +       fan@6 {
> +               reg = <0x06>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x06>;
> +       };
> +
> +       fan@7 {
> +               reg = <0x07>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x07>;
> +       };
> +};
> +
> +
> +
> --
> 2.17.1
>

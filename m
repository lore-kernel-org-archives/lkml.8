Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B79C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FE4206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fIbkomCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGWHXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:23:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3142C0619DC;
        Thu, 23 Jul 2020 00:23:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so3751821edb.3;
        Thu, 23 Jul 2020 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLPgzcsqBl8BLWzd8qx22r2XTFTWtpGQsBjetQCneRM=;
        b=fIbkomCViGTYvfgH3bkn+ta2bQ6ARND3yu52XSnCJyIPjjOAZjYHkXgd+usMfhiSmm
         0Ht2JOCZq5YrVpJWj/oe+QJGzayzVEsOAqSFDnPSPvG/OzyULhsSIV0Pya6d2IgIJXJJ
         xa3SlfhFESJqVfOh512jaHofva++Nau1cFDos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLPgzcsqBl8BLWzd8qx22r2XTFTWtpGQsBjetQCneRM=;
        b=M6d4oeyzwHkmcMsCO0fY5IoSflPBei9qvGIwXaRtnIopjM2QSJ2Z1m4HaTjdysxwgf
         q7/Q+fTcdQtjTv/RTb4X0uHgTldz4o13ofggcm0D04sVDaGWoKSvtaVX2bzWqkTXbFlC
         9lE/SbHfrY2ubGWxTjpPMxJbsRdbKwRkDKDZJFx3mI2dVJUTmC115LPN4HsqPGj8hODd
         v2P7nZwiRqc0i24q7Uy/CrwW5wV755TfVZRpbqB79l+wYlD7aYNxmKY4pTr/gCJc82JS
         C01aUJ7Sw9gHYmjNbtqVGG8PKjW0mEBdWu/ghMCQIq+JXT7m/1uEjFyuTQjWYRMI53tn
         pzXQ==
X-Gm-Message-State: AOAM532y35tW6Cd7WrPV7PKv1KhWQfOuXk1e13Tq39DKR1l1kt5V0wEs
        3B94WFURgE+8UOdatj+vfkuPkYTS7umwZSX+wSE=
X-Google-Smtp-Source: ABdhPJxMyqdWwSuBwu8MNS+0WpqpoVpe8AAO1fOe+Ch0v1BDhLApZwHHIBZJ+TQKl+Gnwl2YebfJHNqpsWC2O9+ZUfs=
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr3057783edb.232.1595489015613;
 Thu, 23 Jul 2020 00:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200722215506.5984-1-supreeth.venkatesh@amd.com>
In-Reply-To: <20200722215506.5984-1-supreeth.venkatesh@amd.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 23 Jul 2020 07:23:23 +0000
Message-ID: <CACPK8XeAr+Y1ySCa4DXeoHU-39eS2g38QOSgvbMk-VmbPk4cVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM:dts:aspeed: Initial device tree for AMD EthanolX
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

On Wed, 22 Jul 2020 at 21:55, Supreeth Venkatesh
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
> ---
> Changes since v1:
> * Addressed review comment regarding SPDX License Identifier
> * Added I2c0 and I2c1 which cater to AMD's APML Interface
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 221 ++++++++++++++++++
>  2 files changed, 222 insertions(+)
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
> index 000000000000..3d67fa31a3ab
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -0,0 +1,221 @@
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
> +       reg = <0x80 0x40>;
> +       status = "okay";
> +};
> +
> +//APML for P1
> +&i2c1 {
> +       reg = <0xc0 0x40>;

This is unusual. i2c1 is at 0x80; this will clash with i2c2.

Note that the i2c naming in linux counts from zero, whereas the ASPEED
docs count from 1. So if your board layout has I2C1, you actually want
i2c2 in the device tree.

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

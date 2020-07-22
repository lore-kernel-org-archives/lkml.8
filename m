Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F971C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1364E207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="XlgcqI4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGVF55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgGVF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:57:55 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D36C061794;
        Tue, 21 Jul 2020 22:57:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so743912edz.0;
        Tue, 21 Jul 2020 22:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HyvRxIrXJ94hpJJ10KYHhFfMdEOmHA2GHT0K+5iUXk=;
        b=XlgcqI4MvjemKHQVFDQvUzykkZRmP3lD/jG4aYdiM6hGOhyvXScttPI7hWy9rKRfuk
         7J0QusowPX9dYB44LlAJBmavv5IOKWu71jWfGsTCuhQfavb8v/oc7Gq4CemDQBtbwA2A
         uio4InFKyFHp+HAVNkP3Xk0qQQOfYwlexvZpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HyvRxIrXJ94hpJJ10KYHhFfMdEOmHA2GHT0K+5iUXk=;
        b=ZhWXg9bMhlj92q3/SxMg5W8MoMWZZWGDfj9pdl1N6d/nPy7Jf/NCPVtxi0TVv1Eg9k
         G86ZW2e/gfkzlgb1fmcm5PB/mTRg4f7xIO2cCuKuo5NnByRGuyOxDpz0PrrXoWVSdl1a
         YzdyaGybvsKCGnPXQBQ24Q9gw016bzODPxxJok05rsyrHSrWPMhKz95ZRyF2+6AYgr8p
         T55jjSddmFPQJhk8jCnv090R71sd5Vaj8KqsgPF3qdZzYlmyoZvV4odiq6Y5usMvGFzz
         qpFOZNOvM/zaVnHQzGVhWx+yNfpcZ0CJrMsPO2UesFmCLpSffx4TmnSOLBSLl71v+OyI
         TdxQ==
X-Gm-Message-State: AOAM533ofpKW6Za+hpNOFRTh8Sq93rCW9w1ltkXzO+0Ah4O0/DQtMg2u
        jejTfJxcFtpoA6FojXOLkHET9FXnyfok7JvyuQOpGs8vdkE=
X-Google-Smtp-Source: ABdhPJyqwx7/7Ern/u8AfDOeaGdctpyl3n7V510LJKLg3E6NY/BORruzv1YBZDEOqkF3HbgrRGVMMg07hHLqxCPsRBY=
X-Received: by 2002:a50:ee8a:: with SMTP id f10mr28623696edr.383.1595397473857;
 Tue, 21 Jul 2020 22:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200720160147.22339-1-supreeth.venkatesh@amd.com>
In-Reply-To: <20200720160147.22339-1-supreeth.venkatesh@amd.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Jul 2020 05:57:41 +0000
Message-ID: <CACPK8XfBPb85uXyYiphD9uEUG6a+acAzEMAsfaenT3t0jqUWNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD EthanolX
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

On Mon, 20 Jul 2020 at 16:02, Supreeth Venkatesh
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

Reviewed-by: Joel Stanley <joel@jms.id.au>

Looks good. One question about the licence.


> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: Apache-2.0
> +// Copyright (c) 2020 AMD Inc.

Can you have a read of the licence rules and add a preferred licence.
The rules are here:

 https://www.kernel.org/doc/html/latest/process/license-rules.html

This very hacky one liner will give you an idea of common licences
used by device trees:

$ git grep -h SPDX -- arch/arm/boot/dts/ | cut -c3- |sort -b | uniq -c
| sort -hr
    579  SPDX-License-Identifier: GPL-2.0
    305  SPDX-License-Identifier: GPL-2.0-only
    222  SPDX-License-Identifier: GPL-2.0-or-later
    188  SPDX-License-Identifier: (GPL-2.0+ OR MIT)
     91  SPDX-License-Identifier: GPL-2.0+
     72  SPDX-License-Identifier: (GPL-2.0 OR MIT)
     57  SPDX-License-Identifier: GPL-2.0+ OR MIT
     46  SPDX-License-Identifier: GPL-2.0-or-later OR MIT
     38  SPDX-License-Identifier: GPL-2.0 OR X11
     29  SPDX-License-Identifier: GPL-2.0 OR MIT
     19  SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
     16  SPDX-License-Identifier: GPL-2.0-only */
      6  SPDX-License-Identifier: ISC
      5  SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
      4  SPDX-License-Identifier: (GPL-2.0+ OR X11)
      4  SPDX-License-Identifier: (GPL-2.0 or MIT)
      4  SPDX-License-Identifier: GPL-2.0 */
      3  SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
      2  SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause) */
      2  SPDX-License-Identifier: GPL-2.0-or-later */
      2  SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
      2  SPDX-License-Identifier: (GPL-2.0+)
      2  SPDX-License-Identifier: (GPL-2.0)
      2 SPDX-License-Identifier: GPL-2.0
      1  SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
      1  SPDX-License-Identifier:  GPL-2.0+
      1 SPDX-License-Identifier: GPL-2.0+
      1   SPDX-License-Identifier: BSD-3-Clause


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

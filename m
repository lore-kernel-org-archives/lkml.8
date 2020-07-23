Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F21C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E2620792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBIvfTuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgGWTnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:43:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E5C0619DC;
        Thu, 23 Jul 2020 12:43:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t27so5316355ill.9;
        Thu, 23 Jul 2020 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rV5mpzrT6SkUop/j6ZVNGWPFvsRIOriu4Vn+jaaZHxA=;
        b=GBIvfTucDvieK+fetXZmxsRj0KZcR9ArmWGzZcO9EZueMvC8wxsvmka9p6gKtW9z4H
         btV10is25U5m7QSC41HTbnh3mMR+4RFna+MjjaLtCUEYUDTfUHdZcf0j23zZ+kCTWIEZ
         eDwYZhRN22mazPg9XPngAy1DzkOCsAegOyvfkqX5/nBL9EPlxwiTO6GeVRznYOSc/7go
         zeboxbXKb4U4f9fO+XSZmvsIcxokwwZAQvQj0wePPfnvFknf0s9yX+xev8tIPs/w52bK
         ixp1Ure0IGXFQfPN+tb3zQsumGbQ16cXxg+Vi43vsFUqNR5H5Q93kO7ugdr+1c9sn82F
         zM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rV5mpzrT6SkUop/j6ZVNGWPFvsRIOriu4Vn+jaaZHxA=;
        b=hJwtN4EuxZIxVizVh3SB4PZU+FtmvXSQZ5jfk/z4AORT3nbulZWiIV9yMMUeenRlos
         ENSZGV3Y5bfPWz7cAXkAJdDNbkA8PPu29VeyU41dWkCCqngr9Ej51vS/tR0RZZKp4+xu
         CV4tjJ8CuthqdnB6obS04O7ZP/GLrU1qgSxG7etYj1Q/ef879GLLwvqtU7ZsKAIhE6m8
         cDoy4tctsOQtbtXJ5QdNxXZ65jtfomA8werSP+p+DS7ztMpbN8qFBL+zS0AM9L5EvucA
         i639Su21Av8e7qKEDQVV0NpL77O4xVAhaYUNlU8ftcbt6QjwD/JYdXq24wYopMmXrfHL
         IeaA==
X-Gm-Message-State: AOAM5334k+ZJ+UkemyR9z0bUqXjTWxe7oaOUtRJxSbS4T/k9Yj6jmZyY
        /eA7nl7/XL4u7+ZSdLhUEeyGFaoq0cFPqAr4R6c=
X-Google-Smtp-Source: ABdhPJwPWVch+bmG/OXy4JKpui+6LFhVG72EzrwfFrw+LHNWNIW0wrZCPW8Ce5+lVNVobpADUexyOcgitkhGAOIvfno=
X-Received: by 2002:a92:980d:: with SMTP id l13mr83531ili.217.1595533417376;
 Thu, 23 Jul 2020 12:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200721185317.208722-1-marcin.sloniewski@gmail.com>
 <20200721185317.208722-3-marcin.sloniewski@gmail.com> <1e7dcbbe-638a-9579-e97f-17f986e664f5@pengutronix.de>
In-Reply-To: <1e7dcbbe-638a-9579-e97f-17f986e664f5@pengutronix.de>
From:   =?UTF-8?Q?Marcin_S=C5=82oniewski?= <marcin.sloniewski@gmail.com>
Date:   Thu, 23 Jul 2020 21:43:25 +0200
Message-ID: <CALa5TyxAYpWnekx+a2yz9gk1D0X1VM0OAqW=YKPdzKqqwNxiNg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: stm32: add initial support for
 stm32mp157-odyssey board
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ahmad,

First of all thank you very much for your feedback, it was very helpful!

=C5=9Br., 22 lip 2020 o 08:40 Ahmad Fatoum <a.fatoum@pengutronix.de> napisa=
=C5=82(a):
>
> On 7/21/20 8:53 PM, Marcin Sloniewski wrote:
> > Add support for Seeed Studio's stm32mp157c odyssey board.
> > Board consists of SoM with stm32mp157c with 4GB eMMC and 512 MB DDR3 RA=
M
> > and carrier board with USB and ETH interfaces, SD card connector,
> > wifi and BT chip AP6236.
> >
> > In this patch only basic kernel boot is supported and interfacing
> > SD card and on-board eMMC.
> >
> > Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> > ---
> >
> > Changes in v3:
> > - fix compilation on tip of stm32-next
> >   due to change in names for pinctrl
> > - fix deprecated binding for led node
> > - fix redundant "okay" statuses
> > - add phy part number for eth in comment
>
> You didn't address all my feedback on v2.
I posted today v4 of the patch-set with further changes.
Regarding watchdog from pmic: when using this watchdog
my board resets even though I feed the watchdog. I'm going to
use the internal watchdog for now and keep in mind that this
could be improved in future.

I changed phy address to 7, indeed you were right about it.
But unfortunately even though I set the address correctly phy
is still missing according to dmesg (I checked datasheet and schematics
the address is surely correct now).
That's something I would like to postpone a little bit as well for now.

>
> > Changes in v2:
> > - add new odyssey dts to Makefile
> >
> >  arch/arm/boot/dts/Makefile                    |   3 +-
> >  .../arm/boot/dts/stm32mp157c-odyssey-som.dtsi | 276 ++++++++++++++++++
> >  arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  72 +++++
> >  3 files changed, 350 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> >  create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index e6a1cac0bfc7..a3ea2301c82c 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1047,7 +1047,8 @@ dtb-$(CONFIG_ARCH_STM32) +=3D \
> >       stm32mp157c-dk2.dtb \
> >       stm32mp157c-ed1.dtb \
> >       stm32mp157c-ev1.dtb \
> > -     stm32mp157c-lxa-mc1.dtb
> > +     stm32mp157c-lxa-mc1.dtb \
> > +     stm32mp157c-odyssey.dtb
> >  dtb-$(CONFIG_MACH_SUN4I) +=3D \
> >       sun4i-a10-a1000.dtb \
> >       sun4i-a10-ba10-tvbox.dtb \
> > diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/arm/=
boot/dts/stm32mp157c-odyssey-som.dtsi
> > new file mode 100644
> > index 000000000000..935632caddd6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> > @@ -0,0 +1,276 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > +/*
> > + * Copyright (C) 2020 Marcin Sloniewski <marcin.sloniewski@gmail.com>.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "stm32mp157.dtsi"
> > +#include "stm32mp15xc.dtsi"
> > +#include "stm32mp15-pinctrl.dtsi"
> > +#include "stm32mp15xxac-pinctrl.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/mfd/st,stpmic1.h>
> > +
> > +/ {
> > +     model =3D "Seeed Studio Odyssey-STM32MP157C SOM";
> > +     compatible =3D "seeed,stm32mp157c-odyssey-som", "st,stm32mp157";
> > +
> > +     memory@c0000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0xc0000000 0x20000000>;
> > +     };
> > +
> > +     reserved-memory {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             ranges;
> > +
> > +             mcuram2: mcuram2@10000000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x10000000 0x40000>;
> > +                     no-map;
> > +             };
> > +
> > +             vdev0vring0: vdev0vring0@10040000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x10040000 0x1000>;
> > +                     no-map;
> > +             };
> > +
> > +             vdev0vring1: vdev0vring1@10041000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x10041000 0x1000>;
> > +                     no-map;
> > +             };
> > +
> > +             vdev0buffer: vdev0buffer@10042000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x10042000 0x4000>;
> > +                     no-map;
> > +             };
> > +
> > +             mcuram: mcuram@30000000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x30000000 0x40000>;
> > +                     no-map;
> > +             };
> > +
> > +             retram: retram@38000000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x38000000 0x10000>;
> > +                     no-map;
> > +             };
> > +
> > +             gpu_reserved: gpu@d4000000 {
> > +                     reg =3D <0xd4000000 0x4000000>;
> > +                     no-map;
> > +             };
> > +     };
> > +
> > +     led {
> > +             compatible =3D "gpio-leds";
> > +             led-blue {
> > +                     color =3D <LED_COLOR_ID_BLUE>;
> > +                     function =3D LED_FUNCTION_HEARTBEAT;
> > +                     gpios =3D <&gpiog 3 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger =3D "heartbeat";
> > +             };
> > +     };
> > +};
> > +
> > +&gpu {
> > +     contiguous-area =3D <&gpu_reserved>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c2_pins_a>;
> > +     i2c-scl-rising-time-ns =3D <185>;
> > +     i2c-scl-falling-time-ns =3D <20>;
> > +     status =3D "okay";
> > +     /* spare dmas for other usage */
> > +     /delete-property/dmas;
> > +     /delete-property/dma-names;
> > +
> > +     pmic: stpmic@33 {
> > +             compatible =3D "st,stpmic1";
> > +             reg =3D <0x33>;
> > +             interrupts-extended =3D <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
> > +             interrupt-controller;
> > +             #interrupt-cells =3D <2>;
> > +
> > +             regulators {
> > +                     compatible =3D "st,stpmic1-regulators";
> > +                     ldo1-supply =3D <&v3v3>;
> > +                     ldo3-supply =3D <&vdd_ddr>;
> > +                     ldo6-supply =3D <&v3v3>;
> > +                     pwr_sw1-supply =3D <&bst_out>;
> > +                     pwr_sw2-supply =3D <&bst_out>;
> > +
> > +                     vddcore: buck1 {
> > +                             regulator-name =3D "vddcore";
> > +                             regulator-min-microvolt =3D <800000>;
> > +                             regulator-max-microvolt =3D <1350000>;
> > +                             regulator-always-on;
> > +                             regulator-initial-mode =3D <0>;
> > +                             regulator-over-current-protection;
> > +                     };
> > +
> > +                     vdd_ddr: buck2 {
> > +                             regulator-name =3D "vdd_ddr";
> > +                             regulator-min-microvolt =3D <1350000>;
> > +                             regulator-max-microvolt =3D <1350000>;
> > +                             regulator-always-on;
> > +                             regulator-initial-mode =3D <0>;
> > +                             regulator-over-current-protection;
> > +                     };
> > +
> > +                     vdd: buck3 {
> > +                             regulator-name =3D "vdd";
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-always-on;
> > +                             st,mask-reset;
> > +                             regulator-initial-mode =3D <0>;
> > +                             regulator-over-current-protection;
> > +                     };
> > +
> > +                     v3v3: buck4 {
> > +                             regulator-name =3D "v3v3";
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-always-on;
> > +                             regulator-over-current-protection;
> > +                             regulator-initial-mode =3D <0>;
> > +                     };
> > +
> > +                     v1v8_audio: ldo1 {
> > +                             regulator-name =3D "v1v8_audio";
> > +                             regulator-min-microvolt =3D <1800000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-always-on;
> > +                             interrupts =3D <IT_CURLIM_LDO1 0>;
> > +                     };
> > +
> > +                     v3v3_hdmi: ldo2 {
> > +                             regulator-name =3D "v3v3_hdmi";
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-always-on;
> > +                             interrupts =3D <IT_CURLIM_LDO2 0>;
> > +                     };
> > +
> > +                     vtt_ddr: ldo3 {
> > +                             regulator-name =3D "vtt_ddr";
> > +                             regulator-min-microvolt =3D <500000>;
> > +                             regulator-max-microvolt =3D <750000>;
> > +                             regulator-always-on;
> > +                             regulator-over-current-protection;
> > +                     };
> > +
> > +                     vdd_usb: ldo4 {
> > +                             regulator-name =3D "vdd_usb";
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             interrupts =3D <IT_CURLIM_LDO4 0>;
> > +                     };
> > +
> > +                     vdda: ldo5 {
> > +                             regulator-name =3D "vdda";
> > +                             regulator-min-microvolt =3D <2900000>;
> > +                             regulator-max-microvolt =3D <2900000>;
> > +                             interrupts =3D <IT_CURLIM_LDO5 0>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     v1v2_hdmi: ldo6 {
> > +                             regulator-name =3D "v1v2_hdmi";
> > +                             regulator-min-microvolt =3D <1200000>;
> > +                             regulator-max-microvolt =3D <1200000>;
> > +                             regulator-always-on;
> > +                             interrupts =3D <IT_CURLIM_LDO6 0>;
> > +                     };
> > +
> > +                     vref_ddr: vref_ddr {
> > +                             regulator-name =3D "vref_ddr";
> > +                             regulator-always-on;
> > +                             regulator-over-current-protection;
> > +                     };
> > +
> > +                      bst_out: boost {
> > +                             regulator-name =3D "bst_out";
> > +                             interrupts =3D <IT_OCP_BOOST 0>;
> > +                      };
> > +
> > +                     vbus_otg: pwr_sw1 {
> > +                             regulator-name =3D "vbus_otg";
> > +                             interrupts =3D <IT_OCP_OTG 0>;
> > +                      };
> > +
> > +                      vbus_sw: pwr_sw2 {
> > +                             regulator-name =3D "vbus_sw";
> > +                             interrupts =3D <IT_OCP_SWOUT 0>;
> > +                             regulator-active-discharge;
> > +                      };
> > +             };
> > +
> > +             onkey {
> > +                     compatible =3D "st,stpmic1-onkey";
> > +                     interrupts =3D <IT_PONKEY_F 0>, <IT_PONKEY_R 0>;
> > +                     interrupt-names =3D "onkey-falling", "onkey-risin=
g";
> > +                     power-off-time-sec =3D <10>;
> > +             };
> > +
> > +             watchdog {
> > +                     compatible =3D "st,stpmic1-wdt";
> > +                     status =3D "disabled";
> > +             };
> > +     };
> > +};
> > +
> > +&ipcc {
> > +     status =3D "okay";
> > +};
> > +
> > +&iwdg2 {
> > +     timeout-sec =3D <32>;
> > +     status =3D "okay";
> > +};
> > +
> > +&m4_rproc {
> > +     memory-region =3D <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0=
>,
> > +                     <&vdev0vring1>, <&vdev0buffer>;
> > +     mboxes =3D <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
> > +     mbox-names =3D "vq0", "vq1", "shutdown";
> > +     interrupt-parent =3D <&exti>;
> > +     interrupts =3D <68 1>;
> > +     status =3D "okay";
> > +};
> > +
> > +&rng1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&rtc {
> > +     status =3D "okay";
> > +};
> > +
> > +&sdmmc2 {
> > +     pinctrl-names =3D "default", "opendrain", "sleep";
> > +     pinctrl-0 =3D <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
> > +     pinctrl-1 =3D <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
> > +     pinctrl-2 =3D <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
> > +     non-removable;
> > +     no-sd;
> > +     no-sdio;
> > +     st,neg-edge;
> > +     bus-width =3D <4>;
> > +     vmmc-supply =3D <&v3v3>;
> > +     vqmmc-supply =3D <&v3v3>;
> > +     mmc-ddr-3_3v;
> > +     status =3D "okay";
> > +};
> > +
> > diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/=
dts/stm32mp157c-odyssey.dts
> > new file mode 100644
> > index 000000000000..09edf6afa155
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > +/*
> > + * Copyright (C) 2020 Marcin Sloniewski <marcin.sloniewski@gmail.com>.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "stm32mp157c-odyssey-som.dtsi"
> > +
> > +/ {
> > +     model =3D "Seeed Studio Odyssey-STM32MP157C Board";
> > +     compatible =3D "seeed,stm32mp157c-odyssey", "st,stm32mp157";
> > +
> > +     aliases {
> > +             ethernet0 =3D &ethernet0;
> > +             serial0 =3D &uart4;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +};
> > +
> > +&ethernet0 {
> > +     status =3D "okay";
> > +     pinctrl-0 =3D <&ethernet0_rgmii_pins_a>;
> > +     pinctrl-1 =3D <&ethernet0_rgmii_sleep_pins_a>;
> > +     pinctrl-names =3D "default", "sleep";
> > +     phy-mode =3D "rgmii-id";
> > +     max-speed =3D <1000>;
> > +     phy-handle =3D <&phy0>;
> > +
> > +     mdio0 {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             compatible =3D "snps,dwmac-mdio";
> > +             phy0: ethernet-phy@0 { /* KSZ9031RN */
> > +                     reg =3D <0>;
> > +             };
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     pinctrl-names =3D "default", "sleep";
> > +     pinctrl-0 =3D <&i2c1_pins_a>;
> > +     pinctrl-1 =3D <&i2c1_sleep_pins_a>;
> > +     i2c-scl-rising-time-ns =3D <100>;
> > +     i2c-scl-falling-time-ns =3D <7>;
> > +     status =3D "okay";
> > +     /delete-property/dmas;
> > +     /delete-property/dma-names;
> > +};
> > +
> > +&sdmmc1 {
> > +     pinctrl-names =3D "default", "opendrain", "sleep";
> > +     pinctrl-0 =3D <&sdmmc1_b4_pins_a>;
> > +     pinctrl-1 =3D <&sdmmc1_b4_od_pins_a>;
> > +     pinctrl-2 =3D <&sdmmc1_b4_sleep_pins_a>;
> > +     cd-gpios =3D <&gpiob 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> > +     disable-wp;
> > +     st,neg-edge;
> > +     bus-width =3D <4>;
> > +     vmmc-supply =3D <&v3v3>;
> > +     status =3D "okay";
> > +};
> > +
> > +&uart4 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&uart4_pins_a>;
> > +     status =3D "okay";
> > +};
> > +
> >
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

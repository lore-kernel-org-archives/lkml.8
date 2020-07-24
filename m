Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC38C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887FC20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVwQEvQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGXOJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:09:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486E1C0619D3;
        Fri, 24 Jul 2020 07:09:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t4so7305291iln.1;
        Fri, 24 Jul 2020 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gCOVbB6rsgEx+5gxbz+cVQZVvkxM51wtmAcUHeU+HqE=;
        b=BVwQEvQeds/pEfGyXxWedTYivU9umR5VzCcec9aaUtji9yVs74r7sPatJlcoeohcJv
         RHVdKydwd38q1hI9NUDclLGJ0NLaM/7UXk0z99kO0eQ4nZ075/u9lZ8cMFbzas3PZFln
         cTpoi1zN0TmZY96Pp4vNRTuHuYZyQT1xCErwm3jxTd4UJuumtcYP5BMdH0vRmcmhu2Bb
         yPuwm2/U3P1q89CGai97DXbxZWvZwL93M+ICkmmIuN5ViiX/7dI02UPMNBnCWCy6c5Af
         hhEzUYyxU5Bm+9sfm0vW9BPzaud4i6Ud4jCJVScWe+hCol7xLdTfN3Ts/wtZuvEM5Okc
         hhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gCOVbB6rsgEx+5gxbz+cVQZVvkxM51wtmAcUHeU+HqE=;
        b=YxiyVf+eFKqSbi1Jajkh/eybSwDkWoUXeL5XKMa/nzHT2scyUKTKG6sxhC7r3l0JaI
         cT3RknbZ1FR7ZU6+xA+/anLkipSzAwZNOzx1xGi2xs2uHUxG37bPSHHp3xOhSwI0T5MN
         ZU+Z3C8Fnpv2aH0g+YRlVGBXMHBFGD8GPok9ZVeDUGrZGklF4JqUpkl4GlhG/4aU7kHz
         EfIXxFo5bJL9uoxSOYz53V/J72dSMb/3Z8vS6uPdI9Ofouzt+a3NPGEZ5hGcqLp5S7r9
         H0TUQRN/N9SmWdYTbrWSMq4FXgIhqtfB8htkGw5ylc14OHpStncyd65aEHB0qfHxFUNG
         3tzw==
X-Gm-Message-State: AOAM530es+rP+jftjJm3dVZYYP6EAfLBJA/2ozqufkpjel9/a+2o9hiQ
        EUgEb8rW7L/w4WLbR8YN48qsoxdd/T4LGsifUlg=
X-Google-Smtp-Source: ABdhPJzFJBQaseStL6mrmbqEdcsfgF+ed2YOlnzUKzoyyo3YuFPm5V65BpbPHh2W9w8uaw0yLT6nE5No87u/XH58TDI=
X-Received: by 2002:a92:980d:: with SMTP id l13mr3796409ili.217.1595599796388;
 Fri, 24 Jul 2020 07:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200721185317.208722-1-marcin.sloniewski@gmail.com>
 <20200721185317.208722-3-marcin.sloniewski@gmail.com> <1e7dcbbe-638a-9579-e97f-17f986e664f5@pengutronix.de>
 <CALa5TyxAYpWnekx+a2yz9gk1D0X1VM0OAqW=YKPdzKqqwNxiNg@mail.gmail.com> <d1ba2e21-d410-5973-b082-e1ef43ca67bd@pengutronix.de>
In-Reply-To: <d1ba2e21-d410-5973-b082-e1ef43ca67bd@pengutronix.de>
From:   =?UTF-8?Q?Marcin_S=C5=82oniewski?= <marcin.sloniewski@gmail.com>
Date:   Fri, 24 Jul 2020 16:09:38 +0200
Message-ID: <CALa5TyzAf7sw9TzO6BCN6KQDm+Y726zRw5AL4iFb6QEDnk4e8w@mail.gmail.com>
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

Hi,

pt., 24 lip 2020 o 11:17 Ahmad Fatoum <a.fatoum@pengutronix.de> napisa=C5=
=82(a):
>
> Hi,
>
> On 7/23/20 9:43 PM, Marcin S=C5=82oniewski wrote:
> > Hello Ahmad,
> >
> > First of all thank you very much for your feedback, it was very helpful=
!
> >
> > =C5=9Br., 22 lip 2020 o 08:40 Ahmad Fatoum <a.fatoum@pengutronix.de> na=
pisa=C5=82(a):
> >>
> >> On 7/21/20 8:53 PM, Marcin Sloniewski wrote:
> >>> Add support for Seeed Studio's stm32mp157c odyssey board.
> >>> Board consists of SoM with stm32mp157c with 4GB eMMC and 512 MB DDR3 =
RAM
> >>> and carrier board with USB and ETH interfaces, SD card connector,
> >>> wifi and BT chip AP6236.
> >>>
> >>> In this patch only basic kernel boot is supported and interfacing
> >>> SD card and on-board eMMC.
> >>>
> >>> Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> >>> ---
> >>>
> >>> Changes in v3:
> >>> - fix compilation on tip of stm32-next
> >>>   due to change in names for pinctrl
> >>> - fix deprecated binding for led node
> >>> - fix redundant "okay" statuses
> >>> - add phy part number for eth in comment
> >>
> >> You didn't address all my feedback on v2.
> > I posted today v4 of the patch-set with further changes.
> > Regarding watchdog from pmic: when using this watchdog
> > my board resets even though I feed the watchdog. I'm going to
> > use the internal watchdog for now and keep in mind that this
> > could be improved in future.
>
> Who turns on the watchdog? If it's in the bootloader,
> you can't rely on CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED feeding it till
> userspace takes over because the stpmic1_wdt doesn't populate
> WDOG_HW_RUNNING in status.
It's not turned on in bootloader (u-boot). I'm able to boot to userspace, b=
ut
the watchdog reboots board when using busybox's watchdog demon and when
I'm manually feeding it. Every other stm32mp1 based board isn't using
pmic watchdog,
so I guess it can be replaced by internal watchdog for now?
>
> > I changed phy address to 7, indeed you were right about it.
> > But unfortunately even though I set the address correctly phy
> > is still missing according to dmesg (I checked datasheet and schematics
> > the address is surely correct now).
> > That's something I would like to postpone a little bit as well for now.
>
> You sent out v4 with a phy address of 7 though.
> Did you get it working meanwhile?
Unfortunately not yet.
>
> >
> >>
> >>> Changes in v2:
> >>> - add new odyssey dts to Makefile
> >>>
> >>>  arch/arm/boot/dts/Makefile                    |   3 +-
> >>>  .../arm/boot/dts/stm32mp157c-odyssey-som.dtsi | 276 ++++++++++++++++=
++
> >>>  arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  72 +++++
> >>>  3 files changed, 350 insertions(+), 1 deletion(-)
> >>>  create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> >>>  create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey.dts
> >>>
> >>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >>> index e6a1cac0bfc7..a3ea2301c82c 100644
> >>> --- a/arch/arm/boot/dts/Makefile
> >>> +++ b/arch/arm/boot/dts/Makefile
> >>> @@ -1047,7 +1047,8 @@ dtb-$(CONFIG_ARCH_STM32) +=3D \
> >>>       stm32mp157c-dk2.dtb \
> >>>       stm32mp157c-ed1.dtb \
> >>>       stm32mp157c-ev1.dtb \
> >>> -     stm32mp157c-lxa-mc1.dtb
> >>> +     stm32mp157c-lxa-mc1.dtb \
> >>> +     stm32mp157c-odyssey.dtb
> >>>  dtb-$(CONFIG_MACH_SUN4I) +=3D \
> >>>       sun4i-a10-a1000.dtb \
> >>>       sun4i-a10-ba10-tvbox.dtb \
> >>> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/ar=
m/boot/dts/stm32mp157c-odyssey-som.dtsi
> >>> new file mode 100644
> >>> index 000000000000..935632caddd6
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> >>> @@ -0,0 +1,276 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >>> +/*
> >>> + * Copyright (C) 2020 Marcin Sloniewski <marcin.sloniewski@gmail.com=
>.
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +
> >>> +#include "stm32mp157.dtsi"
> >>> +#include "stm32mp15xc.dtsi"
> >>> +#include "stm32mp15-pinctrl.dtsi"
> >>> +#include "stm32mp15xxac-pinctrl.dtsi"
> >>> +#include <dt-bindings/gpio/gpio.h>
> >>> +#include <dt-bindings/leds/common.h>
> >>> +#include <dt-bindings/mfd/st,stpmic1.h>
> >>> +
> >>> +/ {
> >>> +     model =3D "Seeed Studio Odyssey-STM32MP157C SOM";
> >>> +     compatible =3D "seeed,stm32mp157c-odyssey-som", "st,stm32mp157"=
;
> >>> +
> >>> +     memory@c0000000 {
> >>> +             device_type =3D "memory";
> >>> +             reg =3D <0xc0000000 0x20000000>;
> >>> +     };
> >>> +
> >>> +     reserved-memory {
> >>> +             #address-cells =3D <1>;
> >>> +             #size-cells =3D <1>;
> >>> +             ranges;
> >>> +
> >>> +             mcuram2: mcuram2@10000000 {
> >>> +                     compatible =3D "shared-dma-pool";
> >>> +                     reg =3D <0x10000000 0x40000>;
> >>> +                     no-map;
> >>> +             };
> >>> +
> >>> +             vdev0vring0: vdev0vring0@10040000 {
> >>> +                     compatible =3D "shared-dma-pool";
> >>> +                     reg =3D <0x10040000 0x1000>;
> >>> +                     no-map;
> >>> +             };
> >>> +
> >>> +             vdev0vring1: vdev0vring1@10041000 {
> >>> +                     compatible =3D "shared-dma-pool";
> >>> +                     reg =3D <0x10041000 0x1000>;
> >>> +                     no-map;
> >>> +             };
> >>> +
> >>> +             vdev0buffer: vdev0buffer@10042000 {
> >>> +                     compatible =3D "shared-dma-pool";
> >>> +                     reg =3D <0x10042000 0x4000>;
> >>> +                     no-map;
> >>> +             };
> >>> +
> >>> +             mcuram: mcuram@30000000 {
> >>> +                     compatible =3D "shared-dma-pool";
> >>> +                     reg =3D <0x30000000 0x40000>;
> >>> +                     no-map;
> >>> +             };
> >>> +
> >>> +             retram: retram@38000000 {
> >>> +                     compatible =3D "shared-dma-pool";
> >>> +                     reg =3D <0x38000000 0x10000>;
> >>> +                     no-map;
> >>> +             };
> >>> +
> >>> +             gpu_reserved: gpu@d4000000 {
> >>> +                     reg =3D <0xd4000000 0x4000000>;
> >>> +                     no-map;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     led {
> >>> +             compatible =3D "gpio-leds";
> >>> +             led-blue {
> >>> +                     color =3D <LED_COLOR_ID_BLUE>;
> >>> +                     function =3D LED_FUNCTION_HEARTBEAT;
> >>> +                     gpios =3D <&gpiog 3 GPIO_ACTIVE_HIGH>;
> >>> +                     linux,default-trigger =3D "heartbeat";
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&gpu {
> >>> +     contiguous-area =3D <&gpu_reserved>;
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&i2c2 {
> >>> +     pinctrl-names =3D "default";
> >>> +     pinctrl-0 =3D <&i2c2_pins_a>;
> >>> +     i2c-scl-rising-time-ns =3D <185>;
> >>> +     i2c-scl-falling-time-ns =3D <20>;
> >>> +     status =3D "okay";
> >>> +     /* spare dmas for other usage */
> >>> +     /delete-property/dmas;
> >>> +     /delete-property/dma-names;
> >>> +
> >>> +     pmic: stpmic@33 {
> >>> +             compatible =3D "st,stpmic1";
> >>> +             reg =3D <0x33>;
> >>> +             interrupts-extended =3D <&gpioa 0 IRQ_TYPE_EDGE_FALLING=
>;
> >>> +             interrupt-controller;
> >>> +             #interrupt-cells =3D <2>;
> >>> +
> >>> +             regulators {
> >>> +                     compatible =3D "st,stpmic1-regulators";
> >>> +                     ldo1-supply =3D <&v3v3>;
> >>> +                     ldo3-supply =3D <&vdd_ddr>;
> >>> +                     ldo6-supply =3D <&v3v3>;
> >>> +                     pwr_sw1-supply =3D <&bst_out>;
> >>> +                     pwr_sw2-supply =3D <&bst_out>;
> >>> +
> >>> +                     vddcore: buck1 {
> >>> +                             regulator-name =3D "vddcore";
> >>> +                             regulator-min-microvolt =3D <800000>;
> >>> +                             regulator-max-microvolt =3D <1350000>;
> >>> +                             regulator-always-on;
> >>> +                             regulator-initial-mode =3D <0>;
> >>> +                             regulator-over-current-protection;
> >>> +                     };
> >>> +
> >>> +                     vdd_ddr: buck2 {
> >>> +                             regulator-name =3D "vdd_ddr";
> >>> +                             regulator-min-microvolt =3D <1350000>;
> >>> +                             regulator-max-microvolt =3D <1350000>;
> >>> +                             regulator-always-on;
> >>> +                             regulator-initial-mode =3D <0>;
> >>> +                             regulator-over-current-protection;
> >>> +                     };
> >>> +
> >>> +                     vdd: buck3 {
> >>> +                             regulator-name =3D "vdd";
> >>> +                             regulator-min-microvolt =3D <3300000>;
> >>> +                             regulator-max-microvolt =3D <3300000>;
> >>> +                             regulator-always-on;
> >>> +                             st,mask-reset;
> >>> +                             regulator-initial-mode =3D <0>;
> >>> +                             regulator-over-current-protection;
> >>> +                     };
> >>> +
> >>> +                     v3v3: buck4 {
> >>> +                             regulator-name =3D "v3v3";
> >>> +                             regulator-min-microvolt =3D <3300000>;
> >>> +                             regulator-max-microvolt =3D <3300000>;
> >>> +                             regulator-always-on;
> >>> +                             regulator-over-current-protection;
> >>> +                             regulator-initial-mode =3D <0>;
> >>> +                     };
> >>> +
> >>> +                     v1v8_audio: ldo1 {
> >>> +                             regulator-name =3D "v1v8_audio";
> >>> +                             regulator-min-microvolt =3D <1800000>;
> >>> +                             regulator-max-microvolt =3D <1800000>;
> >>> +                             regulator-always-on;
> >>> +                             interrupts =3D <IT_CURLIM_LDO1 0>;
> >>> +                     };
> >>> +
> >>> +                     v3v3_hdmi: ldo2 {
> >>> +                             regulator-name =3D "v3v3_hdmi";
> >>> +                             regulator-min-microvolt =3D <3300000>;
> >>> +                             regulator-max-microvolt =3D <3300000>;
> >>> +                             regulator-always-on;
> >>> +                             interrupts =3D <IT_CURLIM_LDO2 0>;
> >>> +                     };
> >>> +
> >>> +                     vtt_ddr: ldo3 {
> >>> +                             regulator-name =3D "vtt_ddr";
> >>> +                             regulator-min-microvolt =3D <500000>;
> >>> +                             regulator-max-microvolt =3D <750000>;
> >>> +                             regulator-always-on;
> >>> +                             regulator-over-current-protection;
> >>> +                     };
> >>> +
> >>> +                     vdd_usb: ldo4 {
> >>> +                             regulator-name =3D "vdd_usb";
> >>> +                             regulator-min-microvolt =3D <3300000>;
> >>> +                             regulator-max-microvolt =3D <3300000>;
> >>> +                             interrupts =3D <IT_CURLIM_LDO4 0>;
> >>> +                     };
> >>> +
> >>> +                     vdda: ldo5 {
> >>> +                             regulator-name =3D "vdda";
> >>> +                             regulator-min-microvolt =3D <2900000>;
> >>> +                             regulator-max-microvolt =3D <2900000>;
> >>> +                             interrupts =3D <IT_CURLIM_LDO5 0>;
> >>> +                             regulator-boot-on;
> >>> +                     };
> >>> +
> >>> +                     v1v2_hdmi: ldo6 {
> >>> +                             regulator-name =3D "v1v2_hdmi";
> >>> +                             regulator-min-microvolt =3D <1200000>;
> >>> +                             regulator-max-microvolt =3D <1200000>;
> >>> +                             regulator-always-on;
> >>> +                             interrupts =3D <IT_CURLIM_LDO6 0>;
> >>> +                     };
> >>> +
> >>> +                     vref_ddr: vref_ddr {
> >>> +                             regulator-name =3D "vref_ddr";
> >>> +                             regulator-always-on;
> >>> +                             regulator-over-current-protection;
> >>> +                     };
> >>> +
> >>> +                      bst_out: boost {
> >>> +                             regulator-name =3D "bst_out";
> >>> +                             interrupts =3D <IT_OCP_BOOST 0>;
> >>> +                      };
> >>> +
> >>> +                     vbus_otg: pwr_sw1 {
> >>> +                             regulator-name =3D "vbus_otg";
> >>> +                             interrupts =3D <IT_OCP_OTG 0>;
> >>> +                      };
> >>> +
> >>> +                      vbus_sw: pwr_sw2 {
> >>> +                             regulator-name =3D "vbus_sw";
> >>> +                             interrupts =3D <IT_OCP_SWOUT 0>;
> >>> +                             regulator-active-discharge;
> >>> +                      };
> >>> +             };
> >>> +
> >>> +             onkey {
> >>> +                     compatible =3D "st,stpmic1-onkey";
> >>> +                     interrupts =3D <IT_PONKEY_F 0>, <IT_PONKEY_R 0>=
;
> >>> +                     interrupt-names =3D "onkey-falling", "onkey-ris=
ing";
> >>> +                     power-off-time-sec =3D <10>;
> >>> +             };
> >>> +
> >>> +             watchdog {
> >>> +                     compatible =3D "st,stpmic1-wdt";
> >>> +                     status =3D "disabled";
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&ipcc {
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&iwdg2 {
> >>> +     timeout-sec =3D <32>;
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&m4_rproc {
> >>> +     memory-region =3D <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vrin=
g0>,
> >>> +                     <&vdev0vring1>, <&vdev0buffer>;
> >>> +     mboxes =3D <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
> >>> +     mbox-names =3D "vq0", "vq1", "shutdown";
> >>> +     interrupt-parent =3D <&exti>;
> >>> +     interrupts =3D <68 1>;
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&rng1 {
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&rtc {
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&sdmmc2 {
> >>> +     pinctrl-names =3D "default", "opendrain", "sleep";
> >>> +     pinctrl-0 =3D <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
> >>> +     pinctrl-1 =3D <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
> >>> +     pinctrl-2 =3D <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a=
>;
> >>> +     non-removable;
> >>> +     no-sd;
> >>> +     no-sdio;
> >>> +     st,neg-edge;
> >>> +     bus-width =3D <4>;
> >>> +     vmmc-supply =3D <&v3v3>;
> >>> +     vqmmc-supply =3D <&v3v3>;
> >>> +     mmc-ddr-3_3v;
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boo=
t/dts/stm32mp157c-odyssey.dts
> >>> new file mode 100644
> >>> index 000000000000..09edf6afa155
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> >>> @@ -0,0 +1,72 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >>> +/*
> >>> + * Copyright (C) 2020 Marcin Sloniewski <marcin.sloniewski@gmail.com=
>.
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +
> >>> +#include "stm32mp157c-odyssey-som.dtsi"
> >>> +
> >>> +/ {
> >>> +     model =3D "Seeed Studio Odyssey-STM32MP157C Board";
> >>> +     compatible =3D "seeed,stm32mp157c-odyssey", "st,stm32mp157";
> >>> +
> >>> +     aliases {
> >>> +             ethernet0 =3D &ethernet0;
> >>> +             serial0 =3D &uart4;
> >>> +     };
> >>> +
> >>> +     chosen {
> >>> +             stdout-path =3D "serial0:115200n8";
> >>> +     };
> >>> +};
> >>> +
> >>> +&ethernet0 {
> >>> +     status =3D "okay";
> >>> +     pinctrl-0 =3D <&ethernet0_rgmii_pins_a>;
> >>> +     pinctrl-1 =3D <&ethernet0_rgmii_sleep_pins_a>;
> >>> +     pinctrl-names =3D "default", "sleep";
> >>> +     phy-mode =3D "rgmii-id";
> >>> +     max-speed =3D <1000>;
> >>> +     phy-handle =3D <&phy0>;
> >>> +
> >>> +     mdio0 {
> >>> +             #address-cells =3D <1>;
> >>> +             #size-cells =3D <0>;
> >>> +             compatible =3D "snps,dwmac-mdio";
> >>> +             phy0: ethernet-phy@0 { /* KSZ9031RN */
> >>> +                     reg =3D <0>;
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&i2c1 {
> >>> +     pinctrl-names =3D "default", "sleep";
> >>> +     pinctrl-0 =3D <&i2c1_pins_a>;
> >>> +     pinctrl-1 =3D <&i2c1_sleep_pins_a>;
> >>> +     i2c-scl-rising-time-ns =3D <100>;
> >>> +     i2c-scl-falling-time-ns =3D <7>;
> >>> +     status =3D "okay";
> >>> +     /delete-property/dmas;
> >>> +     /delete-property/dma-names;
> >>> +};
> >>> +
> >>> +&sdmmc1 {
> >>> +     pinctrl-names =3D "default", "opendrain", "sleep";
> >>> +     pinctrl-0 =3D <&sdmmc1_b4_pins_a>;
> >>> +     pinctrl-1 =3D <&sdmmc1_b4_od_pins_a>;
> >>> +     pinctrl-2 =3D <&sdmmc1_b4_sleep_pins_a>;
> >>> +     cd-gpios =3D <&gpiob 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> >>> +     disable-wp;
> >>> +     st,neg-edge;
> >>> +     bus-width =3D <4>;
> >>> +     vmmc-supply =3D <&v3v3>;
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&uart4 {
> >>> +     pinctrl-names =3D "default";
> >>> +     pinctrl-0 =3D <&uart4_pins_a>;
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>>
> >>
> >> --
> >> Pengutronix e.K.                           |                          =
   |
> >> Steuerwalder Str. 21                       | http://www.pengutronix.de=
/  |
> >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0 =
   |
> >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-55=
55 |
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

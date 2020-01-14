Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F77C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44D22467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WrtEb6ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgANPeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:34:04 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34024 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgANPeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:34:04 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so14271345iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNT9MtZOXnBbt3j83P/1FfWRua0ExXT3bXy6Tpb0oDk=;
        b=WrtEb6ysYoIM2/88wA0hpUCCSEU3QCSTtNayYjL3paam26GeXUEv+u7vTshsJ8N3/c
         iE11t1Zh1PjlOPfBtWoYxAPMhYZ00B2PHf4jAzysv8zCDQ9u9s1I4WvAbvdQYvLK9GpU
         nErk/hm0h2tBYTSXNq0d7yd7GtMQ7BLMOB2zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNT9MtZOXnBbt3j83P/1FfWRua0ExXT3bXy6Tpb0oDk=;
        b=QlMl2PPwYI80sybfd599WOvkbpXOX0A+bmasyAHK6ZDmMP1gSvldVoG03c81ZkzfxE
         BsYjdEOiPtUT00wqvBaBqadRhUNjTGnQLWss/Xv2y0aUi4mJB31FCKLaIYDu44G1LxWC
         c46/YRT1n3OGh3gGfan9/5jsIkKwHVNFFDMPA4vxviiXaLUtyLAkqOxFtufxrq8vC6bp
         /FRS+/zkRn0lDs+8aQqv11/RiZAYPQoFu8i9AL5GYNj7DMEkRNRSalqhsYQDQRuVaTOt
         EyPuWm77rMHNnOZ52b6MJnzWRPuEMCUHu0IIDgPEInNuwxeDhm84ykW15IzsYFY2NVUR
         X33Q==
X-Gm-Message-State: APjAAAXrB34GOcO8wApZpFrhnbVOb2QLr5NoEx1JLTrqv/97C0RlbIGn
        zgA7kwJv2XhjiJrHsc4Qu/fHFrYToZmCr2km0ugxGg==
X-Google-Smtp-Source: APXvYqy0qrAMKOLKyekUK+80K+1tmlcurBS6N0vd2S3t+a/Hh1FIQYO9i94i/oxkGmMSocWjJwgAFRnYcy/5aWbZVko=
X-Received: by 2002:a02:b78a:: with SMTP id f10mr18813823jam.114.1579016042886;
 Tue, 14 Jan 2020 07:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20200110073730.213789-1-hsinyi@chromium.org> <20200110073730.213789-3-hsinyi@chromium.org>
 <7d137ab6-d57b-8471-bb6a-37556e5e2a01@gmail.com> <CAJMQK-j1CfXKDCpyycp5F7pbuESGgbzb=8h-adGrjw1oZcCBnw@mail.gmail.com>
 <a7dd5632-e58b-ecf0-b48f-78b72d6f2fb3@gmail.com>
In-Reply-To: <a7dd5632-e58b-ecf0-b48f-78b72d6f2fb3@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 14 Jan 2020 23:33:36 +0800
Message-ID: <CAJMQK-geKkDJF0QtScf+=gLnpYhyLDQHvSM-aYkxsczZvJVsVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add mt8173 elm and hana board
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:10 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 13/01/2020 19:01, Hsin-Yi Wang wrote:
> > On Fri, Jan 10, 2020 at 9:42 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >>
> >>
> > Thanks, I will address the comments and send next version
> >>
> >> On 10/01/2020 08:37, Hsin-Yi Wang wrote:
> >>> Elm is Acer Chromebook R13. Hana is Lenovo Chromebook. Both uses mt8173
> >>> SoC.
> >>>
> >>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >>> ---
> >>> Changes in v2:
> >>> - remove downstream nodes and unused nodes
> >>> - use GPIO_ACTIVE_LOW for ps8640 gpios
> >>> - move trackpad to hana
> >>> ---
> >>>  arch/arm64/boot/dts/mediatek/Makefile         |    3 +
> >>>  .../dts/mediatek/mt8173-elm-hana-rev7.dts     |   27 +
> >>>  .../boot/dts/mediatek/mt8173-elm-hana.dts     |   16 +
> >>>  .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   60 +
> >>>  arch/arm64/boot/dts/mediatek/mt8173-elm.dts   |   15 +
> >>>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 1040 +++++++++++++++++
> >>>  6 files changed, 1161 insertions(+)
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dts
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> >>> index 458bbc422a94..b45a45a565a1 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >>> @@ -6,5 +6,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
> >>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> >>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
> >>> new file mode 100644
> >>> index 000000000000..a3616bc3d859
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
> >>> @@ -0,0 +1,27 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright 2019 MediaTek Inc.
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +#include "mt8173-elm-hana.dtsi"
> >>> +
> >>> +/ {
> >>> +     model = "Mediatek Hana rev7 board";
> >>> +     compatible = "google,hana-rev7", "mediatek,mt8173";
> >>> +};
> >>> +
> >>> +&cpu_thermal {
> >>> +     trips {
> >>> +             cpu_crit: cpu_crit@0 {
> >>> +                     temperature = <100000>;
> >>> +                     type = "critical";
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&gpio_keys {
> >>> +     /delete-node/tablet_mode;
> >>> +     /delete-node/volume_down;
> >>> +     /delete-node/volume_up;
> >>> +};
> >>> \ No newline at end of file
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
> >>> new file mode 100644
> >>> index 000000000000..8cbcc75192e3
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
> >>> @@ -0,0 +1,16 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright 2016 MediaTek Inc.
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +#include "mt8173-elm-hana.dtsi"
> >>> +
> >>> +/ {
> >>> +     model = "Mediatek Hana rev0 board";
>
> If we can't make this more verbose, at least delete rev0, that's confusing.
> Should the name not be "Google Hana"?
>
Sure, Google Hana makes sense.
> >>> +     compatible = "google,hana-rev6",
> >>> +                     "google,hana-rev5", "google,hana-rev4",
> >>> +                     "google,hana-rev3", "google,hana-rev2",
> >>> +                     "google,hana-rev1", "google,hana-rev0",
> >>> +                     "google,hana", "mediatek,mt8173";
> >>> +};
> >>
> >> I'm a bit confused about all this versions. Do you want to keep them for
> >> internal use, as I suppose only rev6 is available to the general public,
> >> correct? I'm fine with keeping the old revisions if that's of use for you,
> >> otherwise I'd prefer to delete them.
> > According to internal feedback system, at least rev3, rev6, rev7 are
> > in general public. I can delete rev0~rev2, since they are earlier
> > version device.
>
> If you don't plan to use the rev0 to rev2 in-house, then we can delete them.
>
> >>
> >> Model name could be more verbose.
> >>
> >>> \ No newline at end of file
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> >>> new file mode 100644
> >>> index 000000000000..35e12b290947
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> >>> @@ -0,0 +1,60 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright 2016 MediaTek Inc.
> >>> + */
> >>> +
> >>> +#include "mt8173-elm.dtsi"
> >>> +
> >>> +&i2c0 {
> >>> +     clock-frequency = <200000>;
> >>> +};
> >>> +
> >>> +&i2c3 {
> >>> +     touchscreen2: touchscreen@34 {
> >>> +             compatible = "melfas,mip4_ts";
> >>> +             reg = <0x34>;
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <88 IRQ_TYPE_LEVEL_LOW>;
> >>> +     };
> >>> +
> >>> +     touchscreen3: touchscreen@20 {
> >>> +             compatible = "hid-over-i2c";
> >>> +             reg = <0x20>;
> >>> +             hid-descr-addr = <0x0020>;
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <88 IRQ_TYPE_LEVEL_LOW>;
> >>> +     };
> >>
> >> In v1 you mentioned:
> >> "Partners wants to increase touchpad and touchscreen source (they choose
> >> synaptics) for hana 300e, and synaptics uses hid-over-i2c driver."
> >>
> >> So the partner uses the same compatible (google,hana-rev6?) for both devices?
> >>
> > Confirmed with others, second source devices share same compatible.
>
> We should create independent dts for the different boards. Like it is done for
> gru-scarlett. Doesn't the FW provide the sku number in the compatible string?
>
Since I don't have a second source device to verify, I checked with
SIE, and he said the sku number(board id) are same for device using
original trackpad and second source trackpad in hana's case. So I
don't think we can split them to independent dts.
> >>> +};
> >>> +
> >>> +&i2c4 {
> >>> +     trackpad2: trackpad@2c {
> >>> +             compatible = "hid-over-i2c";
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <117 IRQ_TYPE_LEVEL_LOW>;
> >>> +             reg = <0x2c>;
> >>> +             hid-descr-addr = <0x0020>;
> >>> +             wakeup-source;
> >>> +     };
> >>> +};
> >>> +
> >>> +&mmc1 {
> >>> +     wp-gpios = <&pio 42 GPIO_ACTIVE_HIGH>;
> >>> +};
> >>> +
> >>> +&pio {
> >>> +     hdmi_mux_pins: hdmi_mux_pins {
> >>> +             pins2 {
> >>> +                     pinmux = <MT8173_PIN_98_URTS1__FUNC_GPIO98>;
> >>> +                     bias-pull-up;
> >>> +                     output-high;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     mmc1_pins_default: mmc1default {
> >>> +             pins_wp {
> >>> +                     pinmux = <MT8173_PIN_42_DSI_TE__FUNC_GPIO42>;
> >>> +                     input-enable;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +};
> >>> \ No newline at end of file
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm.dts
> >>> new file mode 100644
> >>> index 000000000000..e5da2355760e
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dts
> >>> @@ -0,0 +1,15 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright 2016 MediaTek Inc.
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +#include "mt8173-elm.dtsi"
> >>> +
> >>> +/ {
> >>> +     model = "Mediatek Elm board";
> >>> +     compatible = "google,elm-rev8", "google,elm-rev7", "google,elm-rev6",
> >>> +                     "google,elm-rev5", "google,elm-rev4", "google,elm-rev3",
> >>> +                     "google,elm-rev2", "google,elm-rev1",
> >>> +                     "google,elm", "mediatek,mt8173";
> >>> +};
> >>> \ No newline at end of file
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>> new file mode 100644
> >>> index 000000000000..2ac738bebe04
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>> @@ -0,0 +1,1040 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright 2016 MediaTek Inc.
> >>> + */
> >>> +
> >>> +#include <dt-bindings/input/input.h>
> >>> +#include <dt-bindings/gpio/gpio.h>
> >>> +#include "mt8173.dtsi"
> >>> +
> >>> +/ {
> >>> +     aliases {
> >>> +             serial0 = &uart0;
> >>> +             serial1 = &uart1;
> >>> +             serial2 = &uart2;
> >>> +             serial3 = &uart3;
> >>> +     };
> >>> +
> >>> +     memory@40000000 {
> >>> +             device_type = "memory";
> >>> +             reg = <0 0x40000000 0 0x80000000>;
> >>> +     };
> >>> +
> >>> +     backlight_lcd: backlight_lcd {
> >>> +             compatible = "pwm-backlight";
> >>> +             pwms = <&pwm0 0 1000000>;
> >>> +             brightness-levels = <
> >>> +                       0  16  32  48  64  80  96 112
> >>> +                     128 144 160 176 192 208 224 240
> >>> +                     255
> >>> +             >;
> >>> +             default-brightness-level = <9>;
> >>> +             power-supply = <&bl_fixed_reg>;
> >>> +             enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
> >>> +
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&disp_pwm0_pins>;
> >>> +             status = "okay";
> >>> +     };
> >>> +
> >>> +     bl_fixed_reg: fixedregulator@2 {
> >>> +             compatible = "regulator-fixed";
> >>> +             regulator-name = "bl_fixed";
> >>> +             regulator-min-microvolt = <1800000>;
> >>> +             regulator-max-microvolt = <1800000>;
> >>> +             startup-delay-us = <1000>;
> >>> +             enable-active-high;
> >>> +             gpio = <&pio 32 GPIO_ACTIVE_HIGH>;
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&bl_fixed_pins>;
> >>> +     };
> >>> +
> >>> +     chosen {
> >>> +             stdout-path = &uart0;
> >>> +     };
> >>> +
> >>> +     gpio_keys: gpio-keys {
> >>> +             compatible = "gpio-keys";
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&gpio_keys_pins>;
> >>> +
> >>> +             lid {
> >>> +                     label = "Lid";
> >>> +                     gpios = <&pio 69 GPIO_ACTIVE_LOW>;
> >>> +                     linux,code = <0>; /* SW_LID */
> >>> +                     linux,input-type = <5>; /* EV_SW */
> >>> +                     gpio-key,wakeup;
> >>> +             };
> >>> +
> >>> +             power {
> >>> +                     label = "Power";
> >>> +                     gpios = <&pio 14 GPIO_ACTIVE_HIGH>;
> >>> +                     linux,code = <KEY_POWER>;
> >>> +                     debounce-interval = <30>;
> >>> +                     gpio-key,wakeup;
> >>> +             };
> >>> +
> >>> +             tablet_mode {
> >>> +                     label = "Tablet_mode";
> >>> +                     gpios = <&pio 121 GPIO_ACTIVE_HIGH>;
> >>> +                     linux,code = <1>; /* SW_TABLET_MODE */
> >>
> >> can't we use SW_TABLET_MODE fomr linux-event-codes.h?
> >>
> > Will fix this.
> >>> +                     linux,input-type = <5>; /* EV_SW */
> >>
> >> same here.
> >>
> >>> +                     gpio-key,wakeup;
> >>> +             };
> >>> +
> >>> +             volume_down {
> >>> +                     label = "Volume_down";
> >>> +                     gpios = <&pio 123 GPIO_ACTIVE_LOW>;
> >>> +                     linux,code = <KEY_VOLUMEDOWN>;
> >>> +             };
> >>> +
> >>> +             volume_up {
> >>> +                     label = "Volume_up";
> >>> +                     gpios = <&pio 124 GPIO_ACTIVE_LOW>;
> >>> +                     linux,code = <KEY_VOLUMEUP>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     panel: panel {
> >>> +             compatible = "lg,lp120up1";
> >>> +             power-supply = <&panel_fixed_3v3>;
> >>> +             ddc-i2c-bus = <&i2c0>;
> >>> +             backlight = <&backlight_lcd>;
> >>> +
> >>> +             port {
> >>> +                     panel_in: endpoint {
> >>> +                             remote-endpoint = <&ps8640_out>;
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +
> >>> +     panel_fixed_3v3: regulator@1 {
> >>> +             compatible = "regulator-fixed";
> >>> +             regulator-name = "PANEL_3V3";
> >>> +             regulator-min-microvolt = <3300000>;
> >>> +             regulator-max-microvolt = <3300000>;
> >>> +             enable-active-high;
> >>> +             gpio = <&pio 41 GPIO_ACTIVE_HIGH>;
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&panel_fixed_pins>;
> >>> +     };
> >>> +
> >>> +     ps8640_fixed_1v2: regulator@2 {
> >>> +             compatible = "regulator-fixed";
> >>> +             regulator-name = "PS8640_1V2";
> >>> +             regulator-min-microvolt = <1200000>;
> >>> +             regulator-max-microvolt = <1200000>;
> >>> +             regulator-enable-ramp-delay = <2000>;
> >>> +             enable-active-high;
> >>> +             regulator-boot-on;
> >>> +             gpio = <&pio 30 GPIO_ACTIVE_HIGH>;
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&ps8640_fixed_pins>;
> >>> +     };
> >>> +
> >>> +     sdio_fixed_3v3: fixedregulator@0 {
> >>> +             compatible = "regulator-fixed";
> >>> +             regulator-name = "3V3";
> >>> +             regulator-min-microvolt = <3300000>;
> >>> +             regulator-max-microvolt = <3300000>;
> >>> +             gpio = <&pio 85 GPIO_ACTIVE_HIGH>;
> >>
> >> we don't need to set the pincontroller mux here?
> >>
> > Will double check on schematic and add it.
> >>> +     };
> >>> +
> >>> +     sound: sound {
> >>> +             compatible = "mediatek,mt8173-rt5650";
> >>> +             mediatek,audio-codec = <&rt5650 &hdmi0>;
> >>> +             mediatek,platform = <&afe>;
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&aud_i2s2>;
> >>> +
> >>> +             mediatek,mclk = <1>;
> >>> +             codec-capture {
> >>> +                     sound-dai = <&rt5650 1>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     hdmicon: connector {
> >>> +             compatible = "hdmi-connector";
> >>> +             label = "hdmi";
> >>> +             type = "a";
> >>> +             ddc-i2c-bus = <&hdmiddc0>;
> >>> +
> >>> +             port {
> >>> +                     hdmi_connector_in: endpoint {
> >>> +                             remote-endpoint = <&hdmi0_out>;
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&cec {
> >>> +     status = "okay";
> >>> +};
> >>> +
> >>> +&cpu0 {
> >>> +     proc-supply = <&mt6397_vpca15_reg>;
> >>> +};
> >>> +
> >>> +&cpu1 {
> >>> +     proc-supply = <&mt6397_vpca15_reg>;
> >>> +};
> >>> +
> >>> +&cpu2 {
> >>> +     proc-supply = <&da9211_vcpu_reg>;
> >>> +     sram-supply = <&mt6397_vsramca7_reg>;
> >>> +};
> >>> +
> >>> +&cpu3 {
> >>> +     proc-supply = <&da9211_vcpu_reg>;
> >>> +     sram-supply = <&mt6397_vsramca7_reg>;
> >>> +};
> >>> +
> >>> +&cpu_thermal {
> >>> +     sustainable-power = <4500>; /* milliwatts */
> >>> +     trips {
> >>> +             threshold: trip-point@0 {
> >>> +                     temperature = <60000>;
> >>> +             };
> >>> +
> >>> +             target: trip-point@1 {
> >>> +                     temperature = <65000>;
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&dsi0 {
> >>> +     status = "okay";
> >>> +     ports {
> >>> +             #address-cells = <1>;
> >>> +             #size-cells = <0>;
> >>> +
> >>> +             port@1 {
> >>> +                     dsi0_out: endpoint {
> >>> +                             remote-endpoint = <&ps8640_in>;
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&dpi0 {
> >>> +     status = "okay";
> >>> +};
> >>> +
> >>> +&hdmi0 {
> >>> +     status = "okay";
> >>> +     ports {
> >>> +             port@1 {
> >>> +                     reg = <1>;
> >>> +
> >>> +                     hdmi0_out: endpoint {
> >>> +                             remote-endpoint = <&hdmi_connector_in>;
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&hdmi_phy {
> >>> +     status = "okay";
> >>> +     mediatek,ibias = <0xc>;
> >>> +};
> >>> +
> >>> +&i2c0 {
> >>> +     status = "okay";
> >>> +
> >>> +     rt5650: audio-codec@1a {
> >>> +             compatible = "realtek,rt5650";
> >>> +             reg = <0x1a>;
> >>> +             avdd-supply = <&mt6397_vgp1_reg>;
> >>> +             cpvdd-supply = <&mt6397_vcama_reg>;
> >>
> >> Hm, only defined for "realtek,rt5663", I suppose that's an inconsistency in the
> >> binding documentation. Can you please double check?
> >>
> > This one? https://github.com/torvalds/linux/blob/master/sound/soc/codecs/rt5645.c#L3582
> >
>
> Yes, I checked myself and send a patch to fix the binding description, which was
> missing the two suppliers.
>
>
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&rt5650_irq>;
> >>> +             #sound-dai-cells = <1>;
> >>> +             realtek,dmic1-data-pin = <2>;
> >>> +             realtek,jd-mode = <2>;
> >>> +     };
> >>> +
> >>> +     ps8640: edp-bridge@8 {
> >>> +             compatible = "parade,ps8640";
> >>> +             reg = <0x8>;
> >>> +             powerdown-gpios = <&pio 127 GPIO_ACTIVE_LOW>;
> >>> +             reset-gpios = <&pio 115 GPIO_ACTIVE_LOW>;
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&ps8640_pins>;
> >>> +             vdd12-supply = <&ps8640_fixed_1v2>;
> >>> +             vdd33-supply = <&mt6397_vgp2_reg>;
> >>> +
> >>> +             ports {
> >>> +                     #address-cells = <1>;
> >>> +                     #size-cells = <0>;
> >>> +
> >>> +                     port@0 {
> >>> +                             reg = <0>;
> >>> +
> >>> +                             ps8640_in: endpoint {
> >>> +                                     remote-endpoint = <&dsi0_out>;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     port@1 {
> >>> +                             reg = <1>;
> >>> +
> >>> +                             ps8640_out: endpoint {
> >>> +                                     remote-endpoint = <&panel_in>;
> >>> +                             };
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&i2c1 {
> >>> +     clock-frequency = <1500000>;
> >>> +     status = "okay";
> >>> +
> >>> +     da9211: da9211@68 {
> >>> +             compatible = "dlg,da9211";
> >>> +             reg = <0x68>;
> >>> +
> >>
> >> no interrupts? binding description have this stated as required. what happens
> >> when the device raises an interrupt?
> > Will double check on schematic and add it.
> >>
> >>> +             regulators {
> >>> +                     da9211_vcpu_reg: BUCKA {
> >>> +                             regulator-name = "VBUCKA";
> >>> +                             regulator-min-microvolt = < 700000>;
> >>> +                             regulator-max-microvolt = <1310000>;
> >>> +                             regulator-min-microamp  = <2000000>;
> >>> +                             regulator-max-microamp  = <4400000>;
> >>> +                             regulator-ramp-delay = <10000>;
> >>> +                             regulator-always-on;
> >>> +                             regulator-allowed-modes = <0 1>;
> >>> +                     };
> >>> +
> >>> +                     da9211_vgpu_reg: BUCKB {
> >>> +                             regulator-name = "VBUCKB";
> >>> +                             regulator-min-microvolt = < 700000>;
> >>> +                             regulator-max-microvolt = <1310000>;
> >>> +                             regulator-min-microamp  = <2000000>;
> >>> +                             regulator-max-microamp  = <3000000>;
> >>> +                             regulator-ramp-delay = <10000>;
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&i2c2 {
> >>> +     status = "okay";
> >>> +
> >>> +     tpm: tpm@20 {
> >>> +             compatible = "infineon,slb9645tt";
> >>> +             reg = <0x20>;
> >>> +             powered-while-suspended;
> >>> +     };
> >>> +};
> >>> +
> >>> +&i2c3 {
> >>> +     clock-frequency = <400000>;
> >>> +     status = "okay";
> >>> +
> >>> +     touchscreen: touchscreen@10 {
> >>> +             compatible = "elan,ekth3500";
> >>> +             reg = <0x10>;
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <88 IRQ_TYPE_LEVEL_LOW>;
> >>> +     };
> >>> +};
> >>> +
> >>> +&i2c4 {
> >>> +     clock-frequency = <400000>;
> >>> +     status = "okay";
> >>> +     pinctrl-names = "default";
> >>> +     pinctrl-0 = <&trackpad_irq>;
> >>
> >> Why not move the pinctrl properties into the trackpad node?
> >>
> > As second source trackpad device and original device shares same
> > compatible string (rev id), we need to add 2nd trackpad node here.
> > According to previous log (since I don't have a second source trackpad
> > device to test), adding pinctrl in each trackpad node, there would be
> > error:
> >  [    0.643501] mediatek-mt8173-pinctrl 1000b000.pinctrl: pin URXD3
> > already requested by 7-0015; cannot claim for 7-002c
> >  [    0.643525] mediatek-mt8173-pinctrl 1000b000.pinctrl: pin-117
> > (7-002c) status -22
> >  [    0.643548] mediatek-mt8173-pinctrl 1000b000.pinctrl: could not
> > request pin 117 (URXD3) from group URXD3  on device 1000b000.pinctrl
> >  [    0.643568] i2c_hid 7-002c: Error applying setting, reverse things back
> >  [    0.643867] i2c 7-002c: Driver i2c_hid requests probe deferral
> >
> >
>
> I think we can fix this, if we create the aforementioned two board DTS files.
> Correct?
>
> >>> +
> >>> +     trackpad: trackpad@15 {
> >>> +             compatible = "elan,ekth3000";
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <117 IRQ_TYPE_LEVEL_LOW>;
> >>> +             reg = <0x15>;
> >>> +             vcc-supply = <&mt6397_vgp6_reg>;
> >>> +             wakeup-source;
> >>> +     };
> >>> +};
> >>> +
> >>> +&mipi_tx0 {
> >>> +     status = "okay";
> >>> +};
> >>> +
> >>> +&mmc0 {
> >>> +     status = "okay";
> >>> +     pinctrl-names = "default", "state_uhs";
> >>> +     pinctrl-0 = <&mmc0_pins_default>;
> >>> +     pinctrl-1 = <&mmc0_pins_uhs>;
> >>> +     bus-width = <8>;
> >>> +     max-frequency = <200000000>;
> >>> +     cap-mmc-highspeed;
> >>> +     mmc-hs200-1_8v;
> >>> +     mmc-hs400-1_8v;
> >>> +     cap-mmc-hw-reset;
> >>> +     hs400-ds-delay = <0x14015>;
> >>> +     mediatek,hs200-cmd-int-delay=<30>;
> >>> +     mediatek,hs400-cmd-int-delay=<14>;
> >>> +     mediatek,hs400-cmd-resp-sel-rising;
> >>> +     vmmc-supply = <&mt6397_vemc_3v3_reg>;
> >>> +     vqmmc-supply = <&mt6397_vio18_reg>;
> >>> +     assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
> >>> +     assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
> >>> +     non-removable;
> >>> +};
> >>> +
> >>> +&mmc1 {
> >>> +     status = "okay";
> >>> +     pinctrl-names = "default", "state_uhs";
> >>> +     pinctrl-0 = <&mmc1_pins_default>;
> >>> +     pinctrl-1 = <&mmc1_pins_uhs>;
> >>> +     bus-width = <4>;
> >>> +     max-frequency = <200000000>;
> >>> +     cap-sd-highspeed;
> >>> +     sd-uhs-sdr50;
> >>> +     sd-uhs-sdr104;
> >>> +     cd-gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
> >>> +     vmmc-supply = <&mt6397_vmch_reg>;
> >>> +     vqmmc-supply = <&mt6397_vmc_reg>;
> >>> +};
> >>> +
> >>> +&mmc3 {
> >>> +     status = "okay";
> >>> +     pinctrl-names = "default", "state_uhs";
> >>> +     pinctrl-0 = <&mmc3_pins_default>;
> >>> +     pinctrl-1 = <&mmc3_pins_uhs>;
> >>> +     bus-width = <4>;
> >>> +     max-frequency = <200000000>;
> >>> +     cap-sd-highspeed;
> >>> +     sd-uhs-sdr50;
> >>> +     sd-uhs-sdr104;
> >>> +     sdr104-clk-delay = <5>;
> >>
> >> Not an upstream property, please delete it.
> >>
> >>> +     keep-power-in-suspend;
> >>> +     enable-sdio-wakeup;
> >>> +     cap-sdio-irq;
> >>> +     vmmc-supply = <&sdio_fixed_3v3>;
> >>> +     vqmmc-supply = <&mt6397_vgp3_reg>;
> >>> +     non-removable;
> >>> +     cap-power-off-card;
> >>> +
> >>> +     #address-cells = <1>;
> >>> +     #size-cells = <0>;
> >>> +
> >>> +     btmrvl: btmrvl@2 {
> >>> +             compatible = "marvell,sd8897-bt";
> >>> +             reg = <2>;
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
> >>> +             marvell,wakeup-pin = /bits/ 16 <0x0d>;
> >>> +             marvell,wakeup-gap-ms = /bits/ 16 <0x64>;
> >>> +     };
> >>> +
> >>> +     mwifiex: mwifiex@1 {
> >>> +             compatible = "marvell,sd8897";
> >>> +             reg = <1>;
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
> >>> +             marvell,wakeup-pin = <3>;
> >>> +             marvell,caldata_ed_mac = /bits/ 8 <
> >>> +0x01 0x00 0x07 0x00 0x14 0x00 0x01 0x00 0x00 0x00 0x12 0x00 0x02 0x00 0x01 0x00
> >>> +0x01 0x00 0x00 0x00 0x12 0x00 0x02 0x00 0x01 0x00
> >>> +             >;
> >>
> >> Not an upstream property, please delete.
> >>
> >>> +     };
> >>> +};
> >>> +
> >>> +&nor_flash {
> >>> +     status = "okay";
> >>> +     pinctrl-names = "default";
> >>> +     pinctrl-0 = <&nor_gpio1_pins>;
> >>> +     bus-width = <8>;
> >>> +     max-frequency = <50000000>;
> >>> +     non-removable;
> >>> +     flash@0 {
> >>> +             compatible = "jedec,spi-nor";
> >>> +             reg = <0>;
> >>> +     };
> >>> +};
> >>> +
> >>> +&pio {
> >>> +     aud_i2s2: aud_i2s2 {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_128_I2S0_LRCK__FUNC_I2S1_WS>,
> >>> +                              <MT8173_PIN_129_I2S0_BCK__FUNC_I2S1_BCK>,
> >>> +                              <MT8173_PIN_130_I2S0_MCK__FUNC_I2S1_MCK>,
> >>> +                              <MT8173_PIN_131_I2S0_DATA0__FUNC_I2S1_DO_1>,
> >>> +                              <MT8173_PIN_12_EINT12__FUNC_I2S2_WS>,
> >>> +                              <MT8173_PIN_13_EINT13__FUNC_I2S2_BCK>,
> >>> +                              <MT8173_PIN_132_I2S0_DATA1__FUNC_I2S2_DI_2>;
> >>> +                     bias-pull-down;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     bl_fixed_pins: bl_fixed_pins {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_32_UTXD2__FUNC_GPIO32>;
> >>> +                     output-low;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     bt_wake_pins: bt_wake_pins {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_119_KPROW0__FUNC_GPIO119>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     disp_pwm0_pins: disp_pwm0_pins {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_87_DISP_PWM0__FUNC_DISP_PWM0>;
> >>> +                     output-low;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     gpio_keys_pins: gpio_keys_pins {
> >>> +             volume_pins {
> >>> +                     pinmux = <MT8173_PIN_123_KPCOL1__FUNC_GPIO123>,
> >>> +                              <MT8173_PIN_124_KPCOL2__FUNC_GPIO124>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +
> >>> +             tablet_mode_pins {
> >>> +                     pinmux = <MT8173_PIN_121_KPROW2__FUNC_GPIO121>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     hdmi_mux_pins: hdmi_mux_pins {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_36_DAISYNC__FUNC_GPIO36>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     mmc0_pins_default: mmc0default {
> >>> +             pins_cmd_dat {
> >>> +                     pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
> >>> +                              <MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
> >>> +                              <MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
> >>> +                              <MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
> >>> +                              <MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
> >>> +                              <MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
> >>> +                              <MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
> >>> +                              <MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
> >>> +                              <MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>;
> >>> +                             bias-pull-up;
> >>> +             };
> >>> +
> >>> +             pins_clk {
> >>> +                     pinmux = <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
> >>> +                             bias-pull-down;
> >>
> >> identation.
> >>
> >>> +             };
> >>> +
> >>> +             pins_rst {
> >>> +                     pinmux = <MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     mmc1_pins_default: mmc1default {
> >>> +             pins_cmd_dat {
> >>> +                     pinmux = <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
> >>> +                              <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
> >>> +                              <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
> >>> +                              <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
> >>> +                              <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_4mA>;
> >>> +                     bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> >>> +             };
> >>> +
> >>> +             pins_clk {
> >>> +                     pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
> >>> +                     bias-pull-down;
> >>> +                     drive-strength = <MTK_DRIVE_4mA>;
> >>> +             };
> >>> +
> >>> +             pins_insert {
> >>> +                     pinmux = <MT8173_PIN_1_EINT1__FUNC_GPIO1>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     mmc3_pins_default: mmc3default {
> >>> +             pins_dat {
> >>> +                     pinmux = <MT8173_PIN_22_MSDC3_DAT0__FUNC_MSDC3_DAT0>,
> >>> +                              <MT8173_PIN_23_MSDC3_DAT1__FUNC_MSDC3_DAT1>,
> >>> +                              <MT8173_PIN_24_MSDC3_DAT2__FUNC_MSDC3_DAT2>,
> >>> +                              <MT8173_PIN_25_MSDC3_DAT3__FUNC_MSDC3_DAT3>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_8mA>;
> >>> +                     bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> >>> +             };
> >>> +
> >>> +             pins_cmd {
> >>> +                     pinmux = <MT8173_PIN_27_MSDC3_CMD__FUNC_MSDC3_CMD>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_8mA>;
> >>> +                     bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> >>> +             };
> >>> +
> >>> +             pins_clk {
> >>> +                     pinmux = <MT8173_PIN_26_MSDC3_CLK__FUNC_MSDC3_CLK>;
> >>> +                     bias-pull-down;
> >>> +                     drive-strength = <MTK_DRIVE_8mA>;
> >>> +             };
> >>> +
> >>> +             pins_pdn {
> >>> +                     pinmux = <MT8173_PIN_85_AUD_DAT_MOSI__FUNC_GPIO85>;
> >>> +                     output-low;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     mmc0_pins_uhs: mmc0 {
> >>> +             pins_cmd_dat {
> >>> +                     pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
> >>> +                              <MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
> >>> +                              <MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
> >>> +                              <MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
> >>> +                              <MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
> >>> +                              <MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
> >>> +                              <MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
> >>> +                              <MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
> >>> +                              <MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_6mA>;
> >>> +                     bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> >>> +             };
> >>> +
> >>> +             pins_clk {
> >>> +                     pinmux = <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
> >>> +                     drive-strength = <MTK_DRIVE_6mA>;
> >>> +                     bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
> >>> +             };
> >>> +
> >>> +             pins_ds {
> >>> +                     pinmux = <MT8173_PIN_67_MSDC0_DSL__FUNC_MSDC0_DSL>;
> >>> +                     drive-strength = <MTK_DRIVE_10mA>;
> >>> +                     bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
> >>> +             };
> >>> +
> >>> +             pins_rst {
> >>> +                     pinmux = <MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     mmc1_pins_uhs: mmc1 {
> >>> +             pins_cmd_dat {
> >>> +                     pinmux = <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
> >>> +                              <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
> >>> +                              <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
> >>> +                              <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
> >>> +                              <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_6mA>;
> >>> +                     bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> >>> +             };
> >>> +
> >>> +             pins_clk {
> >>> +                     pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
> >>> +                     drive-strength = <MTK_DRIVE_8mA>;
> >>> +                     bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     mmc3_pins_uhs: mmc3 {
> >>> +             pins_dat {
> >>> +                     pinmux = <MT8173_PIN_22_MSDC3_DAT0__FUNC_MSDC3_DAT0>,
> >>> +                              <MT8173_PIN_23_MSDC3_DAT1__FUNC_MSDC3_DAT1>,
> >>> +                              <MT8173_PIN_24_MSDC3_DAT2__FUNC_MSDC3_DAT2>,
> >>> +                              <MT8173_PIN_25_MSDC3_DAT3__FUNC_MSDC3_DAT3>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_8mA>;
> >>> +                     bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> >>> +             };
> >>> +
> >>> +             pins_cmd {
> >>> +                     pinmux = <MT8173_PIN_27_MSDC3_CMD__FUNC_MSDC3_CMD>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_8mA>;
> >>> +                     bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> >>> +             };
> >>> +
> >>> +             pins_clk {
> >>> +                     pinmux = <MT8173_PIN_26_MSDC3_CLK__FUNC_MSDC3_CLK>;
> >>> +                     drive-strength = <MTK_DRIVE_8mA>;
> >>> +                     bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     nor_gpio1_pins: nor {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_6_EINT6__FUNC_SFCS0>,
> >>> +                              <MT8173_PIN_7_EINT7__FUNC_SFHOLD>,
> >>> +                              <MT8173_PIN_8_EINT8__FUNC_SFIN>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_4mA>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +
> >>> +             pins2 {
> >>> +                     pinmux = <MT8173_PIN_5_EINT5__FUNC_SFOUT>;
> >>> +                     drive-strength = <MTK_DRIVE_4mA>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +
> >>> +             pins_clk {
> >>> +                     pinmux = <MT8173_PIN_9_EINT9__FUNC_SFCK>;
> >>> +                     input-enable;
> >>> +                     drive-strength = <MTK_DRIVE_4mA>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     panel_fixed_pins: panel_fixed_pins {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_41_CMMCLK__FUNC_GPIO41>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     ps8640_pins: ps8640_pins {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_92_PCM_CLK__FUNC_GPIO92>,
> >>> +                              <MT8173_PIN_115_URTS0__FUNC_GPIO115>,
> >>> +                              <MT8173_PIN_127_LCM_RST__FUNC_GPIO127>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     ps8640_fixed_pins: ps8640_fixed_pins {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_30_URTS2__FUNC_GPIO30>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     rt5650_irq: rt5650_irq {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_3_EINT3__FUNC_GPIO3>;
> >>> +                     bias-pull-down;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     spi_pins_a: spi1 {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_0_EINT0__FUNC_GPIO0>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +
> >>> +             pins_spi {
> >>> +                     pinmux = <MT8173_PIN_102_MSDC2_DAT2__FUNC_SPI_CK_1_>,
> >>> +                              <MT8173_PIN_103_MSDC2_DAT3__FUNC_SPI_MI_1_>,
> >>> +                              <MT8173_PIN_104_MSDC2_CLK__FUNC_SPI_MO_1_>,
> >>> +                              <MT8173_PIN_105_MSDC2_CMD__FUNC_SPI_CS_1_>;
> >>> +                     bias-disable;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     trackpad_irq: trackpad_irq {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_117_URXD3__FUNC_GPIO117>;
> >>> +                     input-enable;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     usb_pins: usb@0 {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_101_MSDC2_DAT1__FUNC_GPIO101>;
> >>> +                     output-high;
> >>> +                     bias-disable;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     wifi_wake_pins: wifi_wake_pins {
> >>> +             pins1 {
> >>> +                     pinmux = <MT8173_PIN_38_CONN_RST__FUNC_GPIO38>;
> >>> +                     bias-pull-up;
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&pwm0 {
> >>> +     status = "okay";
> >>> +};
> >>> +
> >>> +&pwrap {
> >>> +     pmic: mt6397 {
> >>> +             compatible = "mediatek,mt6397";
> >>> +             #address-cells = <1>;
> >>> +             #size-cells = <1>;
> >>> +             interrupt-parent = <&pio>;
> >>> +             interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> >>> +             interrupt-controller;
> >>> +             #interrupt-cells = <2>;
> >>> +
> >>> +             mt6397rtc: mt6397rtc {
> >>
> >> AFAIK this should be
> >> rtc: mt6397rtc {
> >>
> >> Please fix that for all subnodes.
> >>
> > Will fix in next version
> >>> +                     compatible = "mediatek,mt6397-rtc";
> >>> +             };
> >>> +
> >>> +             syscfg_pctl_pmic: syscfg_pctl_pmic@c000 {
> >>> +                     compatible = "mediatek,mt6397-pctl-pmic-syscfg",
> >>> +                                  "syscon";
> >>> +                     reg = <0 0x0000c000 0 0x0108>;
> >>
> >> not an upstream compatible, please delete the node.
> >>
>
> I think my comment was not correct. I'll have to dig more to understand why we
> have a compatible without a binding description.
>
> Regards,
> Matthias

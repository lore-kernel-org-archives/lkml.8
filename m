Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL_NO_RDNS autolearn=no autolearn_force=no version=3.4.0
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36804 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgCKBYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:24:12 -0400
MIME-Version: 1.0
References: <20200311010138.10465-1-aford173@gmail.com>
In-Reply-To: <20200311010138.10465-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Mar 2020 22:24:01 -0300
Message-ID:
 <CAOMZO5AqjrQxGcHVLPRQXC0nRUM+hOeWtnAK2vJ=O_P28FZ3-g@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: imx: Add Beacon i.mx8mm development kit
To: Adam Ford <aford173@gmail.com>
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        aford@beaconembeddedworks.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311012401.0NhSuAxHPT6urUmAw-txGP6IHnsPhbji4vZQmP0Yg2Y@z>

Hi Adam,

On Tue, Mar 10, 2020 at 10:01 PM Adam Ford <aford173@gmail.com> wrote:

> +&ecspi2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_espi2>;
> +       cs-gpios = <&gpio5 9 0>;

You could use GPIO_ACTIVE_HIGH instead of hardcoded 0.

> +       status = "okay";
> +
> +       at25@0 {

Node names should be generic:

eeprom@0

> +               compatible = "atmel,at25";

Documentation/devicetree/bindings/eeprom/at25.txt states:

"- compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
  Example "<vendor>,<type>" values:
    "microchip,25lc040"
    "st,m95m02"
    "st,m95256"

> +&i2c4 {
> +

Unneeded blank line.

> diff --git a/arch/arm64/boot/dts/freescale/beacon-imx8mm-kit.dts b/arch/arm64/boot/dts/freescale/beacon-imx8mm-kit.dts
> new file mode 100644
> index 000000000000..417b15d345d5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/beacon-imx8mm-kit.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2020 Compass Electronics Group, LLC
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm.dtsi"
> +#include "beacon-imx8mm-som.dtsi"
> +#include "beacon-imx8mm-baseboard.dtsi"

The naming convention we use is to start the dts names with the i.MX
SoC name, so:

imx8mm-beacon-som.dtsi
imx8mm-beacon-baseboard.dtsi

> +/ {
> +       model = "Beacon EmbeddedWorks i.MX8M Mini Development Kit";
> +       compatible = "fsl,imx8mm";

You should add an Entry for Beacon in
Documentation/devicetree/bindings/vendor-prefixes.yaml on a separate
patch.

and then:

compatible = "beacon,imx8mm-beacon-kit", "fsl,imx8mm"

Also, please add an entry for this board in
Documentation/devicetree/bindings/arm/fsl.yaml

> +&i2c3 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       status = "okay";
> +
> +       eeprom@50 {
> +               compatible = "atmel,24c64";

Same comment about the compatible.

> +&iomuxc {
> +

Unneeded blank line.

> +               pinctrl_fec1: fec1grp {


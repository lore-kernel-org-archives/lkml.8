Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14997C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C7A20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599292470;
	bh=ZoCxCzhyH5PWfIrPdsAkm3KPRt8Z8QvNMRXjsz+xV+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CGgej0eCvQNNGt+mZaKH/TBFa9cmA1ZML61kpc3iWMbtB2lXZBStaVg2kET4Km78R
	 ii9lgInTXZqfYnEribNfzTH9ezBf6Tyixawqmi41BubkxfP1e83+czaE/IYj+BsA0e
	 C7hUcddfN2jsDh9LICqOSVVOzVBVP6P5EBo63pQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIEHy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 03:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgIEHy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:54:27 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B68920760;
        Sat,  5 Sep 2020 07:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599292466;
        bh=ZoCxCzhyH5PWfIrPdsAkm3KPRt8Z8QvNMRXjsz+xV+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oj2+k4zF0yDZ9GwzyWXm2kMk6iPgSpdRnB9Fq8K1z78Qb6oJlG7mTsALx4eJ8/nom
         jPeHyhFcEYa21tQFjULS5X7889ahhi2hlPgxaY1ThEqsieK5VOiTacELZf45F0JzZZ
         NSRMPko/l4csV5igrCLTl38H2qlkhxmq8Lu6mWtI=
Date:   Sat, 5 Sep 2020 15:54:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     meenakshi.aggarwal@nxp.com
Cc:     robh+dt@kernel.org, V.sethi@nxp.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds
 board
Message-ID: <20200905075419.GN9261@dragon>
References: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:43:30PM +0530, meenakshi.aggarwal@nxp.com wrote:
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> 
> Add device tree support for LX2162AQDS board.
> LX2162A has same die as of LX2160A with different packaging.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 336 ++++++++++++++++++++++
>  2 files changed, 337 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index a39f0a1..ab9fbd3 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-clearfog-cx.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
>  
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> new file mode 100644
> index 0000000..a81c6a4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2162AQDS
> +//
> +// Copyright 2020 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +	model = "NXP Layerscape LX2162AQDS";
> +	compatible = "nxp,lx2162a-qds", "fsl,lx2160a";
> +
> +	aliases {
> +		crypto = &crypto;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	sb_3v3: regulator-sb3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "MC34717-3.3VSB";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;

I do not see any point to have regulator-boot-on or regulator-always-on
for a regulator that doesn't have on/off control.

> +	};
> +
> +	mdio-mux-1 {
> +		compatible = "mdio-mux-multiplexer";
> +		mux-controls = <&mux 0>;
> +		mdio-parent-bus = <&emdio1>;
> +		#address-cells=<1>;
> +		#size-cells = <0>;
> +
> +		mdio@0 { /* On-board RTL8211F PHY #1 RGMII1*/
> +			reg = <0x00>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rgmii_phy1: ethernet-phy@1 {
> +				compatible = "ethernet-phy-id001c.c916";
> +				reg = <0x1>;
> +				eee-broken-1000t;
> +			};
> +		};
> +
> +		mdio@8 { /* On-board RTL8211F PHY #2 RGMII2*/

Missing one space before closing comment.

Shawn

> +			reg = <0x8>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rgmii_phy2: ethernet-phy@2 {
> +				compatible = "ethernet-phy-id001c.c916";
> +				reg = <0x2>;
> +				eee-broken-1000t;
> +			};
> +		};
> +
> +		mdio@18 { /* Slot #1 */
> +			reg = <0x18>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@19 { /* Slot #2 */
> +			reg = <0x19>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@1a { /* Slot #3 */
> +			reg = <0x1a>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@1b { /* Slot #4 */
> +			reg = <0x1b>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@1c { /* Slot #5 */
> +			reg = <0x1c>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@1d { /* Slot #6 */
> +			reg = <0x1d>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@1e { /* Slot #7 */
> +			reg = <0x1e>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@1f { /* Slot #8 */
> +			reg = <0x1f>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	mdio-mux-2 {
> +		compatible = "mdio-mux-multiplexer";
> +		mux-controls = <&mux 1>;
> +		mdio-parent-bus = <&emdio2>;
> +		#address-cells=<1>;
> +		#size-cells = <0>;
> +
> +		mdio@0 { /* Slot #1 (secondary EMI) */
> +			reg = <0x00>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@1 { /* Slot #2 (secondary EMI) */
> +			reg = <0x01>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@2 { /* Slot #3 (secondary EMI) */
> +			reg = <0x02>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@3 { /* Slot #4 (secondary EMI) */
> +			reg = <0x03>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@4 { /* Slot #5 (secondary EMI) */
> +			reg = <0x04>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@5 { /* Slot #6 (secondary EMI) */
> +			reg = <0x05>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@6 { /* Slot #7 (secondary EMI) */
> +			reg = <0x06>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mdio@7 { /* Slot #8 (secondary EMI) */
> +			reg = <0x07>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +&crypto {
> +	status = "okay";
> +};
> +
> +&dpmac17 {
> +	phy-handle = <&rgmii_phy1>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&dpmac18 {
> +	phy-handle = <&rgmii_phy2>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&dspi0 {
> +	status = "okay";
> +
> +	dflash0: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +	};
> +};
> +
> +&dspi1 {
> +	status = "okay";
> +
> +	dflash1: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +	};
> +};
> +
> +&dspi2 {
> +	status = "okay";
> +
> +	dflash2: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +	};
> +};
> +
> +&emdio1 {
> +	status = "okay";
> +};
> +
> +&emdio2 {
> +	status = "okay";
> +};
> +
> +&esdhc0 {
> +	status = "okay";
> +};
> +
> +&esdhc1 {
> +	status = "okay";
> +};
> +
> +&fspi {
> +	status = "okay";
> +
> +	mt35xu512aba0: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +		spi-rx-bus-width = <8>;
> +		spi-tx-bus-width = <8>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	fpga@66 {
> +		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
> +			     "simple-mfd";
> +		reg = <0x66>;
> +
> +		mux: mux-controller {
> +			compatible = "reg-mux";
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x54 0xf8>, /* 0: reg 0x54, bits 7:3 */
> +					<0x54 0x07>; /* 1: reg 0x54, bit 2:0 */
> +		};
> +	};
> +
> +	i2c-mux@77 {
> +		compatible = "nxp,pca9547";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			power-monitor@40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <500>;
> +			};
> +
> +			power-monitor@41 {
> +				compatible = "ti,ina220";
> +				reg = <0x41>;
> +				shunt-resistor = <1000>;
> +			};
> +		};
> +
> +		i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			temperature-sensor@4c {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4c>;
> +				vcc-supply = <&sb_3v3>;
> +			};
> +
> +			rtc@51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +			};
> +		};
> +	};
> +};
> +
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&sata1 {
> +	status = "okay";
> +};
> +
> +&sata2 {
> +	status = "okay";
> +};
> +
> +&sata3 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> -- 
> 2.7.4
> 

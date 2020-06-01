Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9615DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622BB20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="cbHrA0JH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFAPQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:16:06 -0400
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:58386 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728049AbgFAPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:16:04 -0400
X-Greylist: delayed 1246 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 11:16:02 EDT
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 2A6D2140693
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:55:15 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id flqKj0GKL1EW3flqMjqYMm; Mon, 01 Jun 2020 08:55:15 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=A7RCwZeG c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=nTHF0DUjJn0A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=vzkQzeYxvNWxcUWojyIA:9 a=S98yGVt2Wv-XtSOH:21 a=EiBAABpLls2hw3GD:21
 a=QEXdDO2ut3YA:10:nop_charset_2 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+Xu7l6hzOuH+trrTVismt5vHgjqhSWauB5JkIiiPwYc=; b=cbHrA0JHvmnRgimXA9GIwodGL7
        86IJQLgQnMJjadzWicFo3eOVxMnTXYDx+pCy+6UU0bb85ibHHpHtkvX1BLmlpPobtxnfGN0gRPjfo
        lRrnC9YNBxLuWp1dlvN1bSYEGtWTcyRvHJs0+NdWk1kRhsXbBMBMC7Q6lLKOkMO91cNDEyJYCPF1z
        /MR62im3YCqJUsBcm1Py9vI2oz3LyOADgughp13FNEJNrevTocXW/VK6s45sQcrSZqaqKJr9ib4fi
        6LVkw01QuxwbO17RYJKMSkkkKG+vm2ReuaDm4NR/IgygvR8f20Xry8YDqclAyQKqwaM2qICw9+hZK
        D5VU2HLA==;
Received: from dslb-002-205-073-081.002.205.pools.vodafone-ip.de ([2.205.73.81]:51482 helo=[192.168.178.164])
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <parthiban@linumiz.com>)
        id 1jflqJ-0004h4-Mc; Mon, 01 Jun 2020 14:55:11 +0000
Subject: Re: [PATCH] ARM: dts: imx6ull: add MYiR MYS-6ULX SBC
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parthiban <parthiban@linumiz.com>
References: <20200408184351.135716-1-parthiban@linumiz.com>
 <20200427061844.i5hb2xatq2ntdqbe@pengutronix.de>
From:   Parthiban <parthiban@linumiz.com>
Message-ID: <9077f6b0-66ac-8854-75fe-5bebb8314fc2@linumiz.com>
Date:   Mon, 1 Jun 2020 16:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200427061844.i5hb2xatq2ntdqbe@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 2.205.73.81
X-Source-L: No
X-Exim-ID: 1jflqJ-0004h4-Mc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: dslb-002-205-073-081.002.205.pools.vodafone-ip.de ([192.168.178.164]) [2.205.73.81]:51482
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 18
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/20 8:18 AM, Marco Felsch wrote:
> Hi Parthiban,
> 
> a few more minor comments..
> 
> On 20-04-08 20:43, Parthiban Nallathambi wrote:
> 
> ...
> 
>> diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
>> new file mode 100644
>> index 000000000000..f0a514187c21
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
>> @@ -0,0 +1,247 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020 Linumiz
>> + * Author: Parthiban Nallathambi <parthiban@linumiz.com>
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pwm/pwm.h>
>> +
>> +/ {
>> +	model = "MYiR MYS-6ULX Single Board Computer";
>> +	compatible = "myir,imx6ull-mys-6ulx", "fsl,imx6ull";
>> +
>> +	chosen {
>> +		stdout-path = &uart1;
>> +	};
>> +
>> +	regulators: regulators {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		vdd_5v: regulator@0 {
>> +			compatible = "regulator-fixed";
>> +			regulator-name = "VDD_5V";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +		};
>> +
>> +		vdd_3v3: regulator@1 {
>> +			compatible = "regulator-fixed";
>> +			regulator-name = "VDD_3V3";
>> +			regulator-min-microvolt = <3300000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			regulator-always-on;
>> +			vin-supply = <&vdd_5v>;
>> +		};
>> +	};
>> +};
>> +
>> +&fec1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_enet1>;
>> +	phy-mode = "rmii";
>> +	phy-handle = <&ethphy0>;
>> +	phy-supply = <&vdd_3v3>;
>> +	status = "okay";
>> +
>> +	mdio: mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethphy0: ethernet-phy@0 {
>> +			reg = <0>;
>> +			compatible = "ethernet-phy-ieee802.3-c22";
>> +			interrupt-parent = <&gpio5>;
>> +			interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>> +			clocks = <&clks IMX6UL_CLK_ENET_REF>;
>> +			clock-names = "rmii-ref";
>> +			status = "okay";
> 
> Status not needed here.

Thanks, removed it.

> 
>> +		};
>> +	};
>> +};
>> +
>> +&gpmi {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
>> +	nand-on-flash-bbt;
>> +	status = "disabled";
>> +};
>> +
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart1>;
>> +	status = "okay";
>> +};
>> +
>> +&usbotg1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usb_otg1_id>;
>> +	dr_mode = "otg";
>> +	status = "okay";
>> +};
>> +
>> +&usbotg2 {
>> +	dr_mode = "host";
>> +	disable-over-current;
>> +	status = "okay";
>> +};
>> +
>> +&usdhc1 {
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc1>;
>> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
>> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
>> +	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
>> +	no-1-8-v;
>> +	keep-power-in-suspend;
>> +	wakeup-source;
>> +	vmmc-supply = <&vdd_3v3>;
>> +	status = "okay";
>> +};
>> +
>> +&usdhc2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
>> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
>> +	bus-width = <8>;
>> +	non-removable;
>> +	keep-power-in-suspend;
>> +	vmmc-supply = <&vdd_3v3>;
>> +	status = "disabled";
> 
> Status not needed here.

Removed, thanks.

> 
> Regards,
>   Marco
> 
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl_enet1: enet1grp {
>> +		fsl,pins = <
>> +			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
>> +			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
>> +			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
>> +			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
>> +			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
>> +			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
>> +			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
>> +			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
>> +			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
>> +			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
>> +			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpmi_nand: gpminandgrp {
>> +		fsl,pins = <
>> +			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0x0b0b1
>> +			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0x0b0b1
>> +			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0x0b0b1
>> +			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0x0b000
>> +			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0x0b0b1
>> +			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0x0b0b1
>> +			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0x0b0b1
>> +			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x0b0b1
>> +			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0x0b0b1
>> +			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0x0b0b1
>> +			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0x0b0b1
>> +			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0x0b0b1
>> +			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0x0b0b1
>> +			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0x0b0b1
>> +			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0x0b0b1
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart1: uart1grp {
>> +		fsl,pins = <
>> +			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
>> +			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
>> +		>;
>> +	};
>> +
>> +	pinctrl_usb_otg1_id: usbotg1idgrp {
>> +		fsl,pins = <
>> +			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1: usdhc1grp {
>> +		fsl,pins = <
>> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
>> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
>> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
>> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
>> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
>> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
>> +			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x17059
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
>> +		fsl,pins = <
>> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
>> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
>> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
>> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
>> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
>> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
>> +		fsl,pins = <
>> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
>> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
>> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
>> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
>> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
>> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2: usdhc2grp {
>> +		fsl,pins = <
>> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
>> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
>> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
>> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
>> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
>> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
>> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
>> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
>> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
>> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
>> +		fsl,pins = <
>> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
>> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
>> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
>> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
>> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
>> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
>> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170b9
>> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170b9
>> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170b9
>> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
>> +		fsl,pins = <
>> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
>> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
>> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
>> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
>> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
>> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
>> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
>> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
>> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
>> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
>> +		>;
>> +	};
>> +};
>> -- 
>> 2.11.0
>>

-- 
Thanks,
Parthiban N
+4915163761545

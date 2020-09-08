Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FAEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C6A206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="CHTXAxXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgIHKqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:46:04 -0400
Received: from mail-eopbgr80132.outbound.protection.outlook.com ([40.107.8.132]:4711
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729316AbgIHKop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeajWr+xSpSxXR5RyJG/10cEG9MqOv4XKcxK2AW1hcv/vZJgWpVJb3T6PHyuLI38yHyF5kdqHEmtOxKKJE8H2yO/zXDtfzIrKiGC//yPoZXo6KPN6blCUbeWS1aMt6eHZsQ/ldas8U9kFwC1WglFhHWJl6hC9k+TfbgqukuM+NYJBU5qIz/BwyB6rVGq3pjyzoJ0YZi20njL002xdOtBDgTyjmYsvExVQ9vZnx6kSYOBcgmKvIpf67iWMbh02Rn3Jmktipx7zlUEi+ICX6qjCzYub+vgVSWINBMeL222UJeWh/h0uq7mK+2zQL0vnCvT6zhAOvLKauHfjRkpnxI9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL8bf3gKrZ4ebdzNmurhaCeZjfzo7owDMQsiFXzMC04=;
 b=RORxxBU1hi+R3lyn8Hyr5CMeynCKca6jh+ciPkE21j+tFK7DzPiranJTjFNvOpPNAzA1tBA7ylNm/2fuD3UJPq3QutOQod2kjt7zdAAs1i5sSeaWmD/jxKQSYSsb2tnKrHpxgX6nYQNWGNt+eHwr/8Dj/tWodr3lSJ15kCeIG98E+y7Kj9EP5lJeNELenEBIwDOu67v8126PvO1+Lauz3/tEE3ofYWBPPPgSc26kHHrli/BQUfslv98/IZfZaZQoQ2F3Nz8q/TFXDtECIGAgGjX2X/qw94q8uBtPcqFS+pAIBvlsGJscaFnG3FvUKvozFvgnKL4TPJ3MVa7Y8pKyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL8bf3gKrZ4ebdzNmurhaCeZjfzo7owDMQsiFXzMC04=;
 b=CHTXAxXGi/Lf9y6STJE4Bu4gxHHYI6lgIfrpzNtLVsmL+h/NKXrI8nzdMZF6etr0bh5bNOTGdeyFM4d/75nafJgsy4naG7d0shXGMyUjdqDJhtrEC65h0C40iOtEETrCBe/eyJ1JyQMEDs8plfA/dDAckgp05iXXgZn45duVP+A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 10:44:38 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51f5:dfc0:24bb:309c]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51f5:dfc0:24bb:309c%7]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 10:44:38 +0000
Subject: Re: [PATCH v2 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and
 baseboards
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200716161216.15461-1-frieder.schrempf@kontron.de>
 <20200716161216.15461-2-frieder.schrempf@kontron.de>
 <20200817085111.GE16951@dragon>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <72d909c8-33f1-b756-2567-5c69a6e284d5@kontron.de>
Date:   Tue, 8 Sep 2020 12:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817085111.GE16951@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::17) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.99.162] (80.147.118.32) by AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 10:44:37 +0000
X-Originating-IP: [80.147.118.32]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61408b71-412b-4390-2951-08d853e42f37
X-MS-TrafficTypeDiagnostic: AM0PR10MB3331:
X-Microsoft-Antispam-PRVS: <AM0PR10MB333139CA04042BBD11B11882E9290@AM0PR10MB3331.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eqNAhC39JAdV9OJAkVdyEhrsj8/uLxmlQMjz8PPkyVUg1zX5TGrC1vT4cqDHwZfb4Dtd8P1xDisvnMBDvPqG4RQsZ97m3ggLWf/mivRCKRxbc3qbatwWVluDkjCOBwXhBTe37BeQNn8SDPErz/X8O39TijpefxGE94fMA13hWRw+NfxUxuPc0KO5o9ubGTamNrimJOXYTObA4akaIXdoyNZxuOdCbMKFVBa1zduSJOerBWJvTdNLVdH7St8C2q7Fmh/jzWXZNAMZ3kX52F4vuGUqhHjR8F36ngd36ik0/FvQJUSQUuXYYari8mjaNWD/8EJZr+7Ob+qnLkqo5l2PZ0zYxdAGUtbkFWOd23O+fBSsHZ0pfeMwrTNQGZaWu52sCpcifnLmxrfi8INU7QnwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(16576012)(66476007)(54906003)(8676002)(7416002)(5660300002)(8936002)(26005)(316002)(30864003)(6486002)(6916009)(53546011)(36756003)(2616005)(956004)(31696002)(86362001)(66946007)(66556008)(44832011)(478600001)(52116002)(31686004)(2906002)(186003)(16526019)(83380400001)(4326008)(43740500002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: C1M3JDRhHlYl6UecwnLfjNItXa7stCdaEZsIWOdvfy56KlriuaiVcZrohPSiO9u9ZHvfOWjtAR7ymMhTl3301qljK5ZPYHOVOiQYYSiBc69lTBQx4RpW2K5KH1OSKZOXjR0L4DTAQQ0FqUasS4PKUHP9t4leUub0PwKfZVjeouZLQIW70omaeDG4j5c8aJ6Q6Ho8dSgufQZ2pMzSoPrmD9vndEKWVX0tSn8Q12Qk9O/rr2XcBXLMHnCbVYzW3P8qrj81ishIJVUdWkVT45Edq1vyhQhRSaPvCfUllan7W0Bb+8dkTtmbH3fZ/CV/lN6ojtB3dQerEwsa1gOEw8aTEgReUeZI+HmrHqc4MeQqmbAzLDdtVNIOKewpZd99pJJPiwskY1GEGmGP58NLVepNUheZY96AICCmyAdwWc2cS/wDlBo3HT8YScnwxZJnVbuvzmqlhs0XZTtXQOoSuqS86zoP3JITiind9djLpbFdYUnNhWoofNnLR9FH9Tl2qeeskqmxAp1xxbKmPGoTNeQMcMtPll/XLQcUiGVnvWaXdG5IJaK/XEl5AW6TU6fvsZ938Me/BVjirCLjsM9czgAFzfkaCI+QJJ+SJDqAb1GBBy9DPrxfrFhgaES6q+hFcdJ4HEw2nBAJqdNCJIMuUQqUMw==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 61408b71-412b-4390-2951-08d853e42f37
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 10:44:38.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2l10i0uUn+EVjnYloB+Oh2D9Dm3cwmHcoqCy9knm0mOROG0IoqVad9YaOVau0gp1HYo3tV/bpG8SqmkrUFfcdzkDSRtADqNAsHtbdsjvH2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.20 10:51, Shawn Guo wrote:
> On Thu, Jul 16, 2020 at 06:11:58PM +0200, Schrempf Frieder wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Kontron Electronics GmbH offers small and powerful SoMs based on the
>> i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.
>>
>> The matching baseboards have the same form factor and similar interfaces
>> as the other boards from the Kontron "Board-Line" family, including
>> SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
>> RS485, CAN, LVDS or HDMI, RTC and much more.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Changes for v2:
>> * Make the licensing less strict (GPL-2.0+ OR MIT)
>> * Merge the SoM and baseboard DTs for N8010 and N8011 into one as
>>    they only differ in DDR and eMMC size.
>> * Change compatibles and model strings to "n810x" and "N8010X".
>> * Only use a common memory node that will be updated by the
>>    bootloader reflecting the detected DDR size.
>> * Improve naming for 16MHz CAN fixed oscillator and set
>>    "clock-output-names".
>> * Consistently use "reg_" prefix for regulators.
>> * Remove "userspi" node.
>> * Slightly improve commit message.
>> ---
>>   .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 327 ++++++++++++++++++
>>   .../freescale/imx8mm-kontron-n801x-som.dtsi   | 294 ++++++++++++++++
>>   2 files changed, 621 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>> new file mode 100644
>> index 000000000000..25b8ef569edd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>> @@ -0,0 +1,327 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "imx8mm-kontron-n801x-som.dtsi"
>> +
>> +/ {
>> +	model = "Kontron i.MX8MM N801X S";
>> +	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
>> +
>> +	aliases {
>> +		ethernet1 = &usbnet;
>> +	};
>> +
>> +	/* fixed crystal dedicated to mcp2515 */
>> +	osc_can: clock-osc-can {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <16000000>;
>> +		clock-output-names = "osc-can";
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_gpio_led>;
>> +
>> +		led1 {
>> +			label = "led1";
>> +			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +
>> +		led2 {
>> +			label = "led2";
>> +			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led3 {
>> +			label = "led3";
>> +			gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led4 {
>> +			label = "led4";
>> +			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led5 {
>> +			label = "led5";
>> +			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led6 {
>> +			label = "led6";
>> +			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	pwm-beeper {
>> +		compatible = "pwm-beeper";
>> +		pwms = <&pwm2 0 5000 0>;
>> +	};
>> +
>> +	reg_rst_eth2: regulator-rst-eth2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "rst-usb-eth2";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_usb_eth2>;
>> +		gpio = <&gpio3 2 GPIO_ACTIVE_LOW>;
>> +		status = "okay";
> 
> We usually use 'okay' to flip 'disabled' status set in <soc>.dtsi.  It's
> not really needed here.

Ok.

> 
>> +	};
>> +
>> +	reg_vdd_5v: regulator-5v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd-5v";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
> 
> What's the point of having these for a regulator that doesn't have
> on/off control?

Nothing, I will remove them.

> 
>> +		status = "okay";
>> +	};
>> +};
>> +
>> +&ecspi2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi2>;
>> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +
>> +	can0: can@0 {
>> +		compatible = "microchip,mcp2515";
>> +		reg = <0>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_can>;
>> +		clocks = <&osc_can>;
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
>> +		spi-max-frequency = <100000>;
>> +		vdd-supply = <&reg_vdd_3v3>;
>> +		xceiver-supply = <&reg_vdd_5v>;
>> +		status = "okay";
>> +	};
>> +};
>> +
>> +&ecspi3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi3>;
>> +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
>> +
>> +&fec1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_enet>;
>> +	phy-mode = "rgmii";
>> +	phy-reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
>> +	phy-reset-duration = <100>;
>> +	phy-reset-post-delay = <100>;
> 
> These properties are deprecated.

Ok, I will use the reset bindings in the phy node instead.

> 
>> +	phy-handle = <&ethphy>;
>> +	status = "okay";
>> +
>> +	mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethphy: ethernet-phy@0 {
>> +			reg = <0>;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c4 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c4>;
>> +	status = "okay";
>> +
>> +	rtc@32 {
>> +		compatible = "epson,rx8900";
>> +		reg = <0x32>;
>> +	};
>> +};
>> +
>> +&pwm2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm2>;
>> +	status = "okay";
>> +};
>> +
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart1>;
>> +	uart-has-rtscts;
>> +	status = "okay";
>> +};
>> +
>> +&uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart2>;
>> +	linux,rs485-enabled-at-boot-time;
>> +	uart-has-rtscts;
>> +	status = "okay";
>> +};
>> +
>> +&usbotg1 {
>> +	dr_mode = "otg";
>> +	status = "okay";
>> +};
>> +
>> +&usbotg2 {
>> +	dr_mode = "host";
>> +	disable-over-current;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	usb1@1 {
>> +		compatible = "usb424,9514";
>> +		reg = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		usbnet: usbether@1 {
>> +			compatible = "usb424,ec00";
>> +			reg = <1>;
>> +			mac-address = [ 00 00 00 00 00 00 ];
>> +		};
>> +	};
>> +};
>> +
>> +&usdhc2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	vmmc-supply = <&reg_vdd_3v3>;
>> +	vqmmc-supply = <&reg_nvcc_sd>;
>> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
>> +	bus-width = <4>;
>> +	status = "okay";
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpio>;
>> +
>> +	pinctrl_can: cangrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_ecspi2: ecspi2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
>> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
>> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
>> +			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_ecspi3: ecspi3grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x82
>> +			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x82
>> +			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x82
>> +			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_enet: enetgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
>> +			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
>> +			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
>> +			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
>> +			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
>> +			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
>> +			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
>> +			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
>> +			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
>> +			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
>> +			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
>> +			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
>> +			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
>> +			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
>> +			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* PHY RST */
>> +			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* ETH IRQ */
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpio_led: gpioledgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19
>> +			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x19
>> +			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x19
>> +			MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x19
>> +			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x19
>> +			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x19
>> +			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpio: gpiogrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
>> +			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c4: i2c4grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
>> +			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
>> +		>;
>> +	};
>> +
>> +	pinctrl_pwm2: pwm2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart1: uart1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
>> +			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
>> +			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
>> +			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart2: uart2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
>> +			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
>> +			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
>> +			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
>> +		>;
>> +	};
>> +
>> +	pinctrl_usb_eth2: usbeth2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2: usdhc2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
>> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
>> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
>> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
>> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
>> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
>> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> +		>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> new file mode 100644
>> index 000000000000..6ff06d1cb23a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> @@ -0,0 +1,294 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
>> + */
>> +
>> +#include "imx8mm.dtsi"
>> +
>> +/ {
>> +	model = "Kontron i.MX8MM N801X SoM";
>> +	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		/*
>> +		 * There are multiple SoM flavors with different DDR sizes.
>> +		 * The smallest is 1GB. For larger sizes the bootloader will
>> +		 * update the reg property.
>> +		 */
>> +		reg = <0x0 0x40000000 0 0x80000000>;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &uart3;
>> +	};
>> +};
>> +
>> +&A53_0 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_1 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_2 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_3 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&ddrc {
>> +	operating-points-v2 = <&ddrc_opp_table>;
>> +
>> +	ddrc_opp_table: opp-table {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-25M {
>> +			opp-hz = /bits/ 64 <25000000>;
>> +		};
>> +
>> +		opp-100M {
>> +			opp-hz = /bits/ 64 <100000000>;
>> +		};
>> +
>> +		opp-750M {
>> +			opp-hz = /bits/ 64 <750000000>;
>> +		};
>> +	};
> 
> Why is this a board level setting?

It is because currently this is not set at SoC level and all other 
i.MX8MM boards do it at board level. Which doesn't mean it is correct, 
but I don't know any better.

> 
>> +};
>> +
>> +&ecspi1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi1>;
>> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
>> +	status = "okay";
>> +
>> +	spi-flash@0 {
>> +		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
>> +		spi-max-frequency = <80000000>;
>> +		reg = <0>;
>> +	};
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	status = "okay";
>> +
>> +	pmic: pca9450@25 {
> 
> Node name should be generic while label could be specific.  So it should
> be better to name it like:
> 
> 	pca9450: pmic@25

Ok, will change.

Thanks for reviewing!

> 
> Shawn
> 
>> +		compatible = "nxp,pca9450a";
>> +		reg = <0x25>;
>> +		pinctrl-0 = <&pinctrl_pmic>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <0 GPIO_ACTIVE_LOW>;
>> +
>> +		regulators {
>> +			reg_vdd_soc: BUCK1 {
>> +				regulator-name = "BUCK1";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <3125>;
>> +			};
>> +
>> +			reg_vdd_arm: BUCK2 {
>> +				regulator-name = "BUCK2";
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-boot-on;
>> +				regulator-ramp-delay = <3125>;
>> +				nxp,dvs-run-voltage = <950000>;
>> +				nxp,dvs-standby-voltage = <850000>;
>> +			};
>> +
>> +			reg_vdd_dram: BUCK3 {
>> +				regulator-name = "BUCK3";
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_3v3: BUCK4 {
>> +				regulator-name = "BUCK4";
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_1v8: BUCK5 {
>> +				regulator-name = "BUCK5";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_dram: BUCK6 {
>> +				regulator-name = "BUCK6";
>> +				regulator-min-microvolt = <1100000>;
>> +				regulator-max-microvolt = <1100000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_snvs: LDO1 {
>> +				regulator-name = "LDO1";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_snvs: LDO2 {
>> +				regulator-compatible = "ldo2";
>> +				regulator-name = "LDO2";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdda: LDO3 {
>> +				regulator-name = "LDO3";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_phy: LDO4 {
>> +				regulator-name = "LDO4";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_sd: LDO5 {
>> +				regulator-name = "LDO5";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&uart3 { /* console */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart3>;
>> +	status = "okay";
>> +};
>> +
>> +&usdhc1 {
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc1>;
>> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
>> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
>> +	vmmc-supply = <&reg_vdd_3v3>;
>> +	vqmmc-supply = <&reg_vdd_1v8>;
>> +	bus-width = <8>;
>> +	non-removable;
>> +	status = "okay";
>> +};
>> +
>> +&wdog1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_wdog>;
>> +	fsl,ext-reset-output;
>> +	status = "okay";
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl_ecspi1: ecspi1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
>> +			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x82
>> +			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x82
>> +			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c1: i2c1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
>> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
>> +		>;
>> +	};
>> +
>> +	pinctrl_pmic: pmicgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x41
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart3: uart3grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140
>> +			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1: usdhc1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x190
>> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d0
>> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
>> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x190
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x194
>> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d4
>> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
>> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x194
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x196
>> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d6
>> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
>> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x196
>> +		>;
>> +	};
>> +
>> +	pinctrl_wdog: wdoggrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
>> +		>;
>> +	};
>> +};
>> -- 
>> 2.17.1
>>

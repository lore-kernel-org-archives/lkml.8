Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26401C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EA920709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W/sbb7xI";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y1xpWIEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgENFDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:13 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58596 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgENFDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432591; x=1620968591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e4owMMcfdvo5QlqDlb/cAttptD/C5XOUa/sOyzKLlEo=;
  b=W/sbb7xIh7Mnhbjid2/VhDOWm+4A9tdJ89Z2l0bghVnNhPWABLeAnyOI
   H3AzPkPpREE90Umfl5nX0h2L+TC0ru6TeZcImw0vYxBryyUZ/BIjPkLTT
   SWOBWrs12Lqqt668HGwTBsIiwXl3JRv3WjJLxc3rCt3vcyOkOT3j8IRhi
   SgyG5owtRKWJDXPXwjZQ6N4SiNPB0aCJFDBwet94Grxk0c/bMgD5WETVv
   X9+vcK2jNOgfelJ08JiGckF40Hv228vDMWysuTF7nao5uJk/Zw02RTfVn
   y1a7FIcq9oLFgJH4dNRpl6KpyTH+KfJi4GICMtoh+hD0MWiNRfPT3l/xE
   Q==;
IronPort-SDR: psbrwxyIDRj8WwC02FUuk3QDLEjATPoFTI0+ycxR8yBhne+MSY2hS8Q7/85cRLLwZlHsUhDblU
 afgkbiaQqGGnbaa+xV+0hqL8Pfhy5UsQKIoGlGNFEciaTlmGMlwa52A7Ig2vqBuLjj6asIveZB
 zKozwoMZqRlXxfuX4eyO6AX+5rFqoXexCIkcDgR8SM4Hae7pDdBGuVc6NgYgcrQKREa0ctIp4S
 ID5qmzZdClHbolHfd9//PEVpuYoscOhFYsapgXyb/vWXE3Eivk/hD8FIKbM/FC3ErW/1MA6L39
 HOg=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="75847101"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl6X8YyM0pMDEhIMXlI+5Jehxuh4RUTRf9toNDU2dhE4FLyDGc/zYQ5bmCWuU/3KqGI8PJLBcHTz73SEmMTZC3ykKcQYKq0u+GhECc616otIj3C05kIuYQTz9dUPOKX8RZMtw7tFOSvvzyrzoKjX2Oj5Gkh3iwQv/TalwMlygrYYk1tnbnAHbHArNhRHwnrEop7z1SjF4j4pQq5cWZccpvaX7vzTwrSbObbY0oK3wjN9ur3/NK65kYtrF9ibHK7sr7e3jLA+Ai1Fd7cQY2qgJqm3k2yLk2OnKlMMviB11zM3FW2C0ais1ch5zSvT9mGZIljkGyjmSrAxB8bmHlqatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dleEhI5Wp5PoiRCO7Zb7ZATDXKN6zjfTXiIO17oWzBU=;
 b=UbB++Kpc51imUAkWQx1KnaXZwk1u2UmM/sP0MnS9fBjJgc9DH58crHjD0QfifO38NXLlfuNtOouU3anDBLneJYjYEEj1O2o93MtXoeq/qMqXSyS9i1ygOI57qGdBWaunqzDJXTR48HpC0RMCeF4MHDmPTYhQNdXU/BWNV3r39qXvkXZjnRk/5Wz2GLpq5q9zjuNKi1XIIKIuvVGaQJqEW/WNGAHLz9dDP6FCCpR9BTRTNwl3jjxhy4QvQxlbMeO3RnHD6u728PeYEUgDvSlvi63Bx3u+9NcNNDFN8UTlFBBTYYfYf3Nh0VQmViFytRCp9Z1Kh+qnfh1NS7GmFudk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dleEhI5Wp5PoiRCO7Zb7ZATDXKN6zjfTXiIO17oWzBU=;
 b=Y1xpWIEYwUK+eMPkC5e4OtUBoQIhIJXKOlqney8bd/wMvnyM6VDhm93bt10nqeDwG5Sged8LK5j/+CnqYc2+RPpKHSH16bfPT1lHoR1ONWqh0efGpQcPH/W28IcaxUfSGgAs0oIwNZWkOSI4rcSFCAVvMkfI0vcsErPNmPPw4UM=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:08 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 03/16] ARM: dts: at91: sama5d2: Move flx3 definitions in the
 SoC dtsi
Thread-Topic: [PATCH 03/16] ARM: dts: at91: sama5d2: Move flx3 definitions in
 the SoC dtsi
Thread-Index: AQHWKaz1grvF6lJZUE2ad+lZJ9HQCA==
Date:   Thu, 14 May 2020 05:03:08 +0000
Message-ID: <20200514050301.147442-4-tudor.ambarus@microchip.com>
References: <20200514050301.147442-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200514050301.147442-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30913fad-3675-4ea5-3f23-08d7f7c417fa
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4483759C5099554277929344F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRkS7Pjs5g8bVYU7Uciq1XHNRUEG2jIJlcL/NX+aSsvD9QxfMWeABo2wh2rnXZGGQZW4QgFcQk/fo8DnALmKyKmCNLSF8oKsSgtbS2cHyrXUP65zotHxfojwbtTS2IhW7WuT7N3sz/ntZT1eHg8MIu4o5yll8whWtGaVsf0OJjiv9wdHLYFrtPF2fXC+x/AiLRHVY5flwHImzZ6otW6qW9BJJXEyKEcOINnifdjdvwbdiqCVc8M5YR6mls/XtSGVi/D+jT3qgP8Quim5Lxg0LsR5LOXuBOemgxqTGVcDIFrm9G/q3UUut2ds98YENcAvUxs4oRYyf8MLLFGhqhqnaBOZWDsG/5VYBD/6ZRmThEhFssyamC1QkprTxzlgTV6TCR/GhCm0kBGwkPIndzXWyapC2MguEnQZgra6ArHASacDi/MKsVHEqGS1qyvly1zh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: t+NAtaS39XTEWHNjM6tELu6y53JgFrle3Q4WsqTEcnH4QPc2WJlIlwltorqO654P7muTWV/nt+CiEGFe/suikOctfG9QQket2zN/tmQwUjVJX9Ql9NA/nNjeON/DGDRilb/kePhkebAgjL9MI8fb1DwnqzoOP4zgsVKo5DCdK6V5mvJHkFKu7OPP7mt1RYIrOyPhhGiRWJ6YdofQKoF6qNi3n3NX6c62pK3KmTUNvK8cZkZaLY3Lt0vsSWMVcd40En/B71d/kJY+wSvBxRFQFb1raFsdXEmeCtFM0a66ZVhh3gscUIW4+bu4KkT9Yhszek2GlmjsIZ5WpXjjsgOszHMbdpc2DKRvsLhRQMf9ph1Adx4AL7bhPD750if3I3BntZPbFjEVy8eQumLFzID+WfVaZ3vQciAR8kPQcUpNJ9f+bKirzU/gXZyJqmwm2F5D3Ybq6f5PZZDwxfHIH9xxtSBxEWumoiay5sT1Umu2xPs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30913fad-3675-4ea5-3f23-08d7f7c417fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:08.3022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0OkcxZ241PVpHlRYAAiLpSXuuYqKonMGJ708h82JBjlp/4L0heFMqH5NWNuo1C5ZMwYrOKTsu1D32vpQC8l5eYRr0oHOFtRHtcic36owKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The Flexcom IP is part of the sama5d2 SoC. Move the flx3 node together
with its function definitions in sama5d2.dtsi. Boards will just fill
the pins and enable the desired functions.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-kizbox3_common.dtsi  | 13 ---------
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 13 +--------
 arch/arm/boot/dts/at91-sama5d2_icp.dts      |  6 -----
 arch/arm/boot/dts/sama5d2.dtsi              | 29 +++++++++++++++++++++
 4 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts=
/at91-kizbox3_common.dtsi
index ee6f036aa008..4351a8d32225 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -325,21 +325,8 @@
 	status =3D "disabled";
=20
 	uart8: serial@200 {
-		compatible =3D "atmel,at91sam9260-usart";
-		reg =3D <0x200 0x400>;
-		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas =3D <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-			| AT91_XDMAC_DT_PERID(17))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-			| AT91_XDMAC_DT_PERID(18))>;
-		dma-names =3D "tx", "rx";
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 22>;
-		clock-names =3D "usart";
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_flx3_default>;
-		atmel,fifo-size =3D <32>;
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
 		status =3D "disabled";
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index 5f4a7c8725f3..abbf14e29d85 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -179,26 +179,15 @@
 				status =3D "disabled";
=20
 				uart8: serial@200 {
-					compatible =3D "atmel,at91sam9260-usart";
-					reg =3D <0x200 0x200>;
-					interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 22>;
-					clock-names =3D "usart";
+					dmas =3D <0>, <0>;
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx3_default>;
-					atmel,fifo-size =3D <32>;
 					status =3D "disabled"; /* Conflict with isc. */
 				};
=20
 				spi5: spi@400 {
-					compatible =3D "atmel,at91rm9200-spi";
-					reg =3D <0x400 0x200>;
-					interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 22>;
-					clock-names =3D "spi_clk";
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx3_default>;
-					atmel,fifo-size =3D <16>;
 					status =3D "disabled"; /* Conflict with isc. */
 				};
 			};
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at9=
1-sama5d2_icp.dts
index 7216a794f4f6..8a4336e12a60 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -185,14 +185,8 @@
 	status =3D "okay";
=20
 	spi5: spi@400 {
-		compatible =3D "atmel,at91rm9200-spi";
-		reg =3D <0x400 0x200>;
-		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 22>;
-		clock-names =3D "spi_clk";
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_mikrobus1_spi &pinctrl_mikrobus1_spi_cs>;
-		atmel,fifo-size =3D <16>;
 		status =3D "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 5c31e4068eb5..5e84cde8226a 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -804,6 +804,35 @@
 				#size-cells =3D <1>;
 				ranges =3D <0x0 0xfc014000 0x800>;
 				status =3D "disabled";
+
+				uart8: serial@200 {
+					compatible =3D "atmel,at91sam9260-usart";
+					reg =3D <0x200 0x200>;
+					interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 22>;
+					clock-names =3D "usart";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(17))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(18))>;
+					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <32>;
+					status =3D "disabled";
+				};
+
+				spi5: spi@400 {
+					compatible =3D "atmel,at91rm9200-spi";
+					reg =3D <0x400 0x200>;
+					interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 22>;
+					clock-names =3D "spi_clk";
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
 			};
=20
 			flx4: flexcom@fc018000 {
--=20
2.23.0

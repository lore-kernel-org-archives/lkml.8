Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08354C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA33A206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AGiGaikm";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qQWCRN6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgENFDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:16 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35450 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENFDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432590; x=1620968590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LMHIR2ZvJik2tCMcOIxrNZTYzpmdpQwRPiVc717sBtQ=;
  b=AGiGaikm8Pc1uGsH/2Xo0dbfH7AeQXOnURZXgzni5sNHw8VmAq/CnmBL
   0NaQbOTjDhdfdFp3MKWf++oT5OwVH0Dx1AlFQevMKwmrqUVHQel1Gjpny
   bX6qqRvksVeV7zn2jfPkumq+JwsKY1lFy0xNBCfciBU4PQvdAW8qNjxtd
   ZwJJqX8i9TUIihwiPpfUz3jLoJU9ybV22+Jkl239TlcrOfSI+1SRAEdov
   jmOH3/W/SNyo/Ymh9aZtf96SIKtbdrWA4xxmtMIeV1UhERfcSFvluxk4g
   1Pp2pHwT2oJbFunf59MrXoxWExC4R530DitUK1+Yoj4mgMDsilTAAyphG
   Q==;
IronPort-SDR: MDo4I/3aT3ZO+y2EIyR/Azmy91FI6mTaGDm5uh/GTrPgCpYkNfkqU9d82q++CFCRpDexWYbexL
 XtRKSy2aF1O0uEvxI8R8xreplUW4Wdi5eUeWYcdUckEtLL7pOM5Lzf0nBqE6+ybfmhQcyF6rhi
 x/BSk7+ZGapGWybV9/LwUR64aAkzWPavqJdKlsIhc3TkxQCjVskWtDbPJP0SuTI47+HeqxLO+s
 fYdq6RZ/A8QRMa7Mv7dPmfOSzsSy12ci0Y5tJPq91gdeTi9P4A9LfSu0fp/wDQhLyGR1sKBvDe
 y8U=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551077"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP5+WSXXiBPIvCtgzgUYONTXrSj2lOUCMhKmUiJB7sTPq7R/XUiajNJ0ue+PaVlOSQx/tovrWAmLT4sZ/qgH8FwSEnGT5BeXq5Vz/Ocil4QqYuaxiXPooBlYiU2cqi7xwxBCQkIf/rUUd9bP8XBF/0cB4Qjc7pni6TslJOWQbBnf0mYinm9QisXxxwTNLwQ/4HHAYNA0KSAznJrkq6JYUJTJdf+p170hVNww0LyvLWlx7zQG4h4+YXr6nCGWtViIDD7UCFtvz2xWjjyviNimkeFZTlQhUGvDbCSFVgV/va40XEwdpi6wzg2iy5Hd0UVicTVw7MWZhwQjfbJoEndEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu3iskQ5dC8K7NM3PHtQOOdSdq4zAd108OcqWFAslKk=;
 b=ObRSznGgvF/09KgNkrdP4UL0GFkQOwxjrQHfWLF/8pvk3DkiYEt38A1SWlGDM57TYQD91o9s3YF664Jb5w15GGx5q7UOV08OBuej1T955HtVyr6gcWNO6Yw+IISrSCBE7dyfNZSzWBa7Ft6iKi1W+gEmteQ9NyalKWLXSuCw1ZmLG//6KpS+9w/ZB8eyMmI/XtKku2aUYQnwxiDiYWqNVOQEy9m78dwQmDi9zHGN1KwFlMDkbSFMzpJKzh3FSKGb99dou+EU3n92foom43Ai0+IdWyA1iFGeDVhToTftEiLKpu/GUbDr6QauRJvBD+a3jUc5fH/euyCSjz4fxBz7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu3iskQ5dC8K7NM3PHtQOOdSdq4zAd108OcqWFAslKk=;
 b=qQWCRN6qVAH3T4QOns3r9RaUAL0ouho6tHhvFYV+X7JedtdNQoiCx3iDBBQ0Ao0vRp9L04jnlWbNPgSqFSJ99JrOV+WTyH0bdYyX84BxXnR7/HEieOhvd3/X1hxCglwgWpN20hd+xItIQpHRcLWIi+we4VGImOHu+Nwxs16Bde4=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:07 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 02/16] ARM: dts: at91: sama5d2: Move flx4 definitions in the
 SoC dtsi
Thread-Topic: [PATCH 02/16] ARM: dts: at91: sama5d2: Move flx4 definitions in
 the SoC dtsi
Thread-Index: AQHWKaz1398QaMgTekema3AKK9UcsQ==
Date:   Thu, 14 May 2020 05:03:07 +0000
Message-ID: <20200514050301.147442-3-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 5f0d4046-5a83-42a7-5278-08d7f7c417a3
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4483566B11241B7DA4C5EEA9F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IV5Vi/snqzmlJQyHILYmmWKkec0LOAKZm2/T+hdBsS/y02nXYSw2b3Eqqvb5CO9B5OOaV/b2pFbnQ8HVFFZ3w/iJRZeikspkR8Goye98A9X3CzaQxk29SvOFMzppu3HLZywtYufpu+3gnWfP1uvnCInR+r2233l0N/ZXZBAoKiVcPSRbHjjH4pgFDFytgsKAJHtsr8bRwoJ/BdximeL6eiBi8zYL6vJqz9jM4wwctNUB+BrpFwDuORbr7j1QQJfThBYL5mxyFoQ4lalEHnxjLpkES1Nw2z4Nw+mEFeDL3Ar1lcb27j0fwJfHl/p1/TE1l7KEeHmPbDosXKwB9kZFx0WptYkMnvOPEFyO/RfAyVHlyik90h/Q+SnI9dgC3DgAbZitUu6Ehsb33s24c6DXMVSVBro8ySW/8SbfHmMQDNecZF167vvfUZavdDn4cGmb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: z/YQz7Zdi+byyauRHovtHJLcQqbh6GZcKOaL0Bq2XeuVeUplsKAxBQFPARzmTY8mxTdCzHVV+9Jb0bFIy3ylpgQObz7uLamfG5o+Gv9dqJhfO8VBt+KCfSaAPcrnuJ3wXkMSsz32hMTA5j9nrg2N2e7l9blr4vPW86bcluvue4OotgPDd/kmKZ54fubg9mwdt0BXC6zEDf96OmsMumys2v9HA580JqLmezcyIKB2Nli/HUUQRrG6WEI1fM0CarCYTSf5gAHo4RxD3651KCvTjgXMRTSEtNAkBMEoSA4ZRdK7IEDaEHOZprnzdYocmIymTt6WepzPTjR+f93hxGN4Xavp/4E1JwJ03G1+cU7gbZ36X2IJ7W9wkG+ies+ptKmRjChKSlYRF17t+M+YzcYDYeMl2GksWlTIt1wR8xA49qQ2ftR7gHB95PRF75wqvVEHwyEuAxtu4EqCDHYw0lRkhbMgOS3Ypv4WHlyVK2SFBms=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0d4046-5a83-42a7-5278-08d7f7c417a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:07.7285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4akI3K4sr3DvwOVYmv8xsYodqwaHMLNMJHDTws0D+TpubR5z0hE1zDKvESC8iRe/0ufM9ivNN6ZppBp7ZVbjwSsb+IdecxZWQ+7x0wbIMlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The Flexcom IP is part of the sama5d2 SoC. Move the flx0 node together
with its function definitions in sama5d2.dtsi. Boards will just fill
the pins and enable the desired functions.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-kizbox3_common.dtsi  | 14 --------
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 20 -----------
 arch/arm/boot/dts/at91-sama5d2_icp.dts      |  8 -----
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  8 -----
 arch/arm/boot/dts/sama5d2.dtsi              | 40 +++++++++++++++++++++
 5 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts=
/at91-kizbox3_common.dtsi
index d7a6c972bdac..ee6f036aa008 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -351,22 +351,8 @@
 	status =3D "disabled";
=20
 	i2c6: i2c@600 {
-		compatible =3D "atmel,sama5d2-i2c";
-		reg =3D <0x600 0x200>;
-		interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas =3D <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-			| AT91_XDMAC_DT_PERID(19))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-			| AT91_XDMAC_DT_PERID(20))>;
-		dma-names =3D "tx", "rx";
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_flx4_default>;
-		atmel,fifo-size =3D <16>;
 		status =3D "disabled";
 	};
 };
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index d215243fe163..5f4a7c8725f3 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -208,41 +208,21 @@
 				status =3D "okay";
=20
 				uart9: serial@200 {
-					compatible =3D "atmel,at91sam9260-usart";
-					reg =3D <0x200 0x200>;
-					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
-					clock-names =3D "usart";
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
-					atmel,fifo-size =3D <32>;
 					status =3D "disabled"; /* Conflict with spi6 and i2c6. */
 				};
=20
 				spi6: spi@400 {
-					compatible =3D "atmel,at91rm9200-spi";
-					reg =3D <0x400 0x200>;
-					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
-					clock-names =3D "spi_clk";
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_mikrobus_spi &pinctrl_mikrobus1_spi_cs &pinct=
rl_mikrobus2_spi_cs>;
-					atmel,fifo-size =3D <16>;
 					status =3D "okay"; /* Conflict with uart5 and i2c6. */
 				};
=20
 				i2c6: i2c@600 {
-					compatible =3D "atmel,sama5d2-i2c";
-					reg =3D <0x600 0x200>;
-					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas =3D <0>, <0>;
-					dma-names =3D "tx", "rx";
-					#address-cells =3D <1>;
-					#size-cells =3D <0>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
-					atmel,fifo-size =3D <16>;
 					status =3D "disabled"; /* Conflict with uart5 and spi6. */
 				};
 			};
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at9=
1-sama5d2_icp.dts
index 1d9556dbbd63..7216a794f4f6 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -202,17 +202,9 @@
 	status =3D "okay";
=20
 	i2c6: i2c@600 {
-		compatible =3D "atmel,sama5d2-i2c";
-		reg =3D <0x600 0x200>;
-		interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
 		dmas =3D <0>, <0>;
-		dma-names =3D "tx", "rx";
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_flx4_default>;
-		atmel,fifo-size =3D <16>;
 		status =3D "okay";
=20
 		mcp16502@5b {
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index 0666708b05f9..a5046f8257ad 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -378,20 +378,12 @@
 				status =3D "okay";
=20
 				i2c6: i2c@600 {
-					compatible =3D "atmel,sama5d2-i2c";
-					reg =3D <0x600 0x200>;
-					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas =3D <0>, <0>;
-					dma-names =3D "tx", "rx";
-					#address-cells =3D <1>;
-					#size-cells =3D <0>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
 					pinctrl-names =3D "default", "gpio";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
 					pinctrl-1 =3D <&pinctrl_flx4_gpio>;
 					sda-gpios =3D <&pioA PIN_PD12 GPIO_ACTIVE_HIGH>;
 					scl-gpios =3D <&pioA PIN_PD13 GPIO_ACTIVE_HIGH>;
-					atmel,fifo-size =3D <16>;
 					i2c-analog-filter;
 					i2c-digital-filter;
 					i2c-digital-filter-width-ns =3D <35>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index ab550d69db91..5c31e4068eb5 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -814,6 +814,46 @@
 				#size-cells =3D <1>;
 				ranges =3D <0x0 0xfc018000 0x800>;
 				status =3D "disabled";
+
+				uart9: serial@200 {
+					compatible =3D "atmel,at91sam9260-usart";
+					reg =3D <0x200 0x200>;
+					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
+					clock-names =3D "usart";
+					atmel,fifo-size =3D <32>;
+					status =3D "disabled";
+				};
+
+				spi6: spi@400 {
+					compatible =3D "atmel,at91rm9200-spi";
+					reg =3D <0x400 0x200>;
+					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
+					clock-names =3D "spi_clk";
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
+
+				i2c6: i2c@600 {
+					compatible =3D "atmel,sama5d2-i2c";
+					reg =3D <0x600 0x200>;
+					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(19))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(20))>;
+					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
 			};
=20
 			trng@fc01c000 {
--=20
2.23.0

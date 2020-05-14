Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CFBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D408206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K7NPL47G";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PpWh40vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgENFEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:04:04 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35460 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENFDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432597; x=1620968597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=keval8Ak2cI8VNjnqr+OqC+3JhE6d2gAjjERJIPdvrs=;
  b=K7NPL47G0EBQ6GRfSv4N2gp30eJibAWUzCdHpLcF1noSgVN9oQ77lQVz
   F5LU3JaFVp3XBJ2oTy56GFWYuSn65RK7W6E13zRT7zV1ECqRKV3RmyU1n
   w3fX8VtsTah1hi9sHDAUcZQboOmKxavB9E5mqSwqH6UTcqYTJQ4/p6Exu
   SdT0U6JNQ5jKtc+uAxDgqfM9usFtHz1pqcEPSRDyLXwAG2lc4HC0i1S/x
   hegGAA2cBfRn/X13TTgCenGe4d5wJpO37ss9Eb9sFdo8Y7XohKWbxaIES
   gEXgfeK0Jrem7vHJM4yodjZBZTXYweTv9yP9xchWISg28fOvW4ltOg8TU
   A==;
IronPort-SDR: KnDjjge9r/Ql+QAVESPlVeUPPvyAjTivxKbWT32S9H2wTLfl6rlCNEU8YARGH7Iqu6hpoXQdOj
 lZK7I67Hsa/gkbZ/mufHslBPud/Q22ynVdZ09B+MQOtSarYW+Xz4fNuPU2xE4tEplSxT64Y5NB
 6zdT9cQiAVpRWdRRO+rhlTLg0FPIE5+RvMISt/972ILeclaaATLaV32MuTP5tAcAR5XkWCLPxq
 WkUOs99CYmZnvn4T4EP2ofn6h/oT9JSdXrMIko7eNZroJ0rCH3kWaz/iVfPjRScqBIVhc6G1a4
 tVI=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551082"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX3hEux/KZQ8HvKEZkKuLAUoOijNS66kYFtEs1Qs5Do735Aq1BcsJPa1OQUvWobXLdOmsbHVrN+DlhLeN9pc1yc3dMpUpzXBLyxgvH7C/fZF6lQJYw8vnwXQtQSwUa6J1sky4LWI+dUBRCMr6EPAh8EvfhsMckQXJXULaISMjCIsAsINTlTu0ut7O7NbtWWGx7u5bCEyyQK6wLwGbZX7JZBDJaurND5ysE/mKXUrK93cb754gopGBrCawcnlN7z1Yr0ZZDpEMCBvE34IFuLWy9jFTP7Ie6SI4GkT8LUgiLfEQTxzrjPNHqG0rFCgef8FDAkseWsZFECMsPl2LrpTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E5bcvuDkJ0xwx2KwFmsFoAeKEOgmlg1VETpKZbgueE=;
 b=E9q+jqwSkNimJxXXdAVU37Pan0hQTjk4EOWKu80BjFJ0yHBc2zJpgvxN8Q9SX1jMucecHlENohyeNGr9TLsyEvfDdcMTnobW+N5VVcYJ+7HGBDF/ghpQcVdRWoJTHamrosRElPNE0qrCL/KJc4GPpZw3CgsrDngVX7vSEbsqrFPru9Wo4YK5828+WEhVM6KpZl4CGIAZsKQgXu7Km5NOR6NNiG6WsFeIrkSn5rsKvyocki1uGveKOjxcNfjtK0OiESFJAS5rrxyJDDlNPN9/Do4FdhxUhojE+TqNkeu2197z+fdM4UeN+/yARhgDP6PkkpCjgg+pxUSpA5C1EcR5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E5bcvuDkJ0xwx2KwFmsFoAeKEOgmlg1VETpKZbgueE=;
 b=PpWh40vI77C7ZxuQfWbIb0+tZTQWPs7pRvAGdrB9FvTCjKzT+chBOcx8wg3ql/9itKeptq5fQTJagY9nJRPj+/lJfTL7MSNICtnRUUAGaaklIdgWAhlgbkHm9tBcU1638NV6rjCkS1vxe1KAkdgno1zyjUN1jtE25CNGmarRvW8=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:10 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 06/16] ARM: dts: at91: sama5d2: Move flx0 definitions in the
 SoC dtsi
Thread-Topic: [PATCH 06/16] ARM: dts: at91: sama5d2: Move flx0 definitions in
 the SoC dtsi
Thread-Index: AQHWKaz2vPixCxQLeE6hkHQUe+T1JQ==
Date:   Thu, 14 May 2020 05:03:10 +0000
Message-ID: <20200514050301.147442-7-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 8a05ca16-981b-4a12-1a03-08d7f7c41944
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB44837795E6126921C549EA6DF0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZG58cRKPBv8LL2SR1QTeTax3pmPcyc//88nBPriDpFRoMkJOKuFwn+EGNPICGka0t5CcqsmfHnGeBs7R0hlLWa3wlVYqby4s7RhH+1E7ePCV4t28fzFrRmLOgdMeeDzCXDtl0mzjX66QYoulC8koSnZm9okdncV1l4Go6S+euNEg0lDq2qJq1wAlv+HfpsLyGnjsPknKXrxz0IhRRTsPMgalUdhS8afbLGxYzX37i93pHzqUqS9BqawvsiLsCdEgTOwztPBQDnk0kG01ZaT6WbZKRJqCu8PtwrTIfz80EAy3uuYgq2yZiGU9yiGbYIl/v50abNznRn3MdUtM7BYfJlBKVOz0Ku8io9xh1o8CKFM/I3vGsL837Y/v2EWWoM8CfrU/u9P1UVIIMh2TzHdpiGYeXerhgpN8bB+EOFlemOqdH6a+ps+7X2pOEGQ7kFSO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PySiViPLnFm6XxmYacWgFsvzGU2aEL+BPcZaRYK0iWFwkqMLnSk2ZDjWtxB0qL2DBie2XKKY4l0yxYm44VjnPlzAB+MGIfmoO01cS7F1fuf/Z3JilGoPLNrLYPCiBM5W+Qy48oVZefskHioHJ612yt0mw7adlYFoHLCFacijiGDu/2it/n/VRhog+ycTL2IdQ6jJ7XDmXMNOZUwhBYTW+QV/KFTaKtnwdAWHQ+E7MoMtoYA5p74G/JPWHHtePhBSqIxFVE/8g1FD7okrqJ9TPYYUs0ZKBxlX9Z8DYMKxfPMP2RCs8+Ydq5GiPbZAiOPYEDj9Cpi793kdIKjfdx0KUocpeJPuvLNdnR7gFSubIWsQTfaueYv5eXbHzeQ8bqN+KcAF/qR1rX3aE6MzXQxFSYT4sSJl/GWLyjMLMf6ou/nr64nGBdlKW8PUuIkUXdBQSGKW/eecjCp4B1MfSZFn2rAh+9wlOtNaKPVDm4djLA4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a05ca16-981b-4a12-1a03-08d7f7c41944
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:10.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkvfNg+f2a6H74vaaZ6HjCE4GITMgVq9kTCHdmE3dJPmJT+P2Ol9hf9ZQqRi/qsmsHpJqQFELN+1Ac4DQhkIinAy4denGe74Eqia+pM8Qfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The Flexcom IP is part of the sama5d2 SoC. Move the flx0 node together
with its function definitions in sama5d2.dtsi. Boards will just fill
the pins and enable the desired functions.

There is a single functional change in this patch. With the move of the
flx0 uart5 definition in the SoC dtsi, the uart5 from
at91-sama5d27_wlsom1_ek.dts inherits the following optional property:
atmel,fifo-size =3D <32>;
This particular change was tested by Codrin.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Tested-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-kizbox3_common.dtsi    | 13 ------
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 12 ------
 arch/arm/boot/dts/at91-sama5d2_icp.dts        |  6 ---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |  7 ----
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |  7 +---
 arch/arm/boot/dts/sama5d2.dtsi                | 40 +++++++++++++++++++
 6 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts=
/at91-kizbox3_common.dtsi
index 4351a8d32225..7c3076e245ef 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -299,21 +299,8 @@
 	status =3D "disabled";
=20
 	uart5: serial@200  {
-		compatible =3D "atmel,at91sam9260-usart";
-		reg =3D <0x200 0x400>;
-		interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas =3D <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-			| AT91_XDMAC_DT_PERID(11))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-			| AT91_XDMAC_DT_PERID(12))>;
-		dma-names =3D "tx", "rx";
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
-		clock-names =3D "usart";
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_flx0_default>;
-		atmel,fifo-size =3D <32>;
 		atmel,use-dma-rx;
 		atmel,use-dma-tx;
 		status =3D "disabled";
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/=
dts/at91-sama5d27_wlsom1_ek.dts
index 6b8461278950..6b38fa3f5568 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -77,18 +77,6 @@
 	status =3D "okay";
=20
 	uart5: serial@200 {
-		compatible =3D "atmel,at91sam9260-usart";
-		reg =3D <0x200 0x200>;
-		interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas =3D <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(11))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(12))>;
-		dma-names =3D "tx", "rx";
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
-		clock-names =3D "usart";
 		pinctrl-0 =3D <&pinctrl_flx0_default>;
 		pinctrl-names =3D "default";
 		atmel,use-dma-rx;
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at9=
1-sama5d2_icp.dts
index 23f413afb333..4a01ab8e7e70 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -105,15 +105,9 @@
 	status =3D "okay";
=20
 	spi2: spi@400 {
-		compatible =3D "atmel,at91rm9200-spi";
-		reg =3D <0x400 0x200>;
-		interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
-		clock-names =3D "spi_clk";
 		cs-gpios =3D <&pioA PIN_PC0 GPIO_ACTIVE_LOW>;
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_mikrobus2_spi &pinctrl_ksz_spi_cs>;
-		atmel,fifo-size =3D <16>;
 		status =3D "okay";
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/=
at91-sama5d2_ptc_ek.dts
index 32435ce1dab2..8ad3a9c6c536 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -191,20 +191,13 @@
 				status =3D "okay";
=20
 				i2c2: i2c@600 {
-					compatible =3D "atmel,sama5d2-i2c";
-					reg =3D <0x600 0x200>;
-					interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas =3D <0>, <0>;
 					dma-names =3D "tx", "rx";
-					#address-cells =3D <1>;
-					#size-cells =3D <0>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
 					pinctrl-names =3D "default", "gpio";
 					pinctrl-0 =3D <&pinctrl_flx0_default>;
 					pinctrl-1 =3D <&pinctrl_flx0_gpio>;
 					sda-gpios =3D <&pioA PIN_PB28 GPIO_ACTIVE_HIGH>;
 					scl-gpios =3D <&pioA PIN_PB29 GPIO_ACTIVE_HIGH>;
-					atmel,fifo-size =3D <16>;
 					status =3D "okay";
 				};
 			};
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index a5046f8257ad..da4442715ea5 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -327,14 +327,9 @@
 				status =3D "disabled"; /* conflict with ISC_D2 & ISC_D3 data pins */
=20
 				uart5: serial@200 {
-					compatible =3D "atmel,at91sam9260-usart";
-					reg =3D <0x200 0x200>;
-					interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
-					clock-names =3D "usart";
+					dmas =3D <0>, <0>;
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx0_default>;
-					atmel,fifo-size =3D <32>;
 					status =3D "okay";
 				};
 			};
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 79ed7bd02df6..acb91908bd74 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -635,6 +635,46 @@
 				#size-cells =3D <1>;
 				ranges =3D <0x0 0xf8034000 0x800>;
 				status =3D "disabled";
+
+				uart5: serial@200 {
+					compatible =3D "atmel,at91sam9260-usart";
+					reg =3D <0x200 0x200>;
+					interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
+					clock-names =3D "usart";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(11))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(12))>;
+					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <32>;
+					status =3D "disabled";
+				};
+
+				spi2: spi@400 {
+					compatible =3D "atmel,at91rm9200-spi";
+					reg =3D <0x400 0x200>;
+					interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
+					clock-names =3D "spi_clk";
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
+
+				i2c2: i2c@600 {
+					compatible =3D "atmel,sama5d2-i2c";
+					reg =3D <0x600 0x200>;
+					interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
 			};
=20
 			flx1: flexcom@f8038000 {
--=20
2.23.0

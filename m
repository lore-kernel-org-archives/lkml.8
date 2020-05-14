Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30612C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18144206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qwzr+7U9";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CfLQzLX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgENFEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:04:15 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35441 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgENFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432591; x=1620968591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uwKEtD8/jRPYcbdZfaS8zSHNukwdI+nicX5PxlTfCl0=;
  b=Qwzr+7U9X7K24LhmtaUE8wS4Lec4Je+vc7THj0Gne9A5XQCL7dgnVWeH
   il1c8+Kqvdi6PzqTekmwpwTucWUC4CItyZcRVYpfUNVfPv+2JnwNzgROy
   l9FNqHIcEA0rSofk1mB8POvnIO6plR5L1wssq1ctrhi/XKKQOLN75eX6x
   X8JopbtJJZRCPlHCBBUIcrxmPY8KfpsRKvfB8dkZoKHFWtRGcyY6xXSxD
   Vyb5tSNbc361dkz+QzTjtGDaq1Y/JaE9GP4Dk6jOEZW8SpTUt6lfZP5HG
   /B7kMOnEXBX3FUB2iUCVQnIbuhOeuNcecO7A4H7r7yi6TE5d8GjrcgNeV
   Q==;
IronPort-SDR: nJz0MLT5Xq+oh0PO2Hi/+DskEDFrqbtVfDe7MjzS8x4bwYwN7ACJCeatUFPJVlPV4NBExVqY+R
 pUHInAlMVyKSM9OFvIW/M5/Pv6eUQ3GO8euHBN5HcHm9L+dIungJmQQarmFviUrrvDVXwk8ggd
 ZRbGqGHJUw+RwDurL6b4CU683rPctmEWxg758xx6h4j5Ar6MjNneOdKNnC3g19DwCT4q/VWuXI
 EsR2Pgw14eIu0v1M7IZLSEXBruw3FSTcOSVNicWE4MP4GBYiUnyYH4u1DIB7Nq7SI/csvhVywd
 Y6U=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551080"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDbhdtpA5xxFtwqp3T8T1Qt9RHRPrPSfUuNkIMQNJ56aZXtGVEhi+5DXKYUjpU68TdfcqO90VUXrj2cG3RNh63v1DhcqFcBaLylFF9GfRlJedaiLVRmYA2KT1n9w0d57VNW0+qyD3ih7TONajYvIFQ46ICbT5LQ4QULSyjv9MmfWZyUZb7SqG9Os1mv/lEYqAaATW4vtHSMhGnGVHOjXpZwbOEh7LQ0fyH3dUApIZXVOriNRxvPH+GWkmlF0ScxHjstF9KDHkXnH1WOUkO3gTCWL4NcqPGFISR6jqLNT1RnrtNV2YqSXJfK+f8LeydmLhZkgWw9yVYW+vEo4BNaUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj76Nd280d+F00QW7LmSHt+TBxuC6yQmfWgNj7ec0AI=;
 b=jCUmLyljMvOq4Bl2rmXcOdhz2UjbZVAZjZ5avsP1sK9/EScyJMwogYvZBszoXEMwaKKkqIlRpMCuRQvv7ScFVzU/i6ZV4CFBrI9gLb0sQpJm65me56n4deJd8uvr+ESkUYnkLlDibaozCHzdIJp1vtIHioVhb3iahp5Q7A/gc4MVDyao2nUcfwz/ttr1UdNbKpER7sKOvS0x16nYCXJ2ZAQ0TfPv8VhHGY4Ozcn1n5ROs1kWIEHrM7SUcIFnWWSq6cG1CJ342jOjMuowz+ItNFt76RwN/Irnihipii7Y/NI+KRsu+4erAuaHvrtqa09Yz9LXc5q03Lik9QxRXEVpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj76Nd280d+F00QW7LmSHt+TBxuC6yQmfWgNj7ec0AI=;
 b=CfLQzLX2y18hXACRwmpDQstBvq0g4eWW9VIXpa8njYeP5GdTS/253wEYCGD+YsTn6F1F7rWIoPg0hClHFbNnNFQSiVAEXCHFaV5qR7mzpaGU0ohHaxIcFC+w75TuAJkDi3eN2fDGQ9C8/UD/VxYryaB7g/dH+51OX/94Mgltwbo=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:09 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 05/16] ARM: dts: at91: sama5d2: Move flx1 definitions in the
 SoC dtsi
Thread-Topic: [PATCH 05/16] ARM: dts: at91: sama5d2: Move flx1 definitions in
 the SoC dtsi
Thread-Index: AQHWKaz2EBruUKsjvkCe6lIEn8yUnA==
Date:   Thu, 14 May 2020 05:03:09 +0000
Message-ID: <20200514050301.147442-6-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 5c59111f-d2eb-4a0d-9c2e-08d7f7c418cd
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB448314E897F63F05DDE065B9F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pK5Dox+1/80E5H6JLHR9R3S1B+0XPRzYMkzN8N1D9p+FXweFeIifTnpqDUNCLVL1w7TJ9+TOlTJJnwJco3J7Qv0Htr94CWkPgMHVt5dFLdzNhMhgNufQRZZSUYEvKr0Hxu6Y+zazw2XTEioAWt10aWpWAP+5OlyNkRFzcRsx7GjVvC26FNhxSsnt92GbTuv5T95OCAbPc770qsq5td8AoKtdNxNF6aPxCP7vzfhywVelJwQHM38u04ZGNf78w5eoimavSPBdOtyF6Rd226YNc138ZCun4tO2uTmtpIzx0z41JQ8003z43HcRrhoMh6gpE3SrXxwVVLA2gZIC2LWjYlsyihub/U8cYad54gAlYj9xsJFw7tCUf7ZiNW7Xcj9cakIUqgvC9DTpeXOnElOsN+6Z3vjeYyUL41WXFn3iBkex1xT+y/xjDqi3MxPIJffz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zaJHXW0GCur6fyqDiBzbeb+o6of5zpe+04+yUumHArpCbfFGamlW59wJQI210+TrlsoeDGD8CyVg/ihMXkBn+cPtjL+vqYUo1jS+6pLieUSzGmLDKTV9KSsVYiacTJ4Q3fEjdut4bfpBlk5vEZ1rV+sDtMQDRjTpvSKx7jC/Qh6b2hc9ltG/jefHBEptIkJBtYb4dHKw09vW5OcEkoNDOb8jZvUzTLUS1Whp8umR78hQo+lq4BYzXt0IK1oHtr5GkZ2XCn6+SYk5LoamBrGNS0xrfoe9pC9bTMxAX6SB5U8YSMQBaGH4tqtsYzM9043zDshvxl8lWMMa+6dzeuh0+3BcTqNQ1bvuDCjY4zQBN3U0m534Wlttv3dLViZKCVwmHgJ1Q5ZvyrqTd2gZQ1qQFrxrgYuarlkTLzviCxXAf3mbNtRYTdgFSB96amQKcyvOAuF3aePifbEIAKgTMhjsNn/fioW+TFSVagFrPf8Y0C8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c59111f-d2eb-4a0d-9c2e-08d7f7c418cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:09.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmEnrkcp2tFguz+iv1AJjqsTM+uHO3Y7Zg6ys200uopLAqE8/XOHlZ2FbmsFLgy7TGxmfdsGFfm4U6TaOhaIzznzCF26tySZLUtqDHZFDWE=
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
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  7 -----
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 12 ---------
 arch/arm/boot/dts/sama5d2.dtsi              | 29 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index abbf14e29d85..a0deff15fb9a 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -126,20 +126,13 @@
 				status =3D "okay";
=20
 				i2c3: i2c@600 {
-					compatible =3D "atmel,sama5d2-i2c";
-					reg =3D <0x600 0x200>;
-					interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas =3D <0>, <0>;
 					dma-names =3D "tx", "rx";
 					i2c-analog-filter;
 					i2c-digital-filter;
 					i2c-digital-filter-width-ns =3D <35>;
-					#address-cells =3D <1>;
-					#size-cells =3D <0>;
-					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>;
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_mikrobus_i2c>;
-					atmel,fifo-size =3D <16>;
 					status =3D "okay";
 				};
 			};
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dt=
s/at91-sama5d27_wlsom1.dtsi
index bea3d60b9722..a06700e53e4c 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -36,18 +36,6 @@
 	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_USART>;
=20
 	uart6: serial@200 {
-		compatible =3D "atmel,at91sam9260-usart";
-		reg =3D <0x200 0x200>;
-		interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas =3D <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(13))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(14))>;
-		dma-names =3D "tx", "rx";
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>;
-		clock-names =3D "usart";
 		pinctrl-0 =3D <&pinctrl_flx1_default>;
 		pinctrl-names =3D "default";
 	};
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 89064225e9aa..79ed7bd02df6 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -645,6 +645,35 @@
 				#size-cells =3D <1>;
 				ranges =3D <0x0 0xf8038000 0x800>;
 				status =3D "disabled";
+
+				uart6: serial@200 {
+					compatible =3D "atmel,at91sam9260-usart";
+					reg =3D <0x200 0x200>;
+					interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>;
+					clock-names =3D "usart";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(13))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(14))>;
+					dma-names =3D "tx", "rx";
+					status =3D "disabled";
+				};
+
+				i2c3: i2c@600 {
+					compatible =3D "atmel,sama5d2-i2c";
+					reg =3D <0x600 0x200>;
+					interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>;
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
 			};
=20
 			securam: sram@f8044000 {
--=20
2.23.0

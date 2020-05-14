Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C663C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26279206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f35g8XrZ";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LM/kEw1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgENFDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:47 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58596 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgENFDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432603; x=1620968603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=REUmqZhkVMIJperpWE96I9V7VPdHvJoOefpTDdgxed0=;
  b=f35g8XrZuNGL133LXv71aRCiop6HPUivHoYLl/LK0UDIhZzlZ6QIkvAn
   b6zU9tzlt6w3+RbSMp939PltmJs9jI/4YkTiZh2wO/aJiZTyf4nAD74fM
   9AJ1i3FnpMOkP1ehIVOKm0iqjj1QWK/vDow1V6j77d5qp3ils3CoeEfvd
   1jCl2+xVB/KhRsjs+C0GRNdb2zJQo7W0e6mhQ41VoQBl+ziAQ1xZQ2KVZ
   muaTE4YtwlRmm3gJs+RTeS+Xg5CxipvFRUCH+OtwjD9fH455dpI2kPWlO
   N2i4CW9zDB2klx80BfMLG8YcgKCSZontUfKhH4Znrkfhgsn66+IEIjECP
   w==;
IronPort-SDR: IyHfnBJpdBcmdAPy1svuOxG6qgDFgbelPd1aPQ4buDadop+5aUYe0vh0LHkCr5v+Q3Wyrn53Ff
 wUklHYPHr588MR+9osOZ8v3jhCR2a0pvH5w5b97D89ZZUE/t9ldvLavpXohYhlyG9IYsIj1/Ff
 CT9z3gg0kc0K3yqTxTR6WhKzYtL4oSa0CpXdSAGlKyIMwTodhG3INdZJJ1vE/QsOTSxr2LVexj
 LyyYOS0lyVgNiok7mTKDgGIeP9YlEPCmxOhKgibhEgkQ4yft4qdutAwIltk8FsqkbC/nX8OEr/
 Cmw=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="75847121"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 May 2020 22:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb1KkA+P2e9Bmmx58dBJan5D6dcYbmSoKM2i1pxUtBcpmy7thQEWB65HDzpfdzWj5TcRsFgUTS8M7ZNj8+9BiU1TZCQSWH1BrTP0oyJwc5YhQfQ2GsVtYiBUZgZvegbmLMd74EaaEXzgoauQG3U3L0K8TY5Majv8Yx4TFZUFSPvx2yvSmWZMQkDPTjAPIOl2ZYB+u9BfMDHyzKsgUQdqoh2O1b6hRDhk24uwgoQh5PSAhkqYdUJgcb4lsKBAJDhVenm/E6SYQubCzxDIEyJV66gSDIIeiUrz4wpprpC+2beomWqJGv3vuB4kAncOK8d44/Q+3MALaO3UqPBHOgrmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUf5vY2DEWA5d6EMO3qdaoT8QSIevx1l771TJTwJ4Mw=;
 b=Ggiuu1bu/st4p7ku2JqxG6fChlW+W6OZIXLZFVqxVnSA/jsvNBoyh7lOH3LyBrXvZjPVx7IzcV3KitOOmE7v3vW79T49Ps1eR/ZLgsrlgqC56aUZpji5S6jeMwCCDxtB2krUiqFLElfGA1PxVCpA5HyfERDgKC/sKV0B+VCubowf31jD73DTXVvtoAUjC/ffc5YcImG8FtpHPEViJatPOzeHIcrTR6dwCANiNzQ7flhkWyvrtrbTRVJ6ZrqiupxpVQpL9f424zjpEzpK71SOTKZ7ZtOrZR0yR/EqzvFZfjr3ySb+a7QzQvEamKAkjf6p5Dn9FuW2Qy25qZdnrWLTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUf5vY2DEWA5d6EMO3qdaoT8QSIevx1l771TJTwJ4Mw=;
 b=LM/kEw1Fl0pjSJJ13KgisuI5MIs5NMhqkpFDRkId467BP9P7X6NBXFJqFHwjWjZUgmjmSG3jOh6nexDn7sotClFk7YXGQA+yUHpswTfM0XYEbnpK8WApIMMMwqO1bHCDkDbNnaYQafAe9rMIJo0n3SIu09ab/ri7o14MNuQqRb4=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4040.namprd11.prod.outlook.com (2603:10b6:a03:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 05:03:15 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 12/16] ARM: dts: at91: sama5d2: Add missing flexcom
 definitions
Thread-Topic: [PATCH 12/16] ARM: dts: at91: sama5d2: Add missing flexcom
 definitions
Thread-Index: AQHWKaz5XueFWLPwRk6ZXAr8TP7nXw==
Date:   Thu, 14 May 2020 05:03:15 +0000
Message-ID: <20200514050301.147442-13-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 522b823b-c50d-447b-2060-08d7f7c41c2e
x-ms-traffictypediagnostic: BY5PR11MB4040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB40404BD7C3250B90C0EDF05DF0BC0@BY5PR11MB4040.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6CsCvL6b+OQmUJjyPRwveBhoZ1UIGPJEldL27Jlpf+EwW6zXCywDba5yHiNXY+LbUKgsOvzobHPXwiRqYuW+Z2XFrFex19F2xnKo4F7qxB06kvJQKzCw9dqkdgjT1nUQZE4NKbriOFd9E7oYptiH8TaZvhO4Kr0QW5tJIZ2N3D1MeJKeYer2i+MsBbR9Bh/kHqgiXJhj/+NZfmgORqIXbOkUOa5W5UNqLiqIrCxKdYcvflWiISG6qP8HDDb/X4mbv+igwKxZ+ZucNVRgcxAmJMF5eoZl6KjbBF7CFJey4h6fqDR4f26H4USGtSvLvgY/VR2WVFiqxmdasxkc2W4de1XbOEUvXbGY7xlpeaOZ9IFCwbnyLFvx44aXxXapHmlJ5uNVAOh/w05QfzjAmOGU03iS5dXQb7ZvmC3OPHT9GR9+HVGHFNNRxkUV2pNGk1CA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(39860400002)(346002)(136003)(186003)(8936002)(36756003)(6512007)(5660300002)(66476007)(316002)(66446008)(66556008)(6636002)(110136005)(4326008)(54906003)(8676002)(1076003)(2616005)(64756008)(107886003)(66946007)(26005)(86362001)(6506007)(76116006)(478600001)(6486002)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Prj3KiDBk7gCdAogjzFFYpIjko2PUeo/f96M/CTMF1+UZ+MmHuRu0RLk1Hrmocan9G6dDqY41ql+Jkc/qSKW78ZMZvjF2ktBzhyEdOD/4XrlrTcTKwYV8cHdfPvaGcWPdzh0ZdODsMm4MP5pvfOGMf56x7GUERsdQhGf8PoZHu4w4TtaG02L7oKW59SjEPab7yVsvDQBCx2qU6f/RjYWHWOWu7dQVURKQOkcpY8WowueD2k+TCO0i2+KNowz5gTLs8sGt/QLEntaqKYQzAj06EVqUkVu9dpw4rgbHCsTlWds9n7BCkJ58vPgogWGqmgUy6HGNu0Ol6Z4IVuk1ke/3f8k7Jkii51tN66K//zrT49axzwetGWKD69BMZ0TJQYt/GNdCtZ29zf17FuakdOQ+GSN73BqM6/JMT4xhNv0ZxnGA29WbHUrSLkfEgY8fotwrSks3eDhEIUIfjnx+y/pq/66woG/XEW1KU87iBxBE0KrBhlDrOzIpr4yKol+9yw6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 522b823b-c50d-447b-2060-08d7f7c41c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:15.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PT1bvCVJ5mCMrPdwhszdbdiSt7czoPYMoXe4pzOHAmTJ0PSOVkEnWY8cVPlP0s+oCpfaEeRWoP+Eqi8l1CPZ8btKcXnQ4tzsBmQE4AXJjOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Describe all the flexcom functions for all the flexcom nodes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 79 ++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 5bba8024f485..b8cdeedee6bc 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -723,6 +723,25 @@
 					status =3D "disabled";
 				};
=20
+				spi3: spi@400 {
+					compatible =3D "atmel,at91rm9200-spi";
+					reg =3D <0x400 0x200>;
+					interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>;
+					clock-names =3D "spi_clk";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(13))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(14))>;
+					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
+
 				i2c3: i2c@600 {
 					compatible =3D "atmel,sama5d2-i2c";
 					reg =3D <0x600 0x200>;
@@ -910,6 +929,45 @@
 					atmel,fifo-size =3D <32>;
 					status =3D "disabled";
 				};
+
+				spi4: spi@400 {
+					compatible =3D "atmel,at91rm9200-spi";
+					reg =3D <0x400 0x200>;
+					interrupts =3D <21 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 21>;
+					clock-names =3D "spi_clk";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(15))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(16))>;
+					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
+
+				i2c4: i2c@600 {
+					compatible =3D "atmel,sama5d2-i2c";
+					reg =3D <0x600 0x200>;
+					interrupts =3D <21 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 21>;
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(15))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(16))>;
+					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
 			};
=20
 			flx3: flexcom@fc014000 {
@@ -958,6 +1016,27 @@
 					atmel,fifo-size =3D <16>;
 					status =3D "disabled";
 				};
+
+				i2c5: i2c@600 {
+					compatible =3D "atmel,sama5d2-i2c";
+					reg =3D <0x600 0x200>;
+					interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 22>;
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(17))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(18))>;
+					dma-names =3D "tx", "rx";
+					atmel,fifo-size =3D <16>;
+					status =3D "disabled";
+				};
+
 			};
=20
 			flx4: flexcom@fc018000 {
--=20
2.23.0

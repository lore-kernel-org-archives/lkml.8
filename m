Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C179C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01603206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CRF7rfR/";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vhAORx2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgENFEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:04:01 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35465 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgENFDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432598; x=1620968598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UEAFtwaIJrplZiQG5jKU8foi+hArmZTQqw9UX1gy3Yk=;
  b=CRF7rfR/k+Nz1NobQvs4oK650mlewPHjmuDOkA9NnXyVPH1lel4pBcz9
   tpJqnU2Fmp/IxPwloCd8/PAIUL6KfC2SdBx3xA4rbPr03ia6TIk3DTEZB
   Vf3FQScExANU02cLkvzonTGFIaRT3aPWoa9fvDNEweM7y48RFhJ+QGCke
   gIzGBQPQoLB+9I89XT898i2/mtt0xvxAiZybelACNr0J/gT4LmUfUllIb
   ZV/BWxRYv9+NFUAU5Y7uddzbZ+Xz3kCgwbWBlcfaaewxMNM5e1SWNOJvy
   x+0ess5pN3bsDoGM2vyViPTHtisaJw9XXVMZrIoyfhq4oOzXpyB2D31+x
   Q==;
IronPort-SDR: zw+cSl6v/2S0eyvRggZRQNKfwLTw8RypxxUZkJtndG8DQJ6u+1IVL009iclN859qKdZfNmeNX5
 22E+Ee3d4MOEgVcgOGefu2d0vrP882iBKx1b0Uxw4pp07wEBoIywkM0GovahOz1ITEZBleOplC
 Z/k/J2TXEqFvWBj253Q5HV44S3mJrScZmzoRFtUizF1pYnmYhEMFVlaL5rPsxfg3jCLbtLFA58
 hjhzQn3oqAQE0kcwllJ9hEw6yFtYkl6kFf5Y1k3wGji7FS3iOIJdTrFGN054SEbPYMD19Hh6sb
 vsQ=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551092"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS8geOli02rygJPnpP5p0ojwnl5nOHlCbZaJXkVSUivzlpuTXztLvfn1CF/VolBak+mg2mi1tIMjSyfaOUFnJ9Iy56v2CpNEHY/nHnJH4gfGDt1yQja8DNlcg1N34SByC3oGdT8/+J+6tFFKQriywfGqpPPIU3K1b1DtqtHE+Ph6Xgs7QFMH6OeWeWCEZ6g/X3UZWlFHcPItoVPzWpxQC3yA1OTYvSqz+6NeiBRz/0T8x4XQTq1+Oy9c66R/dzzi8o8VCFo+8fpaO1zrjyRATXnF3rScWUIambVUapQ/mRXaKc1LLvR9JuTysrv7bImcZdfepkIXXx/0m8adAug9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBdbe0U4zpNmbLKIuTuN3e0DRmi1aSerJSXH1pbSK1M=;
 b=mYgWA65eEb1+br3KARTgYnRIhBu0ZwskWPYKDZR417+o/yb0PJfJmV0tAg3XhgBoWNyMb5tsY5RmgtVmp0NqfUscUUh+GFkkIq8Yej1E/2VYjV/MpjMbMW0libS5Pr3AN36kCmIZZzZdojKtTRjFjgtiMcGFK0A57buLJ4NOWLIxf500QoVOHb0ErGJnmt9cOvUIrwNVuqiprWptHt56xegNjUDuMuyF+RcZE57LuA1LvJhxA2MtIpLO5I0fzuBpehtjn/rs0CC2l2HkRjazaJGM5hEc5VRz9zE2JS9CpPjaPWQ/xo5ZnmLLhel4cO3s6NbVTASQenIY+P7rJ+1aYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBdbe0U4zpNmbLKIuTuN3e0DRmi1aSerJSXH1pbSK1M=;
 b=vhAORx2oEiyYk12QWsT+PZL7AHgl69fAkpkkz2oYlbuAEVWPaa9hIdewwWnw94JDGRCoqJQqlGCmTxlbFvCi5q3Hr2BsafQpmoZ397RZlVWU8YmMYF1iQY+CVL/EQXlO1BVc7B1TOUFpp2eUYxkBCT/i9PfXyJ0MR40kwiN3Ul0=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:12 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 08/16] ARM: dts: at91: sama5d2: Add DMA bindings for the SPI
 and UART flx4 functions
Thread-Topic: [PATCH 08/16] ARM: dts: at91: sama5d2: Add DMA bindings for the
 SPI and UART flx4 functions
Thread-Index: AQHWKaz3X6V0ap5Ns0uiIyl1zvqZWg==
Date:   Thu, 14 May 2020 05:03:12 +0000
Message-ID: <20200514050301.147442-9-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 6c2072aa-a530-4403-76f8-08d7f7c41a54
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB448303FD676F8A58DF1A5E64F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CBX8tNyhEU/U4q1THy77w4vTQ6Dcb+RES4fK/AZ6/Y09dYgXcOq/LDObU7qBT4ZZ5X2hpMlAt7d2H5RUwD01mvHabUI9TbhcsuPfnDNSx8DjMmvnnU3QdZsnJKx3iScbpVZdt+H3HhvrSl5wQCYuUGwMg34Y8TMpiXiInAsVBlfvHhVfmPsf/obbma3YuOTwFCFdK/XtcB3IaRUwsQNMhZmht88Zh2qkwWmU5DaAFQeByAWtE2a92g9rlxo7LGvmfrRwccjdAhlgHzV4Ksr2zGZ0/OjaTfonoySrSPhAqSASC3vT/udIQNjgYS3Kmm6BkNyO0JdFQrHwtUKM5H4LcT2OGlm2/eDVF0R/RA27bMI/KiXYWsZkvxU9NGNCN1tpE5t0FpoVPv1c4/8HEor/PXu4YFY7EaEnw6bCSlFMAD/mXSblTJyKzsSp5Lql3T8d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7Ihgh+74K5wB5k7aS29l9kKKIIX4XxCuLRG5Fzz3vZOcRZ0PUokS9LI6qjbu5jWSt74jxT5HdU6MHzZ9Sx5EEi7ywvZgxswyqkDe3Mc0t6+35zszoCnbkzVAoTaHPXPAA0FZ+rJjr7SL3T0kcsBjo2XaqZpQ8UzL8KOm3UpYHg2D2HLjCmteieYfiqOXXTV69eun6VFWkOy4SOecxhu/dDXmDw9ovas/wzzts96+aXyMoYpCbp3DVKPRnzzUSZz9Qhu6atvOrrLQ/60d2ApB+4eq+hmTj5PvMJbKhX4Oe5sVKntjuT0vHb0ggzvJAww1JQFaJMthHwc0olImpZwrH2zXf4PeWSfxw3t0XsM+Fhh9ad816J6qOf6roenuM3MSK+T+e2ML5Wbw9pvaYL4L76Br/cjo371AaLV3hPUbrXOwTRy69V7RC55PVWYbsRa6z03yKGgAx61/bJbAlBfapJQxeSn7KrBbzQ8GtecIkcznoUeI1ejcEZbWmr191crM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2072aa-a530-4403-76f8-08d7f7c41a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:12.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeU/idwkBMKIxzC3T/liXlYAYQk/KPZpTx+Si7DwZ+jfjseQZt9zXVaKCKWHMP234qunouc/vyjIzIawX6Pn6vp2v88x4ni8DXatM0zG/S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Spare boards of duplicating the DMA bindings. Describe the flx4
DMA bindings in the SoC dtsi. Users that don't want to use DMA
for their flexcom functions have to overwrite the flexcom DMA
bindings in their board device tree.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  2 ++
 arch/arm/boot/dts/sama5d2.dtsi              | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index a0deff15fb9a..6ad66d034305 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -190,12 +190,14 @@
 				status =3D "okay";
=20
 				uart9: serial@200 {
+					dmas =3D <0>, <0>;
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
 					status =3D "disabled"; /* Conflict with spi6 and i2c6. */
 				};
=20
 				spi6: spi@400 {
+					dmas =3D <0>, <0>;
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_mikrobus_spi &pinctrl_mikrobus1_spi_cs &pinct=
rl_mikrobus2_spi_cs>;
 					status =3D "okay"; /* Conflict with uart5 and i2c6. */
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index dde969a140b4..66aa8d6502d3 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -939,6 +939,15 @@
 					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
 					clock-names =3D "usart";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(19))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(20))>;
+					dma-names =3D "tx", "rx";
 					atmel,fifo-size =3D <32>;
 					status =3D "disabled";
 				};
@@ -949,6 +958,15 @@
 					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>;
 					clock-names =3D "spi_clk";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(19))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(20))>;
+					dma-names =3D "tx", "rx";
 					atmel,fifo-size =3D <16>;
 					status =3D "disabled";
 				};
--=20
2.23.0

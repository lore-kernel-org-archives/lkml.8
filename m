Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39ACC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F9C20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pydcc09b";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dS5mMcvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgENFES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:04:18 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:29756 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432591; x=1620968591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YF3g4adybpZHdlqXEtGY+uuRZSmAEWghP4WxB917IGM=;
  b=pydcc09bI0w2Lfu58ZTlYSZH0V9ZqKYMWWNT7a/ofVCDw0S9X2fLu0VO
   bnQN53i7Z0nexXzdY/OexQHWi9m0iq1EEyH4vrSXE2nxS5msYihFIrFfY
   nFxGbhyvg7+XMYkDQdfE9F4rjtWE6TANI4geeacobVO/Ep9fUJ+tC74VG
   E3jNhc2M7cK/HbppnPyV0JpBH9yoOCGhn5GRsoJDR7/JGWJVoSbV19AfI
   7oiIAheNIkD5IaR2rzQqOPofnv0fkzt+Aj7XdKfbZ7LuKn/0iRhI31Pzw
   XI9bTPlWuKs55ebbWVCxabPiVqqPED+HR6mysIysybwt2Sp7KRtrZ2IR+
   w==;
IronPort-SDR: Lf6PugSVODdn6tQddiivnCB6doNGTa7FK0SK07LbRP0FjvcRHwHzwmcuaFCIrUnvYXMqkmRsTp
 qhudlIwdmFNAm8lpAVMewkyI1b+mmZMSLqpChjbnE6jT2uYXdwDmpBBZ3WhZDB5stLJAegD3S3
 +B1Fq35//UjWdtiMhj/gG68LLjP+S8nivE6rOyh9UazE+BfKERjnzSPYmVOSor19qGE5ooDUnS
 jTlynNLRhFbAMez7vowk//ReGXN6finFt1ttFzrcBoxPUVet8XvDCwC5XpA3UFO0VGHtcJ1fT8
 U+M=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="75222005"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2+NSNfqAroqn4LnOYiYMxr+q84SIjYhsDXRijBgEqwKRGkExv6gbnfoUcY7A7jr7cczjp7AsETbpouEBzTRqqqonM0yDrMjOHuvwoB+BJNCBUSuwRm1XNOi1K1aGlIFSS3cfjfNavJfeNJUFbZK0gg/M1AD7zBhkt02dkhyDm4C9v/fY/gEWf44dY8uEdPVgxjuEEbSRFkoTRcvK9/96UT8hPd/d8X7ngzy/aHfCPushMn2urBBNVNqPc4u5rCAawJ5Td711HBGZiLD8R3JCYVQvo6WGsB4U3i/H8trwtXdSM4gXEqWUj2/8Ngme0p0ySTRsT+ClbfzcdAGmc1xzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg9wyYUyKd5/346TQ1xLkgfuOte3iuotlfXcD4kryfY=;
 b=EZZSNgNQtpADMWKeijtQlkirnh++GgahejLiApdDMZuU/LoRqR7FDNI7J3RCH0rQYLYVGLPs7h4f46YHUcMfuhHS2bkgq7jtzGs26n8K6eITC2KkqePcN2i95iuW8BSuiISvxos8Ot6Od9SqOcKU90+zITlkJyr14sIriKI7+77eFMi0OVDkGLvWISvomPldsP1FBnrxx/N6FCdVyr4BzS2yq0JCZzVA5z+o0qwLc08N5gILaafaPPKizMTMe4uyzs6FgPE11xPrNqSLcl3uehihzdqXMf+/owzHlmF22CS7uMlOtUQn/VXsY6ph6LCqx0gk6MRGHlTMErKQA/24jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg9wyYUyKd5/346TQ1xLkgfuOte3iuotlfXcD4kryfY=;
 b=dS5mMcvnDpQGVUirptGjllo60eiOm5ZtHKIa6YCwVf417zl3yhzlqc+XrcSbc7fp4mYqhV0QgMPDdMv4Wd67W8AXca7hoc2e32AyOV3mNlH7iRQdVp0Fdr6POoMnWa9oVDWfryMysY4nUYRs5RyXdkmh632A62iZ+G4DX2qhQUI=
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
Subject: [PATCH 04/16] ARM: dts: at91: sama5d2: Move flx2 definitions in the
 SoC dtsi
Thread-Topic: [PATCH 04/16] ARM: dts: at91: sama5d2: Move flx2 definitions in
 the SoC dtsi
Thread-Index: AQHWKaz1HK4IqE9XAU+N0OUrJnCjXg==
Date:   Thu, 14 May 2020 05:03:08 +0000
Message-ID: <20200514050301.147442-5-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 627d3fb9-1b09-4a5c-4930-08d7f7c4185e
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4483A3F2AFA7BF2643299471F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ujlPWhLZDWsxsWnw+IXeTv20lJj14OWHhNyZeEki48KrMDxxtjE2ZE8uaNF5x7Nz/6LcT9XrzoYaVZXc53tBcydvWfM/S4g4hv+22wdxIYu2KNsN1MWD195/Ascukj5D6dj7n684f95qPydLGGCzWt0c2AFYm2tV1DaY+/G7UFq8NvyStNKeCzHc6dwWW1hEe9TkI6M8lU2/a75+SQWlxqDAHcJILwGOa82B8nymKoWgh55ocxk62nXDj7WzECTnH5rjtoHOLz1r0nh7tW00ynjKjNhqInxlwt5rsF3eXea4yGunxn2RFuuYJe665tLo//5elhJERlP3/8L6teYCUwrK40uQud/gemkN5PpnVYWZNlonzFqnt17L1sHgCB1quqOj4GArU96YJuBbvsOOiHuI9zp7JWyUzj50mi0eLdmkLm8wqTNP6n9EAo4tsQno
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vm5rt3TRLD7o9QavM5stxvr2M3medCEU3n0gmeRxWqQQzZ6odjDfGjcs4CAhFwSBu4O+Uyow46okZN7u3jPeG4k+bFuo63YMd6zSm9E2Q+vCKiChpoHXEPfGGimVQmpFcjBOdpZnGPbBcn+WdMl8ndWvdaE0XBZoAqINdGA+60EZM3XKQCPioYW+qAXGUYOVEwA4f0L0e/BjZWg7DxuixESvzg+k6D6V1tfve9lWLDso+jMcdEUGVInwjstQv/gPyHwre35jHmla4X7hMW7zkNU08e2omxVb6nFkTYv+5doTTRilsDj/HwcYyNgXSq9mouLRC9/saS2lx8V4QL0fSBV2XK/7DOYvYtkRFW4ylQdnus3tfDbTzKq/mmtZC90r34vJAlF3VGLFAFdkKeAROGmxSmqpztWP0ujB/CJiBkz2kA1AQyRc8Hhd8UX2zRDfASFhdBJsoQ2oLFUPFTgqrj0Bms2R2ArhqyhWqUI4Axo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 627d3fb9-1b09-4a5c-4930-08d7f7c4185e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:08.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4qQSL9D1vYSkfwFoOQL49Kuew59Vr6mtXmVSPGGVhgxtAmzmKlr6UGTowZlTpkcBWL3Qq73H0Q11Eh2+71LGjCh2rF4BrZ3TKQY87yzbqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The Flexcom IP is part of the sama5d2 SoC. Move the flx2 node together
with its function definitions in sama5d2.dtsi. Boards will just fill
the pins and enable the desired functions.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_icp.dts | 12 ------------
 arch/arm/boot/dts/sama5d2.dtsi         | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at9=
1-sama5d2_icp.dts
index 8a4336e12a60..23f413afb333 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -160,18 +160,6 @@
 	status =3D "okay";
=20
 	uart7: serial@200 {
-		compatible =3D "atmel,at91sam9260-usart";
-		reg =3D <0x200 0x200>;
-		interrupts =3D <21 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas =3D <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-				AT91_XDMAC_DT_PERID(15))>,
-				<&dma0
-				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-				AT91_XDMAC_DT_PERID(16))>;
-		dma-names =3D "tx", "rx";
-		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 21>;
-		clock-names =3D "usart";
 		pinctrl-0 =3D <&pinctrl_flx2_default>;
 		pinctrl-names =3D "default";
 		atmel,use-dma-rx;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 5e84cde8226a..89064225e9aa 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -794,6 +794,24 @@
 				#size-cells =3D <1>;
 				ranges =3D <0x0 0xfc010000 0x800>;
 				status =3D "disabled";
+
+				uart7: serial@200 {
+					compatible =3D "atmel,at91sam9260-usart";
+					reg =3D <0x200 0x200>;
+					interrupts =3D <21 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 21>;
+					clock-names =3D "usart";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(15))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(16))>;
+					dma-names =3D "tx", "rx";
+					status =3D "disabled";
+				};
 			};
=20
 			flx3: flexcom@fc014000 {
--=20
2.23.0

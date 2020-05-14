Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59779C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44853206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JAsngGcn";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mp2iQccu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgENFDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:45 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58639 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgENFDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432603; x=1620968603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gNsJN16dftxhVUqZ7QfdzcXbr1yXGtf1D9kTTtLsCfc=;
  b=JAsngGcnUhqS2rZ30oyt39/oKvOxBd/w5EaKLdaW5Vnegb15KREJac+c
   zb9ZLtaaPZpN42MWRqtz/l4iA1a9dqNCWxdnu5GsPrFjl8IpsC9pq06HL
   UUgNAZstZ/MC45p81WShi9rh/gRqZKR4IDflNRdysvH0ypdjwUXZZFFBf
   PvB0/kaUSsTpbhk64RVd+A6xpdpcZQ3qXpGoPBn7vKLW0KtC+EXJWCuTx
   aAvwJEaBU+YXjxefvKDgAs4VBpehaaOina4CQArvx8UoAEajiPDwapy6J
   PI2QHXAiHhTXWLgGls8GH9c8gAtHHnCub4Q4Kiear6v532UQRb4cX70Oy
   Q==;
IronPort-SDR: 0rOmSUjnecy1Ucukmz8yTdXuhum5mXNZPFnV3pYCYxSQHTvR7vYieHohjgbrFk578scsQWGjPu
 adm/FlG6IMgeKHW+BWpY9Eb9Z9hd+FBw79ZJkF9PBJZHnYsLw0TogA6aBWM2jpeLGv+AKsCulm
 lyB52NdBbMppOZo7h2wtWiUvT/bKJ/fRR5U0kIqPFT9xFrv1XD1CHyY3qWiwvEbs21ep8Gj1W3
 eP5ZTIWdsR90E0SoG3DTkr/gS1Ycy/R7ye0NeloDyp7cKjqL45BDaknamloamiY0sI4w8WJIdz
 JHM=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="75847123"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 May 2020 22:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKNR5wWt23y0D2sbPY2hBMZLXEpWxiUICVReImUenj/ILhXChMrv+N9reebnZwDM8ZPWBUYYYSHIcpHM0OtfhSK+ZOSvIg9/A6dsMUOibtcrd870SUvGl2DUiHghB0VI6xR7JZ8n5KFg0OZyvLj7QqRkV+aJhShEyvbekqD8am/ZzNnbu2R2c5iyOZY38LKtUtwahGG1YGjvorbHHoUszAyTEGnffdAtLAFiqjY8yd71OgQek31UeSdZyeMdTCPwxX4NKl7FdRBDjtfrtyG9RRZnShMzAMOtNRwaYk0dJ+SKp6c3O6FSYBSMyI0RxvLaLfZ6Ztko1AmKubfPg9L6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmoiyrE5RUii9XC88nPX/QJvvRzd+YwwtMBKLjtqN5k=;
 b=YubOqCsn03wgz812T6izFUFI4kuUJtx2VKLbJGOZVly8CiQHkcJI+vhoq6W/RobZ0LSuZJxJoINNrjxhHemAx9B1Bq3LwHyNW2VrZQdJR/qyvlZUKe6ubzTshNlNRxvd5gtGJ2VglEoekm/T/dWJKXQaA9sOBT33hcKd3zAptXouBBPFiyEOuSEIZUUv8ENyuraqendMQma/nXcdNiKYZkBodNihq7sOQYePDFlECIF1GKP5/tKYB5Zef6iibpFoxjo3XMzustNG8D4rc/O5MDAbugtpfC7fvlUBd1IrpLgSH7y5e79L+W167dqqsMR9exkEeDzu1ppX0VctyU96GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmoiyrE5RUii9XC88nPX/QJvvRzd+YwwtMBKLjtqN5k=;
 b=mp2iQccuaewdVR6IOpC/j2eOA58FMv/ogdbq1s7pxtYRyfzpgvPz/YFHsIebuCoTwe4WZsqb2XrGjIKmWa31ma3Bap25sX0rfJnDbATb9YYvfRKTIuScieGuUpr4C44y8vq9XG35WZNFVcNTXo+suUs7xi2eOs/m3/oaS5/155E=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:17 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 15/16] ARM: dts: at91: sama5d2_xplained: Describe the flx0 I2C
 function
Thread-Topic: [PATCH 15/16] ARM: dts: at91: sama5d2_xplained: Describe the
 flx0 I2C function
Thread-Index: AQHWKaz63D7EDAmmS02hJMxEpz7A8Q==
Date:   Thu, 14 May 2020 05:03:17 +0000
Message-ID: <20200514050301.147442-16-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 0b09c713-a33f-4c75-de8b-08d7f7c41d61
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4483089F42F5C4F04BC6674AF0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6GCeZY/Fx6Yz/p6AU7JGMLWJMLDmZlLVCvJy8i+9nHM1O1RsT0w37nKO23EEugpYSZCONLFYDd9P5f46DdJvJbd10h4cx14b2BdG3wMbGF+F1ttH1vdTW3mvfXvCD8LTf3AN1bgVSu9/RgJ6Y5rKntaME53FVnJocEyCzlVPh+9hbReHrCUIuEVUQ1WZf5EQS2i8R4YcA5K3bl5vSz+qRYhsl9FJ6A0v24bd1TglJRhTDTamo+Nd2qZXv6y61hC+g9NB/ujlA0aiPqNsFo4TUdmHeMFURaOVtEsS0zhjDAMZWCO9Yx1cbfnG+VXlPGPuC96BMYDl3vXvFvVrHhYtQWbKCZWJ72u00AvVIYWVpnJl/mqHq4S5kAQDTXtL8LgFBG23T3NooUxJfUWvywsSybjyBo0xl7U/1sRLB1KbiGz6D1iIOuUl/IATNdeyMir
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iaoEz5r7VobT/LSyi00C6GpQcrBw8kspoC03yQA8AifOHzpJLgrfYRSW5maAS6Ohz9NVtExiLyJ8M9TnQL5JcJWo3+tCiml2BAU4ixfn8PWdzrDwyTZ8yHpzBD1Z6G1nuGac8L5qPLK1QVPhub5PBNqWbnu/d+jo1M2nTt8fPwEmrVKgY/qNv/jQTqbtAPS0AO/FjHiHc9Okuo5s2qR1cjRsNHP3bqHKPQdfujb/ANbZBnCZriAH4iNa9Pn/zq6diWMTKsJJqQ7DOEbXe9dTBAJc3/lbu4tCPoHWr2/G1WkpInWtdRQxxAlPIsKMl4AbK7ltftUG6CjOuR70GavaBQp80r4nZuniOp7VDBxzC60IHqiI8NerJodhxlPxLIfzbS61IP/kOHfY7QMYEO7udzV1tSYoYjJnxiWxH9BN14dRNCom20yn60SqvjYNO19AgPnI2mjm/TC09daBGzl8S7I2qPzsqNX8dAOkBR5nlelSYUv2azUpYvihUQ+IoXmJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b09c713-a33f-4c75-de8b-08d7f7c41d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:17.3159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Idhpysq78X1GtBbP3CNI3PHXRaF8ZVkk+gMw0AsSf1aSqy+Ht87Q6WGBGE1oTZp50ROLedWx5C5mIvtqTEsnbffuUuhLefqIvblxjCm8AAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Users can choose which flexcom function to use. Describe the I2C
Flexcom0 function. Add alias for the i2c2 node in order to not rely
on probe order for the i2c device numbering. The sama5d2 SoC has
two dedicated i2c buses and five flexcoms that can function as i2c.
The i2c0 and i2c1 aliases are kept for the dedicated i2c buses,
the i2c flexcom functions can be numbered in order starting from i2c2.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index 01ffbddd4ab8..77e5d4f5a102 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -18,6 +18,7 @@
=20
 	aliases {
 		serial0 =3D &uart1;	/* DBGU */
+		i2c2 =3D &i2c2;		/* XPRO EXT2 */
 	};
=20
 	chosen {
@@ -336,6 +337,20 @@
 					pinctrl-0 =3D <&pinctrl_flx0_default>;
 					status =3D "okay";
 				};
+
+				i2c2: i2c@600 {
+					dmas =3D <0>, <0>;
+					pinctrl-names =3D "default", "gpio";
+					pinctrl-0 =3D <&pinctrl_flx0_default>;
+					pinctrl-1 =3D <&pinctrl_i2c2_gpio>;
+					sda-gpios =3D <&pioA PIN_PB28 GPIO_ACTIVE_HIGH>;
+					scl-gpios =3D <&pioA PIN_PB29 GPIO_ACTIVE_HIGH>;
+					i2c-sda-hold-time-ns =3D <350>;
+					i2c-analog-filter;
+					i2c-digital-filter;
+					i2c-digital-filter-width-ns =3D <35>;
+					status =3D "disabled"; /* conflict with ISC_D2 & ISC_D3 data pins */
+				};
 			};
=20
 			shdwc@f8048010 {
@@ -523,6 +538,12 @@
 					bias-disable;
 				};
=20
+				pinctrl_i2c2_gpio: i2c2_gpio {
+					pinmux =3D <PIN_PB28__GPIO>,
+						 <PIN_PB29__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_i2s0_default: i2s0_default {
 					pinmux =3D <PIN_PC1__I2SC0_CK>,
 						 <PIN_PC2__I2SC0_MCK>,
--=20
2.23.0

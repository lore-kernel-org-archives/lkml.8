Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431D9206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DOiBL+id";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EI8MzNCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgENFD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:26 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:64450 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgENFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432592; x=1620968592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i7RlqKcZ6rkrSPmAUXAwXWZesrTl8aRHAwUJrBWDQCY=;
  b=DOiBL+idwKGlI1sXWKdjzZaWED1pkE3iL/pA/PzxUebpukHd5EahtUkW
   AOezh4U+k9XQIeaqrB2OBJHOVju5jBIcMK3WjMzwdykQYw0P/rPaRN2e5
   8Nkit0pR2Es7rk9KWCIUJUxn5QvIX2Vb2nuX/rY/qDykKYFejeeFArVyh
   IUyN1A1iu9+lkyr/AlODgZ//HdBKhH8DkUzYyEvn9HGAkUfyPcrTLCvia
   guPBdj5u2FFsMKMnpgwfkTvm/bnCyZnByVpw0H5eazRFl8J2/8VKw0wKQ
   8cv8gpoYF7Tej7eebDUZmpeW7D3pMH+o+/plITP8BBO1XHyQTjTAoSCQj
   Q==;
IronPort-SDR: mZGJFrCaJS1v+6DctsF2Yl9W3XcnzFhnQEXlOcs7+b5BLVMYV2Ai4DcKsPpPXkQzTBFFY+9GsP
 lMYGOJmCcpapKpsfomf6jWkembchbcsGrSOQQCAcIDRybhD36M4b2bZpqS0kYJAWK0x0+QodL3
 lZBIn2fOGj0Gv7zBaISLTbtJ+TbAy8mMqznYnqULIHX69BQ1o7m0uUrVkMBaRPal0etBAxQKNc
 SA5YpkTtljbN46+XQhbBzEWHK7de0r9+87GO14m3UDH8YgXT5GjDqUqT+VSHb1/QSbqpI3Wv+t
 cM0=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="73400079"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 May 2020 22:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHQZBkbA5s1b6R80L1b4T54PWi0KTkFEUPc+wThvmMO31LKHvOBECv5JssXuS7p0SKhR39AmF5nO22y+MLyWB3R/6YulcfqrF5eIjI5ZvCsnQPzldJX6yU1dQak1oqrUOHbMJRy/cT47gac4kHuyVVXQg7+5Kg04prAfNBjpRiA9E33jnSxtUN70TzCk1HqNTsRIAv7xoB5WqeMGlPBCtaZnycA0rTiFcIzQG7Rk7/AQtqowmtI7Z5Oq4nJgzgJU2ga93CtwwWmotzpJyJ6WkxcKGdU5hFex0BP+QdPLeXgUNbb/7uplP9rxx7WJqnW5rcaaNoIHNQta7neV55Zu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XJGVwncdRnKiZzT/3Yu6JXkIiPm6o8EQBFENDvxwGg=;
 b=RQdSTthNuQ+bUcZ3ubhB+gCKz4LsTprv1GsQjwkpy5jsoAhDp93Wu6RS69PkQZ8Ktz4o0ArFHQOTGdQtdPso+HC0AF6vWyqVWQwaj4u/viPWJ/ql2viORBl6tsOFJbvHznMWvkNzuMgwm0y/I4WTTxNsJzlHj3PzyRHckMgUQksciTYFSRX7kF2IYxsyedAiKABnVPe8VwReBHGootWoaDu/pCb5i/Lz5v1ck5MV00EodUorMt4g7vdI8AoeZqpeYeIRA9s3C8wx6P4OAyt7Iy6Z1EQCzMAisZk6aTx5fjW4chALmcdhWqTPqj33G7AEifN0650CNcRgCHjSbVZYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XJGVwncdRnKiZzT/3Yu6JXkIiPm6o8EQBFENDvxwGg=;
 b=EI8MzNCqjHXktoik/QTvpfGJ0LOGjXUSRKAdXihfTf+H7iUbONoO/n2EC5a7X2COnuui/MHpShluQJz3KCghPcG2Kqbsc6q8GrUyQpgPxUlJnMCfk7ezsqYEjtvC4hVfjhg3sneUvp9+3qdjIfmkatk+7uRMImbCBDGjGKOunYA=
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
Subject: [PATCH 01/16] ARM: dts: at91: sama5d2: Fix the label numbering for
 flexcom functions
Thread-Topic: [PATCH 01/16] ARM: dts: at91: sama5d2: Fix the label numbering
 for flexcom functions
Thread-Index: AQHWKaz0LXerz9Q/dUmbzQUpUcG6QQ==
Date:   Thu, 14 May 2020 05:03:07 +0000
Message-ID: <20200514050301.147442-2-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: fb4aa94b-c295-4d5c-f5d7-08d7f7c41740
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB44838A4747E87541B05E3593F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P8/LRo4E0pyUJ9OQg1ZLTGnyDdofQ9J94QolkbeVcT18fEN/RrnaahF8B3WiI9lJwHIcxm2EBES2bNzgcXY+Id76pGwW4VV4xfqZ3mv0tVPcdcJwG+9Zkaqct362c5TGQkDVpTzrSv6+oYFs/Enhw1IEoXy8BiUoxILp0B/rOG9kp+4I1mKPQc+jf/pMeXUS76c6k+3rjmcwMslUWUZEfy9CTLt2cjawj0TTtm4zeqBh9S9YbWqTPH9yxOKb5U2YD7Ts7uAekxcsSgUpJo9UXtEMCgmEHhHMppFzkpB1HKJaYft9Q+dhDxqOopYkn2niv2bB3/HnBpWEPKyylk4/Bj64QFbkNBSJzfyKGi+H0kxhY6sjyzY4EN6KRhhXzITOTc6qxgE+bEePj1xkIfMc1sS1L/FpGBVpk39k/u6csXCjeHYvZZVQsEKZf1ZEnJ1h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KxECwQ3H6g5DByDf9RxZGoED9ISN1OuwjNyWrwiuFZJlLWaXUKDdDsPniR7YlqCDdAmc88XsuFavITEf6HWSa5HsAL2i11FlAZ9UsV94x4Mz1F3zmmHF7wNSzNxf+nurFAfl+xApz2Wua4UEM51sF4d+FISTtxpa8tZyLCQoBqj3Hd5fu9mSDqQdo/5QcWxCCoPhvPxMzk6QFL6JtSV9lL0V2QTOIuU8iJxtKaFl0uLIAk3c7gRLsy6xE5FSqlGEztEDi1HdzPimDgNfjznlOjgZoM1I1bRBYNTu6vrKkW0eeOziSPSzdZPhu8KWD/Ai47TgSHUihHbSi7ixg5Uw41KLK8O2RoI0PJfrlE96ooDa9IEesusUQYK/PI2o1FdvROO2vLFCICd0ulad4TqFY4W7wDoELiAInbBQF3fnqoRjIiBrfnlkah1H64YRbMWw/Ha2PF1H9fkxSySEgCxzElmFw5XYyXRs5Eaz+53OXq4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4aa94b-c295-4d5c-f5d7-08d7f7c41740
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:07.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWlWV10OQXjUx83p8sX/jeOvW7JocdWrmbnEtWPFKHrVInR6aoDifCIUb7znhV240KucXkGEGyHn6/TNv6/5k8c0i6FFi1zFtT6+ZCMO7wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sama5d2 SoC has the following IPs: [uart0, uart4], {spi0, spi1}, {i2c0,=
 i2c1}.
Label the flexcom functions in order:
flx0: uart5, spi2, i2c2
flx1: uart6, spi3, i2c3
flx2: uart7, spi4, i2c4
flx3: uart8, spi5, i2c5
flx4: uart9, spi6, i2c6

Some boards respected this scheme, others not. Fix the ones that didn't.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-kizbox3-hs.dts       |  4 ++--
 arch/arm/boot/dts/at91-kizbox3_common.dtsi  |  8 ++++----
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 20 ++++++++++----------
 arch/arm/boot/dts/at91-sama5d2_icp.dts      |  8 ++++----
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox3-hs.dts b/arch/arm/boot/dts/at91=
-kizbox3-hs.dts
index 8734e7f8939e..0da1f0557eaf 100644
--- a/arch/arm/boot/dts/at91-kizbox3-hs.dts
+++ b/arch/arm/boot/dts/at91-kizbox3-hs.dts
@@ -283,7 +283,7 @@
=20
 &flx3 {
 	status =3D "okay";
-	uart6: serial@200 {
+	uart8: serial@200 {
 		status =3D "okay";
 	};
 };
@@ -291,7 +291,7 @@
 &flx4 {
 	status =3D "okay";
=20
-	i2c2: i2c@600 {
+	i2c6: i2c@600 {
 		status =3D "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts=
/at91-kizbox3_common.dtsi
index 299e74d23184..d7a6c972bdac 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -28,7 +28,7 @@
 		serial3 =3D &uart3;
 		serial4 =3D &uart4;
 		serial5 =3D &uart5;
-		serial6 =3D &uart6;
+		serial6 =3D &uart8;
 	};
=20
 	chosen {
@@ -207,7 +207,7 @@
 		};
 	};
=20
-	pinctrl_flx4_default: flx4_i2c2_default {
+	pinctrl_flx4_default: flx4_i2c6_default {
 		pinmux =3D <PIN_PD12__FLEXCOM4_IO0>, //DATA
 		<PIN_PD13__FLEXCOM4_IO1>; //CLK
 		bias-disable;
@@ -324,7 +324,7 @@
 	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_USART>;
 	status =3D "disabled";
=20
-	uart6: serial@200 {
+	uart8: serial@200 {
 		compatible =3D "atmel,at91sam9260-usart";
 		reg =3D <0x200 0x400>;
 		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -350,7 +350,7 @@
 	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_TWI>;
 	status =3D "disabled";
=20
-	i2c2: i2c@600 {
+	i2c6: i2c@600 {
 		compatible =3D "atmel,sama5d2-i2c";
 		reg =3D <0x600 0x200>;
 		interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index b0853bf7901c..d215243fe163 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -21,7 +21,7 @@
 		serial1 =3D &uart4;	/* mikro BUS 1 */
 		serial2 =3D &uart2;	/* mikro BUS 2 */
 		i2c1	=3D &i2c1;
-		i2c2	=3D &i2c2;
+		i2c2	=3D &i2c3;
 	};
=20
 	chosen {
@@ -125,7 +125,7 @@
 				atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_TWI>;
 				status =3D "okay";
=20
-				i2c2: i2c@600 {
+				i2c3: i2c@600 {
 					compatible =3D "atmel,sama5d2-i2c";
 					reg =3D <0x600 0x200>;
 					interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -178,7 +178,7 @@
 				atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_SPI>;
 				status =3D "disabled";
=20
-				uart7: serial@200 {
+				uart8: serial@200 {
 					compatible =3D "atmel,at91sam9260-usart";
 					reg =3D <0x200 0x200>;
 					interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -190,7 +190,7 @@
 					status =3D "disabled"; /* Conflict with isc. */
 				};
=20
-				spi2: spi@400 {
+				spi5: spi@400 {
 					compatible =3D "atmel,at91rm9200-spi";
 					reg =3D <0x400 0x200>;
 					interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -207,7 +207,7 @@
 				atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_SPI>;
 				status =3D "okay";
=20
-				uart6: serial@200 {
+				uart9: serial@200 {
 					compatible =3D "atmel,at91sam9260-usart";
 					reg =3D <0x200 0x200>;
 					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -216,10 +216,10 @@
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
 					atmel,fifo-size =3D <32>;
-					status =3D "disabled"; /* Conflict with spi3 and i2c3. */
+					status =3D "disabled"; /* Conflict with spi6 and i2c6. */
 				};
=20
-				spi3: spi@400 {
+				spi6: spi@400 {
 					compatible =3D "atmel,at91rm9200-spi";
 					reg =3D <0x400 0x200>;
 					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -228,10 +228,10 @@
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_mikrobus_spi &pinctrl_mikrobus1_spi_cs &pinct=
rl_mikrobus2_spi_cs>;
 					atmel,fifo-size =3D <16>;
-					status =3D "okay"; /* Conflict with uart6 and i2c3. */
+					status =3D "okay"; /* Conflict with uart5 and i2c6. */
 				};
=20
-				i2c3: i2c@600 {
+				i2c6: i2c@600 {
 					compatible =3D "atmel,sama5d2-i2c";
 					reg =3D <0x600 0x200>;
 					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -243,7 +243,7 @@
 					pinctrl-names =3D "default";
 					pinctrl-0 =3D <&pinctrl_flx4_default>;
 					atmel,fifo-size =3D <16>;
-					status =3D "disabled"; /* Conflict with uart6 and spi3. */
+					status =3D "disabled"; /* Conflict with uart5 and spi6. */
 				};
 			};
=20
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at9=
1-sama5d2_icp.dts
index cc9fa700eafb..1d9556dbbd63 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -22,7 +22,7 @@
 		serial0 =3D &uart0;	/* debug uart0 + mikro BUS 1 */
 		serial1 =3D &uart1;	/* mikro BUS 3 */
 		serial3 =3D &uart3;	/* mikro BUS 2 */
-		serial5 =3D &uart5;	/* flx2 */
+		serial5 =3D &uart7;	/* flx2 */
 		i2c0	=3D &i2c0;
 		i2c1	=3D &i2c1;
 	};
@@ -159,7 +159,7 @@
 	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_USART>;
 	status =3D "okay";
=20
-	uart5: serial@200 {
+	uart7: serial@200 {
 		compatible =3D "atmel,at91sam9260-usart";
 		reg =3D <0x200 0x200>;
 		interrupts =3D <21 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -184,7 +184,7 @@
 	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_SPI>;
 	status =3D "okay";
=20
-	spi3: spi@400 {
+	spi5: spi@400 {
 		compatible =3D "atmel,at91rm9200-spi";
 		reg =3D <0x400 0x200>;
 		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -201,7 +201,7 @@
 	atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_TWI>;
 	status =3D "okay";
=20
-	i2c2: i2c@600 {
+	i2c6: i2c@600 {
 		compatible =3D "atmel,sama5d2-i2c";
 		reg =3D <0x600 0x200>;
 		interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index e0c6cff1a312..0666708b05f9 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -377,7 +377,7 @@
 				atmel,flexcom-mode =3D <ATMEL_FLEXCOM_MODE_TWI>;
 				status =3D "okay";
=20
-				i2c2: i2c@600 {
+				i2c6: i2c@600 {
 					compatible =3D "atmel,sama5d2-i2c";
 					reg =3D <0x600 0x200>;
 					interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 7>;
--=20
2.23.0

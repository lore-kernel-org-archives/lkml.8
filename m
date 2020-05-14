Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDAB205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e6kOZwoC";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="o6c5jBRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgENFDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:35 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35471 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgENFDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432600; x=1620968600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+YVMvm9pRYREiIzIQWVBMuBAx7EqbPvCLveGl6UB6Ok=;
  b=e6kOZwoCinbC+RVtZ4qfWpGZublwZylX2k6PSUtJcSgcD7BHBcwz0Mz2
   4Mka1GOD4nyLvi8jfqSfmuAJYYbq18UNitRcLyVIcYuuEN6mXLM+lGCZl
   yT6oE6PUt36NkTYmqX+msIfs8ezVWcihQCqxlcDwDtHLSnGIoeB93/vp4
   AtAPNbPYbgh5dJuFwv4MD1TTmHmQixXMlDgAav7GVVshm5YUrR8n6pgE3
   OOqbEURghxzoy707gBpXHyZqJ15DZxeqVBN+xbks2/nfzGF8nT69jZjwE
   efDxI22h2Rp+XS4MqMNy+mZuoRdRQoWg+7qYWd0a067alr55Oz7gkTINB
   Q==;
IronPort-SDR: D/5IThzsK4Rd0y8X9emAdEUl/SFGt/2CJL4Whk3F+tbu/4jSr7pvnbkThKo4oZNYDz7vUazAEJ
 4MidPV8fA4FvEpE1szQaCM2GaY8PAOZT2x7ZjZtPmn1MFIA4RK/s9wW4x8xa/nnE9kCyK6TtuP
 WSsP8an9j/TGY8BO6mkZaJ1MLCL2vFbyCe/i8Y/gCgpwNKq/gshx9DB1yiJFPT6mZ8t6C68ZPs
 n/WoCrrdf1og97jDIJcrgoBvhoIjMYK7b97W6bIZ/4gaBsxzniPgzifn/Ob8U9csTHivaCjuBC
 nYM=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551121"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZERY6ryP5KsGnZmmfFi4FqPZmiB7RzjqmC/yknOGnHMtoEcxCn4POS57IEEJoncxqOig+9+jQOl86Wb6nWecYjIiJhPD9Jhvo43EUkUe0bw6TPd7xh8krAPe0pfL81LP8uJHBGwJIZngRRdJBCIQCYSfb2+CXakohpKGRSRdj0Xeh5lRv0jR5xs5fukMZ4wbeFrdv+s+Xqt2br9Os0DBRJ2q9Jb8EtAveRmIj9LQRAICjPOQTAGZvTDodHTrBpytZU4bgKuXPh/UaVPsJCIPX9pds/ifKj5FIRnC+cj7IOLOLOLFXDPqQxG0u2cjMgboquxK4S1nfKKEs1n2hP04kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC+EAvpAO+0aQRN7D/Yvy10ctQQHTaEK9Z1GkajQiEE=;
 b=XOWsj1rk7Ow2wCjIXzbzl9jDkkQdXndsh1E4pwAQiSgU5e2ZD30Zf0jjRw4gtR49p0W70pZDzi8r44HUch9bVPxja0sLjcyjUdwPHyJDXcA/JjZwRfhRmmyBkVFmREbMBNZqCENaMdynTviVASoNi58+b63Z+0RB2Om7hgTY3qwBZ6Um+4EfqBjWEF2r+Q2zAykbMTWpGRqwJvIHXkVVgA+uvaZ7gaoo6qI2lDQfc6NMR6D1P5UlNnXR2m0FyOSnRdIO7BrhDbzx7I2N4yD12ix1RsNC2wOpdvDPZgY/KjgrB3tTefX2/U7fCrpfgaZ9hs5h1klMtz6/y2D9AnO2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC+EAvpAO+0aQRN7D/Yvy10ctQQHTaEK9Z1GkajQiEE=;
 b=o6c5jBRbSxPsZ8u9BT6H+kypNXGj2vvqOgSuzvsAM+OZXxPw04uyqZjptEAp4+TNN8AWlBdoBq2ZsR7DVqVStiFvYlSzGHHsuyjFayJPYqGH5QgsHyoE8t1HVqPZPuMlxUZK7ea/fe+Vyj6+TWEvHo5ijzZ+YaTG1NKQqIN0Kaw=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:16 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 14/16] ARM: dts: at91: sama5d2_xplained: Add alias for DBGU
Thread-Topic: [PATCH 14/16] ARM: dts: at91: sama5d2_xplained: Add alias for
 DBGU
Thread-Index: AQHWKaz6EKQYTGVqKUifmquBLv69cw==
Date:   Thu, 14 May 2020 05:03:16 +0000
Message-ID: <20200514050301.147442-15-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: c8793658-1b2d-459d-4a3d-08d7f7c41cf5
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB448320A51FD6A75A418D0DF2F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rmQHOyHsW84DtwSyQr+ArfOLOQxODdxL0Ybp+AxqKhEbj4OnUOodN2cW5aBuiw/uMtghx+2Mst983eN5ROnyMUiufV4t3nS2BAQAeBqyYtpPbws7O0mpjBmQktZncDTYWKZfl3MstM7vYYl3co2j2sPe9IFzf+B6qUl9nKtUoF7fYJN+RpiRXkzgaLPYaJNUbzYBuvTpLybL0KBDjTqyVE+tcsaWEH1zuol/pO9E+9TODpsMMMRGnMzRdQhKibrtSM162842U8D+QSy3Fz/CCBDZmMAaJRGKGNl+DN3oKOpRtJCLLKZUHCPmpzj+L883LmyzcHQa5vwD0PNSrWhWjuoqSUoisPENrKeAihAyUy0CxxLt2Lty0CsXxO9HrhHBi/XJ38H8Cu2XCAFCyPWTlY1FYj9DmLe3ia6D6BggOdEni496vMe+DJ/Qh2Bw/ibN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(4744005)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4HEXe7xZws3I8BXXbI/77zLoJkR/KXjB3E/Yx1U9/HgFPXT4I/96U0Ksx9JrS6RdRzdVsvHQMSeu3/nA+JAvH4q3D1zXXlxLkf9soYS02jEHKz9bZ43LhGgLxdFh7mv83sr49Z6TSTAscowlS+9qAzewT5ENtUjz1nhBTMedHLikgFuscZsucqtyPHEUJy2qlwmiIoapUEcfqUrPqDOI1IbgMIOlzmmi/U8dKAwsQMb4sgUKFUcvAbVMrLSLkAlmV+M5i5FaHOLdYqzRKP9wTDowErN63NcmJMPpWfI93fqhYdc4v1e11afXNIvgqqW1vDEDJpnGQZneFidxD6vZLKPZ89Aj00eaGDRXwhKFa2nIAlbFCH21wRw0L4jiXrjNz7VLGsAPp3LQ2LUH4d8tETPrzA81qwDf6tdbsLeuvIaNlUSCFNQROqVBqj0MBI5zEE5lmZ/PshnF1Q3hbJxw7mj09KARighGU9xf76aM2G42XMCvxYWxT6qlun920lh+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8793658-1b2d-459d-4a3d-08d7f7c41cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:16.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzfDLuBoIW03uF9qOc7f3yRSWBRkm1xPqjbrVMI7YBzaD68/HB9JnN1wvtoQXPnKZNdhUuEwWQOSNe/CfWKM6BCwoNzGxO0XOR38T1OKUd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The aliases should be defined in the board dts rather than in the
SoC dtsi. Don't rely on the aliases defined in the SoC dtsi and define
the alias for the Serial DBGU in the board dts file. sama5d2 boards use
the "serial0" alias for the Serial DBGU, do the same for sama5d2_xplained.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index da4442715ea5..01ffbddd4ab8 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -16,6 +16,10 @@
 	model =3D "Atmel SAMA5D2 Xplained";
 	compatible =3D "atmel,sama5d2-xplained", "atmel,sama5d2", "atmel,sama5";
=20
+	aliases {
+		serial0 =3D &uart1;	/* DBGU */
+	};
+
 	chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
--=20
2.23.0

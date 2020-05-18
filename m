Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCFB20756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hBUpv7wq";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="najrLRyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgERLt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:49:27 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:45699 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgERLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589802566; x=1621338566;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JQ0NAO/GtfI7p2wQggXC6fNNXetSUF0RmF3Qo+o4/KE=;
  b=hBUpv7wqKSabOpHd6qMvpCp5qbu5XrVpZwpT19nmN7jApcIsrldGhg/e
   2I/6M/DvP6sxmwsfVmogRyOLO+wqTJRU5D1AFQKN4ju4McQ3bkTIVoKw4
   6Fjw5bfdGrUhmAFyHuc0ADBA14+ilsGcC5WPI1MXaazs8tPW+g6eLVnWl
   Jyt1ISZglk1JfGNLBZrD2UxwwU3X6QkCfK7/UDQHfZXJA3PUhCfMM43t2
   aD1d8DgBP+SWeNXxRoNBIEsLRF+XeRCKcBP3FmvVIrp609D19v+SHRKrJ
   7vQ7ejNsjQMiGYr5k/Q8yozkm1kcF6W76LOJlsD3t72ND0lO3lALQelv6
   Q==;
IronPort-SDR: 7JlGoEpwLqsVTx6ahRjFajvtgBseb/xhAoifPjvkRspLLZEvC7EIGcmlcNg1uygyvSMpwDm6x1
 nI3ouhg4RrZGowmsov6ry3AgKc8ZhyGWAHOJ4oeWOgW7i43Ds3V2XNHKrYUQiD7fJj+VgvMEeQ
 BYZ1Yod0U/gRQXvE2sZHo5CCTZxoSzpjn3hY6YsBrJNaTDeuLCIWUAYNuXtqu0yrf7qfXtcuRx
 2yf7YukXheleu94yDQQGuTTUcy32gDWwhxchvGNEDwX1tCt1gIK9Q7TspA23GZLn6ua9EgElkL
 ClA=
X-IronPort-AV: E=Sophos;i="5.73,407,1583218800"; 
   d="scan'208";a="77017507"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2020 04:49:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 May 2020 04:49:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 18 May 2020 04:49:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnsXvnP+fAy+rbaYyglK19VYTANZsiCyQGW09tJ86Az9VxXjoaqMJxVuI5/yLoq9dBh+qjJogFI7mB/QNbm7cN9qKQqyZ40zJWhrFTUlGNXnqOnzlbGP0d4z0px4ueSm5zdCZ0oVK6WZqCJ8276tBSTrfhNxjhKOxDhi8ryWYS0QxnoVqW7gjUUWgdy6BGIpYK+E1npS7hh9XtK/TWTIE/f58nwDCC5ezPNKIb1CudrZsw74EMsa4BkMKIa9zsxPFItqf41TzZN7i+E5VfGPylGvf2Hv42qedPTU6WLn8vMWcdpo8haG/5LI7qRPFY4X6hKILsc5FUK8e5JA2Adg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5fAA5BSfKpVFTNEtwZa8SkJDizMP/Hcb7mhzrYAlR4=;
 b=CwgyP1Sx+SQZs7mehhGQM1fEMuyGDcrtzkUmS36QFJif5K5saa7jaI4g1/2BF2PUZx6xgKEDwmlPdAi7waSmre6fKMdq9pGC6mHBDHQveEizNil+dclcWPzZT5w86ahqid702btpWmqpEtMQr53f6BCrehUceCTqc5oOCioaKvNZCkZRelpYXuHDcnx77Bwt4tYKuZLc3AEUSPfLMKB3vcI3dfyQ2C4fqbbHOigEJm/Oid+a6P85Kn3mjlpYu1R4WCmCecQ56f+7FLo5uk+0LPUjkftA6Iuvd9dFIjprlbxjNFghLTEhYAJ94EV7I676zd4kABIy/lYt5twrKOijlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5fAA5BSfKpVFTNEtwZa8SkJDizMP/Hcb7mhzrYAlR4=;
 b=najrLRyRjNrpd00la07YiGY7ksgOavr0u4q7c0FZzFBj9ofbn/mCgKQ+0LNgNja6ezsQHB/nuvLad1F5ojHGttnzgEknL2CXEXxoZyQI2mATZSOZUfyFUBGCJ7ILOSGjrw+Ac9mjfBHErCzyExgiW2G9FAGeMvPKIKmMEvzmSkk=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4102.namprd11.prod.outlook.com (2603:10b6:a03:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 11:49:22 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 11:49:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Nicolas.Ferre@microchip.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2_xplained: Add aliases for the
 dedicated I2C IPs
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2_xplained: Add aliases for the
 dedicated I2C IPs
Thread-Index: AQHWLQpeiYvdwjy7WESHl6IsEN1h9A==
Date:   Mon, 18 May 2020 11:49:21 +0000
Message-ID: <20200518114802.253660-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69d04bd6-dcbf-40c1-bb4b-08d7fb218179
x-ms-traffictypediagnostic: BY5PR11MB4102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4102755933BC4A3CED5AE708F0B80@BY5PR11MB4102.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhFuCK5DNNnSgel839jOz8GynoM7CBwIol4oYkf2pcvN7ASNZ9O6VBlTswV2+4QNW3naT+LuqO7550o3sN8usdD+84E3hwyVilsUmAKlgufxVJIgXaKwo6pfuDBJdqv4UhwOMX9ZAgfDJeHxHtbHr2g9IIjDe2f/WKLTOyMJsG/GLwaxshKFML8bFfaKADxwE3Nh7P79+8PzyDYmfzDJXQ+uZh0eETR+PNFn937J4H9xCIufytTMPV4ukwrQmf2iHUT/vPPkDiedAxL/N/mPjik77UAePQWeWT/TRPBQjcFohyOtCelNMDh90obPhN+4QSAo/Yg/E35fsK6fRUPILDk2KKz2CO42P5v1HCzU4g87a8n8HD2EhIuGOW90JQWT7+1+coo2p4IxBFUh5L48n/6IyRPvgkVtvc48rgHDUp0Oa7QEu97YI4bOIB3S9zt5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(8676002)(6506007)(4326008)(2906002)(6512007)(6636002)(107886003)(6486002)(36756003)(71200400001)(8936002)(2616005)(26005)(5660300002)(110136005)(66556008)(66446008)(86362001)(64756008)(1076003)(66476007)(91956017)(66946007)(54906003)(76116006)(186003)(4744005)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2PGXPQluRbAz2OegNuRm/BIFTynAREp/XT7VvEBVPnrPukxvpGbxP7+hSvrwkR6nBV0RgfsBTV9WRVOXdHfKBSeAE9FQeXaudaC7bynCrlhLZlc0/fCCFFZFl6n2k5PRBUhEdepliWtUINFNJtTaXvQZcZyUgui6soTxjeI/2K+93HNJ5S0O8VWATjylPrDCKa/oCIvKXuW8cginBTjkAx4AS6DIxPpz2VYIymiZg4YQeohc+7NiuKX/37bhgE2gjBQxJuSaGYkHlX8Z8TevdTyDz82FUN0of/4i5KkXdzbPpoaAbyZl1JJhEx3TEh/tSn0JosVZs6U0j6R78evlPuLBQfEKEEULIUDNoJbbRYc4DzLEesusRK7168NX59hpAYTzSJcAPH/xL+d99mi+oZYAvolDoNa+8KYcxyE7G4Hv2UMYGUQ0eFeRkO13VjuAsD69rUJby93AOLzIW3Iu85YAmmqttL7eW+ez5NG3kmA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d04bd6-dcbf-40c1-bb4b-08d7fb218179
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 11:49:22.0226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cs27xMgAQvBTh+kcDlps1CdjMtP9rv7JXnrh7+AmwuyIwFjW1K8o3nQQAmCU/7L0svEe0wFfuhH/05bB45EybSvS9+wC1IlRIYr8c0L9UFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sama5d2 SoC has two dedicated I2C IPs that are enabled on
sama5d2_xplained. Add alias for the i2c devices to not rely on
probe order for the i2c device numbering.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index 851b8587068b..a927165ea7c2 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -18,6 +18,8 @@
=20
 	aliases {
 		serial0 =3D &uart1;	/* DBGU */
+		i2c0 =3D &i2c0;
+		i2c1 =3D &i2c1;
 		i2c2 =3D &i2c2;		/* XPRO EXT2 */
 	};
=20
--=20
2.23.0

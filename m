Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BFCC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93AD20658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="DIyxlmhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBSL5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:57:18 -0500
Received: from mail-eopbgr130117.outbound.protection.outlook.com ([40.107.13.117]:32093
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgBSL5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:57:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gypDhe/vfxWsUoertfApfMgjXbD99qCVEOfkK7Dyi9SLthHo1AjZq+b8JMq3X9aEyc2ISYbzVu8euU8dkHH0wQ5xv8M7phxTWWmAz/C/JBtYi93eP2FI4JzeSuipu9fUtGRu9FIhi9kfxB6lXtTGpM7RB3cvlLGbGt7R9btX1dGtr0EUY6ZxJSI1zkP8vUGP+K2ZJrOakA+CSs0sEj38cSvi6221NtxGdb/XNAnPuV8p9nIn7OpB/UvOfhUGOYywoF/e8N9QQGY5bbxpaR2QRqQjCYKn7VK+IaDm3qgFiVUy8mY6zYz3EY7Nox2zsC5hct0rnodalUHCQ7YGHbbNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbaRyFI+AQayIqXPg9EJfANGjleTwZMkFamRErvfBjE=;
 b=mblr4sSPhP9bwHZGcXtvS8JYL39Onx6v1u4SzGsjOJ2hnbBppwu7F2Ab5AO1Du1LwSdfSDUw/0h3MdhWBIF7KLyV6cKDy4oB23Y774XBpe0U8l0YJatfeHO3hHRIDE4Gu+MrFb8/eRPzdH8296wxx2x0ipx5YTfkgVlTNLZaMoi3AwGkh34Pz9HyrPLeLEG8dUy8l4z7/fxemIeSy58b3uNUTPcxgIvDVdA0eGAf2GMrCSBs1YyT/ttaBv0qjg09OeCQ29j+MV8TwoJVi3LUwtYQo2srtiggNUPM9oIyQsRDqsAE02wWCN/2reoGDrt5PwNw3hgLC1nwJjKNDIUOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbaRyFI+AQayIqXPg9EJfANGjleTwZMkFamRErvfBjE=;
 b=DIyxlmhMwNKDn6t0oSOaqjRPr2DcgCn8C9e8mtH71gfKkLXIHZkY3r3o154hs4dw0jpBIksoxp+Yu8l3y6MSE72H7qvDqTiOepHV4m2PjKzWbwjXXre7j10WKUYyzrYn7kNln+VdPMb1DKcSBwN6gJK1Y8lKXkcKh/od1kyaIeE=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5197.eurprd05.prod.outlook.com (20.178.11.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 11:57:13 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 11:57:13 +0000
Received: from localhost (194.105.145.90) by PR3P191CA0037.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 11:57:12 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: imx7-colibri: Fix frequency for sd/mmc
Thread-Topic: [PATCH] ARM: dts: imx7-colibri: Fix frequency for sd/mmc
Thread-Index: AQHV5xu5UD2HW6jXL0+gmbn3erTUlg==
Date:   Wed, 19 Feb 2020 11:57:13 +0000
Message-ID: <20200219115709.3473072-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR3P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::12) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eac186d-e322-48a2-8875-08d7b532db69
x-ms-traffictypediagnostic: VI1PR05MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5197CE9F548774E0864DA21EF9100@VI1PR05MB5197.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(66946007)(66556008)(64756008)(54906003)(66446008)(66476007)(5660300002)(316002)(6486002)(6496006)(36756003)(86362001)(4326008)(52116002)(8936002)(7416002)(6916009)(44832011)(71200400001)(478600001)(81166006)(16526019)(2616005)(186003)(26005)(2906002)(1076003)(8676002)(81156014)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5197;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9BXsWtMKDKT0SmEmjpulPfa7Myg586sUnsLhrSGcU3epTS4014uiSm7D0Qe1/byEjYtBG64eUqH7wAQJgbuzvu4KAod0sNoVUIT4deBtTUwGAT/CQdbL68LH3MXvs2aU0xwwfPrhtXBB5mWowpeI2VduEohkhj1MPLWZMHOtLBnTclmfLMihGJF6gQ/1yd7/hl5CxxV7pAPXpFK3RLcT6q5v/DG5DZoq4P2kl7ohJq7+Lk/UYT574HWAMWmtsW5SyfNOBxRcVl7Biyq5Yh0Eg32GrOYn36DdG5K42Ep9xakvPvjJvmPzWH2MHLmLmksBU2ZX91HyY+4NudAO7eapID6/5FILwdQOH3Zo/cN9CRn46uJTlAvi1JC2tXjakZCNroE8R58F8rDwwflO4uYEoFk/3tPNy0gQw6jWXAYZxG5NR/wKaeBh8t/IGLRf5jh
x-ms-exchange-antispam-messagedata: 5yfbRxDH2RDwlqVyjE8EZZsliMJ7IEaTeaSiAmywh/aKEj0qYHhurnSBl3iXCA6Etg42OK6X5hbi7TfmMAZaqBwQddAX1tH/GhBl8iuoa/yfVz0V6odwQDtS7o5k7LHNDyOUlMEk0CsrOeR7z+06Rg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eac186d-e322-48a2-8875-08d7b532db69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 11:57:13.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIVkYFd7VPy3XY+Mf2P63x6Vg+IGmaQB2ZNRXzfOE18FzMpUySqDWojidCKECiGKwmfvXyatx9eQsfBoamfVFIyZTfeZvieGBeX61pZAfl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD/MMC on Colibri iMX7S/D modules successfully support
200Mhz frequency in HS200 mode.

Removing the unnecessary max-frequency limit significantly
increases the performance:

=3D=3D before fix =3D=3D=3D=3D
root@colibri-imx7-emmc:~# hdparm -t /dev/mmcblk0
/dev/mmcblk0:
 Timing buffered disk reads: 252 MB in  3.02 seconds =3D  83.54 MB/sec
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D after fix =3D=3D=3D=3D
root@colibri-imx7-emmc:~# hdparm -t /dev/mmcblk0
/dev/mmcblk0:
 Timing buffered disk reads: 408 MB in  3.00 seconds =3D 135.94 MB/sec
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes: f928a4a377e4 ("ARM: dts: imx7: add Toradex Colibri iMX7D
                      1GB (eMMC) support")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index d05be3f0e2a7..04717cf69db0 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -336,7 +336,6 @@ &usdhc3 {
 	assigned-clock-rates =3D <400000000>;
 	bus-width =3D <8>;
 	fsl,tuning-step =3D <2>;
-	max-frequency =3D <100000000>;
 	vmmc-supply =3D <&reg_module_3v3>;
 	vqmmc-supply =3D <&reg_DCDC3>;
 	non-removable;
--=20
2.24.1


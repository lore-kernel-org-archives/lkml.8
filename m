Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3805C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A005C21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="knftrQzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBSNL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:11:29 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com ([40.107.8.118]:5079
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbgBSNL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:11:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFsJSqnd2Ga/Mia1ixKtsUv4O37KX20a6zzyeQpLwxLgcIMWUE8j2g6iQtVqg91lhtwkPQVmP5nL7ES0gHac+N+eRnby06seNxFVMTPZc78l9eBZ1nQcLkM2uivTIhqcnmRkny849MplCIYigJ7OQNCxUhDaJWD+QVLPMX5jLMCkC1S7oeD708seKrS2a4P6DgnJZFkhsB8Vv7T2KC78yZW3MnQ4khgUuy7EPEEhQH/4qXjg7yoqCKpjUl7BG4m6SDflxLnA4Ro0J3de46YelLRHIt5Ir03U96Ukx1HPFVyo7dqEyspx00RkPDd9z41mkyoUeTUoNQpZrqIaSTT8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWWyT5xBxQRBMC96YA8KTfqnxQue/DmYtW6XtI49BtU=;
 b=BjcY5UlcCJkQWYEON7H+mFaXW8YUx6xAwY00dFWfufb+uU/XIuH1SDM1PUBv6tpybyttHeSQne/Z0c0fqIdZYgmsGICJcesJNFvuGVwRQMn2yNgtp65tY8V0WUnUYgFXcxBR+H7Q6s3puKG/SG2tc+dO38aUIaj7TBaS6Hfbi29TRti4Mu3cRghFS9ojjfN9daBwCbBXQbM/vwuAyNtDE2VEnMvAbGn+78uey/IZIwm/zn1yWYkSiSo8dcFVEjYQewP7BQoRTRdCxx9fIODqm/YPwSJfaD7Lb0kKmW22LorNTwdb0zJLoBhGGPSfMTEse1tgd0GGiyooeeqTA4w5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWWyT5xBxQRBMC96YA8KTfqnxQue/DmYtW6XtI49BtU=;
 b=knftrQzUefIwDXRwWp0YECWXKMX9ffx0fhRl1YzGihXKsIi60SujdF3VNGRbopyTJo7jWekt78Qn4+nzh6buU3GlK/B2+sV32Ysk3baY4uOP9oH3h6rc9c1xR5KWxN7UVY4XhsZQSppRIVWuQAMY6YRKD/ZaLKwb0/qPNznMr5o=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6112.eurprd05.prod.outlook.com (20.178.204.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 13:11:24 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:11:24 +0000
Received: from localhost (194.105.145.90) by PR0P264CA0152.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 13:11:24 +0000
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
Subject: [PATCH v2] ARM: dts: imx7-colibri: Fix frequency for sd/mmc
Thread-Topic: [PATCH v2] ARM: dts: imx7-colibri: Fix frequency for sd/mmc
Thread-Index: AQHV5yYW1MJ7wsEAJkO5IbqDZXMXGg==
Date:   Wed, 19 Feb 2020 13:11:24 +0000
Message-ID: <20200219131121.3565738-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::20) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 264d84c1-21c1-452a-6cdb-08d7b53d38b7
x-ms-traffictypediagnostic: VI1PR05MB6112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB61123F0519D3A4E19AFDDF0AF9100@VI1PR05MB6112.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(396003)(346002)(376002)(39850400004)(189003)(199004)(4326008)(5660300002)(86362001)(66476007)(36756003)(316002)(54906003)(956004)(66556008)(2906002)(66946007)(64756008)(66446008)(478600001)(2616005)(71200400001)(16526019)(7416002)(81156014)(6496006)(186003)(8676002)(81166006)(26005)(52116002)(8936002)(1076003)(6916009)(6486002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6112;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgUF27a0ElrK/IwiHJv0kndq0KBKg0mVI8ntY1Mj0JZ7874i5niwJ75ln2O+fb9mUmRceEX6eehgFHct6JCHF1N1oKn5BO6ynEVby2eAPQxGwots3qRN4rRrScAXr2ATw9ddJ31sN7vFYZjGAbYz+O8BCi9FvHzLXE9m7i4SNT8uvRcap+bmooS8ajVgNJcAYrv9UiXWac36oLsd2FrmjTr0LbsInfruahbYw67aHXXofh+9s6ojR9eHDZceTxlDNFm9KL2i2D/KXLXjCHchrUyQYV9HwpTbSm8ZQjv5h1rF3U5HpxEsFp6VzTfcLzdZ9Li5LlG4n/nx0x7l8AdhpfF4kiishAbChCM2xwntl0Q4y2bLAjzQ8HtYeTZzUeJHKUwWk844q3gyor/JcXmOcDIlYgzmKkhIaNARpYPQ8SZHVDDxr+KtCT8YY0mOPsHq
x-ms-exchange-antispam-messagedata: /9lJU4AdTQlE3orF51R+ir7v8/4zebnr7aKOtJzMkw9Tc+gC6GFwBuHCypyFwfv1uwNdJ066n+ZH8dBP5bwqevp8gwwH3/pMrACZcyqnYH6a+L9xtJQbodwWeYgfXxXVmjSap4hBf7xX8rzJFETM5g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d84c1-21c1-452a-6cdb-08d7b53d38b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 13:11:24.7091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Egxs/DAC2qdsBAKy8+qDHrsDdabNZb5S1lCO1hnOIRaTpwHqGA+As+3qMeca2JvsRV2c3DR6iR81c0CDTQyb+RBlwOoI0wmryxTirjicUkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6112
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

Fixes: f928a4a377e4 ("ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC) =
support")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---

Changes in v2:
- keep the Fixes tag in the single line

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


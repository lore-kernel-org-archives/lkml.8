Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D219C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DFA22522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Ij75ESAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAOMe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:34:28 -0500
Received: from mail-eopbgr40123.outbound.protection.outlook.com ([40.107.4.123]:20855
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbgAOMe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:34:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpxlPHKwkbD4dSz/pVZk7Uf2WKtJnPPeuQzoKV1fNtmI5pToTLE3Wf1nAVWchu4+YeP1CQqX2pp+iD4p5o7pqaLv0F0SKdqMylkRrxTEirnED/u4H1DGbCo1GFeQq7HwLFqQ9RfPmWLUt03ZPzU+X7S9YJNy/3us8DgRxX4pUQ1jZ2E1A29yv8w5wq4P9f5ezp/uYdecQ2K2CSaJdeidxYIPsIbNlRFb2kEy1Ab9Q6dazf6Xf15JOmyM44RF2ai+M5HBUNcs6janHWSXI1pp3VSwXfZPVfg+skxKeuewpmi0oy5kUtc1jgSNsWsjeO87VjI9dvBTde6q7rWm78f7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0e5hvsKVP4k1Kk56nRQhdu/kgSOJ9v30lY9F0Pwy1A=;
 b=DgUwYW5RUW21YlhoIyaq1eSt9d4TKexkn+gku7AvmcXuy9ycjv4iZcVBdTnAOgpcKoSonQumP0YtglQI0UoaVIvvU804Mqr+n0mDV73iUCS8jdSdgNvBD3L37xGdjZc838YlaiqFB4uflaHUYAXaEePFu8DvnkWCxeZR/KndEhAh6MnQIWxFR0zLEpapr9GVjwufdjXkvaijsU69oVWy4+1chJZBIEXu0AGjJK8FM2ZnK2RRsS3PR2nq4WxbtnY1U1b0+X9JVWXHdDUkwKVwCdRUwPe4GBb5LUIeIhri5i2IvH/fBkCZm4gnb0lS7FF+M/OB1AzxDarUYZJw8anZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0e5hvsKVP4k1Kk56nRQhdu/kgSOJ9v30lY9F0Pwy1A=;
 b=Ij75ESAPg8DsarfpGQibTAo5GgXs4jeXXYNuxpxDmsn6nNyr3w4/iOKWfITkeQWoCwE+T135COraY/B9FjIAsjuAQurhmDhxxpGcwVotrvS4OIn9GKPI79ch2IrduxMcBGhE6+SJFEE/sBZvN3kTlc29R3Aj8H3k3QPQPL4vG0k=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 AM6SPR01MB0060.eurprd05.prod.outlook.com (10.255.22.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 12:34:21 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 12:34:21 +0000
Received: from localhost (194.105.145.90) by PR2P264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 12:34:20 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Igor Opanyuk <igor.opanyuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] ARM: dts: imx7-colibri: add generic RGB (DPI) panel
Thread-Topic: [PATCH 3/3] ARM: dts: imx7-colibri: add generic RGB (DPI) panel
Thread-Index: AQHVy6Ac56X4lthwbEG5Llfds1xgWw==
Date:   Wed, 15 Jan 2020 12:34:21 +0000
Message-ID: <20200115123401.2264293-4-oleksandr.suvorov@toradex.com>
References: <20200115123401.2264293-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200115123401.2264293-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2P264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::31)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30637859-925a-4466-8881-08d799b73ee0
x-ms-traffictypediagnostic: AM6SPR01MB0060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6SPR01MB00600399F936FD98B11B93ADF9370@AM6SPR01MB0060.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(54906003)(52116002)(6496006)(6916009)(81156014)(316002)(66556008)(64756008)(8676002)(66446008)(66946007)(7416002)(86362001)(71200400001)(44832011)(66476007)(4326008)(36756003)(16526019)(26005)(478600001)(2906002)(5660300002)(81166006)(8936002)(186003)(1076003)(6486002)(956004)(2616005)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6SPR01MB0060;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WhYFIsF4VjdBUzIJUPqeeVo1gjQuQmPw9zQMEBh+CMQHCv9yqFQiaIvZTCZjA39nwh8mxjiZdVFdv9+ar0v0kGeYpZMbrkuG2Ko5E5/UVVFNB52eZyQ3PWRAAC4PxrqZ1GYQOTt6MCyiNkaz4cC0tKrpQSunAB/+bjbObAI9NU89p2WQz66Tgvl0MDZqSrw9Q0ilLRpcqbGsJZwQViQptr/i7iA+/0iGhBBE4CHe0P8MQS+1frO1IH8798aIdUMz9rPy6F94Q3N+AFGhTUKCdnUGZYYDjLdwGQ41T7qB01Nk+VUh/9aySbgSngQTsWYoNx38SHWLMaZZrmFsxHP7HTPF88DnL8KD6HxTUqaKRK0+70AaamvHMU0EimA6FzQFpwnjnM4LIJ/gM/eM53on6+GIO4QHK1KG50aO4zRFStS9oGMhifQgKnk/GaXWDVYjXZdiLN1DTFO5KI1Bc74VGLq1Bo53//C6g+ZHNBSFEM8Pw55w3Gd14sOQbCJRo00t
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30637859-925a-4466-8881-08d799b73ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 12:34:21.1240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNARAofJ42mt1LwnIXiv6Ji3jX4K/sNtc9bhqzIM5F4O+HIZw7W5BkmLLCigeeC597b5bc6RrG2/89Kwhr7nIjYZNuBqyMsTNoLhdOq6YcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make panel definition generic and default to VESA VGA display timings.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 29 ++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dt=
s/imx7-colibri-eval-v3.dtsi
index 6aa123cbdadb..af043526852e 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -67,9 +67,36 @@ power {
 	};
=20
 	panel: panel {
-		compatible =3D "edt,et057090dhu";
+		/*
+		 * edt,et057090dhu: EDT 5.7" LCD TFT
+		 * edt,et070080dh6: EDT 7.0" LCD TFT
+		 * logictechno,lt161010-2nhc: Cap. Touch Display 7" Parallel
+		 * logictechno,lt161010-2nhr: Res. Touch Display 7" Parallel
+		 * logictechno,lt170410-2whc: Cap. Touch Display 10.1" LVDS
+		 * tpk,f07a-0102: Capacitive Multi-Touch Display Fusion 7"
+		 * tpk,f10a-0102: Capacitive Multi-Touch Display Fusion 10"
+		 */
+		compatible =3D "panel-dpi";
 		backlight =3D <&bl>;
 		power-supply =3D <&reg_3v3>;
+		width-mm =3D <217>;
+		height-mm =3D <136>;
+
+		data-mapping =3D "bgr666";
+
+		panel-timing {
+			/* Default VESA VGA display timings */
+			clock-frequency =3D <25175000>;
+			hactive =3D <640>;
+			hback-porch =3D <48>;
+			hfront-porch =3D <16>;
+			hsync-len =3D <96>;
+			vactive =3D <480>;
+			vback-porch =3D <31>;
+			vfront-porch =3D <11>;
+			vsync-len =3D <2>;
+			pixelclk-active =3D <0>;
+		};
=20
 		port {
 			panel_in: endpoint {
--=20
2.24.1


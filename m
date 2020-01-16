Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235DEC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB80620748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZWq2Tbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgAPGiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:38:03 -0500
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:61505
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgAPGiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:38:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXOGPT9bMYFG1WIRccznvjBoAOGbpLifzsdb1GEdrtQsRbPEFXtDexmGRcTNLNy23WGx+a40gGUcbPFx/nmoGnUbUuQjuUVBiGrfFQwlgdHQlv4VzY0Ljh9HgtAXA1f3Z3QG3X+9Mk49/H/L11Nu8l09P+9/eIXgWfTEiTO1NxJBlziR4itKjNjcw5BWXiY58+qqxkZZ0D2p/1qJwgbh9I+rQrVvgebRFigK58f3WSxB5WhAYhA9C47imOfnhXAF83LeUlEzZ/Ltrz0d/CaLA8Cmckj6v4X/wNePb+YWKn7pGp7W+Uf99Gx9elWRqx4DfX7YIcdMOzzyjlRNzTbcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf53RO9PjBXhH7m8Kou178SVFMAiLAOxVHTVPwdPLVc=;
 b=L4Hvlej9JmcbZtAbE8DjZiyD0CXFjHZdeAI979BerC3Qp7CA7yVYsnrGY4yY1ua8RyuSameuy336rbjL5TcsNbnC6bm5rUfnstqVnq50e+i6muBQ3SqQ6MZPNzk+q3sa3wnGoorLg4JbiYBYkhV7pQVWU7BkOQYsiJFVdN7+yXgK26nKAVlBi3b0Uv3wwCD7tZOl9BQbIUCLRBmlnwge28NrQ9inL5f6jO1sOM39LdtRRNC11ZMIOH68csJCxWmRCwEB4zxjgQHP7K/q3PzpBHBRCihr2EEGr4UmnsLARqwknBuM+H6cRev5yYzSZTz14hh9j5swtNghLrrDakEuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf53RO9PjBXhH7m8Kou178SVFMAiLAOxVHTVPwdPLVc=;
 b=AZWq2TbkaqDwYjDZVviVoVbrLORP6EgTJbogxRHODLJgjRNm/0w48SM0YoDcgXxbs6DU4M+ilbwKipm2+a9OHjX62SIdoJv5c+8lVqpmMg4Lpnl5isVZDs6NBCdSJwSN768jgPai6Kuy1E9HDZ+OqK2MnMX6fDmCZ7Jngseogd0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4370.eurprd04.prod.outlook.com (52.135.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 06:37:57 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 06:37:57 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 06:37:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] ARM: dts: imx: use generic name bus
Thread-Topic: [PATCH 1/2] ARM: dts: imx: use generic name bus
Thread-Index: AQHVzDd9dofq1wixmkSbfSHsuEOGXg==
Date:   Thu, 16 Jan 2020 06:37:57 +0000
Message-ID: <1579156408-23739-2-git-send-email-peng.fan@nxp.com>
References: <1579156408-23739-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1579156408-23739-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 618b9608-afce-462b-3130-08d79a4e9fc8
x-ms-traffictypediagnostic: AM0PR04MB4370:|AM0PR04MB4370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4370C46B8B6D83CDC127F55688360@AM0PR04MB4370.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:86;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(199004)(189003)(81156014)(36756003)(86362001)(81166006)(478600001)(8676002)(186003)(16526019)(6506007)(956004)(2616005)(26005)(5660300002)(8936002)(71200400001)(69590400006)(52116002)(4326008)(6486002)(66476007)(64756008)(66446008)(66556008)(6512007)(66946007)(316002)(54906003)(44832011)(110136005)(2906002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4370;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Us8rc4BFaEQAUjKLUYh4SdzVaQf44hX5WWd/RJZ2pcILz5YCQ/WsAX2wOrcdtF/ynMk4NhFp1vhX9XGbe4v6cXDOwdJqXq+lakDgZM88qFRCmOaUATp6qMqhHBCdHRTZ4wTGa6dWF+Lgz/5uYZMRG+P8HGYhx3AKkzYVvFdIX6Knt+gs3s9ZDg2o535W29fHTh8H7oyL3dpSi/ILTiV81yKFimxDYtK0UhHfACQtWlC3NJUyJZiTd85IlBtXH86lgkz/X/dXIY3wYd4J5qmulgB7DzRGPVGYs3wTVHglZU5n3MG2dOLXrX7G7h6v9tXrV/2YfkAefXas0fbpGYg3yOSERS9C0i2e6t48cyUwM8NY/A3ZM3imrxeVun9YXCxUUmrnR+ScEAj63x9VF54zQuxxj208l8pcgpNKNX5AoBBCcNgaKMwZQQJpu0yewKVLgJFNkHCOiPkfgHiJVZwkglSNEMDsm2XyKL5ZiDxsa5XKuvgsy+99cjgUyGr+hUhLEmFzXVDU6DLiyKD5A+qTw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618b9608-afce-462b-3130-08d79a4e9fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 06:37:57.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qM6ad6EMIz6VMRSUHaFKH/nHbn5LsqHUT7dNiVNQCxHNpeaGJiYSXOANR4iq6ebCK98AmrpjmbwxY1ewxkJ9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per devicetree specification, generic names
are recommended to be used, such as bus.

i.MX AIPS is a AHB - IP bridge bus, so
we could use bus as node name.

Script:
sed -i "s/\<aips@/bus@/" arch/arm/boot/dts/imx*.dtsi
sed -i "s/\<aips-bus@/bus@/" arch/arm/boot/dts/imx*.dtsi

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx25.dtsi   | 4 ++--
 arch/arm/boot/dts/imx31.dtsi   | 4 ++--
 arch/arm/boot/dts/imx35.dtsi   | 4 ++--
 arch/arm/boot/dts/imx50.dtsi   | 4 ++--
 arch/arm/boot/dts/imx51.dtsi   | 4 ++--
 arch/arm/boot/dts/imx53.dtsi   | 4 ++--
 arch/arm/boot/dts/imx6dl.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6q.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 arch/arm/boot/dts/imx6qp.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6sll.dtsi | 4 ++--
 arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
 arch/arm/boot/dts/imx6ul.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6ull.dtsi | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 6 +++---
 16 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 40b95a290bd6..1123e683025c 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -75,7 +75,7 @@
 		interrupt-parent =3D <&asic>;
 		ranges;
=20
-		aips@43f00000 { /* AIPS1 */
+		bus@43f00000 { /* AIPS1 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -332,7 +332,7 @@
 			};
 		};
=20
-		aips@53f00000 { /* AIPS2 */
+		bus@53f00000 { /* AIPS2 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 6b62f0745b82..18270ec648fe 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -63,7 +63,7 @@
 			ranges =3D <0 0x1fffc000 0x4000>;
 		};
=20
-		aips@43f00000 { /* AIPS1 */
+		bus@43f00000 { /* AIPS1 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -225,7 +225,7 @@
 			};
 		};
=20
-		aips@53f00000 { /* AIPS2 */
+		bus@53f00000 { /* AIPS2 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 9cbdc1a15cda..2ebf2c1fa682 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -66,7 +66,7 @@
 			cache-level =3D <2>;
 		};
=20
-		aips1: aips@43f00000 {
+		aips1: bus@43f00000 {
 			compatible =3D "fsl,aips", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -199,7 +199,7 @@
 			};
 		};
=20
-		aips2: aips@53f00000 {
+		aips2: bus@53f00000 {
 			compatible =3D "fsl,aips", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 0bfe7c91d0eb..d325658901c5 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -101,7 +101,7 @@
 		interrupt-parent =3D <&tzic>;
 		ranges;
=20
-		aips@50000000 { /* AIPS1 */
+		bus@50000000 { /* AIPS1 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -389,7 +389,7 @@
 			};
 		};
=20
-		aips@60000000 {	/* AIPS2 */
+		bus@60000000 {	/* AIPS2 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index dea86b98e9c3..6f608d9d9016 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -158,7 +158,7 @@
 			};
 		};
=20
-		aips@70000000 { /* AIPS1 */
+		bus@70000000 { /* AIPS1 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -440,7 +440,7 @@
 			};
 		};
=20
-		aips@80000000 {	/* AIPS2 */
+		bus@80000000 {	/* AIPS2 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ed341cfd9d09..8536f59f59e6 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -222,7 +222,7 @@
 			clock-names =3D "core_clk", "mem_iface_clk";
 		};
=20
-		aips@50000000 { /* AIPS1 */
+		bus@50000000 { /* AIPS1 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -654,7 +654,7 @@
 			};
 		};
=20
-		aips@60000000 {	/* AIPS2 */
+		bus@60000000 {	/* AIPS2 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 008312ee0c31..4b3a128d9260 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -85,7 +85,7 @@
 			clocks =3D <&clks IMX6QDL_CLK_OCRAM>;
 		};
=20
-		aips1: aips-bus@2000000 {
+		aips1: bus@2000000 {
 			iomuxc: iomuxc@20e0000 {
 				compatible =3D "fsl,imx6dl-iomuxc";
 			};
@@ -101,7 +101,7 @@
 			};
 		};
=20
-		aips2: aips-bus@2100000 {
+		aips2: bus@2100000 {
 			i2c4: i2c@21f8000 {
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 9d3be1cc6b64..0fad13f9d336 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -164,7 +164,7 @@
 			clocks =3D <&clks IMX6QDL_CLK_OCRAM>;
 		};
=20
-		aips-bus@2000000 { /* AIPS1 */
+		bus@2000000 { /* AIPS1 */
 			spba-bus@2000000 {
 				ecspi5: spi@2018000 {
 					#address-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dts=
i
index e6b4b8525f98..bf9d20f21060 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -294,7 +294,7 @@
 			status =3D "disabled";
 		};
=20
-		aips-bus@2000000 { /* AIPS1 */
+		bus@2000000 { /* AIPS1 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -935,7 +935,7 @@
 			};
 		};
=20
-		aips-bus@2100000 { /* AIPS2 */
+		bus@2100000 { /* AIPS2 */
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 5f51f8e5c1fa..93b89dc1f53b 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -18,7 +18,7 @@
 			clocks =3D <&clks IMX6QDL_CLK_OCRAM>;
 		};
=20
-		aips-bus@2100000 {
+		bus@2100000 {
 			pre1: pre@21c8000 {
 				compatible =3D "fsl,imx6qp-pre";
 				reg =3D <0x021c8000 0x1000>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 59c54e6ad09a..5b26c8d75626 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -143,7 +143,7 @@
 			arm,data-latency =3D <4 2 3>;
 		};
=20
-		aips1: aips-bus@2000000 {
+		aips1: bus@2000000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -786,7 +786,7 @@
 			};
 		};
=20
-		aips2: aips-bus@2100000 {
+		aips2: bus@2100000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dts=
i
index a1bc5bb31756..797f850492fe 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -144,7 +144,7 @@
 			arm,data-latency =3D <4 2 3>;
 		};
=20
-		aips1: aips-bus@2000000 {
+		aips1: bus@2000000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -663,7 +663,7 @@
 			};
 		};
=20
-		aips2: aips-bus@2100000 {
+		aips2: bus@2100000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 59bad60a47dc..98de781b8082 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -235,7 +235,7 @@
 			status =3D "disabled";
 		};
=20
-		aips1: aips-bus@2000000 {
+		aips1: bus@2000000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -830,7 +830,7 @@
 			};
 		};
=20
-		aips2: aips-bus@2100000 {
+		aips2: bus@2100000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -1188,7 +1188,7 @@
 			};
 		};
=20
-		aips3: aips-bus@2200000 {
+		aips3: bus@2200000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index d9fdca12819b..beb82d357f37 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -204,7 +204,7 @@
 			status =3D "disabled";
 		};
=20
-		aips1: aips-bus@2000000 {
+		aips1: bus@2000000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -771,7 +771,7 @@
 			};
 		};
=20
-		aips2: aips-bus@2100000 {
+		aips2: bus@2100000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dts=
i
index b7e67d121322..fcde7f77ae42 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -51,7 +51,7 @@
=20
 / {
 	soc {
-		aips3: aips-bus@2200000 {
+		aips3: bus@2200000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 568d7a984aa6..f959f69b0677 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -315,7 +315,7 @@
 			      <0x31006000 0x2000>;
 		};
=20
-		aips1: aips-bus@30000000 {
+		aips1: bus@30000000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -663,7 +663,7 @@
 			};
 		};
=20
-		aips2: aips-bus@30400000 {
+		aips2: bus@30400000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
@@ -803,7 +803,7 @@
 			};
 		};
=20
-		aips3: aips-bus@30800000 {
+		aips3: bus@30800000 {
 			compatible =3D "fsl,aips-bus", "simple-bus";
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
--=20
2.16.4


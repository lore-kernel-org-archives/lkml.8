Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E02C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEA720748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JydLF/BZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgAPGiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:38:08 -0500
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:49668
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgAPGiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:38:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyWEajqBr8/Hba48K2fmLWjeVBxXLPIC5DfxmF4pnlWyoUa6ujLjcbCBu/Dx+azCeY3ARoqRiNId88/ZjmWXkAwBq4W26/Qym5rOO8s3HVUjkga8oSzDjFJj1m+1okVlNttc2Mh1mmGZ1X0HobP/ZQeq6c3Ta6W0J4jVtMaB2q/iwga9VB23aklmgk7ESVOjm34AlpaWrmu05bx/bmKrXluU2Pv1ZqVXbZztLYW7mSs5iN0F+Q/kzoe2wRwxoGAfw7qGoTe8bkmVKIaCqK46jNO+dki4e3x2w/eqFFSO9dlqe54iUpTf8mLHlZduD5/w4meKyF5F1amIGgPJ/wVsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdclqX5IJWWP3MnKgWjzwYA4cg/eELb+VjV2JyPtfO4=;
 b=GcEfPmgRg/dOlsZflBp13ZlbfaHPaZwke4JPRXDpNyojB4nbkJSDTRH2SfFPtjZK8L900c3oX7lHHoJBllga5OoVPfgUMsd3/JGyeLVIN8jz2GZedHqJiBYPqxsyiDM5V4B4q7yrPuPXVCfNrWjvP+ALP5D20FNaczGhvypdB/mrA+H7nsADN7TdR9Z/PuTJIK1lyfHn3KSiLKXCqV3xnzbrACghVC5d4w51U+Vd7pUzKv3G4efQyS40SCTPqPDsii23c75aca7VZ8t+zuk4I5BXmVlDuKSEOpTmSKMxZxpWyyyWUo7LbsAdLtO/vhoGWmUebJBOvmhfg83G4v9t/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdclqX5IJWWP3MnKgWjzwYA4cg/eELb+VjV2JyPtfO4=;
 b=JydLF/BZc+/fyw/qvlHBUfFNBd9+cAO01I6dbO+z99jXWcIS4XLZGsH6bUko9wMkVU6m4ZIbmInVEDhMkvSFVnAJHMYA7PUTVCc6HUVOxzDB7Jf5O64CDuVfN4LOddIqqxgFFqm2reHIgeOmANGLsFPMDJz3U1qNBhDOdK9yyxY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4370.eurprd04.prod.outlook.com (52.135.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 06:38:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 06:38:03 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 06:37:58 +0000
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
        Peng Fan <peng.fan@nxp.com>, Phu Luu An <phu.luuan@nxp.com>,
        Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Mihaela Martinas <Mihaela.Martinas@freescale.com>,
        Dan Nica <dan.nica@nxp.com>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: [PATCH 2/2] arm64: dts: freescale: s32v234: use generic name bus
Thread-Topic: [PATCH 2/2] arm64: dts: freescale: s32v234: use generic name bus
Thread-Index: AQHVzDeAovkYo45XWU2J2Uelp2vE7g==
Date:   Thu, 16 Jan 2020 06:38:03 +0000
Message-ID: <1579156408-23739-3-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: ff6fbe4c-8975-49a0-cef9-08d79a4ea315
x-ms-traffictypediagnostic: AM0PR04MB4370:|AM0PR04MB4370:|AM0PR04MB4370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB437098F67DACE3F5993A019588360@AM0PR04MB4370.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:86;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(199004)(189003)(81156014)(36756003)(86362001)(81166006)(478600001)(8676002)(6666004)(4744005)(186003)(16526019)(6506007)(956004)(2616005)(26005)(5660300002)(8936002)(71200400001)(69590400006)(52116002)(4326008)(6486002)(66476007)(64756008)(66446008)(66556008)(6512007)(66946007)(316002)(54906003)(44832011)(110136005)(2906002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4370;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3t6LPctc7PRQigQ6CSblyxHVIWpgK62thOWJi9bXnpWfTw4ZlsHKdI1OVn2UKwb8nSYtkhTfC05jr98NwhpQby3aJBdEFAJx8C0tm9HDNU1MDQUUbUHpTDo/2fujgtGbbq4pUFWQ9ZyBMl+s8+T/oFTF25YITos+dpL1B5sap7/26mog2N1sWMY9t2G0A0E1rt6L3SEF33RfJo8wTu5Hy58Tg54tx1YghFNt+77z/C70WTF2Z6zr3r7oC4b3YVL8OcFFbAVjxy0TbcydwE+qkmV+q7P+e9EB0bV1pG5pcMQFQI7gqoUvnOv7CiUwyPsLw+1lys/wutObNhH/TEMN1TGGthwDFk+KkKLrysfeTGaRh7a9qQAGD97sqHwqqrlRU1Oow9z4UVxlsojIciVKV9kChgW0Ua5xWAqkv2ZdNoBsrapb/7d/E7NkZJT+wFVVfgPdj2eL5DncNEA9omwFcSiojEph6K3mIowLj59oTS10dgo9I4DUz6j2HHHZHgeWO7tRE051zERyltEAiIH0Cw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6fbe4c-8975-49a0-cef9-08d79a4ea315
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 06:38:03.4124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iL0OWOZVLbRlffsnTgJlnrISMwsT2kSl/7PfoEFUhyx3BXAor+dTAna6JVaDdFRkWWSIxSbTw3tH6ER3v7/2jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per devicetree specification, generic names are recommended
to be used, such as bus.

AIPS is a AHB - IP bridge bus, so we could use bus as node name.

Script:
sed -i "s/\<aips@/bus@/" arch/arm64/boot/dts/freescale/*.dtsi
sed -i "s/\<aips-bus@/bus@/" arch/arm64/boot/freescale/*.dtsi

Cc: Phu Luu An <phu.luuan@nxp.com>
Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Cc: Dan Nica <dan.nica@nxp.com>
Cc: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32v234.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/d=
ts/freescale/s32v234.dtsi
index e746b9c48f7a..ba0b5305d481 100644
--- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
@@ -104,7 +104,7 @@
 		interrupt-parent =3D <&gic>;
 		ranges;
=20
-		aips0: aips-bus@40000000 {
+		aips0: bus@40000000 {
 			compatible =3D "simple-bus";
 			#address-cells =3D <2>;
 			#size-cells =3D <2>;
@@ -120,7 +120,7 @@
 			};
 		};
=20
-		aips1: aips-bus@40080000 {
+		aips1: bus@40080000 {
 			compatible =3D "simple-bus";
 			#address-cells =3D <2>;
 			#size-cells =3D <2>;
--=20
2.16.4


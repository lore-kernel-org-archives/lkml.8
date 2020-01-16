Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C681AC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AA920748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsC4iNfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgAPGh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:37:58 -0500
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:15427
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgAPGh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:37:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwhYFkq1mLuGUIfVLT6Qyx1RdeGjLuF7L1la76E7FE/X7Sgjud/SG63umZwzuOEw5FFrU1ZYgXPvmhcF/IYndwixsg5hbh3Lgg9IJ+7IqZj0b+z2G7aWpWZRPmFVMhjv7yyuQUwMkGZ9AEcKGqSJvlXecc/hpoTjI8cMNSRJJDgdu3oA1ys0Ma+n/XXT0Ku9yiJ/uzzjge97oZLZCLU6yI5kqhmsFIVvFiVB0/ZQD8dORb8ISKxdhEgMbRX7vfboFy0V3sogMfvqOH6G8PzeJ84Z8ZWuvBNJbcc5GC5x88s+DgtC1lVRFUbXlFGiiFaXn7TRMp4YhGz1inDo+KrIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWl+hUGF9ckAuN43VKxP9OsVD7vvfBTMHCyz/GJGkYg=;
 b=WmYFkdA+jDLBuqmVFoPWd1SAZgrI3NJI2CuSMbDu3wqpMmFeT3n4VI+rdIM3hZNCvWopr/so0e6C/NJrUvNLyoBGL8FrLzfPAAaeeexOa9DJQs6nn+ZSLkq8AiwnuisCK8EU7KjIJW3EJqRZqPA93CDvJlrb/frNME20evPefnlCQ8I+dPi7kk+7+G9aSQHOkZeArni6S6pbfd+RKVxA/UjqsjT+DgrE1WBYDIfHl7eJdjVHsps/mxIc93UwQL8JxiGBM/rz/2w1LvZVvhl+KBf2WTKxyqUfV8Wn8+LX6Hb7uGyRulU4yskXUWNGmFWUtuourVwMSGwvj/c8z7Oo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWl+hUGF9ckAuN43VKxP9OsVD7vvfBTMHCyz/GJGkYg=;
 b=LsC4iNfT9zvB+sSMCSB4VHMynAIiHDypyuaLdss5To8It81TwoHx91t/eGmCitFAsP/u1JBZD92dDfg5k6CsSucduLE4oZLNggGGkoolVc+dIihNp/cVtQTkciUoNJraQAo5VBmU4D3P1evqfothCiraQc6xPw2X+UVNwEja/+k=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4370.eurprd04.prod.outlook.com (52.135.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 06:37:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 06:37:53 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 06:37:49 +0000
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
Subject: [PATCH 0/2] ARM/arm64: dts: freescale: use generic name bus
Thread-Topic: [PATCH 0/2] ARM/arm64: dts: freescale: use generic name bus
Thread-Index: AQHVzDd7U/Erk/HhqkertuIUqeUrsg==
Date:   Thu, 16 Jan 2020 06:37:53 +0000
Message-ID: <1579156408-23739-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6dcb5657-7c86-494d-607e-08d79a4e9d62
x-ms-traffictypediagnostic: AM0PR04MB4370:|AM0PR04MB4370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4370456FF7EEF7762807480E88360@AM0PR04MB4370.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(199004)(189003)(81156014)(36756003)(86362001)(81166006)(478600001)(966005)(8676002)(6666004)(186003)(16526019)(6506007)(956004)(2616005)(26005)(5660300002)(8936002)(71200400001)(69590400006)(52116002)(4326008)(6486002)(66476007)(64756008)(66446008)(66556008)(6512007)(66946007)(316002)(54906003)(44832011)(110136005)(2906002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4370;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1X18RuAoFmu3KN1Ef3kJfvclAjNIcypt1sDz5V87yyzzrzynrHgNXUzLJGBmzAd8udcFq/8Ynm5Jff3QN+NPTMXGCM05o0KT91zV8WqBS+caVdRgpxYV919Fad0Z8+8QjRJnf1cHyWxvWaTW4E1fKU1ocY9SNimKBKWdOkorMZUzKrT76nZIa9D9uHsCsOJ2hViS3OLFYSxlNpV8To3uAeulpokJMuiOVkgn6DhEC5ni5uTHk2/CcSC1cLUGYddBRwMYz5h6NDr/QMoNricDS/Hyd+cFIVbtyJ8M6D4acHs60uvRpc4D0BoGlmzMGixOat9E5qzsJmAvHyxxE6AOv+fo0WSG/9KSewQvYk4j8Z0MP4HA50b4jh/hAp7JfMv7qfo+1u9ZRc3mL30CRwXMdtcVZTiTphuyf5UC/sKHPB6zm+JQ2drkYbVaF1T7leBXQZ/qE/P6+HYpBmq4KLlawMRT8y21YKr1rrxVTmtkf+yqx1lt82prSJLYrGkMIVV4D2xvOEz029YLNQKOiiP0TXKsiiZzzAti9Kd+a6nm56DioHAB6DbIJSVb6xkYW8z
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcb5657-7c86-494d-607e-08d79a4e9d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 06:37:53.7279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeEUcyWRQtQOXiMKqyhc3rb8YymAsqYltgialdIVgyPf0Da69ZrafEY2CL+qo2jJO5M1RQTW1imJT292/tgZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per Rob's suggestion from, https://lkml.org/lkml/2020/1/3/623:
"use bus instead of aips"

Per devicetree specification, generic names are recommended
to be used, such as bus.

AIPS is a AHB - IP bridge bus, so we could use bus as node name.

Script:
sed -i "s/\<aips@/bus@/"      <PATH>/*.dtsi
sed -i "s/\<aips-bus@/bus@/"  <PATH>/*.dtsi

Peng Fan (2):
  ARM: dts: imx: use generic name bus
  arm64: dts: freescale: s32v234: use generic name bus

 arch/arm/boot/dts/imx25.dtsi               | 4 ++--
 arch/arm/boot/dts/imx31.dtsi               | 4 ++--
 arch/arm/boot/dts/imx35.dtsi               | 4 ++--
 arch/arm/boot/dts/imx50.dtsi               | 4 ++--
 arch/arm/boot/dts/imx51.dtsi               | 4 ++--
 arch/arm/boot/dts/imx53.dtsi               | 4 ++--
 arch/arm/boot/dts/imx6dl.dtsi              | 4 ++--
 arch/arm/boot/dts/imx6q.dtsi               | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi             | 4 ++--
 arch/arm/boot/dts/imx6qp.dtsi              | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi              | 4 ++--
 arch/arm/boot/dts/imx6sll.dtsi             | 4 ++--
 arch/arm/boot/dts/imx6sx.dtsi              | 6 +++---
 arch/arm/boot/dts/imx6ul.dtsi              | 4 ++--
 arch/arm/boot/dts/imx6ull.dtsi             | 2 +-
 arch/arm/boot/dts/imx7s.dtsi               | 6 +++---
 arch/arm64/boot/dts/freescale/s32v234.dtsi | 4 ++--
 17 files changed, 33 insertions(+), 33 deletions(-)

--=20
2.16.4


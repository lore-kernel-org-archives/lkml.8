Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385CC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894C52087F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 10:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mkT1jcMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgASKLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 05:11:36 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:46246
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbgASKLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 05:11:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A67cDd4OWG7sw4LKAl1S/7tWHCnJwxHV9gJl4H399OkX8pVtjxy5dS66naGZALjTmNi5OCmctt2Vp5Q3QfMxWoxL7ISsQjjzGTIC/0jo6hFxBsE/mdDbs8hEdoKZgLssq3rJ+V3WOT76N8UU/d88B0smnHepy5Jpe3DW2w1xijSWFGgV1Roh7j94xT0jOT83q/Aokn1U4/ROH/JNGVw3m8XGvEO8senA/naYNf67vEy1RwGmqT7obkyBsAIi1jEhFpueJtWBA7iwtLFODMHXiZs7JQZtd6d7V9D4Y8uEwOGSdeYxSK+qhZGX6hZI+s2OAfEB52DeCFKEqGv/suyH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBmX0oXHl3mLCKM3vt12XfHpIPLvThoU0574maatKDY=;
 b=mr0bmYiPcDBfV6+dc6UVH5+0UBWI+FS0I4sDUtz8tD+9sk9w0w7WwICJSb2e1v7Wu7pMpazYZSSEPcg0X7BNgs3CFY5BTDX8B0/83cUxluvB6W+NLk1AL0/s7AqhLfw0qgidHrYTzYPQIJe0INijjviCMcV1juwyF686P7tCqAJmcEGM4Xq10ePgs77cmNP5friNfe3hcNtrx260DdZj57qQriLVylvm0AeKLyZp4NIu2WbyxYvhd2UnJLEeyoyh9n6cQoqHJ3USsljWkKT9gRIRt9PLbh5r4JW3Hz4Ms9RrpKlBvi/I1Sn2Qr89ztck69A+Mk2TdM9VDureSoIlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBmX0oXHl3mLCKM3vt12XfHpIPLvThoU0574maatKDY=;
 b=mkT1jcMFlmoZiUJn41KsuwOwC3sQmDkEs0OWjpg0ftE6A/XDTfQ285hFUH0xEnSgAPovAKpiW+pCHqPHhXYEjPwbqPD8NMusj2Y3Wamj2grvBIjH/SQg2N5ZDmmpRdxYisYwtT+1OtNL+zZvtZJf2LebWeJoEBfcLDZ425gUw4Y=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0SPR01MB0058.eurprd04.prod.outlook.com (20.179.37.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Sun, 19 Jan 2020 10:11:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 10:11:32 +0000
Received: from localhost.localdomain (119.31.174.66) by HK0PR01CA0065.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.23 via Frontend Transport; Sun, 19 Jan 2020 10:11:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mm: drop redundant interrupt-parent
Thread-Topic: [PATCH] arm64: dts: imx8mm: drop redundant interrupt-parent
Thread-Index: AQHVzrDSsTSUbG7Zs0OJCGW8FrFIzA==
Date:   Sun, 19 Jan 2020 10:11:32 +0000
Message-ID: <1579428407-9981-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0065.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::29) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f95858c-c1eb-4b2c-85da-08d79cc7f507
x-ms-traffictypediagnostic: AM0SPR01MB0058:|AM0SPR01MB0058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0SPR01MB0058696D4A1E2C4F56DB7D0E88330@AM0SPR01MB0058.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(66556008)(66476007)(66446008)(64756008)(2906002)(16526019)(186003)(6512007)(36756003)(478600001)(7416002)(44832011)(26005)(66946007)(6486002)(4326008)(956004)(2616005)(8936002)(4744005)(81166006)(81156014)(6506007)(52116002)(6666004)(86362001)(5660300002)(316002)(8676002)(110136005)(54906003)(71200400001)(69590400006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0058;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ux3v6zAVBXNcQp93Paod4jdjcSna6i0MVieBWA9fU6qFLUOuiZtjhosWCH+7Sesrl7CQsOlTHda0X1acNs9N9ZKb3vV1pdXt4PaQc/7ELZt+kBvZhhF9y7gkSZMRWXrtNG2BuIZmw1Kg7Pf3W+03Josaxu5mE950kjZAjWYcbns95L8vTW0GXmffo5CSiapyraDGOCSQGXJQ0UDhj7ZokNR9dCZK1CHEbomKCfyUXESpbxxEiGsKLc1aON+4ga6jr7O8/PQHlTlyR/mxE0INPo9cw0KEy1KC2RLOIzqLum+rBPyLx55dBe+Jz8zOh3O4drNAwzSseF8tkxViAsAozF1274fpnfHDkrEHxWJUmccinUMFiTws93uvC8riZPHb0lP2wpUmiOnYQ49fGSBFiEtOMhwGYi/f86VdPSmEb2KR6kE0jhcI42lsQ43lBMtA8MIx7ykFtjYOrLNFKMw8vaxCAxrYgGJO8JCU4Gec4fZnVT1A71yjaY6EEfuet2S93DZyTg9grQkVUDt4/aavSA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f95858c-c1eb-4b2c-85da-08d79cc7f507
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 10:11:32.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFB9UMFNL6+uufIT6sNiglpLoBdyeQvhjJ2DYDwqTVOaB8u0AI8j7elt9lCzzNOyQh/Dk8oT8FZHMr6AgrTgyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is interrupt-parent =3D <&gic> in root node, there is no
need set it again in node ddr-pmu@3d800000.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
index 1e5e11592f7b..b3d0b29d7007 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -896,7 +896,6 @@
 		ddr-pmu@3d800000 {
 			compatible =3D "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg =3D <0x3d800000 0x400000>;
-			interrupt-parent =3D <&gic>;
 			interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
--=20
2.16.4


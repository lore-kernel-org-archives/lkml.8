Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CEFC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88662073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rzxuKWom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgAJHUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:20:35 -0500
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:53825
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgAJHUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:20:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heTh3GYlVD0II8yZCg2yZwNbLeG27C2WS+Kie+7b34u/V+ucdEd/JDsnUPFFquJIe54/cOUa2V8CboOO6OjF8QuYJpj0647k6Tu+BxuGOkiaqiOIxdnOgttjKqOm5tVt/x4VslgCZCcZLCcK2/xXmQe71WXqyBcNz89K/s4tjCPDgkeRszFAYtgQ6opEqtHriWEPN5RK/qInmymbCYuUwDxQm+GPONBEyOKasbVyvYS/9XOUk4dVA3zcSriBwCjGGNNFi5G1UPMXUIp6SEqHkxti3lmyn9UyMHfpSfD5Z0ep7+O5xX7YsZeom5ImtiU0hxMRHnd+dSLMazh6yPBqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnkKQt3vdgpBM/xHrsBcM+Zufm/rvMErBTTEyXTldHI=;
 b=Wbwymge6HaWR5pxhSCj12DRFMY8ZvuEm0x3zDAoxkcBPXM9V6zDJGaQuyaeaMpPowDu0u6y1HHMRx9I4jAkiozDSPnBPuSLGOt5sfVYLSKVqyKi/tV7w0F/ch3arWJxyq7x/dXuPHh3K+/Ld6kzRFSPN7UQ787LXxuw2S97AxNDJxMnKLil4yz+d9o14irW238no7WnQRva3WN+LXlD5Glf6g5ayBQ0pLKjIiPCqcTmMgIdobWjF/jMyuwE+glNE2/I1zQljJCsVR/hIG8crPx8OZ+nepip2Z/90tpa0RYCxhcnzhFjdgvvzmsbsVcOXv3zblu0jC2bDXa8qPJNFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnkKQt3vdgpBM/xHrsBcM+Zufm/rvMErBTTEyXTldHI=;
 b=rzxuKWomOlFsnpliH254E41/J+rspvGKzFzo91RTNdrARoYe5aQgM2yGQfS5CVfWyMkR5xN0+6mskEIbYnF/61wSh73zMkd08yh2cIWSss3gGGwXMBPHhkhxPtlZYUFUsdG4SOR62PsGU4FpDWEYFo6u9X0zSRAm91qZwVXc7Z8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4162.eurprd04.prod.outlook.com (52.134.95.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 07:20:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 07:20:31 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0009.apcprd06.prod.outlook.com (2603:1096:202:2e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.10 via Frontend Transport; Fri, 10 Jan 2020 07:20:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mn: Init rates and parents configs for clocks
Thread-Topic: [PATCH] arm64: dts: imx8mn: Init rates and parents configs for
 clocks
Thread-Index: AQHVx4ZxYo+CJ71kh0mLSYhdPwN+wA==
Date:   Fri, 10 Jan 2020 07:20:31 +0000
Message-ID: <1578640589-17210-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:202:2e::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ec1f691-7f5f-4517-62fc-08d7959d9350
x-ms-traffictypediagnostic: AM0PR04MB4162:|AM0PR04MB4162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB416296A93527717E46DCCDB288380@AM0PR04MB4162.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(86362001)(4326008)(81156014)(81166006)(66946007)(316002)(36756003)(69590400006)(6512007)(71200400001)(6666004)(16526019)(52116002)(6486002)(8936002)(54906003)(186003)(26005)(956004)(2616005)(5660300002)(6636002)(6506007)(110136005)(8676002)(478600001)(66446008)(66556008)(66476007)(64756008)(44832011)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4162;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wEUjmdBdUi99hUfggAd4bDZ3S7Y/j/qkH6RVnjyUhFz8O8jhrX0W53hjdUtVtdMwCKHaxODELDT8AgRVFqLxcuJB/QUnqYhA9OMYl/yEbryOJJZOPwe8ojP+3VUCX4qVUYO7S+jKWQHbXQ8a10ZH54mxlwkp6qQzkfBdQTtnY1g/pBlZvpTrLLsNK196HFbSRk5YovTISm/oAwWFhQWl5RoZRExSwIztatk7Ovq+yjn6UJGVo6gJxJXtgFfBgMQ/mfV6lJBvoqis7OPD9X9MkO393m2tQhKLpj9xzMEuxiLLgyyyUFnlJSaIyLq9MvzcN+mJWre29DB8WKqA7S7rWk0elOjr+ry7P12hjEU+HUvJvOnsVy0iDDyIXV9p7LHJv5AAHm+29Ao881+X2aruYnXHxHnt20g39d5j3i3Lbu25/uAAGMsYyqh2Es+UTK+t238TGEX/lKfvvdC5dciNg7DOahY7F/m7xVGRjNuWG1Ns9fduBIXAMCATak1V5/svp1rU0tRQ/hnVVqxMLJFoMw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec1f691-7f5f-4517-62fc-08d7959d9350
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 07:20:31.4055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMphcJAmHp5fXruGEso2qSK0W32bmiNnZzjiKYnj4g4q2h8In8tCzCWWK+PZrfnDcYZYIgQ3jYTMn+vu2BL5Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the initial configuration for clocks that need default parent and rate
setting.

NoC sources from SYS PLL3, running at 600MHz. Audio AHB/IPG clks needs
to run at 400MHz for better performance.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mn.dtsi
index a44b5438e842..0a62a478a930 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -379,6 +379,16 @@
 					 <&clk_ext3>, <&clk_ext4>;
 				clock-names =3D "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
 					      "clk_ext3", "clk_ext4";
+				assigned-clocks =3D <&clk IMX8MN_CLK_NOC>,
+						<&clk IMX8MN_CLK_AUDIO_AHB>,
+						<&clk IMX8MN_CLK_IPG_AUDIO_ROOT>,
+						<&clk IMX8MN_SYS_PLL3>;
+				assigned-clock-parents =3D <&clk IMX8MN_SYS_PLL3_OUT>,
+							 <&clk IMX8MN_SYS_PLL1_800M>;
+				assigned-clock-rates =3D <0>,
+							<400000000>,
+							<400000000>,
+							<600000000>;
 			};
=20
 			src: reset-controller@30390000 {
--=20
2.16.4


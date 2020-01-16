Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F7EC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BB72075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="US4K8Aps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgAPJg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:36:56 -0500
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:6114
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgAPJgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:36:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED3HeCh895ZxaGNyYX48sqg4/4al1WELIxBqms5RJ5pCiKB43lwkP5A6PXZVecV9W6JeaHuZ75yi/QwgCMNSqHhn+nMw3A9FtACJQDPVG0v6LKNvstfxRW4e0otjLUSFpoeNPhfo7vCuKFt5wZfK3xGQ7D9YR5/Ttag0s4IY1R5Z4WS8DVV3GQfGoxOKzGhiqWCGD/ahtVOLXxxKGgfpzQP6uOruarTtilKKnHrOUOB9Ch9wlztPH5TqHhqUwaJ/DiqRI+f1T5EBfNbE77SiGm3m8UHBzRWcymVmTdjIrvSbNZu6XzEdIp3MzrAyvqb5n3Y6wnNjd61lql18OQmmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QANZ/0sdNkmcOgoO/G0FOwceTWYpZY88EkD6FW4Y0jQ=;
 b=koPbCUho6cjr6DRzY/evs4TBzvKMnXBfkRyGdISMf9/BAPC///I11oCp3s4Jtprz3kDbw26cx/djiNW8HYFGEG71ZiVboayJQO2auODederiho1iEWeWUe+i+0+WeWahCxLTav48MulJKsdMzkGajanVYlECp6J7DhAE7O911r7SSBr3NPdwcej/Z2BnLQMKpMp4OG/4Hy8A6jrx2ZIt2maUaE0Xzd/pvxrn0hn7stzK9HICoUK/z6qyGuMLyWadI7Qh2nXKBJFoslyih0+V51kGQYmvSc3Bm3n5fe+If3UWWLr2uT03uZsyM72pf3rnxJ9Q/9YbHoMyaLvSvcKdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QANZ/0sdNkmcOgoO/G0FOwceTWYpZY88EkD6FW4Y0jQ=;
 b=US4K8ApssTvc69CSRITXtUI4TdccLf3aAmHGu/dHSADfe/R3/4nR/id3I/VZO+o0olHxKj5ZMcMkiOA9chVmOOT4adOZbefFf0iTlW8NRdxRXHglZDeu/63w5f1AMQnDf93oN5JqEypz1U0agkKy5Qp9YnFjF0vbn5P0LR2GSjg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4337.eurprd04.prod.outlook.com (52.134.124.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 09:36:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 09:36:53 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 09:36:48 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "git@andred.net" <git@andred.net>, Abel Vesa <abel.vesa@nxp.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC 2/4] ARM: imx: cpu: drop dead code
Thread-Topic: [RFC 2/4] ARM: imx: cpu: drop dead code
Thread-Index: AQHVzFB8b6e6R1l3A0aB7jlzoE7ofA==
Date:   Thu, 16 Jan 2020 09:36:53 +0000
Message-ID: <1579167145-1480-3-git-send-email-peng.fan@nxp.com>
References: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6931b8e7-9be1-4282-c67c-08d79a679e8a
x-ms-traffictypediagnostic: AM0PR04MB4337:|AM0PR04MB4337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4337B2C23822D9F4554DAC7088360@AM0PR04MB4337.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(8936002)(86362001)(69590400006)(71200400001)(6512007)(186003)(16526019)(52116002)(956004)(44832011)(2616005)(6486002)(26005)(6506007)(478600001)(6666004)(4326008)(7416002)(2906002)(81166006)(66556008)(81156014)(66476007)(66446008)(8676002)(110136005)(316002)(54906003)(5660300002)(36756003)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4337;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUAIbWBpTUPOoCVa4qLpaSnl+U2PXtf+OP0X7HgYG1x7jMtXyVcMEr3VAzT8MArwVLOJHQKM2A/WkAyitttVEOOxXiIi96W/GKM/W1wtA3eQ7tsFQwN4l6hOSWgxrmFOZmZ7oInN0RjfFXrAiunzu3hccm6rUrEUNOFJtnPQZT5JDue25T3YtksGl1tWqZENlJFPCD6o3A5WOaPSebGE+oJDR7uSErLEr7TZiAvMorlGQ3gI848BxkJlhYsX7IdQwVuLCSS5z3xEuQNI2d8DuH7DjMqlFnnDMsBzhXiUdgvo10B5bye4UQ9AnhFNb5Up8UCTbn4d/hOmdfa+IF4I19tzpvdiTKTEBAvCQCZs/Ph8kLCqp52ipzv3jG6rIWl0+SZ1syxilEWZfl3lgOohfGI6QYuy43YbScCkM/J2pa+52HHSPRXS4Rc5axkoamXVqbj9Sh1W5cjuSSa8rkQXtB8SHLPNA5cyGlAiZKm5gWJzng19xeJD0iG9PLGKDl7R
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6931b8e7-9be1-4282-c67c-08d79a679e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 09:36:53.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUHME6ycwLYmsYqZogSTzwgJqr/Zuv3raYf7mJuQexhsXIXEfufuE+6MLPXTjr/iwWA/kzEuc0TPzsBOM0GTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

imx_soc_device_init is only called by i.MX6Q/SL/SX/UL/7D/7ULP.
So we could drop the switch case for i.MX1/2/3/5 which are dead code
that never be executed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/cpu.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 2df649a84697..0302cb66134b 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -108,30 +108,6 @@ static int __init imx_soc_device_init(void)
 		goto free_soc;
=20
 	switch (__mxc_cpu_type) {
-	case MXC_CPU_MX1:
-		soc_id =3D "i.MX1";
-		break;
-	case MXC_CPU_MX21:
-		soc_id =3D "i.MX21";
-		break;
-	case MXC_CPU_MX25:
-		soc_id =3D "i.MX25";
-		break;
-	case MXC_CPU_MX27:
-		soc_id =3D "i.MX27";
-		break;
-	case MXC_CPU_MX31:
-		soc_id =3D "i.MX31";
-		break;
-	case MXC_CPU_MX35:
-		soc_id =3D "i.MX35";
-		break;
-	case MXC_CPU_MX51:
-		soc_id =3D "i.MX51";
-		break;
-	case MXC_CPU_MX53:
-		soc_id =3D "i.MX53";
-		break;
 	case MXC_CPU_IMX6SL:
 		ocotp_compat =3D "fsl,imx6sl-ocotp";
 		soc_id =3D "i.MX6SL";
--=20
2.16.4


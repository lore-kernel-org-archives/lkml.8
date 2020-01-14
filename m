Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732AAC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4518D2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HvDGeLxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgANIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:08:49 -0500
Received: from mail-vi1eur05on2040.outbound.protection.outlook.com ([40.107.21.40]:6086
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728992AbgANIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:08:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgz6Ddtb+KohO6/DQDghWz5HTWoby3WoP8ZxBgIdHkeX8I15mWU+dx+JNXhtn7Ox8kjGwSmDEIPwXRRTBtL6lSSjEa9sMCZjNNecTw9eYPJi6xh9ofGJoU5dbqW51feaRzOUgPrz+wSaX9xF8awZyjGaY8WHzznwLkbPbBr4nayZbW2F+fC8T5arNmZ2/75NYkmybBkGc3pJE59bp6nI//o7Ta1Qv1olwWmdscf5L6ptf/HCPO/I0f0Z54zeiNWQKlWLnrI0DRrkaPmcNSULzGjNUk77wSj14V01TNmOs3hkDG7sbMnDKZaMZy2adxrOhCqGC8sy6hxx6r8rWfnyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FgX0zBwYj6iYY93bfqzoEiz7zbrt8goH7bFS0KQB8I=;
 b=nmQ+FhFlc+Ia/E0SHHTeHdy4sjgAYMPrww9oNICDL1vsqjurutHUY796WnGKnD7xy1b6RcEv198dDWwaz9JGj0mR2JvIGwY8LLLg75+/3FbT4ETsHDDnbpoP7OVYTymz0pTby7U56PU+wrepZ1+pJhBWjxTTlNaTM8l0fmw2bDReUUZSFWkLEuW74EQ01zFZ/jbTeDP678r7Naqql0XXzLDpMa3GrFVIhcvdg/iMo3dJYpaPG/eBl2RTN9mrpj9oCtVYx7sbkE0nvc2bo7eYpth1poAQKkOfo/YfAHKOdrwby/Ys6hT1R7246HMZmquxPy9dszYpzClsL/szC/Y4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FgX0zBwYj6iYY93bfqzoEiz7zbrt8goH7bFS0KQB8I=;
 b=HvDGeLxmtMj1adCoX4r/wI4ar7lpbsiUHKKKiwhxF1WkIzVBSoDGxvKiJzacJcQlNn+HsF78tC3K+2Dv/rDDIY8D0spLjjnxiK9rKZw5pVtuXL2Efr+vtHE00kxNFAMUDX+5OiYemZnccuJJDnFwcRjAOHo2Kgp7OcpMrIN4/To=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5153.eurprd04.prod.outlook.com (20.177.40.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 08:08:45 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 08:08:45 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0167.apcprd02.prod.outlook.com (2603:1096:201:1f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.10 via Frontend Transport; Tue, 14 Jan 2020 08:08:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
Thread-Topic: [PATCH] soc: imx: Makefile: only build soc-imx8 when
 CONFIG_ARM64
Thread-Index: AQHVyrHXB0HrD3qW50ui9P9S7z/H8g==
Date:   Tue, 14 Jan 2020 08:08:45 +0000
Message-ID: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 952430a8-3ba9-407e-779c-08d798c8f981
x-ms-traffictypediagnostic: AM0PR04MB5153:|AM0PR04MB5153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5153949499340B7B6292089D88340@AM0PR04MB5153.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(16526019)(956004)(2616005)(4326008)(36756003)(6666004)(44832011)(478600001)(2906002)(71200400001)(6486002)(8676002)(110136005)(6506007)(52116002)(4744005)(316002)(81166006)(54906003)(5660300002)(69590400006)(8936002)(66946007)(86362001)(66556008)(64756008)(6512007)(81156014)(66446008)(66476007)(186003)(6636002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5153;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keW4uyMQ++CY2FQhK8xhNaqKFhYsXJ7l7f4tbsfw50vjTsAZQR4+CWb3ttTBO4s5g7eGQjsADZ7IYqPlAr6lRpn0ZH4l/FCbSM3f1MMYDxsdN1/Q1A9ydevYWNg5NU3wiamaQ93VjQ6ZlKke3ftdszvgKYk1uXzIF1JRwI/3R3vg7AUD0KGGpRwEGjaHA8TyUZ4x0TXY+N3886FXzUwmFDOFiEMX48zUUxf8EGQGhtXhypIZ7FV5nlUuaQHY3veo5Cnlpyw6B4DvcUIpk9sJR+nYjDY0U5zVHALj3Ix2sEN8rXm2YXB3XwuJTok8EmrraDHaGQA2k8mx4kznVbHr19VcpQHTy7/L+wYIJehZ1wC7aPDZ2l8XEqI8+lvbacDsSRMTE8RzEk3hezi2ZrXbxggv7vgprEqFttOd8Pq0CeyU4vGARQkL2vYSn+TkjiJ00quu3phWX3KOLaPMAbJZtB3obLcHaZvv/o+Qpo6LkNZ7vlisRFtSqnaiAanyKNZy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952430a8-3ba9-407e-779c-08d798c8f981
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 08:08:45.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8niL/XWMSalKCU+tefQb8V8x66uI+G/vNYdog4LeIZVArwmja0dTeauQmHUvRNaOLvOEH5Dsw46gRfxlr1StPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Only need to build soc-imx8.c when CONFIG_ARM64 defined,
no need to build it for CONFIG_ARM32 currently.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index cf9ca42ff739..cfcbc62b11d7 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
+ifdef CONFIG_ARM64
 obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o
+endif
 obj-$(CONFIG_IMX_SCU_SOC) +=3D soc-imx-scu.o
--=20
2.16.4


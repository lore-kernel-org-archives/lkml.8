Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF4C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA085207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CEjvtLoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgBUCjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:39:06 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:34546
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729321AbgBUCjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:39:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljxrUqEqh9kIaQrVAwcOO2+UBdNO1TCVzL/NjYqeFcWCFjMG4VACn4I71KMAyKEuM1oi13rM96RgN/4ku4LDuta/5t+6KH1F0KDzXIPU9VdsDMrWZlpIwU8onkiH4y8FM7gM/Ed5+HgGGLNQfckEYr2eSvtldbZAT6iWoUAWYW88UvJzt6WzS50uSMQHdMk6sZqY+YucrlT6p28oMV8PbEmbx7KBLTrTEYyZ8ChfwwK7v5VhojTEV11Igz2JKw0sKi6E0/ZcbKim+4Z8Tvdd+vGIexL+BiBwM3AnpnYDk6kTZj1YwF9Ykw2yZ6AI6wbDUwu3S6qBgHZFT9fcXkwI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DoQ2c0wWcVtlw44EiO8dgJ20B75pVwEVOAPkPcH9fA=;
 b=kL/B9ktlTUWLSCX6ZRclBEjIUhmnvX/9YuD8L3zelJBB0X94CEJCpGN3lWWyOrdejbSNizKiZgfingDtHObauMzoi0yCNHfrs19DrvRoAxIlWdY4prqmDxrelE/8WLIVKrvY4ckH3zhjN2HPgchJopMZX9cjyDoGhjstZ3WaXNW7mZQFNR0vubjxueKfROxuSEWy2hQ3cDXIa0OA7GbiKdD7ks/FMsqmCq8GyM/Ic7YXAXtJDsKdAzPmNYQh8Fhx1X8Y9aqhhCKySNTtSUwjQ2TMySir3IL0zm9N0MfS6EAd/bUVwn4Dh8hbw4ktWizewyeR3klgsYd+AggMKf08Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DoQ2c0wWcVtlw44EiO8dgJ20B75pVwEVOAPkPcH9fA=;
 b=CEjvtLoh/EMHqWVbWUIQ70d0tAkunLoJBL2jkCZ9wwZvoENv43VVceVQolc+40ZTsp/q54PwQOulvZBlWdZsxcNEc8e2nW9Jd3U9s4UxidvfjaOmhVB7ql5OBKvnDoIg2PfESGvsQuvHQBnK24x9t6o8zs0U6mct1UG1+6XwEm0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5281.eurprd04.prod.outlook.com (52.134.89.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 21 Feb 2020 02:38:28 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 02:38:28 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        olof@lixom.net, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 2/2] soc: imx: increase build coverage for imx8m soc driver
Date:   Fri, 21 Feb 2020 10:32:19 +0800
Message-Id: <1582252339-15733-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582252339-15733-1-git-send-email-peng.fan@nxp.com>
References: <1582252339-15733-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0057.apcprd04.prod.outlook.com (2603:1096:202:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 02:38:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b1ced16-262c-4e7a-6bef-08d7b67721aa
X-MS-TrafficTypeDiagnostic: AM0PR04MB5281:|AM0PR04MB5281:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB528130FD3A798CD91947CD5888120@AM0PR04MB5281.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(2616005)(9686003)(26005)(4326008)(956004)(478600001)(6506007)(36756003)(5660300002)(6486002)(6512007)(16526019)(8676002)(86362001)(8936002)(6666004)(52116002)(69590400006)(2906002)(186003)(66946007)(81166006)(66556008)(81156014)(316002)(66476007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5281;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyuM6WgTO29dWQRADM8WTrA54CT2USCYckef7YDa81NIPuOYK3Zz/fTuWJU0k6ffAEq4t6o5w/+v5Evu35XBX4a4QyWfczjIhtoVFKTN7mSY1CzGIf9OgtaLnUWzM9R2GAmhq6EzzETT2mDTpE/zV4n5CdYuKfmkTm/1HiZQ3TxW2koO50xXGOOy3sbDsUXSkNTjzkPA4rDMUO0I4e7tzNvvaKRjRS8PXDA6BKpwFk6rB4cc1SXFvYPpQdclfBTybXVViDhC1ImKPqBRPZrNwQrWrGGgUtviuZzxaZf19dvbX2gu+wW65999oVhsF+LzlFWl+kuQtpqDyIp0od8QNj663FvKj4yqSr06iPmOyB6XsYilU1F/PJCeR7yvN88hI8HmsZs7d18FFCQlrOS5X3nKMOdqRbQkendALYjFpU5AjQBEMsO5kKUyD7ze2WsJa/YHElBOUNwMIAfgZ7CpKMHpolUNDvzHfu64i8sTXr4URn4klE8ISYIgiQDRxFKIZMiOnT0Se5yPbX3b1kY3WLv24jaJboiM2aiABTe8iaEK4jf2DfWIdYtsd9fWxL0F
X-MS-Exchange-AntiSpam-MessageData: GiRT9MspXr3FcS8Yt1SUUPk+c4zWT3z4v4NJ14oK/V4F9H3ucF9aiHUbBvfrJa7L1AqMILpYAUkAfWyeIKN8k+6HQWkGlO5MXVgb+aCujkzob0b+Bh5UfwdGDW3E573s98Od/xATgfUTrCYYP+S4/Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1ced16-262c-4e7a-6bef-08d7b67721aa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 02:38:28.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrvTh/VooBOhReNdE4PjSBflCqjB7XV+d5je1yMZa7O04R5o3c0QOIJazfvt/Ln7XZvZhG6MWGXypUoOQVf8cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The soc-imx8.c driver is actually for i.MX8M family, so rename it
to soc-imx8m.c.

Use CONFIG_SOC_IMX8M as build gate, not CONFIG_ARCH_MXC, to control
whether build this driver, also make it possible for compile test.

Default set it to y for ARCH_MXC && ARM64

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/Makefile                        | 2 +-
 drivers/soc/imx/Kconfig                     | 9 +++++++++
 drivers/soc/imx/Makefile                    | 2 +-
 drivers/soc/imx/{soc-imx8.c => soc-imx8m.c} | 0
 4 files changed, 11 insertions(+), 2 deletions(-)
 rename drivers/soc/imx/{soc-imx8.c => soc-imx8m.c} (100%)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 8b49d782a1ab..a39f17cea376 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
-obj-$(CONFIG_ARCH_MXC)		+= imx/
+obj-y				+= imx/
 obj-$(CONFIG_ARCH_IXP4XX)	+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 0281ef9a1800..70019cefa617 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -17,4 +17,13 @@ config IMX_SCU_SOC
 	  Controller Unit SoC info module, it will provide the SoC info
 	  like SoC family, ID and revision etc.
 
+config SOC_IMX8M
+	bool "i.MX8M SoC family support"
+	depends on ARCH_MXC || COMPILE_TEST
+	default ARCH_MXC && ARM64
+	help
+	  If you say yes here you get support for the NXP i.MX8M family
+	  support, it will provide the SoC info like SoC family,
+	  ID and revision etc.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index cf9ca42ff739..103e2c93c342 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
-obj-$(CONFIG_ARCH_MXC) += soc-imx8.o
+obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_IMX_SCU_SOC) += soc-imx-scu.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8m.c
similarity index 100%
rename from drivers/soc/imx/soc-imx8.c
rename to drivers/soc/imx/soc-imx8m.c
-- 
2.16.4


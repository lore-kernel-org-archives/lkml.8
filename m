Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F9C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F05208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHbTLI7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBTGbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:31:05 -0500
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:42308
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbgBTGbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:31:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSl6TMNcIUKOAHxdA3znBJ7kskzpyRhkR3xdc2W+EclIyB28/JP9wbnbL9yaxzEmDLZQDelJNEf/H9ctuKE84TVJKQu/Xj6Qw66sPY00UEdIQA6Cx2aJdMv3HtaPYWtPwTNE+G0NGGO0OX4Zw2a1eNZz4iw3qSOEvriGV67Eu3py9bgCoKLxMrSozT2q4GDGiGWAQkRau6zzC+9YUPA9PhKE7xbOLflc3km/hfZhI7FFbpaQClvc92kpnv4dvfb8qNvvldQ+5+gCFw4CdXWBxCiCpBpIzX6D8vLmhIApJFEF+CZ74aEDq+qw/bYCAsW2TER9zQZcs1szY+mq1H3TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DoQ2c0wWcVtlw44EiO8dgJ20B75pVwEVOAPkPcH9fA=;
 b=NkeGw/oX0dcMfm0RgBOhdPOmtSYHGtpn+PgAHq2PgGG01cYvI2D0+QUjA4GhUPeq71F/Nki3TmIWuO40hUv0A+79GrKSzQbwEeBvi0MIWIh1bcJwHI4GP5yt2idxvdpPRyT7Ip5nQ1/p8XjtklElv6AXe//jN93gKE5agLhOXjSmktDB++dmJXq9VTAggm1IZRzuquuHx319Pfuzcr55R0OM4uORXtNO80l55traMP7o8WuxUO+1XJt5JEaZfWJVCfYXij2PYtsHwB0Hp027KcGjElslMUzZ3mSfDEnSeVpAyaea0Z+3lG4KL9Rv59PCGBO1gmu8xLmlsgvSVBVRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DoQ2c0wWcVtlw44EiO8dgJ20B75pVwEVOAPkPcH9fA=;
 b=DHbTLI7Z8bIM9Ctk8z/Tf5xTe/+kkGg+o82h+WiY9QqvudFMAr99LOzTnYY4mnjL7d/zqNbTsrLEhj4YXc7+NmTt+WLOaoIDHBeRxmx++NDMwiBXV1xVXaynFckUNJO7To7Hpei/Wz9puPaqS4ypEgr5xnIR6bBOZ5szvALVHEE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4860.eurprd04.prod.outlook.com (20.176.233.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Thu, 20 Feb 2020 06:30:27 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 06:30:27 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        olof@lixom.net, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/2] soc: imx: increase build coverage for imx8m soc driver
Date:   Thu, 20 Feb 2020 14:24:03 +0800
Message-Id: <1582179843-14375-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582179843-14375-1-git-send-email-peng.fan@nxp.com>
References: <1582179843-14375-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 06:30:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87f28521-a8a7-419e-e7dd-08d7b5ce5f8a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4860:|DB7PR04MB4860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB48607946E4DCEDA6456842A188130@DB7PR04MB4860.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(8936002)(6666004)(66946007)(66556008)(66476007)(81166006)(5660300002)(69590400006)(81156014)(8676002)(6486002)(9686003)(6512007)(4326008)(36756003)(478600001)(2906002)(86362001)(2616005)(16526019)(316002)(956004)(186003)(26005)(6506007)(52116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4860;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyZf88UBonv62gk8mOvjlhnDu3KyAX8ldpnEARUVrlQDa+ru3I5DBonPucyQBB5hNkwhntuhcd7yKnjGihKmm/s1ZcDFVrKLF0RHJgzwtjOAwLvW7Gj5hR3AU94BVBpJ221s8jXiYKwoPHi+nd4mRqbTmmwdNLUUOQVK5/Xls/qGeaJkyAPmn7ENT/RK6PqeSHyiUlxkJETDcQTaFTImdPMMfMRFApMgbht+b+9FBjlg6IrRkPSXwJ52tDfcGOtybCS9v9vr8yZtCLU3cfwKnod8VUwUCH7UPA/V3h7W7xchIRpQ+SWvd02kq+XXq0nyFIa4fYCOdMKzpcjdCr31Nx6m+dfgUPj8Jn/4CNk0qseugxbpmV5aYeKRKNac5Z1B/LnTajZbhSZbZCZyFdLZBsP+gjGTmAX8EoQm6SY0pFQlLHzaT+qIsUQF4bQTDFJ9iWC4fK3MeEECwvrWHtNIUhOshQYNstPcSk8l9m9LxokkiONKjc502Qu7RMT0Gn4ugYYLoL9AB7Z/HeVRm/eh1BXaZdU2kyf2VXjUAyYMhB+I6nqugVz9KIqnjfoO5ZMH
X-MS-Exchange-AntiSpam-MessageData: bPg24R6C5x3zwL9lQpAgNdSRZl3Ydtyn74tpgLaiiCNR6zWPfjioZqH4FiyBQu2S4kOzQGudQmphGWWnMPLSL7S+Vofpc3yBJfoOquzf372b5EKakLv+Tlvht/ndkiK510kF7Ts2qn87PQWR6q9LAg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f28521-a8a7-419e-e7dd-08d7b5ce5f8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 06:30:26.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHDahOaHNROd1xiXUTXymQ9ggULmsEx+h7JHMTmuP227lrtasTNSdGLgdSIL/z9DzNV5F0oW5HOAE9vFLzIHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4860
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


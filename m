Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DBEC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4503D20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K1pNt111"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgIJKBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:01:13 -0400
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:20964
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730257AbgIJJx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzE9DSqWlOhG8byWPawXOFbS97DfbH5zdeJ48ezME74GB56PXz96E+CQVapQcQLRH675B8z2yZm3t4ALwDvab4Ryyc2LNEUtX4tvg7jL/NfUFMQfhMLI64O0TPykvEPEmRUcBWN6cyeNtDKF0gbU0Qy2el7ydSXZrICs8IqumKntUi8DP+Aam5l/AVcKKXPBtWplONG04P6gUxYEk/cIfYJnplaLpTjROtB7GVPY2zBmn9cNHr+Acql3Ny4smpjJzD0kqrLs43VNscWvcxjL+b4m5Rf9fvdqok7SYRDrAInsDKsbQwKycEXtECZFGRuxr8CmPvOHHp2zdZM01uuMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha1EMLVI9HUpx1K4c7dBqLXXT+yXsjCxmxAdl5/LyqM=;
 b=EEkm9l3CvIOk7BImLHRmVjAe8wyyIY9i3DTCtutHm6tau/nMQUnZRLRXfa5PrVcT+5U0mOFF3YwUMQeXbijW5FX+ECNkHPd/u5TWxLr4ovbkHOJxyFi0Zu870FnrWzeDyurSD7x1naGSJ3IL1/NMk/5ibXtdsyA0aAbCBcFsVNUJIBhQv89CHcv/Q9I6pnsUNGxAcCIjV2e7exHoypKZIJVNOdKoe9dbSCuSOrR2rKhrpKRXGfrcYTVE+Uqnx1FE0jEvFiMkD6+edH0LDJa4LNWxLN7kM4f2FW2xLZlDgzBh8wYhbEv3o/wmGWSooL+AQWG6eP3CdJzKOduEl3bTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha1EMLVI9HUpx1K4c7dBqLXXT+yXsjCxmxAdl5/LyqM=;
 b=K1pNt111nehrjClCOiEdA3Xet9lv6hVJ2d9B/aR4u9XoABalaSz9ctfVmAIj7cAovIQ22HlBlenvnbOCedzK2FDqQFIuTgu9dRgd1DOLtsCexHdK8F18U4WuOyCsMG6A3EmgEZdadHvNUjT0wZX9a5Z6Knuy/YuitBnmq9aehs8=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB6031.eurprd04.prod.outlook.com
 (2603:10a6:803:102::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 09:53:10 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5d66:84a7:26de:67c3]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5d66:84a7:26de:67c3%6]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 09:53:10 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     laurentiu.palcu@oss.nxp.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx/dcss: fix compilation issue on 32bit
Date:   Thu, 10 Sep 2020 12:52:50 +0300
Message-Id: <20200910095250.7663-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::17) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by AM0PR01CA0076.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 09:53:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4923d17d-d612-458d-9535-08d8556f533d
X-MS-TrafficTypeDiagnostic: VI1PR04MB6031:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6031CA4449152B69796C3934BE270@VI1PR04MB6031.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBbiFZ4DH06NS3uJS21pmv6jUQj+h5SsRF7Nc+ubrDvRLcEI2wfQ9EehuYP2EFeIpp1F1bcsZS/Bvk06mzZwbkfVWMzQ6dYJKJV/zdFyk7Uthmj6zGaAH4GRdLmLygMhCBNRqyhoo1vrPu+w0YdyIYJhlJ7rbeceqoFmsmj1QVztLyqqveUXB/9QzjGjTkrapSAwP+5d2NfUjUhBvuZb1BWEWws0Z4T7kn1p4lf1cNwKCAOamcNteF9d6yusqVOEltY6MUsqJGxb+Nv2gALV6+v2ozXo6nwPxP3qUwcWIwyEiTxTIjtW6JUA7eKrZ1sYLjFYEGaJ+WsyXnlma2xDdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(2616005)(8676002)(956004)(66476007)(66556008)(66946007)(44832011)(16526019)(5660300002)(4326008)(110136005)(6666004)(6506007)(83380400001)(26005)(6486002)(8936002)(86362001)(2906002)(7416002)(316002)(478600001)(186003)(6512007)(52116002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bTQdx7EHNjPd6mb1lZiKIpLQKH+xmBVcCxRZKKivGiWS5xTExrtuWoNPuISAheTk9ZdExyQpTzg28lUU3aOx8TTh74ndisuxqOoFT4lSvERk6CfmLRfXIsVr/WVgw1pJ3sBR6bkest4AS3ScmG+OoCiBgx2UYNqtz9hqXq7icBxj243tyT/GudJGykeKUi1+9aMAPP5037Z5KskQGYAYYoCV7eGnSsZ1zWJ12jFxyliXPoze6m4eKIfhB+A0SsQnSDDmaf4EUmKjE1JA7F0eg8H++0NIA8bocuGAHbLVfOVEQtm+torx30ehGyNXdG4lx60cWWOdBlhkP4vjc3AzEZ+vBnySeJobEPgkcwPYocE67M6WqNnpGX9+s/N+QQ60ifMXLEThVJCXYARqvjwuH/hNOYQnv03GHsYqthLw1KhLQ6f7vd5GPZCDz4XlSxZPZUWnRXtGWAghX44SVSIvwHpuyPmTi5aTyNF8Q7xj49Pxe7qzPAUKxyOfrFPPwO6SGSOgwQn8W7372nzrAB0PZ/sqHQpeOFkYa/+qHc1OpLwmGEAlCn4ERrV09SsLav3vMyeeOehQCrN+HPVcPEThjqUP12Fz+nlP8BcRS8Gj+Nk1pst4EyTIIJb6Bzz0mkODkZesybcwF5XJMZ7CGbrF2Q==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4923d17d-d612-458d-9535-08d8556f533d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 09:53:10.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPCvlchW/zYgdYZUY2Dn8kQ6T5qst/nR3IqAZBpD1DnU2p1MZ5J15Vp2ocpM3tuasWCbBRm27zxHBK5zoBmkkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling for 32bit platforms, the compilation fails with:

ERROR: modpost: "__aeabi_ldivmod"
[drivers/gpu/drm/imx/dcss/imx-dcss.ko] undefined!
ERROR: modpost: "__aeabi_uldivmod"
[drivers/gpu/drm/imx/dcss/imx-dcss.ko] undefined!

This patch adds a dependency on ARM64 since no 32bit SoCs have DCSS, so far.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reported-by: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/imx/dcss/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
index 69860de8861f..2b17a964ff05 100644
--- a/drivers/gpu/drm/imx/dcss/Kconfig
+++ b/drivers/gpu/drm/imx/dcss/Kconfig
@@ -3,7 +3,7 @@ config DRM_IMX_DCSS
 	select IMX_IRQSTEER
 	select DRM_KMS_CMA_HELPER
 	select VIDEOMODE_HELPERS
-	depends on DRM && ARCH_MXC
+	depends on DRM && ARCH_MXC && ARM64
 	help
 	  Choose this if you have a NXP i.MX8MQ based system and want to use the
 	  Display Controller Subsystem. This option enables DCSS support.
-- 
2.17.1


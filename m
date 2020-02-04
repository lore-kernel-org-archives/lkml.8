Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1128C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5AC20730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AbxBgErG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgBDNlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:41:37 -0500
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:43110
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbgBDNlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:41:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+6JgSbfQwCKDJLBFA+Xt+RNIYcpA3ELGIzMuZ2y+24EXaoCJ5meTjOLq/lFXDo5O1K1OHMHP3RP6O8Hq5VLsE3mNEx3ZjwFdC1cFp9iAzqPcV3rGaPTL/G891Vswt0Z4jeUW+ajzCMuWEW4Vc/K3yJ6eFZM3QlP+gYW+Bf8xBFX1ltE3tL+K6tav1/lpymSt+yYtDQ3yKyPsnAB3WZdwTRVNd/2Z5Mj8UZaW3Bqupf6FGVUrqPyQQwrQMPXTr2popeczVWp6R2HN6r27jCtYTYaGV0cCNwL9q7c1S+2w8y0vY9V6cYmV4WoKZJCSWSxgzUF9vEMTQ3VwULF5IhYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciaWO3VO+pP0EQZX28jcraO/8X95/AMNfFw8OgXbf0A=;
 b=PyqTcTEEqtVNFjtJ5HHxNTQ6MplzSVwSlAlde0Dd2v7lrs4G2wDk7EodcWf1iY21hHBsX8DZEN19h+MFFXvulIRNMgkwdzBqWLOI7aBZLcMHwbGQRPDs+FAKNlmwowfwZprbew1kF0/AyVWp4BaaeGREF/Dv/HnFsfRjUXF3jeoVCGTXNQzu5zaRai3XjEO7MOiseuoccuYcKCZ4udoukLLVvDfqHsET0bk6adPfxloer6Wy7JJateU8t46r32QKg6OuQubh+phwncCZ/SX3cWwNjHqgkp30EwlyrD1ORmXtk1ktsnQYHuHvhnP6JqDQ5thEPbIE6ypHdKaX0s7r3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciaWO3VO+pP0EQZX28jcraO/8X95/AMNfFw8OgXbf0A=;
 b=AbxBgErGLi+49EjG+pGD6mfRZ517lJgHeTpnvSMVP3bJjNWxDH2LjdGB9lSwpt+MrNlfzlpHUQu0n3yNZHPhn74JQhFIqfroWOBARvje9yb98SVzKPGdM4Rw8UgLlRomRqv59uOqvDuDxlxEbXxEileqMZ3fuFk6YiSzxDIB0Fk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4851.eurprd04.prod.outlook.com (20.176.215.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 13:41:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 13:41:31 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        abel.vesa@nxp.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/7] clk: imx: imx7ulp: add IMX7ULP_CLK_ARM_FREQ clk
Date:   Tue,  4 Feb 2020 21:34:35 +0800
Message-Id: <1580823277-13644-6-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2686.28 via Frontend Transport; Tue, 4 Feb 2020 13:41:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75873d72-7d49-4e75-4491-08d7a977f1b6
X-MS-TrafficTypeDiagnostic: AM0PR04MB4851:|AM0PR04MB4851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4851F99F495B5BAD73A2C33088030@AM0PR04MB4851.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(26005)(956004)(2616005)(316002)(6486002)(186003)(16526019)(8676002)(2906002)(69590400006)(81156014)(36756003)(6506007)(81166006)(86362001)(6666004)(8936002)(478600001)(66946007)(66476007)(66556008)(4326008)(52116002)(9686003)(5660300002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4851;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5PGXiDKWdyrnGD8LfvB6tI6bDavEKrqylPdLYPd2qnC+Hp8TnZoLGgxyZj1bOrrYKAJyv1vMMNpemlAX+0i3wAR2mJ06sm/2CcjiAx3rdyVg/2UljzFlOouJhH67PgIbgHU6gPX0ODVigi0472bHECTztdfxHeEMF7OtCKLYUng3YAFNCaROGW3uR5WY7QhnurAJPYpCXPkWJSoIAmEdQjh7hyLaSXOqAsxl1YHlkYzaOH+WDMBpBisnxSIOQFri+R/Y2HOqT3lHVZn8EoOT30HxxgMuH2ZAtmyaMmt1pyM3TK79ONVx5SljeAXJSUTIY6elVtVlx02S6F/A87ynRPnfXvYWAdc/H/dzKC74OdGey2KFhhMijMa6zQ9IPDsIMJ/u5X1COmf01/z3rm5eTWcZHruQsl9LpONnk+/rCp714fxNnOPgJwmEZ9IHygOo0z0OA3+I6bOIrTs7DMcWdUdlBDNocMGRFkyl30ELAdJOBeIkwpXEVaXVcNOaPM6Tf6BmxmlUUHH5Ty+0p3bVAmE2L8GTwbHfZznCKdn9bg=
X-MS-Exchange-AntiSpam-MessageData: mM4OvLd0zZ3EG6QjmyyUfh7EP65dr/EJscZM3XoZHHmwD8festI8s2vpisQpxqYP2S9MJ+UQ48Id6FCnPd7MnBQdBAvmKJsdIjqkO9LrfxbJZmKsEIvnE1P3BBkuI2WQySXDqaCnwMfRd3zNoa9G8w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75873d72-7d49-4e75-4491-08d7a977f1b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:41:31.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UY6SDJ+3x4bz5fGi9Mi4sbS+lJX7Mp4/59xa3U5ygVrJ2BoOwldHCsB6DdnLl9lJgJGW0uOtA/jCh43hHy0kwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add IMX7ULP_CLK_ARM_FREQ clk entry for cpufreq usage.
The cpu in device tree needs use this index as clock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c             | 15 ++++++++++++++-
 include/dt-bindings/clock/imx7ulp-clock.h |  3 ++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 0620d6c8c072..daa770432bc8 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -56,6 +56,7 @@ static const int pcc3_uart_clk_ids[] __initconst = {
 static struct clk **pcc2_uart_clks[ARRAY_SIZE(pcc2_uart_clk_ids) + 1] __initdata;
 static struct clk **pcc3_uart_clks[ARRAY_SIZE(pcc3_uart_clk_ids) + 1] __initdata;
 
+static struct clk_hw **hws_scg1;
 static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -139,6 +140,8 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 
 	imx_check_clk_hws(hws, clk_data->num);
 
+	hws_scg1 = hws;
+
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 }
 CLK_OF_DECLARE(imx7ulp_clk_scg1, "fsl,imx7ulp-scg1", imx7ulp_clk_scg1_init);
@@ -270,7 +273,17 @@ static void __init imx7ulp_clk_smc1_init(struct device_node *np)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
-	hws[IMX7ULP_CLK_ARM] = imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, arm_sels, ARRAY_SIZE(arm_sels), CLK_IS_CRITICAL);
+	hws[IMX7ULP_CLK_ARM] = imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, arm_sels, ARRAY_SIZE(arm_sels), 0);
+
+	hws[IMX7ULP_CLK_ARM_FREQ] = imx_clk_hw_cpuv2("arm_freq", "arm",
+						     hws[IMX7ULP_CLK_ARM],
+						     hws_scg1[IMX7ULP_CLK_CORE_DIV],
+						     hws_scg1[IMX7ULP_CLK_HSRUN_CORE_DIV],
+						     hws_scg1[IMX7ULP_CLK_SYS_SEL],
+						     hws_scg1[IMX7ULP_CLK_HSRUN_SYS_SEL],
+						     hws_scg1[IMX7ULP_CLK_SPLL_SEL],
+						     hws_scg1[IMX7ULP_CLK_SPLL_PFD0],
+						     hws_scg1[IMX7ULP_CLK_FIRC], CLK_IS_CRITICAL, 0);
 
 	imx_check_clk_hws(hws, clk_data->num);
 
diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
index 38145bdcd975..ecd832dd1c9c 100644
--- a/include/dt-bindings/clock/imx7ulp-clock.h
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -110,7 +110,8 @@
 
 /* SMC1 */
 #define IMX7ULP_CLK_ARM			0
+#define IMX7ULP_CLK_ARM_FREQ		1
 
-#define IMX7ULP_CLK_SMC1_END		1
+#define IMX7ULP_CLK_SMC1_END		2
 
 #endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
-- 
2.16.4


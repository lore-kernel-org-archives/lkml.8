Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C164AC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4472464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VMxqLUhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgBSKAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:00:02 -0500
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:45024
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbgBSKAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:00:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V89/np5CIZqgs4PSLYpNNCLdghe4jz9wMRQxGZVLp32DlVgZtszT+u+j24fJwO4/CW74LVleBFXphksEmOXWhZXm7tiUkTCjVaNabxRwlgeJnUukm/GMRluz0nepYvA9St0USVCAH/Ry7GeyL/ZIW1xI8nXN1i/ks3aoNztGxV9sq3t16Jm02TMa/CxP8Jz6loRUtlZn9tqJviBpFjaFsbWr/XFbGmJ5K+zY3C+Gmr/dbvtP/z0pKdM3AyADJZTSey925q4BXzWWmx4n0Xhrmo8AHn9HDbMG67cYhQuT7AGusw+l3qOrhr0LBd60TjaSJxv11B+pj68aNXiulvmNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SL3IHLMpnjuRlL6n+Nsttl3NLbt3fNY+JBImHZWJ/E=;
 b=izroJ/k/8fBvZyEY0CoQ8qytp1k/EQM/SJPiaA/o8I4sTaqtDkzBZC2d3RqKZulc8lGKifbPHFGkb/0uylYWWyvhog7rtiNA84y4VntlLY94iaZ2yz8+qCwVW7iCpZLlv5XUliVVKZTQn2HDXyB8pzx5yr4Vy09TPcU6d1v93G9+Rodm+rQBfg7ZyNCEivM83vWhexAEKTD/P/LmJPih/Y7Ih1/k1SWsAbiBbPEgm1jTxDUWyN0juBu6Sopx5zHhXFgNJCi2ZCBaMlO0P0pu7CJxA39sWSYpw6xRT5JqAUKl43i5Zal9t+YylyNf0WGxeFbDHk8GTCt3U1KjQ6eebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SL3IHLMpnjuRlL6n+Nsttl3NLbt3fNY+JBImHZWJ/E=;
 b=VMxqLUhKtdGm2KmntdNHRNTUteiAwF14c8r3WKYHCWqQZAs6kRlnVmrrX6nQqQInxB3Hseqiqti9n2dH8NLDFgC8zP7uygST7OhADEuPqZVxTc/SRzwUJRMblbTqHLwssUTUkL5fWWkvr6PBUMIeY3aFjgydASEDmN4ZneICjYc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6770.eurprd04.prod.outlook.com (52.132.214.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 09:59:58 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 09:59:58 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Date:   Wed, 19 Feb 2020 17:53:38 +0800
Message-Id: <1582106022-20926-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
References: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.8 via Frontend Transport; Wed, 19 Feb 2020 09:59:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6b6a521-918f-4a0e-c77e-08d7b5227a4e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6770:|AM0PR04MB6770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6770476ED5F2B9FACA6033B788100@AM0PR04MB6770.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(66476007)(66946007)(4326008)(66556008)(6666004)(5660300002)(86362001)(69590400006)(16526019)(8936002)(2906002)(316002)(956004)(6486002)(36756003)(52116002)(26005)(6506007)(186003)(478600001)(81166006)(8676002)(9686003)(2616005)(6512007)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6770;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnGU1M1nu+Sk6/ZPFjX1OzngODHnRX/2CpftQhlyz2ESv2rBZyY+jUCzxYbiRW0GtDb60XilZUPIpt2fxr4XK9wg/AJESiXidXFdPENJ/mBUc15bQEdgtXYeMVZQGcncYy+e0wUdZ4KVNP/DFXlDELFbfdJQlZZamnuZLgJqOQG6Oz9JPm7knbJ8/QEkhek/yCyAmWDJA6IkI1OiRKZWGf7L9nrDbA6C80JgRYokFDkG2aOgJrG45s/99jAVGM4r9221E9fbCknBWe+7RYZDK/0pj2bv1XfWiFujWPZzZm1XzRm7fuJzAFAqJ3WzQGj0wyiPurBzsU6am0FQMSMnA3pYrB0QO+NVk6A2sja9AJH/LPNCdswVA9Ih93VIP7z2kzJjkzvcjPcKirU/AbphuDWrj6SaurWOY4PtOt+Y20EVumqs6VvEnv6qW9hUGVmAGeBZegi8ssZ47w0ker2y0XIgi7eNEw49dbEd4jRV2oFpLXlPjqTzivGcB4efjYlPwt/B4CF6YqaErSo4hnPGT/lXqmq8jCROfV+IMtUO3lDakqdYMG6H+VqFQCcN8te5
X-MS-Exchange-AntiSpam-MessageData: MLOXm/QhIYmvfA+jO2L5HL1yDsqi4J8R9KhWX2QTTj7iQznS9DFTTIv1RRgA4gBeFbZNvF/XcvkFtVzkEHlzOmzM8CMYJBLqvhxNQq1gAXFRi4z1gP+VU7sX1xfYJr7okerII2xQa2eA8/ZKPPafCg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b6a521-918f-4a0e-c77e-08d7b5227a4e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 09:59:58.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFr51AjQUNilkQv//c8aNqxseiG9lpSocl58WJTJPcEUH9bDaoZSqqdtXU4Kof5shsrpeG/rLQslrdcPqzRyEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx8m_clk_hw_composite_core to simplify code.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4c0edca1a6d0..e928c1355ad8 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -403,22 +403,16 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	/* CORE */
 	hws[IMX8MQ_CLK_A53_SRC] = imx_clk_hw_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
-	hws[IMX8MQ_CLK_M4_SRC] = imx_clk_hw_mux2("arm_m4_src", base + 0x8080, 24, 3, imx8mq_arm_m4_sels, ARRAY_SIZE(imx8mq_arm_m4_sels));
-	hws[IMX8MQ_CLK_VPU_SRC] = imx_clk_hw_mux2("vpu_src", base + 0x8100, 24, 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));
-	hws[IMX8MQ_CLK_GPU_CORE_SRC] = imx_clk_hw_mux2("gpu_core_src", base + 0x8180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));
-	hws[IMX8MQ_CLK_GPU_SHADER_SRC] = imx_clk_hw_mux2("gpu_shader_src", base + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels));
-
 	hws[IMX8MQ_CLK_A53_CG] = imx_clk_hw_gate3_flags("arm_a53_cg", "arm_a53_src", base + 0x8000, 28, CLK_IS_CRITICAL);
-	hws[IMX8MQ_CLK_M4_CG] = imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", base + 0x8080, 28);
-	hws[IMX8MQ_CLK_VPU_CG] = imx_clk_hw_gate3("vpu_cg", "vpu_src", base + 0x8100, 28);
-	hws[IMX8MQ_CLK_GPU_CORE_CG] = imx_clk_hw_gate3("gpu_core_cg", "gpu_core_src", base + 0x8180, 28);
-	hws[IMX8MQ_CLK_GPU_SHADER_CG] = imx_clk_hw_gate3("gpu_shader_cg", "gpu_shader_src", base + 0x8200, 28);
-
 	hws[IMX8MQ_CLK_A53_DIV] = imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
-	hws[IMX8MQ_CLK_M4_DIV] = imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg", base + 0x8080, 0, 3);
-	hws[IMX8MQ_CLK_VPU_DIV] = imx_clk_hw_divider2("vpu_div", "vpu_cg", base + 0x8100, 0, 3);
-	hws[IMX8MQ_CLK_GPU_CORE_DIV] = imx_clk_hw_divider2("gpu_core_div", "gpu_core_cg", base + 0x8180, 0, 3);
-	hws[IMX8MQ_CLK_GPU_SHADER_DIV] = imx_clk_hw_divider2("gpu_shader_div", "gpu_shader_cg", base + 0x8200, 0, 3);
+
+	hws[IMX8MQ_CLK_M4_DIV] = imx8m_clk_hw_composite_core("arm_m4_div", imx8mq_arm_m4_sels, base + 0x8080);
+	hws[IMX8MQ_CLK_VPU_DIV] = imx8m_clk_hw_composite_core("vpu_div", imx8mq_vpu_sels, base + 0x8100);
+	hws[IMX8MQ_CLK_GPU_CORE_DIV] = imx8m_clk_hw_composite_core("gpu_core_div", imx8mq_gpu_core_sels, base + 0x8180);
+	hws[IMX8MQ_CLK_GPU_SHADER_DIV] = imx8m_clk_hw_composite("gpu_shader_div", imx8mq_gpu_shader_sels, base + 0x8200);
+	/* For DTS which still assign parents for gpu core src clk */
+	hws[IMX8MQ_CLK_GPU_CORE_SRC] = hws[IMX8MQ_CLK_GPU_CORE_DIV];
+	hws[IMX8MQ_CLK_GPU_SHADER_SRC] = hws[IMX8MQ_CLK_GPU_SHADER_DIV];
 
 	/* BUS */
 	hws[IMX8MQ_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mq_main_axi_sels, base + 0x8800);
-- 
2.16.4


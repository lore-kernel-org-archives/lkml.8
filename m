Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF9C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBB02071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qctxZUXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCLK1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:27:21 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:48777
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbgCLK1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:27:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6JeXs16SkczefOp1kOeHqG/OpnXB9TC3+T4k+j5n+aNPO+b0QBBD0MsLD1I7QpGQRZD4Kxmlx4K3bNVR729XM32De+I2obb/X1iJkGQ6+MMY6vdwiydo3oCCLA4nt18+XfZz1oP9hNqVDeIOAUu8fClI+fsZhiKYCWvOADFG3kAaappJxqHJJxZkB+w1rdqwG2ZiWZGai/TLet9ssUxk0yC/v3oKuH+YEP/CItri1JlJnyoSBka8DkzXVSGS+ZVRWRRAES+cgAUxFXEI5GNyzvuCQET5zpWyiDRXgRZ3lkLOXcJb/xxnx9sGA8NnPcb5GWMPNgvUOiu2IaKumnl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaRT3NfG2XBeOP9eYGpEU06FeJxEBVoA+1XcW6dAIBU=;
 b=AUG57YIBTtOG+kIfem1aG2Pr6GejWmAjiJBbQLZlLcquSMH8PgtJZNTUidGxkPrjEmU9u3hWUFkkPcVlnLO4b16uWhGQlT8Fk2gdYLWku8lbd8OMkgE+T+wfSga5Lmz4+Y/0tzEEbxCrFsdYFcvPThtffaTcYHulT8vnz3wtSsgkbqcUib2r+szDQcN2X9LbzDqeKN4Kd8hgK0FqaZGQIzCiCevUb4DbpaOkxXCh0sw0OLabwvzNqEKaoB2yZ3Atkvl0QjkdTe9dg/XqCPfFaJY+Hi2EZ8+4XKpvC8Zy0wuU4ei4gDYkcpwb159iU1gZ0tkiARyAig4lwomUoUeqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaRT3NfG2XBeOP9eYGpEU06FeJxEBVoA+1XcW6dAIBU=;
 b=qctxZUXPK7mCZqjqT6V8Y9Q/6kw0RmOLhZUApiDDfwTB5onuBOpxjSMxm0oJubidqO86KgJNtlZKbQOk/HtMemizQYGLzqV5JdrUiZlZKnjT8WjbGfPtEeiBRa8r8NSOxErAbJv/vIbvd/zuxcX5TOsuOLFm/svzTKsuJVHAUTM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4195.eurprd04.prod.outlook.com (52.134.92.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 10:27:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:27:04 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, sboyd@kernel.org, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anson.Huang@nxp.com, daniel.baluta@nxp.com, aford173@gmail.com,
        ping.bai@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, agx@sigxcpu.org, angus@akkea.ca,
        heiko@sntech.de, fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 05/10] clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code
Date:   Thu, 12 Mar 2020 18:19:39 +0800
Message-Id: <1584008384-11578-6-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0113.apcprd03.prod.outlook.com (2603:1096:4:91::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 10:26:58 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed5b2cf9-40a4-4b6e-773b-08d7c66fe897
X-MS-TrafficTypeDiagnostic: AM0PR04MB4195:|AM0PR04MB4195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4195D5E77E7739574F6F144188FD0@AM0PR04MB4195.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(956004)(26005)(6512007)(9686003)(2616005)(86362001)(8676002)(186003)(6506007)(81166006)(6666004)(8936002)(7416002)(6486002)(478600001)(52116002)(69590400007)(316002)(66946007)(66476007)(16526019)(5660300002)(66556008)(36756003)(81156014)(4326008)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4195;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/C7k+D/tWsHnDp/65mzyifzJMMEh0OPduL2YAu42Jh7oulyyAAs/CnblvSxcm10UWY69fDPx9ePSXQe/t9WHFZ0TvQExdR/l54zqNvqHM+wu7FEL37VKiDAEaqnQQsomspWe40/TZWGVrPdAcGqVyzHfZCALuHmFG5pWLRzo2dbxzMciGoOnr/7Z6z+bJani2inUc0mmk9GmWn7ps1hAlvVjb3EWjXbkVBOW4kbzVGQnthwhwSdfmpT/w3CB1AUW2luOaCXmTlGT9u4VCQAapB0/jjV7z7KQstms70RKCl/qA6ASlK4AAbIJ7HfJ7xE1nkrYSw55dI7BOaBSHOHpXjuZq2hovMYpAdAiqeP4Fcswe7ZVprkFUIozqoffI5hcCnSw6Ar0WbZsgV8zK9ngABpw8L7MhQGXzw9Mcu649NbOgfTKcKqZx+sktGAK3nzF9MeIyABBleCBxRhDBmnrRvEb8m9uKF7nUqw9JMlvmF427p/y4XSWJbmBMo5XpRcq4W+bMp+fqgWqCZoB1F1Jw==
X-MS-Exchange-AntiSpam-MessageData: XUvm12bJ8+axsr2f+vVpBWA6tJm0k4aMOlCisHBdx64Nj9uYZ+0PY/XSZzMJcU0VO5jNK0SN1V19IESCV2qSiaK6D/RdFqlCLsYXEmxF84RvjRItZiJcAYyl5YaUHpNiGtpV+hPjwK47maZvKTiQ7w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5b2cf9-40a4-4b6e-773b-08d7c66fe897
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:27:04.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ds9OZ2WkklEVdqnwVGSwWmCyOrYK9mzzVYVtAnj8GPwngGplOgu+BU6Fu+CXCT0Dz1yjaoL0gz/hwI4BKFWPqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx8m_clk_hw_composite_core to simpliy clks that belong to
core clk slice.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c             | 47 +++++++++++---------------------
 include/dt-bindings/clock/imx8mp-clock.h | 11 +++++++-
 2 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index a7613c7355c8..998e9e63f831 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -546,33 +546,18 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
 	hws[IMX8MP_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
 
-	hws[IMX8MP_CLK_A53_SRC] = imx_clk_hw_mux2("arm_a53_src", ccm_base + 0x8000, 24, 3, imx8mp_a53_sels, ARRAY_SIZE(imx8mp_a53_sels));
-	hws[IMX8MP_CLK_M7_SRC] = imx_clk_hw_mux2("arm_m7_src", ccm_base + 0x8080, 24, 3, imx8mp_m7_sels, ARRAY_SIZE(imx8mp_m7_sels));
-	hws[IMX8MP_CLK_ML_SRC] = imx_clk_hw_mux2("ml_src", ccm_base + 0x8100, 24, 3, imx8mp_ml_sels, ARRAY_SIZE(imx8mp_ml_sels));
-	hws[IMX8MP_CLK_GPU3D_CORE_SRC] = imx_clk_hw_mux2("gpu3d_core_src", ccm_base + 0x8180, 24, 3,  imx8mp_gpu3d_core_sels, ARRAY_SIZE(imx8mp_gpu3d_core_sels));
-	hws[IMX8MP_CLK_GPU3D_SHADER_SRC] = imx_clk_hw_mux2("gpu3d_shader_src", ccm_base + 0x8200, 24, 3, imx8mp_gpu3d_shader_sels, ARRAY_SIZE(imx8mp_gpu3d_shader_sels));
-	hws[IMX8MP_CLK_GPU2D_SRC] = imx_clk_hw_mux2("gpu2d_src", ccm_base + 0x8280, 24, 3, imx8mp_gpu2d_sels, ARRAY_SIZE(imx8mp_gpu2d_sels));
-	hws[IMX8MP_CLK_AUDIO_AXI_SRC] = imx_clk_hw_mux2("audio_axi_src", ccm_base + 0x8300, 24, 3, imx8mp_audio_axi_sels, ARRAY_SIZE(imx8mp_audio_axi_sels));
-	hws[IMX8MP_CLK_HSIO_AXI_SRC] = imx_clk_hw_mux2("hsio_axi_src", ccm_base + 0x8380, 24, 3, imx8mp_hsio_axi_sels, ARRAY_SIZE(imx8mp_hsio_axi_sels));
-	hws[IMX8MP_CLK_MEDIA_ISP_SRC] = imx_clk_hw_mux2("media_isp_src", ccm_base + 0x8400, 24, 3, imx8mp_media_isp_sels, ARRAY_SIZE(imx8mp_media_isp_sels));
-	hws[IMX8MP_CLK_A53_CG] = imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", ccm_base + 0x8000, 28);
-	hws[IMX8MP_CLK_M4_CG] = imx_clk_hw_gate3("arm_m7_cg", "arm_m7_src", ccm_base + 0x8080, 28);
-	hws[IMX8MP_CLK_ML_CG] = imx_clk_hw_gate3("ml_cg", "ml_src", ccm_base + 0x8100, 28);
-	hws[IMX8MP_CLK_GPU3D_CORE_CG] = imx_clk_hw_gate3("gpu3d_core_cg", "gpu3d_core_src", ccm_base + 0x8180, 28);
-	hws[IMX8MP_CLK_GPU3D_SHADER_CG] = imx_clk_hw_gate3("gpu3d_shader_cg", "gpu3d_shader_src", ccm_base + 0x8200, 28);
-	hws[IMX8MP_CLK_GPU2D_CG] = imx_clk_hw_gate3("gpu2d_cg", "gpu2d_src", ccm_base + 0x8280, 28);
-	hws[IMX8MP_CLK_AUDIO_AXI_CG] = imx_clk_hw_gate3("audio_axi_cg", "audio_axi_src", ccm_base + 0x8300, 28);
-	hws[IMX8MP_CLK_HSIO_AXI_CG] = imx_clk_hw_gate3("hsio_axi_cg", "hsio_axi_src", ccm_base + 0x8380, 28);
-	hws[IMX8MP_CLK_MEDIA_ISP_CG] = imx_clk_hw_gate3("media_isp_cg", "media_isp_src", ccm_base + 0x8400, 28);
-	hws[IMX8MP_CLK_A53_DIV] = imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", ccm_base + 0x8000, 0, 3);
-	hws[IMX8MP_CLK_M7_DIV] = imx_clk_hw_divider2("arm_m7_div", "arm_m7_cg", ccm_base + 0x8080, 0, 3);
-	hws[IMX8MP_CLK_ML_DIV] = imx_clk_hw_divider2("ml_div", "ml_cg", ccm_base + 0x8100, 0, 3);
-	hws[IMX8MP_CLK_GPU3D_CORE_DIV] = imx_clk_hw_divider2("gpu3d_core_div", "gpu3d_core_cg", ccm_base + 0x8180, 0, 3);
-	hws[IMX8MP_CLK_GPU3D_SHADER_DIV] = imx_clk_hw_divider2("gpu3d_shader_div", "gpu3d_shader_cg", ccm_base + 0x8200, 0, 3);
-	hws[IMX8MP_CLK_GPU2D_DIV] = imx_clk_hw_divider2("gpu2d_div", "gpu2d_cg", ccm_base + 0x8280, 0, 3);
-	hws[IMX8MP_CLK_AUDIO_AXI_DIV] = imx_clk_hw_divider2("audio_axi_div", "audio_axi_cg", ccm_base + 0x8300, 0, 3);
-	hws[IMX8MP_CLK_HSIO_AXI_DIV] = imx_clk_hw_divider2("hsio_axi_div", "hsio_axi_cg", ccm_base + 0x8380, 0, 3);
-	hws[IMX8MP_CLK_MEDIA_ISP_DIV] = imx_clk_hw_divider2("media_isp_div", "media_isp_cg", ccm_base + 0x8400, 0, 3);
+	hws[IMX8MP_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mp_a53_sels, ccm_base + 0x8000);
+	hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
+	hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
+	hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, ccm_base + 0x8080);
+	hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, ccm_base + 0x8100);
+	hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, ccm_base + 0x8180);
+	hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, ccm_base + 0x8200);
+	hws[IMX8MP_CLK_GPU2D_CORE] = imx8m_clk_hw_composite("gpu2d_core", imx8mp_gpu2d_sels, ccm_base + 0x8280);
+	hws[IMX8MP_CLK_AUDIO_AXI] = imx8m_clk_hw_composite("audio_axi", imx8mp_audio_axi_sels, ccm_base + 0x8300);
+	hws[IMX8MP_CLK_AUDIO_AXI_SRC] = hws[IMX8MP_CLK_AUDIO_AXI];
+	hws[IMX8MP_CLK_HSIO_AXI] = imx8m_clk_hw_composite("hsio_axi", imx8mp_hsio_axi_sels, ccm_base + 0x8380);
+	hws[IMX8MP_CLK_MEDIA_ISP] = imx8m_clk_hw_composite("media_isp", imx8mp_media_isp_sels, ccm_base + 0x8400);
 
 	/* CORE SEL */
 	hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels));
@@ -713,8 +698,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
 	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
 	hws[IMX8MP_CLK_SIM_ENET_ROOT] = imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400, 0);
-	hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_div", ccm_base + 0x4450, 0);
-	hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core_div", ccm_base + 0x4460, 0);
+	hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", ccm_base + 0x4450, 0);
+	hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", ccm_base + 0x4460, 0);
 	hws[IMX8MP_CLK_SNVS_ROOT] = imx_clk_hw_gate4("snvs_root_clk", "ipg_root", ccm_base + 0x4470, 0);
 	hws[IMX8MP_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", ccm_base + 0x4490, 0);
 	hws[IMX8MP_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", ccm_base + 0x44a0, 0);
@@ -731,7 +716,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_GPU_ROOT] = imx_clk_hw_gate4("gpu_root_clk", "gpu_axi", ccm_base + 0x4570, 0);
 	hws[IMX8MP_CLK_VPU_VC8KE_ROOT] = imx_clk_hw_gate4("vpu_vc8ke_root_clk", "vpu_vc8000e", ccm_base + 0x4590, 0);
 	hws[IMX8MP_CLK_VPU_G2_ROOT] = imx_clk_hw_gate4("vpu_g2_root_clk", "vpu_g2", ccm_base + 0x45a0, 0);
-	hws[IMX8MP_CLK_NPU_ROOT] = imx_clk_hw_gate4("npu_root_clk", "ml_div", ccm_base + 0x45b0, 0);
+	hws[IMX8MP_CLK_NPU_ROOT] = imx_clk_hw_gate4("npu_root_clk", "ml_core", ccm_base + 0x45b0, 0);
 	hws[IMX8MP_CLK_HSIO_ROOT] = imx_clk_hw_gate4("hsio_root_clk", "ipg_root", ccm_base + 0x45c0, 0);
 	hws[IMX8MP_CLK_MEDIA_APB_ROOT] = imx_clk_hw_gate2_shared2("media_apb_root_clk", "media_apb", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_AXI_ROOT] = imx_clk_hw_gate2_shared2("media_axi_root_clk", "media_axi", ccm_base + 0x45d0, 0, &share_count_media);
@@ -739,7 +724,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_MEDIA_CAM2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam2_pix_root_clk", "media_cam2_pix", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", ccm_base + 0x45d0, 0, &share_count_media);
-	hws[IMX8MP_CLK_MEDIA_ISP_ROOT] = imx_clk_hw_gate2_shared2("media_isp_root_clk", "media_isp_div", ccm_base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_ISP_ROOT] = imx_clk_hw_gate2_shared2("media_isp_root_clk", "media_isp", ccm_base + 0x45d0, 0, &share_count_media);
 
 	hws[IMX8MP_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", ccm_base + 0x45e0, 0);
 	hws[IMX8MP_CLK_HDMI_ROOT] = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", ccm_base + 0x45f0, 0);
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 46c69cd66c62..8430bc4fd182 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -313,6 +313,15 @@
 #define IMX8MP_SYS_PLL2_333M_CG			303
 #define IMX8MP_SYS_PLL2_500M_CG			304
 
-#define IMX8MP_CLK_END				305
+#define IMX8MP_CLK_M7_CORE			305
+#define IMX8MP_CLK_ML_CORE			306
+#define IMX8MP_CLK_GPU3D_CORE			307
+#define IMX8MP_CLK_GPU3D_SHADER_CORE		308
+#define IMX8MP_CLK_GPU2D_CORE			309
+#define IMX8MP_CLK_AUDIO_AXI			310
+#define IMX8MP_CLK_HSIO_AXI			311
+#define IMX8MP_CLK_MEDIA_ISP			312
+
+#define IMX8MP_CLK_END				313
 
 #endif
-- 
2.16.4


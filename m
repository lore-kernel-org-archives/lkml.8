Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B7C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82BB24677
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kZHAj64T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgBSKAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:00:09 -0500
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:60172
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726777AbgBSKAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:00:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTHWEDcM03ZBXLZl0xhVfDJwuYn6BAWfUFQ7EpiES0vWrESAU5yq65wrW4yPrVviBO7pOEDhL+TyFSWPA4TjwhvPFbGsKsxiQT7Q3zFzsvbGcswW0y3HJTcZTLZIHM4QMlfNT9U6PGeGhtriQw/mNN0cHyy7fD067+C5C8bRKHaMQuSvjiTd7mjzodBy4ysZUXNexGHJkwV9CISqg8nCOA49qr1BbIPtg8xE4wQyh7ng0qWkNXYnB2/C7LnktqGSVrRhLuHnCNyTig0yKG9p+GbxSPNMw23/ezNywe9K8BH+8YJ4g+efPx1NjkttXcK3qmS4eyRb4ZqNKExWzk9nsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2FfUKUiIYfOPyyFV261SZOdJ3SXdMqmgC5PnY4vjiQ=;
 b=NH96ZSzFQuuV9PFbjm83hlTY7cDlQcjcDAMW2kwdzsGw84ZjMwIMoDF+QYEASSMvufJvhh7IihdYNBxv5GvLp0sZzjV9w1UzitcHizoGIxTlkRM0N/kTGZyG3nbwN9TZfslg0tJQqGnqL0upqvLHBGRaqoEquxIompEdPiKT3vSbJpVgzNCtIaOxjVZxcKeXu+F5vAsd+/BpFk55KpdHPzqQSB642wQYWWSe6ndUHLDd1xkehb5iSjeCn+ySKOnC76GO5hYo8Pc5oPD+stiI3gRaxuE0vg5XXy6hjYPmwHKVx87KatU/Mf672QF5sTmllZOOBDPsbxI0aYEquuJvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2FfUKUiIYfOPyyFV261SZOdJ3SXdMqmgC5PnY4vjiQ=;
 b=kZHAj64TwohDnKpibHadVuaW4aZiFHip6nIPD4SjJuUcvWxl6gBLE01bbPXCgdH7N3/7EUmCEsIiZZLD7xTF+ufQkPJ7X6Mv7uIdMfrDs34u3mEVyiFNAilzA5TJnWZ7DNj9dj71wQ/Q0IYhGMUeBt25U8yisSMQI78w/+f+pBE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6514.eurprd04.prod.outlook.com (20.179.254.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 10:00:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:00:03 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Date:   Wed, 19 Feb 2020 17:53:39 +0800
Message-Id: <1582106022-20926-6-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
References: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.8 via Frontend Transport; Wed, 19 Feb 2020 09:59:58 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9285761f-4ff5-4050-559f-08d7b5227d31
X-MS-TrafficTypeDiagnostic: AM0PR04MB6514:|AM0PR04MB6514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6514DC848532F516681CAB3988100@AM0PR04MB6514.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(4326008)(2616005)(956004)(6512007)(5660300002)(8936002)(9686003)(16526019)(186003)(478600001)(81166006)(81156014)(8676002)(36756003)(2906002)(6486002)(6506007)(86362001)(66946007)(52116002)(69590400006)(66556008)(66476007)(316002)(6666004)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6514;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8Paetd1by+tG8rD3i7UC+dAeUtPzGdLDqgNsctAFTZQ3SEmaMnJe9dW9rr8mU8nKOtfv52+Wgan+XjE0UROxfzZvWuFWfwX9bH1hbWbdYPu7PyC5eJd9767KLAgNlRB5O/Ya3nCBZCn5TyEIT+NFbkrtAaj8tKdVjKVTg3xdM4IDOm7h+2I6zC4rn3+/y6VkTumpp0pY7wo9Z9e+rRyIZJUNYPnujDm9Cq57DYoFfhFgS97zTKn1jWH8B650/43VizRA/HnNLk1bo8JbBDpwmtbawIJ744/Ti7TM4eskGYPDC7Ja4LLYUkU6Mz4FLLFANJuDOyobm0M78mI9ZQTgjjjxVg/HeiRyrJkR9KResTAayo5UmdY+sg0rXQrjZImqu7Ffqg5jPlU4lpVY4uFJMf6SYV1LmHamGVFWyEuxtYy4Y/pWeJkpkizrNDOMGhn5k4fOt3gqRoIPGX1ebip7wrhKowb29koqOUxCmmTwEjxk/mUJoPeeYCpQn8DMmpmjH/9GV4aMEXkjak4/PaMgVxb8fxGW4NDM86zloIbdHf5FgZAi0jyytEcD2DiaM6+
X-MS-Exchange-AntiSpam-MessageData: 4ldDTNRQ2zJlvDsb14/gcmbCE/kELDwaeTpRyg19sgpcNiy/+lpmE7tju0o3id7VJZCV6Ova0HjWkkczzVRQ+HM6Oa6UGbQpffXcbKou7370VxXAnP049VzSwX1Ar09vhOgP42RM1F4pZYzd3FzZ+Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9285761f-4ff5-4050-559f-08d7b5227d31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:00:03.2174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVC40lW5yy6N8iXPkDBdyFiiobbgrHlm/eUd7MBFxL4CgrZhBTARN5D5TSrokqtE56VPjpZgkUuGQ3HRggC1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx8m_clk_hw_composite_core to simplify code.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 2ed93fc25087..197ba2cdab7d 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -414,20 +414,13 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 
 	/* Core Slice */
 	hws[IMX8MM_CLK_A53_SRC] = imx_clk_hw_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels));
-	hws[IMX8MM_CLK_M4_SRC] = imx_clk_hw_mux2("arm_m4_src", base + 0x8080, 24, 3, imx8mm_m4_sels, ARRAY_SIZE(imx8mm_m4_sels));
-	hws[IMX8MM_CLK_VPU_SRC] = imx_clk_hw_mux2("vpu_src", base + 0x8100, 24, 3, imx8mm_vpu_sels, ARRAY_SIZE(imx8mm_vpu_sels));
-	hws[IMX8MM_CLK_GPU3D_SRC] = imx_clk_hw_mux2("gpu3d_src", base + 0x8180, 24, 3,  imx8mm_gpu3d_sels, ARRAY_SIZE(imx8mm_gpu3d_sels));
-	hws[IMX8MM_CLK_GPU2D_SRC] = imx_clk_hw_mux2("gpu2d_src", base + 0x8200, 24, 3, imx8mm_gpu2d_sels,  ARRAY_SIZE(imx8mm_gpu2d_sels));
 	hws[IMX8MM_CLK_A53_CG] = imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28);
-	hws[IMX8MM_CLK_M4_CG] = imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", base + 0x8080, 28);
-	hws[IMX8MM_CLK_VPU_CG] = imx_clk_hw_gate3("vpu_cg", "vpu_src", base + 0x8100, 28);
-	hws[IMX8MM_CLK_GPU3D_CG] = imx_clk_hw_gate3("gpu3d_cg", "gpu3d_src", base + 0x8180, 28);
-	hws[IMX8MM_CLK_GPU2D_CG] = imx_clk_hw_gate3("gpu2d_cg", "gpu2d_src", base + 0x8200, 28);
 	hws[IMX8MM_CLK_A53_DIV] = imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
-	hws[IMX8MM_CLK_M4_DIV] = imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg", base + 0x8080, 0, 3);
-	hws[IMX8MM_CLK_VPU_DIV] = imx_clk_hw_divider2("vpu_div", "vpu_cg", base + 0x8100, 0, 3);
-	hws[IMX8MM_CLK_GPU3D_DIV] = imx_clk_hw_divider2("gpu3d_div", "gpu3d_cg", base + 0x8180, 0, 3);
-	hws[IMX8MM_CLK_GPU2D_DIV] = imx_clk_hw_divider2("gpu2d_div", "gpu2d_cg", base + 0x8200, 0, 3);
+
+	hws[IMX8MM_CLK_M4_DIV] = imx8m_clk_hw_composite_core("arm_m4_div", imx8mm_m4_sels, base + 0x8080);
+	hws[IMX8MM_CLK_VPU_DIV] = imx8m_clk_hw_composite_core("vpu_div", imx8mm_vpu_sels, base + 0x8100);
+	hws[IMX8MM_CLK_GPU3D_DIV] = imx8m_clk_hw_composite_core("gpu3d_div", imx8mm_gpu3d_sels, base + 0x8180);
+	hws[IMX8MM_CLK_GPU2D_DIV] = imx8m_clk_hw_composite_core("gpu2d_div", imx8mm_gpu2d_sels, base + 0x8200);
 
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi",  imx8mm_main_axi_sels, base + 0x8800);
-- 
2.16.4


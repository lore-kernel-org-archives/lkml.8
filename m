Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B6EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A424206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJxz0cyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgCLJIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:08:54 -0400
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:6623
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgCLJIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:08:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayWnwovsFzaCyz+/WQmNnZyHmHrYvgfUzHHKAWwOTF2KsRYM0ltRf3Pr9P36E9vmmOlxJXU6kIAhtDuwFMC0uOLrJ45jXbXLjZTMfWNmd1EINJjs7snzpQFPVE4wHhdAeuuWXTwwXdHHnGchW9G//l3E8i4A9Lt+iWFlhn44TqJNZ7ucJIzD9BJi6vHbnzJ8+gN980VHZTWIb/V50TG308Sb9gwYT6k05NRZ1xKxTjEw3m4cx+1kp6etP1ykMR9or3fgJXrmSPgTWONXXNKdBG1fS0LL6bARdFQv22RFoe1AWpclr+aGes5JXIZv7L1ojTSSKi1x2Rqce6xuV0zvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obxC7ONXcmaL0Xazi7UayeJxNbg8wwo4Rkj8J9xuJHA=;
 b=ANC5xwFG3EolSR5ZPgki3y1UgusGPNRNuRgeUybEUftHDDHgyVjBXAeWrK70F7WseQqO9b0MD1nnsVLCR1LsmrIWgPXONowZd/Y8qdv7p1utTt/ewuHQmVd+zNwQt1ocwe26e76X/7bSJHVomLu13qlkB86wDhi81vxNyVZLXaPAO9Rz8trn6CGas8q5Xb5oqOpBgzFhNRsJROk/gyYpm6WDgr+8h/tBmwnhl4z5WtjX9ow0KXe96J2aGz8jy0SBDgYY3/0wF33ktQofMsULPEi+A2jBHqKU1dUakRmSgkvzxaQ8fXEFHHnek6EveVmL4jvr7i83zqa50XqUIrB8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obxC7ONXcmaL0Xazi7UayeJxNbg8wwo4Rkj8J9xuJHA=;
 b=DJxz0cyPmH2ClZMRTFVZzi9fRqdXq1aNQk7fpO8BPe8Vw/SpTfArc7Ywr3hKGhCfvXgE3q9nIFCXyU9VDdGZfaE6zQ5Awq8iKyNLnKpY+GuXPDKYJ4q5+Kpz3mlQBG4ND4VKl+WcJqWjd+tnIc0qJDBqH0tqoZiqG8Xa6j/dKVE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4305.eurprd04.prod.outlook.com (52.134.126.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:08:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:08:51 +0000
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
Subject: [PATCH 06/10] clk: imx8m: migrate A53 clk root to use composite core
Date:   Thu, 12 Mar 2020 17:01:28 +0800
Message-Id: <1584003692-25523-7-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
References: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:54::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.14 via Frontend Transport; Thu, 12 Mar 2020 09:08:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb650562-8b3f-40ac-50e8-08d7c664fb4d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4305:|AM0PR04MB4305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB43051CD86161B5E38FB57E8088FD0@AM0PR04MB4305.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(478600001)(36756003)(86362001)(2906002)(4326008)(6666004)(316002)(81166006)(81156014)(8936002)(8676002)(2616005)(956004)(186003)(69590400007)(5660300002)(6506007)(26005)(66476007)(66556008)(66946007)(9686003)(16526019)(6486002)(7416002)(52116002)(6512007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4305;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daS2U5GOSt6M9P9ZcqpXzygZkMG6g9/Ufn8TVNcHz8S7ZYsXOiq+INvpRrW0012YQf6OKRo0ZrOOC8lwJ+RfCSZPvvbYL9WvVoHTkB8UIaoH9hPWFnU3AgqqqOyN+6Z2G3yk7tsWNPSeWixDCHIj2HSxNdbmLG6sYHGUh0jm4ydKcVUFGFNcRst2VgtrIjdV5e53JXDSGeGUf45BMhvKEWXAHNwfbhBf0A3QArrKaLyZs9eRl6navpWqoWs1jXkgLGpySs2Bmdlp9tGwphlUInp53XfI+Tp/1Oit2FqQIBEKclw+hmD+tFhS7HqskvKFi5xkYEhhQ2/ACGlaqEtWm3hdZt9KfLpYBkUN+iCGiTmncsm760kH7fMseS/fsXJ3nMrPmqUXWw2bqTH7EcVIlLzHR73Hg/XW/yEUvkANksGZJOMhZllNO4o5lccNXIjHQT4TRTI1kDAnF6ypa37FMpQAR09OjQ3Kq8dVTQ+7Adl7XPv3wkPsakL9gALEqJFO3+ZBnLcHKO64QajFdO1r5w==
X-MS-Exchange-AntiSpam-MessageData: VbdMnoKpNHxFrbsL751r4nDwl999Hf+fttGTuK7uaNXnCmUuU2aDSHwX/yiYrkcMJ36eiLzJTPTxQg/4ftRZUV6SBq1Gc/Imm2tAE8wunOOAveLw8na1NgCFb+d7fJK2Z5WbUivvieBLBGESJJ8ing==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb650562-8b3f-40ac-50e8-08d7c664fb4d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:08:51.3370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0qvtVIK6QZyPEkwL6Q9nIDB7hNGjem6t1XZIvwhrwrXlPGzEm5c8p4I7wC2d45q6CqQ7twa50QsxW3DtA0onA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Migrate A53 clk root to use composite core clk type. It
will simplify code and make it easy to use composite
specific mux operation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 6 +++---
 drivers/clk/imx/clk-imx8mn.c | 6 +++---
 drivers/clk/imx/clk-imx8mq.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 5435042a06e3..12443e06f329 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -416,9 +416,9 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	/* Core Slice */
-	hws[IMX8MM_CLK_A53_SRC] = imx_clk_hw_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels));
-	hws[IMX8MM_CLK_A53_CG] = imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28);
-	hws[IMX8MM_CLK_A53_DIV] = imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
+	hws[IMX8MM_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mm_a53_sels, base + 0x8000);
+	hws[IMX8MM_CLK_A53_CG] = hws[IMX8MM_CLK_A53_DIV];
+	hws[IMX8MM_CLK_A53_SRC] = hws[IMX8MM_CLK_A53_DIV];
 
 	hws[IMX8MM_CLK_M4_CORE] = imx8m_clk_hw_composite_core("arm_m4_core", imx8mm_m4_sels, base + 0x8080);
 	hws[IMX8MM_CLK_VPU_CORE] = imx8m_clk_hw_composite_core("vpu_core", imx8mm_vpu_sels, base + 0x8100);
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 6cac6ca03e12..bd3759b4afd0 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -413,9 +413,9 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	}
 
 	/* CORE */
-	hws[IMX8MN_CLK_A53_SRC] = imx_clk_hw_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mn_a53_sels, ARRAY_SIZE(imx8mn_a53_sels));
-	hws[IMX8MN_CLK_A53_CG] = imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28);
-	hws[IMX8MN_CLK_A53_DIV] = imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
+	hws[IMX8MN_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mn_a53_sels, base + 0x8000);
+	hws[IMX8MN_CLK_A53_SRC] = hws[IMX8MN_CLK_A53_DIV];
+	hws[IMX8MN_CLK_A53_CG] = hws[IMX8MN_CLK_A53_DIV];
 
 	hws[IMX8MN_CLK_GPU_CORE] = imx8m_clk_hw_composite_core("gpu_core", imx8mn_gpu_core_sels, base + 0x8180);
 	hws[IMX8MN_CLK_GPU_SHADER] = imx8m_clk_hw_composite_core("gpu_shader", imx8mn_gpu_shader_sels, base + 0x8200);
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 201c7bbb201f..91309ff65441 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -405,9 +405,9 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	/* CORE */
-	hws[IMX8MQ_CLK_A53_SRC] = imx_clk_hw_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
-	hws[IMX8MQ_CLK_A53_CG] = imx_clk_hw_gate3_flags("arm_a53_cg", "arm_a53_src", base + 0x8000, 28, CLK_IS_CRITICAL);
-	hws[IMX8MQ_CLK_A53_DIV] = imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
+	hws[IMX8MQ_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mq_a53_sels, base + 0x8000);
+	hws[IMX8MQ_CLK_A53_CG] = hws[IMX8MQ_CLK_A53_DIV];
+	hws[IMX8MQ_CLK_A53_SRC] = hws[IMX8MQ_CLK_A53_DIV];
 
 	hws[IMX8MQ_CLK_M4_CORE] = imx8m_clk_hw_composite_core("arm_m4_core", imx8mq_arm_m4_sels, base + 0x8080);
 	hws[IMX8MQ_CLK_VPU_CORE] = imx8m_clk_hw_composite_core("vpu_core", imx8mq_vpu_sels, base + 0x8100);
-- 
2.16.4


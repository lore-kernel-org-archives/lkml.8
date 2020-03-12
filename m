Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FDFC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2781D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmyXyfT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCLK12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:27:28 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:42173
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbgCLK1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:27:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBwayy8EktIyE0WMr/ExbevajWQJ6mc59CmpVV7Xi2AVMqXP2Tmvh2kjILsVRr5hD61ZjEKNy17t0jc3PSljMzFthHHBNTTiWE7mSrCtImPd1eFWs4R1jwaahI/CkP44okQbDZ9lTzGDhy0fcbE8+1x1YSVElGkCx1xAUjraLsmOSR9TK59yyLay+QWQau55/vLECaJhRnRSZTLQPl1TIFmRK8v6IVm7Tx6M5wGz2p2fJj3ZaUEFlrJGChThknqLqCt9dFtbz3+nb3QQMq9RVEgzD4R8ZRjGGmgOOzrEE0Qx2ZBqwgOl5uakX8VuACgzND5kI6KptpPuYiW7gcYbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obxC7ONXcmaL0Xazi7UayeJxNbg8wwo4Rkj8J9xuJHA=;
 b=HT5NMSCTDn/3654MbzcR90j8HU4igc5enUMWahgy+8lM7C2mZMGXQ8ksERM4OXVQyTuC/UsrQNNR+XGheaOPUpQFpnTZ8Ri2fw3yz0nvRn7ireeOp74/qBKGXKXDuJRpFrp67SZNnTr4XBiHVGX9KLF9djdarujbBbyIInwKDV6iPWgQiYpJaoo9JBaYatdm/36Yy7TuZ1VrdJIRX37r1Q3Y8ec3wJGN5BQuvU+0dFnfOGdf+KONi6lb4ZkzAfGbaHT9nnVbMmg+TELi2hxMgb5SaztNEpdddBasw+fmKA2UKCHqMXUGFDfMor4MmMJtWlvnjlDZBvr+rxsL8WZvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obxC7ONXcmaL0Xazi7UayeJxNbg8wwo4Rkj8J9xuJHA=;
 b=jmyXyfT+WudKIWtrNqkO+x/7AZIJPP9B+8H1i7gmM+c0ZhYVSpFu79G9AheP8U8E4SLKvmXtien4LfakTYG7qA5sn3RJqt7Fkw0R3P9Qj3UeVjX5X/9H9ZZTIZPhaccaxWatR8MCEJRLyad1CGDj0INp2CLVLBqZdZg66NbK3lA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6177.eurprd04.prod.outlook.com (20.179.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 10:27:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:27:11 +0000
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
Subject: [PATCH V2 06/10] clk: imx8m: migrate A53 clk root to use composite core
Date:   Thu, 12 Mar 2020 18:19:40 +0800
Message-Id: <1584008384-11578-7-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0113.apcprd03.prod.outlook.com (2603:1096:4:91::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 10:27:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f4257b3-1b6c-4d68-0027-08d7c66fec86
X-MS-TrafficTypeDiagnostic: AM0PR04MB6177:|AM0PR04MB6177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6177866FB886DAA5EEAF293988FD0@AM0PR04MB6177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(199004)(6506007)(9686003)(316002)(81156014)(66946007)(8936002)(7416002)(36756003)(66476007)(6666004)(69590400007)(2906002)(478600001)(6512007)(5660300002)(81166006)(8676002)(52116002)(2616005)(16526019)(186003)(66556008)(956004)(26005)(4326008)(6486002)(86362001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6177;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Z0mTE2sAk9MRXcET3jbixMPExZBt3vUDPOefYSxGvX39smwVmH+4x16c4dsC0vKRP154xMuczg3od/S3y67qcbTI9LMkiE/Xu6AxyAZYJ+ic0XHl+290Qlbp06LxMq8LKzbJFlcrrxl+0ITnUxE5y/KQY1AbxbPkOmf+CdwnJ0I6EyjmFtcg8N8KH5G36mPl2H74YsjQR6GNm+Q7bbyCV5D/9HH3CyS1fcFvN5icEKrEvR2UAOgVvsM15roHmtfzhVldro1+qsObActOUKNtzLmMR+CAy2N6aDZmgZpr6lYgD4aMDIzS8/T4+VDg1wm4l37RD+gsB6lPMphNbqqdPyJMgSZZ3qLXxyxrCEAUmg10/RLbpWqbCUapw71wSFPgsm/lBlP9W6mUPBxX/s4yVlpf1j5J1xfnoItL1mAGHWifM+Hf+59cZuzw9YzNpqOQ9c+kvpi22WB9oaoJRdsP9NQlXeo4eBsgqxJidiKzJl3NL5lc2VnCzYfl8mft9JARZmUFKArprBM4sn45YTu4Q==
X-MS-Exchange-AntiSpam-MessageData: 47h1y788eJoRMTpKObdlqvPwdibIRFuo1pE823HjdWx4RVDrBZyHrLIRW2qSJX/zWXOTzMyc6e9d3Kp2EQxGvStf7eRKrKhF9hMaEulasNWF9Hu7p+Haqmx/JwFziHZo6lD8xk6TPaULajksxySd+A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4257b3-1b6c-4d68-0027-08d7c66fec86
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:27:11.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ruSmGa8BGUD2Jy/eEtKg7jTX3qQ3HMxnys08CITSQ359idKg23sibn1ltBcmwYmtdQSKn5ffbsOeoeiD+G9AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6177
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


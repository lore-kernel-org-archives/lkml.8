Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C324C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0144720737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g2wAdDm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCLK1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:27:34 -0400
Received: from mail-db8eur05on2068.outbound.protection.outlook.com ([40.107.20.68]:47311
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727036AbgCLK1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkfieCfh6kv9Xp4uM0D6L+IEKCHazi/edjttLOgbYOrHLiSePQXAaGaD9Aa9HYlxpSl+14y3kMtBOUvjFamEhlYh7LfT7BGKwUP/ayGyB0thkExVJWJtUwYGUHcr2+v7jshxroB3t9BWZajDy+PwZIsRlFr1ELvNyG8NCUuG7/ZjN92ugpJE25s95WMvFUVnwEgPbk8s0ohbfMgzoTrXVIQWRbybFyiIODhooBfmpdReR0R4I3cpwgk0eHRsz/+CsiIiLeTsKvWw8t6towjDUxA9zBVoH7LG2qzAIEHmpEURt+eYngR2PIGqpBa9RYjJrvfVhyOZuLZjI2hdWHNhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XitpZMODXlBhzhhdUcIvaO6eQ0Sq0BCK7S0mQufagZY=;
 b=h4pxOm1IvU6wqqFuuquhZOFqI4cphxFKgxZc803Jrx+cefUWaIWQC/87/lsMyxNPFNtogWYmFQzHi3MZE6hvwtiP9nY0kGsaouThbeH7JBbGtXIIR1hT1Klq16X5aZWAoz2t2d+gekiHYwGsIvkDfdsabrLAQc1Xkyz0MqNDLYf+zxGgxQDSFt2m573PO72SIyagIy0ckHafWYSELMCuTIa942otT+ZIIAiUTqku21M9ePm/xjIXlRrgJUCAKtdCzbFjdoWY/TTnS1yYIRJff5hRxfi+MNKeXlKqsfyheD+FJUpkHVk3a9h4s1mSNt0OAJ4tdeCMCrnTXzI6UAosTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XitpZMODXlBhzhhdUcIvaO6eQ0Sq0BCK7S0mQufagZY=;
 b=g2wAdDm3e89k4diM+BfS5sOzkqJr0OLeahi5t08s2unPh6luDj3JW24sALDdcRTJZ2WV5WidyNfyRtjkUvXVUYoGL/TS+14hbuDlrRqy/HK3n5JNTP/5uPC01oSMvf5iuVYWwGPgk+/9DZhH2q37Og/fDP4dpyPb3pSP0MPIUew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7171.eurprd04.prod.outlook.com (10.186.130.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Thu, 12 Mar 2020 10:27:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:27:27 +0000
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
Subject: [PATCH V2 08/10] clk: imx: add imx8m_clk_hw_composite_bus
Date:   Thu, 12 Mar 2020 18:19:42 +0800
Message-Id: <1584008384-11578-9-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0113.apcprd03.prod.outlook.com (2603:1096:4:91::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 10:27:19 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ada521f3-d97f-43f5-d811-08d7c66ff53c
X-MS-TrafficTypeDiagnostic: AM0PR04MB7171:|AM0PR04MB7171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB7171B30D2B583325B989773188FD0@AM0PR04MB7171.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(478600001)(4326008)(8676002)(5660300002)(956004)(6506007)(7416002)(2616005)(16526019)(6486002)(186003)(2906002)(9686003)(86362001)(6666004)(69590400007)(36756003)(81166006)(26005)(66476007)(8936002)(6512007)(81156014)(66946007)(66556008)(52116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7171;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bk+gDk5kI3JbMZaUab89EhHwBzRXjRLaRSRdtlW1xQR2mYpMzBwyKhSCR47k0LDQyp9H0cyFPlVR7Rc2ZUGaBIcEF1J7QbX4ww1ht7Icfk4Hw2YkwBw1Efcf0BIy5BeLdhbS39dH/WgiB6SoeRofUGNvlPgnSCdPB24OTyOdqi7OIufN60TpWWDg8yVYOh9ue4rHBKtpgZFibGskzxFaaB/SL/OXh2qxKC5xO17X7x6imiuH4q1SB3Iaib3FATN4oiGbZxUZ+YaMHG7d3O3pgs7X6A6J3yMo4B6gY4jwRLJRZwYyeEFDxSZeY0Inx/kjbmrLu90/h38CabD2CvYfkcCM43NCaQs12HAMDEckmhl1MqUnSkR7IbGvKXQSYLiImmd5v9F66KEvaJkfNUsCl8qDQ5uRuETTt5q5uJrYukCrfUKnYU4+EaVbS1cFFnKHCInRqC9xPO9Ee8sVnbnzSpyl/Xu7xA1uQPcJn63800Pj7f0tLiOXWUnm2ElfmewU
X-MS-Exchange-AntiSpam-MessageData: WzCOAxSQTWpaaUjXVcOm/AaZORLNACMMUwxFyHipNMFWfwqoAFRz9BkzTkJSv8zQ1e9LHPn8zJrflT6oSsfp0anZrrmFQTJbyiagSZRhDIEQ0tLctTgLmSn7JgytxzsE3Er9+GCvleoCKfeTUTtbgA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada521f3-d97f-43f5-d811-08d7c66ff53c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:27:27.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xO5RqXce9sZX5zCbcQyA5B8l4eoUXiDhSQT4+u2uzHSQ5AGplNT7ETkvmtnXIs/Pcj4OYoDm6rugTT+KiI/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce imx8m_clk_hw_composite_bus api for bus clk root slice usage.
Because the mux switch sequence issue, we could not reuse Peripheral
Clock Slice code, need use composite specific mux operation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 5 +++++
 drivers/clk/imx/clk.h              | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index eae02c151ced..ec28643426c2 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -216,6 +216,11 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 		div->width = PCG_CORE_DIV_WIDTH;
 		divider_ops = &clk_divider_ops;
 		mux_ops = &imx8m_clk_composite_mux_ops;
+	} else if (composite_flags & IMX_COMPOSITE_BUS) {
+		div->shift = PCG_PREDIV_SHIFT;
+		div->width = PCG_PREDIV_WIDTH;
+		divider_ops = &imx8m_clk_composite_divider_ops;
+		mux_ops = &imx8m_clk_composite_mux_ops;
 	} else {
 		div->shift = PCG_PREDIV_SHIFT;
 		div->width = PCG_PREDIV_WIDTH;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index f074dd8ec42e..d4ea1609bcb7 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -478,6 +478,7 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 		struct clk *step);
 
 #define IMX_COMPOSITE_CORE	BIT(0)
+#define IMX_COMPOSITE_BUS	BIT(1)
 
 struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					    const char * const *parent_names,
@@ -486,6 +487,12 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					    u32 composite_flags,
 					    unsigned long flags);
 
+#define imx8m_clk_hw_composite_bus(name, parent_names, reg)	\
+	imx8m_clk_hw_composite_flags(name, parent_names, \
+			ARRAY_SIZE(parent_names), reg, \
+			IMX_COMPOSITE_BUS, \
+			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
 #define imx8m_clk_hw_composite_core(name, parent_names, reg)	\
 	imx8m_clk_hw_composite_flags(name, parent_names, \
 			ARRAY_SIZE(parent_names), reg, \
-- 
2.16.4


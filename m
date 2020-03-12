Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E989C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0C720737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WTy8q4M5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCLVcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:32:11 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:23165
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbgCLVcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:32:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7PbNQqQybuqevuMWOZeHVo7CdSJXr1l518/BhiYfbPs9Cqd/vI7bfJh6JpF72BxDRzzZTDVwJjPZb497+svGc0OGp8rfkGaeKFWFm84rQ1WfKbTGH3/A/wfFO4X6F6TVAVDbVvjoOPlEi4QnIU2LJuK6T17V3tEXstfTumpR9dI6GMaxPFAg+k9ZNwzRpMUyOom2deaHE9C/9AJw8E8RPKl5bOIlbg/GorWyc/XPV40rbegdqqTBQJ3r1AIC1JMc07WJDoyLd7Vni7KpmwiQfmNuxzPlxx1FsLMOQrebz++MkLQDo2TvP7ExlSv82De7Y388DxzQYvFOxsPqdgeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYZAhCkmw2pEBIW8Ef75RaBl0tKuzdxEfWRlLaYzo4k=;
 b=elbuLwTMPOxFEl0GfyeeoVnHRwfE2GFJLHr8g3Y64UlLVKdplwEpvu18NWHWZnHM5aM1eNn4OcaOo6r/pWub73WByTOz4lFWB4WzC6l7+ztz/qHjqeOGU9+35xZN9LYCxDoClU+KOIrHxvM3gbZ52JbMmXrNu1Hgzk38SCgXWA+Kg1Dy3KG1WxE9MIhk6nJZhRNpKHD1X0JIbNUsuT5cwbSOU/L+gR1/yyT2zvJ4jWA612yRo4MubAbGxKfeHDT1YrDaySNEKnx6LkuPQ3mWJp77uTYGVlQlqlKzZuYGlkJ9a2HLR4YaCo8yrsr5L2H9gcMWPH9KODemaWFe8Ef+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lixom.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYZAhCkmw2pEBIW8Ef75RaBl0tKuzdxEfWRlLaYzo4k=;
 b=WTy8q4M5NiWISY7115yuIwyVGBBSHfaxkUtjajtQY3xJ8xiHS5Df1xddrQPt4UJsOPSXJyObvr66rBlEcXSUAKW0qIjOIyCsL/oPCRcGlqOablZKdbwvvju0qg5YqvoRMtfAc+QIZ1P48eAoNRsDScDkXzqgkAtx5o5tWImqPE8=
Received: from CY4PR14CA0046.namprd14.prod.outlook.com (2603:10b6:903:101::32)
 by BYAPR02MB5158.namprd02.prod.outlook.com (2603:10b6:a03:6c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 21:32:08 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:101:cafe::62) by CY4PR14CA0046.outlook.office365.com
 (2603:10b6:903:101::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Thu, 12 Mar 2020 21:32:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lixom.net; dkim=none (message not signed)
 header.d=none;lixom.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Thu, 12 Mar 2020 21:32:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jCVR1-0001nF-7y; Thu, 12 Mar 2020 14:32:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jCVQv-0006jp-Rq; Thu, 12 Mar 2020 14:32:01 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jCVQm-0006iZ-VK; Thu, 12 Mar 2020 14:31:53 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v2 1/2] drivers: clk: zynqmp: Add support for custom type flags
Date:   Thu, 12 Mar 2020 14:31:38 -0700
Message-Id: <1584048699-24186-2-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
References: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(199004)(26005)(7696005)(478600001)(107886003)(5660300002)(70206006)(4326008)(9786002)(8676002)(81166006)(81156014)(70586007)(36756003)(6666004)(356004)(8936002)(2906002)(54906003)(186003)(336012)(426003)(316002)(44832011)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5158;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b763930d-e948-4300-c81f-08d7c6ccd0f9
X-MS-TrafficTypeDiagnostic: BYAPR02MB5158:
X-Microsoft-Antispam-PRVS: <BYAPR02MB51580687786A5A8BA2A15084B8FD0@BYAPR02MB5158.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 0340850FCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXFu566WP1boX8ZlV8as3nYE2dGrRKsEMZhIsFffFmrlTcQ5zZzeE2iCCAoqMDgGNpHxTAhAgATW05rM1+jxDXL9A54jDEwh9WWSo+aI6N3R+GpqKWzJ34WgPzea8SMGDaLR6TUt8SICRW3kZxPY3yCUIDtRtOkiuOr9Ck4sBDgHaoaFJn0U1pJBTGcqYvOUH3YqLM9i7pO21qshMb6YtWU6PEL6UmxTlw7NACQ2usez/g7hGFSvvzIwHeyVBmGMk5OdDLBmAV4CD5yilfff/iVrMajhePbcEIDxkp/HsjwbHpii2FpKOTL60aYuYg57QNzTOM9jC/hut5PY+eQZWWXU0rD8ZkGm3qmfCNUiqDvCJM6GGZuSY3SO5nBjrzp/gScUOoFHfjNA1aHzkJLpFufA4hVaomOJzYJl3v0R1hljdOghtDj2dCMLUEdp9QkL
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 21:32:07.6532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b763930d-e948-4300-c81f-08d7c6ccd0f9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Store extra custom type flags received from firmware.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clk-zynqmp.h | 1 +
 drivers/clk/zynqmp/clkc.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
index fec9a15..5beeb41 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -30,6 +30,7 @@ struct clock_topology {
 	u32 type;
 	u32 flag;
 	u32 type_flag;
+	u8 custom_type_flag;
 };
 
 struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index 5eed5ce..e12d01c 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -84,6 +84,7 @@ struct name_resp {
 
 struct topology_resp {
 #define CLK_TOPOLOGY_TYPE		GENMASK(3, 0)
+#define CLK_TOPOLOGY_CUSTOM_TYPE_FLAGS	GENMASK(7, 4)
 #define CLK_TOPOLOGY_FLAGS		GENMASK(23, 8)
 #define CLK_TOPOLOGY_TYPE_FLAGS		GENMASK(31, 24)
 	u32 topology[CLK_GET_TOPOLOGY_RESP_WORDS];
@@ -395,6 +396,9 @@ static int __zynqmp_clock_get_topology(struct clock_topology *topology,
 		topology[*nnodes].type_flag =
 				FIELD_GET(CLK_TOPOLOGY_TYPE_FLAGS,
 					  response->topology[i]);
+		topology[*nnodes].custom_type_flag =
+			FIELD_GET(CLK_TOPOLOGY_CUSTOM_TYPE_FLAGS,
+				  response->topology[i]);
 		(*nnodes)++;
 	}
 
-- 
2.7.4


Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90949C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDD4206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SxcZlyjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgFZSqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:46:51 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:20787
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgFZSqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzAWrRcwykWB48nl2hpxh/8e7ajU6YWWKY5OTLuYMX6Vz0YyiHiM9w6341Vp4QoqJH7lrcB2n/omvwhHS8CkWScK138FrBh4ay8svsj5SQKKhJ9CbyE5DC/iY2OYJdUo9wWJzlvkHH58QJpiFF4yzE2YMpMii0BnS5RJbBwLA5DhwEN3Q2BX38MVpOGneFHM5TqJYRj+BQbYJmibRjEaUuN1ZOlz0sut7BQih050Owf922qK0VkKekoAT3ZLzTP8MSWb2dCROv4v9ZIiQDV85DKSWxKMcvNtON2J1mfLi6OS+Im4f41lEFu5p3GYKXAb+rBfVHPlZn1d/zbCebts8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZc5qAaVTWR748KjKTqJVHlSntreeCrhofKfdKRvJKs=;
 b=K2wOs00AnBal0vcg1XVpqlJvu4E/0IdNeDS+n8wgkRaCh2xuZNH8l3ForlnqaUPaIjGrEcWn/w9EWZCJlgt/KzuZU2nz3CdeYfMN3K2Dm7p45hpAQEVb6+g21XvTDgK6CYj9sLA3YYj0dmNGtc58bJQ/I0LbNMbvOQVTsP0LZy9qH55TOWhmfu0gtqMq7Uf1jJxM5GwzDx5MS6e15MxaryCXJ6ULJZvIUatl3trQnO1LbF8Gv4XZ0o28EsojBl/r90OdYilp7BO83Z1zBRYQtjDovXWJxmm+5McewV8zGwmFQ+Xpp3ObQekN3iwtr2D9no3hVom7ydla0Skgtdq0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZc5qAaVTWR748KjKTqJVHlSntreeCrhofKfdKRvJKs=;
 b=SxcZlyjJUURoOmhxTxHTLr0tC1i4Y+MsEb7D84FomLc0c2nJktjJKTBF7CvteReHKSOi5NKpLqV02MIJMK84qgfUSqOerICEfGvlB7GhwWNfB00ff1DTJIRr/fbASpf8waj1721ZDzqqgUGNKqWNbdRRBX8fPj4g14iyDEeaxCo=
Received: from DM5PR06CA0037.namprd06.prod.outlook.com (2603:10b6:3:5d::23) by
 MN2PR02MB6877.namprd02.prod.outlook.com (2603:10b6:208:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 18:46:42 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::31) by DM5PR06CA0037.outlook.office365.com
 (2603:10b6:3:5d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 18:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 18:46:42
 +0000
Received: from [149.199.38.66] (port=35802 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotLo-0006GJ-Ot; Fri, 26 Jun 2020 11:45:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotN3-0000vz-O6; Fri, 26 Jun 2020 11:46:41 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QIkVwn018117;
        Fri, 26 Jun 2020 11:46:32 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotMt-0000q1-Lx; Fri, 26 Jun 2020 11:46:31 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v5 7/8] clk: clock-wizard: Update the fixed factor divisors
Date:   Sat, 27 Jun 2020 00:16:10 +0530
Message-Id: <1593197171-21747-6-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593197171-21747-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593197171-21747-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(346002)(39860400002)(376002)(136003)(46966005)(83380400001)(316002)(4326008)(6666004)(70586007)(336012)(70206006)(2616005)(426003)(186003)(7696005)(44832011)(107886003)(8676002)(15650500001)(36756003)(2906002)(6916009)(26005)(9786002)(356005)(8936002)(5660300002)(82740400003)(47076004)(81166007)(478600001)(82310400002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 54a1c47f-b4f8-4f0e-b6bd-08d81a014492
X-MS-TrafficTypeDiagnostic: MN2PR02MB6877:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6877564DC5CDAAEA3356CD29AA930@MN2PR02MB6877.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DuLCgB4Fuwl/lQkGvRKDjAxD84SO7P7ovZe+TdRaaNmX6Bkk9pb2fZqJszerf5XOy6CM5ITgESbkJLvJreX8cog26hskBzHP793/V3/BefGSSvVBAZKXC0q6K+oPuZU5rT4AVWJRIcbQpSNfSSQUcyc7V59P52wsgOQPouECFAbGG1MM/NuNGMqXvLQgepNupB3PFn/s6Q6pCvTGrgDmiE0SFVH4Es0wxnsK1b/eN2aINUICTDrHxXiLUTUTugPP4Mz9MtAWB0ZY+rLhfz4NRsUoBDvNFRj4bxKLwhXrxWAAl3P5IaPhfBMlRjZz/4cknjymznwHc6KtcUsMZF6vQuX3+JcMgKH86YcjOiEyBIOtV80C5XlggcZa4y7PN3/wGNaDW0CXhqIPhG8s0m0ow==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 18:46:42.0570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a1c47f-b4f8-4f0e-b6bd-08d81a014492
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the fixed factor clock registration to register the divisors.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk-xlnx-clock-wizard.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 0c57ca0..5f53bfd0 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -493,9 +493,11 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	u32 reg, reg_f, mult;
 	unsigned long rate;
 	const char *clk_name;
+	void __iomem *ctrl_reg;
 	struct clk_wzrd *clk_wzrd;
 	struct resource *mem;
 	int outputs;
+	unsigned long flags = 0;
 	struct device_node *np = pdev->dev.of_node;
 
 	clk_wzrd = devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
@@ -567,16 +569,17 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	}
 
 	outputs = of_property_count_strings(np, "clock-output-names");
-	/* register div */
-	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-			WZRD_DIVCLK_DIVIDE_MASK) >> WZRD_DIVCLK_DIVIDE_SHIFT;
+	if (outputs == 1)
+		flags = CLK_SET_RATE_PARENT;
 	clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
 	if (!clk_name) {
 		ret = -ENOMEM;
 		goto err_rm_int_clk;
 	}
 
-	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_fixed_factor
+	ctrl_reg = clk_wzrd->base + WZRD_CLK_CFG_REG(0);
+	/* register div */
+	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_divider
 			(&pdev->dev, clk_name,
 			 __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
 			flags, ctrl_reg, 0, 8, CLK_DIVIDER_ONE_BASED |
@@ -601,7 +604,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		if (!i)
 			clk_wzrd->clkout[i] = clk_wzrd_register_divf
 				(&pdev->dev, clkout_name,
-				clk_name, 0,
+				clk_name, flags,
 				clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i * 12),
 				WZRD_CLKOUT_DIVIDE_SHIFT,
 				WZRD_CLKOUT_DIVIDE_WIDTH,
-- 
2.1.1


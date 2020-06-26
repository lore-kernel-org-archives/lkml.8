Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6BDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFAB2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VrbqMaJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgFZMmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:42:20 -0400
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:64955
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726901AbgFZMmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgiZxcTicEoAnKsYWJ7d7qqCgOhh0sKSLxSAAdaiXfuZ9zrbkAkkI1hS1A04FqsRBFMphi1SBJi71Kkmy2Q4Pyh0HaK2zviQ2x7bZcJLollVbngVfEMCvDY0PmyCxoEeLJM0jy2xk5pn2d7V+HR5HeqHtZxIY82ARZDy49SLK9Lvv3uo6QtZ0W3sW6BYW2uoOFAn6asA8HCyWsguTueElmVAMB1072M4kJBfkXiXORBmOPs8RhJ74t16xBqeo3GXVGrRFC4tSLOsijkL0nWp7zZFeSbCkiEj8BMYnlcyuINr7GI/IKw5TpY7j7ewj689eydMbY/bP2qJJawkWF4XTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsyM7MCwBQJzq3HcMKV4fO/Fc8Nwyydz053t4wFoRVk=;
 b=lNA+akFkwWXAj9VYbeu0iPWTlIBwWlMhtKDqpbc3H/pLQINLxeFv8wQip4m3YCbxSCnUNsWPnGJ2O3U6QStD7w6LEq6sDIOFNKBAw+V1yH0XIerIowIcNG8lU0pCnQXSWBlmptMWHsV04lMn4zVZuFWqUbw2tfMnwpSsFMetliamAjbqC7b9BTS0MPQg0UbytnraOlTjaUBnCvHtYBXspkVvPMgZPN0GjsOL+rxGCAc57CtWupH0Vh9ckdXWiMXRoNjrF9CyJdlraOlsSK+vptjuS+njY85aUxqQxvB6075YUCEj1IirRLWAXS+xO7NIYjy0t3N8GyHfiq7snx8eGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsyM7MCwBQJzq3HcMKV4fO/Fc8Nwyydz053t4wFoRVk=;
 b=VrbqMaJVrpC9NHkW/yZwCMwVFKiPOCopOKCkllzaofQvWwFFw0SODbjvyhU2XP9WuMuUeaEzCvlJl2dvC7pOL1sXze0wEDKULlgX1gqfeW/L9990WnymBEx+SKDrG1YszYe47lD/JfAB95BMdsa7dvgIEZ0EfKXFxWlf4QBu8b0=
Received: from DM6PR02CA0120.namprd02.prod.outlook.com (2603:10b6:5:1b4::22)
 by CY4PR02MB2567.namprd02.prod.outlook.com (2603:10b6:903:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 12:42:15 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::17) by DM6PR02CA0120.outlook.office365.com
 (2603:10b6:5:1b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 12:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 12:42:15
 +0000
Received: from [149.199.38.66] (port=38923 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonf8-0003KM-Fg; Fri, 26 Jun 2020 05:40:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jongN-0001e6-3r; Fri, 26 Jun 2020 05:42:15 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QCgAPh029301;
        Fri, 26 Jun 2020 05:42:10 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jongI-0001Wm-Br; Fri, 26 Jun 2020 05:42:10 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4 7/8] clk: clock-wizard: Update the fixed factor divisors
Date:   Fri, 26 Jun 2020 18:11:43 +0530
Message-Id: <1593175304-4876-8-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(396003)(376002)(46966005)(44832011)(2616005)(336012)(426003)(186003)(26005)(7696005)(47076004)(70586007)(70206006)(6666004)(5660300002)(316002)(8676002)(8936002)(15650500001)(4326008)(82310400002)(83380400001)(2906002)(36756003)(9786002)(107886003)(6916009)(81166007)(478600001)(82740400003)(356005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a813488-e3db-4a2a-d0df-08d819ce5b01
X-MS-TrafficTypeDiagnostic: CY4PR02MB2567:
X-Microsoft-Antispam-PRVS: <CY4PR02MB25677329BA287325AEDA0056AA930@CY4PR02MB2567.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLNhJzrjDZW3zw/wKZI5E6DFe0M/S7giYmEwtOCyuzXDOsSHt+FhB4mennN9sCsUeSIqyT+w85OO2YDwM778d2eATM2SdUC9eQhJDW5CpO4By7VZNbXEhfpGDX81wf3XUbGGg1TAiO3z2Bs/urVQKwqaX2hvdq0Cuqe075SdYwD6pedhpiEgU8HoJlGUIC2LfIJpdR5NjOo5VnuqbAwXjTvYvNeBo+jzaREzS19ZohVWl67/6ArePoso/+klEXrbGN8Mw2BR4cdO1YOgUHE+VYsTiesc2ZJBh3IwvDjMSISznrfRRpQ2cxCTHWJcgqYwlTGXGih8SJUueyLkkixYKxn+ApLkHe1e6/ArnCi8ma1Fo+LgrQtUMDZoV4bUsSm0Ue14cKW4N+FZR/k5BujggA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 12:42:15.3628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a813488-e3db-4a2a-d0df-08d819ce5b01
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2567
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
index 28bbaa0..333ada78 100644
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


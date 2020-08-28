Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C3EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F4520872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UbGxz/Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgH1OBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:01:32 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:25761
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727017AbgH1N7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEZMehP3Fv0ELHb9U8obVd6Q7WaAOI9kuqtc3i+4H36sWdSdR0gKbDkBKN8CVE7p/GOEH7K1BpALcV0mryNGHjuB8X+OrLOII+weBlcM4LAtutQAy60Lv6t1HyuUnXnjJTwCZBUeZSZ0mb+xs8VKNW7gFqbIJfz3mpd34PO81H6yd0b3YnHqKNUVSjalPjnx+7CwZ7zHIRlgK00rTNW+/TSRngLIW3jQAm5OgMHVFgQr8rcrOkAkVZSVlsTFHky3Ui1dQLfwIf57D3vr3lbas1jv0d2djvqbNYPUM2vYpUfe++atikzITQKL+IksY8dNur9/HKz58kLPDeWk61v7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw11UjkdmrTpMBFpCWkveLjVF0897nI4BqVQ+LZZIO4=;
 b=ZUoKt05jsPkz2rvcDiIP/wSiTt9uznDqZO5tYB1UAWYElrLDxfAgti/+uSth34MYVESYQKDQrjPyqYTvvpQktUxIs5LArcZCRvJX5ZpvFm3betntwa7VyaejM2RCAdLLNU6K18L5/Qi40N2/H5UKTUpsPQuQzoaHaJwN2ArQ94jREmm8PRe1MWkGFW+7lefrEnZw+veMFlQk9Pk05IMUpLb0E6XL79Zph6h2PRHYL+zNZPKziF3ogFH6aihDLyXeSbhNqsxyv71IPV8+pUVDZCV2ImHszpYfl2MoPpRuAjfVu/7iIZXrqexLEFxoDZt4qYJfZ7vOJmnqFECRZLjLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw11UjkdmrTpMBFpCWkveLjVF0897nI4BqVQ+LZZIO4=;
 b=UbGxz/Qu4OKjzj4C+IvTJ2xJF8NRiu6Z9TU0O1WVzZf+TJR5Dp4E4GNZG9LX4qIc3t+f292utRoHmPx2GkAjfltUAqeu8/5uQe/Fwfd/ydVhpnXKi93FMXPWV1fiTBfeNzdBBJx2HTGjoGHX9JElUtev9xuInqufAQz09gGsnnY=
Received: from BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29)
 by BN7PR02MB5076.namprd02.prod.outlook.com (2603:10b6:408:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 13:40:44 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:35:cafe::9f) by BL0PR02CA0124.outlook.office365.com
 (2603:10b6:208:35::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Fri, 28 Aug 2020 13:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 13:40:44
 +0000
Received: from [149.199.38.66] (port=60348 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBebx-0004uO-Gv; Fri, 28 Aug 2020 06:40:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBecV-0006Rp-IF; Fri, 28 Aug 2020 06:40:43 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07SDeaAO028728;
        Fri, 28 Aug 2020 06:40:36 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBecO-0005it-3X; Fri, 28 Aug 2020 06:40:36 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, sboyd@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v6 7/8] clk: clock-wizard: Update the fixed factor divisors
Date:   Fri, 28 Aug 2020 19:09:55 +0530
Message-Id: <1598621996-31040-8-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ad98676f-6c26-4790-c6be-08d84b57f65c
X-MS-TrafficTypeDiagnostic: BN7PR02MB5076:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5076B130696F3BB1F6D22224AA520@BN7PR02MB5076.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Um2Mr0P417EGkgYOb/OT/PkPXsZpHJ7+OkkwQSxwtK1spUDCneOZcPKGswbqq0C4VAFkpVGFNR6dsPDtJTXtA0/7vaKOknZpdTIGQIUNg8gmJ92yfeyz3PVBZGLRr/XJM9hDTJ9DsYXshCGaKMQXVklSG19d1yya4bEUt9f3GskwaVA8MuUSTInIPikgcq6NT8lZRT8Wb+6Pu7uHTI2z9bN6Jg/PgHm8ZYtYXPBr8H0FQ2WaiCR7dcixmcJTeuizCVwPg8SG7fQf4e3LGbsbHjD7PLoX3FEsOgEFsTT+tkaZ2Q+Eg3OK/lCRPb4oiUGQN9D4kCVPD0W2vF/I1Cqi17UbJ3R8335kCDchw/PKoOoFUidvUPtv5le9y3ewt0cetsHh4mgXpWBhglJmgbHR4w==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(46966005)(6666004)(478600001)(15650500001)(2906002)(107886003)(8676002)(83380400001)(7696005)(36756003)(47076004)(82740400003)(82310400002)(336012)(26005)(8936002)(4326008)(44832011)(9786002)(2616005)(81166007)(426003)(186003)(356005)(70586007)(70206006)(6916009)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 13:40:44.0338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad98676f-6c26-4790-c6be-08d84b57f65c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5076
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
index ded4cdd..fd69eb0 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -440,9 +440,11 @@ static int clk_wzrd_probe(struct platform_device *pdev)
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
@@ -514,16 +516,17 @@ static int clk_wzrd_probe(struct platform_device *pdev)
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
@@ -548,7 +551,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
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


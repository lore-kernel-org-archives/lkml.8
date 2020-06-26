Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A383C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF012078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FPQeqilT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgFZMmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:42:25 -0400
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:39808
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbgFZMmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsW5nJpz6SNM85kkM+AxQN8pNhEnTp/CDm4/gZFiryx6iNLOJSwhMoTvOoWikUF5PyqtYegNHVm0f5lecbedDeyfM8Rv/F88SW9MvmbbuMgysSsoZ/KLT0M3JNnzKyZyPuXWdIP6lPvD4H9E/Hcj/X0gKRE3jJYDDHgbWzohvB+DDj6YLASxcdo10xR4tefJE9tPq8ZW3APyhQwRndJN0N16vPGs1E8055GpOZuFNirtpAZpzsvUFUemfwBSfn9+dED+T57z6IWC7VLSIlCRpLpLZ/Rg6do79LMT2XGBMBhEZbwVO0JoYKu+64PNRnD4v9wBIrYwbN+c3PvYC5qQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3+NZcDNbTQUNbYMkLsFssrecdvIGZ2HkNoVWCv7X0s=;
 b=oKhPE7UArQGQkOEIdxt/TReEQ3o+jXX2EUShUla7UuA+TuZ1ihXfxWQlQAeVLT+Uox1XjukQw0R6AjSwQczRydbjR2S1JniI5Bnx+mjtjZWzzSQI1l6cyWDAIhdXbO/JfpxUIL7jXSqHupbLZhOeM7dvhDVkkxE75O5nCk26ab1BGtsOXAAXQKQfoHD/qTXwkFZDsj1YPYxreJpSOBbDjLPnx1llxMvrW/W/Vn7g1vsAx+OdnAwPXeAPuTC+kSxd+JJIIlXd+FH9DAdd7t5SBcyphXPNeke8Pvin5Ky1ZM2lOQeWP4/XB5xIozpKvdBBldWfK2S2PsHCMuUfb404AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3+NZcDNbTQUNbYMkLsFssrecdvIGZ2HkNoVWCv7X0s=;
 b=FPQeqilTa6BW8rmOnM7TcxHCcJSqC6pemYcCm2QUZtitpUcphIyPdaUmxQ6HVEBkNSoVhFwSZF+fQmcN3prU7kwi2gl5/ORw1xRsvvUNhajM+i+kPoJ64szRVnzxSTxtfwa3P/N28BmaxnvBh18WodAIKLTBYyuH0E7zBlZ5iOM=
Received: from SN4PR0201CA0023.namprd02.prod.outlook.com
 (2603:10b6:803:2b::33) by DM6PR02MB5083.namprd02.prod.outlook.com
 (2603:10b6:5:4f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 12:42:15 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::82) by SN4PR0201CA0023.outlook.office365.com
 (2603:10b6:803:2b::33) with Microsoft SMTP Server (version=TLS1_2,
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
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 12:42:15
 +0000
Received: from [149.199.38.66] (port=38889 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonf8-0003KG-89; Fri, 26 Jun 2020 05:40:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jongM-0001e6-SP; Fri, 26 Jun 2020 05:42:14 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QCg7HH029487;
        Fri, 26 Jun 2020 05:42:07 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jongF-0001Wm-5O; Fri, 26 Jun 2020 05:42:07 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4 6/8] clk: clock-wizard: Remove the hardcoding of the clock outputs
Date:   Fri, 26 Jun 2020 18:11:42 +0530
Message-Id: <1593175304-4876-7-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(46966005)(82740400003)(478600001)(4326008)(47076004)(7696005)(6666004)(2906002)(70206006)(70586007)(316002)(336012)(426003)(5660300002)(2616005)(81166007)(186003)(8676002)(44832011)(83380400001)(8936002)(9786002)(82310400002)(26005)(356005)(6916009)(107886003)(36756003)(42866002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 921f0d86-5a8a-49fe-01ef-08d819ce5ae6
X-MS-TrafficTypeDiagnostic: DM6PR02MB5083:
X-Microsoft-Antispam-PRVS: <DM6PR02MB508323E83B8BFC17C442D25EAA930@DM6PR02MB5083.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhce00l/ctLrYfVVr3vYhszb5Zz6GDl2yMjwoGv97ujT36cVym4FMBQB6AvdDO68RBc5coH1PXhPq0Blb9k/Q4WaxD1Ad2q3ZUT9mpzT65vU1n/+ps45p0zQtJRZKwwhfKsT6uCSNGp5M1TpRmfzWcPL264scZuf7ertx6RnNPpn+rZyDwDbW8CBY/w7BINlbXnHl6xXsQRDJIgdEAD5BlIa69U1DR3cYyRjSQZQpNa4tsu9UimsTGtiJv3GGB0Rg38RgixeBA07eN9nTZVU0X5hgr6wM+9hMnxInOiFELIy5R0QXDkJAiRK8ZKEC4WpuAKg27P032QEtpq7WrkmSdeuHp4yD6Dq+Bd+78EE8pVl2s7enoWdXyMOrNUEjGQ/d+qMzmPaEZkL9jYSwUHegHsrOgV6dpZwAXETGifp7tM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 12:42:15.1795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921f0d86-5a8a-49fe-01ef-08d819ce5ae6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of output clocks are configurable in the hardware.
Currently the driver registers the maximum number of outputs.
Fix the same by registering only the outputs that are there.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v4:
Assign output in this patch

 drivers/clk/clk-xlnx-clock-wizard.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 8a7f9bb..28bbaa0 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -495,6 +495,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	const char *clk_name;
 	struct clk_wzrd *clk_wzrd;
 	struct resource *mem;
+	int outputs;
 	struct device_node *np = pdev->dev.of_node;
 
 	clk_wzrd = devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
@@ -565,6 +566,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
+	outputs = of_property_count_strings(np, "clock-output-names");
 	/* register div */
 	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
 			WZRD_DIVCLK_DIVIDE_MASK) >> WZRD_DIVCLK_DIVIDE_SHIFT;
@@ -586,7 +588,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	}
 
 	/* register div per output */
-	for (i = WZRD_NUM_OUTPUTS - 1; i >= 0 ; i--) {
+	for (i = outputs - 1; i >= 0 ; i--) {
 		const char *clkout_name;
 
 		if (of_property_read_string_index(np, "clock-output-names", i,
@@ -617,7 +619,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		if (IS_ERR(clk_wzrd->clkout[i])) {
 			int j;
 
-			for (j = i + 1; j < WZRD_NUM_OUTPUTS; j++)
+			for (j = i + 1; j < outputs; j++)
 				clk_unregister(clk_wzrd->clkout[j]);
 			dev_err(&pdev->dev,
 				"unable to register divider clock\n");
-- 
2.1.1


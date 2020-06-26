Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01D4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9591206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kRCERXpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFZSqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:46:47 -0400
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:6170
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgFZSqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:46:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a309+VkQie/fTsmI7+ieaEmRW0qCkFzZi4BL9QKNVxfW+v5sSUss3BvunWeJL2yYWCmQUuIuuRq1LRgboK+yCmnKIWN1kzn0TdILSYvzZ+BUSPUwaX5AG2O3FsEwGA95eRGU1Maut9B24zWz3hQ+nsXc3Xdq/kfVq6dJlRpxYNm9ilREZYlwMfVU1c32U4iLc4wGO10Gd200JSt2SRHNd0+UDqqZrcFxQvu9cBVsksWUwUwZ0+4L9ZfWpKVliNZ0HSQ0o0kCrnjJeonc+8OHBipATG/0wChRwGhDEWEz8K6nWeIBwj5ofFjWui251K2vypsm3t5PIfp+KQq3Gd3emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvCDVAy2U8RIhh/TazJW5MrsoBihV+Z+btD4ER28x6w=;
 b=LQx37/JezGi7ht2au84cDOcuEm45azK5AmyCjsAluhgLi1wow9sJcheobTk0jA8KleOeFf70N3CtcbuA7xkLkCaREkQfTTKZRU5G+ycQwjMzs0gQRNJkIdkRfcE57drnqsIzd2kAjQCqyrbaFWTlOXa0OSAb8QqHVacTQRCv1JMpfEbGtynI5fLkq8qcdzWhmKcj0gXIbLIydMLmVaX0dKDevBqf3nYBYlMRWRlJBcSEV2RW2ewoNeMdnmABkGnSrYAGLN4Axrctn3LyhhmQSfDMXfw7lZ0TLi6jXI3eVsrCGYUiKexSYQbIJH3araQbZEB2OYwjnhDDsA2o5tfIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvCDVAy2U8RIhh/TazJW5MrsoBihV+Z+btD4ER28x6w=;
 b=kRCERXpkonxASyYbovGGtcXcCogLi7vLKOL+C2vcUfMdN9FLrlKNcf487Z0vjDeAGH5F1Lx6UKEyLxHfjSJKmG8fm+akoC3J+yP/4mUPFu8N3VYzvuLDhgxxpNjMjxsbEqzCrrfI9ZGTH5dR8Ku25spZQDmgTMuLzwI7cAkd2TY=
Received: from MN2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:208:134::18)
 by DM6PR02MB7001.namprd02.prod.outlook.com (2603:10b6:5:256::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 18:46:32 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:134:cafe::f2) by MN2PR16CA0005.outlook.office365.com
 (2603:10b6:208:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 18:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 18:46:31
 +0000
Received: from [149.199.38.66] (port=35660 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotLe-0006Ek-Fe; Fri, 26 Jun 2020 11:45:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotMt-0000uL-EV; Fri, 26 Jun 2020 11:46:31 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QIkSae018077;
        Fri, 26 Jun 2020 11:46:29 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotMq-0000q1-Ca; Fri, 26 Jun 2020 11:46:28 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v5 6/8] clk: clock-wizard: Remove the hardcoding of the clock outputs
Date:   Sat, 27 Jun 2020 00:16:09 +0530
Message-Id: <1593197171-21747-5-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593197171-21747-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593197171-21747-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(396003)(136003)(346002)(39860400002)(46966005)(5660300002)(426003)(336012)(2616005)(70206006)(36756003)(356005)(6916009)(81166007)(70586007)(107886003)(186003)(26005)(4326008)(83380400001)(82310400002)(7696005)(47076004)(82740400003)(9786002)(8676002)(316002)(478600001)(2906002)(44832011)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 987d849a-47d3-43fc-1c4f-08d81a013e7f
X-MS-TrafficTypeDiagnostic: DM6PR02MB7001:
X-Microsoft-Antispam-PRVS: <DM6PR02MB70010317FD385BF2D4844CD6AA930@DM6PR02MB7001.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJJKdvrhSl6AW9mAfdzQN3OjAV18cRWnU/51HBcfMS103DltckzbEU1OTlHt1lLPySulj250TGHmvl4aLGYDSzwtVIiDLFfJ+3urxM07wlUqxvLh+5ZgjJc5Cx3QoIMhKe5zIjgK+23ofhzzteXE0tk4vrsl0Zz29laI3l3NygJpwcJAdwjJjj0KaUJapPjuQJd7l4065tRaTh0ovWLhZD88Ph8sSlgHRy58m0iqrH9AOfAqyc5q7XbLFEkRrJgtBXeZHhgNWRtnSNInNRlNfX9yJONlentSuNa21F//yukGj4/10wRbS0SPKDV2RiBDhd3l96tFQuqX/Uk7ES8T/2VJcuCZH58zCglJ6IlNHaLp3dpsDWwgnhQFbWTG1JTtJHXRy0w4GEiWMkFhCPwUfQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 18:46:31.8627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 987d849a-47d3-43fc-1c4f-08d81a013e7f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7001
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
index 1cf381c..0c57ca0 100644
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


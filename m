Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E5D206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FHUXEJLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgFZSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:46:36 -0400
Received: from mail-eopbgr700068.outbound.protection.outlook.com ([40.107.70.68]:50400
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgFZSqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:46:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDpXSzvOaeFeEQxCyKN04DL2pSMCBzdbZ4kn0kSX4gyVN8EwoCOBmM96eUNr3BrLL5ZMDLnGFYn1b0ED4E22zxnlXru519tYtjoj20M71ylenc8xUGpiewDeGmxmgRs37zzMZzFfCtKo1C0SRUhMFIs1FA1AFVz9Ow3kEWmkPe5RWc28graGDGFw/2ggZwySbfS5fCeZoyRIeIC6ZPbTnfFbAKR5wKTxPorPhT8Nl/js5MTsv5ptzj6nCvBIjXinOKF8ZzupgZPU7LKT03b3suHZKKcFdGcTVhZdhg1hEEeUNblh7BpZJe9F7tI+yOI+aqs8DgDbKvR65I+lzOddSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAgPAMvG1k9Jse38eh3gYsIT9SQTY5QRjDjio5rLxtw=;
 b=NvOjMli/RAZZS4R30n9LZyCIKU7EAidRPrJXg3tpS5uDQiUuXR8MwfU3av2TNWYgjA4t68A/MRIpOhAQppUXtuiZT26PAsk7KFnKKgbkka4M6NF6opy62kD8T6UbYnjWvbkRiy8lZIosJLHBRUn6JP/wiwojf6eJQTW1fTRTKWCf3+QGmO+aRYlXaXMv6ZwwoKzPPT8EaJCIpY1fdo1P2VBwunBHvcq7PwL9b/Ienq8STc5ckp07FD1A8xn9TXzd+bcUpW3cbo5mPbm1PhuLMTVynmUqNbYD6XAVu93AuJraFrHL9cpedQBTk/BOlC3x01XxPcOJ4AQlEAAWJlFvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAgPAMvG1k9Jse38eh3gYsIT9SQTY5QRjDjio5rLxtw=;
 b=FHUXEJLKYCeug9oHXPiEKzQGyN41ehKGUGRnvWSuk8YyIoOuHIRIynFzCPqbV5zcrUL5Q7428ttyC42tRoMcLec4qygrXgDmVOeqwNieu4CFv2JGQJxfmpef9/zQ8ySQKZ9rRkYq/y5CK0GK/6a2nJzY+9L9+escSqptOfXrtb0=
Received: from CY1PR07CA0021.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::31) by DM5PR02MB2348.namprd02.prod.outlook.com
 (2603:10b6:3:50::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 18:46:31 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:e400:c60a:cafe::19) by CY1PR07CA0021.outlook.office365.com
 (2a01:111:e400:c60a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 18:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 18:46:31
 +0000
Received: from [149.199.38.66] (port=35656 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotLe-0006Ef-Dy; Fri, 26 Jun 2020 11:45:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotMt-0000uL-Cy; Fri, 26 Jun 2020 11:46:31 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QIkJuv017952;
        Fri, 26 Jun 2020 11:46:19 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jotMh-0000q1-7d; Fri, 26 Jun 2020 11:46:19 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v5 3/8] clk: clock-wizard: Fix kernel-doc warning
Date:   Sat, 27 Jun 2020 00:16:06 +0530
Message-Id: <1593197171-21747-2-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593197171-21747-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593197171-21747-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(136003)(39860400002)(46966005)(107886003)(8676002)(6666004)(9786002)(6916009)(8936002)(186003)(5660300002)(26005)(44832011)(336012)(426003)(4744005)(2616005)(2906002)(36756003)(70586007)(70206006)(47076004)(7696005)(81166007)(4326008)(356005)(478600001)(83380400001)(82310400002)(82740400003)(316002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 42916357-7ed8-4fb1-fe9a-08d81a013e68
X-MS-TrafficTypeDiagnostic: DM5PR02MB2348:
X-Microsoft-Antispam-PRVS: <DM5PR02MB23481B7ABE76FE2F77EEE758AA930@DM5PR02MB2348.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7b9Tr8XpT6NQzXNyVrSXZW7MYmeiVOEknWqu62aQ9CwSlQTSYFncRikbL+E5gq2c0spW7JzcYsv5wxKPqWsn/9/YUGXoHghslYen4u3QKHPBG+EwMQRJJCuztNMi81IoRbT6l4d0P1qbWlLM3YCi46zWpgAnOJLEr8tszYIaK8hViAdVEb58nIkxqlRSVcDyHNb1Iiuc/knY4rab2OGRIyAdGSMcThFps6j2fMlQxL55sXaFId8ZC3ZKI+ux2gttmh5FP7wUkZK6z3L2f5XzaKYoo56rjqtVZjJrRhHRSizux4mZgQ2iWw/8evYGS2iKmHAcm3xfTGsGUc+jSx5Cxf6gCrD27aU4xM98egRE0gL6fsmpYrORSNwlK7/tkUuQdu4c9yb3pvX3QA03CBMAPQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 18:46:31.7173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42916357-7ed8-4fb1-fe9a-08d81a013e68
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update description for the clocking wizard structure

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk-xlnx-clock-wizard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index b31524a..d6577c8 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -40,7 +40,8 @@ enum clk_wzrd_int_clks {
 };
 
 /**
- * struct clk_wzrd:
+ * struct clk_wzrd - Clock wizard private data structure
+ *
  * @clk_data:		Clock data
  * @nb:			Notifier block
  * @base:		Memory base
-- 
2.1.1


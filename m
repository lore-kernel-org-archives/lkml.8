Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0575C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B4B2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IaRFue/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH1OCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:02:21 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:51425
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbgH1N7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:59:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjGsuQGrWZuruTaqPA6hfBDfQSrB30lLWChEszyImXToedJxXn4CKT+X8I1i+59zenXW9KDFONSSLPwxNkxbWdhSHr15wA55bJz0033SdwQTvB8LlSoMexBuXvlttjO61//Z54Pk3GvqV0zHMo2+Jw3eWGssALbJFC4kR1DXWAqQ5S66yo9QIshdFYiP3eqMJUUPQWISz9qUA9rCDBXm3B54XOfNYTGbtIiQghsue5Yk+4Mh0+7bwmXv42IIxGIgsH3iYgnwFQMiQ7PV2ECpwpGOnlSGkQzTdQ47YQuM/yKcitWCTq7wvBBEzxSEUUvzcj5ntplUZzrqaLf7UgQdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAgPAMvG1k9Jse38eh3gYsIT9SQTY5QRjDjio5rLxtw=;
 b=bbwGKKgTJswHKESyuqgGuTITdafcs7gsAFzrJCaBU7s3hYSIfN+01W/Q7yPtLLLosTixnPLxocp/LEFdoh5HO4iCE809BJcOw2QpITzr/MdwzAgyGMiRwi+orkpD0jfBd5DCLhPYs3a5O2JN7cwDnMJhbksQ4aNYJ/h8ldw43DvhY4eiC6EKU/qrnffBZIjolLSm7I0bJfadIrWK2G5seXkUKt+QJGR70grNH0knWz9TWw3hqQYi3rJJyQfoY7171JtGm5Po9nyz+5OWions4zGCQY1iPTbFzw8K9hbEq7TZcPiuW0SExJXyTz0Fjel9VcU2ISH5mLSCSbAYp9dGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAgPAMvG1k9Jse38eh3gYsIT9SQTY5QRjDjio5rLxtw=;
 b=IaRFue/3DiyKL+qBYpcum50aZY4IPlerRledMTSi89w8XSFOpCNbeuPg3Mrr/M9zpaOJqzkl70FdKONzUv7dl1dGx8IO+qExPaE0ODEs47PRnEe//i4A9x4a8yPfV8mmyj+n4g/zddiCiyhbZnZ20UfYdKCbBPBykZAuIsrhdCc=
Received: from DM5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:3:23::30) by
 MWHPR02MB2591.namprd02.prod.outlook.com (2603:10b6:300:43::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 28 Aug 2020 13:40:25 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::6b) by DM5PR13CA0020.outlook.office365.com
 (2603:10b6:3:23::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Fri, 28 Aug 2020 13:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 13:40:23
 +0000
Received: from [149.199.38.66] (port=59354 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBebc-0004sZ-Uw; Fri, 28 Aug 2020 06:39:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBecB-0006Fd-09; Fri, 28 Aug 2020 06:40:23 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07SDeIRs024642;
        Fri, 28 Aug 2020 06:40:18 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBec6-0005it-59; Fri, 28 Aug 2020 06:40:18 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, sboyd@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v6 3/8] clk: clock-wizard: Fix kernel-doc warning
Date:   Fri, 28 Aug 2020 19:09:51 +0530
Message-Id: <1598621996-31040-4-git-send-email-shubhrajyoti.datta@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebe8b6bc-b321-4346-2953-08d84b57e9f4
X-MS-TrafficTypeDiagnostic: MWHPR02MB2591:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2591F39509879AB0D2E5DBF0AA520@MWHPR02MB2591.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ML8gTM8i8xz0fGkiKMMvrVD18t32/So5Rm8Gv5uVlzEzYwAXVvOcUYxuzpo8N6L6evVidvGwRT4oyEYO2lUVWcOcOJPkYR9H0OPpMc/2P3i2RDX4S5BGFEZ/uRh3epVoNLvFzeL61o51qFvKpmPgvIaMywrTv64wj4t9fk+6uTV0xKIwowze0uawqs6fQo+3OIEvNQKmGMPj4BlCRjCpRswlIk0ND8kSl5pd0tVa30Bost58aHp6/unCCP2ZwqDy9bt1zf4uHkCWV1AUQdY2HqsTN3VCje+tdUQDGAx5NARRfJCgyBhpxO5U0+EQqwlHDVyqi+BTbyi6DBqEUNJ3y6cvg7m6PSBWTChyTUUt+iKdw6fOFsx4fadjmFTh1WkgY1QB3ncTP894leLDI1X2ZA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(136003)(46966005)(186003)(7696005)(2616005)(5660300002)(70586007)(26005)(83380400001)(36756003)(9786002)(6666004)(336012)(47076004)(70206006)(2906002)(4326008)(4744005)(107886003)(81166007)(478600001)(44832011)(316002)(8676002)(82740400003)(6916009)(426003)(82310400002)(8936002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 13:40:23.2155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe8b6bc-b321-4346-2953-08d84b57e9f4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2591
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


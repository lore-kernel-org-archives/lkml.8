Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D8FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCC42078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aBeIiyMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgFZMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:42:09 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:29774
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728485AbgFZMmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1QVS1HF1JIil9TNBEB9kGSEchXroAo6ApXTeWdx/cFtIGUz0tlMkSVwa/RWEeztjbIH1vzTpjidImTk90GMYFAIeYsk+dmT7t2wZYz9gVbUW/dxzdUqfAsUSXjD9dPYu3w6cnLFi0jozDAnyFCJcZpYvklEYyDdM4x97UHBD3sEsXo4416DZZah6bVMYX1XUmKZJp7wJR9h/Hs+4IwzcBvNWTc6lEMWv8UQ6lmMTEAjbYMETyaM8nrgshsC3qYY+OdYELs3shjfEwZkOcimig8eDfd2O8mDR6bze9HL3gVWD94bvCPrjOl+olSPRP/pf7SNluvuaICvu8oRYat9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAgPAMvG1k9Jse38eh3gYsIT9SQTY5QRjDjio5rLxtw=;
 b=ixPMHwC1+Wbi5zsMhU1efcsF/MQemmp+AmgmQYbLjd4w8JfevPkPPN+PgmXBG9LM4662SuwkpxhqrF/4dG+ZrTrSGb0dHwS/tUS5iuZYFYFkh+dYQmnxJoSiE3sMB5giyiYjQMg4BwNJH4J4yu5fg5cbrhMceRer1eKAo0ppHmceTztU+ltenNVU2poVlRAYQ1cBnAOXjGh2nFsVtzGBOsHdbzYIe6eXNHB8almShwIhYowTsLs9L9DziHum9wLe2wWWenvuNuRNsoXI7rBYASuKEdbTJnOdssksfF1Ux7zZc1qxRafnEZXFHgz1pwmECktMv/1JorskeQQB2EnpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAgPAMvG1k9Jse38eh3gYsIT9SQTY5QRjDjio5rLxtw=;
 b=aBeIiyMvGg45RkYABQ/VhYINyVySTmXxl0YoRzWmvpSSSgocxYdVnjc6KU7ZLU0Rwy+jpHZHmg1Cls15RIcm9h/D5avIUzwjbkmwv5JzVzdpqDgO6Jkksw3HpPSVzc0oB/5QrhwVj2Qc9j5G3DJ8yiLOmkjy01niKsSJDQfgvm4=
Received: from SA9PR03CA0029.namprd03.prod.outlook.com (2603:10b6:806:20::34)
 by MN2PR02MB5952.namprd02.prod.outlook.com (2603:10b6:208:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 12:42:05 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:20:cafe::b) by SA9PR03CA0029.outlook.office365.com
 (2603:10b6:806:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23 via Frontend
 Transport; Fri, 26 Jun 2020 12:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 12:42:04
 +0000
Received: from [149.199.38.66] (port=38669 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonex-0003Jg-RH; Fri, 26 Jun 2020 05:40:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jongC-0001bv-Fa; Fri, 26 Jun 2020 05:42:04 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QCfwvs028981;
        Fri, 26 Jun 2020 05:41:58 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jong5-0001Wm-PM; Fri, 26 Jun 2020 05:41:58 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4 3/8] clk: clock-wizard: Fix kernel-doc warning
Date:   Fri, 26 Jun 2020 18:11:39 +0530
Message-Id: <1593175304-4876-4-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(136003)(39860400002)(46966005)(82740400003)(7696005)(316002)(356005)(6666004)(36756003)(81166007)(478600001)(107886003)(6916009)(26005)(70206006)(9786002)(70586007)(4744005)(186003)(4326008)(5660300002)(82310400002)(8676002)(336012)(44832011)(47076004)(2616005)(426003)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 06067dd3-8632-43c3-04db-08d819ce54b3
X-MS-TrafficTypeDiagnostic: MN2PR02MB5952:
X-Microsoft-Antispam-PRVS: <MN2PR02MB59521629FDC57A4B88C7B705AA930@MN2PR02MB5952.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxgCTOy4fAetHjL4ZKXtVa3u++tSYV/0bWS+vDQov8wIUAhe/v9TO4LgIPRfD+8hsO6tVJzDUwad3LEJkVKaE7d5M/nJC6oEBtsr8n++a96dRprwpK6ax1COyi9Mz/slF+QY1NIQh5efBxLeU5/3mOE2vVFtIAcfWp8+RfPeQGMG90gec3tF2CAYKi0DPs4JuzaQmEmBn5x2qkD2fG61g+m0bGnZgNxvoLKSEkQpfjbzuj/Mg0dZazPAuHlDD0TuFMPakSpILyVUBKPn71tCGxUurp+PolWq+ouWq3eO1uBZYTTNeXMSe08g1zwutPZD4qivT/chvOX+seKbuh0paCHTzPYfS2q3H0AfhERvvA7lmKqA0l78uWNnaXNQDdlLjjX4prbAMt/nSE16FXn/MQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 12:42:04.7800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06067dd3-8632-43c3-04db-08d819ce54b3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5952
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


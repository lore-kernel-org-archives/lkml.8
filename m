Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3022C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECC62064B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ps2w1NuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgIIUpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:45:13 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:18240
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbgIIUpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drmc2TKIEScpMMy6ZcX/PpIJBlTAE/kdHNBS+DCwjvC++6Gqcr9DCuhwzg1YkhiErkEgA954eNbZfli53S1OSXIaWToW1iDd7r6gWtXV5kGdkJD9oHDyyqG7hZU1Pry2Qu2q0WYFJNcEgrTDNdRHci3W1DR+jJkn5MxjYY6/VEANvYVxlEqSlkr1XTV/b/IWhtWZtQvWFaKhpBuOQOelxRsMFGv+cowHfYX63d1cQqvLUsBYkvtQ0WSFVMF6kuCtsP3WH/zOjQ5OU/P87Aux/QZxwup+RtJhQvp5lhCGrsEZBVUIZrfSR7B2t8zKzuhludgvD6FuQ3chC9nwufvhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/Dk7N+byDPchs8YFviZueMQRM37HPoXqKBbno3ylho=;
 b=CUo3s6V4aL5+3jN4PYhSY/YpMxbzOG8LPrz8X0Lnuj0u1H2RCBgTvIJQNH5ojzcGaLaCoOTRKs/XFWcgKg/v2GD570/vPukX8AN5TrU4veWXzeGfCSQo8GJOPR10Du0yP+SZSNU/xVb+FyLBZUxKuPIe+hlD99P0qf0ImzHZe9/4KSbVA53vBYBbpw4eueYptt4j3BScGzSeXqSqEGcEc1+nX/+NQgf0hk6o8jjQH7cDTc8geDa2uCB7CbXGlHvCAw9iJ8WQtZgXCrUyO0G7qZ3qjP/b76ttFRuNVc6Y6YfisiF7Jwvm3OSE7ZkE6aibSgMr3QcfLExBVF4rsymS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/Dk7N+byDPchs8YFviZueMQRM37HPoXqKBbno3ylho=;
 b=ps2w1NuK9d9SQwiLAEWvA80qiePjGySpd+PcXA+0bEL5ERKteMKInEpYlInTLiSYuQLdOxpxVYKUxOB3ZuxG3Ys342ozvoDxkbG3EoWz/l4GgdryRGiwRk8cFf5+IaX2KGL/5R5LzyhhwRfiVuAvBb/6gBY7BHisocK0Pqfweww=
Received: from CY4PR12CA0028.namprd12.prod.outlook.com (2603:10b6:903:129::14)
 by SN6PR02MB4782.namprd02.prod.outlook.com (2603:10b6:805:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 20:45:00 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:129:cafe::58) by CY4PR12CA0028.outlook.office365.com
 (2603:10b6:903:129::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 20:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 20:45:00
 +0000
Received: from [149.199.38.66] (port=53394 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xP-0001xa-PC; Wed, 09 Sep 2020 13:44:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xg-0007dx-0K; Wed, 09 Sep 2020 13:45:00 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089Kis3C028428;
        Wed, 9 Sep 2020 13:44:54 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xa-0007dJ-AZ; Wed, 09 Sep 2020 13:44:54 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v4 2/3] clk: zynqmp: Use firmware specific divider clock flags
Date:   Wed,  9 Sep 2020 13:44:47 -0700
Message-Id: <1599684288-20917-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599684288-20917-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1599684288-20917-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0aac3241-ddcf-4962-4747-08d855013865
X-MS-TrafficTypeDiagnostic: SN6PR02MB4782:
X-Microsoft-Antispam-PRVS: <SN6PR02MB478208534752928592ED79D6A7260@SN6PR02MB4782.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBcse43MaSUrEA+6mtSSDayxsA9nekKXdx9k84NTbqGq+ixLxxcs7N/cftGyhRkgOxxMnWue9P83cf4BBqV3TuV9lCRaXgvR6kdbrRfouUXIGUekcKjleo5N8WlfEGPB3yA6iRoc03IJiJu4SmhfyhDJfNLCBnlw+6avbPc9iI9or+J8iMqp7aQxLtWYWO9oz6MjMcSKUZV6qy31wx4+X/k6fkowpzqeUJCSNvFNpu7KnSgVwV+yAnpO2fNTSjXtrI1ucMkGKEbomFDImpQ2i662aqo/d+1eOaBNJob6kwiIsUlsQBgzrSp/8bS6QxRy2tOt6MN1hd+E2jpxjpyt1mkUOauOfSGwuM0YRb2irQa/IVfmyMfwp/c9lLHkeov+UoqtQerh6nZe9wBbG8+Z4Q==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(46966005)(316002)(2906002)(336012)(7696005)(26005)(8676002)(2616005)(426003)(9786002)(81166007)(82740400003)(5660300002)(478600001)(107886003)(47076004)(83380400001)(356005)(4326008)(8936002)(36756003)(82310400003)(186003)(70586007)(6666004)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:45:00.2324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac3241-ddcf-4962-4747-08d855013865
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use ZynqMP specific divider clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clk-zynqmp.h |  9 +++++++++
 drivers/clk/zynqmp/divider.c    | 25 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index 974d3da..9b2ff35e 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -32,6 +32,15 @@
 /* do not gate, ever */
 #define ZYNQMP_CLK_IS_CRITICAL         BIT(11)

+/* Type Flags for divider clock */
+#define ZYNQMP_CLK_DIVIDER_ONE_BASED           BIT(0)
+#define ZYNQMP_CLK_DIVIDER_POWER_OF_TWO                BIT(1)
+#define ZYNQMP_CLK_DIVIDER_ALLOW_ZERO          BIT(2)
+#define ZYNQMP_CLK_DIVIDER_HIWORD_MASK         BIT(3)
+#define ZYNQMP_CLK_DIVIDER_ROUND_CLOSEST       BIT(4)
+#define ZYNQMP_CLK_DIVIDER_READ_ONLY           BIT(5)
+#define ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO         BIT(6)
+
 enum topology_type {
        TYPE_INVALID,
        TYPE_MUX,
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 775d54f..14adba0 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -283,6 +283,29 @@ static u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 =
type)
        return ret_payload[1];
 }

+static inline unsigned long zynqmp_clk_map_divider_ccf_flags(
+                                              const u32 zynqmp_type_flag)
+{
+       unsigned long ccf_flag =3D 0;
+
+       if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ONE_BASED)
+               ccf_flag |=3D CLK_DIVIDER_ONE_BASED;
+       if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO)
+               ccf_flag |=3D CLK_DIVIDER_POWER_OF_TWO;
+       if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ALLOW_ZERO)
+               ccf_flag |=3D CLK_DIVIDER_ALLOW_ZERO;
+       if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO)
+               ccf_flag |=3D CLK_DIVIDER_HIWORD_MASK;
+       if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ROUND_CLOSEST)
+               ccf_flag |=3D CLK_DIVIDER_ROUND_CLOSEST;
+       if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_READ_ONLY)
+               ccf_flag |=3D CLK_DIVIDER_READ_ONLY;
+       if (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO)
+               ccf_flag |=3D CLK_DIVIDER_MAX_AT_ZERO;
+
+       return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_divider() - Register a divider clock
  * @name:              Name of this clock
@@ -320,7 +343,7 @@ struct clk_hw *zynqmp_clk_register_divider(const char *=
name,
        /* struct clk_divider assignments */
        div->is_frac =3D !!((nodes->flag & CLK_FRAC) |
                          (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC))=
;
-       div->flags =3D nodes->type_flag;
+       div->flags =3D zynqmp_clk_map_divider_ccf_flags(nodes->type_flag);
        div->hw.init =3D &init;
        div->clk_id =3D clk_id;
        div->div_type =3D nodes->type;
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

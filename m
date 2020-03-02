Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508702465D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="q+Ol0Al1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCBVbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:31:18 -0500
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:6065
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgCBVbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:31:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6zms39CqjHPu1KJb2bGZUpKeNuQkyy0D3y9twqj0QiRh5Fyd9u20kngU1sHeTpAwweaPDwvfjbUlk151OsfdM6kQoqzIgChk2O7dIWhW4wXMWrlvvvsueRf38Fgkb8vbErOJBY/BKpecJpcjFnTQEAwamqESbH8+s5ZUqRUf42XF4sUPUE2OAP7fjWSVTb3IfxSZ3r15SrTmDsp1UovGYos8HWC73Dn155wYiPKsnN/UvXVv4HDfSEVSdSGN7TfRJHr2LgHTONkknXsnjFF8jgExndLqDRKaappuPlKNKnstVWXUm1sZFtQvwQyooBhbhPCSAO9u00QF9wqypcGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zy8Vdei8otRnmwBOCPOxF2o3s0WjtIlq9N9z8mQZro=;
 b=PCwGsjMKWCCSF555n0B/5NKqUpF9LdpBZz6KufIP5MNp+KnKnikyIu+RhfnZE4wi54Pb5ppCGfuZsQVb9lji5jdm92dWyXz5XMyAG7vzp6ezAGmxCKk2GLompozet6yM/jO/S7eEn059Y+4YZSEdUwsvzdUSds9v0Tkejvxin3HDIhxT7XWCKqjUwuVTgYJFia7s3agOb3OJHbdJZehPx4XO3Jq/3ruVbjFMwfSjciLAaMaYbhp+liX2Wr6jTxyjDM+bW8BirlRU2BQpU83H7sO8ceGmOixusqJ+cWNtKTmtssgpZ+LaUF/HrelRr9XoG33W2UZRkIbPAuY2rx7XVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zy8Vdei8otRnmwBOCPOxF2o3s0WjtIlq9N9z8mQZro=;
 b=q+Ol0Al1I4d6ho6fk+DZz63WjTpzVjz6JUIhWSjPqrS6R4BeuKV25FdTz1tsVNO9mwVVPMUaLv3I3Nq5r38pmYC1PXNReLtDSfFwWuahb0keJawDQcX/xW/HMWI6OWH6n8SBZhcN0kLzM11FrVUmpmPS2meq0MOLzh1pZwiC7XY=
Received: from MN2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:208:120::25)
 by BYAPR02MB5416.namprd02.prod.outlook.com (2603:10b6:a03:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 21:31:10 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::bf) by MN2PR10CA0012.outlook.office365.com
 (2603:10b6:208:120::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 21:31:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 21:31:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8seb-0001vB-Ic; Mon, 02 Mar 2020 13:31:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8seW-0005hD-Fc; Mon, 02 Mar 2020 13:31:04 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022LUxKl030793;
        Mon, 2 Mar 2020 13:31:00 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8seR-0005dg-Rh; Mon, 02 Mar 2020 13:30:59 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@codeaurora.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 2/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
Date:   Mon,  2 Mar 2020 13:30:43 -0800
Message-Id: <1583184643-19191-3-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583184643-19191-1-git-send-email-jolly.shah@xilinx.com>
References: <1583184643-19191-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(70586007)(8936002)(336012)(54906003)(44832011)(107886003)(186003)(70206006)(26005)(4326008)(478600001)(15650500001)(9786002)(2616005)(5660300002)(81166006)(81156014)(7696005)(2906002)(36756003)(8676002)(6666004)(356004)(316002)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5416;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86f547d9-fd28-4f66-8f43-08d7bef106a0
X-MS-TrafficTypeDiagnostic: BYAPR02MB5416:
X-Microsoft-Antispam-PRVS: <BYAPR02MB54164C2C83E30019E037B8D6B8E70@BYAPR02MB5416.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERsXiYVeu/zSrkCyKKKd2C4PBoH+BrW7jxmDv3wyZ/MjZrTjlXxQ2Pjcp7G4A5KW9MwHnwHuQ9hBwgV00/Uu05P8lw+Up4GLtPMF9/2xFaWbjRHYW1ARc+LXoCGtokpJaac7UoSjGoFEIWlrybPvEvShf2XUYK1sK8/Udae0DmuQKB6PASgA3UrUs+y9tlqp3vGWbassacFtChYapZuTE4l0WsP2CVjIZmapWgATqwdO6pQpxUxjyideX8T2cWOVdeDvy9kNmzst4ZZrqIgI43pdU9ZeZDzi4d7mvaMGju1604+KgglIuvcOhJHXkGvdKFjsc1EI+PilBdLdH8zjMwOPo74soGIwfdBlFEtbZBSdHDyj369LV/ESihTVKrB7FLf7LRGX+Rz63TH7h3Bra/7p2SmNGYqilo3rGeRyCksgGJhDx3X1hRjbNJfhRLeX
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:31:10.1994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f547d9-fd28-4f66-8f43-08d7bef106a0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Older firmware version sets BIT(13) in clkflag to mark a
divider as fractional divider. Updated firmware version sets BIT(4)
in custom type flags to mark a divider as fractional divider since
BIT(13) is defined as CLK_DUTY_CYCLE_PARENT in the common clk
framework flags.

To support both old and new firmware version, consider BIT(13) from
clkflag and BIT(4) from type_flag to check if divider is fractional
or not.

To maintain compatibility BIT(13) of clkflag in firmware will not be
used in future for any purpose and will be marked as unused.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 4be2cc7..973cdf0 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -25,7 +25,8 @@
 #define to_zynqmp_clk_divider(_hw)		\
 	container_of(_hw, struct zynqmp_clk_divider, hw)
 
-#define CLK_FRAC	BIT(13) /* has a fractional parent */
+#define CLK_FRAC		BIT(13) /* has a fractional parent */
+#define CUSTOM_FLAG_CLK_FRAC	BIT(4) /* has a fractional parent in custom type flag */
 
 /**
  * struct zynqmp_clk_divider - adjustable divider clock
@@ -311,7 +312,8 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 	init.num_parents = 1;
 
 	/* struct clk_divider assignments */
-	div->is_frac = !!(nodes->flag & CLK_FRAC);
+	div->is_frac = !!((nodes->flag & CLK_FRAC) |
+			  (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC));
 	div->flags = nodes->type_flag;
 	div->hw.init = &init;
 	div->clk_id = clk_id;
-- 
2.7.4


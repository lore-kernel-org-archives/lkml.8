Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614BBC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2D5206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FuA8ksUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgDITNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:13:51 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:55136
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbgDITMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOGK9f5vsz1ekKrZzKknsI0D9KS8IyWPwiMsA1+hcesVXkl9OfZ8sQmWjtTKD99a96mkwvsrLv+OzIhT6Cys2MwUOaIoHkcBx1Wy1gLV6xG+8ngQIiuIJqlL8PRWEo36BuxfZonjetQ7OekvWNHOHgL4XE0GLWuCUb5k6A2Uvz8ic2ah6xbQA2930V2QfigMJOOoF4b5M488eNICR9laa4M+nBoCSvK/jEVj/PoqTLlRcr7rqxJbDFaRgyiJ7FxDKtQbKzVXBYc/crF56UJhjAKqJtLLJfEalOhd5cbCsWreMAFGVbfeQ5DfUkyf0v0vopVP91b3ZMwdNIUR2kiJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfjioUTWZWsuP7/bJ/unKMGABsK+FjvCGc2MPcGh+uo=;
 b=Q1jjkRX4NLDQX1kAE9hxuSKJ+vTy4JJV/CSAH97BgF79iaXH2mzSB8oriz5VosoSio2l1t3Jf1rGqrquMljnk1RUhbQp7WSYz9kVXalYE7LxV70zfOAbSnm19xlIeh5zW3ZqINjRT4s+zYAVXBaJypDaSoTIcRcNvvBF3FE6NasCfZDqLGFrmjexE76AYlFWd8L0RygzpDQMG8A2IHYtUTa79mQ3oGKNwV9Zi9lyLD6moQjOgAjs6Coo9kgx2gd6rDuWZ5H4Q4+3NTOVN2GUH8nl/czrvocMuohTYtil80gro7SKawIK2Qg6+Ok4U7oIJXc1daE+OFwmxvCXh79wPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfjioUTWZWsuP7/bJ/unKMGABsK+FjvCGc2MPcGh+uo=;
 b=FuA8ksUTvasoRvVNhbyNKIEg3beV4H44KqLf7gZMjZ1UKYS6TXEe7EkBkxLVbf2GwMuYmw1SwTC/owNMUvaNNcnbWQtp2EUosHhuDD9jqfhvWAVq8kWM/Nb4jAWZJZJ9xVFETnLICnWu6yGqWZAT6+hULYK0teu8/IpxwKVmE/M=
Received: from MN2PR04CA0034.namprd04.prod.outlook.com (2603:10b6:208:d4::47)
 by DM5PR02MB3749.namprd02.prod.outlook.com (2603:10b6:4:b4::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 19:12:52 +0000
Received: from BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:d4:cafe::bf) by MN2PR04CA0034.outlook.office365.com
 (2603:10b6:208:d4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT024.mail.protection.outlook.com (10.152.77.62) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:50
 +0000
Received: from [149.199.38.66] (port=44324 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcb9-00060T-Ix; Thu, 09 Apr 2020 12:12:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcba-0007NV-1T; Thu, 09 Apr 2020 12:12:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbS-0007La-5s; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 08/25] firmware: xilinx: Remove eemi ops for clock_getdivider
Date:   Thu,  9 Apr 2020 12:11:57 -0700
Message-Id: <1586459534-8997-9-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(46966005)(6666004)(8676002)(9786002)(7696005)(4326008)(426003)(498600001)(356004)(7416002)(47076004)(8936002)(186003)(54906003)(2616005)(336012)(107886003)(26005)(5660300002)(6636002)(81156014)(70206006)(36756003)(44832011)(70586007)(81166007)(2906002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8db4278a-e394-41c4-3314-08d7dcb9ff2a
X-MS-TrafficTypeDiagnostic: DM5PR02MB3749:
X-Microsoft-Antispam-PRVS: <DM5PR02MB374949234026FEAEFFDD5A8DB8C10@DM5PR02MB3749.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HYpUG6KI+jNr4D07eUMzVUO/m3qt/hJZSPZVlGa2jy1Sqm8PG2Kbi7pu4FCzGdJbYy2pj0f/aAogKLTtZvH157Yr8ASO4+5jgL6j5YphKLI6mfSRI57zjCt8lZMj2jV0bNE5ZgZy7EmjVdOtW0uJot7MKrZgm4RHDd06PptaH3I+DmJaTsJnogUseHXBqWyFA+65Neklcud/WQFj7fP3JrjLs2MFDEMe3JpudqnU4zU3xXHI32zr8zSWG5WO8MEa6h47ZY0Q7zmWnoE4d4Im3ki5f556PQxttSHG4CkVp2DNYSnsMg0RtDkWeqtUU/p4u+cINwxCqiZPZ5fC2zpWgHRszCLG/OfORN2LDouRahMR1PvLsV5z2t4OBiv1ky4VmYDuZYe+mmlPYeCBqF2+q4HWDlojWCvlroGpOfNpLQ+HqBPCC2jbmqN+hALyIi99ZGntGfcICZrGB5jJR/8ATZLcDPewiZGmc5sOVNWBbazNLbgIL0dDTwz7n6f59eMfvz7FszyRtwkKc5cINM37A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:50.4060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db4278a-e394-41c4-3314-08d7dcb9ff2a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of using eemi ops for
clock_getdivider.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/divider.c         | 6 ++----
 drivers/clk/zynqmp/pll.c             | 2 +-
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 include/linux/firmware/xlnx-zynqmp.h | 6 +++++-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 13041cd..8eed715 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -83,9 +83,8 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 	u32 div_type = divider->div_type;
 	u32 div, value;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_getdivider(clk_id, &div);
+	ret = zynqmp_pm_clock_getdivider(clk_id, &div);
 
 	if (ret)
 		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
@@ -163,11 +162,10 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 	u32 div_type = divider->div_type;
 	u32 bestdiv;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
-		ret = eemi_ops->clock_getdivider(clk_id, &bestdiv);
+		ret = zynqmp_pm_clock_getdivider(clk_id, &bestdiv);
 
 		if (ret)
 			pr_warn_once("%s() get divider failed for %s, ret = %d\n",
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 95fad06..73fb5bb 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -141,7 +141,7 @@ static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
 	int ret;
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_getdivider(clk_id, &fbdiv);
+	ret = zynqmp_pm_clock_getdivider(clk_id, &fbdiv);
 	if (ret)
 		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index ef2412d..5782b5c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -422,7 +422,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setdivider);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
@@ -433,6 +433,7 @@ static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getdivider);
 
 /**
  * zynqmp_pm_clock_setrate() - Set the clock rate for given id
@@ -741,7 +742,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.clock_getdivider = zynqmp_pm_clock_getdivider,
 	.clock_setrate = zynqmp_pm_clock_setrate,
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 023f1f9..3bda22f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*clock_getdivider)(u32 clock_id, u32 *divider);
 	int (*clock_setrate)(u32 clock_id, u64 rate);
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
@@ -331,6 +330,7 @@ int zynqmp_pm_clock_enable(u32 clock_id);
 int zynqmp_pm_clock_disable(u32 clock_id);
 int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state);
 int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider);
+int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -365,6 +365,10 @@ static inline int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4


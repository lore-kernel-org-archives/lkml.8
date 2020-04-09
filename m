Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE526C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0036215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qMcC4lU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDITND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:13:03 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:6093
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbgDITMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFsiEUn45GQ2skd7DxBlHDcHKcMAbPs5VXa/gk0FnsTg06EzWG5zrXoxUErWo0dB7QHbLvOEMITq3wf/v/N0zkNIve9NJexYvoIPlWk6T59hf3oGEbNkMkPLeyH/3PB5s0Q1+a5u1S11PnQZd5M2p1Rwss7LzYmk8KsuXB2iV7YjHSqr2FXjvu4rCTu9TTVJHY5foM6RQ85EOHFABkOWWLXe96M+V2fuq1AFZ9u9xjSStmr/McTueWtcRSAJH/LzB9USKXYqMu5Nsb2TohHsNuKIq4FfWPrJCucrP+mJqQ98eJC0pg05zAvpEVXHwNIm4hAn5jFvu8mRE4GlGftZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAl5DV4g6pOCd56rFXeJcxsQII7ho7EKejt8SioNjd4=;
 b=OLFkiSedjmOslNjB8wr2Ws0X26RUwmFRlYoI2yhxV5aIoaLcy88z2P6m+COy4651clv4O7CwSket1CsAiojWDi5kmZ+DapDXA9yXC9peeCX7xE4sQhhbM4+08R+APM0c1l92rhdkySH8/GfoaYKAZML3pK6C23StVt5tbWg3XPPgkYHAdyTyHX2ZowtKFLB/YmZ51rZjjg3A+v7gWQHmhfp73D9XyfBJs7qOvDBdFBnDut+k78FwMjxHKEMI6kH0Iyid2e28nnrODY271VygztjzGXYG2e48T71vwYihWVbkNP1TW0c0co6708qmAFByVl5YVWTGyCYrUMQaGqbAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAl5DV4g6pOCd56rFXeJcxsQII7ho7EKejt8SioNjd4=;
 b=qMcC4lU2+FkdNProwcyiuoY/Aoih8+KavpEdBdoYwMma62AArRFK3/VVyxcab6TXN/mRu+NX+Tk3J1lm5XHK4GZpLt1ijf+cNJJodZXKtysEPZrRw5A3jFXjC1kMBkimw39GTltJ+j/PQP4geCw9gl4htw85zItZ08tJvV8614g=
Received: from BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19)
 by DM6PR02MB4842.namprd02.prod.outlook.com (2603:10b6:5:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Thu, 9 Apr
 2020 19:12:51 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3d:cafe::b5) by BL0PR02CA0042.outlook.office365.com
 (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:50
 +0000
Received: from [149.199.38.66] (port=44333 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcb9-00060c-NS; Thu, 09 Apr 2020 12:12:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcba-0007NV-5v; Thu, 09 Apr 2020 12:12:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbR-0007La-Vz; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 05/25] firmware: xilinx: Remove eemi ops for clock_disable
Date:   Thu,  9 Apr 2020 12:11:54 -0700
Message-Id: <1586459534-8997-6-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(4326008)(478600001)(356004)(6666004)(82740400003)(47076004)(107886003)(2906002)(70586007)(70206006)(36756003)(9786002)(316002)(7696005)(54906003)(2616005)(7416002)(81156014)(336012)(426003)(8676002)(8936002)(26005)(186003)(44832011)(81166007)(6636002)(5660300002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c0659ac-7390-477e-ac62-08d7dcb9ff40
X-MS-TrafficTypeDiagnostic: DM6PR02MB4842:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4842FABF9CF9C6846BDAC339B8C10@DM6PR02MB4842.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0N05/3KMm1YBh7uFxILFyMCL+E4DGwi15ZX0xHbrvkEMZLOOK5n8CPnEhOqD2y/+X3XO5Q5JhLTJTmsd1CRGEr7bEeMy+4gA9EG0uw3gQeq4EhLs36YviKItkh3B+n8oHSmn4Ta+UjdlzUeaS5juCPungWHcrVtZYXmpMx9syP4hudTEe3D6KaN+cM8XMo7tvT2JI1GyHdHnomqoaL1Ygf5qZ5mIgZ2IJcB0XucBdqibTkVjPZmh/NLXsQGj0AevzSGPWD+C3nclGJ9OFYgjlHd6OBzs8lplRoCZQ8rkBRsv8intx/CFO00ojOUqohGJp8ZT+TeoxX/kRUReAiTAvW+uJOCrBXgajy3d1eWK5HJLV/IeVlcj09ESVn64Cii+cZCbkL8Ce9HYSVYNAg0QpFHSB1fV/g89C+om+C0bNmA032nfGFUp10bzPTCiNj11skrtOO71yk7MOwBlxLS0YHyAFdyhVO734GcYSdYnxZpfw7Ujs8cnxi2IDvFabvqLaZt21qSnllx48v7CVJAGA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:50.5543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0659ac-7390-477e-ac62-08d7dcb9ff40
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call for clock_disable instead using of eemi ops.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clk-gate-zynqmp.c | 4 +---
 drivers/clk/zynqmp/pll.c             | 3 +--
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 include/linux/firmware/xlnx-zynqmp.h | 6 +++++-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
index 437b921..11f1b97 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -37,7 +37,6 @@ static int zynqmp_clk_gate_enable(struct clk_hw *hw)
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 clk_id = gate->clk_id;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
 	ret = zynqmp_pm_clock_enable(clk_id);
 
@@ -58,9 +57,8 @@ static void zynqmp_clk_gate_disable(struct clk_hw *hw)
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 clk_id = gate->clk_id;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_disable(clk_id);
+	ret = zynqmp_pm_clock_disable(clk_id);
 
 	if (ret)
 		pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 153aa67..38b8dbc 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -268,12 +268,11 @@ static void zynqmp_pll_disable(struct clk_hw *hw)
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 clk_id = clk->clk_id;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
 	if (!zynqmp_pll_is_enabled(hw))
 		return;
 
-	ret = eemi_ops->clock_disable(clk_id);
+	ret = zynqmp_pm_clock_disable(clk_id);
 	if (ret)
 		pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index da13627..d884805 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -366,10 +366,11 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_clock_disable(u32 clock_id)
+int zynqmp_pm_clock_disable(u32 clock_id)
 {
 	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_clock_disable);
 
 /**
  * zynqmp_pm_clock_getstate() - Get the clock state for given id
@@ -738,7 +739,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.clock_disable = zynqmp_pm_clock_disable,
 	.clock_getstate = zynqmp_pm_clock_getstate,
 	.clock_setdivider = zynqmp_pm_clock_setdivider,
 	.clock_getdivider = zynqmp_pm_clock_getdivider,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 77365d1..f9a84d9 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*clock_disable)(u32 clock_id);
 	int (*clock_getstate)(u32 clock_id, u32 *state);
 	int (*clock_setdivider)(u32 clock_id, u32 divider);
 	int (*clock_getdivider)(u32 clock_id, u32 *divider);
@@ -331,6 +330,7 @@ int zynqmp_pm_get_api_version(u32 *version);
 int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
 int zynqmp_pm_clock_enable(u32 clock_id);
+int zynqmp_pm_clock_disable(u32 clock_id);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -353,6 +353,10 @@ static inline int zynqmp_pm_clock_enable(u32 clock_id)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4


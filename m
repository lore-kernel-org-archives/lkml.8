Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF41C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B51208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LUXCrnOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgDITNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:13:07 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:24545
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726791AbgDITM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bez90T6EfcdTJ7Fh1NKfQkaCEg2D/Rawa+4hTpI4nztnlBrM/F/K5GnN0xoPgLAkN8zCYe4KydoZX+DWcgekwiKbR4Z5MGHxuB1Y/s/2RMICOSuh/jzGN0fHOMk23tV2gNWaz1f9LZsQbUY9K28j1z1cg9QZVmJR0R+s6JJSaNFTQ8sOqaWMRIXWbQp/w8WIXqXrjhLlYnNkEfi6WQLT8ODjJP4xbPJRiAezqxA8RwkClqZmYZ4QL+eW034wQB2ew9k+zamN1/8fklAm/j/KY+Bo74fpecYcA/BZEwip6fJ6xe8rgcWazUNOMsUNj+Fzyv7peE4g5MxCFEsf8DeRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTMAvD5IyJaFssNJx7zMyBTmn1sGBgNjbcebgA75PlE=;
 b=kfZddZ1thF9yCdiEMsJF1Vfn3qOhxsAfLjc3F/tU2unkWhln11ewfqRwJQakv8b3OBN2f1D1QUat6u+6Wg6vkl7mV/7Al0SucJnqh7KF7LvFixrdQ18WsfQzrVtHAjdVJdGXxuF4vy+Z8zkISvAQZC2UH9EyMeCCQCTDZbjcwEM/xUPk2wsNZEaF/GN9/UHo10VlOJ0rGiPMF8d/ADhXmbRJqWJiK3r00waE3G2P5eS4ezbhvJ7rsc3CfSJeyQ8z+eUGhLo6RvAyiJQDti9dREUacHMWRrDo39vdc8PUohLoWbF2Zy8IeHEIWwcFAYBpQhghviXwzJj5Z0pmyW0ZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTMAvD5IyJaFssNJx7zMyBTmn1sGBgNjbcebgA75PlE=;
 b=LUXCrnOcRH7n6c/VPsdYAF3MxjUpfxOV9ngJ7/DN/gnMvReCMKAUdDIRX0D5acLXo4Kpa+KJafxnd0mDRQhKdGmBNYlGFpaUNVIAf4f/FH9F4Rid++QgvmFiFBwbA1g6AOXyjK1XzX8U+viezG7aPFW7Xs5M8qJwyK5BA4DYkbU=
Received: from MN2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:c0::21)
 by DM6PR02MB4057.namprd02.prod.outlook.com (2603:10b6:5:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 19:12:52 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:c0:cafe::a5) by MN2PR05CA0008.outlook.office365.com
 (2603:10b6:208:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server id 15.20.2900.18 via Frontend Transport; Thu, 9 Apr 2020 19:12:51
 +0000
Received: from [149.199.38.66] (port=44415 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbA-00060z-Ll; Thu, 09 Apr 2020 12:12:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbb-0007NV-3v; Thu, 09 Apr 2020 12:12:51 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbS-0007La-EF; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 12/25] firmware: xilinx: Remove eemi ops for reset_assert
Date:   Thu,  9 Apr 2020 12:12:01 -0700
Message-Id: <1586459534-8997-13-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(478600001)(6636002)(2906002)(54906003)(7416002)(82740400003)(7696005)(316002)(8676002)(81156014)(5660300002)(9786002)(47076004)(8936002)(70206006)(336012)(426003)(6666004)(186003)(356004)(2616005)(44832011)(26005)(4326008)(81166007)(36756003)(107886003)(70586007);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9af6053-bca4-46ad-ee18-08d7dcb9ffd7
X-MS-TrafficTypeDiagnostic: DM6PR02MB4057:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4057AAF5FC3BB794F647E697B8C10@DM6PR02MB4057.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHP1iBqTzd45K1dox3coIbHTmiR/cFLW9SMXnzCDQuqVihhXSosN0NMUXgASQXIxM8jmTk+VF+a7NlEpMjRsdqvQZmZM1wrEC8SdfPPYT+zK8C8dw9Xnv/C6i589SV2K4LXFCsGEWZJVKF2ysBWjXjgOblm9nGQpyrqPj1fA2GohhYUzrGYUzrwO3K1Aoe4+KdMJBv33rkTIKzhA9E4YMNaUeA8DA3ebJy3PCJ92yujWIvxTA+FqjcefnZ4y/AR05nZFlqE8YnQ39hROLltYrMnEfg9IXuKaLKoxBBCkUQkFvwCDhfdsTNv4a+oVqduimT8PTnxjbKT7FunUdeIbZt+YLv5nI9/gLaY4X/6CbIRmwIog0036gofqyE2GVhrpLQ7FgiqQv+RJa2N4k9lsEspHPfWMiDElyf8jthwEp4r5RCiIcxUTRInaKblgpntm+8w9wePLZDfECZOJL4GXVGRWdnyJY0pAPdQbk5uZCANKn/3zjUvK3tXkogobnc3qsw8ifh6yUhKWhi6fLeOO8w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:51.5466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9af6053-bca4-46ad-ee18-08d7dcb9ffd7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of using eemi ops for
reset_assert.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     |  6 +++---
 drivers/reset/reset-zynqmp.c         | 18 ++++++------------
 include/linux/firmware/xlnx-zynqmp.h |  9 +++++++--
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 94fd755..2a79091 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -627,12 +627,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
-				  const enum zynqmp_pm_reset_action assert_flag)
+int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+			   const enum zynqmp_pm_reset_action assert_flag)
 {
 	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
 				   0, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
 
 /**
  * zynqmp_pm_reset_get_status - Get status of the reset
@@ -807,7 +808,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.reset_assert = zynqmp_pm_reset_assert,
 	.reset_get_status = zynqmp_pm_reset_get_status,
 	.init_finalize = zynqmp_pm_init_finalize,
 	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 0144075..4a01b7e 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -27,19 +27,15 @@ to_zynqmp_reset_data(struct reset_controller_dev *rcdev)
 static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
-
-	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
-					    PM_RESET_ACTION_ASSERT);
+	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+				      PM_RESET_ACTION_ASSERT);
 }
 
 static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
-	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
-
-	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
-					    PM_RESET_ACTION_RELEASE);
+	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+				      PM_RESET_ACTION_RELEASE);
 }
 
 static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
@@ -58,10 +54,8 @@ static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
 static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
-	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
-
-	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
-					    PM_RESET_ACTION_PULSE);
+	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
+				      PM_RESET_ACTION_PULSE);
 }
 
 static const struct reset_control_ops zynqmp_reset_ops = {
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5aff896..22b2bbe 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,8 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*reset_assert)(const enum zynqmp_pm_reset reset,
-			    const enum zynqmp_pm_reset_action assert_flag);
 	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
 	int (*init_finalize)(void);
 	int (*set_suspend_mode)(u32 mode);
@@ -336,6 +334,8 @@ int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data);
 int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data);
 int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
+int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+			   const enum zynqmp_pm_reset_action assert_flag);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -414,6 +414,11 @@ static inline int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+			   const enum zynqmp_pm_reset_action assert_flag)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4


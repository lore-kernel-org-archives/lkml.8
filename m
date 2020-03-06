Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B6C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077EB206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ouu9j535"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCFXtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:49:16 -0500
Received: from mail-eopbgr690045.outbound.protection.outlook.com ([40.107.69.45]:12352
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727234AbgCFXsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dhar/Od/OhsNjhDrP69NYvhOqOCYK5GBRhi5KPkdDNuiBBKBnTI8s4MfcOd9vish0x147RDfcV98sQZRUiDrAH+SWI2/lv+DB2j7E0TjorI8I97SsC++KtWP7ZkHxxI6EyU2S9yVREu8ggiz08ZFF89ZJ2dqknsUxHbf75EY9+YaGEP4KuQz3OjTOuiOTymmlLXZAF+0jMWTCnHqM44AFllo6ofZNmGSPFJpYYFve/Nd3kI+OXJJ9jCe4BbX9T56cCxO6Vs0HWE+kX3MoIaHgtklcErbwZ05ffFzEgOmeICXwgZeBppmQJJ6/ZFvggbEGDE6QBi2QKTPIqpm3vL6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exhMmoAsa48T+xXW5O7w5Dsgjt6wxhjxqlW3XKRBfUA=;
 b=iSR2LDGJvTvXxV1jPQeBPb3TfZ8/L6gndKOJa7COCEbw7xNCNdIxmxgkyEWuYTmra0Y4FvBdvTR75q1y3jmC/JH8d4UVgeDWm58gj5Pbs21xhJIbfSdGr+2f/j3tDhnjlTts3RZzE1jvG47Hz6HAb/l7V/HKmmeHphd31CnnT5JBySQfHumnYFtksEozct2dcBonz0v1C/MHVVcMDwTZcPGAE5R/zRLrzxF7yqxQwTpHnUcwqAvYqm8BGpICLWqmokC+bDtul5QremPUkfUH5AFn4HAlhOMLGkaKzksJkUu7+B8kXQJHwQcC8EXKcGpNDq3CE2LHu2dKy30tzpaQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exhMmoAsa48T+xXW5O7w5Dsgjt6wxhjxqlW3XKRBfUA=;
 b=Ouu9j535IVE7b2glQ31bje+pMdT2Fo1nJoKVWwLhXlTSl/MTO5voTx8os6x+etNdOyrogWTDeBGET8/JPqwpPCyKPhxfqx0yhq4QjpDubPXiuarBGi4/TmsGnrJwUZwyP1qIZ+SXW7InVZOhtJYyQ0IP2X1b268l7Gm5vhsq/oo=
Received: from SN2PR01CA0026.prod.exchangelabs.com (2603:10b6:804:2::36) by
 BYAPR02MB4005.namprd02.prod.outlook.com (2603:10b6:a02:f8::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Fri, 6 Mar 2020 23:47:59 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::8a) by SN2PR01CA0026.outlook.office365.com
 (2603:10b6:804:2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Fri, 6 Mar 2020 23:47:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:47:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMhC-0003QC-2J; Fri, 06 Mar 2020 15:47:58 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh6-0002g8-VR; Fri, 06 Mar 2020 15:47:53 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026Nlj5u001003;
        Fri, 6 Mar 2020 15:47:46 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMgz-0002eg-SJ; Fri, 06 Mar 2020 15:47:45 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v3 04/24] firmware: xilinx: Remove eemi ops for clock_enable
Date:   Fri,  6 Mar 2020 15:47:12 -0800
Message-Id: <1583538452-1992-5-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(9786002)(81166006)(81156014)(8676002)(7416002)(36756003)(8936002)(478600001)(70206006)(6666004)(70586007)(356004)(5660300002)(7696005)(54906003)(316002)(2906002)(186003)(426003)(26005)(4326008)(336012)(107886003)(2616005)(44832011)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4005;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07a3be69-0a20-4773-dc04-08d7c228ccd4
X-MS-TrafficTypeDiagnostic: BYAPR02MB4005:
X-Microsoft-Antispam-PRVS: <BYAPR02MB40059A5096D1FA4874FC8E79B8E30@BYAPR02MB4005.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njOHN2o8uWmkE/AMrrv72COnkZrLeVWDF4yeRc8NtCmlNjGXykxGuO2BZbPjToU2GycLFT199Dk5RGMYRKvSEYz3jCIVoJA7a1qIVkWgtfG4HxHgDPJ4oWMkwVJUDlHLdvT4OBGDc96irNTU5H75mPUrZNKvZ4BpqvJWvK9ognNx1Vo1Br+niIC4Ls5FDCKyyrUvvfiBBsRpASd1HLQ01cOyqrO7z4+MWOkZqmGcSJR9COzovnWVXVPskf2PWcjLelDh0bIX4ROZ31w2EdgGgIDY9FLCYqK3D4PTkUNIMr5GfkM0TBerckyTJIlvOWf7Ag06DelGzztqRWZbxiXigXJKp0DSgdp42JfjOPXir5oOLKVX/2eiDIV5PDevkTDcFH/ZVCuOXolVngLRAexQvtV1cl+01+0S1hyJEqYyaYDw3zC5IwZEK+9RZIckAUnt
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:47:58.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a3be69-0a20-4773-dc04-08d7c228ccd4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call for clock_enable instead of eemi ops.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clk-gate-zynqmp.c | 2 +-
 drivers/clk/zynqmp/pll.c             | 3 +--
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 include/linux/firmware/xlnx-zynqmp.h | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
index 83b236f..437b921 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -39,7 +39,7 @@ static int zynqmp_clk_gate_enable(struct clk_hw *hw)
 	int ret;
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_enable(clk_id);
+	ret = zynqmp_pm_clock_enable(clk_id);
 
 	if (ret)
 		pr_warn_once("%s() clock enabled failed for %s, ret = %d\n",
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 89b5995..153aa67 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -246,12 +246,11 @@ static int zynqmp_pll_enable(struct clk_hw *hw)
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 clk_id = clk->clk_id;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
 	if (zynqmp_pll_is_enabled(hw))
 		return 0;
 
-	ret = eemi_ops->clock_enable(clk_id);
+	ret = zynqmp_pm_clock_enable(clk_id);
 	if (ret)
 		pr_warn_once("%s() clock enable failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index e25a540..dd98214 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -351,10 +351,11 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_query_data);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_clock_enable(u32 clock_id)
+int zynqmp_pm_clock_enable(u32 clock_id)
 {
 	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
 
 /**
  * zynqmp_pm_clock_disable() - Disable the clock for given id
@@ -711,7 +712,6 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.clock_enable = zynqmp_pm_clock_enable,
 	.clock_disable = zynqmp_pm_clock_disable,
 	.clock_getstate = zynqmp_pm_clock_getstate,
 	.clock_setdivider = zynqmp_pm_clock_setdivider,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 283d039..7dc72d3 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -288,7 +288,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
 	int (*clock_getstate)(u32 clock_id, u32 *state);
 	int (*clock_setdivider)(u32 clock_id, u32 divider);
@@ -317,6 +316,7 @@ struct zynqmp_eemi_ops {
 int zynqmp_pm_get_api_version(u32 *version);
 int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
+int zynqmp_pm_clock_enable(u32 clock_id);
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-- 
2.7.4


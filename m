Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915FBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623E5206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Qu7hczg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCFXsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:48:09 -0500
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:6156
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727212AbgCFXsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:48:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aju/sRCkwwDrw5Qycc2z0RarbqSq73rZb4hLa++u2Y6d3Pz0UlSN5KSxG1Anlj08S5nr9VRAa/6wZfeBLjxWSappRaAU1PZVKYfzLPO77yF9Q98mQBQzIGuQHA2fT/2zGioCh0hA8REfOdtR+ITvQg95Xx9SlsRnaBkU5JrJH/Wycm5W5m1eefQ63L9uvt9lT0LEBU4+pIvVGMGn2leK9jm4XjCjZerqb/MXsizR9/8lZ1nWI7Y3CdI+DWyLKjIu94W5MRndVcoo55mxcE2pK86X3jgmhKlZrkz25Cfklj5evWUJH2HDXU/v+Ik3nI/pIodrcRvIwkacCS1NUrYNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv62Pb4CbY+oJb+aq6hHBludD/jLPpakm8DwS4dhFH0=;
 b=Tj/E9Im9GHaNmDselUS0BajldurM+7NsydUtnpukLFIl/yHLMAVkntQ4nm/LCbhgpd3e8fiIhqj3FtoqrOP4E/TUIWHYJDFkR6HT35asVjkAsIBJBA+6jte4/Y5xT3yuwMRNHKfuYgCp2K+GZUyTs18v1da+RimLUT++W+ckypwO/hw9yx3Yo7rzQO9/BYcESkzdkGYI3UNGLiKbD78pv4laur37RTC6sB72CCiL78POtRADygS31+b/D2VWQM30D8gFEzxosLSBpUyw7RJrEAG8B1gOpgvVT2fO5RDY2YsFcJYjjK0Jk4YBYbbRtFRuYFvixPOhMWbkGuE8crj/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv62Pb4CbY+oJb+aq6hHBludD/jLPpakm8DwS4dhFH0=;
 b=Qu7hczg9bEbWs302VQEITgsi1Vjqtn18MSFyJyozTcQ4O6zGYthpsIxeLucrKqg5WzJnaq5tI/FH0p1aM2awIWgOUdmHden9om6j1zbTqPqvkwMQgCJCnAQCPiwzT1CHAw7OawitAjGeqaT/RGEX71FiAUGTQzldeR/OSW95aek=
Received: from SN4PR0201CA0010.namprd02.prod.outlook.com
 (2603:10b6:803:2b::20) by DM5PR0201MB3621.namprd02.prod.outlook.com
 (2603:10b6:4:77::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Fri, 6 Mar
 2020 23:47:57 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::c1) by SN4PR0201CA0010.outlook.office365.com
 (2603:10b6:803:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Fri, 6 Mar 2020 23:47:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:47:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMhA-0003Q0-Ti; Fri, 06 Mar 2020 15:47:56 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh5-0002g8-QO; Fri, 06 Mar 2020 15:47:51 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026NlkwK002396;
        Fri, 6 Mar 2020 15:47:46 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh0-0002eg-07; Fri, 06 Mar 2020 15:47:46 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v3 06/24] firmware: xilinx: Remove eemi ops for clock_getstate
Date:   Fri,  6 Mar 2020 15:47:14 -0800
Message-Id: <1583538452-1992-7-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(186003)(81166006)(81156014)(336012)(2906002)(2616005)(26005)(5660300002)(7696005)(8936002)(426003)(6636002)(9786002)(316002)(70586007)(54906003)(70206006)(7416002)(356004)(4326008)(107886003)(6666004)(36756003)(44832011)(478600001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3621;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32cba7d5-6404-4bb0-9669-08d7c228cc17
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3621:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB36213138958983BA480C2BC5B8E30@DM5PR0201MB3621.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4tdsGB8hEgvvhs6UMc1WRCB0PV+wYa0SsyzCp0HxwxCHf6cJlSu1SkvAdJm36yTjL/Kdebe1VFb4Uea1LwdN+H/Z+ZspQQb1K9dc4xBiVi7+QUn62wiOle6DiqRsw17FRPCTWSkaeqf1sE7dY+zp40UfEaErv/VD9TZCYnZ6l4rXi1qF4sJ8wjIUW+hFU7Cd7Lxzx8eB00wOjyFcTw9G3HrZxL+EbdadSFQmRh7IBeI6SNiRckMIyYOdeIE48pc+nfmy9RFGfSJt9BkiWNgkHK4DR7rJhr0h8QMW/GbZapimQKeEIwzUafhg/AHLjCvJeuNTabPV9+tMwmX2yte2HRCw6A/+blVuacf4FyjllYRwL0szq1pnFNMo5i2rqP8RfS65wuSsOlVkdA9Beu5rz/G9jNg8WqMeW47JDoPv3SgW9wlrVa3+05zeG0aRy8O
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:47:57.3321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cba7d5-6404-4bb0-9669-08d7c228cc17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of eemi ops for clock_getstate.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clk-gate-zynqmp.c | 3 +--
 drivers/clk/zynqmp/pll.c             | 3 +--
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 include/linux/firmware/xlnx-zynqmp.h | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
index 11f1b97..10c9b88 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -77,9 +77,8 @@ static int zynqmp_clk_gate_is_enabled(struct clk_hw *hw)
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 clk_id = gate->clk_id;
 	int state, ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_getstate(clk_id, &state);
+	ret = zynqmp_pm_clock_getstate(clk_id, &state);
 	if (ret) {
 		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 38b8dbc..41f376a 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -222,9 +222,8 @@ static int zynqmp_pll_is_enabled(struct clk_hw *hw)
 	u32 clk_id = clk->clk_id;
 	unsigned int state;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_getstate(clk_id, &state);
+	ret = zynqmp_pm_clock_getstate(clk_id, &state);
 	if (ret) {
 		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 00cdaaf..8a0d5af 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -382,7 +382,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_disable);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
@@ -393,6 +393,7 @@ static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getstate);
 
 /**
  * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
@@ -713,7 +714,6 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.clock_getstate = zynqmp_pm_clock_getstate,
 	.clock_setdivider = zynqmp_pm_clock_setdivider,
 	.clock_getdivider = zynqmp_pm_clock_getdivider,
 	.clock_setrate = zynqmp_pm_clock_setrate,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index d2f5677..44c6702 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -288,7 +288,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*clock_getstate)(u32 clock_id, u32 *state);
 	int (*clock_setdivider)(u32 clock_id, u32 divider);
 	int (*clock_getdivider)(u32 clock_id, u32 *divider);
 	int (*clock_setrate)(u32 clock_id, u64 rate);
@@ -317,6 +316,7 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
 int zynqmp_pm_clock_enable(u32 clock_id);
 int zynqmp_pm_clock_disable(u32 clock_id);
+int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state);
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-- 
2.7.4


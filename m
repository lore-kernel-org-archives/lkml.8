Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C452C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3104B206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="m0BlenTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDITPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:15:32 -0400
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:35392
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbgDITPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:15:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW2P+tG4uF7MsCwq0EsF2sM5uoRux2t9EeahtqIVmxaUZeG/0/0wcyNSMsonbwN3WZ4URvTYhc3finLPOmoRBGap11Z+On1TiywRp/jf5R20NK6c7Kt8jDnvd09L7UeF/COmyr5TjkjaETLlphx1qL7oFaSDQu5A8cFchkeWrrUvETJdebCAGcfwAwx6WQw8hjAj568jE8PRH+Gsb+Nucy+YSqXUX/1Yu8LWN+drqe4rPlHoTKPRF97aF1H/MkJbSrw6RlN6HKufY3CIq6PP2qvJayADFHIUIhAuueJyAG1X4vIIHnstQW6IaxmOEC80x/pFYdTj07pRdSWun0uDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0nLemtZ0w8h4ajLjICpZVwTtE+gvitXSzz8fRW9AZE=;
 b=MHGu2ZQI9DoIWiDCoiDnGEEZW27Yik3QhoPZzQAwCmnpJ95ANLwYDseXHSOEBBHn4dBrmhXd1xs4Ng+lOVQ6xaMKkC9XZ+ipiXS4O0bQ7sUmL/1M9F0TVKaz7RRsugwSmBtoxGaHpxpRVw5CBYFsaWm/mnE/b0X5frQgdubnMZ2jL+9DrsdSUikRRi/cFeyUzmrunV5FCLcAk1NvR6gY/AocYP8kZIbO0cfF+I0ddSaUPh1a54ZjP/8ZOs0Yni8kjWT6CwiqerLH5OqGyHAD+aXSnkfX+RM6GrLXXHNg67uCaPg86s7BFz0EOHz+rt+mKh9y5fTOo+35TFhNkJASMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0nLemtZ0w8h4ajLjICpZVwTtE+gvitXSzz8fRW9AZE=;
 b=m0BlenTgM1z68+NnnwtcRJjSNkFuHDl65SUMYwg4yLWaqPaFYyjmv1DQl1cp1WzDXag3pWulj3OM8RL+mxGpi29HhmBtfDdHDucVLViNydA9vF19T7myWT6Io56WaTVX8Kl3jFj6o6bLeGJi2I0l8SiBFvALKizRtbA0oXTj0F0=
Received: from CY1PR07CA0035.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::45) by DM6PR02MB4602.namprd02.prod.outlook.com
 (2603:10b6:5:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 19:12:51 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:e400:c60a:cafe::ee) by CY1PR07CA0035.outlook.office365.com
 (2a01:111:e400:c60a::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:50
 +0000
Received: from [149.199.38.66] (port=44359 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbA-00060i-1v; Thu, 09 Apr 2020 12:12:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcba-0007NV-GV; Thu, 09 Apr 2020 12:12:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbS-0007La-C0; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 11/25] firmware: xilinx: Use APIs instead of IOCTLs
Date:   Thu,  9 Apr 2020 12:12:00 -0700
Message-Id: <1586459534-8997-12-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966005)(82740400003)(478600001)(336012)(54906003)(4326008)(36756003)(107886003)(26005)(186003)(316002)(70206006)(6636002)(2616005)(9786002)(426003)(81166007)(7416002)(2906002)(5660300002)(8676002)(7696005)(30864003)(6666004)(47076004)(356004)(44832011)(70586007)(8936002)(81156014);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcf8e0c4-1423-4954-a92f-08d7dcb9ff6e
X-MS-TrafficTypeDiagnostic: DM6PR02MB4602:
X-Microsoft-Antispam-PRVS: <DM6PR02MB46025462429D051F583E45A0B8C10@DM6PR02MB4602.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:188;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVsrA8pwS8ArebonCMYa+GkA2eA7x9AxcGpZeNGArRe6nysFZlHBdVTh2Bs+SezJJ+Q+BGSI1Z56/ShWfGbv5osdF9bLrgtMg98r3RW4CQ/UaJZXNv2bNNi4I4VU/fqOqdkx57w3TPHyrnd3s8606uKO0LTdJskubyOWip9T4kmNmc9mXSk5964WZyGgs/zEoRS1vLlt5DjPuyTHFoTMOnzrKbVWjjRj/c6j6DmKx6Zi6rV4Jl+jKZCW4XhUnPzRepKiF+zLaCA/dEDqFO+igoAxTPa8ghdXJ+ZkBuS/MX4K7SAy2JxssgWqIbDRcTtJsmZZhYYf6XISdZ/5u72151ddfLyTAPSmzjc+MJu2TqinHM4E+q0r6PVzAaPAY6cWctzQpU9bE0akidLQTxARD9wHP4ixqTdXdNSTPGeT7xnzzpJQvgrArvb31VBvV/R1kX6PXaywY1ur1WewJNrwAvyETFOhtddUs5VohIRRM2lhzJfBIHXl2BkUk3D+ENcDgabgJqlHDVMAXfw9ZZqB0w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:50.8567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf8e0c4-1423-4954-a92f-08d7dcb9ff6e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Remove IOCTL API and use individual APIs for better readability.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/pll.c             |  14 ++---
 drivers/firmware/xilinx/zynqmp.c     | 118 ++++++++++++++++++++++++++---------
 drivers/mmc/host/sdhci-of-arasan.c   |  38 +----------
 include/linux/firmware/xlnx-zynqmp.h |  31 ++++++++-
 4 files changed, 126 insertions(+), 75 deletions(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 73fb5bb..92f449e 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -50,10 +50,8 @@ static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0,
-			      ret_payload);
+	ret = zynqmp_pm_get_pll_frac_mode(clk_id, ret_payload);
 	if (ret)
 		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
@@ -73,14 +71,13 @@ static inline void zynqmp_pll_set_mode(struct clk_hw *hw, bool on)
 	const char *clk_name = clk_hw_get_name(hw);
 	int ret;
 	u32 mode;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
 	if (on)
 		mode = PLL_MODE_FRAC;
 	else
 		mode = PLL_MODE_INT;
 
-	ret = eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode, NULL);
+	ret = zynqmp_pm_set_pll_frac_mode(clk_id, mode);
 	if (ret)
 		pr_warn_once("%s() PLL set frac mode failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
@@ -139,7 +136,6 @@ static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
 	unsigned long rate, frac;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
 	ret = zynqmp_pm_clock_getdivider(clk_id, &fbdiv);
 	if (ret)
@@ -148,8 +144,7 @@ static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
 
 	rate =  parent_rate * fbdiv;
 	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
-		eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0,
-				ret_payload);
+		zynqmp_pm_get_pll_frac_data(clk_id, ret_payload);
 		data = ret_payload[1];
 		frac = (parent_rate * data) / FRAC_DIV;
 		rate = rate + frac;
@@ -177,7 +172,6 @@ static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 fbdiv;
 	long rate_div, frac, m, f;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
 	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
 		rate_div = (rate * FRAC_DIV) / parent_rate;
@@ -194,7 +188,7 @@ static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		else if (ret)
 			pr_warn_once("%s() set divider failed for %s, ret = %d\n",
 				     __func__, clk_name, ret);
-		eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, f, NULL);
+		zynqmp_pm_set_pll_frac_data(clk_id, f);
 
 		return rate + frac;
 	}
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index b0aa967..94fd755 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -516,47 +516,108 @@ int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
 
 /**
- * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
- * @ioctl_id:	IOCTL ID
+ * zynqmp_pm_set_pll_frac_mode() - PM API for set PLL mode
  *
- * Return: 1 if IOCTL is valid else 0
+ * @clk_id:	PLL clock ID
+ * @mode:	PLL mode (PLL_MODE_FRAC/PLL_MODE_INT)
+ *
+ * This function sets PLL mode
+ *
+ * Return: Returns status, either success or error+reason
  */
-static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
+int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
 {
-	switch (ioctl_id) {
-	case IOCTL_SD_DLL_RESET:
-	case IOCTL_SET_SD_TAPDELAY:
-	case IOCTL_SET_PLL_FRAC_MODE:
-	case IOCTL_GET_PLL_FRAC_MODE:
-	case IOCTL_SET_PLL_FRAC_DATA:
-	case IOCTL_GET_PLL_FRAC_DATA:
-		return 1;
-	default:
-		return 0;
-	}
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_MODE,
+				   clk_id, mode, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
 
 /**
- * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
- * @node_id:	Node ID of the device
- * @ioctl_id:	ID of the requested IOCTL
- * @arg1:	Argument 1 to requested IOCTL call
- * @arg2:	Argument 2 to requested IOCTL call
- * @out:	Returned output value
+ * zynqmp_pm_get_pll_frac_mode() - PM API for get PLL mode
+ *
+ * @clk_id:	PLL clock ID
+ * @mode:	PLL mode
  *
- * This function calls IOCTL to firmware for device control and configuration.
+ * This function return current PLL mode
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
-			   u32 *out)
+int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
 {
-	if (!zynqmp_is_valid_ioctl(ioctl_id))
-		return -EINVAL;
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_MODE,
+				   clk_id, 0, mode);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
+
+/**
+ * zynqmp_pm_set_pll_frac_data() - PM API for setting pll fraction data
+ *
+ * @clk_id:	PLL clock ID
+ * @data:	fraction data
+ *
+ * This function sets fraction data.
+ * It is valid for fraction mode only.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_DATA,
+				   clk_id, data, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
+
+/**
+ * zynqmp_pm_get_pll_frac_data() - PM API for getting pll fraction data
+ *
+ * @clk_id:	PLL clock ID
+ * @data:	fraction data
+ *
+ * This function returns fraction data value.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_DATA,
+				   clk_id, 0, data);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
 
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
-				   arg1, arg2, out);
+/**
+ * zynqmp_pm_set_sd_tapdelay() -  Set tap delay for the SD device
+ *
+ * @node_id	Node ID of the device
+ * @type	Type of tap delay to set (input/output)
+ * @value	Value to set fot the tap delay
+ *
+ * This function sets input/output tap delay for the SD device.
+ *
+ * @return	Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY,
+				   type, value, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
+
+/**
+ * zynqmp_pm_sd_dll_reset() - Reset DLL logic
+ *
+ * @node_id	Node ID of the device
+ * @type	Reset type
+ *
+ * This function resets DLL logic for the SD device.
+ *
+ * @return	Returns status, either success or error+reason
+ */
+int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY,
+				   type, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
 
 /**
  * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
@@ -746,7 +807,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.ioctl = zynqmp_pm_ioctl,
 	.reset_assert = zynqmp_pm_reset_assert,
 	.reset_get_status = zynqmp_pm_reset_get_status,
 	.init_finalize = zynqmp_pm_init_finalize,
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index d4905c1..d01f762 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -98,10 +98,6 @@ struct sdhci_arasan_clk_data {
 	void		*clk_of_data;
 };
 
-struct sdhci_arasan_zynqmp_clk_data {
-	const struct zynqmp_eemi_ops *eemi_ops;
-};
-
 /**
  * struct sdhci_arasan_data
  * @host:		Pointer to the main SDHCI host structure.
@@ -630,9 +626,6 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 	struct sdhci_arasan_data *sdhci_arasan =
 		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
-	struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data =
-		clk_data->clk_of_data;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_clk_data->eemi_ops;
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 node_id = !strcmp(clk_name, "clk_out_sd0") ? NODE_SD_0 : NODE_SD_1;
 	u8 tap_delay, tap_max = 0;
@@ -672,8 +665,7 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 	tap_delay = (degrees * tap_max) / 360;
 
 	/* Set the Clock Phase */
-	ret = eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
-			      PM_TAPDELAY_OUTPUT, tap_delay, NULL);
+	ret = zynqmp_pm_set_sd_tapdelay(node_id, PM_TAPDELAY_OUTPUT, tap_delay);
 	if (ret)
 		pr_err("Error setting Output Tap Delay\n");
 
@@ -702,9 +694,6 @@ static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 	struct sdhci_arasan_data *sdhci_arasan =
 		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
-	struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data =
-		clk_data->clk_of_data;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_clk_data->eemi_ops;
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 node_id = !strcmp(clk_name, "clk_in_sd0") ? NODE_SD_0 : NODE_SD_1;
 	u8 tap_delay, tap_max = 0;
@@ -744,8 +733,7 @@ static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 	tap_delay = (degrees * tap_max) / 360;
 
 	/* Set the Clock Phase */
-	ret = eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
-			      PM_TAPDELAY_INPUT, tap_delay, NULL);
+	ret = zynqmp_pm_set_sd_tapdelay(node_id, PM_TAPDELAY_INPUT, tap_delay);
 	if (ret)
 		pr_err("Error setting Input Tap Delay\n");
 
@@ -759,11 +747,6 @@ static const struct clk_ops zynqmp_sampleclk_ops = {
 
 static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u32 deviceid)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
-	struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data =
-		sdhci_arasan->clk_data.clk_of_data;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_clk_data->eemi_ops;
 	u16 clk;
 
 	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
@@ -771,8 +754,7 @@ static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u32 deviceid)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	/* Issue DLL Reset */
-	eemi_ops->ioctl(deviceid, IOCTL_SD_DLL_RESET,
-			PM_DLL_RESET_PULSE, 0, NULL);
+	zynqmp_pm_sd_dll_reset(deviceid, PM_DLL_RESET_PULSE);
 
 	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 
@@ -1277,20 +1259,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_disable_all;
 
 	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a")) {
-		struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data;
-		const struct zynqmp_eemi_ops *eemi_ops;
-
-		zynqmp_clk_data = devm_kzalloc(&pdev->dev,
-					       sizeof(*zynqmp_clk_data),
-					       GFP_KERNEL);
-		eemi_ops = zynqmp_pm_get_eemi_ops();
-		if (IS_ERR(eemi_ops)) {
-			ret = PTR_ERR(eemi_ops);
-			goto unreg_clk;
-		}
-
-		zynqmp_clk_data->eemi_ops = eemi_ops;
-		sdhci_arasan->clk_data.clk_of_data = zynqmp_clk_data;
 		host->mmc_host_ops.execute_tuning =
 			arasan_zynqmp_execute_tuning;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 7abb683..5aff896 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*reset_assert)(const enum zynqmp_pm_reset reset,
 			    const enum zynqmp_pm_reset_action assert_flag);
 	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
@@ -331,6 +330,12 @@ int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate);
 int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate);
 int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id);
 int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id);
+int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode);
+int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode);
+int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data);
+int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data);
+int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
+int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -385,6 +390,30 @@ static inline int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4


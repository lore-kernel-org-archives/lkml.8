Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A10BC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491A92168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JjVw+p/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgDXU7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:59:36 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:60705
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbgDXU60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:58:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjG85H/In/vAlQzmVNtSzmGEApxGwRxC24Xw0V9wBInbkTQFIkBFZJEucKbbe/gPzWgeuTr9twg8eidrwvz2nlGnNRkaWEdbv7u6dJcIX5cQsg55PMCqBEdQPpSsvdlWx3qbskIbUwcZKvvfonlfug/TN4IXt5nIFHtLTJWN1NCzxYRGRTv64zxRH4IOzwHLlzKqCelyO6ab0MpHaRQFQDQxY6bDraGDGcy1WlEONc2Xsj8uzwzgRntq/i7jVlMT9RpRNfKNEKzseWIP+EJZpgZI1rO88WN7olX0rNddCML/sfaSwPsy4sRUodqTaMYaKMOTgsNC4SP2+9GaCXd/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQPq/wNl++7b2IxZCtzLm1Dxg3IITGUWADpU8pbrYYo=;
 b=g4KOGaDfxsVaIcz+hmBI8xQ1GWX0Hcq2eRhRx7c6IMDstBRhQod+E6Svm8KvlpBrrl/LEIRCzqHRhk5y98Tw1iwR2Ui//q154SS4rDKD6Sk2UXTm2SstfBgfUWfvk6AMkj1wTtpx/LvC3HpZnELffyUUE9Z7IhDWnuRCWnQy7OdLiuqdf//zjLAKughtjafEpouH72RJmRKOEba3pmo6Dlb8TJAACtD5U7U27EjqsyrPtCgdqcpmpvuolxj/blxohFojn1Ac2lGEUOGWWXCfvaFlgKvDjTinOqpbXZiX3OK3MWm3UnNHuV8Jacjuts5USjLtlsQq0qaBtvBC/i3fNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQPq/wNl++7b2IxZCtzLm1Dxg3IITGUWADpU8pbrYYo=;
 b=JjVw+p/yGhKMW+1KDoitqUIwQ1YzsTLxkt6+C2wEfX0tnvxe6E7M9aMStW0z+Kh8e6ZnZP/Rf5nx9/hIIzgI79ThICyIIvLqqjJk5VzlQKT4nE38KTDH5mDXSOPB08HIwouWUowtzfDkumJKka3I4uzCIEFD/2MrRsSbqrLJCaI=
Received: from MN2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:c0::33)
 by CY4PR02MB2711.namprd02.prod.outlook.com (2603:10b6:903:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 20:58:22 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:c0:cafe::6f) by MN2PR05CA0020.outlook.office365.com
 (2603:10b6:208:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.10 via Frontend
 Transport; Fri, 24 Apr 2020 20:58:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 20:58:21
 +0000
Received: from [149.199.38.66] (port=33275 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Nm-0002Cu-BQ; Fri, 24 Apr 2020 13:57:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ov-0007N4-Ak; Fri, 24 Apr 2020 13:58:21 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OKwIM9026311;
        Fri, 24 Apr 2020 13:58:19 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Os-0007Lo-Qi; Fri, 24 Apr 2020 13:58:18 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v5 03/25] firmware: xilinx: Remove eemi ops for query_data
Date:   Fri, 24 Apr 2020 13:57:45 -0700
Message-Id: <1587761887-4279-4-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
References: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966005)(5660300002)(186003)(44832011)(82310400002)(7696005)(26005)(47076004)(336012)(8936002)(70206006)(426003)(107886003)(81166007)(9786002)(8676002)(81156014)(82740400003)(36756003)(4326008)(356005)(316002)(2906002)(2616005)(6666004)(6636002)(478600001)(70586007)(7416002)(54906003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06e09b95-a362-4ffd-c536-08d7e892392d
X-MS-TrafficTypeDiagnostic: CY4PR02MB2711:
X-Microsoft-Antispam-PRVS: <CY4PR02MB271153CE974C36611A21BE61B8D00@CY4PR02MB2711.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:276;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1BeSX2KrZ5rBL1TyU4LHqh70Dldlkh8WnsyfovLuB2DArFcoLpEXjIwgasEt6MOGJJOcivernMWHCzxHzeo3qwhl1k1kNI08a6y4f/CJ/gWQXIDJV33IisYBvB5iGhWXSLnwVrHq5JupnAuoXDq/l1aMOZGY3U8kK37NpNXitSWzg4OcGeK/fM0tdxw1tE/dyvimE0sLDbEj2DPNYyuNgC/M8I8wiIpSC2rY3M4A5LZfAC7HQ3Ape+GTTBan6uULy4Ts4lTN6BOxZz3C3YC8XcvAiWumhBP2HmtzKDJoTZc02cytSYCcCKOj+gRBKfCXmNRP0xl76OmA7exInVWPSNXw00eBJNXzPe3b/pJM/BcbhWD5xYPEfd7vPbHgZynUY1G1wgkibVLoOqu/0l6he1le6I+64Z0CteqRcii3xt83E/qlxAVJgHvDvNuZKqsJZ28PCuC1Yat2obBSurDR8OY9uzmMyPEEyg5Gxcf1GN+SvRL2W1iaTHhkneRzuG/swLnvgpqZ3BNGFc8pKDAqw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 20:58:21.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e09b95-a362-4ffd-c536-08d7e892392d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call for query_data instead of using eemi ops.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clkc.c              | 17 ++++++-----------
 drivers/clk/zynqmp/divider.c           |  3 +--
 drivers/firmware/xilinx/zynqmp-debug.c |  3 +--
 drivers/firmware/xilinx/zynqmp.c       |  4 ++--
 include/linux/firmware/xlnx-zynqmp.h   |  7 ++++++-
 5 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index 10e89f2..5eed5ce 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -134,7 +134,6 @@ static struct clk_hw *(* const clk_topology[]) (const char *name, u32 clk_id,
 static struct zynqmp_clock *clock;
 static struct clk_hw_onecell_data *zynqmp_data;
 static unsigned int clock_max_idx;
-static const struct zynqmp_eemi_ops *eemi_ops;
 
 /**
  * zynqmp_is_valid_clock() - Check whether clock is valid or not
@@ -206,7 +205,7 @@ static int zynqmp_pm_clock_get_num_clocks(u32 *nclocks)
 
 	qdata.qid = PM_QID_CLOCK_GET_NUM_CLOCKS;
 
-	ret = eemi_ops->query_data(qdata, ret_payload);
+	ret = zynqmp_pm_query_data(qdata, ret_payload);
 	*nclocks = ret_payload[1];
 
 	return ret;
@@ -231,7 +230,7 @@ static int zynqmp_pm_clock_get_name(u32 clock_id,
 	qdata.qid = PM_QID_CLOCK_GET_NAME;
 	qdata.arg1 = clock_id;
 
-	eemi_ops->query_data(qdata, ret_payload);
+	zynqmp_pm_query_data(qdata, ret_payload);
 	memcpy(response, ret_payload, sizeof(*response));
 
 	return 0;
@@ -265,7 +264,7 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index,
 	qdata.arg1 = clock_id;
 	qdata.arg2 = index;
 
-	ret = eemi_ops->query_data(qdata, ret_payload);
+	ret = zynqmp_pm_query_data(qdata, ret_payload);
 	memcpy(response, &ret_payload[1], sizeof(*response));
 
 	return ret;
@@ -296,7 +295,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
 	qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
 	qdata.arg1 = clk_id;
 
-	ret = eemi_ops->query_data(qdata, ret_payload);
+	ret = zynqmp_pm_query_data(qdata, ret_payload);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -339,7 +338,7 @@ static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index,
 	qdata.arg1 = clock_id;
 	qdata.arg2 = index;
 
-	ret = eemi_ops->query_data(qdata, ret_payload);
+	ret = zynqmp_pm_query_data(qdata, ret_payload);
 	memcpy(response, &ret_payload[1], sizeof(*response));
 
 	return ret;
@@ -364,7 +363,7 @@ static int zynqmp_pm_clock_get_attributes(u32 clock_id,
 	qdata.qid = PM_QID_CLOCK_GET_ATTRIBUTES;
 	qdata.arg1 = clock_id;
 
-	ret = eemi_ops->query_data(qdata, ret_payload);
+	ret = zynqmp_pm_query_data(qdata, ret_payload);
 	memcpy(response, &ret_payload[1], sizeof(*response));
 
 	return ret;
@@ -738,10 +737,6 @@ static int zynqmp_clock_probe(struct platform_device *pdev)
 	int ret;
 	struct device *dev = &pdev->dev;
 
-	eemi_ops = zynqmp_pm_get_eemi_ops();
-	if (IS_ERR(eemi_ops))
-		return PTR_ERR(eemi_ops);
-
 	ret = zynqmp_clk_setup(dev->of_node);
 
 	return ret;
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 4be2cc7..e21f4ea 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -258,7 +258,6 @@ static const struct clk_ops zynqmp_clk_divider_ops = {
  */
 u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
 {
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	struct zynqmp_pm_query_data qdata = {0};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
@@ -266,7 +265,7 @@ u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
 	qdata.qid = PM_QID_CLOCK_GET_MAX_DIVISOR;
 	qdata.arg1 = clk_id;
 	qdata.arg2 = type;
-	ret = eemi_ops->query_data(qdata, ret_payload);
+	ret = zynqmp_pm_query_data(qdata, ret_payload);
 	/*
 	 * To maintain backward compatibility return maximum possible value
 	 * (0xFFFF) if query for max divisor is not successful.
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 06a21ef..99606b3 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -85,7 +85,6 @@ static int get_pm_api_id(char *pm_api_req, u32 *pm_id)
 
 static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 {
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 pm_api_version;
 	int ret;
 	struct zynqmp_pm_query_data qdata = {0};
@@ -102,7 +101,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		qdata.arg2 = pm_api_arg[2];
 		qdata.arg3 = pm_api_arg[3];
 
-		ret = eemi_ops->query_data(qdata, pm_api_ret);
+		ret = zynqmp_pm_query_data(qdata, pm_api_ret);
 		if (ret)
 			break;
 
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 36ab9ac..3fbab29 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -326,7 +326,7 @@ static int get_set_conduit_method(struct device_node *np)
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
 	int ret;
 
@@ -340,6 +340,7 @@ static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 	 */
 	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_query_data);
 
 /**
  * zynqmp_pm_clock_enable() - Enable the clock for given id
@@ -736,7 +737,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
 	.clock_disable = zynqmp_pm_clock_disable,
 	.clock_getstate = zynqmp_pm_clock_getstate,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 89f6a53..fa1195c7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
 	int (*clock_getstate)(u32 clock_id, u32 *state);
@@ -331,6 +330,7 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 int zynqmp_pm_get_api_version(u32 *version);
 int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
+int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -344,6 +344,11 @@ static inline int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata,
+				       u32 *out)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4


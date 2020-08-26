Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE037C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8436022B40
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="L0S02VAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgHZQPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:15:47 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:57696
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726876AbgHZQNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh1lLDF6Da7APPWNmleDW7vO7o41KmKN5iIOBu8VE+ZZN4i0TXfJY8sQ1d8Et7skBXACMj8wfdMroZnSk6kfdpSkj4L6WUpC1JcgtGTMP+qq4B/I9X2iKGHhnfN1QWXZjj/1cjai2bwfrqAIMa6B4aVlpulsWwAHoQKiaXpTvPTuBsQsixaA0MDngubQOvqHLbrMP5gGwTxvBeyr2R8RZfqtE/tf9GIG9f+k8vmSHVaVOG565+MiFTbgbZLfysBM+4dn2hqXqLVRzWoXPulDaLKVDAYJSVQ4rrc9bRPu8veSAh8j4KVqQbCs/mRzu4wBNfopRCqPPoObouVyCqUxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPJTeFxFxhlkY5wDeF6NoOMC1ZUFeGzsJg5GiaK6Xfo=;
 b=RV1r5t6i1ijtXxpMKvycO6cSORUDiV62jAdf+gqDjP5vqBKBrcUeSPUbPWqXtz3ougjfZO1Sinoklaw5wpbWj+39uy9akmDL9DgtEEBohzN4iyOG+QAsnmjGYL0v8fLNIlolI7ecIJsPqNw3qTyIVJ1sIBrpynpc2jlzCUidcvJbnfDQJya/VUoXvxfPxgiil0/b36AwE6h93Pxc1R+n0QUwTkWk2WdXmHxib18bjyDyH5tQxUXnRC0JQGZdwenfwCms8t4zAolF2ZNkEQXkV130VWNd/mTONFhf8RA2YcLqK8HcZlBVsCL2saig+p/UbOIpCut2cc8JheFu6QAfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPJTeFxFxhlkY5wDeF6NoOMC1ZUFeGzsJg5GiaK6Xfo=;
 b=L0S02VAW5VCc4a4ey+1StGLfofb04kOHbi6lzKVG/hLfn6oY1kp9OgPUIwLRhspiwLyOYwx+J/RGBnwmaHcEs8cQXUdgdlEqSPSvgw5eKdl3o20eW3cpL9nji8FPtsDRz2smiCznXJIclRRPi22HM81sW4J+ZQjHlp/pTvEU5w4=
Received: from BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) by
 CY4PR02MB2661.namprd02.prod.outlook.com (2603:10b6:903:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 16:13:10 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::68) by BL0PR0102CA0021.outlook.office365.com
 (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 16:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 16:13:10
 +0000
Received: from [149.199.38.66] (port=58629 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2Q-0006aE-Os; Wed, 26 Aug 2020 09:12:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2v-0008BQ-NJ; Wed, 26 Aug 2020 09:13:09 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2t-0008B0-Pd; Wed, 26 Aug 2020 09:13:07 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        michael.auchter@ni.com
Subject: [PATCH v9 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Wed, 26 Aug 2020 09:13:05 -0700
Message-Id: <20200826161307.1064-4-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826161307.1064-1-ben.levinsky@xilinx.com>
References: <20200826161307.1064-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7cd0ac28-6661-4d3c-64f9-08d849daed01
X-MS-TrafficTypeDiagnostic: CY4PR02MB2661:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2661D9B6984F30186CFA78BBB5540@CY4PR02MB2661.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHNkcvKuDCWgbfEdHSfw6pWZ5URrRX6XOg9R7vV2VLpbKW7QH62C06UrnnFb17B8gvXTCPv+PILsEa5Pd0WNSho/86TYeJwJNFVIW+RiGkQp0ZHmdlBOuEJRiz/ipObW4P3fUhF6hMnZfxKqpEApqY5oxjMhJLr+a3pPezTIsV8079CKG/oYbyJ0NjdxMgoPcYGOR5D5rzRCPu4MQNLo6s468yZBTCdR7SzOUiAEn20uy3weowSyyqr1Ktt4OTestVS7nDoMiEhu9pxEIZoln2FBt5qEu7+vRr3nQiMmoDjTURGuY86Vc6E7sXfYZAJin0ER9hlJhh4gG3cMlycb+c6DgUC6cM30hlv7cabN4LIqQi15RAQHqM3HoYSqpMasfwc22X3RrxzsrajyDkbLuQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(46966005)(336012)(7696005)(26005)(9786002)(2906002)(6636002)(70586007)(70206006)(186003)(83380400001)(4326008)(44832011)(8676002)(8936002)(82310400002)(47076004)(1076003)(426003)(36756003)(82740400003)(81166007)(356005)(5660300002)(478600001)(2616005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 16:13:10.0815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd0ac28-6661-4d3c-64f9-08d849daed01
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds APIs to access to configure RPU and its
processor-specific memory.

That is query the run-time mode of RPU as either split or lockstep as well
as API to set this mode. In addition add APIs to access configuration of
the RPUs' tightly coupled memory (TCM).

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
v4:
- add default values for enums
v9:
- update commit message
- for zynqmp_pm_set_tcm_config and zynqmp_pm_get_rpu_mode update docs for
  expected output, arguments as well removing unused args
- remove unused fn zynqmp_pm_get_node_status
---
 drivers/firmware/xilinx/zynqmp.c     | 51 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 22 ++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a966ee956573..6907abcaa981 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -846,6 +846,57 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_get_rpu_mode() - Get RPU mode
+ * @node_id:	Node ID of the device
+ * @out:	Returned output value
+ *
+ * Return: RPU mode. This is enum rpu_oper_mode
+ */
+int zynqmp_pm_get_rpu_mode(u32 node_id, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_GET_RPU_OPER_MODE, 0, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
+
+/**
+ * zynqmp_pm_set_rpu_mode() - Set RPU mode
+ * @node_id:	Node ID of the device
+ * @arg1:	Argument 1 to requested IOCTL call. This is expeted to
+ *              to be value from enum rpu_oper_mode
+ * @out:	Returned output value
+ *
+ * This function is used to set RPU mode to split or lockstep
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_rpu_mode(u32 node_id,
+			   u32 arg1, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_SET_RPU_OPER_MODE, arg1, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
+
+/**
+ * zynqmp_pm_set_tcm_config - configure TCM
+ * @arg1:	Argument 1 to requested IOCTL call
+ *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
+ * @out:	Returned output value
+ *
+ * This function is used to set RPU mode to split or combined
+ *
+ * Return: status: 0 for success, else failure
+ */
+int zynqmp_pm_set_tcm_config(u32 node_id,
+			     u32 arg1, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_TCM_COMB_CONFIG, arg1, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
+
 /**
  * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
  *             be powered down forcefully
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1f92ea99ad7c..3cdc3f334c39 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -384,6 +384,11 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const bool set_addr,
 			   const u64 address,
 			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_get_rpu_mode(u32 node_id, u32 *out);
+int zynqmp_pm_set_rpu_mode(u32 node_id,
+			   u32 arg1, u32 *out);
+int zynqmp_pm_set_tcm_config(u32 node_id,
+			     u32 arg1, u32 *out);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -548,6 +553,23 @@ static inline int zynqmp_pm_request_wake(const u32 node,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_get_rpu_mode(u32 node_id, u32 *out)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_rpu_mode(u32 node_id,
+					 u32 arg1, u32 *out)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_tcm_config(u32 node_id,
+					   u32 arg1, u32 *out)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.17.1


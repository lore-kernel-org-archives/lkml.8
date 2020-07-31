Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43440C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A92921744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NQsYqXzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbgGaQsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:48:18 -0400
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com ([40.107.94.47]:18945
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732673AbgGaQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:48:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF8JGa9Wjyg9g4UlK0XDkWPNjCuZnUGUVDoIeGT1f4vwVGxjmuzczVJH2yXvYliOd+09BdWY45C47tHYPAkUDsRSv7bzv2PI04tiL18CVALzu6utrbQiIXypLlReFniJkHyWdfZVXoNsmlTA6MMxO84mWvOxR8UNXJAOOxRSWGFyoh6kWlirudRun9ohQDLCaanHGsW2RP2gCaORq1ytZLr6sxYJAo2GatRn66D4D/CTDAJd3JC8n5EhpAlUfkgMCVxPGVJUnLlPZVNtgZVB3oROEV7pDr4XcZ7xFin9qY7ZttlVulYqAxv7QR/tHOwbxMCAx3RWFgVUjIL+pcY03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEdA5MsFpqG5rs1CAktgtjDjK9YRV5hVDrmuPPYU0C8=;
 b=IDdA7Z9vfIs+pu/wBkY5H0Q2u9ojF/xHsW4smevP9JnAu03TEVfOyPe230qbK50/XC6FbWFMJVsKPtfJHbldixo9y65KicjFVR0nKoTS8wN3IEh6pJX5ke0LNFXc5i0AS1ZW34iyQk2bu+0BUJ+XFQrvhJTrysxITptdibZhyobmC9+07IESSjqBrQAwA5cayea9DTo8G/GNX6Ts9Lw/vGoMpgC3cIizvPP9SLVT5OERwI67QJw2Urr5HkwS1DwP9b7Pt047VQKqMdMg9Iovs4hTU0NiXdKA/ebzhCw5FCnHC6MoUUZNR9PzPN4MwuSoXZcHMYijHRAdvxuNGh8ODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEdA5MsFpqG5rs1CAktgtjDjK9YRV5hVDrmuPPYU0C8=;
 b=NQsYqXznON99QXjD0LtXYc3ZH8L3ZUXYNnWIpOx2H08vEQO5Wxk3YWxxf9TmpGz19TjiWDLoG7O2wSRztRGy2JhQIXklGmFgLHtk8l4qFnT49JiyBXVlu+tvAQ5yI4sMsnV4fiETnMU8nSitaQopo87qkVcSQ99db9sd1yB5z44=
Received: from SN4PR0601CA0010.namprd06.prod.outlook.com
 (2603:10b6:803:2f::20) by BN6PR02MB3204.namprd02.prod.outlook.com
 (2603:10b6:405:62::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 16:48:06 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::92) by SN4PR0601CA0010.outlook.office365.com
 (2603:10b6:803:2f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Fri, 31 Jul 2020 16:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 16:48:06
 +0000
Received: from [149.199.38.66] (port=41007 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YAS-0006bi-BN; Fri, 31 Jul 2020 09:46:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCT-0007o7-US; Fri, 31 Jul 2020 09:48:05 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06VGlt0s021516;
        Fri, 31 Jul 2020 09:47:55 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCJ-0007jL-2M; Fri, 31 Jul 2020 09:47:55 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michal.simek@xilinx.com
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Fri, 31 Jul 2020 09:47:52 -0700
Message-Id: <20200731164754.20505-4-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731164754.20505-1-ben.levinsky@xilinx.com>
References: <20200731164754.20505-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 694f4bde-f06c-4168-1b0b-08d835717fa6
X-MS-TrafficTypeDiagnostic: BN6PR02MB3204:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3204431E5D45130AE9BE20E9B54E0@BN6PR02MB3204.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NtabbDq7c6hX6R0VYnnnB9lluvW9kJWUKVDBYoT+N07V0qxOBuDA9GUYIIK+I//nl5QmS8THrXz5gmmdtJ4QU88nsYNKINGoxfeHGaz6z62vpdfpkCM9CQE3VXv+9jG0+lJJBcwbLA/FRjuMrCu71fXz/rGKmmGNvDwFOrRa7v+nZ4om+tHxaQW77mkgObnIewDmJKc/O2VQHZ0Yxe76ApNXyJeS9CMksJrTp6DpK1JSSug7kp8m7QIhqddzXsp5nj/BZ9b8ng3XMHw5vZMaoOxefq6QHE2RqJngoqQjEVYagxSUJ+D5dD/1XJUmiWVO0N1fOCZdJgxMoCxpm706PNa30yPYyNVE01kIkpBrRkTweua2zQ6Yxm2HbELbYpGv8e/lO3yECv+tLEKQvgAExEVTvJ96T7NHGPWprmIpKk=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(346002)(39860400002)(46966005)(7696005)(6636002)(186003)(5660300002)(336012)(26005)(316002)(9786002)(6666004)(4326008)(8676002)(8936002)(2616005)(2906002)(83380400001)(478600001)(81166007)(47076004)(82740400003)(1076003)(356005)(426003)(70206006)(36756003)(70586007)(82310400002)(44832011)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 16:48:06.1984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 694f4bde-f06c-4168-1b0b-08d835717fa6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds APIs to provide access and a configuration interface
to the current power state of a sub-system on Zynqmp sub-system.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
v4:
- add default values for enums
---
 drivers/firmware/xilinx/zynqmp.c     | 99 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 34 ++++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index f1a0bd35deeb..fdd61d258e55 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -846,6 +846,61 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_get_rpu_mode() - Get RPU mode
+ * @node_id:	Node ID of the device
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * Return: RPU mode
+ */
+int zynqmp_pm_get_rpu_mode(u32 node_id,
+			   u32 arg1, u32 arg2, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_GET_RPU_OPER_MODE, 0, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
+
+/**
+ * zynqmp_pm_set_rpu_mode() - Set RPU mode
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function is used to set RPU mode.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_rpu_mode(u32 node_id,
+			   u32 arg1, u32 arg2, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_SET_RPU_OPER_MODE, 0, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
+
+/**
+ * zynqmp_pm_tcm_comb_config - configure TCM
+ * @node_id:	Node ID of the device
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function is used to set RPU mode.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_tcm_config(u32 node_id,
+			     u32 arg1, u32 arg2, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_TCM_COMB_CONFIG, 0, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
+
 /**
  * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
  *             be powered down forcefully
@@ -881,6 +936,50 @@ int zynqmp_pm_request_wakeup(const u32 node,
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
 
+/**
+ * zynqmp_pm_get_node_status - PM call to request a node's current power state
+ * @node:      ID of the component or sub-system in question
+ * @status:        Current operating state of the requested node
+ * @requirements:  Current requirements asserted on the node,
+ *         used for slave nodes only.
+ * @usage:     Usage information, used for slave nodes only:
+ *         PM_USAGE_NO_MASTER  - No master is currently using
+ *                       the node
+ *         PM_USAGE_CURRENT_MASTER - Only requesting master is
+ *                       currently using the node
+ *         PM_USAGE_OTHER_MASTER   - Only other masters are
+ *                       currently using the node
+ *         PM_USAGE_BOTH_MASTERS   - Both the current and at least
+ *                       one other master is currently
+ *                       using the node
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_get_node_status(const u32 node,
+			      u32 *status, u32 *requirements,
+			      u32 *usage)
+
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, node, 0, 0, 0,
+				  ret_payload);
+	if (ret_payload[0] == XST_PM_SUCCESS) {
+		*status = ret_payload[1];
+		if (requirements)
+			*requirements = ret_payload[2];
+		if (usage)
+			*usage = ret_payload[3];
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_node_status);
+
 /**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 4d83a7d69c4c..0caca9e2223a 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -64,6 +64,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_NODE_STATUS = 3,
 	PM_FORCE_POWERDOWN = 8,
 	PM_REQUEST_WAKEUP = 10,
 	PM_SYSTEM_SHUTDOWN = 12,
@@ -384,6 +385,14 @@ int zynqmp_pm_request_wakeup(const u32 node,
 			     const bool set_addr,
 			     const u64 address,
 			     const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_get_node_status(const u32 node, u32 *status,
+			      u32 *requirements, u32 *usage);
+int zynqmp_pm_get_rpu_mode(u32 node_id,
+			   u32 arg1, u32 arg2, u32 *out);
+int zynqmp_pm_set_rpu_mode(u32 node_id,
+			   u32 arg1, u32 arg2, u32 *out);
+int zynqmp_pm_set_tcm_config(u32 node_id,
+			     u32 arg1, u32 arg2, u32 *out);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -548,6 +557,31 @@ static inline int zynqmp_pm_request_wakeup(const u32 node,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_get_node_status(const u32 node,
+					    u32 *status, u32 *requirements,
+					    u32 *usage)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_get_rpu_mode(u32 node_id,
+					 u32 arg1, u32 arg2, u32 *out)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_rpu_mode(u32 node_id,
+					 u32 arg1, u32 arg2, u32 *out)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_tcm_config(u32 node_id,
+					   u32 arg1, u32 arg2, u32 *out)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.17.1


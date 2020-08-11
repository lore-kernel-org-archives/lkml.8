Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C466C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E5C206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hw14WBPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgHKDce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:32:34 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:21472
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbgHKDc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:32:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krt3met7FdpDjCBdxM9CxIFdl0CRZp9OjLaQy/MfYc8ChjeiNi8hdhNxfR1R8jaEm8SLFrQOOnXZwKLaISG5QdZ8VNqW3QoS/MKcTpt2cFb41BGxMtNOX3uIp2KDba2JBOFvKFU/z8+qdPMbKaqT7CKOWceM435ybFJYVjpcvLXIIHpAfcaQul6XAHUNVZzTSFwTqO1oppGenIuYdaw0OpZitb8UiMRl6qew7B5gseMgk88XrUsZaxYChrDmvlRqGP0OQsDZukjTcyELs49Yw0vLg82Ny5aDbVC4YWcEtBD70cKEv8PY1W10kbJWKHXdAywayLM8lTOKcqr2hdFb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEdA5MsFpqG5rs1CAktgtjDjK9YRV5hVDrmuPPYU0C8=;
 b=mS9WJFoyuGNikxRrjZNpcDSziK6jUy2DjI9fAbZAgHvJX7n7xSn1wVjmGkoZWXCddJrnWNd+1JrLCECku8o7D/+8A4AgsM1gzK2TKaAnXOGCakuDl5C/4qNICMTeAWge7SGtXY/qsJ/0F++mIpsZ1JmPuyRrQA3Da2+82eL4SSY7AalWXfKQruiPCvZOz71LJCoqOt3ff5H5m52XJ7rCIg7yGkbLtVLrq0Qn7Ot/lWWabGdZsbnlz7ZqSNYnKv2fvK9gUimrAM2Emp24mXyDuPkoeCy5T425yiFuhzt5tA0oomaeq9HokxPzA8CPid+WaTjHorOTGTM43Eh8V/TeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEdA5MsFpqG5rs1CAktgtjDjK9YRV5hVDrmuPPYU0C8=;
 b=hw14WBPCKnxp1sHGoOQBvl3bfDh6QSzSQNzikHzju0pJGr/ScX4s8I4LEbN/Z2m4W3x9tJvrAgTeVK+09G0RQFLrWPPKn8C/xH2XjU3FQRYzusDA+OKZUaofKvq07AS70tz1IsK+IZFeqvntXDjzvvSjhwbzXScxiRMgDyPJXb4=
Received: from CY4PR08CA0045.namprd08.prod.outlook.com (2603:10b6:903:151::31)
 by BYAPR02MB5575.namprd02.prod.outlook.com (2603:10b6:a03:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 03:32:21 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:151:cafe::66) by CY4PR08CA0045.outlook.office365.com
 (2603:10b6:903:151::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Tue, 11 Aug 2020 03:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server id 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 03:32:21
 +0000
Received: from [149.199.38.66] (port=60887 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1K-0000hw-H4; Mon, 10 Aug 2020 20:32:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1R-0004hE-3a; Mon, 10 Aug 2020 20:32:21 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1J-0004gc-7n; Mon, 10 Aug 2020 20:32:13 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefanos@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        ed.mooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wendy.liang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Mon, 10 Aug 2020 20:32:11 -0700
Message-Id: <20200811033213.20088-4-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811033213.20088-1-ben.levinsky@xilinx.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ef34c190-f547-4af6-0b56-08d83da72809
X-MS-TrafficTypeDiagnostic: BYAPR02MB5575:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5575BB6DA7D9BEECD3174D5CB5450@BYAPR02MB5575.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SK3ES24WSe1HOav1uLarPCuvl+PB8M6BFnFIu34wn61b+Y2cwsIVFG8Gg/V386mT3hhm5EbgwHH35AUejRBZJDtq0lmtCe0YZOF7lH5DghE+bln72iLADhfSZ3/4JK61f4irgFI550I+PPReG41cPSoLxCCcbpKLKeiL2CiXRFe6Y23lKzrauH8Yte7hGf1Yvz9DeAiaJvzqqHfv+5c3/7s6kLAEcgSYWt7kbngzgFPfCcF7k0+0GyDQIaODCaJ3VBX7kT/QSnSSwNIDc4xEwK9/BtrjX6aA1WGPkMSr18ywdGXa9MY2RzHyWjxtFrz01QUZWQOkvDV2tB2IHI0goRu2P1+vXFeXz82mhpOJWtsoKWfR6JMlMU5oRcK2pmxFZ/bvFzth1iUA/kjZfYRRQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(396003)(46966005)(81166007)(356005)(6636002)(1076003)(8936002)(82310400002)(2906002)(70206006)(47076004)(478600001)(2616005)(316002)(36756003)(186003)(26005)(5660300002)(426003)(44832011)(70586007)(82740400003)(7696005)(4326008)(83380400001)(8676002)(336012)(9786002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:32:21.3369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef34c190-f547-4af6-0b56-08d83da72809
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5575
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


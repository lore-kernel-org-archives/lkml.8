Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEECC433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C14206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BlSUY4fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGOPdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:33:42 -0400
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:55808
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbgGOPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:33:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3WAPRJ3CiKLQ7dtFgqw/XrDoBbDg6A32puOmEqFWB9h1GEuNit6TsR16QxbMwGv8gU6qN6Of3SHmpqQJCGEZ2K27sibvbsdEPUrtQkK2qDqKjAHbweFb/VBga8Cie8WY347OsesppI6Grnzlex9nQgRydJmOO7QUP9EgXHIPMyNnCFwT9PBQgzfceEGAK1FY3/pW0VUZI/KVIIPg0EQKibUbFmn/uTiwsm5iw/3sN9aLCHtUNG7KLxABZdzYzuYcPjgm7I0Ea4Z7u85S7jzDefHh4JW25GrWZoQb8TFqqCOutFw7cbTcalqDniM6i87EBBuvR6Td9sB9uPsdhTouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEdA5MsFpqG5rs1CAktgtjDjK9YRV5hVDrmuPPYU0C8=;
 b=iAbx4Nw+bk9RuxCN+mwNzYDh7qqCE1ED+mOkPnSdKnwRJPfV/7kY3OxkJeo16MPMTzKE429TRJ4OFsumac1lExgaazsp3RlGk1+PFr0t8fLH/wLHCYaXAP+kGkKsQ7x9aUPnCgip568FKbobNeag2iwvJCFuoH5Rmw9+49JS3dk3H87k1emcso8LdyJYLp5lagvRGDxEhIotYPQ8ONi7pK8HKJb6hbLELcMFCxQI2zW0/oxRkIuk5VN7oe55pQ+4ESH1D40JETZrXGUEngCLHrJ+3OlL/kU2KgF54eVTqPUiS1+H6BxTJEJsBwLbVnZpvGD5dVqzoPPaYRL4UwhA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEdA5MsFpqG5rs1CAktgtjDjK9YRV5hVDrmuPPYU0C8=;
 b=BlSUY4fyBrGTSXiyGvIhY982kqKg8graoVNUwCI2O5dEgUHSpAI9Yw9TjqE+kuFKnb3+9aicOgkfrJmm3SyKwGw7RgNYFKQJAG/9fE5O4DF53hSwz0Mq4LsVjVyGMRDbmY/X4TTaT73FxmtwbOfuurXPiCrIw5FsmeLTcQYnRc8=
Received: from DM5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:3:c0::13) by
 DM6PR02MB4988.namprd02.prod.outlook.com (2603:10b6:5:52::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Wed, 15 Jul 2020 15:33:20 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::ae) by DM5PR16CA0003.outlook.office365.com
 (2603:10b6:3:c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Wed, 15 Jul 2020 15:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 15:33:20
 +0000
Received: from [149.199.38.66] (port=39367 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjNh-0005fL-6O; Wed, 15 Jul 2020 08:31:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPM-0007rZ-1t; Wed, 15 Jul 2020 08:33:20 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPJ-0007qz-Ot; Wed, 15 Jul 2020 08:33:17 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        JOLLYS@xilinx.com, RAJANV@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        stefanos@xilinx.com
Subject: [PATCH v6 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Wed, 15 Jul 2020 08:33:15 -0700
Message-Id: <20200715153317.25643-4-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715153317.25643-1-ben.levinsky@xilinx.com>
References: <20200715153317.25643-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(136003)(39860400002)(46966005)(70586007)(83380400001)(36756003)(9786002)(316002)(186003)(7696005)(8936002)(336012)(81166007)(26005)(478600001)(70206006)(2906002)(107886003)(47076004)(82310400002)(356005)(4326008)(82740400003)(44832011)(8676002)(2616005)(426003)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 72a7c68a-5feb-4a9a-2e44-08d828d46746
X-MS-TrafficTypeDiagnostic: DM6PR02MB4988:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4988F415A5D429BE3DC73E59B57E0@DM6PR02MB4988.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Twq6uBU/j1cmMnLx2urI70UTGe/pDfxwex8fBMdRMPfcCD8gnCkDRVaS8MorMVMby0xCuxLIly6f8q8VH0tVL1J+BvszkvwOQNG13vAQIoKtYBcwXMsbkQSbp1mQYZHO42mpbnLL4LkkZfMAcU0UHbIDj2dRMl+TiS95RqxJ8M21ietQug5jj10IOJ+rFa7Z5WNdKdf1jsqvFLZzSg1awHkDollqopO+5LNcJMFLnX+n8KpQiRPFUMbDXQC/U/1ytEHIKOkpvjsdkCuHaGJ6YC9NTutsGif9Lbq6jUJ1m9AKxTkiocYlRN4NY9yMe7LcgBueustYtlkbT/gD13TVN0eYg4kcMzpjfu57/dpngJNlEIc9DPhFcSkdwi2ZV0tPN06uEnw0d+z1BjGNdMlMOQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 15:33:20.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a7c68a-5feb-4a9a-2e44-08d828d46746
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4988
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


Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0347AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5CB20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TLWw5Emp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgFCOvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:51:24 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:33985
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbgFCOuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:50:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb1HLQeaEfaIRggTpF88E1SzLHsWNTu/58xS2C4SVZPiyxIAm9e8ZtsSg95kXb5M6bnk+kPsEVXNRlEUQy/lekljOCwr7ZDimURNvWYAr/VBZvAB7ku8eE3DvuiHTWYjXLeCWesSWKCuY0XEvl9oflXFkasbEiPRxd5GyI/+SpxjE1tieT3UOk7tzs+8l1jZmz2El7FO0MwR373xp10UyCzv3BzAijpgdEjuU7hlGAjsGpvHPfqWMlToT+1PNE14CYDk8fRf4HdWlmYjOW8eaXajd9jGohHfrdPMOAcT//PlFryKUhEsVHtYv1L4LYmdD+6+qy5VjrWDhWAcZy2zeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYl5ckkej4H4VDuk6jflAg2r97TSRYAxRRvj7jCldJo=;
 b=e+XRusDdVnGw4/Gofm7k0+u4EAaV78JSX4EFP3miaPkg1TRmCpWkkpzNznM6TxfIQR0JdwS57mCyEryVTPMkrv+PNGz/jPqpY6HYVlcoaPL9vYU2uAE2lc6BIBcbo0BF8U43CjUEc+2yIOvBcieJkhgez27PG9n4ZzCS9CGkKf4wY30Jcc527n8rO056N2v5HXbF3kydshEuQYfwKXIO/Wx0GDLOQP5WGPRGhXTg7/3s3SFjUzQNLtmO6fv0BD/MirmTJ6rcADPIlDXXol/Cyoep+A3D3Ln6DN13jw9OAMDT2XejtiUW1nSN5FMcgsfZzbNsZTKt1tz7wVlyhF8Ycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYl5ckkej4H4VDuk6jflAg2r97TSRYAxRRvj7jCldJo=;
 b=TLWw5Empxr/S+2jko32wgSSWYtOZ2BMFA4/EZMFzHWq9Os/eNKyP6hnkur0lk3aBGZI83IGlPrQR1fIlHNsXWmV4PuVOTb5BfjhG9O4j23EyAmH2mJGtzpDsvG73gN7HG1nwRt2PC6MClzbhf4m8MDk1cbqWYnAEICyk33qd6wg=
Received: from CY4PR02CA0007.namprd02.prod.outlook.com (2603:10b6:903:18::17)
 by BN7PR02MB5220.namprd02.prod.outlook.com (2603:10b6:408:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 14:49:49 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:18:cafe::81) by CY4PR02CA0007.outlook.office365.com
 (2603:10b6:903:18::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Wed, 3 Jun 2020 14:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server id 15.20.3045.17 via Frontend Transport; Wed, 3 Jun 2020 14:49:49
 +0000
Received: from [149.199.38.66] (port=60712 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUhS-0007GG-2F; Wed, 03 Jun 2020 07:49:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUiB-000515-Ru; Wed, 03 Jun 2020 07:49:47 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 053Enh9l017036;
        Wed, 3 Jun 2020 07:49:43 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUi7-00050a-Ba; Wed, 03 Jun 2020 07:49:43 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        jollys@xilinx.com, rajanv@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Wed,  3 Jun 2020 07:49:41 -0700
Message-Id: <1591195783-10290-4-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
References: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(39860400002)(46966005)(336012)(186003)(82740400003)(2616005)(81166007)(426003)(5660300002)(47076004)(44832011)(8676002)(2906002)(9786002)(26005)(36756003)(70206006)(8936002)(7696005)(83380400001)(82310400002)(478600001)(4326008)(70586007)(356005)(316002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e6d595e-ee5b-476a-82c1-08d807cd5da1
X-MS-TrafficTypeDiagnostic: BN7PR02MB5220:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5220CFF386F7B75B1167F1F6B5880@BN7PR02MB5220.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++9EIUCR9gqDMD6vpo3+qvGJwkoT7Y7v3Gkbp3zmua5I/yTsRYMfFhoNaBr+X5ush9Koe2tXHuLKEnfO+zAS1EMx1SDRQnSlVYaqsYOXbrG96yjNKs2NRi1IsLIxrFetGh60V/y6DhDVkkn7SL5qEWNEjKb+w+OKZ5jOqzK7YwaGTdaaKN+senNc5LwU3AMQb3+JfvjnYVt5PQQCR4tCIdfcgY3rmFNX/GeYlqD29yFFJdNF10NAzA5m6Yan062611ps6SNVgQO8lfzw0gF0or4wz1sqczPwnS4Xt+Jt2cNew3vZnRpRrvz1t28TSB9gJJvpyjuJIUnehE9sbM16qJXPykjIq9qux+0Dnuz2n7dUOH9mxhUtjFyJl+bLdTy4eewBILdE0+C4x39b0uFgzg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:49:49.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6d595e-ee5b-476a-82c1-08d807cd5da1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5220
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
 drivers/firmware/xilinx/zynqmp.c     | 99 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 34 +++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 16a8d69..20c1f58 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -845,6 +845,61 @@ int zynqmp_pm_release_node(const u32 node)
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
 /**
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
+/**
  * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
  *             be powered down forcefully
  * @target:    Node ID of the targeted PU or subsystem
@@ -880,6 +935,50 @@ int zynqmp_pm_request_wakeup(const u32 node,
 EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
 
 /**
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
+/**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
  * @capabilities:	Requested capabilities of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 4d83a7d..0caca9e 100644
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
2.7.4


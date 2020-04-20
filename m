Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1768C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04C520857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ggq4FD5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgDTW1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:27:32 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:11968
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbgDTW1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:27:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE+dKT3LjNAZ1m/13V79rNJUomxjAFqiRUkZPIYB5zV+SP0NcW/1SmcNf3IyKVOxgA5zpTkjL1uQ/ywEjIF5P3XsA+krgf4kZ7NRyICYsZdL+dXCMobvFYzjqk4cGVCOsFs/A4EPEe1Y9DvkpgiwOkHKWP8o7TVwAR8Bn11yo4rZY5urzo0CJtEikSyuMzQ6U0GhP6KWctEETO1+UoShNIB6uatHLoROfvcvIWcfD3r/IedSPk6XSt54GhH4BjfonzzxkSAV85YvtNRvGNgSl4I1QlHJ3TnKFRb/9nWECEh5nQ/gKIYXCIX64O8NKioy/TyYBGq1tFkGsVsKPqK9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMcdUtCd+taLzU6Exta5fz/sI5tSTkzUEmxEbVomjwI=;
 b=NxzZTTR5bwT9X6eujFMoCXIYI2e19NM3IURKTcyOP40GK+NPSXLSPdw1Nx+FE9UMiFhgL0AS4doxKfkmNf00fjwm5gdoGZecJYjXB7M6v+8Nq1/3rzbqoxggeIyJ+oJeUdirxqky+In9MVUXSGufs+7QVnBp1XYOashh+CJD3A2fbbD/lth0zoJrVQJGpNZw4zdvYxWC4jRP8FPaaKvbri8mJVTHfk7KfXXIBcbg+yC6tuxk1cdu/ir6FmBzi3AVpexwVkdIU4fkhMc7iwGKxmUxU/+48bxxkAuDoPrp1ibLibCts/tcNLrdUzkR/LCA3hjvM92xNDK3MxsNav6szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMcdUtCd+taLzU6Exta5fz/sI5tSTkzUEmxEbVomjwI=;
 b=ggq4FD5baBwS98qoxNYZq4RS4+hHoYHLPKABA8ZMJNX7tQJVdvJ3/MI3st77jrA1Em4gL6f76OM5otmu8YA4dOXVg6iNUsMeTo9zrGO64v/CJU3wUO6VmtYdX4NyJ1FdBf3BCbuwMKO+ydNc7gWHhEmzxQk5AkYei8CgsptvNmo=
Received: from SN4PR0201CA0033.namprd02.prod.outlook.com
 (2603:10b6:803:2e::19) by DM6PR02MB5833.namprd02.prod.outlook.com
 (2603:10b6:5:157::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 22:27:20 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::a5) by SN4PR0201CA0033.outlook.office365.com
 (2603:10b6:803:2e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 22:27:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 22:27:19
 +0000
Received: from [149.199.38.66] (port=33635 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQerr-0000SV-Um; Mon, 20 Apr 2020 15:26:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQesp-0008OD-3C; Mon, 20 Apr 2020 15:27:19 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03KMR9qT006356;
        Mon, 20 Apr 2020 15:27:09 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQesf-0008MN-Aw; Mon, 20 Apr 2020 15:27:09 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Mon, 20 Apr 2020 15:27:07 -0700
Message-Id: <1587421629-914-4-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
References: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(8676002)(478600001)(82740400003)(47076004)(70586007)(356005)(81166007)(70206006)(44832011)(81156014)(9786002)(2906002)(36756003)(316002)(4326008)(426003)(186003)(8936002)(7696005)(2616005)(26005)(5660300002)(336012);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4148b21e-73bf-4ad8-576e-08d7e579fcfe
X-MS-TrafficTypeDiagnostic: DM6PR02MB5833:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5833523A397F4B8B9B434E15B5D40@DM6PR02MB5833.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 03793408BA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkKv+QEQozatkYsTYEc9kQW7OV/skM1Y7Kt9c7BTIxlcggX0KkdsdPQBgU0vkAQmtEOKoX3vCWdG6AzRdddOnAfDWGxXxToqdkxBj0od02UPM9eBt6sM39YSS15LuhsFEDYYIEEPGg5OVIIki1iePL7HgUJgxYedP5VhvAY6dXywWQu9J7aYUlXEF3fslbr2JqNsYJbq8YQF8ZLmnYMb3mObmOpZjFrCpCJEdayPp5hqhXEOC8KnaezJEHAVJupajoR32Ul6Vj8VGA/h+PBNnzO1CJX9wc1qy/DecFrlZHZBhotk4cAv0K88l9LGPhybj8LrB+D5zgiZPHSFyDm6DSNnucW8Aj0sIHZPxeSnnwKKatzOYleuZqitsrKKY4h7dUI8LyHpl9we06myYHzQqR5PPYMIURp0eaF1u0PoP31xjEcmgt9rsChI6emmAwg9qUoi2UD9rM97Y+mTYQJfbxnFg5z9q3JwOMuWcx+806mUI8q9SOvMl3Ddab0wBxNzvZ2AmHT6+clLcB60LjwIeQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 22:27:19.4410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4148b21e-73bf-4ad8-576e-08d7e579fcfe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds APIs to provide access and a configuration interface
to the current power state of a sub-system on Zynqmp sub-system.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
changes since v2:
- add xilinx-related platform mgmt fn's instead of wrapping around
	function pointer in xilinx eemi ops struct
---
 drivers/firmware/xilinx/zynqmp.c     | 101 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  30 +++++++++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index b0d140f..e0a906e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -845,6 +845,63 @@ int zynqmp_pm_release_node(const u32 node)
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
 /**
+ * zynqmp_pm_get_rpu_mode() - Get RPU mode
+ * @node_id:	Node ID of the device
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * Return: Returns RPU mode
+ */
+int zynqmp_pm_get_rpu_mode(u32 node_id,
+			u32 arg1, u32 arg2, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				IOCTL_GET_RPU_OPER_MODE, 0, 0, out);
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
+			u32 arg1, u32 arg2, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				IOCTL_SET_RPU_OPER_MODE, 0, 0, out);
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
+			u32 arg1, u32 arg2, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				IOCTL_TCM_COMB_CONFIG, 0, 0, out);
+
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
+
+
+/**
  * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
  *             be powered down forcefully
  * @target:    Node ID of the targeted PU or subsystem
@@ -880,6 +937,50 @@ int zynqmp_pm_request_wakeup(const u32 node,
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
+ * Return:     Returns status, either success or error+reason
+ */
+int zynqmp_pm_get_node_status(const u32 node,
+			u32 *status, u32 *requirements,
+			u32 *usage)
+
+{
+   u32 ret_payload[PAYLOAD_ARG_CNT];
+   int ret;
+
+   if (!status)
+       return -EINVAL;
+
+   ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, node, 0, 0,
+                 0, ret_payload);
+   if (ret_payload[0] == XST_PM_SUCCESS) {
+       *status = ret_payload[1];
+       if (requirements)
+           *requirements = ret_payload[2];
+       if (usage)
+           *usage = ret_payload[3];
+   }
+
+   return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_node_status);
+
+/**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
  * @capabilities:	Requested capabilities of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1235923..c123d1b 100644
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
+			u32 *requirements, u32 *usage);
+int zynqmp_pm_get_rpu_mode(u32 node_id,
+            u32 arg1, u32 arg2, u32 *out);
+int zynqmp_pm_set_rpu_mode(u32 node_id,
+            u32 arg1, u32 arg2, u32 *out);
+int zynqmp_pm_set_tcm_config(u32 node_id,
+            u32 arg1, u32 arg2, u32 *out);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -546,6 +555,27 @@ static inline int zynqmp_pm_request_wakeup(const u32 node,
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_get_node_status(const u32 node,
+			u32 *status, u32 *requirements,
+			u32 *usage)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_get_rpu_mode(u32 node_id,
+            u32 arg1, u32 arg2, u32 *out)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_set_rpu_mode(u32 node_id,
+            u32 arg1, u32 arg2, u32 *out)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_set_tcm_config(u32 node_id,
+            u32 arg1, u32 arg2, u32 *out)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4


Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1887CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAA521744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fcNtj+7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbgGaQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:48:27 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:5025
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732684AbgGaQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:48:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr6LxN+ZTtUhK2X3+kRb0+4qwj1SB3qnpGVwG3FwagCPASO1sp6SylxOyMdiGJs5xIi56tHGPAOapTzbQ35tQZb0rR5U6AujiPEy8WC+aYwgEZXsdfQs+JxZLaCnkXpDCBQic+4wogfc7Xu4W398gi6IAOG2ELX9SQicBMA/TLCQkzQT+cRJEaV+IHggvnzbsvZQiWSpKoiWklUPP6ckNQAcdhb39zf+d9bmdE4Gh+oUTVCV51xzFgQSP5aA5rdoY2TYJk5yER0KhreuQAuacGxnJNV1+w1xKgYN89XCuQ9LyCnAuXkM2ZWA9u5JEJHjffkHy4gNUSISRWgMpGnNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB8T90onqd3S7zv68wweKUfbOK8XxI/y5My+BAK+764=;
 b=ezENBv3e/BYpeyvUVMqMOV+q4DJxogtl/duTiMYUbqgN5cU7d4S+6fJ+u0Kv7Qjteea5XxocmqYnp1VWi2UQKdwvOeLZ67MLUboQJ0EB9kXjCrM7SbmDFgmwEDKtGwKjIRUuLKo6p2cD2l8o2GW8vxP1DiX4iu0M9EZ7GmMv9MPdYQqa3digMgB7ZKsqv9DyCguX+XcB2Iucx6vOFvF5poZEC55D3nLg0tP3EkodWh06gTgAo/XKBFgMjhsKQk5erXhKka+ib3HJCDjhUvxZ6qdPyqKwM8z4buC4wxu4pj7ddb0KfAnFpwMB9jf3LHBytwporCAaUduS5Y68sIa9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB8T90onqd3S7zv68wweKUfbOK8XxI/y5My+BAK+764=;
 b=fcNtj+7WMXUOulcze3cc7p8QI7ahsw7RV3+Z9bdsA38H71UgZVVcPfXoZ62pQDdRG1QGKzelF/yTLoikaU4El8U1ja+UxHA4oJpga4UjkSaKpzlkHk83QguY7EuS1VqITYYg6NvHNcdXIgRoichbRq/+3uuzHpXITouBqCigjDM=
Received: from SA0PR11CA0062.namprd11.prod.outlook.com (2603:10b6:806:d2::7)
 by BN8PR02MB5730.namprd02.prod.outlook.com (2603:10b6:408:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 31 Jul
 2020 16:48:06 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::24) by SA0PR11CA0062.outlook.office365.com
 (2603:10b6:806:d2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Fri, 31 Jul 2020 16:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 16:48:06
 +0000
Received: from [149.199.38.66] (port=41021 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YAS-0006bv-Ho; Fri, 31 Jul 2020 09:46:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCU-0007o7-4I; Fri, 31 Jul 2020 09:48:06 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06VGlt1i021514;
        Fri, 31 Jul 2020 09:47:55 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCJ-0007jL-0i; Fri, 31 Jul 2020 09:47:55 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michal.simek@xilinx.com
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Fri, 31 Jul 2020 09:47:51 -0700
Message-Id: <20200731164754.20505-3-ben.levinsky@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 695a8b40-bdfc-40f0-b2fe-08d835717fc7
X-MS-TrafficTypeDiagnostic: BN8PR02MB5730:
X-Microsoft-Antispam-PRVS: <BN8PR02MB573099746CF11E1C37D0658DB54E0@BN8PR02MB5730.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEXSpoiw/TUUhc2h6YmzLQABtkqAiaNFYLU0dcuNbQdjwESXvGR4XYYwXN1wBuL82g9xParzVv+C99IFK6GG8vWTBeZK50No4eVcKI+Q/0Uo3+Tccy50xUxqQDhgmxNasCTpJeV1wQQXLhUXjmqRSzNXTibg//q5Fm5UmAIkr+Esu9ahg+xDuLv+8VxU35yRYjMs1/PaV85egYbAuJwh5jg0kCGBZzztRAcqk0Dxg6P3zhlZS3XAWKHh5eI8Jm4tv4eNcCZ0vk1F7tNCqt33Dz3X4muSjsA3hokddfJDv3dkGyKA2CTZ833AdG5RMtFuOyr6G+DLIfJumRFfwm7YcDX9r2YordSPiB8S6bMKHMw2YpUSWPEo7biflwcsFSFiAEaBtm70lQwfG43hEwVwgQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(396003)(46966005)(44832011)(9786002)(83380400001)(356005)(5660300002)(1076003)(478600001)(8936002)(6666004)(426003)(8676002)(82310400002)(316002)(186003)(81166007)(2616005)(70586007)(336012)(70206006)(36756003)(47076004)(4326008)(2906002)(26005)(6636002)(82740400003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 16:48:06.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695a8b40-bdfc-40f0-b2fe-08d835717fc7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5730
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
- fix formatting
v4:
- add default values for enum
---
 drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 22 +++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8d1ff2454e2e..f1a0bd35deeb 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -846,6 +846,41 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
+ *             be powered down forcefully
+ * @target:    Node ID of the targeted PU or subsystem
+ * @ack:   Flag to specify whether acknowledge is requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_force_powerdown(const u32 target,
+			      const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_force_powerdown);
+
+/**
+ * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
+ * @node:  Node ID of the master or subsystem
+ * @set_addr:  Specifies whether the address argument is relevant
+ * @address:   Address from which to resume when woken up
+ * @ack:   Flag to specify whether acknowledge requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_request_wakeup(const u32 node,
+			     const bool set_addr,
+			     const u64 address,
+			     const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+				   address >> 32, ack, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
+
 /**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index bb347dfe4ba4..4d83a7d69c4c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -64,6 +64,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_SYSTEM_SHUTDOWN = 12,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE,
@@ -376,6 +378,12 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
+int zynqmp_pm_force_powerdown(const u32 target,
+			      const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_request_wakeup(const u32 node,
+			     const bool set_addr,
+			     const u64 address,
+			     const enum zynqmp_pm_request_ack ack);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -526,6 +534,20 @@ static inline int zynqmp_pm_set_boot_health_status(u32 value)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_force_powerdown(const u32 target,
+				    const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_request_wakeup(const u32 node,
+					   const bool set_addr,
+					   const u64 address,
+				   const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.17.1


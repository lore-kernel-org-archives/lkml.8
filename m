Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDF3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF13F206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kGp6dZQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgIDOej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:34:39 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:8032
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730526AbgIDOcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:32:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFoM7NhtMAAsj2gjiCfbrTPvy6/WDhslwguPEzuZ3YepYJMlAtM18GMgkmaSG7BK+5fiEC6ddV91YsNjbrun1cZP+kAS2cgnY3UaNn1TeyY9HUILWz6t+Da142OqXWPrHlaCytIhyupMi7Kvdz68NZjGWRc7sZ3GYFmzi6It9BzZtWUXIzkRnn7peyo9OrTY8EcvhN357tQ+iuawWNwzqfZKUhZrcMdP4wqmxIzLrlkU8yeyh2AhYyVToLdl69rx4qBYPBP+NXURVMBRH8kIDy43DfJAzakiiLIj69bFfoVnlS5qIIDu7uCvsbJhqBs3hWvVS+cMp8EXZwS5wrFcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXlvvgkgk5NVtQWRNRs7Ng0J70lamUAT04M4qSPl4yk=;
 b=oDowIgNEXw9E0d1RiiR00uA1glr7k3WBJICvqOnak63H2XF+E4P5aIpPni27opyQlUeu+Mrnf584DZyRrj4Md4+vemaMyOSxCD/TrnZmzFL6Mz52wP3is+ms8YKprniW+7Ajdb1L6KBV2F8AsZIuTpCGEw2fI+RDxiUFCB2D283jRFXB45HnwVzOmzVX2FfcK2IyN+m3kQNUTXTkywB66jQjQ6VZ0zk5amTGU0M2o1Tun34PQHNjRHFciZwqQWPK0oJ8N0eywE+DvkIbly5oXg3+oj+vyXlrKNMovBIXVkFSQTA7MObdx/E/BghqutEdnZ/YhFMjh/sariDkVWH2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=toshiba.co.jp smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXlvvgkgk5NVtQWRNRs7Ng0J70lamUAT04M4qSPl4yk=;
 b=kGp6dZQEGea1dipRXkESWfMMlaF9xdQkfrmqUtQnAKb/hxWoeRw8shDUKLhEFjDdt62B3NLdd0S4LvJqLzz1N3uv0KYb/c2UpIiINByMJ3/NJSJCbPoH/2gaI93TQTgUmgOQVvNCxsp2E/6WWPhJWoI4z35YISXhOfH8nzFgcU0=
Received: from SN4PR0701CA0007.namprd07.prod.outlook.com
 (2603:10b6:803:28::17) by DM6PR02MB4426.namprd02.prod.outlook.com
 (2603:10b6:5:22::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 4 Sep
 2020 14:32:16 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:28:cafe::3d) by SN4PR0701CA0007.outlook.office365.com
 (2603:10b6:803:28::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Fri, 4 Sep 2020 14:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; toshiba.co.jp; dkim=none (message not signed)
 header.d=none;toshiba.co.jp; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Fri, 4 Sep 2020 14:32:15
 +0000
Received: from [149.199.38.66] (port=38230 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kECl5-0002aM-Tq; Fri, 04 Sep 2020 07:32:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kEClD-0003ng-Dp; Fri, 04 Sep 2020 07:32:15 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kECl7-0003lx-OC; Fri, 04 Sep 2020 07:32:09 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     punit1.agrawal@toshiba.co.jp, stefanos@xilinx.com,
        michals@xilinx.com
Cc:     michael.auchter@ni.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, emooring@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jliang@xilinx.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Fri,  4 Sep 2020 07:32:06 -0700
Message-Id: <20200904143209.31235-3-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904143209.31235-1-ben.levinsky@xilinx.com>
References: <20200904143209.31235-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa9a7b1b-40e4-4b37-194f-08d850df520c
X-MS-TrafficTypeDiagnostic: DM6PR02MB4426:
X-Microsoft-Antispam-PRVS: <DM6PR02MB442658E6F6425FAF1FDCBD95B52D0@DM6PR02MB4426.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uCT5oA8CLp9motORU4RAwhq/hfKaeAaSJ+oIUrkVEgtCBocRIYv/cWZVTsvNHENa1ao4YZThjucTUjAW9eI09vlhIhUK8CQvFy4BRb9qETIXy7O8uMtb2+aATUnJvgQn17VKKI9fIeyEDDBMn/Z1GGPUx6BKU2cAtKKuNg5ci+OuBTzYcEnRNP7P+sj9QQ/qvjDakS9/blc3RidESVVnqvxj78Hq5DhlsHcU2XJLUO6cieENMr6CISE8vY+Zhn2vl/7x8k5FuLNUSttnHDe/NpacITFjy8/qHYmSpj4jIwQAABi7jxjzYh0cG+f2w0Hbdw9jRQaOqdHR3CGcDOTDe03ewChHvjbPu5hJX/4qMnGDmGPIQRrIVuYd9f9BJ+z8OQ1HEB8X/uSwiGIinuWZQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(376002)(46966005)(47076004)(44832011)(5660300002)(6636002)(186003)(8676002)(426003)(2906002)(316002)(83380400001)(6666004)(70586007)(8936002)(82310400003)(70206006)(9786002)(82740400003)(1076003)(36756003)(81166007)(478600001)(336012)(7696005)(4326008)(26005)(2616005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 14:32:15.7268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9a7b1b-40e4-4b37-194f-08d850df520c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4426
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Note alignment of args matches convention of other fn's in this file.
The reason being that the long fn name results in aligned args that
otherwise go over 80 chars so shift right to avoid this

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
- fix formatting
v4:
- add default values for enumv3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
- fix formatting
v4:
- add default values for enum
v9:
- zynqmp_pm_force_powerdown update arg 'target' to 'node'
- zynqmp_pm_request_wakeup fix code style
v10:
- add types.h to includes for compilation
---
 drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 23 ++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8d1ff2454e2e..a966ee956573 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -846,6 +846,41 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
+ *             be powered down forcefully
+ * @node:  Node ID of the targeted PU or subsystem
+ * @ack:   Flag to specify whether acknowledge is requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_force_pwrdwn(const u32 node,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
+
+/**
+ * zynqmp_pm_request_wake - PM call to wake up selected master or subsystem
+ * @node:  Node ID of the master or subsystem
+ * @set_addr:  Specifies whether the address argument is relevant
+ * @address:   Address from which to resume when woken up
+ * @ack:   Flag to specify whether acknowledge requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+				   address >> 32, ack, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
+
 /**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index bb347dfe4ba4..6241c5ac51b3 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -12,6 +12,7 @@
 
 #ifndef __FIRMWARE_ZYNQMP_H__
 #define __FIRMWARE_ZYNQMP_H__
+#include <linux/types.h>
 
 #define ZYNQMP_PM_VERSION_MAJOR	1
 #define ZYNQMP_PM_VERSION_MINOR	0
@@ -64,6 +65,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_SYSTEM_SHUTDOWN = 12,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE,
@@ -376,6 +379,12 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
+int zynqmp_pm_force_pwrdwn(const u32 target,
+			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -526,6 +535,20 @@ static inline int zynqmp_pm_set_boot_health_status(u32 value)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_force_pwrdwn(const u32 target,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_request_wake(const u32 node,
+					 const bool set_addr,
+					 const u64 address,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.17.1


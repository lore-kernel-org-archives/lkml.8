Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1153EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC84020825
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UHTQ3hIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHZQNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:13:31 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:10208
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726745AbgHZQNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsN8maRTH2Dr86SINlvNxH50FQ9g0HzUM0jVA0eNaPa4MphVX+jS05XtM3kCqRHzxmhB8oq9zN+6YtveKPaRbzEh05II4TOTzEnQpaagM7v4xeqptgXHzw3B63O8zEbfIvlmIrGfCL2Dl0cirt4Tq4NEwqBR+wqnBMpYHens5A0yCIZDVjwQFqzzRULg9CVTeItx+8zJdOOizs6BPGR2v42NiAZXm2DiPTdqX5ffYYSE7fb5Nu3R5dMrhmm8lK+IoG3BwpY1igKnG3lkXk/rLVg6LvD45l8LU7nxOlqmrgQ3D20Mq3b3ZawRCrumF0fSdMKDHHo5LFec61paaYqZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqTbCe3dpv+gWa8rHs0aIySUpDViyb33kwND+NQDG/Q=;
 b=XRY1tWIywSXLdOXZ+d5azqZbbEAOPb/y2JYhwF31MDqXbHNszEcPqPamdMj9CCpQfw6eHfra02uRT+UwMM3uR4p1RElsSrAquLOg8av5d39xaFRaYKMJ1ndlCzjMSXGVOQLwxYnj5rHMHQRtGp2JkRPZXrP+uwMKc6Imn+bE4QUoyo8HyLSwum4NOM+XdIMF/2Eluu2WN+joLVEeuxqvHCvBNXDXr+7MI1Bd0AToEMsCGmb0z0HHKCbU67AAx8zBECK7vHxCNb/+RZQlr2mhn+YADHPeWf17tDxlTIktYKz3SYPzBKQ0n19St+OO3YcnpOWJ493sNCf0nI8qbXHT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqTbCe3dpv+gWa8rHs0aIySUpDViyb33kwND+NQDG/Q=;
 b=UHTQ3hIPPuDkdlCVaVBmIIng+L/4yE6qwrAbai9TKTNp3NgTvar8fBYahOanxHIMeu3YhvH2h+BvyFXETXfBQn6HRd/di4/2cRhdLeeKzC+/5lXciKvBe7YAt5bRQqZF2lByY+Ycn2bbvi3NAMqUONg89dzY3qlyOrvnPGFqxpU=
Received: from MN2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:208:e8::21)
 by BYAPR02MB4984.namprd02.prod.outlook.com (2603:10b6:a03:65::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 16:13:10 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::2e) by MN2PR20CA0008.outlook.office365.com
 (2603:10b6:208:e8::21) with Microsoft SMTP Server (version=TLS1_2,
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
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 16:13:09
 +0000
Received: from [149.199.38.66] (port=58613 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2Q-0006a5-Fb; Wed, 26 Aug 2020 09:12:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2v-0008BQ-EC; Wed, 26 Aug 2020 09:13:09 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2t-0008B0-Nm; Wed, 26 Aug 2020 09:13:07 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        michael.auchter@ni.com
Subject: [PATCH v9 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Wed, 26 Aug 2020 09:13:04 -0700
Message-Id: <20200826161307.1064-3-ben.levinsky@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6c44996-d797-4a9a-fd3b-08d849daecd7
X-MS-TrafficTypeDiagnostic: BYAPR02MB4984:
X-Microsoft-Antispam-PRVS: <BYAPR02MB498415AA1CCCBDCC09762618B5540@BYAPR02MB4984.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMHrSkDgb7tf9upRvC9m91zXdxTSZdYl21bHjm2M0wQRaOO9POZ4SXYmJ/qmRQiMH+lY5OEQK9Zioss+H3Ti1eMCmtXxDkdNydQ9fiJMpChtFX31QDg02BEFLhjUTUYTU98pvYhs4zj4lH0vrTZHxpqQt66VFEG1XQ6fyJYGHW/RI718fOgSmbccX7MaMjOt6ye9u3fM61wMBUjDaFGMsMYGEddfgXAB728CF4XOVl2WxXt/igOYLCgJhJ0zHWRm7hN90EJk5RY0g1pPkUGmOsBQftYqDiU9CFxAOCCj/SOrHqeQwXyXtD3LVfkpBKGwkPoynQvb5I8ucFCGTM2cnRZ6X84PQ3/tjK0Ef4hpfAagDtZAyHUd8rTbgIqqkVWLpI5hR/fcISbDhJe6+XDYhw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(346002)(46966005)(36756003)(83380400001)(2616005)(316002)(8676002)(47076004)(4326008)(8936002)(82740400003)(356005)(9786002)(2906002)(82310400002)(44832011)(81166007)(6636002)(6666004)(336012)(186003)(5660300002)(1076003)(426003)(26005)(70206006)(70586007)(7696005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 16:13:09.7971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c44996-d797-4a9a-fd3b-08d849daecd7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Note few things on code style of zynqmp_pm_request_wakeup and
  zynqmp_pm_force_pwrdwn:
- in editor the args are properly aligned and this is reflected in that
  when running checkpatch.pl --strict on this patch the "arguments not
  aligned with open paren" warning is not raised.
- the reason the args are not aligned is that the patch adds the '+' sign
  to the args which eats a space in the whitespace resulting in seemingly
  misaligned args. once applied, the args should appear aligned in the 
  file.

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
---
 drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 22 +++++++++++++++++
 2 files changed, 57 insertions(+)

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
index bb347dfe4ba4..1f92ea99ad7c 100644
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
+int zynqmp_pm_force_pwrdwn(const u32 target,
+			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -526,6 +534,20 @@ static inline int zynqmp_pm_set_boot_health_status(u32 value)
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


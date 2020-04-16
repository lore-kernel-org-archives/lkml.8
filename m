Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E2C38A29
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF4D218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pSCTufUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgDPVy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:54:59 -0400
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:12255
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbgDPVyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEQySly1d7gt7loUwO9VwQZdP/PMe1kaoqAai6lUos3kZPtTmsCArBTFI4g35Us+QSY5rg6Y/9bVU99BHBfPNgu4/UHSnka33IO3CSFRVtH/ltzX8mwTpqnBblJmf8DO6X5xSvqpfZSiWSlRViukU2MjQCR+L958eOFMzq6foAGoyVhkxCfm4bIf55MoUguI5INQmtP9m+iihRParsC5LdBuhdRDU5sgFoIfQBjJoOl4QPnBKJ306hBr/SD4MNB5hGBV8RdIF8bOSHDSPkwuxm/AgQ6pgUO1KjqiktQjbUyCRVGF0zjPZyAY26A3Xk+CW8QZ3+bv0Qdxufba+tt/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btZsUjCsTfExWUXR0J03tvhl+ASq8g/KU1R/B1avt0k=;
 b=lR7imA2LJHJYGbZ8TSsGzZl13vbQLKXg0c9XItuQeQxgySD0Mq8567Q3ylh/yDvspl410BM1jYnAdoeuLDIbqwP0xedVnm/jsL/wykBSTSiB54ejvqxFblG/73ndCtdzzL3hoo59NmamIMwOhFE//6sVdfgN+WHmgPuOzg5G5gXw72ne9GCcCXeq+x0wWNnDpUZCu28vE1J65aDloVyEosutDtnFYHTSfsiHwplInje+II0NB1IT4JIn8GUioaeAgqHmWrMMe3h2lmfKlp/pFjQd0Xy48CA0ltET5+whgEvAbS+lhlTS3rMFDoDgl4cNux9VKy9YNQUwza0d9LLrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btZsUjCsTfExWUXR0J03tvhl+ASq8g/KU1R/B1avt0k=;
 b=pSCTufUjJ8JtnMPYMN7aoVtrb7BOv1xPZ89QFjuE4HwtOllMCvXV6G1+mWZZhN5KbgkF9/N5zo6km793FMmUuzul05Y9n9BIP9MHaBo94+QZtrgCweFX7qJouVsVhVx9bVjd5d6LqsxHHzH2BKhtq0Aj6rG6p3fF2UHkqN6vu7I=
Received: from MN2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:208:234::14)
 by CY4PR0201MB3620.namprd02.prod.outlook.com (2603:10b6:910:92::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 21:54:47 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::a1) by MN2PR16CA0045.outlook.office365.com
 (2603:10b6:208:234::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Thu, 16 Apr 2020 21:54:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 21:54:47
 +0000
Received: from [149.199.38.66] (port=38396 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCSN-0004cb-I2; Thu, 16 Apr 2020 14:53:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCT8-0003e3-OR; Thu, 16 Apr 2020 14:54:46 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCT4-0003cm-7Y; Thu, 16 Apr 2020 14:54:42 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] firmware: xilinx: Add zynqmp_get_node_status API
Date:   Thu, 16 Apr 2020 14:54:40 -0700
Message-Id: <1587074082-14836-4-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
References: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966005)(8936002)(5660300002)(82740400003)(8676002)(47076004)(7696005)(44832011)(4326008)(336012)(186003)(2616005)(9786002)(81166007)(81156014)(70206006)(316002)(2906002)(356005)(26005)(36756003)(426003)(70586007)(478600001);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ff81d40-e472-46b3-d9b7-08d7e250c7b0
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3620:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3620F531780DA4F69D2EDA8BB5D80@CY4PR0201MB3620.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0375972289
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvzI1/bSHh7+aJaJEBG+bKToV90p/Or4ZSeqqeg3olIClu05P1qkSTfo0K9mYg9L2aCiy3MdRt3PJpvlySXzkUdkl7hcXZsIOpwF3Jx8p072/mcjZhHg8Tf1cZsVn2PUOjRr1QJ+M29o2GJQ9JoT7Xe4iwQwLH29cwgA1d//pgTZkxocGDSCCHBBVJsk15bM9Eq2yGfTZsYcrBjmo7zkM0xscKSgxbGlrZba5vAOMcKeIDapj7NU1yLRJCgElBdhfeHpcf97dgiYyqkrVIoefTNYjYYcQAtzAXnyOJaSgJsesWP9NzludYs94I+ird9/8DreHeh1xjfeJQPGr6unC1vhMet687mPAyIOQ7NU8XyjXjBJQlzqGOHsih+prI41D58E1PfkvaZs+6RsOEMeENhBkzfttPE2KppKDr/p/jSKzMt+F1J+xvfuw4NUW013mxmDX99pTlxXO+RbGrCt4CBmnJW1kGhCMEiRVsXaJuQcEFUBOkyN9O0u/2BgzDWCu+XaUr2VNpI1MNsKWI1rmQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 21:54:47.1611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff81d40-e472-46b3-d9b7-08d7e250c7b0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3620
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new API to provide access to the
current power state of a sub-system on Zynqmp sub-system.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 42 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 0a545a2..be7e460 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -727,6 +727,47 @@ static int zynqmp_pm_request_wakeup(const u32 node,
 }
 
 /**
+ * zynqmp_pm_get_node_status - PM call to request a node's current power state
+ * @node:		ID of the component or sub-system in question
+ * @status:		Current operating state of the requested node
+ * @requirements:	Current requirements asserted on the node,
+ *			used for slave nodes only.
+ * @usage:		Usage information, used for slave nodes only:
+ *			PM_USAGE_NO_MASTER	- No master is currently using
+ *						  the node
+ *			PM_USAGE_CURRENT_MASTER	- Only requesting master is
+ *						  currently using the node
+ *			PM_USAGE_OTHER_MASTER	- Only other masters are
+ *						  currently using the node
+ *			PM_USAGE_BOTH_MASTERS	- Both the current and at least
+ *						  one other master is currently
+ *						  using the node
+ *
+ * Return:		Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_node_status(const u32 node, u32 *const status,
+				     u32 *const requirements, u32 *const usage)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, node, 0, 0,
+				  0, ret_payload);
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
+
+/**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
  * @capabilities:	Requested capabilities of the slave
@@ -773,6 +814,7 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.get_chipid = zynqmp_pm_get_chipid,
+	.get_node_status = zynqmp_pm_get_node_status,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
 	.clock_disable = zynqmp_pm_clock_disable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 899febc..0ed7e9e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -62,6 +62,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_NODE_STATUS = 3,
 	PM_FORCE_POWERDOWN = 8,
 	PM_REQUEST_WAKEUP = 10,
 	PM_REQUEST_NODE = 13,
@@ -317,6 +318,8 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*get_chipid)(u32 *idcode, u32 *version);
+	int (*get_node_status)(const u32 node, u32 *const status,
+			       u32 *const requirements, u32 *const usage);
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
-- 
2.7.4


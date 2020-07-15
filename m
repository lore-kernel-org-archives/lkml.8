Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D8FC433F7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00F2206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LeHaGUVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGOPdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:33:39 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:2912
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbgGOPdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmAzyLGCkyLacGV3/t1Yx9+dazTVDOZ31/m+GmDCsoHHPDMS9HwDxNpnXGYjCrlwq9ydfRQuej+WveQcIqgWWrWSPaPfjIhnVzwx26SQHorpptmH73chRtwM4Aob2GJjqt22YxzqMXAr6rLsaLspUkHSZmv1SgmaV8ss4TsKO6RfuN+CI86C3gonL7gmozn+7i1RPPxGL+3mNEiBxhsJ/+wmDl2fBBzUIad7SCGRRqJQqdawidjjlSKyZqtzbpAno6XhhVhM7N5KAdaoDge5qmtQ5ff71NJnvQe6RA32dWOLMFa4kZt6RjZX3MdzowDBVpxZuLoHIntC8Aut68l4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB8T90onqd3S7zv68wweKUfbOK8XxI/y5My+BAK+764=;
 b=d3jiVigVECE97r7t7R/osd/wyQ52uI3lah+0S8oI69jL0Oj1VbA0+wESwudB2T4X4B/QdbxeF6kowCbjuIn0IUlmcjkUdgSCythjv5T4cBLLSySmjms5bdxxEWsxJj3X6pSnZ0QWJ9IvtGwTMmzcxU+IpE4flxbLoi5+TtLZMmo13e3O3uvMoTEnQYh8ed2UvAAiVYBV1nzLlM9owFRrECPd8RSnb0zBg39eQPVyFleamr87BgcUx1nkC3Y35o2GcgEb0IHmf7aASjiBQBoLRbIP5Ntvn6wS7Dr4+Vs+DsiG31E5eWL2DP8DImK6+J8hBrN6RqhrwtwQPtIPZsDwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB8T90onqd3S7zv68wweKUfbOK8XxI/y5My+BAK+764=;
 b=LeHaGUVU8kVxFNiQw8y83GWoPXcv2dpLYh0LtWZeM7dTiUD3/Qx39cP36r0Rupo4UAvAbewlPaVncw4s+UnpZDMJqWnAhJoxEdwCY27ZdxYbqzUty+CeShYSwzJiiO1xJ7gBc1HExaXMXomosRJ2gbNhwajN721SdKxyA1ZPAzM=
Received: from BL0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:2d::17)
 by SN1PR02MB3775.namprd02.prod.outlook.com (2603:10b6:802:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 15:33:21 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2d:cafe::b0) by BL0PR03CA0004.outlook.office365.com
 (2603:10b6:208:2d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Wed, 15 Jul 2020 15:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 15:33:20
 +0000
Received: from [149.199.38.66] (port=39385 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjNh-0005fU-FI; Wed, 15 Jul 2020 08:31:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPM-0007rZ-An; Wed, 15 Jul 2020 08:33:20 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPJ-0007qz-N1; Wed, 15 Jul 2020 08:33:17 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        JOLLYS@xilinx.com, RAJANV@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        stefanos@xilinx.com
Subject: [PATCH v6 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Wed, 15 Jul 2020 08:33:14 -0700
Message-Id: <20200715153317.25643-3-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715153317.25643-1-ben.levinsky@xilinx.com>
References: <20200715153317.25643-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(396003)(136003)(346002)(46966005)(36756003)(9786002)(1076003)(81166007)(70206006)(26005)(82310400002)(356005)(186003)(5660300002)(426003)(44832011)(83380400001)(82740400003)(8676002)(2616005)(336012)(70586007)(107886003)(2906002)(7696005)(4326008)(316002)(8936002)(47076004)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 991af7e6-0f1c-4532-caf3-08d828d4677a
X-MS-TrafficTypeDiagnostic: SN1PR02MB3775:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3775B21B0094FEBEB7A522CDB57E0@SN1PR02MB3775.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1/yqN3nTZ3vPcWa8ye3Hy858aRT0Tqq+y9dF2mbZ/eFUBHlhBTrffaUgfeIuqElnBOz09302X/pAL5h+h1GT88rzi/GxNSJ8kyOLj8Txa014VZeyi9m6oysTohJaSOsJ9w02oUv7V7/9JsW2XVWDRFPOiKBcgn3Este7iCsupIq1UUIwQvfRTkTM74XMv38zKKQn4jkrh+Slp/xCpvH2h41tSKVa0oYKvcKxXnNAEHnm20zPWbwQpcy4i56UbcMYINgypJ3Klfy+3Bb/PhKrEVLGPJIJ+IY5dIlneBb9SN/cjmGvore4WVMnbPOFBfg0GJw8+z9OrN5yhKJI3kNMa/7QFWeBKh9b5+Pa5gTDhR5GxR/nIPQXMzKWutzoezF579668lrjkJcTa6b2wE4ZQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 15:33:20.7073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991af7e6-0f1c-4532-caf3-08d828d4677a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3775
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


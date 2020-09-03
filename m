Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95B6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC815206D4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lqRZLUsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgICVX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:23:27 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:36928
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728037AbgICVXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgm8HEa0GhHjW17rpcQH1MMVitaAbvV3x8SddS1AxG86judhtYPM7OePD51GwKSXLo/leqXz1Z9ssUI49273/n8n9N/uCDoiijGOoAw5Q3gduINqeN+z0m1srFfJmKurup5pZqB4vTU7xmIiW2iCxAjDUADZbkjc7jJwqIeW1MzYIMXM576EtIprw6SuPA/ZaNVTs9kUy2xyXu4s60QYlXyjw4A6v7Db/xEa+O2tK1dlkVqAwdBJw/33Oob42UER6W3jAXWJ7eYNeohiEDa8afKUTUuNwH+eO2pI5moZmONK9Qp+2LYGnU+Gs1+96OFBM8gF0S4FPOh6L3AZgy2N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oylXQrBpZxzeyQv8gsEA43cVwV/ECuvHJODeuIS4DXU=;
 b=g0Jt7u9PiR3HSfo9PXPOfu20h8a15cOvwVu2XXX4kYh1dYVj5I3q/RhESu3FG1WvO0ZgCdvuZ4zEKvzIMUdkfz00DVFyAOhNoAWema8p510JBZ7ZD/AUFjcvPc3IDKchFbhpNdfleWWzxPPu84Vy0rG683KZiX97pLqlOl+SnK/ogFiO4EuAd8i4JcZln4R28RI3yUPBVFc/n51ZFsuDp3xggRWuzRuuaIgN8vOFqm5MfAgYSgYN+C/ExMBRcfnF1flPjQdG7zY6jgUG9zALtwJAGOmubVznGkkKGuRi7igc1fI/0ok1HZNT3BS8yYr6QjVkyV5su7mjsQCkeTN6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oylXQrBpZxzeyQv8gsEA43cVwV/ECuvHJODeuIS4DXU=;
 b=lqRZLUsL1+ghTbrRR6z/p3G77DHSWWr+BtKYqdbndXZrisHQUI5UT6QUJnPTZbxQgUc0xXLjwF7my229Dy150zBydE/vcIT/PmC1cW3TG4GGWQFqcxH59z5k5vxR9EfNXvLOo5SQynYJVIfjSal6kZAZCH8jk8EuwVNOUCr3/Uc=
Received: from SN4PR0701CA0010.namprd07.prod.outlook.com
 (2603:10b6:803:28::20) by DM6PR02MB6010.namprd02.prod.outlook.com
 (2603:10b6:5:157::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 21:23:16 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:28:cafe::a3) by SN4PR0701CA0010.outlook.office365.com
 (2603:10b6:803:28::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Thu, 3 Sep 2020 21:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 21:23:16
 +0000
Received: from [149.199.38.66] (port=37608 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhJ-0006to-JQ; Thu, 03 Sep 2020 14:23:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhP-0000OF-Tr; Thu, 03 Sep 2020 14:23:15 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 083LNAJm023393;
        Thu, 3 Sep 2020 14:23:10 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDwhK-0000M3-9I; Thu, 03 Sep 2020 14:23:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     punit1.agrawal@toshiba.co.jp, stefanos@xilinx.com,
        michals@xilinx.com
Cc:     michael.auchter@ni.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, emooring@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jliang@xilinx.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v12 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Thu,  3 Sep 2020 14:23:08 -0700
Message-Id: <20200903212310.17990-4-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903212310.17990-1-ben.levinsky@xilinx.com>
References: <20200903212310.17990-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8af75dfe-be2e-491b-2981-08d8504f926e
X-MS-TrafficTypeDiagnostic: DM6PR02MB6010:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6010E0D145D8A180A8DFD535B52C0@DM6PR02MB6010.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:179;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zy4EETx+HPb0AecanH5IY6i8M1w1SqJfjABimj6r7t+uL0Dl4c5gMciF9Q7TMfdILu0USjwMB62s+5g68WF1TnIVcenLkE6vsJgqX44JFUS09ID0Prw9xYVk+90B2nD4SqWJOSYhjX0wJI7qCh6rXaWFraAcLavKXH2Yn9LDMfRw//ZRSOC+G2G+6GX7/BQ3btVwbbkz5TMxje+mmqmadK+ZAbFGDfVe7k6nLJvu5zFaubEYA2CaHnI3vt2b6ovrPtQZ5zLwtqySaXOz5Dcr1s+zhvChCQ4eDOzdna4KuSqRofZ37GXRIGCJT5Lx6L4TuD401U7w9hBB9/VZHO3C+b4b2t4ZzuOo6YuJROBA283PZ4fbY6ZtaGHqY2JPElrAEEpHWmaivvFtdz1+MaajnkIoHCvBwekPsWu6n8MPd+c=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(396003)(46966005)(82740400003)(44832011)(356005)(8676002)(81166007)(4326008)(186003)(478600001)(7696005)(83380400001)(26005)(1076003)(70206006)(2906002)(70586007)(336012)(6636002)(316002)(9786002)(2616005)(8936002)(82310400003)(5660300002)(47076004)(36756003)(426003)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 21:23:16.2146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af75dfe-be2e-491b-2981-08d8504f926e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds APIs to access to configure RPU and its
processor-specific memory.

That is query the run-time mode of RPU as either split or lockstep as well
as API to set this mode. In addition add APIs to access configuration of
the RPUs' tightly coupled memory (TCM).

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
v4:
- add default values for enums
v9:
- update commit message
- for zynqmp_pm_set_tcm_config and zynqmp_pm_get_rpu_mode update docs for
  expected output, arguments as well removing unused args
- remove unused fn zynqmp_pm_get_node_status
v11:
- update usage of zynqmp_pm_get_rpu_mode to return rpu mode in enum
- update zynqmp_pm_set_tcm_config and zynqmp_pm_set_rpu_mode arguments to remove unused args
v12:
- in drivers/firmware/zynqmp.c, update zynqmp_pm_set_rpu_mode so rpu_mode
  is only set if no error
- update args for zynqmp_pm_set_rpu_mode, zynqmp_pm_set_tcm_config fn arg's to
  reflect what is expected in the function and the usage in
  zynqmp_r5_remoteproc accordingly
---
 drivers/firmware/xilinx/zynqmp.c     | 60 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 18 +++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a966ee956573..916a0b15ab33 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -846,6 +846,66 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_get_rpu_mode() - Get RPU mode
+ * @node_id:	Node ID of the device
+ * @rpu_mode:	return by reference value
+ *		either split or lockstep
+ *
+ * Return:	return 0 on success or error+reason.
+ *		if success, then  rpu_mode will be set
+ *		to current rpu mode.
+ */
+int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
+
+	/* only set rpu_mode if no error */
+	*rpu_mode = ret_payload[0];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
+
+/**
+ * zynqmp_pm_set_rpu_mode() - Set RPU mode
+ * @node_id:	Node ID of the device
+ * @rpu_mode:	Argument 1 to requested IOCTL call. either split or lockstep
+ *
+ *		This function is used to set RPU mode to split or
+ *		lockstep
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
+				   0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
+
+/**
+ * zynqmp_pm_set_tcm_config - configure TCM
+ * @tcm_mode:	Argument 1 to requested IOCTL call
+ *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
+ *
+ * This function is used to set RPU mode to split or combined
+ *
+ * Return: status: 0 for success, else failure
+ */
+int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
+				   NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
+
 /**
  * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
  *             be powered down forcefully
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 6241c5ac51b3..79aa2fcbcd54 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -385,6 +385,9 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const bool set_addr,
 			   const u64 address,
 			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
+int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
+int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -549,6 +552,21 @@ static inline int zynqmp_pm_request_wake(const u32 node,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.17.1


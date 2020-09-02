Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFA7C2BBD0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F1520767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="A8LzlsRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIBQ7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:59:55 -0400
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:58721
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728524AbgIBQ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6WBMkbx5jNCpQXfYAu0QEuQ9s/ehyUqrOpNfQwZqPWk9KBgGm+hBo+H2N7e5bvijkRZQgAJZqxb+vXeoGd/WNZtSR7lCljHkXkMC2YZL3xelMH21XSszxdZAE5KNYT+JRzJeZ7nNgvghdZnZWKCLNTXH6dZOFEnPjjCRrOyiRhlPwgzhZ38+yjyFYyXKfLt9VvYhPhGS7zjrk3l1sc8TYXw4kHSbsi0asVyA1nMPeSdX9GtvhwiSI8KYHqWGf4lSI6nwA1fKaPXwyYZ7ra1Q1Yp6w5rlTrrnQqCeoqG3rnNaHLAJcNpW0BdL9i4tR19MgQvDYZkjvxJ5yTf4gkd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhqvm0voVhweIetU2uC6OvJ2OF0sdb/aGeERsFi2rCU=;
 b=UlQSQRDNU4II75utkCma6GQ+UMtImw0epsWYgbLNfC8wMCozn5Gy1q0WJlNDVvuA9bCsib5KlFmAt6O6HvLXKQ+NOOIFY2QLcft4N/PPE2lPtvYgOs7aMX3wt2z1OxAMR947VWCcYfssi7UexIhsTWDl5GPOV4x/jtm78PdpfY3s2xXLwtK0yXilsjZYNUlR2/zBS3XONKR7884IKabT+VtR/vj11TgxtpMSD+djxyEFTmU2lQQG1qm3HoGTfEUY7jB0JRqhVZiWsVW90UixfyaKbWFJ0g3wCHcvFLJYvw3sWRKqbCU+AYYFUFO0C2V4qDiisYlmVCg4+PqxglSVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhqvm0voVhweIetU2uC6OvJ2OF0sdb/aGeERsFi2rCU=;
 b=A8LzlsRCJpt+MLXyXwMO0R9oqsbSCPElwP5zaACr4xGOj214+AgnInS7S+tIibSrvKT5vkNcq0WUsLc39dzV4WLk/bYrgKmmqDMtGk9BPorIxaZ92WgbM1Q3ro9KJa7b3ZxajXT5lMNvrtn/UMSAzDaFRgJWbesz2+SABg32+ks=
Received: from SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) by BYAPR02MB4789.namprd02.prod.outlook.com
 (2603:10b6:a03:46::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 16:58:51 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::27) by SN4PR0501CA0034.outlook.office365.com
 (2603:10b6:803:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.8 via Frontend
 Transport; Wed, 2 Sep 2020 16:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 16:58:50
 +0000
Received: from [149.199.38.66] (port=52911 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5u-0004kc-0o; Wed, 02 Sep 2020 09:58:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5y-0004Hg-Jr; Wed, 02 Sep 2020 09:58:50 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 082GwkE6003913;
        Wed, 2 Sep 2020 09:58:46 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5u-0004H9-DP; Wed, 02 Sep 2020 09:58:46 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefanos@xilinx.com, michals@xilinx.com, michael.auchter@ni.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Wed,  2 Sep 2020 09:58:44 -0700
Message-Id: <20200902165846.3366-4-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902165846.3366-1-ben.levinsky@xilinx.com>
References: <20200902165846.3366-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 640bac6a-71d9-4d35-9a43-08d84f617790
X-MS-TrafficTypeDiagnostic: BYAPR02MB4789:
X-Microsoft-Antispam-PRVS: <BYAPR02MB478969A9CEF686A76E585BC6B52F0@BYAPR02MB4789.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:205;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18bW6T24+kjNYJ8ADOWbZofxmpIrULtrkx5vMyfhB2DPFWcTTT2kl/gBdCVkY04nfcTL/qeVmoj1rl9z1BmRDs1Aj0gWY1m3JGH8MAy4D4N4FODxPvq6s5HHGCtSputdEf4+Bd2dM9zzftJSJm636vIoMmsoVJXE5rO3wnT/YS6g+kbftwkw6JxQKgGcTWjxhUNzcTWoQerp7XURd1VBYd3XxAnUKmslLwj8XeGuqNb8Vok/d8rQ1LC7thrDG5MqYoKK/u5nwzxnBKIFSdcovGCmBVZLhPZqvd8nFKghxPXJMrSoabwkOas41c1yzrys39JWwyCZRCD18et/Phc+zYZfAhcGCIy1zn0/HKt3ig5MfeXaHtH/5EYaSi/NL/iwqC5e+M4gQY2tquAM9QY4Qg==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(136003)(46966005)(44832011)(7696005)(70206006)(356005)(36756003)(2616005)(2906002)(82740400003)(47076004)(4326008)(316002)(9786002)(70586007)(26005)(186003)(426003)(8936002)(82310400003)(5660300002)(1076003)(336012)(8676002)(81166007)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 16:58:50.9222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640bac6a-71d9-4d35-9a43-08d84f617790
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4789
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
---
 drivers/firmware/xilinx/zynqmp.c     | 59 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 18 +++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a966ee956573..807e404589f8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -846,6 +846,65 @@ int zynqmp_pm_release_node(const u32 node)
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
+	if (ret < 0)
+		(void)rpu_mode;
+	else
+		*rpu_mode = ret_payload[0];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
+
+/**
+ * zynqmp_pm_set_rpu_mode() - Set RPU mode
+ * @node_id:	Node ID of the device
+ * @arg1:	Argument 1 to requested IOCTL call. This is expeted to
+ *              to be value from enum rpu_oper_mode
+ *
+ * This function is used to set RPU mode to split or lockstep
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_SET_RPU_OPER_MODE, arg1, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
+
+/**
+ * zynqmp_pm_set_tcm_config - configure TCM
+ * @arg1:	Argument 1 to requested IOCTL call
+ *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
+ *
+ * This function is used to set RPU mode to split or combined
+ *
+ * Return: status: 0 for success, else failure
+ */
+int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_TCM_COMB_CONFIG, arg1, 0, NULL);
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


Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF80C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC4820736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tedTUoJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgDXRgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:36:38 -0400
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:29476
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728732AbgDXRgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:36:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/kszrhg8FNctmeUZjL3218RZ40O9dGM3adVnBxtbjRyoODOy6MaCiHu1qW6fRMAVTeQzQB8ZFyxzdECKl02bglXTIL96vq/9yULLif7J/qrlxMwjAhcZ3UK+oawdl0lrYo13wNfw74Ubk34PlCygP08ctpQoG8cewFoLhT+VoUAG21UHanhqUKwBQdT3LREQHGyHmOS4fqq9wcmDGmw+6mAWDb1tcszL4FHjJ+d7sZJkQhRSxojTIhrBbDuGxpJCAltzPn8OgN+x0h1gqH5uNoysjmH2j1rZrR03jVLyhMEMR0LZSVRGo7aB1V/9RxNo7puMRUIwV3e9cCIxm9NaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qD58fp4Riwb2wvqzecDl5BbGSm84drgIQJ1mXWwED4=;
 b=hg0u5hRosLNAPRV2dkqJ3QMHAT/Oa0TfvT4+/1ZcSOjjLT21b2BQDe+y8Ar/a9tdfbMAqHSO07aE8RHrve4QiKnpTa/8N+bl5e54XQ1ErJQQKvU6Zp4LWrslZlBcFLTdg9jgwRbK1DXb3megWUDucpyx0M8osMwBMSmtVNeszHeiPheOh02Z+Z9h1jz/NrexA8xKYawdHpUz+zOOAPHCMQraZl2Fa105jHDhutifiNP6s/2ESfeX9ppXD3fEPl+Jaaz4CjKrWT8ygZVCrwFNNYQBeiQJXivBaAdARaR35yGdZPtpbj1fj0zZDLjZ3OBYSX0SgkARytdRDMinVuQqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qD58fp4Riwb2wvqzecDl5BbGSm84drgIQJ1mXWwED4=;
 b=tedTUoJZ24JtLyGvivluiEEEocH3WAr3vHRIr07BEtmRnHUlIbEz1uBlscroNWQHhDiEYx3+gYq5WEF//gl/dzf3Z+OxcKTb2m76IDRWyZij5g3uI7zm7pQ/C3WBVrwtmcLdulajmS+CnNlQNKjtqHlNYaNX1BG9T3A6x+2SqKk=
Received: from SN4PR0801CA0024.namprd08.prod.outlook.com
 (2603:10b6:803:29::34) by DM6PR02MB6825.namprd02.prod.outlook.com
 (2603:10b6:5:21a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 17:36:23 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::eb) by SN4PR0801CA0024.outlook.office365.com
 (2603:10b6:803:29::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 17:36:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 17:36:22
 +0000
Received: from [149.199.38.66] (port=41728 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jS2EJ-0005BO-Nq; Fri, 24 Apr 2020 10:35:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jS2FS-0006l0-9C; Fri, 24 Apr 2020 10:36:22 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OHaAmU026366;
        Fri, 24 Apr 2020 10:36:11 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jS2FG-0006h9-SI; Fri, 24 Apr 2020 10:36:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Fri, 24 Apr 2020 10:36:07 -0700
Message-Id: <1587749770-15082-3-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(478600001)(2616005)(6666004)(26005)(47076004)(44832011)(2906002)(70206006)(8676002)(81156014)(9786002)(8936002)(186003)(4326008)(336012)(70586007)(36756003)(426003)(81166007)(316002)(7696005)(82740400003)(82310400002)(356005)(5660300002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 513ebff1-7af9-4383-ad04-08d7e8760188
X-MS-TrafficTypeDiagnostic: DM6PR02MB6825:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6825DCD3CB30E5353B8A1C3EB5D00@DM6PR02MB6825.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YycdCJ5oXL7OmYzoDEtsWXGJ61Eu8NcOntP60htN+iKWoC374ouJ1lLO4LPCv6/eelaiMQgi7oGc0S7Mslcar/zcJmlQZhsaNiiNTHrojx65Nwue0aXmgi5CaXqbIXWPH0PZi0+Yiu1ch83993zU4QZoPvIHmB+OpImH/cf3k4s0h2svIdgNcxSQZBNQP+xvzdCM/TVuGLQRPB/RCLo6W/joIuN6NZRwWJxAfAZkUryJ7YNCQox8+8IIQNYmI1vT9uGe6EixRvBjel9YPGwsFjenzYWtH1VVbmejWaC7u63s4Wj6sHbkr0lrbWy/JLW/UNuiPGBaYQSQcKSrXNS00tRpz3ozsmNtSupn3ISBdElVJ/iZ7xi2pwhwk7yi+KCtAswyeBfVhD0tQc2reraBWUcy8X6cly7M3D5mkZ0c//NvPvFRhV2VTPz9dS8RBhwt5XsY2KjyCviY5AYev+WLi00/C9z+2OPijWEuTgiyTcG0KxRjVTg2jND//vGKhV54PC/f4h5HXYUi+Q+mKDACA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 17:36:22.5613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 513ebff1-7af9-4383-ad04-08d7e8760188
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6825
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
changes since v2:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct

changes since v3:
- fix formatting
---
 drivers/firmware/xilinx/zynqmp.c     | 35 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 22 ++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index bfaf29a..16a8d69 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -845,6 +845,41 @@ int zynqmp_pm_release_node(const u32 node)
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
 /**
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
+/**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
  * @capabilities:	Requested capabilities of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index bb347df..4d83a7d 100644
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
2.7.4


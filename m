Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8130FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549DD20870
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tV3He+j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgFCOt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:49:56 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:48480
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbgFCOtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:49:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aboRRrYBM1/C7xeI6qbOmKlU75XI9Os4amhx8uxj9F5l1rdaF30awNx8QDAmuuK24Cs+jtG71sX1K48JY5RmciuR+0WAMSjl5R+Gsk4wwbCKvEqpVd3tKIRM/GVuj9rLFWG6UUQ3aY8U0ZZDvQzUY1r41U4EdvcIFFs20alRrPe2i4xkNELf0Zy+Fn2zrv3JBmySz1fopDujQaXU+YxyqzvRHw1sNzkLgUbGTliFQYoQZRDmfzOnkfwyQx+i53gt16um+WgR0FTk7QLTT60ufTq9zLGQm9xaXLBPOurbhrHqEDmneJdgsdQhUoqmIZHquoJNy9+Ze9iyarFIHsFrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqcdlYUE0p6+UUX9oGk0yalGR+NExs6gxZr79U8oEpo=;
 b=Dwi8qcuEvmrQiY2TPbdH1Os02jifaKcluR56nRqyC28MVQX5BfYCe8ArsMWqQFjSx95EY7IEZN8WysOrmlfWOqlWPVjmswLcIL/ZuNxxYxzZAajEAP6SHP99woiIBScjpBQsj5sKBFgVduhbaoR/bsQbjh3d8Ui3vZB7+iy692+P0a+H84cQmFGQHuBb4kqqLQQobxHBeJl2KDTixoMGobypJ7eY9xmaZTkgf5jbVDVc8YX4D8YpqN+sfAyr9pzNwVXobCE5fiHk5NC5evzpcdUjbRJEtDadF6EXTp9PMc4QsI8s9WqURgTRTlN7gzXy/uSeLh3He3vBwb9Pl9+kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqcdlYUE0p6+UUX9oGk0yalGR+NExs6gxZr79U8oEpo=;
 b=tV3He+j5D7VnYtGo0bT7h4/seGilun4oInLZ0Q2knWhiG9XpiWppwaZBwL6liVjz8Sf3wa/pmXqWnfE7odmwC4vX65wvV7X23xqWQ9CnQXsfNk4sae5s6UbRe+EqrCYVvGKqgpHJ9FNoKnIIlBpjsXxZ9T3gOwbvYPfbg8NRF94=
Received: from CY4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:903:18::23)
 by BN8PR02MB5730.namprd02.prod.outlook.com (2603:10b6:408:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 14:49:49 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:18:cafe::58) by CY4PR02CA0013.outlook.office365.com
 (2603:10b6:903:18::23) with Microsoft SMTP Server (version=TLS1_2,
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
Received: from [149.199.38.66] (port=60722 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUhS-0007GJ-5A; Wed, 03 Jun 2020 07:49:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUiB-000515-V1; Wed, 03 Jun 2020 07:49:48 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 053EnhKt017034;
        Wed, 3 Jun 2020 07:49:43 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUi7-00050a-9o; Wed, 03 Jun 2020 07:49:43 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        jollys@xilinx.com, rajanv@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Wed,  3 Jun 2020 07:49:40 -0700
Message-Id: <1591195783-10290-3-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
References: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(396003)(39860400002)(136003)(376002)(46966005)(8936002)(478600001)(2906002)(70206006)(316002)(426003)(186003)(9786002)(2616005)(44832011)(7696005)(26005)(82740400003)(8676002)(336012)(70586007)(83380400001)(36756003)(47076004)(356005)(81166007)(4326008)(82310400002)(5660300002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f2e86298-31f7-4458-1ef0-08d807cd5da2
X-MS-TrafficTypeDiagnostic: BN8PR02MB5730:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5730083C6C418DA2EDCFC259B5880@BN8PR02MB5730.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zb6Hx6d+vhHwtcd25TDZOIkyUSvYsyBHFHU8qzNKTTo4NKCuvlx5gs10ki2H3xxGp21pWIqrsBiAcMsteQv49p6OTisU831pKZUaUCzAebfYf+DJ40JF/ax/yHuiMpzM5BxZFp6zludg2RI9mgFG3Y0LZvOEY3SvsKrYeFx3iq7lBSJIazTIH4qQS3H55911BB+PMdvP2MdqzZKG2PPbz+Ni1yr8eRdnBoYcqaUwBKfIwJtjLsZPYwidIK6vzH0q61/o1PAa5aY9z6qMHHjwUeZV/dlvH7niQtoSRiC2m13jtd5GG609UKNFeArnh59Z8nroZHq16DMwDT3ZqxaRuRup25yzKXnELZqeCqbTiXRB5ICVA9YT8QQWWu6XFTiY+ZYQlT4FGOywtU9AprwHEA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:49:49.3401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e86298-31f7-4458-1ef0-08d807cd5da2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
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
- add default values for enums

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


Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5406C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96712073A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UG5SiY4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgH0B60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:58:26 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:38405
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgH0B6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1TEF0jkULSCIyWFFEqhX1o0+8PHhszkPr2AXAxAZBXyUPIrL8GzjimpqT/M464VWSXxeov8e8gF6KXmVle0hZ3C8R3m0Q2YnGDNNqoc535/WOUZPFf1OKZbUVIZujPA5VmhrBVxU2EnI4j6gl8dvn+s8BCjYrQj6DXXEBfbeH5GLCGQUeFo2toTpDQUZPqOIZvfCrwmqi1mSxGOmiuxPV4SUh1/9ELgYwLwXDcZf3/eoffipiah6J4uVcvJgTbOKrBgNPxi5MyOM7tdmgiBz4ed/rPUHtdZCoFkEG8TAj3kyJyuWDNr2R/a7zlionFK+k1sh7bg0kjS3VPdhi65zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXlvvgkgk5NVtQWRNRs7Ng0J70lamUAT04M4qSPl4yk=;
 b=igKyjotl7SGZjJ7TYowwwlk3CqucJhhYYN9yN/TlK1KQ/1shNiKSms35XdsPJycL1CVp6zsgN0eIGSwOElS0mXQKW58C4OMK7gm5d0yOfzjX2H5RML03k53t0bv+wCuuj0zX5wY7Vn0dqFnTt5O75cvcz3EgZWbx25dyeHD4utTEjM4f+8jVPuedF16I1+n5TxaXe63sdxX/8n6r7h8IShWUtM1rllHAODFlRN/zOXc/EiT7TPX6S72gS9GkPT5biPuLC1Krh27GEVTelU24A5kSKyaFAh99JkoWuRgnzhsOawkxUS30cL49b+3DIHfRDgzYKdfARdKZd3ldu2ny+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXlvvgkgk5NVtQWRNRs7Ng0J70lamUAT04M4qSPl4yk=;
 b=UG5SiY4+FX/z/Iq6nsHvx4yPTJ2YhSo3eA772Yu9vYQLfCfXSkgyhwnwM/IJVTzs5lnnQztk+GvK7WzRumZOsBeFtx9wwoWQ0p3LwuZnmD+Wr+TQyjQtGtokwxLSrDy7sqjWXXBNwiv818tS6rDUB9mG8B1UgchM9qaFXTia/HE=
Received: from CY4PR06CA0060.namprd06.prod.outlook.com (2603:10b6:903:13d::22)
 by BN8PR02MB5860.namprd02.prod.outlook.com (2603:10b6:408:b5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 01:58:15 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::f4) by CY4PR06CA0060.outlook.office365.com
 (2603:10b6:903:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 01:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 01:58:15
 +0000
Received: from [149.199.38.66] (port=58684 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7Ad-0002AI-BC; Wed, 26 Aug 2020 18:57:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7B8-000183-Uz; Wed, 26 Aug 2020 18:58:15 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07R1wAvP015258;
        Wed, 26 Aug 2020 18:58:11 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7B4-000155-Re; Wed, 26 Aug 2020 18:58:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com,
        michael.auchter@ni.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Wed, 26 Aug 2020 18:58:07 -0700
Message-Id: <20200827015810.11157-3-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827015810.11157-1-ben.levinsky@xilinx.com>
References: <20200827015810.11157-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85b4dcae-1dde-40e2-c5ea-08d84a2ca951
X-MS-TrafficTypeDiagnostic: BN8PR02MB5860:
X-Microsoft-Antispam-PRVS: <BN8PR02MB58609855E40823C88F273C0FB5550@BN8PR02MB5860.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCTEus/kxynyssKIjLjwLD46sMdS095cQvCSF+XtKrZCIdvXOiqug60jnSccCkPPMpXSiN6egzPSPwYlJ6qL74G33rS7DFbjRRh2R8C4jE0s/Edp4XYslM50HvUdyHKWDdtq6qfWF9yFRV0I16+8tITcdhfGawEIn1ZVRJd4OIRi+x7jmKlhFyNtzHNe5cUDJCCf+8ubzDVH//TcO96drhFvMGQjAAD0Q3JsyKm+ZyhC/TVI81uHeaFqBZELzAYqeoenm7DXQ4UL2YuEgXGsb/BGqRG/TzRqu9USJp/MAJh9JYS+01PpA/hAXlw+ZVe7wkzCUg3mjHKuhszmzrvdNnBfi2IieKz07wRVqrJdfPYU16rK8HS55YgyTwv3IFYFfrsWQs4oQR0MDuYFkM2GoQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(136003)(46966005)(1076003)(44832011)(186003)(70206006)(70586007)(47076004)(8936002)(4326008)(6666004)(5660300002)(26005)(36756003)(9786002)(82310400002)(81166007)(356005)(478600001)(8676002)(2906002)(336012)(2616005)(7696005)(316002)(82740400003)(83380400001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 01:58:15.2430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4dcae-1dde-40e2-c5ea-08d84a2ca951
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5860
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


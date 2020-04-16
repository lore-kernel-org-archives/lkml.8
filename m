Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB2C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06025221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AD4PwM9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgDPVyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:54:52 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:6176
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgDPVyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFWVBSn1CyCLkTlvWGknEuoiBWnP4Ur6L/QbPQl9BkNC5hGuz7ahEQZvC2Fwj0afO8/invLeAqxuZZeNEJypYRsBHWILf2ncezI7kIod+nzfYPs+Jf/5pot91lZlAEpuqen7OzWmEI0CmIxhbLf/VYkoPNjjawNS5uMcfEDFTNR/D2szGfQQnXpJK79t/p7BbLg+sWvNQjYTWNy0HnJ694tzQ5h5RJU8QCDHaUabY8/7JFYYyPgD9dQBE9EAdhK6M02YQ0yAkaiDnxDoLEopMzxIPh++S9OghgFyRyaEe6TshMNcLaKtQaSPvV/RshxRv9ycJXaky//fy9GDSnfCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WqrD7LBiBunrsj9HOaj53bxUwVO+GIZjl21Y89+zUY=;
 b=nS1mK4OmvfSQG1Txyl5yAKSbgR/FpmqEbH06NMhC3bMFLY5WEiPdxXQlZmiB5IxWjxbWIKmUmHtAr7bjixsDg1TfQBhcefYQs6z4KRgLvgi1AXW2UU+uo4QenWIJBlZmKMxMNyaqAtmfSXEbKBFzl/XjoZOlHRp795+wZJDKpT+EZOmt4TgSbwH2ALcHd0Mz93sPMALBpIItWT24Oy2CevmENlnHfEapqh9CBWxLd5+sox0++EpKVaI5CPgqygY+sXUL2lhdce5LOfDkB9rYBw8+/IOLeypwrjW0ZaPQ0/nHcEjkgdPpFHlKTbza9VkzN2o2Lll2LtQBbYsCzHVngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WqrD7LBiBunrsj9HOaj53bxUwVO+GIZjl21Y89+zUY=;
 b=AD4PwM9N/zTnfZ8i6PZ7y7S9rx5W0aFOCpuWwvdLsKO/mEZG7t+UaFYE74RupCRujY1Kp5JaDdqPyppIXWCevwrXSvBtWztaJNhf46XxaCp4R8PrJZduxvG1sVMqlfHmpsObDos3IIYxagnv1eFzOyyG/I6DoihSNmZJwcZx1Nw=
Received: from CY4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:903:18::26)
 by MWHPR02MB3359.namprd02.prod.outlook.com (2603:10b6:301:62::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Thu, 16 Apr
 2020 21:54:47 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:18:cafe::7c) by CY4PR02CA0016.outlook.office365.com
 (2603:10b6:903:18::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Thu, 16 Apr 2020 21:54:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 21:54:46
 +0000
Received: from [149.199.38.66] (port=38374 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCSN-0004cS-8T; Thu, 16 Apr 2020 14:53:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCT8-0003e3-FH; Thu, 16 Apr 2020 14:54:46 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCT4-0003cm-7B; Thu, 16 Apr 2020 14:54:42 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Thu, 16 Apr 2020 14:54:39 -0700
Message-Id: <1587074082-14836-3-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
References: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966005)(81166007)(186003)(2906002)(4326008)(26005)(9786002)(8936002)(81156014)(478600001)(5660300002)(8676002)(36756003)(356005)(6666004)(2616005)(426003)(336012)(70586007)(316002)(82740400003)(7696005)(44832011)(47076004)(70206006);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06bc6204-b084-4f5d-293d-08d7e250c784
X-MS-TrafficTypeDiagnostic: MWHPR02MB3359:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3359D810DBA828039B41208BB5D80@MWHPR02MB3359.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0375972289
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOwAXies5VhjaJtr2QE4sWZHEl9XeC4intJ3FDQ63o3wvaySP/uyDtEdb4TE514gcTVsdgfHy2aCuKKyu4Z8JwPTt3hGnaDAZU0mFuHDO39wWbLVvokc08NMkiiIIxfQuWZlP1+UmgM5dHD/wsoZdE3BoYvKRpTYIUHK/eKxqWKm3vtRxyXFgko6L+3F5092fu9lCP3CFsSjLB3yhIbtRIlJ3Xs+WgUQLQgQG8NmOt4IVSGFsasXXM4woPBkYrw2aXeWkyQMYPJA1asGDtalR5w9KS3Jzt2D6iPYXg0up8tNxlJBqjO9D/MkCPieeyH4QYMuPN84LAgPsSvbluntCwzFwNxFR1nw1CaawmiSzBdAO2zU0VMoG3GcJ/eOKkg9pLa7/3P0rjzyx5q2SHGRW9fsUXfcCk96V9rko/yEl3nM83wDUYW4dGBBk/qw5RDVDQCcVwdgU5dNNYjRZUPnkoHNgctwTzYLW8LW9xnLvUzlfMd5zZ4FM43XshNDiqXGHhpHeYnNfNgywI4+bS7Org==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 21:54:46.8672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bc6204-b084-4f5d-293d-08d7e250c784
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 35 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7978065..0a545a2 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -694,6 +694,39 @@ static int zynqmp_pm_release_node(const u32 node)
 }
 
 /**
+ * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
+ *             be powered down forcefully
+ * @target:    Node ID of the targeted PU or subsystem
+ * @ack:   Flag to specify whether acknowledge is requested
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_force_powerdown(const u32 target,
+				   const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
+ * @node:  Node ID of the master or subsystem
+ * @set_addr:  Specifies whether the address argument is relevant
+ * @address:   Address from which to resume when woken up
+ * @ack:   Flag to specify whether acknowledge requested
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_wakeup(const u32 node,
+				   const bool set_addr,
+				   const u64 address,
+				   const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+					address >> 32, ack, NULL);
+}
+
+/**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
  * @capabilities:	Requested capabilities of the slave
@@ -750,9 +783,11 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.force_powerdown = zynqmp_pm_force_powerdown,
 	.ioctl = zynqmp_pm_ioctl,
 	.reset_assert = zynqmp_pm_reset_assert,
 	.reset_get_status = zynqmp_pm_reset_get_status,
+	.request_wakeup = zynqmp_pm_request_wakeup,
 	.init_finalize = zynqmp_pm_init_finalize,
 	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 	.request_node = zynqmp_pm_request_node,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index ddc996de..899febc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -62,6 +62,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE,
 	PM_SET_REQUIREMENT,
@@ -338,6 +340,12 @@ struct zynqmp_eemi_ops {
 			    const u32 qos,
 			    const enum zynqmp_pm_request_ack ack);
 	int (*release_node)(const u32 node);
+	int (*force_powerdown)(const u32 target,
+				const enum zynqmp_pm_request_ack ack);
+	int (*request_wakeup)(const u32 node,
+				const bool set_addr,
+				const u64 address,
+				const enum zynqmp_pm_request_ack ack);
 	int (*set_requirement)(const u32 node,
 			       const u32 capabilities,
 			       const u32 qos,
-- 
2.7.4


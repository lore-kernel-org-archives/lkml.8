Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8B2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E56F2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbiEeQDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgFCDnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:43:07 -0400
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:24647
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbgFCDnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngCl2HXW4MuLVbjS7+E+GG6R24f5dAJ1CSu6BJnSt9bxx5W09Aj6OTHBvuPbpX/5tj6Ozw9WFZfHDgFdajZYKD+JUxN0RVfdE7TXTE56OE/Uf4lTbhYos7283s2CauKnymnbyHb8E5dYrcMxNYAqZnJ18oNsuOn4CGOL7PUCcOUpQuX6QrJiR++viEijjWT4kRr8YxPKSfoLhxxnFt0i8dqfS1vXDGLD7w/2J2G/589XlLzrF7FY1i83sgKn3hgSRfJ6IrmQwaBa5xfP18MMgv+otT11k0Ea1zmCHcnWRCgMZxN1TZDh3ddR8GlB2PwGfbQfHXeFF8peKAU7BlBEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y6KmzpjnZPMeLFffH3MdwziMO46EBAKN311oQe/mxg=;
 b=oWr+8s5dfKzO+7CYC6OAJvxgf3a3OqMKTQOXVR4T8rsZacjJrlXCJI/q4rsTipoVVC0HdvumSqOULSu2/F9mje//jWTZd31ginT57+kBpv3upFkPHT3ak6xvD94aew7eqwVqfneWuLdLnmGK7SuQUQHrQoYtKv2B/bDWS29C5SA8BKLzjN1oGgEE9eHQbXku/O/vxXDOmASmUB26YQ6NTLAyzEd9WXl7ROQMN66tNLB2a6ypjfOMtsSBJCjPN5Cg4dBlu8r6PDlc0sWBYn0CUCsDY5Yeq4zGH8e3+48G7OyPZDsD0+aKZaODm6CZb052YB5Rx+iwX8GMVopte1KG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y6KmzpjnZPMeLFffH3MdwziMO46EBAKN311oQe/mxg=;
 b=cbiEeQDJc3lyUbkmJJM8oOtKOJdNJeBoFIphv92t65d0TQsnhjrWilev216C0LKLPt9kvL4K+lj7Wyef8lV+FQml5KC+ZbtAaKogONOVe91/EsXzH76y03NNobRJINPtI4TlEDqK+DDZEjiw0jF+YUjapHeAxcq3/dN0E54S6tM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2854.eurprd04.prod.outlook.com (2603:10a6:4:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 03:43:01 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 03:43:01 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/3] firmware: imx: add resource management api
Date:   Wed,  3 Jun 2020 11:32:22 +0800
Message-Id: <1591155143-25972-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
References: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 03:42:57 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 863b12bd-fd28-44f3-61ef-08d8077036f9
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB285408CF8CC6E43866C9F99688880@DB6PR0402MB2854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcp+D0Z4iypFVv3DEMsxNls+OAEg8WYWxCi0uKL+MqvT8WSNkY+D5RpJ1nzcqY8h5V/tQTLkq6tJht2Vr9UUy750ljnPQM4qW1Hxatxjs00Zi81fAMK+EwshaxfM7Z5Ty6vMLKyZwj83b5R1d3pCcdVfndq4voU1Nob97qO0PYwffDVQGrqDbLR9jPd3JCTRbOiygw8e4vIjYBylKc/jJxxDj1T3pcQzerzwc7q/w8mXEmxjLMSYCdlBZ14xFIoaqQ6gnEIB7EyrTXprhHjxYy2zNDipt85IQZuGEsbm0yW4T2R1F7WYQfABzuZ3W9ewk0CWr6NdWal7iPlQzTBNb/5tpHhpa2mGYrtbpH5MqTquVtirxOWnNUrc98blfVmd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(6506007)(478600001)(186003)(6486002)(36756003)(5660300002)(26005)(66476007)(66946007)(66556008)(83380400001)(2616005)(52116002)(8936002)(16526019)(9686003)(316002)(2906002)(956004)(6512007)(69590400007)(4326008)(8676002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DO+M5lqxL30eJ56xLSaiA/QB7QLu45mElOw1IuB+WjMo//lpn1mh7rFilrE1OTL7ec8jpL4i2Ak2AHDPNEYpww87FaRY4eMnQiEYKfCIRy0308CyO/tZSm6JnQT+M5esS87GQRw2A4faewgBF0rxayim6fPnvDTntqPzlswSVnJ0f8/Vh1iFf0RdkWiiXiAmHrVEH1JjD1DN8Wa9YDs5PRMmgtYEoUYMkzyKtrAIL8QQUhAlKZ7X3boLa6tVTD4aSf63pohvcVHz0KsXBDfDSrFW4jdaxqdXBHnPe0lMHp9Rh3Vr509LYA4lRE8JcFDiufLq5xlCajXMGC3/Pd1ugJbvd45OAPXu7kmvvNwwCUfkqm8LIyOa1hu+2K9djrQkzPODztjHrjd6Aj+BRVZ753XtXKPXFJVlakTyUgIdXX7dWHiaY46IEFK5F3gyAEqLdNl9JeVJ3m6fB8TM7bzObA/leAK4geVmgonJzubVVAjWxC6CMN2tU9Y8bsPTwWsF
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863b12bd-fd28-44f3-61ef-08d8077036f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 03:43:01.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HonasEbFPA1Kuw7zFv40u9lMviM5msWX0HmkrIMkoEGCwFqjt+YCLaIp3JTpCrXPDPSnWNyUzsIyV4cLZWUlDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add resource management API, when we have multiple
partition running together, resources not owned to current
partition should not be used.

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile       |  2 +-
 drivers/firmware/imx/rm.c           | 45 ++++++++++++++++++++++++
 include/linux/firmware/imx/sci.h    |  1 +
 include/linux/firmware/imx/svc/rm.h | 69 +++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/rm.c
 create mode 100644 include/linux/firmware/imx/svc/rm.h

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 08bc9ddfbdfb..17ea3613e142 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/firmware/imx/rm.c b/drivers/firmware/imx/rm.c
new file mode 100644
index 000000000000..a12db6ff323b
--- /dev/null
+++ b/drivers/firmware/imx/rm.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ *
+ * File containing client-side RPC functions for the RM service. These
+ * function are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/svc/rm.h>
+
+struct imx_sc_msg_rm_rsrc_owned {
+	struct imx_sc_rpc_msg hdr;
+	u16 resource;
+} __packed __aligned(4);
+
+/*
+ * This function check @resource is owned by current partition or not
+ *
+ * @param[in]     ipc         IPC handle
+ * @param[in]     resource    resource the control is associated with
+ *
+ * @return Returns 0 for not owned and 1 for owned.
+ */
+bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)
+{
+	struct imx_sc_msg_rm_rsrc_owned msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_RM;
+	hdr->func = IMX_SC_RM_FUNC_IS_RESOURCE_OWNED;
+	hdr->size = 2;
+
+	msg.resource = resource;
+
+	/*
+	 * SCU firmware only returns value 0 or 1
+	 * for resource owned check which means not owned or owned.
+	 * So it is always successful.
+	 */
+	imx_scu_call_rpc(ipc, &msg, true);
+
+	return hdr->func;
+}
+EXPORT_SYMBOL(imx_sc_rm_is_resource_owned);
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 3fa418a4ca67..3c459f54a88f 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -14,6 +14,7 @@
 
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
+#include <linux/firmware/imx/svc/rm.h>
 
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
diff --git a/include/linux/firmware/imx/svc/rm.h b/include/linux/firmware/imx/svc/rm.h
new file mode 100644
index 000000000000..9924216f3e45
--- /dev/null
+++ b/include/linux/firmware/imx/svc/rm.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2020 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Power Management (PM) function. This includes functions for power state
+ * control, clock control, reset control, and wake-up event control.
+ *
+ * RM_SVC (SVC) Resource Management Service
+ *
+ * Module for the Resource Management (RM) service.
+ */
+
+#ifndef _SC_RM_API_H
+#define _SC_RM_API_H
+
+#include <linux/firmware/imx/sci.h>
+
+/*
+ * This type is used to indicate RPC RM function calls.
+ */
+enum imx_sc_rm_func {
+	IMX_SC_RM_FUNC_UNKNOWN = 0,
+	IMX_SC_RM_FUNC_PARTITION_ALLOC = 1,
+	IMX_SC_RM_FUNC_SET_CONFIDENTIAL = 31,
+	IMX_SC_RM_FUNC_PARTITION_FREE = 2,
+	IMX_SC_RM_FUNC_GET_DID = 26,
+	IMX_SC_RM_FUNC_PARTITION_STATIC = 3,
+	IMX_SC_RM_FUNC_PARTITION_LOCK = 4,
+	IMX_SC_RM_FUNC_GET_PARTITION = 5,
+	IMX_SC_RM_FUNC_SET_PARENT = 6,
+	IMX_SC_RM_FUNC_MOVE_ALL = 7,
+	IMX_SC_RM_FUNC_ASSIGN_RESOURCE = 8,
+	IMX_SC_RM_FUNC_SET_RESOURCE_MOVABLE = 9,
+	IMX_SC_RM_FUNC_SET_SUBSYS_RSRC_MOVABLE = 28,
+	IMX_SC_RM_FUNC_SET_MASTER_ATTRIBUTES = 10,
+	IMX_SC_RM_FUNC_SET_MASTER_SID = 11,
+	IMX_SC_RM_FUNC_SET_PERIPHERAL_PERMISSIONS = 12,
+	IMX_SC_RM_FUNC_IS_RESOURCE_OWNED = 13,
+	IMX_SC_RM_FUNC_GET_RESOURCE_OWNER = 33,
+	IMX_SC_RM_FUNC_IS_RESOURCE_MASTER = 14,
+	IMX_SC_RM_FUNC_IS_RESOURCE_PERIPHERAL = 15,
+	IMX_SC_RM_FUNC_GET_RESOURCE_INFO = 16,
+	IMX_SC_RM_FUNC_MEMREG_ALLOC = 17,
+	IMX_SC_RM_FUNC_MEMREG_SPLIT = 29,
+	IMX_SC_RM_FUNC_MEMREG_FRAG = 32,
+	IMX_SC_RM_FUNC_MEMREG_FREE = 18,
+	IMX_SC_RM_FUNC_FIND_MEMREG = 30,
+	IMX_SC_RM_FUNC_ASSIGN_MEMREG = 19,
+	IMX_SC_RM_FUNC_SET_MEMREG_PERMISSIONS = 20,
+	IMX_SC_RM_FUNC_IS_MEMREG_OWNED = 21,
+	IMX_SC_RM_FUNC_GET_MEMREG_INFO = 22,
+	IMX_SC_RM_FUNC_ASSIGN_PAD = 23,
+	IMX_SC_RM_FUNC_SET_PAD_MOVABLE = 24,
+	IMX_SC_RM_FUNC_IS_PAD_OWNED = 25,
+	IMX_SC_RM_FUNC_DUMP = 27,
+};
+
+#if IS_ENABLED(CONFIG_IMX_SCU)
+bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource);
+#else
+static inline bool
+imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)
+{
+	return true;
+}
+#endif
+#endif
-- 
2.16.4


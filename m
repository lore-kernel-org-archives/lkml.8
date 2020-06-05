Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F082C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FB5207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="socc6IEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgFECKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 22:10:48 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:45569
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgFECKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:10:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfobkIiaPvqvWXHof5G1sD6EyyD33BRwl+T/OQh8H5v5DoHnwNrccVHiksQ1hSGE58NEMY1/SwQPj0hlQRqYH5ckbkDShZE5iFndz9d7y9ATsFiOx+QTiDvTBcOiQMp6cYzHsq1xMT72TLCFJ/Kyid7VPDYtiVHtE8NhWXv5Bl1hCmCGri4jMmZn4z7w5e/yhKr/pd4CyOlDFR/JjD9OxIT5zOUs7X7Qs+w4pTvYCvO4cgPqLb+o1fWKS+Pld+wzbKcEBbJXY/w0fXVQ6MChbGjhDDcmWSrowZEp6tD5h6fAWWPYttiZtvYNGI0QOkZL8OR3PQ+C/WhMnzlVlWuJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00IQ+fLa14IEg9epmEfUz7KLdhcVInmjMAPLVLEoYxM=;
 b=DIKVHUFNAHWxOJfMOVVW/FCCY0R46sakISsZN6JpcwOJoJbtkoKbpUNxy5BnU45tqoK9Ogt2JPP0Vfi7uv1XdCpRbnTXbONiMiV/sdOKNsKqRQigry3W9S0V5b/6Se34dmdXNoXo3MHQyGYnvbUQoYdr3UVj+x8GdeY9NU32WXzhD1/u8ay2vFTVX2CzXQ3yTcli0XCvDP3qeYr7kyoAeZvxm8nfwcWRJg9ehrPRwCMKUBSUa4TvNZb1SChkKXieLzLivx7HiRaFCB1ROYK4o/1H82DgTK0KJYK1COm0TVVSnV/J9EL4MwXG0qXYauO/ys13olEKD5nkMaUhvKFwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00IQ+fLa14IEg9epmEfUz7KLdhcVInmjMAPLVLEoYxM=;
 b=socc6IEV2AtXdBLy//STAMz4NuhEVGdF1084WYDZ3ZFLzqElWNuxTgvttj9Ge82yZ6MzRBUp1RCHRsDVvMM0Y+GDvCFwTFN45gGA0rEDQ2ovP7Yd9pKrVK65NIxEEA8CW80mVpLAQBfYIAyoOt2d/5Fe644kZ5PMgYhyNOxdFsY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2696.eurprd04.prod.outlook.com (2603:10a6:4:a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 02:10:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 02:10:41 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        franck.lenormand@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/3] firmware: imx: add resource management api
Date:   Fri,  5 Jun 2020 09:59:31 +0800
Message-Id: <1591322372-3793-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
References: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 02:10:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c50392bb-02d6-4d3b-5645-08d808f5a596
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2696453EF00A4D1F46DF8C6188860@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9zdnLMXA9mM0dCP8SHZY3uhqpDV2RoSnahCzw0OG33wXm4+ZHUV9O8I5IAwP/XjplI4N9pWS1H8e0v/7FkOlbw8p/XWso3jlb2d4YgvXl3rwWUBjzqfFLBsZ5zKNw/QHUyDwJ6t7SGCn/2/BdKcmU+72w0YAuMrgQzfjTgGkwYrliERRUswmMycyjwgiOzrPQQ7dK7eckKGTIMkID+TnIdTbLhxbaMmZ3/TTCXGkeyal+6UTT83peTMDfwTYo3Onc65KvuIfZT5YgR+aHxJ8NfgAbhF0c12pkaHR+bZ5uOkztFMNM7psFI09FKP9vZcxhTW8ZYfkTyZeiVCI5XGkaVuFGSMIDH9VssqOFeNBYB4lAQzODrk5SHwmZ80TYM0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(86362001)(83380400001)(6506007)(52116002)(478600001)(66556008)(66946007)(8676002)(9686003)(66476007)(6512007)(8936002)(2906002)(186003)(36756003)(2616005)(6486002)(956004)(4326008)(69590400007)(16526019)(6666004)(26005)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6eJ8Ncr99W1LYK0Pcvw2kcgxPQqiGfvsD1AIg0j5XYENIxxVAR/1hA1L8OC+/AaIGlDNQeC3D17tDyaQReTPuaDguXp1WwmPp4goNMf/SdGWpZA4WRzcWYiBonnyQYK9UQ+/bzREkw7j9f42hf+RJ6DvdjtudT+X6FwVPowKqkRyMVtKmsNpEACYvvTiinSlSY/4rgUqxMsizry7cRYQxltQVkQjgIsZct/XxZTVZZSqMERJo66ARhtCmJUC8ozrGaDFmh8j4s1yKM6Qcl7g86tnf2Nq3Nl89dvp+M4erRDz7iRCjYynegvIGHUlh+QWPljZAlp/cgVaCgy53Q6vcef7YCymQuxc80wzo2AsYMzgcf9w3c7XaccR5QwC51HPehNOQIzRz709WCrNPTHRJsg03jsQx8Y1cbNMQId91o6cJKo7rlZkyaBG33tCLegr3J52HhJcxpr91smzjcGd2vdrHUALY/9KCnWyWwhGUqY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50392bb-02d6-4d3b-5645-08d808f5a596
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 02:10:41.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIA5OmCH1Hrtve1Bo5IFN6cM7QXpfLRu8DL+PA5g3qPquH8qL5PTBqSk74WPGKq+5EEFHZ4kaSuEf/3knRs+Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add resource management API, when we have multiple
partition running together, resources not owned to current
partition should not be used.

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
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
index 000000000000..456b6a59d29b
--- /dev/null
+++ b/include/linux/firmware/imx/svc/rm.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2020 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Resource Management (RM) function. This includes functions for
+ * partitioning resources, pads, and memory regions.
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


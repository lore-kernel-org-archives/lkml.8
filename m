Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D29C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7E821775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BTGkHUtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGTJGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:06:31 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:30692
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTJGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2GqmpXUZ+Wm3e7G5vg+BJWIhIf8GUqmLZ1EUX8WW0Hp0VwKY27tMGiIJGdXWWBNRtcVJgub8KQbeC2mkHJBbwIxaL/URLmrxEKu7sazd7F9Iqsh8D3p3D/h1d/c0nyjIuBZZidLIjf/8uHPaLAc0WmjpHNqhGgz2jpm1i1PPuSrFad10R5sNxCOtHt6mNQnw8xNN47PIlQPp64Tuz6ChBQF0dU5grX1dpBA5sH7zsTrprHhbH3l8UYtMfNOPjocDr/8pgmi029qg0mLdC9zI7dMsDH5mfbNPE+pn7Vt2Dv5CpzP7sssDwsWjvFnPdL0gsCV6840lV305cXESNlXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NpwQ4mx97MyOCQZKVgmpmVik70amk5kpehPjolcebs=;
 b=BM37RiCSX9OZ4SY6r5gNyWGKxYk4u7WYNQwuaFXLs10aKNhxB5LKlAkMp3g4NdqJCQ2r9K7IV+SHDtI3LkiWBX0HksSW7mq1kzh72e3AA5nQbu9fNScXoe1+gPOuNxXu/ngeoQinM3vIEouulSq4atw2JrPncxmPtjxpo70TxKnU00NvXPmKhMN5tt5lKFtKusXxnY6vY8pnkntBM36Zc1dZPTD8GybC0A4PHhcHknGmYcXf+8NGKlPOe5Kgue/0W4+t6a3JS/Sim+MGZqZga+kbUkWcijpVTG/sT0XuInQezcCklP3eRhnEbGQB2VTM0TlXnKj+8DlX1Q3uuZJZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NpwQ4mx97MyOCQZKVgmpmVik70amk5kpehPjolcebs=;
 b=BTGkHUtUv75zVK0ynmu7/CjKsATY//K9Ece4oOw/TQMkYWA3q4yW1wIiB32i8FDfeZ/qF3hYwlm2FjVhQPMomL5HRhmhqiIvf3FCK8PgHNeg558vm1AbNic3q/AH5X4LTna8m0gj3gwvsq/6wYxf612QZx24tn8QxT7UKPdoTFE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR0402MB3762.eurprd04.prod.outlook.com
 (2603:10a6:208:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 09:06:20 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:06:20 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH 1/7] firmware: imx: scu-rm: Add Resource Management APIs
Date:   Mon, 20 Jul 2020 11:06:11 +0200
Message-Id: <1595235977-106241-2-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 09:06:19 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc0089e8-8c6a-4521-ac35-08d82c8c2aed
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3762012E1D809AA0C8776087D37B0@AM0PR0402MB3762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70hgWCCmd7hYWbuIDwVO3dc7O8iGBywQwluZxrjgMJqYCJKtjqbqph/F+sIPQyN7EaNDpfdeclPeXJ/ecQtwcviJYGbfMIaFxTiJmClC948f9pkaJMVjg16AxOb+CtMjBL8+QswxqwBwDsEwpoxkLkxdFEGo1YCI5khXd597ZeiWfjncw33MPnqv0Shf5N4dNwAosZqtLktQ04s4giIoiCEH+ucD/zQbaTAvrsgd/P14566laRt32nihGTtz4K7u1rGeZEkVsLdnhXXstjkR5gwBVarJDsuPDhVH6EpAbkv9GXN2LvcEj+xjrGIirWeF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(6512007)(316002)(66476007)(66946007)(66556008)(2906002)(6666004)(9686003)(8676002)(8936002)(86362001)(83380400001)(5660300002)(26005)(186003)(16526019)(2616005)(6506007)(956004)(6486002)(478600001)(52116002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tTx7ZI85rWNKQ8mWT4wLqHy1jFAqrXOreK9HIsXaSBv/Tjm3mC/VVzY3omXMz3Prd0lsjsIdUh+0S+IVFaLX+vLQSJR3q7VjGEzLYOiLY973TyI4gi4WSlGl18NUmoql8eM8YBLXHTiCCt8x+dLeq8GakI0bUDeOUXu+gC2JdsFsM9fgMlsrWHUpva0XDJv8OseF8N6mJwk8MFRSODCwIYDuhadqxrddaI5X+OVCYbjjsLHZHqFg4w/p/qo6W0/j3iPYYz+ZuWQWkV85fZX5H0fxSh5RsUGSKpVJ7i2rRZjCkDqFGVv34nnFnq8AsGLaY01hKHk9IvxP6sLPh782q2uip0/jR05d8MN7Tf2jW/rD0n0m9uPS3sGOiCWguDaPp1d+lU2dKdXUjTvaDqRVaDGHqDl/CPlh7iJoBEswgSwPJd5hCsxPeWoI1yP+wVfigxH+M4/sHaVooHCc0NFnZ6isgw7VZr27sU3qykdGLfM=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0089e8-8c6a-4521-ac35-08d82c8c2aed
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:06:20.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSdGoouyI0fn1V4no13ZTwIsbH9eNsLEOroO/jAvs9+wUN2FTIuzGnZb3I4xTzfuIzMI0lWCQV/QOescqMv3L0y772QnR2mxH019nAMuP6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

This patch adds the imx_sc_rm_is_resource_owned indicating if a
specific resource is owned by the caller.

Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
---
 drivers/firmware/imx/Makefile       |  2 +-
 drivers/firmware/imx/rm.c           | 44 +++++++++++++++++++++++
 include/linux/firmware/imx/sci.h    |  1 +
 include/linux/firmware/imx/svc/rm.h | 69 +++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/rm.c
 create mode 100644 include/linux/firmware/imx/svc/rm.h

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 08bc9dd..17ea361 100644
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
index 00000000..a397c6b
--- /dev/null
+++ b/drivers/firmware/imx/rm.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2020 NXP
+ *
+ * File containing client-side RPC functions for the RM service. These
+ * functions are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/svc/rm.h>
+
+struct imx_sc_msg_rm_rsrc_owned {
+	struct imx_sc_rpc_msg hdr;
+	u16 resource;
+} __packed __aligned(4);
+
+/**
+ * imx_sc_rm_is_resource_owned() - Checks @resource is owned by current
+ * partition or not
+ *
+ * @ipc: IPC handle
+ * @resource: resource the control is associated with
+ *
+ * Return:
+ * 0 - OK
+ * < 0 - error.
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
+	imx_scu_call_rpc(ipc, &msg, true);
+
+	return hdr->func;
+}
+EXPORT_SYMBOL(imx_sc_rm_is_resource_owned);
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 3fa418a..3c459f5 100644
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
index 00000000..9924216
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
2.7.4


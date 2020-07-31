Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43035C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061A322B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pS+yXvtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbgGaQsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:48:16 -0400
Received: from mail-eopbgr690074.outbound.protection.outlook.com ([40.107.69.74]:10126
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732662AbgGaQsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:48:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4KFz+L3gKP/P5niYgv9+w+4fSz8D763EuDUnhq6tSb/iRnoXhep/PKXJZAUD1nsmxzmpF/XGz/O1BBtt//1FW6gpyPjYlaGobtmaMHBqHleeQhNFis9JbjqXwXS9xk/Y7Yyn6wEPlfpxFI10bhCBgXmjUuDPirMAQnDn7PlvpHeAcYzBnBdcNp2AcI9MnijMm1SSWO2OpzDTZ3YoLRXG9Qes13bkv1LSEOBqtM9CAv8/tRPtNYGpCwhLI/oNDj3lm0m/bDhuaAGu34EFhyfvHPksfpGctaUe4P94oWqMqo/e6Jpt83P3hdFwJBhGHzDLeOezrVfT/bRQ48r7JQ4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnOf0UeJlrLcOLBcSrLcsd0HPGbotTXYi//tdeznaD0=;
 b=fYOwQZOYcinolcPo0J/AquPVVVFlY1IzBrm3kT+2MpgYGJtnxd3W/jTTLk+ZlB4f/Ym3aMBXrKsbbEUW2qgmwCESceZOnSMZnEaF3UV58zO+HVoaxdl/owgWR6EPWZEokh2BVlYifu1bnhDH7uRZa8VmsAq3YmAimk1y2AYsY3f6wYg676+P1qcBEWq43YyQ3TTphukTxh3SBFGjQ7PHg17XTvokMEI7VjzpR7PSAOTP5ESb++7GiQ3kJKoz0A/VcQft55TIWfAShecFHjXuGRrnxKguzZRQddLC2J6Xet6pdvcogYL8semY2iZ8oFUMUxfHobFCTOwXdoGCsVR7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnOf0UeJlrLcOLBcSrLcsd0HPGbotTXYi//tdeznaD0=;
 b=pS+yXvtNS15vMth+vG4T9STHxzFbtwCOv1G1DmAKBEa83XLFKga9bwyfOSJZ5i1xeHLeGx7qDj4fqepcbH1dWuGW39YSG0hXwRAAutbT76qo2P3ATCFuK1d7e+ABJgQ1xoBNysJuLgmr4e7HJ0o3pvTl0wBHDjug8HoV3xMCD5M=
Received: from SA0PR11CA0065.namprd11.prod.outlook.com (2603:10b6:806:d2::10)
 by DM6PR02MB7050.namprd02.prod.outlook.com (2603:10b6:5:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 16:48:06 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::e9) by SA0PR11CA0065.outlook.office365.com
 (2603:10b6:806:d2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Fri, 31 Jul 2020 16:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 16:48:06
 +0000
Received: from [149.199.38.66] (port=41025 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YAS-0006bx-JA; Fri, 31 Jul 2020 09:46:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCU-0007o7-64; Fri, 31 Jul 2020 09:48:06 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06VGlte8021518;
        Fri, 31 Jul 2020 09:47:55 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCJ-0007jL-5j; Fri, 31 Jul 2020 09:47:55 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michal.simek@xilinx.com
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/5] remoteproc: Add initial zynqmp R5 remoteproc driver
Date:   Fri, 31 Jul 2020 09:47:54 -0700
Message-Id: <20200731164754.20505-6-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731164754.20505-1-ben.levinsky@xilinx.com>
References: <20200731164754.20505-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 10076dcf-9957-465f-1ace-08d835717fce
X-MS-TrafficTypeDiagnostic: DM6PR02MB7050:
X-Microsoft-Antispam-PRVS: <DM6PR02MB705033ECF2FAE4D5263165C2B54E0@DM6PR02MB7050.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIGi3eo+iwnpWeRWVf/ZgVWbplUkRetrUKcH3M1oiOmkKl+d5mndQxe5Y+3/RhSfF//hsXX2UwUJB9fD3HT2em3ND8vkAzDRWOLRWH30FlTRtQVqyGsqIJ8rX7Wetx4YksaeLIDHo+lf3fOsFObGwONPVxYlvxchb/Use6LJjc+PTI/bIvpGM5tYExj0RbeHbmbiHx1i97PevfPRUeiplB29FTTuBpixz4MmBY1E0N/NphvEmJD94+8zKmb5i1kUQQmHJZTzPVC3WKhFANlm1Lg/pjxDiFhEKBNRavsp/6loCoX7PsUcXNJQ5QzS2a+lhqYL/89by9nhtyEv9tGUg2npvpCvGSha3Pjb8G4qwjZXb4JMpDJ3RwNKgu66r1tlwUMAs/dubAjVxL4ZLftml+o+ztMNu7LSkonr7MU7FH0=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(346002)(376002)(46966005)(7696005)(186003)(44832011)(1076003)(82310400002)(356005)(26005)(70586007)(81166007)(2616005)(6636002)(316002)(36756003)(426003)(2906002)(336012)(30864003)(4326008)(9786002)(8676002)(478600001)(8936002)(83380400001)(47076004)(82740400003)(70206006)(5660300002)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 16:48:06.4635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10076dcf-9957-465f-1ace-08d835717fce
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
remotproc driver, we can boot the R5 sub-system in different
configurations.

Acked-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Acked-by: Ben Levinsky <ben.levinsky@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
Signed-off-by: Jason Wu <j.wu@xilinx.com>
Tested-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v2:
- remove domain struct as per review from Mathieu
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
v4:
- add default values for enums
- fix formatting as per checkpatch.pl --strict. Note that 1 warning and 1 check
  are still raised as each is due to fixing the warning results in that
particular line going over 80 characters.
v5:
- parse_fw change from use of rproc_of_resm_mem_entry_init to rproc_mem_entry_init and use of alloc/release
- var's of type zynqmp_r5_pdata all have same local variable name
- use dev_dbg instead of dev_info
v6:
- adding memory carveouts is handled much more similarly. All mem carveouts are
  now described in reserved memory as needed. That is, TCM nodes are not
  coupled to remoteproc anymore. This is reflected in the remoteproc R5 driver
  and the device tree binding.
- remove mailbox from device tree binding as it is not necessary for elf
  loading
- use lockstep-mode property for configuring RPU
v7:
- remove unused headers
- change  u32 *lockstep_mode ->  u32 lockstep_mode;
- change device-tree binding "lockstep-mode"  to xlnx,cluster-mode
- remove zynqmp_r5_mem_probe and loop to Probe R5 memory devices at 
  remoteproc-probe time
- remove is_r5_mode_set from  zynqmp rpu remote processor private data
- do not error out if no mailbox is provided
- remove zynqmp_r5_remoteproc_probe call of platform_set_drvdata as pdata is
  handled in zynqmp_r5_remoteproc_remove

---
 drivers/remoteproc/Kconfig                |  10 +
 drivers/remoteproc/Makefile               |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c | 847 ++++++++++++++++++++++
 3 files changed, 858 insertions(+)
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c4d1731295eb..342a7e668636 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -249,6 +249,16 @@ config STM32_RPROC
 
 	  This can be either built-in or a loadable module.
 
+config ZYNQMP_R5_REMOTEPROC
+	tristate "ZynqMP_R5 remoteproc support"
+	depends on ARM64 && PM && ARCH_ZYNQMP
+	select RPMSG_VIRTIO
+	select MAILBOX
+	select ZYNQMP_IPI_MBOX
+	help
+	  Say y here to support ZynqMP R5 remote processors via the remote
+	  processor framework.
+
 endif # REMOTEPROC
 
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index e8b886e511f0..04d1c95d06d7 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -28,5 +28,6 @@ obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
 qcom_wcnss_pil-y			+= qcom_wcnss.o
 qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
 obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
+obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+= zynqmp_r5_remoteproc.o
 obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
 obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c b/drivers/remoteproc/zynqmp_r5_remoteproc.c
new file mode 100644
index 000000000000..41f649700054
--- /dev/null
+++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
@@ -0,0 +1,847 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq R5 Remote Processor driver
+ *
+ * Copyright (C) 2019, 2020 Xilinx Inc. Ben Levinsky <ben.levinsky@xilinx.com>
+ * Copyright (C) 2015 - 2018 Xilinx Inc.
+ * Copyright (C) 2015 Jason Wu <j.wu@xilinx.com>
+ *
+ * Based on origin OMAP and Zynq Remote Processor driver
+ *
+ * Copyright (C) 2012 Michal Simek <monstr@monstr.eu>
+ * Copyright (C) 2012 PetaLogix
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2011 Google, Inc.
+ */
+
+#include <linux/cpu.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/zynqmp-ipi-message.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include "remoteproc_internal.h"
+
+#define MAX_RPROCS	2 /* Support up to 2 RPU */
+#define MAX_MEM_PNODES	4 /* Max power nodes for one RPU memory instance */
+
+#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
+
+/* IPI buffer MAX length */
+#define IPI_BUF_LEN_MAX	32U
+/* RX mailbox client buffer max length */
+#define RX_MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
+				 sizeof(struct zynqmp_ipi_message))
+
+#define ZYNQMP_R5_NUM_TCM_BANKS 4
+
+/* lookup table mapping power-node-ID of TCM bank to absolute base address */
+static unsigned long tcm_addr_to_pnode[ZYNQMP_R5_NUM_TCM_BANKS][2] = {
+	{0xFFE00000,	0xF },
+	{0xFFE20000,	0x10},
+	{0xFFE90000,	0x10},
+	{0xFFEB0000,	0x11},
+};
+
+static bool autoboot __read_mostly;
+
+/**
+ * struct zynqmp_r5_mem - zynqmp rpu memory data
+ * @pnode_id: TCM power domain ids
+ * @res: memory resource
+ * @node: list node
+ */
+struct zynqmp_r5_mem {
+	u32 pnode_id[MAX_MEM_PNODES];
+	struct resource res;
+	struct list_head node;
+};
+
+/**
+ * struct zynqmp_r5_pdata - zynqmp rpu remote processor private data
+ * @dev: device of RPU instance
+ * @rproc: rproc handle
+ * @pnode_id: RPU CPU power domain id
+ * @mems: memory resources
+ * @tx_mc: tx mailbox client
+ * @rx_mc: rx mailbox client
+ * @tx_chan: tx mailbox channel
+ * @rx_chan: rx mailbox channel
+ * @mbox_work: mbox_work for the RPU remoteproc
+ * @tx_mc_skbs: socket buffers for tx mailbox client
+ * @rx_mc_buf: rx mailbox client buffer to save the rx message
+ */
+struct zynqmp_r5_pdata {
+	struct device dev;
+	struct rproc *rproc;
+	u32 pnode_id;
+	struct list_head mems;
+	struct mbox_client tx_mc;
+	struct mbox_client rx_mc;
+	struct mbox_chan *tx_chan;
+	struct mbox_chan *rx_chan;
+	struct work_struct mbox_work;
+	struct sk_buff_head tx_mc_skbs;
+	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
+};
+
+/**
+ * table of RPUs
+ */
+struct zynqmp_r5_pdata rpus[MAX_RPROCS];
+/**
+ *  RPU core configuration
+ */
+enum rpu_oper_mode rpu_mode;
+
+/*
+ * r5_set_mode - set RPU operation mode
+ * @pdata: Remote processor private data
+ *
+ * set RPU oepration mode
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int r5_set_mode(struct zynqmp_r5_pdata *pdata)
+{
+	u32 val[PAYLOAD_ARG_CNT] = {0}, expect, tcm_mode;
+	struct device *dev = &pdata->dev;
+	int ret;
+
+	expect = (u32)rpu_mode;
+	ret = zynqmp_pm_get_rpu_mode(pdata->pnode_id, 0, 0, val);
+	if (ret < 0) {
+		dev_err(dev, "failed to get RPU oper mode.\n");
+		return ret;
+	}
+	if (val[0] == expect) {
+		dev_dbg(dev, "RPU mode matches: %x\n", val[0]);
+	} else {
+		ret = zynqmp_pm_set_rpu_mode(pdata->pnode_id,
+					     expect, 0, val);
+		if (ret < 0) {
+			dev_err(dev,
+				"failed to set RPU oper mode.\n");
+			return ret;
+		}
+	}
+
+	tcm_mode = (expect == (u32)PM_RPU_MODE_LOCKSTEP) ?
+		    PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
+	ret = zynqmp_pm_set_tcm_config(pdata->pnode_id, tcm_mode, 0, val);
+	if (ret < 0) {
+		dev_err(dev, "failed to config TCM to %x.\n",
+			expect);
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * ZynqMP R5 remoteproc memory release function
+ */
+static int zynqmp_r5_mem_release(struct rproc *rproc,
+				 struct rproc_mem_entry *mem)
+{
+	struct zynqmp_r5_mem *priv;
+	int i, ret;
+	struct device *dev = &rproc->dev;
+
+	priv = mem->priv;
+	if (!priv)
+		return 0;
+	for (i = 0; i < MAX_MEM_PNODES; i++) {
+		if (priv->pnode_id[i]) {
+			dev_dbg(dev, "%s, pnode %d\n",
+				__func__, priv->pnode_id[i]);
+			ret = zynqmp_pm_release_node(priv->pnode_id[i]);
+			if (ret < 0) {
+				dev_err(dev,
+					"failed to release power node: %u\n",
+					priv->pnode_id[i]);
+				return ret;
+			}
+		} else {
+			break;
+		}
+	}
+	return 0;
+}
+
+/*
+ * ZynqMP R5 remoteproc operations
+ */
+static int zynqmp_r5_rproc_start(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct zynqmp_r5_pdata *pdata = rproc->priv;
+	enum rpu_boot_mem bootmem;
+	int ret;
+
+	if ((rproc->bootaddr & 0xF0000000) == 0xF0000000)
+		bootmem = PM_RPU_BOOTMEM_HIVEC;
+	else
+		bootmem = PM_RPU_BOOTMEM_LOVEC;
+	dev_dbg(dev, "RPU boot from %s.",
+		bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
+	ret = zynqmp_pm_request_wakeup(pdata->pnode_id, 1,
+				       bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
+	if (ret < 0) {
+		dev_err(dev, "failed to boot R5.\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int zynqmp_r5_rproc_stop(struct rproc *rproc)
+{
+	struct zynqmp_r5_pdata *pdata = rproc->priv;
+	int ret;
+
+	ret = zynqmp_pm_force_powerdown(pdata->pnode_id,
+					ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+	if (ret < 0) {
+		dev_err(&pdata->dev, "failed to shutdown R5.\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int zynqmp_r5_rproc_mem_alloc(struct rproc *rproc,
+				      struct rproc_mem_entry *mem)
+{
+	struct device *dev = rproc->dev.parent;
+	void *va;
+
+	dev_dbg(rproc->dev.parent, "map memory: %pa\n", &mem->dma);
+	va = ioremap_wc(mem->dma, mem->len);
+	if (IS_ERR_OR_NULL(va)) {
+		dev_err(dev, "Unable to map memory region: %pa+%lx\n",
+			&mem->dma, mem->len);
+		return -ENOMEM;
+	}
+
+	/* Update memory entry va */
+	mem->va = va;
+
+	return 0;
+}
+
+static int zynqmp_r5_rproc_mem_release(struct rproc *rproc,
+				       struct rproc_mem_entry *mem)
+{
+	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
+	iounmap(mem->va);
+
+	return 0;
+}
+
+/*
+ * TCM needs mapping to R5 relative address and xilinx platform mgmt call
+ */
+struct rproc_mem_entry *handle_tcm_parsing(struct device *dev,
+					    struct reserved_mem *rmem,
+					    struct device_node *node,
+					    int lookup_idx)
+{
+	void *va;
+	dma_addr_t dma;
+	resource_size_t size;
+	int ret;
+	u32 pnode_id;
+	struct resource rsc;
+	struct rproc_mem_entry *mem;
+
+	pnode_id =  tcm_addr_to_pnode[lookup_idx][1];
+	ret = zynqmp_pm_request_node(pnode_id,
+				     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+	if (ret < 0) {
+		dev_err(dev, "failed to request power node: %u\n", pnode_id);
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(node, 0, &rsc);
+	if (ret < 0) {
+		dev_err(dev, "failed to get resource of memory %s",
+			of_node_full_name(node));
+		return -EINVAL;
+	}
+	size = resource_size(&rsc);
+	va = devm_ioremap_wc(dev, rsc.start, size);
+	if (!va)
+		return -ENOMEM;
+
+	/* zero out tcm base address */
+	if (rsc.start & 0xffe00000) {
+		/* R5 can't see anything past 0xfffff so wipe it */
+		rsc.start &= 0x000fffff;
+		/*
+		 * handle tcm banks 1 a and b (0xffe9000 and
+		 * 0xffeb0000)
+		 */
+		if (rsc.start & 0x80000)
+			rsc.start -= 0x90000;
+	}
+
+	dma = (dma_addr_t)rsc.start;
+	mem = rproc_mem_entry_init(dev, va, dma, (int)size, rsc.start,
+				   NULL, zynqmp_r5_mem_release,
+				   rsc.name);
+	if (!mem)
+		return -ENOMEM;
+
+	return mem;
+}
+
+static int parse_mem_regions(struct rproc *rproc)
+{
+	int num_mems, i;
+	struct zynqmp_r5_pdata *pdata = rproc->priv;
+	struct device *dev =  &pdata->dev;
+	struct device_node *np = dev->of_node;
+	struct rproc_mem_entry *mem;
+
+	num_mems = of_count_phandle_with_args(np, "memory-region", NULL);
+	if (num_mems <= 0)
+		return 0;
+	for (i = 0; i < num_mems; i++) {
+		struct device_node *node;
+		struct reserved_mem *rmem;
+
+		node = of_parse_phandle(np, "memory-region", i);
+		rmem = of_reserved_mem_lookup(node);
+		if (!rmem) {
+			dev_err(dev, "unable to acquire memory-region\n");
+			return -EINVAL;
+		}
+
+		if (strstr(node->name, "vdev0buffer")) {
+			/* Register DMA region */
+			mem = rproc_mem_entry_init(dev, NULL,
+						   (dma_addr_t)rmem->base,
+						   rmem->size, rmem->base,
+						   NULL, NULL,
+						   "vdev0buffer");
+			if (!mem) {
+				dev_err(dev, "unable to initialize memory-region %s\n",
+					node->name);
+				return -ENOMEM;
+			}
+			dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
+				mem->dma);
+		} else if (strstr(node->name, "vdev0vring")) {
+			int vring_id;
+			char name[16];
+
+			/*
+			 * can be 1 of multiple vring IDs per IPC channel
+			 * e.g. 'vdev0vring0' and 'vdev0vring1'
+			 */
+			vring_id = node->name[14] - '0';
+			snprintf(name, sizeof(name), "vdev0vring%d", vring_id);
+			/* Register vring */
+			mem = rproc_mem_entry_init(dev, NULL,
+						   (dma_addr_t)rmem->base,
+						   rmem->size, rmem->base,
+						   zynqmp_r5_rproc_mem_alloc,
+						   zynqmp_r5_rproc_mem_release,
+						   name);
+			dev_dbg(dev, "parsed %s at %llx\r\n", mem->name,
+				mem->dma);
+		} else {
+			int idx;
+
+			/*
+			 * if TCM update address space for R5 and
+			 * make xilinx platform mgmt call
+			 */
+			for (idx = 0; idx < ZYNQMP_R5_NUM_TCM_BANKS; idx++) {
+				if (tcm_addr_to_pnode[idx][0] == rmem->base)
+					break;
+			}
+
+			if (idx != ZYNQMP_R5_NUM_TCM_BANKS) {
+				mem = handle_tcm_parsing(dev, rmem, node, idx);
+			} else {
+				mem = rproc_mem_entry_init(dev, NULL,
+						   (dma_addr_t)rmem->base,
+						   rmem->size, rmem->base,
+						   zynqmp_r5_rproc_mem_alloc,
+						   zynqmp_r5_rproc_mem_release,
+						   node->name);
+			}
+
+			if (!mem) {
+				dev_err(dev,
+					"unable to init memory-region %s\n",
+					node->name);
+				return -ENOMEM;
+			}
+		}
+		rproc_add_carveout(rproc, mem);
+	}
+
+	return 0;
+}
+
+static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	int ret;
+	struct zynqmp_r5_pdata *pdata = rproc->priv;
+	struct device *dev = &pdata->dev;
+
+	ret = parse_mem_regions(rproc);
+	if (ret) {
+		dev_err(dev, "parse_mem_regions failed %x\n", ret);
+		return ret;
+	}
+
+	ret = rproc_elf_load_rsc_table(rproc, fw);
+	if (ret == -EINVAL) {
+		dev_dbg(dev, "no resource table found.\n");
+		ret = 0;
+	}
+	return ret;
+}
+
+/* kick a firmware */
+static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct device *dev = rproc->dev.parent;
+	struct zynqmp_r5_pdata *pdata = rproc->priv;
+
+	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n", vqid);
+
+	if (vqid < 0) {
+		/* If vqid is negative, does not pass the vqid to
+		 * mailbox. As vqid is supposed to be 0 or possive.
+		 * It also gives a way to just kick instead but
+		 * not use the IPI buffer. It is better to provide
+		 * a proper way to pass the short message, which will
+		 * need to sync to upstream first, for now,
+		 * use negative vqid to assume no message will be
+		 * passed with IPI buffer, but just raise interrupt.
+		 * This will be faster as it doesn't need to copy the
+		 * message to the IPI buffer.
+		 *
+		 * It will ignore the return, as failure is due to
+		 * there already kicks in the mailbox queue.
+		 */
+		(void)mbox_send_message(pdata->tx_chan, NULL);
+	} else {
+		struct sk_buff *skb;
+		unsigned int skb_len;
+		struct zynqmp_ipi_message *mb_msg;
+		int ret;
+
+		skb_len = (unsigned int)(sizeof(vqid) + sizeof(mb_msg));
+		skb = alloc_skb(skb_len, GFP_ATOMIC);
+		if (!skb) {
+			dev_err(dev,
+				"Failed to allocate skb to kick remote.\n");
+			return;
+		}
+		mb_msg = (struct zynqmp_ipi_message *)skb_put(skb, skb_len);
+		mb_msg->len = sizeof(vqid);
+		memcpy(mb_msg->data, &vqid, sizeof(vqid));
+		skb_queue_tail(&pdata->tx_mc_skbs, skb);
+		ret = mbox_send_message(pdata->tx_chan, mb_msg);
+		if (ret < 0) {
+			dev_warn(dev, "Failed to kick remote.\n");
+			skb_dequeue_tail(&pdata->tx_mc_skbs);
+			kfree_skb(skb);
+		}
+	}
+}
+
+static struct rproc_ops zynqmp_r5_rproc_ops = {
+	.start		= zynqmp_r5_rproc_start,
+	.stop		= zynqmp_r5_rproc_stop,
+	.load		= rproc_elf_load_segments,
+	.parse_fw	= zynqmp_r5_parse_fw,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
+	.sanity_check	= rproc_elf_sanity_check,
+	.get_boot_addr	= rproc_elf_get_boot_addr,
+	.kick		= zynqmp_r5_rproc_kick,
+};
+
+/**
+ * zynqmp_r5_release() - ZynqMP R5 device release function
+ * @dev: pointer to the device struct of ZynqMP R5
+ *
+ * Function to release ZynqMP R5 device.
+ */
+static void zynqmp_r5_release(struct device *dev)
+{
+	struct zynqmp_r5_pdata *pdata;
+	struct rproc *rproc;
+	struct sk_buff *skb;
+
+	pdata = dev_get_drvdata(dev);
+	rproc = pdata->rproc;
+	if (rproc) {
+		rproc_del(rproc);
+		rproc_free(rproc);
+	}
+	if (pdata->tx_chan)
+		mbox_free_channel(pdata->tx_chan);
+	if (pdata->rx_chan)
+		mbox_free_channel(pdata->rx_chan);
+	/* Discard all SKBs */
+	while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
+		skb = skb_dequeue(&pdata->tx_mc_skbs);
+		kfree_skb(skb);
+	}
+
+	put_device(dev->parent);
+}
+
+/**
+ * event_notified_idr_cb() - event notified idr callback
+ * @id: idr id
+ * @ptr: pointer to idr private data
+ * @data: data passed to idr_for_each callback
+ *
+ * Pass notification to remoteproc virtio
+ *
+ * Return: 0. having return is to satisfy the idr_for_each() function
+ *          pointer input argument requirement.
+ **/
+static int event_notified_idr_cb(int id, void *ptr, void *data)
+{
+	struct rproc *rproc = data;
+
+	(void)rproc_vq_interrupt(rproc, id);
+	return 0;
+}
+
+/**
+ * handle_event_notified() - remoteproc notification work funciton
+ * @work: pointer to the work structure
+ *
+ * It checks each registered remoteproc notify IDs.
+ */
+static void handle_event_notified(struct work_struct *work)
+{
+	struct rproc *rproc;
+	struct zynqmp_r5_pdata *pdata;
+
+	pdata = container_of(work, struct zynqmp_r5_pdata, mbox_work);
+
+	(void)mbox_send_message(pdata->rx_chan, NULL);
+	rproc = pdata->rproc;
+	/*
+	 * We only use IPI for interrupt. The firmware side may or may
+	 * not write the notifyid when it trigger IPI.
+	 * And thus, we scan through all the registered notifyids.
+	 */
+	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
+}
+
+/**
+ * zynqmp_r5_mb_rx_cb() - Receive channel mailbox callback
+ * @cl: mailbox client
+ * @mssg: message pointer
+ *
+ * It will schedule the R5 notification work.
+ */
+static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *mssg)
+{
+	struct zynqmp_r5_pdata *pdata;
+
+	pdata = container_of(cl, struct zynqmp_r5_pdata, rx_mc);
+	if (mssg) {
+		struct zynqmp_ipi_message *ipi_msg, *buf_msg;
+		size_t len;
+
+		ipi_msg = (struct zynqmp_ipi_message *)mssg;
+		buf_msg = (struct zynqmp_ipi_message *)pdata->rx_mc_buf;
+		len = (ipi_msg->len >= IPI_BUF_LEN_MAX) ?
+		      IPI_BUF_LEN_MAX : ipi_msg->len;
+		buf_msg->len = len;
+		memcpy(buf_msg->data, ipi_msg->data, len);
+	}
+	schedule_work(&pdata->mbox_work);
+}
+
+/**
+ * zynqmp_r5_mb_tx_done() - Request has been sent to the remote
+ * @cl: mailbox client
+ * @mssg: pointer to the message which has been sent
+ * @r: status of last TX - OK or error
+ *
+ * It will be called by the mailbox framework when the last TX has done.
+ */
+static void zynqmp_r5_mb_tx_done(struct mbox_client *cl, void *mssg, int r)
+{
+	struct zynqmp_r5_pdata *pdata;
+	struct sk_buff *skb;
+
+	if (!mssg)
+		return;
+	pdata = container_of(cl, struct zynqmp_r5_pdata, tx_mc);
+	skb = skb_dequeue(&pdata->tx_mc_skbs);
+	kfree_skb(skb);
+}
+
+/**
+ * zynqmp_r5_setup_mbox() - Setup mailboxes
+ *
+ * @pdata: pointer to the ZynqMP R5 processor platform data
+ * @node: pointer of the device node
+ *
+ * Function to setup mailboxes to talk to RPU.
+ *
+ * Return: 0 for success, negative value for failure.
+ */
+static int zynqmp_r5_setup_mbox(struct zynqmp_r5_pdata *pdata,
+				struct device_node *node)
+{
+	struct device *dev = &pdata->dev;
+	struct mbox_client *mclient;
+
+	/* Setup TX mailbox channel client */
+	mclient = &pdata->tx_mc;
+	mclient->dev = dev;
+	mclient->rx_callback = NULL;
+	mclient->tx_block = false;
+	mclient->knows_txdone = false;
+	mclient->tx_done = zynqmp_r5_mb_tx_done;
+
+	/* Setup TX mailbox channel client */
+	mclient = &pdata->rx_mc;
+	mclient->dev = dev;
+	mclient->rx_callback = zynqmp_r5_mb_rx_cb;
+	mclient->tx_block = false;
+	mclient->knows_txdone = false;
+
+	INIT_WORK(&pdata->mbox_work, handle_event_notified);
+
+	/* Request TX and RX channels */
+	pdata->tx_chan = mbox_request_channel_byname(&pdata->tx_mc, "tx");
+	if (IS_ERR(pdata->tx_chan)) {
+		dev_err(dev, "failed to request mbox tx channel.\n");
+		pdata->tx_chan = NULL;
+		return -EINVAL;
+	}
+	pdata->rx_chan = mbox_request_channel_byname(&pdata->rx_mc, "rx");
+	if (IS_ERR(pdata->rx_chan)) {
+		dev_err(dev, "failed to request mbox rx channel.\n");
+		pdata->rx_chan = NULL;
+		return -EINVAL;
+	}
+	skb_queue_head_init(&pdata->tx_mc_skbs);
+	return 0;
+}
+
+/**
+ * zynqmp_r5_probe() - Probes ZynqMP R5 processor device node
+ * @pdata: pointer to the ZynqMP R5 processor platform data
+ * @pdev: parent RPU domain platform device
+ * @node: pointer of the device node
+ *
+ * Function to retrieve the information of the ZynqMP R5 device node.
+ *
+ * Return: 0 for success, negative value for failure.
+ */
+static int zynqmp_r5_probe(struct zynqmp_r5_pdata *pdata,
+			   struct platform_device *pdev,
+			   struct device_node *node)
+{
+	struct device *dev = &pdata->dev;
+	struct rproc *rproc;
+	int ret;
+
+	/* Create device for ZynqMP R5 device */
+	dev->parent = &pdev->dev;
+	dev->release = zynqmp_r5_release;
+	dev->of_node = node;
+	dev_set_name(dev, "%s", of_node_full_name(node));
+	dev_set_drvdata(dev, pdata);
+	ret = device_register(dev);
+	if (ret) {
+		dev_err(dev, "failed to register device.\n");
+		return ret;
+	}
+	get_device(&pdev->dev);
+
+	/* Allocate remoteproc instance */
+	rproc = rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops, NULL, 0);
+	if (!rproc) {
+		dev_err(dev, "rproc allocation failed.\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+	rproc->auto_boot = autoboot;
+	pdata->rproc = rproc;
+	rproc->priv = pdata;
+
+	/*
+	 * The device has not been spawned from a device tree, so
+	 * arch_setup_dma_ops has not been called, thus leaving
+	 * the device with dummy DMA ops.
+	 * Fix this by inheriting the parent's DMA ops and mask.
+	 */
+	rproc->dev.dma_mask = pdev->dev.dma_mask;
+	set_dma_ops(&rproc->dev, get_dma_ops(&pdev->dev));
+
+	/* Set up DMA mask */
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_warn(dev, "dma_set_coherent_mask failed: %d\n", ret);
+		/* If DMA is not configured yet, try to configure it. */
+		ret = of_dma_configure(dev, node, true);
+		if (ret) {
+			dev_err(dev, "failed to configure DMA.\n");
+			goto error;
+		}
+	}
+
+	/* Get R5 power domain node */
+	ret = of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
+	if (ret) {
+		dev_err(dev, "failed to get power node id.\n");
+		goto error;
+	}
+
+	/* TODO Check if R5 is running */
+
+	/* Set up R5 if not already setup */
+	ret = r5_set_mode(pdata);
+	if (ret) {
+		dev_err(dev, "failed to set R5 operation mode.\n");
+		return ret;
+	}
+
+	if (!of_get_property(dev->of_node, "mboxes", NULL)) {
+		dev_dbg(dev, "no mailboxes.\n");
+	} else {
+		ret = zynqmp_r5_setup_mbox(pdata, node);
+		if (ret < 0)
+			goto error;
+	}
+
+	/* Add R5 remoteproc */
+	ret = rproc_add(rproc);
+	if (ret) {
+		dev_err(dev, "rproc registration failed\n");
+		goto error;
+	}
+	return 0;
+error:
+	if (pdata->rproc)
+		rproc_free(pdata->rproc);
+	pdata->rproc = NULL;
+	device_unregister(dev);
+	put_device(&pdev->dev);
+	return ret;
+}
+
+static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
+{
+	int ret, i = 0;
+	u32 lockstep_mode;
+	struct device *dev = &pdev->dev;
+	struct device_node *nc;
+	struct zynqmp_r5_pdata *pdata;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	of_property_read_u32(dev->of_node, "xlnx,cluster-mode", &lockstep_mode);
+
+	if (!lockstep_mode) {
+		rpu_mode = PM_RPU_MODE_SPLIT;
+	} else if (lockstep_mode == 1) {
+		rpu_mode = PM_RPU_MODE_LOCKSTEP;
+	} else {
+		dev_err(dev,
+			"Invalid lockstep-mode mode provided - %x %d\n",
+			lockstep_mode, rpu_mode);
+		return -EINVAL;
+	}
+	dev_dbg(dev, "RPU configuration: %s\r\n",
+		lockstep_mode ? "lockstep" : "split");
+
+	for_each_available_child_of_node(dev->of_node, nc) {
+		ret = zynqmp_r5_probe(&rpus[i], pdev, nc);
+		if (ret) {
+			dev_err(dev, "failed to probe rpu %s.\n",
+				of_node_full_name(nc));
+			return ret;
+		}
+		i++;
+	}
+
+	return 0;
+}
+
+static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < MAX_RPROCS; i++) {
+		struct zynqmp_r5_pdata *pdata = &rpus[i];
+		struct rproc *rproc;
+
+		rproc = pdata->rproc;
+		if (rproc) {
+			rproc_del(rproc);
+			rproc_free(rproc);
+			pdata->rproc = NULL;
+		}
+		if (pdata->tx_chan) {
+			mbox_free_channel(pdata->tx_chan);
+			pdata->tx_chan = NULL;
+		}
+		if (pdata->rx_chan) {
+			mbox_free_channel(pdata->rx_chan);
+			pdata->rx_chan = NULL;
+		}
+
+		device_unregister(&pdata->dev);
+	}
+
+	return 0;
+}
+
+/* Match table for OF platform binding */
+static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
+	{ .compatible = "xlnx,zynqmp-r5-remoteproc-1.0", },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
+
+static struct platform_driver zynqmp_r5_remoteproc_driver = {
+	.probe = zynqmp_r5_remoteproc_probe,
+	.remove = zynqmp_r5_remoteproc_remove,
+	.driver = {
+		.name = "zynqmp_r5_remoteproc",
+		.of_match_table = zynqmp_r5_remoteproc_match,
+	},
+};
+module_platform_driver(zynqmp_r5_remoteproc_driver);
+
+module_param_named(autoboot,  autoboot, bool, 0444);
+MODULE_PARM_DESC(autoboot,
+		 "enable | disable autoboot. (default: false)");
+
+MODULE_AUTHOR("Ben Levinsky <ben.levinsky@xilinx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84988C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386EA2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="A4y5Azk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHZQPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:15:19 -0400
Received: from mail-bn8nam08on2068.outbound.protection.outlook.com ([40.107.100.68]:51041
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgHZQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:13:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9l8OUp89qrgPfXnpz/plpDjUq1/q8Jf/+F20FrOV2Z2VZmyms6IOem8cmmrJZt6NIbsiQNBsQpiILy3vq0DV8QmUdSYYIJ6rCvNAh34tyUvIE820KCkwcTVLc27WEPlGiUyKiN1aTeowlsZ8UlI12Woy/tmYOdUGxnt5hPM2akE3qPLVC8dsoYbPmC5vuH0cX9UkuaBCeiV2Pan6+k9oRgS5KEAw3jNAqecmx0QTI2z7eAI4iwMx/+tX8O1wV+cWKupnhvnOOxhR5WkVCNEbVNlCCwasZVQ9kskhvuNlmBIVhX974vcs8NsrU2/4RgYh7SK9Q8Ca9GFimIh+6VHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9NFSMtKMDUdFFqW807qhnnrqOreXjc6sMxP8ignCBE=;
 b=f3ebHpEddhZuBLWLIf/lSM4mA7lW3IJ9nf8ND67Rynp2nkjquNZUR/Zq6ML1bwoVBTfLfs4GnKplKGwEy+NXt4abAYY/CZGVOTFRn6RcMK2IsZ5Dg/5hcBmOljfS5/X68G9nctliaudyxu7fP5sV9BSU+diS2JG2Mtz4tWmeiVc5EXoZVjT3Mc546dEexHdUgKwr5TP8biBfFUaL/ZldyMgcswhf5L6d0xFsO7USihqmLi6X9wJxG032oQ7aSdE+sUdyDC91AFzX2OjAyEpT0IjVYjiHi6COaNFEc1aQ98K10F72Ksr/wQxXGd9/PMutcMrdTDvnd6/lTYN4g5SJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9NFSMtKMDUdFFqW807qhnnrqOreXjc6sMxP8ignCBE=;
 b=A4y5Azk7hGEni2bfBj6eZD16GsDmxWfSRuDUL5vEKj1p9dP8vui59WwBSTHJIPQPr+aNAdwRSjwAsIv6sDvtINb/M/d+SacGDsluIhSSrHTyMw2vC0CTgy0fFDSwtt7bKcoeHPVMZhyfVmf9K2njkwe1MMmy/h1/iqJOBcg2Mqk=
Received: from SN6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:805:66::25)
 by BL0PR02MB4419.namprd02.prod.outlook.com (2603:10b6:208:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 16:13:10 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::14) by SN6PR08CA0012.outlook.office365.com
 (2603:10b6:805:66::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 16:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 16:13:09
 +0000
Received: from [149.199.38.66] (port=58619 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2Q-0006a8-Ii; Wed, 26 Aug 2020 09:12:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2v-0008BQ-HG; Wed, 26 Aug 2020 09:13:09 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2t-0008B0-Rt; Wed, 26 Aug 2020 09:13:07 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        michael.auchter@ni.com
Subject: [PATCH v9 5/5] remoteproc: Add initial zynqmp R5 remoteproc driver
Date:   Wed, 26 Aug 2020 09:13:07 -0700
Message-Id: <20200826161307.1064-6-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826161307.1064-1-ben.levinsky@xilinx.com>
References: <20200826161307.1064-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7a9f83ae-4f1a-4207-58f7-08d849daecdb
X-MS-TrafficTypeDiagnostic: BL0PR02MB4419:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4419418FDB6192797BEC0BECB5540@BL0PR02MB4419.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8o4f9JtMddAJbKaQcqh0uTXGQWOCUwf/xN1UEDwK/ikvMFb3m9hvXrEBxqC+V2NrVnElnfgzquEthI8GB3ki1SDvrL1Z00HAE9AuVl6oOlSFih8zndUApZ+8yTd/p04C9Wc8OJMKSjpbp6EGJvWxnVBRQtQhY+b4k2P4tVy2TpFWbOUaWpKqA8QF+AIbv2oVt2cDH9UWT5yOYoZKMk8c5+IC8Im2CNrJ6Bfx+0RGf2o9+B4/zHj1NrEW5ls9TcQKP8xRRR5ilkOWNf/0+RT4sNpwhgeY3SkNWaxsuEPd/IRRBYAtA0/+zPZSD5zQEA/rmTwcDicQ2dqefS4+Uyajt5eAwWsvMlYpgfp3B5kdbpklLjUZ6zswuKpUTSvj9oAMqdlix7396ht4uuOYm82Qbg==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(346002)(136003)(396003)(376002)(46966005)(316002)(426003)(6636002)(9786002)(2906002)(47076004)(478600001)(186003)(7696005)(83380400001)(70586007)(82740400003)(82310400002)(356005)(81166007)(36756003)(2616005)(336012)(70206006)(8676002)(30864003)(1076003)(44832011)(5660300002)(8936002)(26005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 16:13:09.8331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9f83ae-4f1a-4207-58f7-08d849daecdb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
remotproc driver, we can boot the R5 sub-system in different 2
configurations: split or lock-step.

The Xilinx R5 Remoteproc Driver boots the R5's via calls to the Xilinx
Platform Management Unit that handles the R5 configuration, memory access
and R5 lifecycle management. The interface to this manager is done in this
driver via zynqmp_pm_* function calls.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
Signed-off-by: Jason Wu <j.wu@xilinx.com>
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
 - parse_fw change from use of rproc_of_resm_mem_entry_init to
 rproc_mem_entry_init and use of alloc/release
 - var's of type zynqmp_r5_pdata all have same local variable name
 - use dev_dbg instead of dev_info
 v6:
 - adding memory carveouts is handled much more similarly. All mem
 carveouts are
   now described in reserved memory as needed. That is, TCM nodes are not
   coupled to remoteproc anymore. This is reflected in the remoteproc R5
 driver
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
 - remove zynqmp_r5_remoteproc_probe call of platform_set_drvdata as
 pdata is
   handled in zynqmp_r5_remoteproc_remove
v8:
 - remove old acks, reviewed-by's in commit message
v9:
- as mboxes are now optional, if pdata->tx_mc_skbs not initialized then
  do not call skb_queue_empty
- update usage for zynqmp_pm_set_rpu_mode, zynqmp_pm_set_tcm_config and
  zynqmp_pm_get_rpu_mode
- update 5/5 patch commit message to document supported configurations
  and how they are booted by the driver.
- remove copyrights other than SPDX from zynqmp_r5_remoteproc.c
- compilation warnings no longer raised
- remove unused includes from zynqmp_r5_remoteproc.c
- remove unused  var autoboot from zynqmp_r5_remoteproc.c
- reorder zynqmp_r5_pdata fpr small mem savings due to alignment
- use of zynqmp_pm_set_tcm_config now does not have
  output arg
- in tcm handling, unconditionally use &= 0x000fffff mask since all nodes
  in this fn are for tcm
- update comments for translating dma field in tcm handling to device
  address
- update calls to rproc_mem_entry_init in parse_mem_regions so that there
  are only 2 cases for types of carveouts instead of 3
- in parse_mem_regions, check if device tree node is null before using it
- add example device tree nodes used in parse_mem_regions and tcm parsing
- add comment for vring id node length
- add check for string length so that vring id is at least min length
- move tcm nodes from reserved mem to instead own device tree nodes
   and only use them if enabled in device tree
- add comment for explaining handling of rproc_elf_load_rsc_table
- remove obsolete check for "if (vqid < 0)" in zynqmp_r5_rproc_kick
- remove unused field mems in struct zynqmp_r5_pdata
- remove call to zynqmp_r5_mem_probe and the fn itself as tcm handling
  is done by zyqmp_r5_pm_request_tcm
- remove obsolete setting of dma_ops and parent device dma_mask
- remove obsolete use of of_dma_configure
- add comment for call to r5_set_mode fn
- make mbox usage optional and gracefully inform user via dev_dbg if not
  present
- change var lockstep_mode from u32* to u32
---
 drivers/remoteproc/Kconfig                |  10 +
 drivers/remoteproc/Makefile               |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c | 898 ++++++++++++++++++++++
 3 files changed, 909 insertions(+)
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c4d1731295eb..dd9ed45654e0 100644
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
+	  Say y or m here to support ZynqMP R5 remote processors via the remote
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
index 000000000000..2fbcccfe538c
--- /dev/null
+++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
@@ -0,0 +1,898 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq R5 Remote Processor driver
+ *
+ * Based on origin OMAP and Zynq Remote Processor driver
+ *
+ */
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/zynqmp-ipi-message.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/skbuff.h>
+#include <linux/sysfs.h>
+
+#include "remoteproc_internal.h"
+
+#define MAX_RPROCS	2 /* Support up to 2 RPU */
+#define MAX_MEM_PNODES	4 /* Max power nodes for one RPU memory instance */
+
+#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
+
+/* PM proc states */
+#define PM_PROC_STATE_ACTIVE 1U
+
+/* IPI buffer MAX length */
+#define IPI_BUF_LEN_MAX	32U
+/* RX mailbox client buffer max length */
+#define RX_MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
+				 sizeof(struct zynqmp_ipi_message))
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
+ * @is_r5_mode_set: indicate if r5 operation mode is set
+ * @tx_mc: tx mailbox client
+ * @rx_mc: rx mailbox client
+ * @tx_chan: tx mailbox channel
+ * @rx_chan: rx mailbox channel
+ * @mbox_work: mbox_work for the RPU remoteproc
+ * @tx_mc_skbs: socket buffers for tx mailbox client
+ * @rx_mc_buf: rx mailbox client buffer to save the rx message
+ */
+struct zynqmp_r5_pdata {
+	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
+	struct mbox_client tx_mc;
+	struct mbox_client rx_mc;
+	struct work_struct mbox_work;
+	struct sk_buff_head tx_mc_skbs;
+	struct device dev;
+	struct rproc *rproc;
+	struct mbox_chan *tx_chan;
+	struct mbox_chan *rx_chan;
+	u32 pnode_id;
+	bool is_r5_mode_set;
+};
+
+/**
+ * table of RPUs
+ */
+struct zynqmp_r5_pdata rpus[MAX_RPROCS];
+/**
+ * RPU core configuration
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
+	ret = zynqmp_pm_get_rpu_mode(pdata->pnode_id, val);
+	if (ret < 0) {
+		dev_err(dev, "failed to get RPU oper mode.\n");
+		return ret;
+	}
+	if (val[0] == expect) {
+		dev_dbg(dev, "RPU mode matches: %x\n", val[0]);
+	} else {
+		ret = zynqmp_pm_set_rpu_mode(pdata->pnode_id,
+					     expect, 0);
+		if (ret < 0) {
+			dev_err(dev,
+				"failed to set RPU oper mode.\n");
+			return ret;
+		}
+	}
+
+	tcm_mode = (expect == (u32)PM_RPU_MODE_LOCKSTEP) ?
+		    PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
+	ret = zynqmp_pm_set_tcm_config(pdata->pnode_id, tcm_mode, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to config TCM to %x.\n",
+			expect);
+		return ret;
+	}
+	pdata->is_r5_mode_set = true;
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
+	ret = zynqmp_pm_request_wake(pdata->pnode_id, 1,
+				     bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
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
+	ret = zynqmp_pm_force_pwrdwn(pdata->pnode_id,
+				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+	if (ret < 0) {
+		dev_err(&pdata->dev, "failed to shutdown R5.\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int zynqmp_r5_rproc_mem_alloc(struct rproc *rproc,
+				     struct rproc_mem_entry *mem)
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
+		if (!node) {
+			dev_err(dev, "no memory-region specified\n");
+			return -EINVAL;
+		}
+
+		rmem = of_reserved_mem_lookup(node);
+		if (!rmem) {
+			dev_err(dev, "unable to acquire memory-region\n");
+			return -EINVAL;
+		}
+
+		if (strstr(node->name, "vdev0vring")) {
+			int vring_id;
+			char name[16];
+
+			/*
+			 * expecting form of "rpuXvdev0vringX as documented
+			 * in xilinx remoteproc device tree binding
+			 */
+			if (strlen(node->name) < 14) {
+				dev_err(dev, "%s has to be at least 14 chars",
+					node->name);
+				return -EINVAL;
+			}
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
+			/* Register DMA region */
+			int (*alloc)(struct rproc *r,
+				     struct rproc_mem_entry *rme);
+			int (*release)(struct rproc *r,
+				       struct rproc_mem_entry *rme);
+			char name[20];
+
+			if (strstr(node->name, "vdev0buffer")) {
+				alloc = NULL;
+				release = NULL;
+				strcpy(name, "vdev0buffer");
+			} else {
+				alloc = zynqmp_r5_rproc_mem_alloc;
+				release = zynqmp_r5_rproc_mem_release;
+				strcpy(name, node->name);
+			}
+
+			mem = rproc_mem_entry_init(dev, NULL,
+						   (dma_addr_t)rmem->base,
+						   rmem->size, rmem->base,
+						   alloc, release, name);
+			if (!mem) {
+				dev_err(dev, "unable to initialize memory-region %s\n",
+					node->name);
+				return -ENOMEM;
+			}
+			dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
+				mem->dma);
+		}
+		rproc_add_carveout(rproc, mem);
+	}
+
+	return 0;
+}
+
+/* call Xilix Platform manager to request access to TCM bank */
+static int zyqmp_r5_pm_request_tcm(struct device_node *tcm_node,
+				   struct device *dev)
+{
+	u32 pnode_id;
+	int ret;
+
+	ret = of_property_read_u32(tcm_node, "pnode-id", &pnode_id);
+	if (ret) {
+		dev_err(dev, "Can't parse pnode-id property\n");
+		return ret;
+	}
+
+	ret = zynqmp_pm_request_node(pnode_id, ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+	if (ret < 0) {
+		dev_err(dev, "failed to request power node: %u\n", pnode_id);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Given tcm bank entry,
+ * this callback will set device address for R5 running on TCM
+ * and also setup virtual address for tcm bank remoteproc carveout
+ */
+static int tcm_mem_alloc(struct rproc *rproc,
+			 struct rproc_mem_entry *mem)
+{
+	void *va;
+	struct device *dev = rproc->dev.parent;
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
+	va = devm_ioremap_wc(dev, mem->da, mem->len);
+	if (!va)
+		return -ENOMEM;
+	/* As R5 is 32 bit, wipe out extra high bits */
+	mem->da &= 0x000fffff;
+	/*
+	 * handle tcm banks 1 a and b (0xffe90000 and oxffeb0000)
+	 * As both of these the only common bit found not in tcm bank0 a or b
+	 * is at 0x80000 use this mask to suss it out
+	 */
+	if (mem->da & 0x80000)
+		/*
+		 * similar to wiping tcm banks 0a and 0b with just the
+		 * mask of 0x000fffff will translate to device addr's
+		 * at 0x0 and 0x20000, need to do more to further translate
+		 * tcm banks 1a and 1b at 0xffe90000 and oxffeb0000
+		 * respectively to 0x0 and 0x20000
+		 */
+		mem->da -= 0x90000;
+
+	return 0;
+}
+
+/*
+ * Given R5 node in remoteproc instance,
+ * allocate remoteproc carveout for TCM memory
+ * needed for firmware to be loaded
+ */
+static int parse_tcm_banks(struct rproc *rproc)
+{
+	int ret;
+	struct device_node *dt_node;
+	int tcm_bank_idx, tcm_bank_done;
+	char tcm_str[10];
+	struct resource rsc;
+	resource_size_t size;
+	struct rproc_mem_entry *mem;
+
+	struct zynqmp_r5_pdata *pdata = rproc->priv;
+	struct device *dev = &pdata->dev;
+
+	/* set start and stop for loop through tcm banks. */
+	if (rpu_mode == PM_RPU_MODE_SPLIT) {
+		/*
+		 * In split mode, R50 can use TCM banks
+		 * 0a, 0b and R51 can use 1a, 1b
+		 *
+		 * indices relate to the power node id that will
+		 * then be translated by Xilinx Platform Manager
+		 */
+		tcm_bank_idx = (pdata->pnode_id == 0x7) ? 0 : 2;
+		tcm_bank_done = tcm_bank_idx + 2;
+	} else {
+		/* if RPU in lockstep, all banks are available */
+		tcm_bank_idx = 0;
+		tcm_bank_done = tcm_bank_idx + 4;
+	}
+
+	/* process TCM bank nodes in device tree */
+	for (; tcm_bank_idx < tcm_bank_done ; tcm_bank_idx++) {
+		/* construct tcm bank name */
+		strcpy(tcm_str, "tcm_");
+		strcat(tcm_str, (tcm_bank_idx <= 0x10) ? "0" : "1");
+		strcat(tcm_str, (tcm_bank_idx & 0x1) ? "b" : "a");
+
+		dt_node = of_find_node_by_name(NULL, tcm_str);
+		if (dt_node && of_device_is_available(dt_node)) {
+			dev_dbg(dev, "node %s is available\n", tcm_str);
+
+			/* get address */
+			ret = of_address_to_resource(dt_node, 0, &rsc);
+			if (ret < 0) {
+				dev_err(dev, "fail to get rsc mem %s",
+					of_node_full_name(dt_node));
+				return -EINVAL;
+			}
+
+			/* request access */
+			zyqmp_r5_pm_request_tcm(dt_node, dev);
+
+			/* add carveout */
+			size = resource_size(&rsc);
+			mem = rproc_mem_entry_init(dev, NULL, rsc.start,
+						   (int)size, rsc.start,
+						   tcm_mem_alloc,
+						   zynqmp_r5_mem_release,
+						   rsc.name);
+			if (!mem)
+				return -ENOMEM;
+
+			rproc_add_carveout(rproc, mem);
+		} else {
+			dev_info(dev, "node %s is not available\n", tcm_str);
+		}
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
+	ret = parse_tcm_banks(rproc);
+	if (ret) {
+		dev_err(dev, "parse_tcm_banks failed %x\n", ret);
+		return ret;
+	}
+
+	ret = parse_mem_regions(rproc);
+	if (ret) {
+		dev_err(dev, "parse_mem_regions failed %x\n", ret);
+		return ret;
+	}
+
+	ret = rproc_elf_load_rsc_table(rproc, fw);
+	if (ret == -EINVAL) {
+		/*
+		 * resource table only required for IPC.
+		 * if not present, this is not necessarily an error;
+		 * for example, loading r5 hello world application
+		 * so simply inform user and keep going.
+		 */
+		dev_info(dev, "no resource table found.\n");
+		ret = 0;
+	}
+	return ret;
+}
+
+/* kick a firmware */
+static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct sk_buff *skb;
+	unsigned int skb_len;
+	struct zynqmp_ipi_message *mb_msg;
+	int ret;
+
+	struct device *dev = rproc->dev.parent;
+	struct zynqmp_r5_pdata *pdata = rproc->priv;
+
+	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n", vqid);
+
+	skb_len = (unsigned int)(sizeof(vqid) + sizeof(mb_msg));
+	skb = alloc_skb(skb_len, GFP_ATOMIC);
+	if (!skb) {
+		dev_err(dev,
+			"Failed to allocate skb to kick remote.\n");
+		return;
+	}
+	mb_msg = (struct zynqmp_ipi_message *)skb_put(skb, skb_len);
+	mb_msg->len = sizeof(vqid);
+	memcpy(mb_msg->data, &vqid, sizeof(vqid));
+	skb_queue_tail(&pdata->tx_mc_skbs, skb);
+	ret = mbox_send_message(pdata->tx_chan, mb_msg);
+	if (ret < 0) {
+		dev_warn(dev, "Failed to kick remote.\n");
+		skb_dequeue_tail(&pdata->tx_mc_skbs);
+		kfree_skb(skb);
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
+
+	/* Discard all SKBs if tx_mc_skbs is initialized */
+	if (&pdata->tx_mc_skbs.prev) {
+		while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
+			skb = skb_dequeue(&pdata->tx_mc_skbs);
+			kfree_skb(skb);
+		}
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
+
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
+	pdata->rproc = rproc;
+	rproc->priv = pdata;
+
+	/* Set up DMA mask */
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n", ret);
+		return ret;
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
+	/*
+	 * Set up R5 if not already setup
+	 * This check is needed as there are cases where
+	 * a user might repeatedly do modprobe
+	 * and modprobe -r. In this case, upon a
+	 * subsequent load, this check is needed.
+	 */
+	ret = pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
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
+	platform_set_drvdata(pdev, pdata);
+
+	of_property_read_u32(dev->of_node, "lockstep-mode", &lockstep_mode);
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
+MODULE_AUTHOR("Ben Levinsky <ben.levinsky@xilinx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2385920720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="h3M99itF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgHUSLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:11:21 -0400
Received: from mail-mw2nam10on2092.outbound.protection.outlook.com ([40.107.94.92]:30049
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbgHUSLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMF0t/xIhxDKnUsOLRH/Ksx3XmNczNEz6M2PYvBvUB0NqZqam6zhbrpYj1gPmTmswTRmnKdHMHDODKPfD9b2aLU75tudEJCGPAL6f1VpH76TL2fnvqEdjvGufbenyOpFQ/3uEO4kxXR7B0FtME95Lkw1RPJ1zlojo9kKfLhvYc/Bfx/t9Dl1dG9/nrPsqk2fxhnV10NbOBJhL3OPSVaDIRzx4XchT+su4SwhhvdqmimGASYHuV+yvg32l6lOw8TtZyLMHQtOY32urc7eZbr3uEzGjLF6fjusiNCso7XdyZMY7oIyfzZ4CYWcNOPBFdF5mQc8utFayXY/m+1CvVy/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzd14vexbJl459l4uphI6fdKnPud8LnubJqGwnqlHZQ=;
 b=ckkZeN50PWVImBMgqEQl0Zm9zinPVYBUtcenEQV2VUtAa+MRUfl822jhDPK1avFP0IemJVET2gVMSGogoybmogejSph7ZL2UxSRqGRf98PFlJzjTg8i884Gw69CkdxlUF3rHBpP41rnXvMAo66EczCPogFSFQUhSBEge2pQ+7PS+0dkJDXHpQQ3WynonOfNHs1HRTWrzNv15l+cZsLuvMPWSkmsz01X6Rj5FKHAB4AryCGRwc/9JLiRYZ+Q3cVClpFEqpldVjSqs0QMey6G5L0sDZF82gqCl9t9SvcAjYkVfhOzOfxDEgX3IJX01zZ5/zF5v56EA4X8Fy8n4FYWbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzd14vexbJl459l4uphI6fdKnPud8LnubJqGwnqlHZQ=;
 b=h3M99itFhjKT6uCWuJewYb1YkiuiflSxlf6p2js8z+qJXa6erRCtDbDgzbgVlgmkqz3sumT5SU2e/WkxmtH2GtBKAPi33CjxZs9a3cABM4AyORg8HU275HiKU9yswkpsf+UvHjCrgDmWGAB5jRCPa5OP7elnD6mhhZE5NEN3/wg=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4023.prod.exchangelabs.com (2603:10b6:a03:11::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.24; Fri, 21 Aug 2020 18:11:02 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::bcc1:5d0a:6c11:9320]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::bcc1:5d0a:6c11:9320%3]) with mapi id 15.20.3305.026; Fri, 21 Aug 2020
 18:11:02 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] driver/perf: Add PMU driver for the ARM DMC-620 memory controller
Date:   Fri, 21 Aug 2020 11:10:48 -0700
Message-Id: <1598033450-30145-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::49) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:e0::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.10 via Frontend Transport; Fri, 21 Aug 2020 18:11:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bd05467-69ef-4f05-2913-08d845fd8f85
X-MS-TrafficTypeDiagnostic: BYAPR01MB4023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB40231309BB00ADF83EBAFA23E05B0@BYAPR01MB4023.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRSaTDEeN5Xrz1Ac33wnptCjqlVg9kMyF7IkJBXXpCAqaJX64M0C6ke7iftaFbq2Bfh+HMYcXfiCmDdHEcyoSnLAy2Gz5IjAJ8xLECRRCePXtIM1GmvHIRJcLB2QCiorX10NJJCTWdzRy64/twYrUjiAKReAjOJQcoKDe9BPAmZJ/+NeJXeQIOjp8YWQwFCB2AZhfAe204FDEeaKjNdCcBVyKA7mp54OLo7jfPh250dkam9cz5B6JA3+aDtVSYjtDUsrdo7dJijJ+qImQo2tIZsi68zTZhRq/+8+o7wTQifdU0ytdO/VBm+ZL+lWElAZIsqjAgQ+lFUe3drdkWu+ovvFzOY18JOx6saFHevnUhMiaPROjQAFUzx7njrk6sFMGfVsAQfUTQwrSInPQ4bQvO0xLZ0XvCQyvvG7Ug0gz8qrbTGeyIOHWsxR6wcxcHsvURcZLS9iBhLFLT41bPy3wFVSDubXyIBP/IOYYQb7Ye8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(366004)(346002)(396003)(136003)(966005)(5660300002)(66946007)(478600001)(4326008)(52116002)(8676002)(66556008)(66476007)(8936002)(2906002)(86362001)(316002)(109986005)(16576012)(30864003)(2616005)(956004)(26005)(6666004)(110011004)(186003)(54906003)(6486002)(83380400001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: d1IID55YuguU0feurJQmwk2XJXK1eTrNIF3xOqUTMyE4FN/22oOBm4v9TTuQNW4P/9PIeoYFsyky6NYtDy3SX1abua1Ei5aEPWh72TrX2J3lIYIIGmrUtaMh7h3gvSOZXE0vfC7M4NedbEmwPQBAY++WacosP2vVciEyHLaauvkwJLW1nFpyCTTMcteda5uN70qNhPO+zxD3jOONkXBA2CIrx/wKE7sHtrG13qScLR2hdkje01sPibcxDaSUVXwQ2oaR8rfi3vyw0hMRcvfiK9Lv/EYue6ivrxGYvfWIbHtpKL8TOkaDwn9zAfY97AjNdmq3xtSe97Le1iNsH2xT9zrbJLLAOs+LiHEFQznpBkZQLvG7QvQ/nZg3hGKBHnCqHEjjiDRpHRABsije32ZyeM6sOVPyBGw9/WZ0DHzGDukcVAF+pb9E9HRnzfu63zmVuB95JVg8rouoJDNvLWVvmrqg3k7QL/t96h+CkRTS447C420rOQFXUhQRcwODCLBbLWBk5InxGeC8WLAXBbSOVmoX0+uMjtO3HeQhLYwiRzv17a4x0FHjx+QCHMxvglWMwVXub/x941wy3HMd/M9eNfzSt2wxl2HkcB6Cg/fqVU9oFkyARNAV5dQoR0rc9RyafB0SnuaJYS7NNz8Lk8nQhA==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd05467-69ef-4f05-2913-08d845fd8f85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 18:11:02.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXSGRAcudl4+Q2Kq3vLsAJ5JqC5AADtOjvuPiMWcrT7ha3UPpE6V7UwvZPf9iotyGGzSDYLtWqDwPcd81Zs+I5bdvT/FU9mP3ygXuwX6YgGPFAKHKyWE8lyt7QKEz72N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4023
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMC-620 PMU supports total 10 counters which each is
independently programmable to different events and can
be started and stopped individually.

Currently, it only supports ACPI. Other platforms feel free to test and add
support for device tree.

Usage example:
  #perf stat -e arm_dmc620_10008c000/clk_cycle_count/ -C 0
  Get perf event for clk_cycle_count counter.

  #perf stat -e arm_dmc620_10008c000/clkdiv2_allocate,mask=0x1f,match=0x2f,
  incr=2,invert=1/ -C 0
  The above example shows how to specify mask, match, incr,
  invert parameters for clkdiv2_allocate event.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
Changes in v3:
- Removed "_OFFSET" suffix.
- Renamed "affinity" to "irq".
- Have a better definition of group register.

Changes in v2:
- Removed IRQF_SHARED flag and added support for multiple 
PMUs sharing the same interrupt.
- Fixed an interrupt handler race condition.

The ACPI binding spec for PMU DMC620 can be downloaded at:
https://developer.arm.com/documentation/den0093/c/

 drivers/perf/Kconfig          |   8 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/arm_dmc620_pmu.c | 880 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 889 insertions(+)
 create mode 100644 drivers/perf/arm_dmc620_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 7305d57..240cc3e 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -123,6 +123,14 @@ config ARM_SPE_PMU
 	  Extension, which provides periodic sampling of operations in
 	  the CPU pipeline and reports this via the perf AUX interface.
 
+config ARM_DMC620_PMU
+	tristate "Enable PMU support for the ARM DMC-620 memory controller"
+	depends on ARM64 && ACPI
+	default n
+	help
+	  Support for PMU events monitoring on the ARM DMC-620 memory
+	  controller.
+
 source "drivers/perf/hisilicon/Kconfig"
 
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 2ebb4de..5d577d1 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
+obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
new file mode 100644
index 0000000..811c4de
--- /dev/null
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -0,0 +1,880 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ARM DMC-620 memory controller PMU driver
+ *
+ * Copyright (C) 2020 Ampere Computing LLC.
+ */
+
+#define DMC620_PMUNAME		"arm_dmc620"
+#define DMC620_DRVNAME		DMC620_PMUNAME "_pmu"
+#define pr_fmt(fmt)		DMC620_DRVNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/perf_event.h>
+#include <linux/perf/arm_pmu.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/rculist.h>
+#include <linux/refcount.h>
+
+#define DMC620_PA_SHIFT					12
+#define DMC620_CNT_MAX_PERIOD				0xffffffff
+#define DMC620_PMU_CLKDIV2_MAX_COUNTERS			8
+#define DMC620_PMU_CLK_MAX_COUNTERS			2
+#define DMC620_PMU_MAX_COUNTERS				\
+	(DMC620_PMU_CLKDIV2_MAX_COUNTERS + DMC620_PMU_CLK_MAX_COUNTERS)
+
+/*
+ * The PMU registers start at 0xA00 in the DMC-620 memory map, and these
+ * offsets are relative to that base.
+ *
+ * Each counter has a group of control/value registers, and the
+ * DMC620_PMU_COUNTERx offsets are within a counter group.
+ *
+ * The counter registers groups start at 0xA10.
+ */
+#define DMC620_PMU_OVERFLOW_STATUS_CLKDIV2		0x8
+#define  DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_MASK	\
+		(DMC620_PMU_CLKDIV2_MAX_COUNTERS - 1)
+#define DMC620_PMU_OVERFLOW_STATUS_CLK			0xC
+#define  DMC620_PMU_OVERFLOW_STATUS_CLK_MASK		\
+		(DMC620_PMU_CLK_MAX_COUNTERS - 1)
+#define DMC620_PMU_COUNTERS_BASE			0x10
+#define DMC620_PMU_COUNTERx_MASK_31_00			0x0
+#define DMC620_PMU_COUNTERx_MASK_63_32			0x4
+#define DMC620_PMU_COUNTERx_MATCH_31_00			0x8
+#define DMC620_PMU_COUNTERx_MATCH_63_32			0xC
+#define DMC620_PMU_COUNTERx_CONTROL			0x10
+#define  DMC620_PMU_COUNTER_CONTROLx_ENABLE_MASK	BIT(0)
+#define  DMC620_PMU_COUNTER_CONTROLx_INVERT_SHIFT	1
+#define  DMC620_PMU_COUNTER_CONTROLx_EVENT_MUX		(((x)&0x1f)>>2)
+#define  DMC620_PMU_COUNTER_CONTROLx_EVENT_MUX_SHIFT	2
+#define  DMC620_PMU_COUNTERx_CONTROL_INCR		(((x)&0x1ff)>>7)
+#define  DMC620_PMU_COUNTERx_CONTROL_INCR_SHIFT		7
+#define DMC620_PMU_COUNTERx_SNAPSHOT			0x18
+#define DMC620_PMU_COUNTERx_VALUE			0x20
+/* Offset of the registers for a given counter, relative to 0xA00 */
+#define DMC620_PMU_COUNTERx_OFFSET(x) \
+	(DMC620_PMU_COUNTERS_BASE + 0x28 * (x))
+
+#define DMC620_PMU_CLKDIV2_CYCLE_COUNT			0x0
+#define DMC620_PMU_CLKDIV2_ALLOCATE			0x1
+#define DMC620_PMU_CLKDIV2_QUEUE_DEPTH			0x2
+#define DMC620_PMU_CLKDIV2_WAITING_FOR_WR_DATA		0x3
+#define DMC620_PMU_CLKDIV2_READ_BACKLOG			0x4
+#define DMC620_PMU_CLKDIV2_WAITING_FOR_MI		0x5
+#define DMC620_PMU_CLKDIV2_HAZARD_RESOLUTION		0x6
+#define DMC620_PMU_CLKDIV2_ENQUEUE			0x7
+#define DMC620_PMU_CLKDIV2_ARBITRATE			0x8
+#define DMC620_PMU_CLKDIV2_LRANK_TURNAROUND_ACTIVATE	0x9
+#define DMC620_PMU_CLKDIV2_PRANK_TURNAROUND_ACTIVATE	0xA
+#define DMC620_PMU_CLKDIV2_READ_DEPTH			0xB
+#define DMC620_PMU_CLKDIV2_WRITE_DEPTH			0xC
+#define DMC620_PMU_CLKDIV2_HIGHHIGH_QOS_DEPTH		0xD
+#define DMC620_PMU_CLKDIV2_HIGH_QOS_DEPTH		0xE
+#define DMC620_PMU_CLKDIV2_MEDIUM_QOS_DEPTH		0xF
+#define DMC620_PMU_CLKDIV2_LOW_QOS_DEPTH		0x10
+#define DMC620_PMU_CLKDIV2_ACTIVATE			0x11
+#define DMC620_PMU_CLKDIV2_RDWR				0x12
+#define DMC620_PMU_CLKDIV2_REFRESH			0x13
+#define DMC620_PMU_CLKDIV2_TRAINING_REQUEST		0x14
+#define DMC620_PMU_CLKDIV2_T_MAC_TRACKER		0x15
+#define DMC620_PMU_CLKDIV2_BK_FSM_TRACKER		0x16
+#define DMC620_PMU_CLKDIV2_BK_OPEN_TRACKER		0x17
+#define DMC620_PMU_CLKDIV2_RANKS_IN_PWR_DOWN		0x18
+#define DMC620_PMU_CLKDIV2_RANKS_IN_SREF		0x19
+#define DMC620_PMU_CLK_CYCLE_COUNTER			0x20
+#define DMC620_PMU_CLK_REQUEST				0x21
+#define DMC620_PMU_CLK_UPLOAD_STALL			0x22
+#define DMC620_PMU_CLK_INDICATE_MASK			0x20
+
+static LIST_HEAD(dmc620_pmu_irqs);
+static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
+
+struct dmc620_pmu_irq {
+	struct hlist_node node;
+	struct list_head pmus_node;
+	struct list_head irqs_node;
+	refcount_t refcount;
+	unsigned int irq_num;
+	unsigned int cpu;
+};
+
+struct dmc620_pmu {
+	struct pmu pmu;
+	struct platform_device *pdev;
+
+	void __iomem *base;
+	struct dmc620_pmu_irq *irq;
+	struct list_head pmus_node;
+
+	/*
+	 * We put all clkdiv2 and clk counters to a same array.
+	 * The first DMC620_PMU_CLKDIV2_MAX_COUNTERS bits belong to
+	 * clkdiv2 counters, the last DMC620_PMU_CLK_MAX_COUNTERS
+	 * belong to clk counters.
+	 */
+	DECLARE_BITMAP(used_mask, DMC620_PMU_MAX_COUNTERS);
+	struct perf_event *events[DMC620_PMU_MAX_COUNTERS];
+};
+
+#define to_dmc620_pmu(p) (container_of(p, struct dmc620_pmu, pmu))
+
+static int cpuhp_state_num;
+
+static ssize_t
+dmc620_pmu_events_sysfs_show(struct device *dev,
+			   struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%03llx\n", pmu_attr->id);
+}
+
+#define DMC620_PMU_EVENT_ATTR(name, config)			\
+	PMU_EVENT_ATTR(name, dmc620_pmu_event_attr_##name,	\
+		       config, dmc620_pmu_events_sysfs_show)
+
+/* clkdiv2 events list */
+DMC620_PMU_EVENT_ATTR(clkdiv2_cycle_count,
+		DMC620_PMU_CLKDIV2_CYCLE_COUNT);
+DMC620_PMU_EVENT_ATTR(clkdiv2_allocate,
+		DMC620_PMU_CLKDIV2_ALLOCATE);
+DMC620_PMU_EVENT_ATTR(clkdiv2_queue_depth,
+		DMC620_PMU_CLKDIV2_QUEUE_DEPTH);
+DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_wr_data,
+		DMC620_PMU_CLKDIV2_WAITING_FOR_WR_DATA);
+DMC620_PMU_EVENT_ATTR(clkdiv2_read_backlog,
+		DMC620_PMU_CLKDIV2_READ_BACKLOG);
+DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_mi,
+		DMC620_PMU_CLKDIV2_WAITING_FOR_MI);
+DMC620_PMU_EVENT_ATTR(clkdiv2_hazard_resolution,
+		DMC620_PMU_CLKDIV2_HAZARD_RESOLUTION);
+DMC620_PMU_EVENT_ATTR(clkdiv2_enqueue,
+		DMC620_PMU_CLKDIV2_ENQUEUE);
+DMC620_PMU_EVENT_ATTR(clkdiv2_arbitrate,
+		DMC620_PMU_CLKDIV2_ARBITRATE);
+DMC620_PMU_EVENT_ATTR(clkdiv2_lrank_turnaround_activate,
+		DMC620_PMU_CLKDIV2_LRANK_TURNAROUND_ACTIVATE);
+DMC620_PMU_EVENT_ATTR(clkdiv2_prank_turnaround_activate,
+		DMC620_PMU_CLKDIV2_PRANK_TURNAROUND_ACTIVATE);
+DMC620_PMU_EVENT_ATTR(clkdiv2_read_depth,
+		DMC620_PMU_CLKDIV2_READ_DEPTH);
+DMC620_PMU_EVENT_ATTR(clkdiv2_write_depth,
+		DMC620_PMU_CLKDIV2_WRITE_DEPTH);
+DMC620_PMU_EVENT_ATTR(clkdiv2_highigh_qos_depth,
+		DMC620_PMU_CLKDIV2_HIGHHIGH_QOS_DEPTH);
+DMC620_PMU_EVENT_ATTR(clkdiv2_high_qos_depth,
+		DMC620_PMU_CLKDIV2_HIGH_QOS_DEPTH);
+DMC620_PMU_EVENT_ATTR(clkdiv2_medium_qos_depth,
+		DMC620_PMU_CLKDIV2_MEDIUM_QOS_DEPTH);
+DMC620_PMU_EVENT_ATTR(clkdiv2_low_qos_depth,
+		DMC620_PMU_CLKDIV2_LOW_QOS_DEPTH);
+DMC620_PMU_EVENT_ATTR(clkdiv2_activate,
+		DMC620_PMU_CLKDIV2_ACTIVATE);
+DMC620_PMU_EVENT_ATTR(clkdiv2_rdwr,
+		DMC620_PMU_CLKDIV2_RDWR);
+DMC620_PMU_EVENT_ATTR(clkdiv2_refresh,
+		DMC620_PMU_CLKDIV2_REFRESH);
+DMC620_PMU_EVENT_ATTR(clkdiv2_training_request,
+		DMC620_PMU_CLKDIV2_TRAINING_REQUEST);
+DMC620_PMU_EVENT_ATTR(clkdiv2_t_mac_tracker,
+		DMC620_PMU_CLKDIV2_T_MAC_TRACKER);
+DMC620_PMU_EVENT_ATTR(clkdiv2_bk_fsm_tracker,
+		DMC620_PMU_CLKDIV2_BK_FSM_TRACKER);
+DMC620_PMU_EVENT_ATTR(clkdiv2_bk_open_tracker,
+		DMC620_PMU_CLKDIV2_BK_OPEN_TRACKER);
+DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_pwr_down,
+		DMC620_PMU_CLKDIV2_RANKS_IN_PWR_DOWN);
+DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_sref,
+		DMC620_PMU_CLKDIV2_RANKS_IN_SREF);
+
+/* clk events list */
+DMC620_PMU_EVENT_ATTR(clk_cycle_count,
+		DMC620_PMU_CLK_CYCLE_COUNTER);
+DMC620_PMU_EVENT_ATTR(clk_request,
+		DMC620_PMU_CLK_REQUEST);
+DMC620_PMU_EVENT_ATTR(clk_upload_stall,
+		DMC620_PMU_CLK_UPLOAD_STALL);
+
+static struct attribute *dmc620_pmu_events_attrs[] = {
+	&dmc620_pmu_event_attr_clkdiv2_cycle_count.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_allocate.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_queue_depth.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_waiting_for_wr_data.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_read_backlog.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_waiting_for_mi.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_hazard_resolution.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_enqueue.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_arbitrate.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_lrank_turnaround_activate.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_prank_turnaround_activate.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_read_depth.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_write_depth.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_highigh_qos_depth.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_high_qos_depth.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_medium_qos_depth.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_low_qos_depth.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_activate.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_rdwr.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_refresh.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_training_request.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_t_mac_tracker.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_bk_fsm_tracker.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_bk_open_tracker.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_ranks_in_pwr_down.attr.attr,
+	&dmc620_pmu_event_attr_clkdiv2_ranks_in_sref.attr.attr,
+	&dmc620_pmu_event_attr_clk_cycle_count.attr.attr,
+	&dmc620_pmu_event_attr_clk_request.attr.attr,
+	&dmc620_pmu_event_attr_clk_upload_stall.attr.attr,
+	NULL,
+};
+
+static struct attribute_group dmc620_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = dmc620_pmu_events_attrs,
+};
+
+/* User ABI */
+#define ATTR_CFG_FLD_mask_CFG		config
+#define ATTR_CFG_FLD_mask_LO		0
+#define ATTR_CFG_FLD_mask_HI		44
+#define ATTR_CFG_FLD_match_CFG		config1
+#define ATTR_CFG_FLD_match_LO		0
+#define ATTR_CFG_FLD_match_HI		44
+#define ATTR_CFG_FLD_invert_CFG		config2
+#define ATTR_CFG_FLD_invert_LO		0
+#define ATTR_CFG_FLD_invert_HI		0
+#define ATTR_CFG_FLD_incr_CFG		config2
+#define ATTR_CFG_FLD_incr_LO		1
+#define ATTR_CFG_FLD_incr_HI		2
+#define ATTR_CFG_FLD_event_CFG		config2
+#define ATTR_CFG_FLD_event_LO		3
+#define ATTR_CFG_FLD_event_HI		8
+
+#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
+	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
+
+#define _GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
+	__GEN_PMU_FORMAT_ATTR(cfg, lo, hi)
+
+#define GEN_PMU_FORMAT_ATTR(name)				\
+	PMU_FORMAT_ATTR(name,					\
+	_GEN_PMU_FORMAT_ATTR(ATTR_CFG_FLD_##name##_CFG,		\
+			     ATTR_CFG_FLD_##name##_LO,		\
+			     ATTR_CFG_FLD_##name##_HI))
+
+#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)			\
+	((((attr)->cfg) >> lo) & GENMASK(hi - lo, 0))
+
+#define ATTR_CFG_GET_FLD(attr, name)				\
+	_ATTR_CFG_GET_FLD(attr,					\
+			  ATTR_CFG_FLD_##name##_CFG,		\
+			  ATTR_CFG_FLD_##name##_LO,		\
+			  ATTR_CFG_FLD_##name##_HI)
+
+GEN_PMU_FORMAT_ATTR(mask);
+GEN_PMU_FORMAT_ATTR(match);
+GEN_PMU_FORMAT_ATTR(invert);
+GEN_PMU_FORMAT_ATTR(incr);
+GEN_PMU_FORMAT_ATTR(event);
+
+static struct attribute *dmc620_pmu_formats_attrs[] = {
+	&format_attr_mask.attr,
+	&format_attr_match.attr,
+	&format_attr_invert.attr,
+	&format_attr_incr.attr,
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group dmc620_pmu_format_attr_group = {
+	.name	= "format",
+	.attrs	= dmc620_pmu_formats_attrs,
+};
+
+static const struct attribute_group *dmc620_pmu_attr_groups[] = {
+	&dmc620_pmu_events_attr_group,
+	&dmc620_pmu_format_attr_group,
+	NULL,
+};
+
+static inline
+u32 dmc620_pmu_creg_read(struct dmc620_pmu *dmc620_pmu,
+					  unsigned int idx,
+					  unsigned int offset)
+{
+	return readl(dmc620_pmu->base +
+			DMC620_PMU_COUNTERx_OFFSET(idx) + offset);
+}
+
+static inline
+void dmc620_pmu_creg_write(struct dmc620_pmu *dmc620_pmu,
+				  unsigned int idx,
+				  unsigned int offset,
+				  u32 val)
+{
+	writel(val, dmc620_pmu->base +
+			DMC620_PMU_COUNTERx_OFFSET(idx) + offset);
+}
+
+static
+unsigned int dmc620_event_to_counter_control(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	unsigned int reg = 0;
+
+	reg |= ATTR_CFG_GET_FLD(attr, invert) <<
+		DMC620_PMU_COUNTER_CONTROLx_INVERT_SHIFT;
+	reg |= ATTR_CFG_GET_FLD(attr, incr) <<
+		DMC620_PMU_COUNTERx_CONTROL_INCR_SHIFT;
+	reg |= (ATTR_CFG_GET_FLD(attr, event) &
+		~DMC620_PMU_CLK_INDICATE_MASK) <<
+		DMC620_PMU_COUNTER_CONTROLx_EVENT_MUX_SHIFT;
+
+	return reg;
+}
+
+static int dmc620_get_event_idx(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	int idx, start_idx, end_idx;
+
+	if (ATTR_CFG_GET_FLD(&event->attr, event) &
+			DMC620_PMU_CLK_INDICATE_MASK) {
+		start_idx = DMC620_PMU_CLKDIV2_MAX_COUNTERS;
+		end_idx = DMC620_PMU_MAX_COUNTERS;
+	} else {
+		start_idx = 0;
+		end_idx = DMC620_PMU_CLKDIV2_MAX_COUNTERS;
+	}
+
+	for (idx = start_idx; idx < end_idx; ++idx) {
+		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
+			return idx;
+	}
+
+	/* The counters are all in use. */
+	return -EAGAIN;
+}
+
+static u64 dmc620_pmu_read_counter(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+
+	return dmc620_pmu_creg_read(dmc620_pmu,
+			  event->hw.idx,
+			  DMC620_PMU_COUNTERx_VALUE);
+}
+
+static void dmc620_pmu_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_count, new_count;
+
+	do {
+		/* We may also be called from the irq handler */
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = dmc620_pmu_read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count,
+			prev_count, new_count) != prev_count);
+	delta = (new_count - prev_count) & DMC620_CNT_MAX_PERIOD;
+	local64_add(delta, &event->count);
+}
+
+static void dmc620_pmu_event_set_period(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+
+	/*
+	 * All DMC-620 PMU event counters are 32bit counters.
+	 * To handle cases of extreme interrupt latency, we program
+	 * the counter with half of the max count for the counters.
+	 */
+	u32 val = DMC620_CNT_MAX_PERIOD >> 1;
+
+	local64_set(&event->hw.prev_count, val);
+	dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_VALUE,
+			  val);
+}
+
+static void dmc620_pmu_enable_counter(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	u32 reg;
+
+	reg = dmc620_pmu_creg_read(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL);
+	reg |= DMC620_PMU_COUNTER_CONTROLx_ENABLE_MASK;
+	dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL,
+			  reg);
+}
+
+static void dmc620_pmu_disable_counter(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	u32 reg;
+
+	reg = dmc620_pmu_creg_read(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL);
+	reg &= ~DMC620_PMU_COUNTER_CONTROLx_ENABLE_MASK;
+	dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL,
+			  reg);
+}
+
+static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
+{
+	struct dmc620_pmu_irq *irq = data;
+	struct dmc620_pmu *dmc620_pmu;
+	irqreturn_t ret = IRQ_NONE;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(dmc620_pmu,
+				  &irq->pmus_node, pmus_node) {
+		unsigned long status_clkdiv2, status_clk;
+		struct perf_event *event;
+		unsigned int idx;
+
+		status_clkdiv2 = readl(dmc620_pmu->base +
+				  DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
+		status_clk = readl(dmc620_pmu->base +
+				  DMC620_PMU_OVERFLOW_STATUS_CLK);
+		if (!status_clkdiv2 && !status_clk)
+			continue;
+
+		for (idx = 0; idx < DMC620_PMU_MAX_COUNTERS; idx++) {
+			event = dmc620_pmu->events[idx];
+			if (!event)
+				continue;
+			dmc620_pmu_disable_counter(event);
+		}
+
+		for_each_set_bit(idx, &status_clkdiv2,
+				  DMC620_PMU_CLKDIV2_MAX_COUNTERS) {
+			event = dmc620_pmu->events[idx];
+			if (WARN_ON_ONCE(!event))
+				continue;
+			dmc620_pmu_event_update(event);
+			dmc620_pmu_event_set_period(event);
+		}
+
+		for_each_set_bit(idx, &status_clk,
+				  DMC620_PMU_CLK_MAX_COUNTERS) {
+			event = dmc620_pmu->events[idx +
+				DMC620_PMU_CLKDIV2_MAX_COUNTERS];
+			if (WARN_ON_ONCE(!event))
+				continue;
+			dmc620_pmu_event_update(event);
+			dmc620_pmu_event_set_period(event);
+		}
+
+		if (status_clkdiv2)
+			writel(0, dmc620_pmu->base +
+				DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
+		if (status_clk)
+			writel(0, dmc620_pmu->base +
+				DMC620_PMU_OVERFLOW_STATUS_CLK);
+
+		for (idx = 0; idx < DMC620_PMU_MAX_COUNTERS; idx++) {
+			event = dmc620_pmu->events[idx];
+			if (!event)
+				continue;
+			if (!(event->hw.state & PERF_HES_STOPPED))
+				dmc620_pmu_enable_counter(event);
+		}
+		ret = IRQ_HANDLED;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
+{
+	struct dmc620_pmu_irq *irq;
+	int ret;
+
+	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
+		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
+			return irq;
+
+	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
+	if (!irq)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&irq->pmus_node);
+
+	/* Pick one CPU to be the preferred one to use */
+	irq->cpu = raw_smp_processor_id();
+	refcount_set(&irq->refcount, 1);
+
+	ret = request_irq(irq_num, dmc620_pmu_handle_irq,
+			  IRQF_NOBALANCING | IRQF_NO_THREAD,
+			  "dmc620-pmu", irq);
+	if (ret)
+		goto out_free_aff;
+
+	ret = irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
+	if (ret)
+		goto out_free_irq;
+
+	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
+	if (ret)
+		goto out_free_irq;
+
+	irq->irq_num = irq_num;
+	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
+
+	return irq;
+
+out_free_irq:
+	free_irq(irq_num, irq);
+out_free_aff:
+	kfree(irq);
+	return ERR_PTR(ret);
+}
+
+static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
+{
+	struct dmc620_pmu_irq *irq;
+
+	mutex_lock(&dmc620_pmu_irqs_lock);
+	irq = __dmc620_pmu_get_irq(irq_num);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+
+	if (IS_ERR(irq))
+		return PTR_ERR(irq);
+
+	dmc620_pmu->irq = irq;
+	mutex_lock(&dmc620_pmu_irqs_lock);
+	list_add_rcu(&dmc620_pmu->pmus_node, &irq->pmus_node);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+
+	return 0;
+}
+
+static void dmc620_pmu_put_irq(struct dmc620_pmu *dmc620_pmu)
+{
+	struct dmc620_pmu_irq *irq = dmc620_pmu->irq;
+
+	mutex_lock(&dmc620_pmu_irqs_lock);
+	list_del_rcu(&dmc620_pmu->pmus_node);
+
+	if (!refcount_dec_and_test(&irq->refcount)) {
+		mutex_unlock(&dmc620_pmu_irqs_lock);
+		return;
+	}
+
+	list_del(&irq->irqs_node);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+
+	free_irq(irq->irq_num, irq);
+	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &irq->node);
+	kfree(irq);
+}
+
+static int dmc620_pmu_event_init(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event *sibling;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * DMC 620 PMUs are shared across all cpus and cannot
+	 * support task bound and sampling events.
+	 */
+	if (is_sampling_event(event) ||
+		event->attach_state & PERF_ATTACH_TASK) {
+		dev_dbg(dmc620_pmu->pmu.dev,
+			"Can't support per-task counters\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0) {
+		dev_dbg(dmc620_pmu->pmu.dev,
+			"Per-task mode not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Many perf core operations (eg. events rotation) operate on a
+	 * single CPU context. This is obvious for CPU PMUs, where one
+	 * expects the same sets of events being observed on all CPUs,
+	 * but can lead to issues for off-core PMUs, where each
+	 * event could be theoretically assigned to a different CPU. To
+	 * mitigate this, we enforce CPU assignment to one, selected
+	 * processor.
+	 */
+	event->cpu = dmc620_pmu->irq->cpu;
+
+	/*
+	 * We must NOT create groups containing mixed PMUs, although software
+	 * events are acceptable.
+	 */
+	if (event->group_leader->pmu != event->pmu &&
+			!is_software_event(event->group_leader))
+		return -EINVAL;
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (sibling->pmu != event->pmu &&
+				!is_software_event(sibling))
+			return -EINVAL;
+	}
+
+	hwc->idx = -1;
+	return 0;
+}
+
+static void dmc620_pmu_read(struct perf_event *event)
+{
+	dmc620_pmu_event_update(event);
+}
+
+static void dmc620_pmu_start(struct perf_event *event, int flags)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+
+	event->hw.state = 0;
+	dmc620_pmu_event_set_period(event);
+
+	if (flags & PERF_EF_RELOAD) {
+		unsigned long prev_raw_count =
+			local64_read(&event->hw.prev_count);
+
+		dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_VALUE,
+			  (unsigned int)prev_raw_count);
+	}
+	dmc620_pmu_enable_counter(event);
+}
+
+static void dmc620_pmu_stop(struct perf_event *event, int flags)
+{
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	dmc620_pmu_disable_counter(event);
+	dmc620_pmu_event_update(event);
+	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int dmc620_pmu_add(struct perf_event *event, int flags)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event_attr *attr = &event->attr;
+	unsigned long reg;
+	int idx;
+
+	idx = dmc620_get_event_idx(event);
+	if (idx < 0)
+		return idx;
+
+	hwc->idx = idx;
+	dmc620_pmu->events[idx] = event;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	reg = ATTR_CFG_GET_FLD(attr, mask);
+	dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_MASK_31_00,
+			  lower_32_bits(reg));
+	dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_MASK_63_32,
+			  upper_32_bits(reg));
+
+	reg = ATTR_CFG_GET_FLD(attr, match);
+	dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_MATCH_31_00,
+			  lower_32_bits(reg));
+	dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_MATCH_63_32,
+			  upper_32_bits(reg));
+
+	reg = dmc620_event_to_counter_control(event);
+	dmc620_pmu_creg_write(dmc620_pmu,
+			  event->hw.idx, DMC620_PMU_COUNTERx_CONTROL,
+			  (u32)reg);
+
+	if (flags & PERF_EF_START)
+		dmc620_pmu_start(event, PERF_EF_RELOAD);
+
+	perf_event_update_userpage(event);
+	return 0;
+}
+
+static void dmc620_pmu_del(struct perf_event *event, int flags)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	dmc620_pmu_stop(event, PERF_EF_UPDATE);
+	dmc620_pmu->events[idx] = NULL;
+	clear_bit(idx, dmc620_pmu->used_mask);
+	perf_event_update_userpage(event);
+}
+
+static int dmc620_pmu_cpu_teardown(unsigned int cpu,
+				   struct hlist_node *node)
+{
+	struct dmc620_pmu_irq *irq;
+	struct dmc620_pmu *dmc620_pmu;
+	unsigned int target;
+
+	irq = hlist_entry_safe(node, struct dmc620_pmu_irq, node);
+	if (cpu != irq->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	/* We're only reading, but this isn't the place to be involving RCU */
+	mutex_lock(&dmc620_pmu_irqs_lock);
+	list_for_each_entry(dmc620_pmu, &irq->pmus_node, pmus_node)
+		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+
+	WARN_ON(irq_set_affinity_hint(irq->irq_num, cpumask_of(target)));
+	irq->cpu = target;
+
+	return 0;
+}
+
+static int dmc620_pmu_device_probe(struct platform_device *pdev)
+{
+	struct dmc620_pmu *dmc620_pmu;
+	struct resource *res;
+	char *name;
+	int irq_num;
+	int ret;
+
+	dmc620_pmu = devm_kzalloc(&pdev->dev,
+			sizeof(struct dmc620_pmu), GFP_KERNEL);
+	if (!dmc620_pmu)
+		return -ENOMEM;
+
+	dmc620_pmu->pdev = pdev;
+	platform_set_drvdata(pdev, dmc620_pmu);
+
+	dmc620_pmu->pmu = (struct pmu) {
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr	= perf_invalid_context,
+		.event_init	= dmc620_pmu_event_init,
+		.add		= dmc620_pmu_add,
+		.del		= dmc620_pmu_del,
+		.start		= dmc620_pmu_start,
+		.stop		= dmc620_pmu_stop,
+		.read		= dmc620_pmu_read,
+		.attr_groups	= dmc620_pmu_attr_groups,
+	};
+
+	irq_num = platform_get_irq(pdev, 0);
+	if (irq_num < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ (%d)\n", irq_num);
+		return irq_num;
+	}
+
+	ret = dmc620_pmu_get_irq(dmc620_pmu, irq_num);
+	if (ret)
+		return ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dmc620_pmu->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dmc620_pmu->base)) {
+		dev_err(&pdev->dev,
+			"ioremap failed for DMC-620 PMU resource\n");
+		ret = PTR_ERR(dmc620_pmu->base);
+		goto out_teardown_dev;
+	}
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+				  "%s_%llx", DMC620_PMUNAME,
+				  (res->start) >> DMC620_PA_SHIFT);
+	if (!name) {
+		dev_err(&pdev->dev,
+			  "Create name failed, PMU @%pa\n", &res->start);
+		goto out_teardown_dev;
+	}
+
+	ret = perf_pmu_register(&dmc620_pmu->pmu, name, -1);
+	if (ret)
+		goto out_teardown_dev;
+
+	return 0;
+
+out_teardown_dev:
+	dmc620_pmu_put_irq(dmc620_pmu);
+	synchronize_rcu();
+	return ret;
+}
+
+static int dmc620_pmu_device_remove(struct platform_device *pdev)
+{
+	struct dmc620_pmu *dmc620_pmu = platform_get_drvdata(pdev);
+
+	dmc620_pmu_put_irq(dmc620_pmu);
+
+	/* perf will synchronise RCU before devres can free dmc620_pmu */
+	perf_pmu_unregister(&dmc620_pmu->pmu);
+
+	return 0;
+}
+
+static const struct acpi_device_id dmc620_acpi_match[] = {
+	{ "ARMHD620", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, dmc620_acpi_match);
+static struct platform_driver dmc620_pmu_driver = {
+	.driver	= {
+		.name		= DMC620_DRVNAME,
+		.acpi_match_table = ACPI_PTR(dmc620_acpi_match),
+	},
+	.probe	= dmc620_pmu_device_probe,
+	.remove	= dmc620_pmu_device_remove,
+};
+
+static int __init dmc620_pmu_init(void)
+{
+	cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      DMC620_DRVNAME,
+				      NULL,
+				      dmc620_pmu_cpu_teardown);
+	if (cpuhp_state_num < 0)
+		return cpuhp_state_num;
+
+	return platform_driver_register(&dmc620_pmu_driver);
+}
+
+static void __exit dmc620_pmu_exit(void)
+{
+	platform_driver_unregister(&dmc620_pmu_driver);
+	cpuhp_remove_multi_state(cpuhp_state_num);
+}
+
+module_init(dmc620_pmu_init);
+module_exit(dmc620_pmu_exit);
+
+MODULE_DESCRIPTION("Perf driver for the ARM DMC-620 memory controller");
+MODULE_AUTHOR("Tuan Phan <tuanphan@os.amperecomputing.com");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


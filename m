Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F8BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DF0206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390273AbgE1NRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:17:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:17067 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390234AbgE1NRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:17:16 -0400
IronPort-SDR: kcx7IuQplISS7RuOIbC++igUBBSv0QYc4dDGj5jxz6HJZrGI75RzFGPKZzseiXRnkKsj9eBgk3
 jQXOaWr1zzAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:17:16 -0700
IronPort-SDR: l/MuQXkK+7HIzZEFslp5JUPPnvZPjFKnTGpruDsSMihJhDeMHm6PXafbYm9v/SHzbpv6YgLYYp
 rBQ+7KflREsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="256156999"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2020 06:17:16 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, David.Laight@ACULAB.COM,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/3] perf/x86/intel/uncore: Record the size of mapped area
Date:   Thu, 28 May 2020 06:15:26 -0700
Message-Id: <1590671727-99311-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf cannot validate an address before the actual access to MMIO space
of some uncore units, e.g. IMC on TGL. Accessing an invalid address,
which exceeds mapped area, can trigger oops.

Perf never records the size of mapped area. Generic functions, e.g.
uncore_mmio_read_counter(), cannot get the correct size for address
validation.

Add mmio_map_size in intel_uncore_type to record the size of mapped
area. Also sanity check the size before ioremap.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch

 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snb.c   | 20 ++++++++++++++++++--
 arch/x86/events/intel/uncore_snbep.c | 13 ++++++++++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 0da4a46..c2e5725 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -61,6 +61,7 @@ struct intel_uncore_type {
 		unsigned msr_offset;
 		unsigned mmio_offset;
 	};
+	unsigned mmio_map_size;
 	unsigned num_shared_regs:8;
 	unsigned single_fixed:1;
 	unsigned pair_ctr_ctl:1;
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 1038e9f..52bcb69 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -415,6 +415,7 @@ static const struct attribute_group snb_uncore_imc_format_group = {
 
 static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 {
+	struct intel_uncore_type *type = box->pmu->type;
 	struct pci_dev *pdev = box->pci_dev;
 	int where = SNB_UNCORE_PCI_IMC_BAR_OFFSET;
 	resource_size_t addr;
@@ -430,7 +431,13 @@ static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 
 	addr &= ~(PAGE_SIZE - 1);
 
-	box->io_addr = ioremap(addr, SNB_UNCORE_PCI_IMC_MAP_SIZE);
+	if (!type->mmio_map_size) {
+		pr_warn("perf uncore: Cannot ioremap for %s. Size of map area is 0.\n",
+			type->name);
+		return;
+	}
+
+	box->io_addr = ioremap(addr, type->mmio_map_size);
 	box->hrtimer_duration = UNCORE_SNB_IMC_HRTIMER_INTERVAL;
 }
 
@@ -586,6 +593,7 @@ static struct intel_uncore_type snb_uncore_imc = {
 	.num_counters   = 2,
 	.num_boxes	= 1,
 	.num_freerunning_types	= SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size	= SNB_UNCORE_PCI_IMC_MAP_SIZE,
 	.freerunning	= snb_uncore_imc_freerunning,
 	.event_descs	= snb_uncore_imc_events,
 	.format_group	= &snb_uncore_imc_format_group,
@@ -1091,6 +1099,7 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = tgl_uncore_get_mc_dev();
 	struct intel_uncore_pmu *pmu = box->pmu;
+	struct intel_uncore_type *type = pmu->type;
 	resource_size_t addr;
 	u32 mch_bar;
 
@@ -1113,7 +1122,13 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 	addr |= ((resource_size_t)mch_bar << 32);
 #endif
 
-	box->io_addr = ioremap(addr, TGL_UNCORE_PCI_IMC_MAP_SIZE);
+	if (!type->mmio_map_size) {
+		pr_warn("perf uncore: Cannot ioremap for %s. Size of map area is 0.\n",
+			type->name);
+		return;
+	}
+
+	box->io_addr = ioremap(addr, type->mmio_map_size);
 }
 
 static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
@@ -1139,6 +1154,7 @@ static struct intel_uncore_type tgl_uncore_imc_free_running = {
 	.num_counters		= 3,
 	.num_boxes		= 2,
 	.num_freerunning_types	= TGL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size		= TGL_UNCORE_PCI_IMC_MAP_SIZE,
 	.freerunning		= tgl_uncore_imc_freerunning,
 	.ops			= &tgl_uncore_imc_freerunning_ops,
 	.event_descs		= tgl_uncore_imc_events,
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 07652fa..801b662 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4421,6 +4421,7 @@ static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
 				       unsigned int box_ctl, int mem_offset)
 {
 	struct pci_dev *pdev = snr_uncore_get_mc_dev(box->dieid);
+	struct intel_uncore_type *type = box->pmu->type;
 	resource_size_t addr;
 	u32 pci_dword;
 
@@ -4435,7 +4436,13 @@ static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
 
 	addr += box_ctl;
 
-	box->io_addr = ioremap(addr, SNR_IMC_MMIO_SIZE);
+	if (!type->mmio_map_size) {
+		pr_warn("perf uncore: Cannot ioremap for %s. Size of map area is 0.\n",
+			type->name);
+		return;
+	}
+
+	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr)
 		return;
 
@@ -4530,6 +4537,7 @@ static struct intel_uncore_type snr_uncore_imc = {
 	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
 	.box_ctl	= SNR_IMC_MMIO_PMON_BOX_CTL,
 	.mmio_offset	= SNR_IMC_MMIO_OFFSET,
+	.mmio_map_size	= SNR_IMC_MMIO_SIZE,
 	.ops		= &snr_uncore_mmio_ops,
 	.format_group	= &skx_uncore_format_group,
 };
@@ -4570,6 +4578,7 @@ static struct intel_uncore_type snr_uncore_imc_free_running = {
 	.num_counters		= 3,
 	.num_boxes		= 1,
 	.num_freerunning_types	= SNR_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size		= SNR_IMC_MMIO_SIZE,
 	.freerunning		= snr_imc_freerunning,
 	.ops			= &snr_uncore_imc_freerunning_ops,
 	.event_descs		= snr_uncore_imc_freerunning_events,
@@ -4987,6 +4996,7 @@ static struct intel_uncore_type icx_uncore_imc = {
 	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
 	.box_ctl	= SNR_IMC_MMIO_PMON_BOX_CTL,
 	.mmio_offset	= SNR_IMC_MMIO_OFFSET,
+	.mmio_map_size	= SNR_IMC_MMIO_SIZE,
 	.ops		= &icx_uncore_mmio_ops,
 	.format_group	= &skx_uncore_format_group,
 };
@@ -5044,6 +5054,7 @@ static struct intel_uncore_type icx_uncore_imc_free_running = {
 	.num_counters		= 5,
 	.num_boxes		= 4,
 	.num_freerunning_types	= ICX_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size		= SNR_IMC_MMIO_SIZE,
 	.freerunning		= icx_imc_freerunning,
 	.ops			= &icx_uncore_imc_freerunning_ops,
 	.event_descs		= icx_uncore_imc_freerunning_events,
-- 
2.7.4


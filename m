Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465622075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404333AbgE1PVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:21:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:30135 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404275AbgE1PVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:21:16 -0400
IronPort-SDR: mhD/vpkrcdAlahgKOC/gY15rdfKC7SGOA0SHCwVvg9tSaZK/BnhTOnlCA3Fjg77HVlGkWdVh3I
 nt8DxMFofChQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:21:16 -0700
IronPort-SDR: 7ucLHshLl2AMxNgFByV1lWF73iJL7u1ygXYlHc0PoSthsPljenDmlmy2Am3bvdXe9WXd9mR8WV
 b+cf1cp5y0oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="292031374"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2020 08:21:16 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, David.Laight@ACULAB.COM,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/3] perf/x86/intel/uncore: Record the size of mapped area
Date:   Thu, 28 May 2020 08:19:28 -0700
Message-Id: <1590679169-61823-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590679169-61823-1-git-send-email-kan.liang@linux.intel.com>
References: <1590679169-61823-1-git-send-email-kan.liang@linux.intel.com>
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
area. Print warning message if ioremap fails.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Check box->io_addr instead of mmio_map_size
- Print warning message if ioremap fails

 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snb.c   | 13 +++++++++++--
 arch/x86/events/intel/uncore_snbep.c | 11 +++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

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
index 1038e9f..639de75 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -415,6 +415,7 @@ static const struct attribute_group snb_uncore_imc_format_group = {
 
 static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 {
+	struct intel_uncore_type *type = box->pmu->type;
 	struct pci_dev *pdev = box->pci_dev;
 	int where = SNB_UNCORE_PCI_IMC_BAR_OFFSET;
 	resource_size_t addr;
@@ -430,7 +431,10 @@ static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 
 	addr &= ~(PAGE_SIZE - 1);
 
-	box->io_addr = ioremap(addr, SNB_UNCORE_PCI_IMC_MAP_SIZE);
+	box->io_addr = ioremap(addr, type->mmio_map_size);
+	if (!box->io_addr)
+		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
+
 	box->hrtimer_duration = UNCORE_SNB_IMC_HRTIMER_INTERVAL;
 }
 
@@ -586,6 +590,7 @@ static struct intel_uncore_type snb_uncore_imc = {
 	.num_counters   = 2,
 	.num_boxes	= 1,
 	.num_freerunning_types	= SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size	= SNB_UNCORE_PCI_IMC_MAP_SIZE,
 	.freerunning	= snb_uncore_imc_freerunning,
 	.event_descs	= snb_uncore_imc_events,
 	.format_group	= &snb_uncore_imc_format_group,
@@ -1091,6 +1096,7 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = tgl_uncore_get_mc_dev();
 	struct intel_uncore_pmu *pmu = box->pmu;
+	struct intel_uncore_type *type = pmu->type;
 	resource_size_t addr;
 	u32 mch_bar;
 
@@ -1113,7 +1119,9 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 	addr |= ((resource_size_t)mch_bar << 32);
 #endif
 
-	box->io_addr = ioremap(addr, TGL_UNCORE_PCI_IMC_MAP_SIZE);
+	box->io_addr = ioremap(addr, type->mmio_map_size);
+	if (!box->io_addr)
+		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
 }
 
 static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
@@ -1139,6 +1147,7 @@ static struct intel_uncore_type tgl_uncore_imc_free_running = {
 	.num_counters		= 3,
 	.num_boxes		= 2,
 	.num_freerunning_types	= TGL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size		= TGL_UNCORE_PCI_IMC_MAP_SIZE,
 	.freerunning		= tgl_uncore_imc_freerunning,
 	.ops			= &tgl_uncore_imc_freerunning_ops,
 	.event_descs		= tgl_uncore_imc_events,
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 07652fa..bffb755 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4421,6 +4421,7 @@ static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
 				       unsigned int box_ctl, int mem_offset)
 {
 	struct pci_dev *pdev = snr_uncore_get_mc_dev(box->dieid);
+	struct intel_uncore_type *type = box->pmu->type;
 	resource_size_t addr;
 	u32 pci_dword;
 
@@ -4435,9 +4436,11 @@ static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
 
 	addr += box_ctl;
 
-	box->io_addr = ioremap(addr, SNR_IMC_MMIO_SIZE);
-	if (!box->io_addr)
+	box->io_addr = ioremap(addr, type->mmio_map_size);
+	if (!box->io_addr) {
+		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
 		return;
+	}
 
 	writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
 }
@@ -4530,6 +4533,7 @@ static struct intel_uncore_type snr_uncore_imc = {
 	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
 	.box_ctl	= SNR_IMC_MMIO_PMON_BOX_CTL,
 	.mmio_offset	= SNR_IMC_MMIO_OFFSET,
+	.mmio_map_size	= SNR_IMC_MMIO_SIZE,
 	.ops		= &snr_uncore_mmio_ops,
 	.format_group	= &skx_uncore_format_group,
 };
@@ -4570,6 +4574,7 @@ static struct intel_uncore_type snr_uncore_imc_free_running = {
 	.num_counters		= 3,
 	.num_boxes		= 1,
 	.num_freerunning_types	= SNR_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size		= SNR_IMC_MMIO_SIZE,
 	.freerunning		= snr_imc_freerunning,
 	.ops			= &snr_uncore_imc_freerunning_ops,
 	.event_descs		= snr_uncore_imc_freerunning_events,
@@ -4987,6 +4992,7 @@ static struct intel_uncore_type icx_uncore_imc = {
 	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
 	.box_ctl	= SNR_IMC_MMIO_PMON_BOX_CTL,
 	.mmio_offset	= SNR_IMC_MMIO_OFFSET,
+	.mmio_map_size	= SNR_IMC_MMIO_SIZE,
 	.ops		= &icx_uncore_mmio_ops,
 	.format_group	= &skx_uncore_format_group,
 };
@@ -5044,6 +5050,7 @@ static struct intel_uncore_type icx_uncore_imc_free_running = {
 	.num_counters		= 5,
 	.num_boxes		= 4,
 	.num_freerunning_types	= ICX_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size		= SNR_IMC_MMIO_SIZE,
 	.freerunning		= icx_imc_freerunning,
 	.ops			= &icx_uncore_imc_freerunning_ops,
 	.event_descs		= icx_uncore_imc_freerunning_events,
-- 
2.7.4


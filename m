Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FEEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57EC620C09
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgFPMV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgFPMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06351C08C5C4;
        Tue, 16 Jun 2020 05:21:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb5-0004aV-Bg; Tue, 16 Jun 2020 14:21:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB4E01C0475;
        Tue, 16 Jun 2020 14:21:46 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:46 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Record the size of mapped area
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1590679169-61823-2-git-send-email-kan.liang@linux.intel.com>
References: <1590679169-61823-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159231010670.16989.5034166286742461401.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1b94d31de422399421422af0e63c9685e7485901
Gitweb:        https://git.kernel.org/tip/1b94d31de422399421422af0e63c9685e7485901
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 28 May 2020 08:19:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:50 +02:00

perf/x86/intel/uncore: Record the size of mapped area

Perf cannot validate an address before the actual access to MMIO space
of some uncore units, e.g. IMC on TGL. Accessing an invalid address,
which exceeds mapped area, can trigger oops.

Perf never records the size of mapped area. Generic functions, e.g.
uncore_mmio_read_counter(), cannot get the correct size for address
validation.

Add mmio_map_size in intel_uncore_type to record the size of mapped
area. Print warning message if ioremap fails.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1590679169-61823-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snb.c   | 13 +++++++++++--
 arch/x86/events/intel/uncore_snbep.c | 11 +++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index b469ddd..79ff626 100644
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
index d5ae3a8..cb94ba8 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -426,6 +426,7 @@ static const struct attribute_group snb_uncore_imc_format_group = {
 
 static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 {
+	struct intel_uncore_type *type = box->pmu->type;
 	struct pci_dev *pdev = box->pci_dev;
 	int where = SNB_UNCORE_PCI_IMC_BAR_OFFSET;
 	resource_size_t addr;
@@ -441,7 +442,10 @@ static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 
 	addr &= ~(PAGE_SIZE - 1);
 
-	box->io_addr = ioremap(addr, SNB_UNCORE_PCI_IMC_MAP_SIZE);
+	box->io_addr = ioremap(addr, type->mmio_map_size);
+	if (!box->io_addr)
+		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
+
 	box->hrtimer_duration = UNCORE_SNB_IMC_HRTIMER_INTERVAL;
 }
 
@@ -597,6 +601,7 @@ static struct intel_uncore_type snb_uncore_imc = {
 	.num_counters   = 2,
 	.num_boxes	= 1,
 	.num_freerunning_types	= SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size	= SNB_UNCORE_PCI_IMC_MAP_SIZE,
 	.freerunning	= snb_uncore_imc_freerunning,
 	.event_descs	= snb_uncore_imc_events,
 	.format_group	= &snb_uncore_imc_format_group,
@@ -1157,6 +1162,7 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = tgl_uncore_get_mc_dev();
 	struct intel_uncore_pmu *pmu = box->pmu;
+	struct intel_uncore_type *type = pmu->type;
 	resource_size_t addr;
 	u32 mch_bar;
 
@@ -1179,7 +1185,9 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 	addr |= ((resource_size_t)mch_bar << 32);
 #endif
 
-	box->io_addr = ioremap(addr, TGL_UNCORE_PCI_IMC_MAP_SIZE);
+	box->io_addr = ioremap(addr, type->mmio_map_size);
+	if (!box->io_addr)
+		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
 }
 
 static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
@@ -1205,6 +1213,7 @@ static struct intel_uncore_type tgl_uncore_imc_free_running = {
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

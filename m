Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A9CC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E934520720
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBEViE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:38:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:46755 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgBEViD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:38:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 13:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="254899358"
Received: from ssp-tglu-cdi358.jf.intel.com ([10.54.55.34])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2020 13:38:02 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86: Add Intel Tiger Lake uncore support
Date:   Wed,  5 Feb 2020 13:39:04 -0800
Message-Id: <20200205213904.24638-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For MSR type of uncore units, there is no difference between Ice Lake
and Tiger Lake. Share the same code with Ice Lake.

Tiger Lake has two MCs. Both of them are located at 0:0:0. The BAR
offset is still 0x48. The offset of the two MCs is 0x10000.
Each MC has three counters to count every read/write/total issued by the
Memory Controller to DRAM. The counters can be accessed by MMIO.
They are free-running counters.

The offset of counters are different for TIGERLAKE_L and TIGERLAKE.
Add separated mmio_init() functions.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |  12 +++
 arch/x86/events/intel/uncore.h     |   2 +
 arch/x86/events/intel/uncore_snb.c | 155 +++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86467f85c383..63922e3a34f5 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1470,6 +1470,16 @@ static const struct intel_uncore_init_fun icl_uncore_init __initconst = {
 	.pci_init = skl_uncore_pci_init,
 };
 
+static const struct intel_uncore_init_fun tgl_uncore_init __initconst = {
+	.cpu_init = icl_uncore_cpu_init,
+	.mmio_init = tgl_uncore_mmio_init,
+};
+
+static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
+	.cpu_init = icl_uncore_cpu_init,
+	.mmio_init = tgl_l_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 	.cpu_init = snr_uncore_cpu_init,
 	.pci_init = snr_uncore_pci_init,
@@ -1505,6 +1515,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_TIGERLAKE_L,	  tgl_l_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_TIGERLAKE,	  tgl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_D, snr_uncore_init),
 	{},
 };
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index bbfdaa720b45..1204dcc9fe9b 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -527,6 +527,8 @@ void snb_uncore_cpu_init(void);
 void nhm_uncore_cpu_init(void);
 void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
+void tgl_uncore_mmio_init(void);
+void tgl_l_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index c37cb12d0ef6..6afa97f0b70a 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -44,6 +44,11 @@
 #define PCI_DEVICE_ID_INTEL_WHL_UD_IMC		0x3e35
 #define PCI_DEVICE_ID_INTEL_ICL_U_IMC		0x8a02
 #define PCI_DEVICE_ID_INTEL_ICL_U2_IMC		0x8a12
+#define PCI_DEVICE_ID_INTEL_TGL_U1_IMC		0x9a02
+#define PCI_DEVICE_ID_INTEL_TGL_U2_IMC		0x9a04
+#define PCI_DEVICE_ID_INTEL_TGL_U3_IMC		0x9a12
+#define PCI_DEVICE_ID_INTEL_TGL_U4_IMC		0x9a14
+#define PCI_DEVICE_ID_INTEL_TGL_H_IMC		0x9a36
 
 
 /* SNB event control */
@@ -1002,3 +1007,153 @@ void nhm_uncore_cpu_init(void)
 }
 
 /* end of Nehalem uncore support */
+
+/* Tiger Lake MMIO uncore support */
+
+static const struct pci_device_id tgl_uncore_pci_ids[] = {
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_U1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_U2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_U3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_U4_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_H_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* end: all zeroes */ },
+};
+
+enum perf_tgl_uncore_imc_freerunning_types {
+	TGL_MMIO_UNCORE_IMC_DATA_TOTAL		= 0,
+	TGL_MMIO_UNCORE_IMC_DATA_READ,
+	TGL_MMIO_UNCORE_IMC_DATA_WRITE,
+	TGL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters tgl_l_uncore_imc_freerunning[] = {
+	[TGL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0x5040, 0x0, 0x0, 1, 64 },
+	[TGL_MMIO_UNCORE_IMC_DATA_READ]		= { 0x5058, 0x0, 0x0, 1, 64 },
+	[TGL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0x50A0, 0x0, 0x0, 1, 64 },
+};
+
+static struct freerunning_counters tgl_uncore_imc_freerunning[] = {
+	[TGL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0xd840, 0x0, 0x0, 1, 64 },
+	[TGL_MMIO_UNCORE_IMC_DATA_READ]		= { 0xd858, 0x0, 0x0, 1, 64 },
+	[TGL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0xd8A0, 0x0, 0x0, 1, 64 },
+};
+
+static struct uncore_event_desc tgl_uncore_imc_events[] = {
+	INTEL_UNCORE_EVENT_DESC(data_total,         "event=0xff,umask=0x10"),
+	INTEL_UNCORE_EVENT_DESC(data_total.scale,   "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(data_total.unit,    "MiB"),
+
+	INTEL_UNCORE_EVENT_DESC(data_read,         "event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(data_read.scale,   "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(data_read.unit,    "MiB"),
+
+	INTEL_UNCORE_EVENT_DESC(data_write,        "event=0xff,umask=0x30"),
+	INTEL_UNCORE_EVENT_DESC(data_write.scale,  "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(data_write.unit,   "MiB"),
+
+	{ /* end: all zeroes */ },
+};
+
+static struct pci_dev *tgl_uncore_get_mc_dev(void)
+{
+	const struct pci_device_id *ids = tgl_uncore_pci_ids;
+	struct pci_dev *mc_dev = NULL;
+
+	while (ids && ids->vendor) {
+		mc_dev = pci_get_device(PCI_VENDOR_ID_INTEL, ids->device, NULL);
+		if (mc_dev)
+			return mc_dev;
+		ids++;
+	}
+
+	return mc_dev;
+}
+
+#define TGL_UNCORE_MMIO_IMC_MEM_OFFSET		0x10000
+
+static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+{
+	struct pci_dev *pdev = tgl_uncore_get_mc_dev();
+	struct intel_uncore_pmu *pmu = box->pmu;
+	resource_size_t addr;
+	u64 mch_bar;
+
+	if (!pdev) {
+		pr_warn("perf uncore: Cannot find matched IMC device.\n");
+		return;
+	}
+
+	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET, (u32 *)&mch_bar);
+	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET + 4, (u32 *)&mch_bar + 1);
+
+	/* MCHBAR is disabled */
+	if (!(mch_bar & 1ULL)) {
+		pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
+		return;
+	}
+	addr = (resource_size_t)((mch_bar & ~1ULL) + (TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx));
+
+	box->io_addr = ioremap(addr, SNB_UNCORE_PCI_IMC_MAP_SIZE);
+}
+
+static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
+	.init_box	= tgl_uncore_imc_freerunning_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.read_counter	= uncore_mmio_read_counter,
+	.hw_config	= uncore_freerunning_hw_config,
+};
+
+static struct attribute *tgl_uncore_imc_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	NULL,
+};
+
+static const struct attribute_group tgl_uncore_imc_format_group = {
+	.name = "format",
+	.attrs = tgl_uncore_imc_formats_attr,
+};
+
+static struct intel_uncore_type tgl_uncore_imc_free_running = {
+	.name			= "imc_free_running",
+	.num_counters		= 3,
+	.num_boxes		= 2,
+	.num_freerunning_types	= TGL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+	.freerunning		= tgl_uncore_imc_freerunning,
+	.ops			= &tgl_uncore_imc_freerunning_ops,
+	.event_descs		= tgl_uncore_imc_events,
+	.format_group		= &tgl_uncore_imc_format_group,
+};
+
+static struct intel_uncore_type *tgl_mmio_uncores[] = {
+	&tgl_uncore_imc_free_running,
+	NULL,
+};
+
+void tgl_l_uncore_mmio_init(void)
+{
+	tgl_uncore_imc_free_running.freerunning = tgl_l_uncore_imc_freerunning;
+	uncore_mmio_uncores = tgl_mmio_uncores;
+}
+
+void tgl_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = tgl_mmio_uncores;
+}
+
+/* end of Tiger Lake MMIO uncore support */
-- 
2.21.0


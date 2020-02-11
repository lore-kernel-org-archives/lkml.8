Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9A2C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58644208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgBKMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:47:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45971 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgBKMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux6-0007Y6-Km; Tue, 11 Feb 2020 13:47:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 469771C2017;
        Tue, 11 Feb 2020 13:47:44 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:44 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add Intel Tiger Lake uncore support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206161527.3529-1-kan.liang@linux.intel.com>
References: <20200206161527.3529-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158142526405.411.15968037917306955534.tip-bot2@tip-bot2>
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

Commit-ID:     fdb64822443ec9fb8c3a74b598a74790ae8d2e22
Gitweb:        https://git.kernel.org/tip/fdb64822443ec9fb8c3a74b598a74790ae8d2e22
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 06 Feb 2020 08:15:27 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:23:49 +01:00

perf/x86: Add Intel Tiger Lake uncore support

For MSR type of uncore units, there is no difference between Ice Lake
and Tiger Lake. Share the same code with Ice Lake.

Tiger Lake has two MCs. Both of them are located at 0:0:0. The BAR
offset is still 0x48. The offset of the two MCs is 0x10000.
Each MC has three counters to count every read/write/total issued by the
Memory Controller to DRAM. The counters can be accessed by MMIO.
They are free-running counters.

The offset of counters are different for TIGERLAKE_L and TIGERLAKE.
Add separated mmio_init() functions.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20200206161527.3529-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |  12 ++-
 arch/x86/events/intel/uncore.h     |   2 +-
 arch/x86/events/intel/uncore_snb.c | 159 ++++++++++++++++++++++++++++-
 3 files changed, 173 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86467f8..63922e3 100644
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
index bbfdaa7..1204dcc 100644
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
index c37cb12..3de1065 100644
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
@@ -1002,3 +1007,157 @@ void nhm_uncore_cpu_init(void)
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
+	{ /* end: all zeroes */ }
+};
+
+enum perf_tgl_uncore_imc_freerunning_types {
+	TGL_MMIO_UNCORE_IMC_DATA_TOTAL,
+	TGL_MMIO_UNCORE_IMC_DATA_READ,
+	TGL_MMIO_UNCORE_IMC_DATA_WRITE,
+	TGL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX
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
+	{ /* end: all zeroes */ }
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
+	u32 mch_bar;
+
+	if (!pdev) {
+		pr_warn("perf uncore: Cannot find matched IMC device.\n");
+		return;
+	}
+
+	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET, &mch_bar);
+	/* MCHBAR is disabled */
+	if (!(mch_bar & BIT(0))) {
+		pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
+		return;
+	}
+	mch_bar &= ~BIT(0);
+	addr = (resource_size_t)(mch_bar + TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx);
+
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET + 4, &mch_bar);
+	addr |= ((resource_size_t)mch_bar << 32);
+#endif
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
+	NULL
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
+	NULL
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

Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5257AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCC220705
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgDLOTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:19:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41449 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgDLOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:19:32 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jNdSJ-0001W7-F2; Sun, 12 Apr 2020 16:19:27 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 04689100E35;
        Sun, 12 Apr 2020 16:19:27 +0200 (CEST)
Date:   Sun, 12 Apr 2020 14:18:38 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.7-rc1
References: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
Message-ID: <158670111898.20085.15483830842616301182.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-04-12

up to:  d3296fb372bf: perf/core: Disable page faults when getting phys address


Thre fixes/updates for perf:

 - Fix the perf event cgroup tracking which tries to track the cgroup even
   for disabled events.

 - Add Ice Lake server support for uncore events

 - Disable pagefaults when retrieving the physical address in the sampling
   code.



Thanks,

	tglx

------------------>
Ian Rogers (1):
      perf/cgroup: Correct indirection in perf_less_group_idx()

Jiri Olsa (1):
      perf/core: Disable page faults when getting phys address

Kan Liang (1):
      perf/x86/intel/uncore: Add Ice Lake server uncore support

Peter Zijlstra (1):
      perf/core: Fix event cgroup tracking


 arch/x86/events/intel/uncore.c       |   8 +
 arch/x86/events/intel/uncore.h       |   3 +
 arch/x86/events/intel/uncore_snbep.c | 511 +++++++++++++++++++++++++++++++++++
 kernel/events/core.c                 |  82 +++---
 4 files changed, 573 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 1ba72c563313..cf76d6631afa 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1476,6 +1476,12 @@ static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
 	.mmio_init = tgl_l_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
+	.cpu_init = icx_uncore_cpu_init,
+	.pci_init = icx_uncore_pci_init,
+	.mmio_init = icx_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 	.cpu_init = snr_uncore_cpu_init,
 	.pci_init = snr_uncore_pci_init,
@@ -1511,6 +1517,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&icl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_l_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index b30429f8a53a..0da4a4605536 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -550,6 +550,9 @@ void skx_uncore_cpu_init(void);
 int snr_uncore_pci_init(void);
 void snr_uncore_cpu_init(void);
 void snr_uncore_mmio_init(void);
+int icx_uncore_pci_init(void);
+void icx_uncore_cpu_init(void);
+void icx_uncore_mmio_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 01023f0d935b..07652fa20ebb 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -382,6 +382,42 @@
 #define SNR_IMC_MMIO_MEM0_OFFSET		0xd8
 #define SNR_IMC_MMIO_MEM0_MASK			0x7FF
 
+/* ICX CHA */
+#define ICX_C34_MSR_PMON_CTR0			0xb68
+#define ICX_C34_MSR_PMON_CTL0			0xb61
+#define ICX_C34_MSR_PMON_BOX_CTL		0xb60
+#define ICX_C34_MSR_PMON_BOX_FILTER0		0xb65
+
+/* ICX IIO */
+#define ICX_IIO_MSR_PMON_CTL0			0xa58
+#define ICX_IIO_MSR_PMON_CTR0			0xa51
+#define ICX_IIO_MSR_PMON_BOX_CTL		0xa50
+
+/* ICX IRP */
+#define ICX_IRP0_MSR_PMON_CTL0			0xa4d
+#define ICX_IRP0_MSR_PMON_CTR0			0xa4b
+#define ICX_IRP0_MSR_PMON_BOX_CTL		0xa4a
+
+/* ICX M2PCIE */
+#define ICX_M2PCIE_MSR_PMON_CTL0		0xa46
+#define ICX_M2PCIE_MSR_PMON_CTR0		0xa41
+#define ICX_M2PCIE_MSR_PMON_BOX_CTL		0xa40
+
+/* ICX UPI */
+#define ICX_UPI_PCI_PMON_CTL0			0x350
+#define ICX_UPI_PCI_PMON_CTR0			0x320
+#define ICX_UPI_PCI_PMON_BOX_CTL		0x318
+#define ICX_UPI_CTL_UMASK_EXT			0xffffff
+
+/* ICX M3UPI*/
+#define ICX_M3UPI_PCI_PMON_CTL0			0xd8
+#define ICX_M3UPI_PCI_PMON_CTR0			0xa8
+#define ICX_M3UPI_PCI_PMON_BOX_CTL		0xa0
+
+/* ICX IMC */
+#define ICX_NUMBER_IMC_CHN			2
+#define ICX_IMC_MEM_STRIDE			0x4
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
 DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
@@ -390,6 +426,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
@@ -4551,3 +4588,477 @@ void snr_uncore_mmio_init(void)
 }
 
 /* end of SNR uncore support */
+
+/* ICX uncore support */
+
+static unsigned icx_cha_msr_offsets[] = {
+	0x2a0, 0x2ae, 0x2bc, 0x2ca, 0x2d8, 0x2e6, 0x2f4, 0x302, 0x310,
+	0x31e, 0x32c, 0x33a, 0x348, 0x356, 0x364, 0x372, 0x380, 0x38e,
+	0x3aa, 0x3b8, 0x3c6, 0x3d4, 0x3e2, 0x3f0, 0x3fe, 0x40c, 0x41a,
+	0x428, 0x436, 0x444, 0x452, 0x460, 0x46e, 0x47c, 0x0,   0xe,
+	0x1c,  0x2a,  0x38,  0x46,
+};
+
+static int icx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
+	bool tie_en = !!(event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN);
+
+	if (tie_en) {
+		reg1->reg = ICX_C34_MSR_PMON_BOX_FILTER0 +
+			    icx_cha_msr_offsets[box->pmu->pmu_idx];
+		reg1->config = event->attr.config1 & SKX_CHA_MSR_PMON_BOX_FILTER_TID;
+		reg1->idx = 0;
+	}
+
+	return 0;
+}
+
+static struct intel_uncore_ops icx_uncore_chabox_ops = {
+	.init_box		= ivbep_uncore_msr_init_box,
+	.disable_box		= snbep_uncore_msr_disable_box,
+	.enable_box		= snbep_uncore_msr_enable_box,
+	.disable_event		= snbep_uncore_msr_disable_event,
+	.enable_event		= snr_cha_enable_event,
+	.read_counter		= uncore_msr_read_counter,
+	.hw_config		= icx_cha_hw_config,
+};
+
+static struct intel_uncore_type icx_uncore_chabox = {
+	.name			= "cha",
+	.num_counters		= 4,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= ICX_C34_MSR_PMON_CTL0,
+	.perf_ctr		= ICX_C34_MSR_PMON_CTR0,
+	.box_ctl		= ICX_C34_MSR_PMON_BOX_CTL,
+	.msr_offsets		= icx_cha_msr_offsets,
+	.event_mask		= HSWEP_S_MSR_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SNR_CHA_RAW_EVENT_MASK_EXT,
+	.constraints		= skx_uncore_chabox_constraints,
+	.ops			= &icx_uncore_chabox_ops,
+	.format_group		= &snr_uncore_chabox_format_group,
+};
+
+static unsigned icx_msr_offsets[] = {
+	0x0, 0x20, 0x40, 0x90, 0xb0, 0xd0,
+};
+
+static struct event_constraint icx_uncore_iio_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x02, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x03, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x83, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
+	EVENT_CONSTRAINT_END
+};
+
+static struct intel_uncore_type icx_uncore_iio = {
+	.name			= "iio",
+	.num_counters		= 4,
+	.num_boxes		= 6,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= ICX_IIO_MSR_PMON_CTL0,
+	.perf_ctr		= ICX_IIO_MSR_PMON_CTR0,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
+	.box_ctl		= ICX_IIO_MSR_PMON_BOX_CTL,
+	.msr_offsets		= icx_msr_offsets,
+	.constraints		= icx_uncore_iio_constraints,
+	.ops			= &skx_uncore_iio_ops,
+	.format_group		= &snr_uncore_iio_format_group,
+};
+
+static struct intel_uncore_type icx_uncore_irp = {
+	.name			= "irp",
+	.num_counters		= 2,
+	.num_boxes		= 6,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= ICX_IRP0_MSR_PMON_CTL0,
+	.perf_ctr		= ICX_IRP0_MSR_PMON_CTR0,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl		= ICX_IRP0_MSR_PMON_BOX_CTL,
+	.msr_offsets		= icx_msr_offsets,
+	.ops			= &ivbep_uncore_msr_ops,
+	.format_group		= &ivbep_uncore_format_group,
+};
+
+static struct event_constraint icx_uncore_m2pcie_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
+	EVENT_CONSTRAINT_END
+};
+
+static struct intel_uncore_type icx_uncore_m2pcie = {
+	.name		= "m2pcie",
+	.num_counters	= 4,
+	.num_boxes	= 6,
+	.perf_ctr_bits	= 48,
+	.event_ctl	= ICX_M2PCIE_MSR_PMON_CTL0,
+	.perf_ctr	= ICX_M2PCIE_MSR_PMON_CTR0,
+	.box_ctl	= ICX_M2PCIE_MSR_PMON_BOX_CTL,
+	.msr_offsets	= icx_msr_offsets,
+	.constraints	= icx_uncore_m2pcie_constraints,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.ops		= &ivbep_uncore_msr_ops,
+	.format_group	= &ivbep_uncore_format_group,
+};
+
+enum perf_uncore_icx_iio_freerunning_type_id {
+	ICX_IIO_MSR_IOCLK,
+	ICX_IIO_MSR_BW_IN,
+
+	ICX_IIO_FREERUNNING_TYPE_MAX,
+};
+
+static unsigned icx_iio_clk_freerunning_box_offsets[] = {
+	0x0, 0x20, 0x40, 0x90, 0xb0, 0xd0,
+};
+
+static unsigned icx_iio_bw_freerunning_box_offsets[] = {
+	0x0, 0x10, 0x20, 0x90, 0xa0, 0xb0,
+};
+
+static struct freerunning_counters icx_iio_freerunning[] = {
+	[ICX_IIO_MSR_IOCLK]	= { 0xa55, 0x1, 0x20, 1, 48, icx_iio_clk_freerunning_box_offsets },
+	[ICX_IIO_MSR_BW_IN]	= { 0xaa0, 0x1, 0x10, 8, 48, icx_iio_bw_freerunning_box_offsets },
+};
+
+static struct uncore_event_desc icx_uncore_iio_freerunning_events[] = {
+	/* Free-Running IIO CLOCKS Counter */
+	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
+	/* Free-Running IIO BANDWIDTH IN Counters */
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type icx_uncore_iio_free_running = {
+	.name			= "iio_free_running",
+	.num_counters		= 9,
+	.num_boxes		= 6,
+	.num_freerunning_types	= ICX_IIO_FREERUNNING_TYPE_MAX,
+	.freerunning		= icx_iio_freerunning,
+	.ops			= &skx_uncore_iio_freerunning_ops,
+	.event_descs		= icx_uncore_iio_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+static struct intel_uncore_type *icx_msr_uncores[] = {
+	&skx_uncore_ubox,
+	&icx_uncore_chabox,
+	&icx_uncore_iio,
+	&icx_uncore_irp,
+	&icx_uncore_m2pcie,
+	&skx_uncore_pcu,
+	&icx_uncore_iio_free_running,
+	NULL,
+};
+
+/*
+ * To determine the number of CHAs, it should read CAPID6(Low) and CAPID7 (High)
+ * registers which located at Device 30, Function 3
+ */
+#define ICX_CAPID6		0x9c
+#define ICX_CAPID7		0xa0
+
+static u64 icx_count_chabox(void)
+{
+	struct pci_dev *dev = NULL;
+	u64 caps = 0;
+
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x345b, dev);
+	if (!dev)
+		goto out;
+
+	pci_read_config_dword(dev, ICX_CAPID6, (u32 *)&caps);
+	pci_read_config_dword(dev, ICX_CAPID7, (u32 *)&caps + 1);
+out:
+	pci_dev_put(dev);
+	return hweight64(caps);
+}
+
+void icx_uncore_cpu_init(void)
+{
+	u64 num_boxes = icx_count_chabox();
+
+	if (WARN_ON(num_boxes > ARRAY_SIZE(icx_cha_msr_offsets)))
+		return;
+	icx_uncore_chabox.num_boxes = num_boxes;
+	uncore_msr_uncores = icx_msr_uncores;
+}
+
+static struct intel_uncore_type icx_uncore_m2m = {
+	.name		= "m2m",
+	.num_counters   = 4,
+	.num_boxes	= 4,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= SNR_M2M_PCI_PMON_CTR0,
+	.event_ctl	= SNR_M2M_PCI_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl	= SNR_M2M_PCI_PMON_BOX_CTL,
+	.ops		= &snr_m2m_uncore_pci_ops,
+	.format_group	= &skx_uncore_format_group,
+};
+
+static struct attribute *icx_upi_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext4.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	NULL,
+};
+
+static const struct attribute_group icx_upi_uncore_format_group = {
+	.name = "format",
+	.attrs = icx_upi_uncore_formats_attr,
+};
+
+static struct intel_uncore_type icx_uncore_upi = {
+	.name		= "upi",
+	.num_counters   = 4,
+	.num_boxes	= 3,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= ICX_UPI_PCI_PMON_CTR0,
+	.event_ctl	= ICX_UPI_PCI_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext = ICX_UPI_CTL_UMASK_EXT,
+	.box_ctl	= ICX_UPI_PCI_PMON_BOX_CTL,
+	.ops		= &skx_upi_uncore_pci_ops,
+	.format_group	= &icx_upi_uncore_format_group,
+};
+
+static struct event_constraint icx_uncore_m3upi_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x1c, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1d, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1e, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
+	UNCORE_EVENT_CONSTRAINT(0x40, 0x7),
+	UNCORE_EVENT_CONSTRAINT(0x4e, 0x7),
+	UNCORE_EVENT_CONSTRAINT(0x4f, 0x7),
+	UNCORE_EVENT_CONSTRAINT(0x50, 0x7),
+	EVENT_CONSTRAINT_END
+};
+
+static struct intel_uncore_type icx_uncore_m3upi = {
+	.name		= "m3upi",
+	.num_counters   = 4,
+	.num_boxes	= 3,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= ICX_M3UPI_PCI_PMON_CTR0,
+	.event_ctl	= ICX_M3UPI_PCI_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl	= ICX_M3UPI_PCI_PMON_BOX_CTL,
+	.constraints	= icx_uncore_m3upi_constraints,
+	.ops		= &ivbep_uncore_pci_ops,
+	.format_group	= &skx_uncore_format_group,
+};
+
+enum {
+	ICX_PCI_UNCORE_M2M,
+	ICX_PCI_UNCORE_UPI,
+	ICX_PCI_UNCORE_M3UPI,
+};
+
+static struct intel_uncore_type *icx_pci_uncores[] = {
+	[ICX_PCI_UNCORE_M2M]		= &icx_uncore_m2m,
+	[ICX_PCI_UNCORE_UPI]		= &icx_uncore_upi,
+	[ICX_PCI_UNCORE_M3UPI]		= &icx_uncore_m3upi,
+	NULL,
+};
+
+static const struct pci_device_id icx_uncore_pci_ids[] = {
+	{ /* M2M 0 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(12, 0, ICX_PCI_UNCORE_M2M, 0),
+	},
+	{ /* M2M 1 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(13, 0, ICX_PCI_UNCORE_M2M, 1),
+	},
+	{ /* M2M 2 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(14, 0, ICX_PCI_UNCORE_M2M, 2),
+	},
+	{ /* M2M 3 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(15, 0, ICX_PCI_UNCORE_M2M, 3),
+	},
+	{ /* UPI Link 0 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3441),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(2, 1, ICX_PCI_UNCORE_UPI, 0),
+	},
+	{ /* UPI Link 1 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3441),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(3, 1, ICX_PCI_UNCORE_UPI, 1),
+	},
+	{ /* UPI Link 2 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3441),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(4, 1, ICX_PCI_UNCORE_UPI, 2),
+	},
+	{ /* M3UPI Link 0 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3446),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(5, 1, ICX_PCI_UNCORE_M3UPI, 0),
+	},
+	{ /* M3UPI Link 1 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3446),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(6, 1, ICX_PCI_UNCORE_M3UPI, 1),
+	},
+	{ /* M3UPI Link 2 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3446),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(7, 1, ICX_PCI_UNCORE_M3UPI, 2),
+	},
+	{ /* end: all zeroes */ }
+};
+
+static struct pci_driver icx_uncore_pci_driver = {
+	.name		= "icx_uncore",
+	.id_table	= icx_uncore_pci_ids,
+};
+
+int icx_uncore_pci_init(void)
+{
+	/* ICX UBOX DID */
+	int ret = snbep_pci2phy_map_init(0x3450, SKX_CPUNODEID,
+					 SKX_GIDNIDMAP, true);
+
+	if (ret)
+		return ret;
+
+	uncore_pci_uncores = icx_pci_uncores;
+	uncore_pci_driver = &icx_uncore_pci_driver;
+	return 0;
+}
+
+static void icx_uncore_imc_init_box(struct intel_uncore_box *box)
+{
+	unsigned int box_ctl = box->pmu->type->box_ctl +
+			       box->pmu->type->mmio_offset * (box->pmu->pmu_idx % ICX_NUMBER_IMC_CHN);
+	int mem_offset = (box->pmu->pmu_idx / ICX_NUMBER_IMC_CHN) * ICX_IMC_MEM_STRIDE +
+			 SNR_IMC_MMIO_MEM0_OFFSET;
+
+	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset);
+}
+
+static struct intel_uncore_ops icx_uncore_mmio_ops = {
+	.init_box	= icx_uncore_imc_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.disable_box	= snr_uncore_mmio_disable_box,
+	.enable_box	= snr_uncore_mmio_enable_box,
+	.disable_event	= snr_uncore_mmio_disable_event,
+	.enable_event	= snr_uncore_mmio_enable_event,
+	.read_counter	= uncore_mmio_read_counter,
+};
+
+static struct intel_uncore_type icx_uncore_imc = {
+	.name		= "imc",
+	.num_counters   = 4,
+	.num_boxes	= 8,
+	.perf_ctr_bits	= 48,
+	.fixed_ctr_bits	= 48,
+	.fixed_ctr	= SNR_IMC_MMIO_PMON_FIXED_CTR,
+	.fixed_ctl	= SNR_IMC_MMIO_PMON_FIXED_CTL,
+	.event_descs	= hswep_uncore_imc_events,
+	.perf_ctr	= SNR_IMC_MMIO_PMON_CTR0,
+	.event_ctl	= SNR_IMC_MMIO_PMON_CTL0,
+	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
+	.box_ctl	= SNR_IMC_MMIO_PMON_BOX_CTL,
+	.mmio_offset	= SNR_IMC_MMIO_OFFSET,
+	.ops		= &icx_uncore_mmio_ops,
+	.format_group	= &skx_uncore_format_group,
+};
+
+enum perf_uncore_icx_imc_freerunning_type_id {
+	ICX_IMC_DCLK,
+	ICX_IMC_DDR,
+	ICX_IMC_DDRT,
+
+	ICX_IMC_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters icx_imc_freerunning[] = {
+	[ICX_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
+	[ICX_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
+	[ICX_IMC_DDRT]	= { 0x22a0, 0x8, 0, 2, 48 },
+};
+
+static struct uncore_event_desc icx_uncore_imc_freerunning_events[] = {
+	INTEL_UNCORE_EVENT_DESC(dclk,			"event=0xff,umask=0x10"),
+
+	INTEL_UNCORE_EVENT_DESC(read,			"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(read.scale,		"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(read.unit,		"MiB"),
+	INTEL_UNCORE_EVENT_DESC(write,			"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(write.scale,		"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(write.unit,		"MiB"),
+
+	INTEL_UNCORE_EVENT_DESC(ddrt_read,		"event=0xff,umask=0x30"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_read.unit,		"MiB"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_write,		"event=0xff,umask=0x31"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_write.unit,	"MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static void icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+{
+	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE +
+			 SNR_IMC_MMIO_MEM0_OFFSET;
+
+	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box), mem_offset);
+}
+
+static struct intel_uncore_ops icx_uncore_imc_freerunning_ops = {
+	.init_box	= icx_uncore_imc_freerunning_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.read_counter	= uncore_mmio_read_counter,
+	.hw_config	= uncore_freerunning_hw_config,
+};
+
+static struct intel_uncore_type icx_uncore_imc_free_running = {
+	.name			= "imc_free_running",
+	.num_counters		= 5,
+	.num_boxes		= 4,
+	.num_freerunning_types	= ICX_IMC_FREERUNNING_TYPE_MAX,
+	.freerunning		= icx_imc_freerunning,
+	.ops			= &icx_uncore_imc_freerunning_ops,
+	.event_descs		= icx_uncore_imc_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+static struct intel_uncore_type *icx_mmio_uncores[] = {
+	&icx_uncore_imc,
+	&icx_uncore_imc_free_running,
+	NULL,
+};
+
+void icx_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = icx_mmio_uncores;
+}
+
+/* end of ICX uncore support */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55e44417f66d..bc9b98a9af9a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -983,16 +983,10 @@ perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
 	event->shadow_ctx_time = now - t->timestamp;
 }
 
-/*
- * Update cpuctx->cgrp so that it is set when first cgroup event is added and
- * cleared when last cgroup event is removed.
- */
 static inline void
-list_update_cgroup_event(struct perf_event *event,
-			 struct perf_event_context *ctx, bool add)
+perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_cpu_context *cpuctx;
-	struct list_head *cpuctx_entry;
 
 	if (!is_cgroup_event(event))
 		return;
@@ -1009,28 +1003,41 @@ list_update_cgroup_event(struct perf_event *event,
 	 * because if the first would mismatch, the second would not try again
 	 * and we would leave cpuctx->cgrp unset.
 	 */
-	if (add && !cpuctx->cgrp) {
+	if (ctx->is_active && !cpuctx->cgrp) {
 		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
 
 		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
 			cpuctx->cgrp = cgrp;
 	}
 
-	if (add && ctx->nr_cgroups++)
+	if (ctx->nr_cgroups++)
 		return;
-	else if (!add && --ctx->nr_cgroups)
+
+	list_add(&cpuctx->cgrp_cpuctx_entry,
+			per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
+}
+
+static inline void
+perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (!is_cgroup_event(event))
+		return;
+
+	/*
+	 * Because cgroup events are always per-cpu events,
+	 * @ctx == &cpuctx->ctx.
+	 */
+	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
+
+	if (--ctx->nr_cgroups)
 		return;
 
-	/* no cgroup running */
-	if (!add)
+	if (ctx->is_active && cpuctx->cgrp)
 		cpuctx->cgrp = NULL;
 
-	cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
-	if (add)
-		list_add(cpuctx_entry,
-			 per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
-	else
-		list_del(cpuctx_entry);
+	list_del(&cpuctx->cgrp_cpuctx_entry);
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -1096,11 +1103,14 @@ static inline u64 perf_cgroup_event_time(struct perf_event *event)
 }
 
 static inline void
-list_update_cgroup_event(struct perf_event *event,
-			 struct perf_event_context *ctx, bool add)
+perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
 {
 }
 
+static inline void
+perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
+{
+}
 #endif
 
 /*
@@ -1791,13 +1801,14 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		add_event_to_groups(event, ctx);
 	}
 
-	list_update_cgroup_event(event, ctx, true);
-
 	list_add_rcu(&event->event_entry, &ctx->event_list);
 	ctx->nr_events++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
 
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_enable(event, ctx);
+
 	ctx->generation++;
 }
 
@@ -1976,8 +1987,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	event->attach_state &= ~PERF_ATTACH_CONTEXT;
 
-	list_update_cgroup_event(event, ctx, false);
-
 	ctx->nr_events--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
@@ -1994,8 +2003,10 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	 * of error state is by explicit re-enabling
 	 * of the event
 	 */
-	if (event->state > PERF_EVENT_STATE_OFF)
+	if (event->state > PERF_EVENT_STATE_OFF) {
+		perf_cgroup_event_disable(event, ctx);
 		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
+	}
 
 	ctx->generation++;
 }
@@ -2226,6 +2237,7 @@ event_sched_out(struct perf_event *event,
 
 	if (READ_ONCE(event->pending_disable) >= 0) {
 		WRITE_ONCE(event->pending_disable, -1);
+		perf_cgroup_event_disable(event, ctx);
 		state = PERF_EVENT_STATE_OFF;
 	}
 	perf_event_set_state(event, state);
@@ -2363,6 +2375,7 @@ static void __perf_event_disable(struct perf_event *event,
 		event_sched_out(event, cpuctx, ctx);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
+	perf_cgroup_event_disable(event, ctx);
 }
 
 /*
@@ -2746,7 +2759,7 @@ static int  __perf_install_in_context(void *info)
 	}
 
 #ifdef CONFIG_CGROUP_PERF
-	if (is_cgroup_event(event)) {
+	if (event->state > PERF_EVENT_STATE_OFF && is_cgroup_event(event)) {
 		/*
 		 * If the current cgroup doesn't match the event's
 		 * cgroup, we should not try to schedule it.
@@ -2906,6 +2919,7 @@ static void __perf_event_enable(struct perf_event *event,
 		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+	perf_cgroup_event_enable(event, ctx);
 
 	if (!ctx->is_active)
 		return;
@@ -3508,7 +3522,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 
 static bool perf_less_group_idx(const void *l, const void *r)
 {
-	const struct perf_event *le = l, *re = r;
+	const struct perf_event *le = *(const struct perf_event **)l;
+	const struct perf_event *re = *(const struct perf_event **)r;
 
 	return le->group_index < re->group_index;
 }
@@ -3616,8 +3631,10 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	}
 
 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
-		if (event->attr.pinned)
+		if (event->attr.pinned) {
+			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		}
 
 		*can_add_hw = 0;
 		ctx->rotate_necessary = 1;
@@ -6917,9 +6934,12 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe __get_user_pages_fast first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if ((current->mm != NULL) &&
-		    (__get_user_pages_fast(virt, 1, 0, &p) == 1))
-			phys_addr = page_to_phys(p) + virt % PAGE_SIZE;
+		if (current->mm != NULL) {
+			pagefault_disable();
+			if (__get_user_pages_fast(virt, 1, 0, &p) == 1)
+				phys_addr = page_to_phys(p) + virt % PAGE_SIZE;
+			pagefault_enable();
+		}
 
 		if (p)
 			put_page(p);


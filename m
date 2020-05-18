Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECF9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9887D20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgERXrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:47:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:65332 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgERXrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:47:12 -0400
IronPort-SDR: CtZLR9iJSVEqdpz0fr/vxiu/GsRjw2GqHjkOmnjd1LEMOS3/XIsspJRy9vhIRDKx5VWFlNb/R6
 lsxkzn8PaHIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:47:11 -0700
IronPort-SDR: hPNj/VCjE6jIVnKoy7x2zi1vpLwmiMzMM0MjQX0AgD3oxkR6k8lUrWmFxVo5QIG04O8r/ll1lR
 CNJAoZwwT71A==
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="288757535"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:47:10 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 1/4] x86/resctrl: Enable user to view and select thread throttling mode
Date:   Mon, 18 May 2020 16:46:46 -0700
Message-Id: <28be277fac30c30a3efe8c120ef8565ec87594c0.1589844108.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589844108.git.reinette.chatre@intel.com>
References: <cover.1589844108.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Memory Bandwidth Allocation (MBA) control is provided per
processor core. At the same time different CLOS, configured with
different bandwidth percentages, can be assigned to the hardware
threads sharing a core. In the original implementation of MBA the
maximum throttling of the per-thread CLOS is allocated to the core.
Specifically, the lower bandwidth percentage is allocated to the core.

Newer systems can be configured to allocate either maximum or
minimum throttling of the per-thread CLOS values to the core.

Introduce a new resctrl file, "thread_throttle_mode", on Intel systems
that exposes to the user how per-thread values are allocated to
a core. On systems that support the original MBA implementation the
file will always display "max". On systems that can be configured
the possible values are "min" or "max" that the user can modify by
writing these same words to the file.

AMD confirmed in
https://lore.kernel.org/lkml/18d277fd-6523-319c-d560-66b63ff606b8@amd.com
that AMD bandwidth allocation is already at thread level. But AMD does not
use memory delay throttle model to control the allocation like Intel does.
So, to avoid any confusion the thread throttling mode would be UNDEFINED
on AMD systems and the "thread_throttle_mode" file will not be visible.

Cc: Babu Moger <babu.moger@amd.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V4:
- Three checks are performed before the MBA_CFG register is updated from
  its cache. Move all checks to the same if statement. (Babu)
- Remove unnecessary return statement when there is only a switch statement
  in the function that is already handling all cases. (Babu)

 Documentation/x86/resctrl_ui.rst       |  19 ++-
 arch/x86/kernel/cpu/resctrl/core.c     |  49 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  47 +++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 196 ++++++++++++++++++++++++-
 4 files changed, 302 insertions(+), 9 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 5368cedfb530..861ee2816470 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -138,6 +138,19 @@ with respect to allocation:
 		non-linear. This field is purely informational
 		only.
 
+"thread_throttle_mode":
+		Indicator (on some CPU models control) on Intel systems
+		of how tasks running on threads of a physical core are
+		throttled in cases where they request different memory
+		bandwidth percentages:
+
+		"min":
+			the largest percentage is applied
+			to all threads
+		"max":
+			the smallest percentage is applied
+			to all threads
+
 If RDT monitoring is available there will be an "L3_MON" directory
 with the following files:
 
@@ -364,8 +377,10 @@ to the next control step available on the hardware.
 
 The bandwidth throttling is a core specific mechanism on some of Intel
 SKUs. Using a high bandwidth and a low bandwidth setting on two threads
-sharing a core will result in both threads being throttled to use the
-low bandwidth. The fact that Memory bandwidth allocation(MBA) is a core
+sharing a core may result in both threads being throttled to use the
+low bandwidth (see "thread_throttle_mode").
+
+The fact that Memory bandwidth allocation(MBA) may be a core
 specific mechanism where as memory bandwidth monitoring(MBM) is done at
 the package level may lead to confusion when users try to apply control
 via the MBA and then monitor the bandwidth to see if the controls are
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 12f967c6b603..687221cae5c3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -250,6 +250,40 @@ static inline bool rdt_get_mb_table(struct rdt_resource *r)
 	return false;
 }
 
+/*
+ * Restore the MBA configuration from the cached configuration. Used for
+ * the case when an entire package was offline at the time the user made
+ * the configuration change.
+ */
+static void mba_cfg_reconfigure_throttle_mode(struct rdt_resource *r)
+{
+	if (r->alloc_capable && r == &rdt_resources_all[RDT_RESOURCE_MBA] &&
+	    r->membw.arch_throttle_mode == THREAD_THROTTLE_MIN_MAX)
+		wrmsrl(MSR_MBA_CFG, mba_cfg_msr);
+}
+
+/*
+ * Model-specific test to determine if platform where memory bandwidth
+ * control is applied to a core can be configured to apply either the
+ * maximum or minimum of the per-thread delay values.
+ * By default, platforms where memory bandwidth control is applied to a
+ * core will select the maximum delay value of the per-thread CLOS.
+ *
+ * NOTE: delay value programmed to hardware is inverse of bandwidth
+ * percentage configured via user interface.
+ */
+static bool mba_cfg_supports_min_max_intel(void)
+{
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_ATOM_TREMONT_D:
+	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_D:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool __get_mem_config_intel(struct rdt_resource *r)
 {
 	union cpuid_0x10_3_eax eax;
@@ -270,6 +304,14 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	}
 	r->data_width = 3;
 
+	if (mba_cfg_supports_min_max_intel()) {
+		r->membw.arch_throttle_mode = THREAD_THROTTLE_MIN_MAX;
+		thread_throttle_mode_init_rw();
+	} else {
+		r->membw.arch_throttle_mode = THREAD_THROTTLE_MAX_ONLY;
+		thread_throttle_mode_init_ro();
+	}
+
 	r->alloc_capable = true;
 	r->alloc_enabled = true;
 
@@ -289,6 +331,11 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
 
+	/*
+	 * AMD does not use memory delay throttle model to control
+	 * the allocation like Intel does.
+	 */
+	r->membw.arch_throttle_mode = THREAD_THROTTLE_UNDEFINED;
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
 	/* Max value is 2048, Data width should be 4 in decimal */
@@ -580,6 +627,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	rdt_domain_reconfigure_cdp(r);
 
+	mba_cfg_reconfigure_throttle_mode(r);
+
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
 		kfree(d);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f20a47d120b1..6b9b21d67c9b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -9,6 +9,7 @@
 
 #define MSR_IA32_L3_QOS_CFG		0xc81
 #define MSR_IA32_L2_QOS_CFG		0xc82
+#define MSR_MBA_CFG			0xc84
 #define MSR_IA32_L3_CBM_BASE		0xc90
 #define MSR_IA32_L2_CBM_BASE		0xd10
 #define MSR_IA32_MBA_THRTL_BASE		0xd50
@@ -21,6 +22,9 @@
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
 
+#define MBA_THROTTLE_MODE_MIN		0x01ULL
+#define MBA_THROTTLE_MODE_MAX		0x00ULL
+
 /*
  * Event IDs are used to program IA32_QM_EVTSEL before reading event
  * counter from IA32_QM_CTR
@@ -38,6 +42,8 @@
 #define MBA_MAX_MBPS			U32_MAX
 #define MAX_MBA_BW_AMD			0x800
 
+#define MBA_THROTTLE_MODE_MASK		BIT_ULL(0)
+
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
 /*
@@ -47,6 +53,10 @@
  */
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
+/*
+ * MSR_MBA_CFG cache
+ */
+extern u64 mba_cfg_msr;
 
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
@@ -368,6 +378,26 @@ struct rdt_cache {
 	unsigned int	shareable_bits;
 };
 
+/**
+ * enum membw_throttle_mode - System's memory bandwidth throttling mode
+ * @THREAD_THROTTLE_UNDEFINED:	Not relevant to the system
+ * @THREAD_THROTTLE_MIN_MAX:	Memory bandwidth is throttled at the core and
+ *				can be configured to use smallest or largest
+ *				bandwidth percentage assigned to threads.
+ *				Systems that support this mode will support
+ *				MSR_MBA_CFG and the configuration of
+ *				thread throttling mode via resctrl
+ *				file "thread_throttle_mode".
+ * @THREAD_THROTTLE_MAX_ONLY:	Memory bandwidth is throttled at the core
+ *				always using smallest bandwidth percentage
+ *				assigned to threads, aka "max throttling"
+ */
+enum membw_throttle_mode {
+	THREAD_THROTTLE_UNDEFINED = 0,
+	THREAD_THROTTLE_MIN_MAX,
+	THREAD_THROTTLE_MAX_ONLY,
+};
+
 /**
  * struct rdt_membw - Memory bandwidth allocation related data
  * @max_delay:		Max throttle delay. Delay is the hardware
@@ -375,16 +405,19 @@ struct rdt_cache {
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
+ * @arch_throttle_mode:	Bandwidth throttling mode when threads request
+ *			different memory bandwidths
  * @mba_sc:		True if MBA software controller(mba_sc) is enabled
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct rdt_membw {
-	u32		max_delay;
-	u32		min_bw;
-	u32		bw_gran;
-	u32		delay_linear;
-	bool		mba_sc;
-	u32		*mb_map;
+	u32				max_delay;
+	u32				min_bw;
+	u32				bw_gran;
+	u32				delay_linear;
+	enum membw_throttle_mode	arch_throttle_mode;
+	bool				mba_sc;
+	u32				*mb_map;
 };
 
 static inline bool is_llc_occupancy_enabled(void)
@@ -611,5 +644,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
 bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
 bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
+void thread_throttle_mode_init_rw(void);
+void thread_throttle_mode_init_ro(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7cb5ab0d1f0..3ce6319b7226 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -29,6 +29,7 @@
 
 #include <uapi/linux/magic.h>
 
+#include <asm/intel-family.h>
 #include <asm/resctrl.h>
 #include "internal.h"
 
@@ -38,6 +39,7 @@ DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
+u64 mba_cfg_msr;
 
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
@@ -1017,6 +1019,141 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * As documented in the Intel SDM, on systems supporting the original MBA
+ * implementation the delay value allocated to a core is always the maximum
+ * of the delay values assigned to the hardware threads sharing the core.
+ *
+ * Some systems support a model-specific MSR with which this default
+ * behavior can be changed. On these systems the core can be allocated
+ * with either the minimum or maximum delay value assigned to its hardware
+ * threads.
+ *
+ * NOTE: The hardware deals with memory delay values that may be programmed
+ * from zero (implying zero delay, and full bandwidth available) to the
+ * maximum specified in CPUID. The software interface deals with memory
+ * bandwidth percentages that are the inverse of the delay values (100%
+ * memory bandwidth from user perspective is zero MBA delay from hardware
+ * perspective). When maximum throttling is active the core is allocated
+ * with the maximum delay value that from the software interface will be
+ * the minimum of the bandwidth percentages assigned to the hardware threads
+ * sharing the core.
+ */
+static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
+					 struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	unsigned int throttle_mode = 0;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (r->membw.arch_throttle_mode == THREAD_THROTTLE_MIN_MAX)
+		throttle_mode = mba_cfg_msr & MBA_THROTTLE_MODE_MASK;
+
+	seq_puts(seq,
+		 throttle_mode == MBA_THROTTLE_MODE_MIN ? "min\n" : "max\n");
+
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
+static void update_mba_cfg(void *data)
+{
+	wrmsrl(MSR_MBA_CFG, *(u64 *)data);
+}
+
+/*
+ * The model-specific MBA configuration MSR has package scope. Making a
+ * system-wide MBA configuration change thus needs to modify the MSR on one
+ * CPU from each package.
+ */
+static int rdt_system_mba_cfg_set(u64 mba_cfg)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+	cpumask_var_t cpu_mask;
+	struct rdt_domain *d;
+
+	if (list_is_singular(&r->domains)) {
+		wrmsrl(MSR_MBA_CFG, mba_cfg);
+		goto out;
+	}
+
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
+		rdt_last_cmd_puts("Memory allocation error\n");
+		return -ENOMEM;
+	}
+
+	list_for_each_entry(d, &r->domains, list)
+		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
+
+	on_each_cpu_mask(cpu_mask, update_mba_cfg, &mba_cfg, 1);
+
+	free_cpumask_var(cpu_mask);
+out:
+	mba_cfg_msr = mba_cfg;
+	return 0;
+}
+
+static void mba_cfg_reset_all(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+
+	if (!r->alloc_capable)
+		return;
+
+	if (r->membw.arch_throttle_mode == THREAD_THROTTLE_MIN_MAX)
+		rdt_system_mba_cfg_set(0);
+}
+
+/*
+ * Callback will only be associated with the "thread_throttle_mode" file on
+ * systems that are capable of memory bandwidth allocation
+ * (RDT_RESOURCE_MBA is alloc_capable) AND the thread throttle mode is
+ * THREAD_THROTTLE_MIN_MAX.
+ *
+ * See NOTE associated with rdt_thread_throttle_mode_show() for
+ * details of the min/max interpretation.
+ */
+static ssize_t rdt_thread_throttle_mode_write(struct kernfs_open_file *of,
+					      char *buf, size_t nbytes,
+					      loff_t off)
+{
+	u64 mba_cfg;
+	int ret = 0;
+
+	if (nbytes == 0)
+		return -EINVAL;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	mba_cfg = mba_cfg_msr & MBA_THROTTLE_MODE_MASK;
+
+	if ((sysfs_streq(buf, "min") && mba_cfg == MBA_THROTTLE_MODE_MIN) ||
+	    (sysfs_streq(buf, "max") && mba_cfg == MBA_THROTTLE_MODE_MAX))
+		goto out;
+
+	if (sysfs_streq(buf, "min")) {
+		mba_cfg = MBA_THROTTLE_MODE_MIN;
+	} else if (sysfs_streq(buf, "max")) {
+		mba_cfg = MBA_THROTTLE_MODE_MAX;
+	} else {
+		rdt_last_cmd_puts("Unknown or unsupported mode\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mba_cfg = (mba_cfg_msr & ~MBA_THROTTLE_MODE_MASK) | mba_cfg;
+	ret = rdt_system_mba_cfg_set(mba_cfg);
+
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret ?: nbytes;
+}
+
 static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
@@ -1512,6 +1649,16 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_delay_linear_show,
 		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
 	},
+	/*
+	 * Platform specific which (if any) capabilities are provided by
+	 * thread_throttle_mode. Defer some initialization to platform
+	 * discovery.
+	 */
+	{
+		.name		= "thread_throttle_mode",
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_thread_throttle_mode_show,
+	},
 	{
 		.name		= "max_threshold_occupancy",
 		.mode		= 0644,
@@ -1571,6 +1718,52 @@ static struct rftype res_common_files[] = {
 
 };
 
+static struct rftype *rdtgroup_rftype_by_name(const char *name)
+{
+	struct rftype *rfts, *rft;
+	int len;
+
+	rfts = res_common_files;
+	len = ARRAY_SIZE(res_common_files);
+
+	for (rft = rfts; rft < rfts + len; rft++) {
+		if (!strcmp(rft->name, name))
+			return rft;
+	}
+
+	return NULL;
+}
+
+/*
+ * Only systems that support memory bandwidth allocation and have
+ * THREAD_THROTTLE_MIN_MAX set will support a writable thread_throttle_mode
+ * file with which the user can modify the thread throttling mode.
+ */
+void __init thread_throttle_mode_init_rw(void)
+{
+	struct rftype *rft;
+
+	rft = rdtgroup_rftype_by_name("thread_throttle_mode");
+	if (!rft)
+		return;
+
+	rft->mode = 0644;
+	rft->write = rdt_thread_throttle_mode_write;
+	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
+}
+
+void __init thread_throttle_mode_init_ro(void)
+{
+	struct rftype *rft;
+
+	rft = rdtgroup_rftype_by_name("thread_throttle_mode");
+	if (!rft)
+		return;
+
+	rft->mode = 0444;
+	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
+}
+
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 {
 	struct rftype *rfts, *rft;
@@ -1582,7 +1775,7 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	for (rft = rfts; rft < rfts + len; rft++) {
-		if ((fflags & rft->fflags) == rft->fflags) {
+		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
 			ret = rdtgroup_add_file(kn, rft);
 			if (ret)
 				goto error;
@@ -2371,6 +2564,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	/*Put everything back to default values. */
 	for_each_alloc_enabled_rdt_resource(r)
 		reset_all_ctrls(r);
+	mba_cfg_reset_all();
 	cdp_disable_all();
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
-- 
2.21.0


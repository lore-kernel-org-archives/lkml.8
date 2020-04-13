Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B008C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415F720644
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbgDMU6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:58:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:8591 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgDMU6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:58:23 -0400
IronPort-SDR: 7VVB0SzJnP/ZUfwipo8EQycJraqTRPmU5a7un31NL+A2lwa9W9baQwgqv5V2WodXy3ANFAji0p
 ZSjK3vvO7gqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 13:58:21 -0700
IronPort-SDR: 9CVous5vBIudl8GI+NNWGS8WxpLfw8tTpH6rCRQe2LzDMYQktw8QNBWe3Gy1aaPYkaDnkiy80G
 ZovKF1ZKvO+A==
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="453301659"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 13:58:21 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 1/4] x86/resctrl: Enable user to view and select thread throttling mode
Date:   Mon, 13 Apr 2020 13:58:00 -0700
Message-Id: <f4b1b6734c3912ca6eb3e17267de020570e02ac2.1586801373.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1586801373.git.reinette.chatre@intel.com>
References: <cover.1586801373.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Memory Bandwidth Allocation (MBA) control is provided per
processor core. At the same time different CLOS, configured with different
bandwidth percentages, can be assigned to the hardware threads
sharing a core. In the original implementation of MBA the maximum throttling
of the per-thread CLOS is allocated to the core. Specifically, the lower
bandwidth percentage is allocated to the core.

Newer systems can be configured to allocate either maximum or
minimum throttling of the per-thread CLOS values to the core.

Introduce a new resctrl file, "thread_throttle_mode", on Intel systems
that exposes to the user how per-thread values are allocated to
a core. On systems that support the original MBA implementation the
file will always display "max". On systems that can be configured
the possible values are "min" or "max" that the user can modify by
writing these same words to the file.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Rebased on top of James Morse's CDP fix
(https://lore.kernel.org/lkml/20200221162105.154163-1-james.morse@arm.com)
- Remove RF_UNINITIALIZED (having uninitialized be represented with ones
  creates too much confusion), replace with an explicit check of rft->fflags
  in rdtgroup_add_files() (Fenghua Yu)
- Rename MBA_THREAD_THROTTLE_MODE to MBA_THROTTLE_MODE_MASK to clarify its
  use as a mask (Tony Luck)
- Introduce explicit MBA_THROTTLE_MODE_MAX instead of implying it is the
  opposite of min and use these values (min and max) explicitly whenever
  testing/setting the throttle mode value (Tony Luck)
- Add __init attribute to thread_throttle_mode_init_intel_rw() and
  thread_throttle_mode_init_intel_ro() since they are only needed during
  initialization (Fenghua Yu)
- Remove MBA_CFG MSR reads and error checking so that the patch is simpler
  and easier to review (Fenghua Yu)
- Ensure CPU hotplug lock is taken when writing register on multiple CPUs (Fenghua Yu)
- Use CPU mask already maintained as part of domains to determine which
  CPUs to update MBA register on (Fenghua Yu)
- Maintain MBA configuration register contents to support use case when not
  all CPUs of a package are online when configuration is set from user
  space.
- Use seq_puts() instead of seq_printf() when simple strings are printed
- Set MBA configuration to default when resctrl is unmounted
- Complete rewrite of "thread_throttle_mode" documentation (Tony Luck)

 Documentation/x86/resctrl_ui.rst       |  14 +-
 arch/x86/kernel/cpu/resctrl/core.c     |  32 +++++
 arch/x86/kernel/cpu/resctrl/internal.h |  13 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 188 ++++++++++++++++++++++++-
 4 files changed, 244 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 5368cedfb530..1dc0611ec266 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -138,6 +138,14 @@ with respect to allocation:
 		non-linear. This field is purely informational
 		only.
 
+"thread_throttle_mode":
+		Indicator (on some CPU models control) on Intel systems
+		of how tasks running on threads of a physical core are
+		throttled in cases where they request different memory
+		bandwidth percentages:
+		"min" - the largest percentage is applied to all threads
+		"max" - the smallest percentage is applied to all threads
+
 If RDT monitoring is available there will be an "L3_MON" directory
 with the following files:
 
@@ -364,8 +372,10 @@ to the next control step available on the hardware.
 
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
index d8cc5223b7ce..aca85117a653 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -250,6 +250,30 @@ static inline bool rdt_get_mb_table(struct rdt_resource *r)
 	return false;
 }
 
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
+bool mba_cfg_supports_min_max_intel(void)
+{
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_ATOM_TREMONT_D:
+	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_D:
+		return true;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
 static bool __get_mem_config_intel(struct rdt_resource *r)
 {
 	union cpuid_0x10_3_eax eax;
@@ -270,6 +294,11 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	}
 	r->data_width = 3;
 
+	if (mba_cfg_supports_min_max_intel())
+		thread_throttle_mode_init_intel_rw();
+	else
+		thread_throttle_mode_init_intel_ro();
+
 	r->alloc_capable = true;
 	r->alloc_enabled = true;
 
@@ -580,6 +609,9 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	rdt_domain_reconfigure_cdp(r);
 
+	if (mba_cfg_supports_min_max_intel())
+		wrmsrl(MSR_MBA_CFG, mba_cfg_msr);
+
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
 		kfree(d);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f20a47d120b1..c5f4cb91009b 100644
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
@@ -611,5 +621,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
 bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
 bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
+bool mba_cfg_supports_min_max_intel(void);
+void thread_throttle_mode_init_intel_rw(void);
+void thread_throttle_mode_init_intel_ro(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 025fe99cc4b4..2d6707b52a5d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -29,6 +29,7 @@
 
 #include <uapi/linux/magic.h>
 
+#include <asm/intel-family.h>
 #include <asm/resctrl_sched.h>
 #include "internal.h"
 
@@ -38,6 +39,7 @@ DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
+u64 mba_cfg_msr;
 
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
@@ -1017,6 +1019,134 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
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
+	unsigned int throttle_mode = 0;
+
+	if (mba_cfg_supports_min_max_intel())
+		throttle_mode = mba_cfg_msr & MBA_THROTTLE_MODE_MASK;
+
+	seq_puts(seq,
+		 throttle_mode == MBA_THROTTLE_MODE_MIN ? "min\n" : "max\n");
+
+	return 0;
+}
+
+static void update_mba_cfg(void *data)
+{
+	u64 *mba_cfg = data;
+
+	wrmsrl(MSR_MBA_CFG, *mba_cfg);
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
+/*
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
+	/*
+	 * Additional check.
+	 * This function should not be associated with the user space file
+	 * on systems that do not support configuration.
+	 */
+	if (!mba_cfg_supports_min_max_intel()) {
+		rdt_last_cmd_puts("Platform does not support mode changes\n");
+		ret = -EINVAL;
+		goto out;
+	}
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
@@ -1512,6 +1642,16 @@ static struct rftype res_common_files[] = {
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
@@ -1571,6 +1711,47 @@ static struct rftype res_common_files[] = {
 
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
+void __init thread_throttle_mode_init_intel_rw(void)
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
+void __init thread_throttle_mode_init_intel_ro(void)
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
@@ -1582,7 +1763,7 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	for (rft = rfts; rft < rfts + len; rft++) {
-		if ((fflags & rft->fflags) == rft->fflags) {
+		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
 			ret = rdtgroup_add_file(kn, rft);
 			if (ret)
 				goto error;
@@ -2239,6 +2420,11 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	put_cpu();
 
+	if (mba_cfg_supports_min_max_intel()) {
+		mba_cfg_msr = 0;
+		on_each_cpu_mask(cpu_mask, update_mba_cfg, &mba_cfg_msr, 1);
+	}
+
 	free_cpumask_var(cpu_mask);
 
 	return 0;
-- 
2.21.0


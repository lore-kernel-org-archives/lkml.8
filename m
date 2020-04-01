Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B86C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8581C20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbgDASbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:31:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:5040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732566AbgDASa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:30:58 -0400
IronPort-SDR: 7Za0ka68YCKRKKXr4WoNAlng8z77iHthdeS9CLLOdh17YzHgQnyfgv5gc7/IoGK/57osEZI3MK
 iRkD8Q3lebjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 11:30:57 -0700
IronPort-SDR: uL2k1jkcbHFvQ1qwmgD2q+c5iYxFbyVznIGVuaCophP/fDlaAxnMzX8w6whk4QFWT0FjNinxj3
 jZnK+1SsyDVQ==
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="249552583"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 11:30:57 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 1/2] x86/resctrl: Enable user to view and select thread throttling mode
Date:   Wed,  1 Apr 2020 11:30:47 -0700
Message-Id: <253b034d47149930cf88cd44313112e748107a4d.1585765499.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1585765499.git.reinette.chatre@intel.com>
References: <cover.1585765499.git.reinette.chatre@intel.com>
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
 Documentation/x86/resctrl_ui.rst       |  21 ++-
 arch/x86/kernel/cpu/resctrl/core.c     |  29 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |   9 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 196 +++++++++++++++++++++++++
 4 files changed, 253 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 5368cedfb530..c9888d530c8d 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -138,6 +138,21 @@ with respect to allocation:
 		non-linear. This field is purely informational
 		only.
 
+"thread_throttle_mode":
+		The memory bandwidth control applied to a core when
+		control is provided per core but each hardware
+		thread can be assigned a unique CLOSID.
+		"thread_throttle_mode" displays how the bandwidth
+		percentage allocated to the core is selected:
+		either "max" or "min" throttling of the bandwidth
+		percentages of the per-thread CLOS. Specifically, when
+		throttling is "max" then the lowest bandwidth percentage
+		is allocated to the core and when throttling is "min"
+		then the highest bandwidth percentage is allocated to
+		the core.
+		Configurable on systems that support both modes by
+		writing "min" or "max" to the file.
+
 If RDT monitoring is available there will be an "L3_MON" directory
 with the following files:
 
@@ -364,8 +379,10 @@ to the next control step available on the hardware.
 
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
index 89049b343c7a..00c8a948fe2e 100644
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
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3a16d1c0ff40..a7b63b948ce8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -9,6 +9,7 @@
 
 #define MSR_IA32_L3_QOS_CFG		0xc81
 #define MSR_IA32_L2_QOS_CFG		0xc82
+#define MSR_MBA_CFG			0xc84
 #define MSR_IA32_L3_CBM_BASE		0xc90
 #define MSR_IA32_L2_CBM_BASE		0xd10
 #define MSR_IA32_MBA_THRTL_BASE		0xd50
@@ -21,6 +22,8 @@
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
 
+#define MBA_THROTTLE_MODE_MIN		0x01ULL
+
 /*
  * Event IDs are used to program IA32_QM_EVTSEL before reading event
  * counter from IA32_QM_CTR
@@ -38,6 +41,8 @@
 #define MBA_MAX_MBPS			U32_MAX
 #define MAX_MBA_BW_AMD			0x800
 
+#define MBA_THREAD_THROTTLE_MODE	BIT_ULL(0)
+
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
 /*
@@ -241,6 +246,7 @@ struct rdtgroup {
 #define RF_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RF_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
 #define RF_CTRL_BASE			(RFTYPE_BASE | RFTYPE_CTRL)
+#define RF_UNINITIALIZED		ULONG_MAX
 
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
@@ -610,5 +616,8 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
 bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
+bool mba_cfg_supports_min_max_intel(void);
+void thread_throttle_mode_init_intel_rw(void);
+void thread_throttle_mode_init_intel_ro(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 210a6fd375bd..fbee891a7d6e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -29,6 +29,7 @@
 
 #include <uapi/linux/magic.h>
 
+#include <asm/intel-family.h>
 #include <asm/resctrl_sched.h>
 #include "internal.h"
 
@@ -1017,6 +1018,149 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
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
+	u64 mba_cfg;
+	int ret;
+
+	if (mba_cfg_supports_min_max_intel()) {
+		ret = rdmsrl_safe(MSR_MBA_CFG, &mba_cfg);
+		if (ret)
+			return -ENOENT;
+		throttle_mode = mba_cfg & MBA_THREAD_THROTTLE_MODE;
+	}
+
+	seq_printf(seq, "%s\n", throttle_mode ? "min" : "max");
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
+	int max_pkg = topology_max_packages();
+	cpumask_var_t cpu_mask;
+	int pkg, i;
+
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
+		rdt_last_cmd_puts("Memory allocation error\n");
+		return -ENOMEM;
+	}
+
+	/* Set one CPU from each package in CPU mask */
+	for (pkg = 0; pkg < max_pkg; pkg++) {
+		for_each_online_cpu(i) {
+			if (topology_physical_package_id(i) == pkg) {
+				cpumask_set_cpu(i, cpu_mask);
+				break;
+			}
+		}
+	}
+
+	on_each_cpu_mask(cpu_mask, update_mba_cfg, &mba_cfg, 1);
+
+	free_cpumask_var(cpu_mask);
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
+	int max_pkg = topology_max_packages();
+	u64 mba_cfg;
+	int ret = 0;
+
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
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n') {
+		rdt_last_cmd_puts("Invalid input\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rdmsrl(MSR_MBA_CFG, mba_cfg);
+
+	if ((sysfs_streq(buf, "min") && (mba_cfg & MBA_THREAD_THROTTLE_MODE)) ||
+	    (sysfs_streq(buf, "max") && !(mba_cfg & MBA_THREAD_THROTTLE_MODE)))
+		goto out;
+
+	if (sysfs_streq(buf, "min")) {
+		mba_cfg |= MBA_THROTTLE_MODE_MIN;
+	} else if (sysfs_streq(buf, "max")) {
+		mba_cfg &= ~MBA_THROTTLE_MODE_MIN;
+	} else {
+		rdt_last_cmd_puts("Unknown or unsupported mode\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * MSR has package scope but the throttling mode is expected to be
+	 * configured the same for all packages on the system. When user
+	 * modifies the thread throttling mode ensure that entire system
+	 * uses the same mode.
+	 */
+	if (max_pkg == 1)
+		wrmsrl(MSR_MBA_CFG, mba_cfg);
+	else
+		ret = rdt_system_mba_cfg_set(mba_cfg);
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	return ret ?: nbytes;
+}
+
 static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
@@ -1512,6 +1656,17 @@ static struct rftype res_common_files[] = {
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
+		.fflags		= RF_UNINITIALIZED,
+	},
 	{
 		.name		= "max_threshold_occupancy",
 		.mode		= 0644,
@@ -1571,6 +1726,47 @@ static struct rftype res_common_files[] = {
 
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
+void thread_throttle_mode_init_intel_rw(void)
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
+void thread_throttle_mode_init_intel_ro(void)
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
-- 
2.21.0


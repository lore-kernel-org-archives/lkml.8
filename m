Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B4DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906C32074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHXTLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:11:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:36587 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgHXTLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:11:33 -0400
IronPort-SDR: LSgi5LmfZilKQRkgX+UjZC3quDMT+OQaTACbNcLYGzFxmJQ3DmxpeVxkv/YEPp0b8bCw3sHjxH
 wWrtaLlf8YmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="157026634"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="157026634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 12:11:31 -0700
IronPort-SDR: FW7QfGFlp6qlkB4eqy5KGaHHzv30VdI35NlquK6y4Zf24IGCT2bwopYn1oarG0c48Z2lPfdGe7
 q9J8fjY9tl5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="322442258"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2020 12:11:31 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 2/2] x86/resctrl: Enable user to view thread or core throttling mode
Date:   Mon, 24 Aug 2020 12:11:21 -0700
Message-Id: <1598296281-127595-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1598296281-127595-1-git-send-email-fenghua.yu@intel.com>
References: <1598296281-127595-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early Intel hardware implementations of Memory Bandwidth Allocation (MBA)
could only control bandwidth at the processor core level. This meant that
when two processes with different bandwidth allocations ran simultaneously
on the same core the hardware had to resolve this difference. It did so by
applying the higher throttling value (lower bandwidth) to both processes.

Newer implementations can apply different throttling values to each
thread on a core.

Introduce a new resctrl file, "thread_throttle_mode", on Intel systems
that shows to the user how throttling values are allocated, per-core or
per-thread.

On systems that support per-core throttling, the file will display "max".
On newer systems that support per-thread throttling, the file will display
"per-thread".

AMD confirmed in
https://lore.kernel.org/lkml/18d277fd-6523-319c-d560-66b63ff606b8@amd.com
that AMD bandwidth allocation is already at thread level but that the AMD
implementation does not use a memory delay throttle mode. So to avoid
confusion the thread throttling mode would be UNDEFINED on AMD systems
and the "thread_throttle_mode" file will not be visible.

Originally-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Change log:
v3:
- Rename "get_rdtgroup_rftype_get_by_name()" to
  "rdtgroup_get_rftype_by_name()" (Boris).
- Re-base the patch to tip:x86/cache (Boris).

v2:
- Rename "arch_throttle_mode" to "throttle_mode" and
  "rdtgroup_rftype_by_name()" to "rdtgroup_rftype_get_by_name()" (Boris).

 Documentation/x86/resctrl_ui.rst       | 18 ++++++++-
 arch/x86/kernel/cpu/resctrl/core.c     | 11 ++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 30 ++++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 +++++++++++++++++++++++++-
 4 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 5368cedfb530..e59b7b93a9b4 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -138,6 +138,18 @@ with respect to allocation:
 		non-linear. This field is purely informational
 		only.
 
+"thread_throttle_mode":
+		Indicator on Intel systems of how tasks running on threads
+		of a physical core are throttled in cases where they
+		request different memory bandwidth percentages:
+
+		"max":
+			the smallest percentage is applied
+			to all threads
+		"per-thread":
+			bandwidth percentages are directly applied to
+			the threads running on the core
+
 If RDT monitoring is available there will be an "L3_MON" directory
 with the following files:
 
@@ -364,8 +376,10 @@ to the next control step available on the hardware.
 
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
index 1c00f2f0bf0c..9e1712e8aef7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -273,6 +273,12 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	}
 	r->data_width = 3;
 
+	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA))
+		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
+	else
+		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
+	thread_throttle_mode_init();
+
 	r->alloc_capable = true;
 	r->alloc_enabled = true;
 
@@ -293,6 +299,11 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	r->membw.delay_linear = false;
 	r->membw.arch_needs_linear = false;
 
+	/*
+	 * AMD does not use memory delay throttle model to control
+	 * the allocation like Intel does.
+	 */
+	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
 	/* Max value is 2048, Data width should be 4 in decimal */
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0b4829484c9e..80fa997fae60 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -371,22 +371,39 @@ struct rdt_cache {
 	bool		arch_has_empty_bitmaps;
 };
 
+/**
+ * enum membw_throttle_mode - System's memory bandwidth throttling mode
+ * @THREAD_THROTTLE_UNDEFINED:	Not relevant to the system
+ * @THREAD_THROTTLE_MAX:	Memory bandwidth is throttled at the core
+ *				always using smallest bandwidth percentage
+ *				assigned to threads, aka "max throttling"
+ * @THREAD_THROTTLE_PER_THREAD:	Memory bandwidth is throttled at the thread
+ */
+enum membw_throttle_mode {
+	THREAD_THROTTLE_UNDEFINED = 0,
+	THREAD_THROTTLE_MAX,
+	THREAD_THROTTLE_PER_THREAD,
+};
+
 /**
  * struct rdt_membw - Memory bandwidth allocation related data
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
  * @arch_needs_linear:	True if we can't configure non-linear resources
+ * @throttle_mode:	Bandwidth throttling mode when threads request
+ *			different memory bandwidths
  * @mba_sc:		True if MBA software controller(mba_sc) is enabled
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct rdt_membw {
-	u32		min_bw;
-	u32		bw_gran;
-	u32		delay_linear;
-	bool		arch_needs_linear;
-	bool		mba_sc;
-	u32		*mb_map;
+	u32				min_bw;
+	u32				bw_gran;
+	u32				delay_linear;
+	bool				arch_needs_linear;
+	enum membw_throttle_mode	throttle_mode;
+	bool				mba_sc;
+	u32				*mb_map;
 };
 
 static inline bool is_llc_occupancy_enabled(void)
@@ -607,5 +624,6 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
+void __init thread_throttle_mode_init(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 78f3be10e215..b494187632b2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1027,6 +1027,19 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
+					 struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
+		seq_puts(seq, "per-thread\n");
+	else
+		seq_puts(seq, "max\n");
+
+	return 0;
+}
+
 static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
@@ -1523,6 +1536,17 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_delay_linear_show,
 		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
 	},
+	/*
+	 * Platform specific which (if any) capabilities are provided by
+	 * thread_throttle_mode. Defer "fflags" initialization to platform
+	 * discovery.
+	 */
+	{
+		.name		= "thread_throttle_mode",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_thread_throttle_mode_show,
+	},
 	{
 		.name		= "max_threshold_occupancy",
 		.mode		= 0644,
@@ -1593,7 +1617,7 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	for (rft = rfts; rft < rfts + len; rft++) {
-		if ((fflags & rft->fflags) == rft->fflags) {
+		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
 			ret = rdtgroup_add_file(kn, rft);
 			if (ret)
 				goto error;
@@ -1610,6 +1634,33 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 	return ret;
 }
 
+static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
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
+void __init thread_throttle_mode_init(void)
+{
+	struct rftype *rft;
+
+	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
+	if (!rft)
+		return;
+
+	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
+}
+
 /**
  * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
  * @r: The resource group with which the file is associated.
-- 
2.19.1


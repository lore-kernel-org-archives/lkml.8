Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26ED2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWKOaQWC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xwyGpJ9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHZQIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHZQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:08:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D9C061574;
        Wed, 26 Aug 2020 09:08:29 -0700 (PDT)
Date:   Wed, 26 Aug 2020 16:08:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598458106;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ebq8NKBRgy1Hm9IvsN+cdbSEyXakYm/n0Q5fCvenHE=;
        b=SWKOaQWCkXiIUwqo+1obVgXwNJ+47v90FpC037JLuL8FQh1lzp9PSJea/bu0cVocDUe/Y3
        E4MBnd8yrHYTLWszb6jYnBlC1Agay9oW8zXzVzcMD/k7YApYlm9d41X5GkYkFsRGgRRu/A
        3ryTRyJzefyM9Qbo6bNJAkSlxlyxKXLZwmTrPcvd0+fDIIlDma4m1Al8NTaZneW0mTzqFj
        H+CL5+0iihaz6by+2FcNxEr0draQ9Tw1yGdjXuTW/hrOX81kJLn7aoBXMdOm0kUIYoSpsa
        d0w3zlsIK/NQ4EmG0fTd7EfUQ6q9+UijuBDJDN9MJwuoS97FvMpkbsP+Vf3w6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598458106;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ebq8NKBRgy1Hm9IvsN+cdbSEyXakYm/n0Q5fCvenHE=;
        b=xwyGpJ9SBCEPnXDqCqYt9asiUvEKjReK6bTs0ojmksQrY1k3Qdwoj5S+WbeL61oDXG2FxN
        yoPAjzASMkWynrCA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Enable user to view thread or core
 throttling mode
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1598296281-127595-3-git-send-email-fenghua.yu@intel.com>
References: <1598296281-127595-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <159845810528.389.15030205688555561094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     29b6bd41ee24f69a85666b9f68d500b382d408fd
Gitweb:        https://git.kernel.org/tip/29b6bd41ee24f69a85666b9f68d500b382d408fd
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 24 Aug 2020 12:11:21 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 26 Aug 2020 17:53:22 +02:00

x86/resctrl: Enable user to view thread or core throttling mode

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

AMD confirmed in [1] that AMD bandwidth allocation is already at thread
level but that the AMD implementation does not use a memory delay
throttle mode. So to avoid confusion the thread throttling mode would be
UNDEFINED on AMD systems and the "thread_throttle_mode" file will not be
visible.

Originally-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/1598296281-127595-3-git-send-email-fenghua.yu@intel.com
Link: [1] https://lore.kernel.org/lkml/18d277fd-6523-319c-d560-66b63ff606b8@amd.com
---
 Documentation/x86/resctrl_ui.rst       | 18 +++++++-
 arch/x86/kernel/cpu/resctrl/core.c     | 11 +++++-
 arch/x86/kernel/cpu/resctrl/internal.h | 30 +++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 ++++++++++++++++++++++++-
 4 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 5368ced..e59b7b9 100644
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
index 1c00f2f..9e1712e 100644
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
index 0b48294..80fa997 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -372,21 +372,38 @@ struct rdt_cache {
 };
 
 /**
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
+/**
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
index 78f3be1..b494187 100644
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
@@ -1610,6 +1634,33 @@ error:
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

Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB956C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D077D20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgERXrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:47:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:65332 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgERXrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:47:13 -0400
IronPort-SDR: SDtBtCc87c8LS9S5TDKkM59cQpaAB1SPi2xjO9uGmIGUMaA28ze9cRTQf/mSuiB4cvVB63Zhfb
 2mGWuhtnPZ9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:47:11 -0700
IronPort-SDR: qoBGuwJEjBi9Be6sqzv7IhJ/7LjGpZNCoDUHS7XhXZjZywe8UnoSVendg1eF2TXQAMU1Cw+VJl
 f+HpgVGSPDUQ==
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="288757563"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:47:11 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 3/4] x86/resctrl: Enable per-thread MBA
Date:   Mon, 18 May 2020 16:46:48 -0700
Message-Id: <aa348d8863fcf94357f499b0cb4f9ec944489198.1589844108.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589844108.git.reinette.chatre@intel.com>
References: <cover.1589844108.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Current Memory Bandwidth Allocation (MBA) hardware has a limitation:
all threads on the same core must have the same delay value. If there
are different delay values across threads on one core, the original
MBA implementation allocates the max delay value to the core and an
updated implementation allocates either min or max delay value specified
by a configuration MSR across threads on the core.

Newer systems support per-thread MBA such that each thread is allocated
with its own delay value.

If per-thread MBA is supported, report "per-thread" in resctrl file
"info/MB/thread_throttle_mode" to let user applications know memory
bandwidth is allocated per thread and help them fine tune MBA on thread
level.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
[reinette: transition patch to use membw_throttle_mode enum]
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since V4:
- Pick up Babu's "Reviewed-by" tag.

 Documentation/x86/resctrl_ui.rst       |  3 +++
 arch/x86/kernel/cpu/resctrl/core.c     |  5 ++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 861ee2816470..1b066d1aafad 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -150,6 +150,9 @@ with respect to allocation:
 		"max":
 			the smallest percentage is applied
 			to all threads
+		"per-thread":
+			bandwidth percentages are directly applied to
+			the threads running on the core
 
 If RDT monitoring is available there will be an "L3_MON" directory
 with the following files:
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 687221cae5c3..716ad71edf80 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -304,7 +304,10 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	}
 	r->data_width = 3;
 
-	if (mba_cfg_supports_min_max_intel()) {
+	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA)) {
+		r->membw.arch_throttle_mode = THREAD_THROTTLE_PER_THREAD;
+		thread_throttle_mode_init_ro();
+	} else if (mba_cfg_supports_min_max_intel()) {
 		r->membw.arch_throttle_mode = THREAD_THROTTLE_MIN_MAX;
 		thread_throttle_mode_init_rw();
 	} else {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6b9b21d67c9b..e198ea2a8468 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -391,11 +391,13 @@ struct rdt_cache {
  * @THREAD_THROTTLE_MAX_ONLY:	Memory bandwidth is throttled at the core
  *				always using smallest bandwidth percentage
  *				assigned to threads, aka "max throttling"
+ * @THREAD_THROTTLE_PER_THREAD:	Memory bandwidth is throttled at the thread
  */
 enum membw_throttle_mode {
 	THREAD_THROTTLE_UNDEFINED = 0,
 	THREAD_THROTTLE_MIN_MAX,
 	THREAD_THROTTLE_MAX_ONLY,
+	THREAD_THROTTLE_PER_THREAD,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3ce6319b7226..088a1536bccc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1038,6 +1038,11 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
  * with the maximum delay value that from the software interface will be
  * the minimum of the bandwidth percentages assigned to the hardware threads
  * sharing the core.
+ *
+ * Some systems (identified by X86_FEATURE_PER_THREAD_MBA enumerated via CPUID)
+ * support per-thread MBA. On these systems hardware doesn't apply the minimum
+ * or maximum delay value to all threads in a core. Instead, a thread is
+ * allocated with the delay value that is assigned to the thread.
  */
 static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 					 struct seq_file *seq, void *v)
@@ -1047,12 +1052,18 @@ static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 
 	mutex_lock(&rdtgroup_mutex);
 
+	if (r->membw.arch_throttle_mode == THREAD_THROTTLE_PER_THREAD) {
+		seq_puts(seq, "per-thread\n");
+		goto out;
+	}
+
 	if (r->membw.arch_throttle_mode == THREAD_THROTTLE_MIN_MAX)
 		throttle_mode = mba_cfg_msr & MBA_THROTTLE_MODE_MASK;
 
 	seq_puts(seq,
 		 throttle_mode == MBA_THROTTLE_MODE_MIN ? "min\n" : "max\n");
 
+out:
 	mutex_unlock(&rdtgroup_mutex);
 	return 0;
 }
-- 
2.21.0


Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58275C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFEF2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgEFXum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:50:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:22519 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgEFXue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:50:34 -0400
IronPort-SDR: 25GSdg3ZGz11N+O+zD8cDqcWLsH67DgKJXspTcn8nvqxwjVBBCILt8b1k/y1TZK/wn/zqRnpza
 5nyuC1cXeaQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:50:31 -0700
IronPort-SDR: MZoqhT+0tjQeEBXoFgnejosY45DTHTa4tZoPdT8hZTpfJaafSY3P0IBmke75keOtVDQfRV8/Jj
 kYskYC4pJQ+g==
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="435084106"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:50:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 3/4] x86/resctrl: Enable per-thread MBA
Date:   Wed,  6 May 2020 16:49:54 -0700
Message-Id: <3510244af29b7443221dc926745fd0cf541576e0.1588808538.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588808537.git.reinette.chatre@intel.com>
References: <cover.1588808537.git.reinette.chatre@intel.com>
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
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Fix rST formatting of documentation (resctrl_ui.rst) describing
  new "thread_throttle_mode" resctrl file.
- Use boot_cpu_has() instead of static_cpu_has() when determining what
  to display to user (slow path).

 Documentation/x86/resctrl_ui.rst       |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

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
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6a9408060ac4..c60a3b307f7d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1038,12 +1038,23 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
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
 {
 	unsigned int throttle_mode = 0;
 
+	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA)) {
+		seq_puts(seq, "per-thread\n");
+
+		return 0;
+	}
+
 	if (mba_cfg_supports_min_max_intel())
 		throttle_mode = mba_cfg_msr & MBA_THROTTLE_MODE_MASK;
 
-- 
2.21.0


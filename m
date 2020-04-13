Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC89C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1361220644
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbgDMU6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:58:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:8596 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733294AbgDMU6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:58:23 -0400
IronPort-SDR: MkbRIPwntUE8v4DSccb13tIbFMBLKpGYVH7ubVXP5zw+derXKX7DdBP66yqlTGtI9OL/09Ve/9
 OkF/SUVfZaMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 13:58:21 -0700
IronPort-SDR: iOWzpre00kBS4ss+bQZgZl+061A9SCHiYMiBDCCqfCm8w2ZzVmpQgNfMs6mDBx51huos7fWppR
 OHmjefBxZibw==
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="453301666"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 13:58:21 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 3/4] x86/resctrl: Enable per-thread MBA
Date:   Mon, 13 Apr 2020 13:58:02 -0700
Message-Id: <00a2335632f46c25c00646f84f3afca8e6332c98.1586801373.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1586801373.git.reinette.chatre@intel.com>
References: <cover.1586801373.git.reinette.chatre@intel.com>
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
 Documentation/x86/resctrl_ui.rst       |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 1dc0611ec266..4c0fba65da8e 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -145,6 +145,8 @@ with respect to allocation:
 		bandwidth percentages:
 		"min" - the largest percentage is applied to all threads
 		"max" - the smallest percentage is applied to all threads
+		"per-thread" - bandwidth percentages are directly applied to
+			       the threads running on the core
 
 If RDT monitoring is available there will be an "L3_MON" directory
 with the following files:
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2d6707b52a5d..d4e9b8a204d6 100644
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
 
+	if (static_cpu_has(X86_FEATURE_PER_THREAD_MBA)) {
+		seq_puts(seq, "per-thread\n");
+
+		return 0;
+	}
+
 	if (mba_cfg_supports_min_max_intel())
 		throttle_mode = mba_cfg_msr & MBA_THROTTLE_MODE_MASK;
 
-- 
2.21.0


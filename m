Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9395FC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E0207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ETWeah5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgG2AL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:11:56 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:43639 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbgG2ALx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595981513; x=1627517513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6L6ZRUMVlwG22LRFDI+OYQ3UvbTI0uybQ2AfLBqLhgI=;
  b=ETWeah5HxHk8jLNfFPq80tGezIRSeZW/dScVvK4W0SvC0fdvXInaA/ap
   7G1LE/3IT0Yg+4GCnWRbBCyhwx2QVaHqTHujPuM5FnNN4ErZmd1FhDkiJ
   t8if6k4tLdTWHkK/ksZgAImd8Em58XLbajiM83eknXd8UDgSkTULl1t3J
   c=;
IronPort-SDR: ltnIxeEV8ISU9YIopCcL0ji6nbtR2vPTnmPf4VTsc+YSzVtwXddXFLahQ5RYJ/h+VF0L9/X8pY
 4W+AJcOKwEqQ==
X-IronPort-AV: E=Sophos;i="5.75,408,1589241600"; 
   d="scan'208";a="46122877"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 29 Jul 2020 00:11:52 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 93029A06EB;
        Wed, 29 Jul 2020 00:11:48 +0000 (UTC)
Received: from EX13D01UWA004.ant.amazon.com (10.43.160.99) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:33 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13d01UWA004.ant.amazon.com (10.43.160.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:33 +0000
Received: from localhost (10.143.192.232) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 00:11:31 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        <mingo@kernel.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v2 4/5] prctl: Hook L1D flushing in via prctl
Date:   Wed, 29 Jul 2020 10:11:02 +1000
Message-ID: <20200729001103.6450-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729001103.6450-1-sblbir@amazon.com>
References: <20200729001103.6450-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing PR_GET/SET_SPECULATION_CTRL API to expose the L1D
flush capability. For L1D flushing PR_SPEC_FORCE_DISABLE and
PR_SPEC_DISABLE_NOEXEC are not supported.

There is also no seccomp integration for the feature.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/kernel/cpu/bugs.c | 54 ++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/tlb.c          | 25 +++++++++++++++++-
 include/uapi/linux/prctl.h |  1 +
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0b71970d2d3d..935ea88313ab 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -295,6 +295,13 @@ enum taa_mitigations {
 	TAA_MITIGATION_TSX_DISABLED,
 };
 
+enum l1d_flush_out_mitigations {
+	L1D_FLUSH_OUT_OFF,
+	L1D_FLUSH_OUT_ON,
+};
+
+static enum l1d_flush_out_mitigations l1d_flush_out_mitigation __ro_after_init = L1D_FLUSH_OUT_ON;
+
 /* Default mitigation for TAA-affected CPUs */
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
 static bool taa_nosmt __ro_after_init;
@@ -378,6 +385,18 @@ static void __init taa_select_mitigation(void)
 	pr_info("%s\n", taa_strings[taa_mitigation]);
 }
 
+static int __init l1d_flush_out_parse_cmdline(char *str)
+{
+	if (!boot_cpu_has_bug(X86_BUG_L1TF))
+		return 0;
+
+	if (!strcmp(str, "off"))
+		l1d_flush_out_mitigation = L1D_FLUSH_OUT_OFF;
+
+	return 0;
+}
+early_param("l1d_flush_out", l1d_flush_out_parse_cmdline);
+
 static int __init tsx_async_abort_parse_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TAA))
@@ -1220,6 +1239,23 @@ static void task_update_spec_tif(struct task_struct *tsk)
 		speculation_ctrl_update_current();
 }
 
+static int l1d_flush_out_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+
+	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
+		return -EPERM;
+
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		return enable_l1d_flush_for_task(task);
+	case PR_SPEC_DISABLE:
+		return disable_l1d_flush_for_task(task);
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
@@ -1312,6 +1348,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1328,6 +1366,20 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 }
 #endif
 
+static int l1d_flush_out_prctl_get(struct task_struct *task)
+{
+	int ret;
+
+	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
+		return PR_SPEC_FORCE_DISABLE;
+
+	ret = test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+	if (ret)
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	else
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1381,6 +1433,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 48ccc3dd1492..77b739929ad2 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -316,8 +316,31 @@ EXPORT_SYMBOL_GPL(leave_mm);
 
 int enable_l1d_flush_for_task(struct task_struct *tsk)
 {
+	int cpu, ret = 0, i;
+
+	/*
+	 * Do not enable L1D_FLUSH_OUT if
+	 * b. The CPU is not affected by the L1TF bug
+	 * c. The CPU does not have L1D FLUSH feature support
+	 * c. The task's affinity is on cores with SMT on.
+	 */
+
+	if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
+			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
+		return -EINVAL;
+
+	cpu = get_cpu();
+
+	for_each_cpu(i, &tsk->cpus_mask) {
+		if (cpu_data(i).smt_active == true) {
+			put_cpu();
+			return -EINVAL;
+		}
+	}
+
 	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
-	return 0;
+	put_cpu();
+	return ret;
 }
 
 int disable_l1d_flush_for_task(struct task_struct *tsk)
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e36..1e864867a367 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH_OUT		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
-- 
2.17.1


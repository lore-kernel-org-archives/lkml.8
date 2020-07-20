Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B91C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BF320656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGTNzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:55:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:51259 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTNzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:55:38 -0400
IronPort-SDR: NbAdbsw3YoAujPSdTUak3dEY1mM6NoXLwRqE2GcLSJz3XLmlpHU0866UbMDopC0NHGELliojKB
 PaE9K7Kb2pNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="214588086"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="214588086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 06:55:33 -0700
IronPort-SDR: cafc5xPM8ONBkAaZB0Q9pImfEN8WiXRs4WjQuiVhzMoPaJwebvr/KtZ5bnfgEvcV1S1F82lqV8
 iKat1zvA3wnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="283521068"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2020 06:55:33 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, yu-cheng.yu@intel.com,
        bigeasy@linutronix.de, gorcunov@gmail.com, hpa@zytor.com,
        eranian@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] x86/fpu/xstate: Fix an xstate size check warning
Date:   Mon, 20 Jul 2020 06:50:51 -0700
Message-Id: <1595253051-75374-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

An xstate size check warning is triggered on the machine which supports
Architectural LBRs.

[    0.000000] XSAVE consistency problem, dumping leaves
[    0.000000] WARNING: CPU: 0 PID: 0 at
arch/x86/kernel/fpu/xstate.c:649 fpu__init_system_xstate+0x4d4/0xd0e
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted intel-arch_lbr+
[    0.000000] RIP: 0010:fpu__init_system_xstate+0x4d4/0xd0e

The xstate size check routine, init_xstate_size(), compares the size
retrieved from the hardware with the size of task->fpu, which is
calculated by the software.

The size from the hardware is the total size of the enabled xstates in
XCR0 | IA32_XSS. Architectural LBR state is a dynamic supervisor
feature, which sets the corresponding bit in the IA32_XSS at boot time.
The size from the hardware includes the size of the Architectural LBR
state.

However, a dynamic supervisor feature doesn't allocate a buffer in the
task->fpu. The size of task->fpu doesn't include the size of the
Architectural LBR state. The mismatch will trigger the warning.

Three options as below were considered to fix the issue:
- Correct the size from the hardware by subtracting the size of the
  dynamic supervisor features.
  The purpose of the check is to compare the size CPU told with the size
  of the XSAVE buffer, which is calculated by the software. If the
  software mucks with the number from hardware, it removes the value of
  the check.
  This option is not a good option.
- Prevent the hardware from counting the size of the dynamic supervisor
  feature by temporarily removing the corresponding bits in IA32_XSS.
  Two extra MSR writes are required to flip the IA32_XSS. The option is
  not pretty, but it is workable. The check is only called once at early
  boot time. The synchronization or context-switching doesn't need to be
  worried.
  This option is implemented here.
- Remove the check entirely, because the check hasn't found any real
  problems. The option may be an alternative as option 2.
  This option is not implemented here.

Add a new function, get_xsaves_size_no_dynamic(), which retrieves the
total size without the dynamic supervisor features from the hardware.
The size will be used to compare with the size of task->fpu.

Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")
Reported-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 10cf878..a4e4ac4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -611,6 +611,10 @@ static void check_xstate_against_struct(int nr)
  * This essentially double-checks what the cpu told us about
  * how large the XSAVE buffer needs to be.  We are recalculating
  * it to be safe.
+ *
+ * Dynamic XSAVE features allocate their own buffers and are not
+ * covered by these checks. Only the size of the buffer for task->fpu
+ * is checked here.
  */
 static void do_extra_xstate_size_checks(void)
 {
@@ -673,6 +677,33 @@ static unsigned int __init get_xsaves_size(void)
 	return ebx;
 }
 
+/*
+ * Get the total size of the enabled xstates without the dynamic supervisor
+ * features.
+ */
+static unsigned int __init get_xsaves_size_no_dynamic(void)
+{
+	u64 mask = xfeatures_mask_dynamic();
+	unsigned int size;
+
+	if (!mask)
+		return get_xsaves_size();
+
+	/* Disable dynamic features. */
+	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
+
+	/*
+	 * Ask the hardware what size is required of the buffer.
+	 * This is the size required from the task->fpu buffer.
+	 */
+	size = get_xsaves_size();
+
+	/* Re-enable dynamic features so XSAVES will work on them again. */
+	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
+
+	return size;
+}
+
 static unsigned int __init get_xsave_size(void)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -710,7 +741,7 @@ static int __init init_xstate_size(void)
 	xsave_size = get_xsave_size();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size = get_xsaves_size();
+		possible_xstate_size = get_xsaves_size_no_dynamic();
 	else
 		possible_xstate_size = xsave_size;
 
-- 
2.7.4


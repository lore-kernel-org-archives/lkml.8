Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF4CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6822220882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgAUUUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:20:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:7227 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgAUUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:20:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 12:20:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="307313026"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2020 12:20:01 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 3/8] x86/fpu/xstate: Introduce XSAVES supervisor states
Date:   Tue, 21 Jan 2020 12:18:38 -0800
Message-Id: <20200121201843.12047-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200121201843.12047-1-yu-cheng.yu@intel.com>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XSAVES supervisor states by setting MSR_IA32_XSS bits according to
CPUID enumeration results.  Also revise comments at various places.

v2:
- Remove printing of supervisor xstates from fpu__init_system_xstate().

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3b22d630f5bb..0c5c91ee235e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -229,13 +229,14 @@ void fpu__init_cpu_xstate(void)
 	 * states can be set here.
 	 */
 	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+
+	/*
+	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
 }
 
-/*
- * Note that in the future we will likely need a pair of
- * functions here: one for user xstates and the other for
- * system xstates.  For now, they are the same.
- */
 static int xfeature_enabled(enum xfeature xfeature)
 {
 	return !!(xfeatures_mask_all & (1UL << xfeature));
@@ -626,9 +627,6 @@ static void do_extra_xstate_size_checks(void)
  * the size of the *user* states.  If we use it to size a buffer
  * that we use 'XSAVES' on, we could potentially overflow the
  * buffer because 'XSAVES' saves system states too.
- *
- * Note that we do not currently set any bits on IA32_XSS so
- * 'XCR0 | IA32_XSS == XCR0' for now.
  */
 static unsigned int __init get_xsaves_size(void)
 {
@@ -751,7 +749,11 @@ void __init fpu__init_system_xstate(void)
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
 	xfeatures_mask_all = eax + ((u64)edx << 32);
 
-	/* Place supervisor features in xfeatures_mask_all here */
+	/*
+	 * Find supervisor xstates supported by the processor.
+	 */
+	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	xfeatures_mask_all |= ecx + ((u64)edx << 32);
 
 	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
@@ -812,6 +814,13 @@ void fpu__resume_cpu(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
 		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+
+	/*
+	 * Restore IA32_XSS. The same CPUID bit enumerates support
+	 * of XSAVES and MSR_IA32_XSS.
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
 }
 
 /*
-- 
2.21.0


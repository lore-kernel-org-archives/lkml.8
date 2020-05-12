Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C83C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCDB206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgELOzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:55:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:29542 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbgELOzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:55:11 -0400
IronPort-SDR: KxMJMbIabyE6yDBT5BN3vL/bSjW7lWFaLF82e1KxesbqygEYIR5DYAw+Q54ohtRjq+F18n5MHp
 LKfpATp2UlLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:55:08 -0700
IronPort-SDR: ycXa9Zx+oa3bMYzeNsXVx6WidMeyg+KjvHrd4q3baB8WKcIF9fxtE728pgCvjYxrc1zo1dvV9c
 vJ2VSjIqwsTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="371587810"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2020 07:55:08 -0700
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
Subject: [PATCH v4 04/10] x86/fpu/xstate: Introduce XSAVES supervisor states
Date:   Tue, 12 May 2020 07:54:38 -0700
Message-Id: <20200512145444.15483-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200512145444.15483-1-yu-cheng.yu@intel.com>
References: <20200512145444.15483-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XSAVES supervisor states by setting MSR_IA32_XSS bits according to
CPUID enumeration results.  Also revise comments at various places.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Remove printing of supervisor xstates from fpu__init_system_xstate().

 arch/x86/kernel/fpu/xstate.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index fa71af643025..a68213ed5be6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -228,13 +228,14 @@ void fpu__init_cpu_xstate(void)
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
 static bool xfeature_enabled(enum xfeature xfeature)
 {
 	return xfeatures_mask_all & BIT_ULL(xfeature);
@@ -625,9 +626,6 @@ static void do_extra_xstate_size_checks(void)
  * the size of the *user* states.  If we use it to size a buffer
  * that we use 'XSAVES' on, we could potentially overflow the
  * buffer because 'XSAVES' saves system states too.
- *
- * Note that we do not currently set any bits on IA32_XSS so
- * 'XCR0 | IA32_XSS == XCR0' for now.
  */
 static unsigned int __init get_xsaves_size(void)
 {
@@ -750,7 +748,12 @@ void __init fpu__init_system_xstate(void)
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
 	xfeatures_mask_all = eax + ((u64)edx << 32);
 
-	/* Place supervisor features in xfeatures_mask_all here */
+	/*
+	 * Find supervisor xstates supported by the processor.
+	 */
+	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	xfeatures_mask_all |= ecx + ((u64)edx << 32);
+
 	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
@@ -810,6 +813,13 @@ void fpu__resume_cpu(void)
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


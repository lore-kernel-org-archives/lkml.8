Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1FEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF4C21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgDSUg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgDSUgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:36:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA71C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:36:13 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQGfe-0007Jy-D8; Sun, 19 Apr 2020 22:36:06 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A6E29FFBA2;
        Sun, 19 Apr 2020 22:36:05 +0200 (CEST)
Message-Id: <20200419203336.039484088@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 19 Apr 2020 22:31:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch 04/15] x86/alternatives: Move temporary_mm helpers into C
References: <20200419203137.214111265@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of these inlines is the text poke code and this must not be
exposed to the world.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mmu_context.h |   55 -------------------------------------
 arch/x86/kernel/alternative.c      |   55 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 55 deletions(-)

--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -215,59 +215,4 @@ static inline bool arch_vma_access_permi
 
 unsigned long __get_current_cr3_fast(void);
 
-typedef struct {
-	struct mm_struct *mm;
-} temp_mm_state_t;
-
-/*
- * Using a temporary mm allows to set temporary mappings that are not accessible
- * by other CPUs. Such mappings are needed to perform sensitive memory writes
- * that override the kernel memory protections (e.g., W^X), without exposing the
- * temporary page-table mappings that are required for these write operations to
- * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
- * mapping is torn down.
- *
- * Context: The temporary mm needs to be used exclusively by a single core. To
- *          harden security IRQs must be disabled while the temporary mm is
- *          loaded, thereby preventing interrupt handler bugs from overriding
- *          the kernel memory protection.
- */
-static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
-{
-	temp_mm_state_t temp_state;
-
-	lockdep_assert_irqs_disabled();
-	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	switch_mm_irqs_off(NULL, mm, current);
-
-	/*
-	 * If breakpoints are enabled, disable them while the temporary mm is
-	 * used. Userspace might set up watchpoints on addresses that are used
-	 * in the temporary mm, which would lead to wrong signals being sent or
-	 * crashes.
-	 *
-	 * Note that breakpoints are not disabled selectively, which also causes
-	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
-	 * undesirable, but still seems reasonable as the code that runs in the
-	 * temporary mm should be short.
-	 */
-	if (hw_breakpoint_active())
-		hw_breakpoint_disable();
-
-	return temp_state;
-}
-
-static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
-{
-	lockdep_assert_irqs_disabled();
-	switch_mm_irqs_off(NULL, prev_state.mm, current);
-
-	/*
-	 * Restore the breakpoints if they were disabled before the temporary mm
-	 * was loaded.
-	 */
-	if (hw_breakpoint_active())
-		hw_breakpoint_restore();
-}
-
 #endif /* _ASM_X86_MMU_CONTEXT_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -783,6 +783,61 @@ void __init_or_module text_poke_early(vo
 	}
 }
 
+typedef struct {
+	struct mm_struct *mm;
+} temp_mm_state_t;
+
+/*
+ * Using a temporary mm allows to set temporary mappings that are not accessible
+ * by other CPUs. Such mappings are needed to perform sensitive memory writes
+ * that override the kernel memory protections (e.g., W^X), without exposing the
+ * temporary page-table mappings that are required for these write operations to
+ * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
+ * mapping is torn down.
+ *
+ * Context: The temporary mm needs to be used exclusively by a single core. To
+ *          harden security IRQs must be disabled while the temporary mm is
+ *          loaded, thereby preventing interrupt handler bugs from overriding
+ *          the kernel memory protection.
+ */
+static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
+{
+	temp_mm_state_t temp_state;
+
+	lockdep_assert_irqs_disabled();
+	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	switch_mm_irqs_off(NULL, mm, current);
+
+	/*
+	 * If breakpoints are enabled, disable them while the temporary mm is
+	 * used. Userspace might set up watchpoints on addresses that are used
+	 * in the temporary mm, which would lead to wrong signals being sent or
+	 * crashes.
+	 *
+	 * Note that breakpoints are not disabled selectively, which also causes
+	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
+	 * undesirable, but still seems reasonable as the code that runs in the
+	 * temporary mm should be short.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_disable();
+
+	return temp_state;
+}
+
+static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
+{
+	lockdep_assert_irqs_disabled();
+	switch_mm_irqs_off(NULL, prev_state.mm, current);
+
+	/*
+	 * Restore the breakpoints if they were disabled before the temporary mm
+	 * was loaded.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_restore();
+}
+
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 


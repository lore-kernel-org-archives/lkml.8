Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE8AC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9D420A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgDZSnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726312AbgDZSnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:43:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E57C061A0F;
        Sun, 26 Apr 2020 11:43:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEz-0007Dc-3K; Sun, 26 Apr 2020 20:42:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A9D4B1C0334;
        Sun, 26 Apr 2020 20:42:53 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:53 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/alternatives: Move temporary_mm helpers into C
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.139069561@linutronix.de>
References: <20200421092559.139069561@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657329.28353.15454847420595201595.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     9020d3956317d052cdddd43e55acdd2970344192
Gitweb:        https://git.kernel.org/tip/9020d3956317d052cdddd43e55acdd2970344192
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 24 Apr 2020 19:12:56 +02:00

x86/alternatives: Move temporary_mm helpers into C

The only user of these inlines is the text poke code and this must not be
exposed to the world.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092559.139069561@linutronix.de
---
 arch/x86/include/asm/mmu_context.h | 55 +-----------------------------
 arch/x86/kernel/alternative.c      | 55 +++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 2985d06..4756214 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -215,59 +215,4 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7867dfb..cd61797 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -783,6 +783,61 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
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
 

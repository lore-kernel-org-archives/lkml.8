Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B478C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555322087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgDUJ1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728617AbgDUJ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:27:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA017C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:27:17 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQpBK-00084a-Mf; Tue, 21 Apr 2020 11:27:06 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B26221002EE;
        Tue, 21 Apr 2020 11:27:05 +0200 (CEST)
Message-Id: <20200421092600.052543007@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 21 Apr 2020 11:20:40 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch V2 13/16] x86/tlb: Uninline nmi_uaccess_okay()
References: <20200421092027.591582014@linutronix.de>
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

cpu_tlbstate is exported because various TLB related functions need access
to it, but cpu_tlbstate is sensitive information which should only be
accessed by well contained kernel functions and not be directly exposed to
modules.

nmi_access_ok() is the last inline function which requires access to
cpu_tlbstate. Move it into the TLB code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/tlbflush.h |   33 +--------------------------------
 arch/x86/mm/tlb.c               |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 32 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -247,38 +247,7 @@ struct tlb_state {
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
 
-/*
- * Blindly accessing user memory from NMI context can be dangerous
- * if we're in the middle of switching the current user task or
- * switching the loaded mm.  It can also be dangerous if we
- * interrupted some kernel code that was temporarily using a
- * different mm.
- */
-static inline bool nmi_uaccess_okay(void)
-{
-	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	struct mm_struct *current_mm = current->mm;
-
-	VM_WARN_ON_ONCE(!loaded_mm);
-
-	/*
-	 * The condition we want to check is
-	 * current_mm->pgd == __va(read_cr3_pa()).  This may be slow, though,
-	 * if we're running in a VM with shadow paging, and nmi_uaccess_okay()
-	 * is supposed to be reasonably fast.
-	 *
-	 * Instead, we check the almost equivalent but somewhat conservative
-	 * condition below, and we rely on the fact that switch_mm_irqs_off()
-	 * sets loaded_mm to LOADED_MM_SWITCHING before writing to CR3.
-	 */
-	if (loaded_mm != current_mm)
-		return false;
-
-	VM_WARN_ON_ONCE(current_mm->pgd != __va(read_cr3_pa()));
-
-	return true;
-}
-
+bool nmi_uaccess_okay(void);
 #define nmi_uaccess_okay nmi_uaccess_okay
 
 void cr4_update_irqsoff(unsigned long set, unsigned long clear);
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1079,6 +1079,38 @@ void arch_tlbbatch_flush(struct arch_tlb
 	put_cpu();
 }
 
+/*
+ * Blindly accessing user memory from NMI context can be dangerous
+ * if we're in the middle of switching the current user task or
+ * switching the loaded mm.  It can also be dangerous if we
+ * interrupted some kernel code that was temporarily using a
+ * different mm.
+ */
+bool nmi_uaccess_okay(void)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	struct mm_struct *current_mm = current->mm;
+
+	VM_WARN_ON_ONCE(!loaded_mm);
+
+	/*
+	 * The condition we want to check is
+	 * current_mm->pgd == __va(read_cr3_pa()).  This may be slow, though,
+	 * if we're running in a VM with shadow paging, and nmi_uaccess_okay()
+	 * is supposed to be reasonably fast.
+	 *
+	 * Instead, we check the almost equivalent but somewhat conservative
+	 * condition below, and we rely on the fact that switch_mm_irqs_off()
+	 * sets loaded_mm to LOADED_MM_SWITCHING before writing to CR3.
+	 */
+	if (loaded_mm != current_mm)
+		return false;
+
+	VM_WARN_ON_ONCE(current_mm->pgd != __va(read_cr3_pa()));
+
+	return true;
+}
+
 static ssize_t tlbflush_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {


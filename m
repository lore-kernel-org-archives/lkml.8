Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F6CC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FED21775
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDZSnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbgDZSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F70C061A0F;
        Sun, 26 Apr 2020 11:42:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEr-0007A3-B4; Sun, 26 Apr 2020 20:42:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D85461C0178;
        Sun, 26 Apr 2020 20:42:48 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:48 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Uninline nmi_uaccess_okay()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092600.052543007@linutronix.de>
References: <20200421092600.052543007@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792656847.28353.4934739152990460407.tip-bot2@tip-bot2>
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

Commit-ID:     af5c40c6ee057c5354930abdc4d34be013d0e9e0
Gitweb:        https://git.kernel.org/tip/af5c40c6ee057c5354930abdc4d34be013d0e9e0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 18:47:05 +02:00

x86/tlb: Uninline nmi_uaccess_okay()

cpu_tlbstate is exported because various TLB-related functions need
access to it, but cpu_tlbstate is sensitive information which should
only be accessed by well-contained kernel functions and not be directly
exposed to modules.

nmi_access_ok() is the last inline function which requires access to
cpu_tlbstate. Move it into the TLB code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092600.052543007@linutronix.de
---
 arch/x86/include/asm/tlbflush.h | 33 +--------------------------------
 arch/x86/mm/tlb.c               | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 917deea..1c17f5a 100644
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
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index aabf8c7..45426ae 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1094,6 +1094,38 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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

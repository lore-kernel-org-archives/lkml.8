Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E1C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73805214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDZSnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726397AbgDZSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3F9C061A0F;
        Sun, 26 Apr 2020 11:42:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEv-0007DZ-Ki; Sun, 26 Apr 2020 20:42:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 35A961C0178;
        Sun, 26 Apr 2020 20:42:53 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:52 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Move __flush_tlb() out of line
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.246130908@linutronix.de>
References: <20200421092559.246130908@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657273.28353.17129461908915152457.tip-bot2@tip-bot2>
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

Commit-ID:     2faf153bb7346b7dfc895f916edf93a86297ec0a
Gitweb:        https://git.kernel.org/tip/2faf153bb7346b7dfc895f916edf93a86297ec0a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 11:00:05 +02:00

x86/tlb: Move __flush_tlb() out of line

cpu_tlbstate is exported because various TLB-related functions need
access to it, but cpu_tlbstate is sensitive information which should
only be accessed by well-contained kernel functions and not be directly
exposed to modules.

As a first step, move __flush_tlb() out of line and hide the native
function. The latter can be static when CONFIG_PARAVIRT is disabled.

Consolidate the namespace while at it and remove the pointless extra
wrapper in the paravirt code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092559.246130908@linutronix.de
---
 arch/x86/include/asm/paravirt.h    |  4 +++-
 arch/x86/include/asm/tlbflush.h    | 29 ++++---------------------
 arch/x86/kernel/cpu/mtrr/generic.c |  4 ++--
 arch/x86/kernel/paravirt.c         |  7 +------
 arch/x86/mm/mem_encrypt.c          |  2 +-
 arch/x86/mm/tlb.c                  | 33 ++++++++++++++++++++++++++++-
 arch/x86/platform/uv/tlb_uv.c      |  2 +-
 7 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 694d8da..f412450 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -47,7 +47,9 @@ static inline void slow_down_io(void)
 #endif
 }
 
-static inline void __flush_tlb(void)
+void native_flush_tlb_local(void);
+
+static inline void __flush_tlb_local(void)
 {
 	PVOP_VCALL0(mmu.flush_tlb_user);
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d804030..fe1fd02 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -140,12 +140,13 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
 }
 
+void flush_tlb_local(void);
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
-#define __flush_tlb() __native_flush_tlb()
-#define __flush_tlb_global() __native_flush_tlb_global()
-#define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
+#define __flush_tlb_global()		__native_flush_tlb_global()
+#define __flush_tlb_one_user(addr)	__native_flush_tlb_one_user(addr)
 #endif
 
 struct tlb_context {
@@ -371,24 +372,6 @@ static inline void invalidate_user_asid(u16 asid)
 }
 
 /*
- * flush the entire current user mapping
- */
-static inline void __native_flush_tlb(void)
-{
-	/*
-	 * Preemption or interrupts must be disabled to protect the access
-	 * to the per CPU variable and to prevent being preempted between
-	 * read_cr3() and write_cr3().
-	 */
-	WARN_ON_ONCE(preemptible());
-
-	invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
-
-	/* If current->mm == NULL then the read_cr3() "borrows" an mm */
-	native_write_cr3(__native_read_cr3());
-}
-
-/*
  * flush everything
  */
 static inline void __native_flush_tlb_global(void)
@@ -461,7 +444,7 @@ static inline void __flush_tlb_all(void)
 		/*
 		 * !PGE -> !PCID (setup_pcid()), thus every flush is total.
 		 */
-		__flush_tlb();
+		flush_tlb_local();
 	}
 }
 
@@ -537,8 +520,6 @@ struct flush_tlb_info {
 	bool			freed_tables;
 };
 
-#define local_flush_tlb() __flush_tlb()
-
 #define flush_tlb_mm(mm)						\
 		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 51b9190..23ad8e9 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -761,7 +761,7 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 
 	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-	__flush_tlb();
+	flush_tlb_local();
 
 	/* Save MTRR state */
 	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
@@ -778,7 +778,7 @@ static void post_set(void) __releases(set_atomicity_lock)
 {
 	/* Flush TLBs (no need to flush caches - they are disabled) */
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-	__flush_tlb();
+	flush_tlb_local();
 
 	/* Intel (P6) standard MTRRs */
 	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c131ba4..4cb3d82 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -160,11 +160,6 @@ unsigned paravirt_patch_insns(void *insn_buff, unsigned len,
 	return insn_len;
 }
 
-static void native_flush_tlb(void)
-{
-	__native_flush_tlb();
-}
-
 /*
  * Global pages have to be flushed a bit differently. Not a real
  * performance problem because this does not happen often.
@@ -359,7 +354,7 @@ struct paravirt_patch_template pv_ops = {
 #endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
-	.mmu.flush_tlb_user	= native_flush_tlb,
+	.mmu.flush_tlb_user	= native_flush_tlb_local,
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_others	= native_flush_tlb_others,
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index a03614b..4a781cf 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -134,7 +134,7 @@ static void __init __sme_early_map_unmap_mem(void *vaddr, unsigned long size,
 		size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
 	} while (size);
 
-	__native_flush_tlb();
+	flush_tlb_local();
 }
 
 void __init sme_unmap_bootdata(char *real_mode_data)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 3d9d819..0611648 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -18,6 +18,13 @@
 
 #include "mm_internal.h"
 
+#ifdef CONFIG_PARAVIRT
+# define STATIC_NOPV
+#else
+# define STATIC_NOPV			static
+# define __flush_tlb_local		native_flush_tlb_local
+#endif
+
 /*
  *	TLB flushing, formerly SMP-only
  *		c/o Linus Torvalds.
@@ -645,7 +652,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		trace_tlb_flush(reason, nr_invalidate);
 	} else {
 		/* Full flush. */
-		local_flush_tlb();
+		flush_tlb_local();
 		if (local)
 			count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 		trace_tlb_flush(reason, TLB_FLUSH_ALL);
@@ -884,6 +891,30 @@ unsigned long __get_current_cr3_fast(void)
 EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
 
 /*
+ * Flush the entire current user mapping
+ */
+STATIC_NOPV void native_flush_tlb_local(void)
+{
+	/*
+	 * Preemption or interrupts must be disabled to protect the access
+	 * to the per CPU variable and to prevent being preempted between
+	 * read_cr3() and write_cr3().
+	 */
+	WARN_ON_ONCE(preemptible());
+
+	invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+
+	/* If current->mm == NULL then the read_cr3() "borrows" an mm */
+	native_write_cr3(__native_read_cr3());
+}
+
+void flush_tlb_local(void)
+{
+	__flush_tlb_local();
+}
+EXPORT_SYMBOL_GPL(flush_tlb_local);
+
+/*
  * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.
  * This means that the 'struct flush_tlb_info' that describes which mappings to
  * flush is actually fixed. We therefore set a single fixed struct and use it in
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 1fd321f..6af766c 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -293,7 +293,7 @@ static void bau_process_message(struct msg_desc *mdp, struct bau_control *bcp,
 	 * This must be a normal message, or retry of a normal message
 	 */
 	if (msg->address == TLB_FLUSH_ALL) {
-		local_flush_tlb();
+		flush_tlb_local();
 		stat->d_alltlb++;
 	} else {
 		__flush_tlb_one_user(msg->address);

Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E5C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C566221835
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgDZSnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726374AbgDZSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59BC061A0F;
        Sun, 26 Apr 2020 11:42:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEu-0007Cj-II; Sun, 26 Apr 2020 20:42:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2DD2B1C0178;
        Sun, 26 Apr 2020 20:42:52 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:51 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Move __flush_tlb_one_user() out of line
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.428213098@linutronix.de>
References: <20200421092559.428213098@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657178.28353.2940270519615352126.tip-bot2@tip-bot2>
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

Commit-ID:     127ac915c8e1c11b8209393e700ca16be0efabe8
Gitweb:        https://git.kernel.org/tip/127ac915c8e1c11b8209393e700ca16be0efabe8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 11:00:29 +02:00

x86/tlb: Move __flush_tlb_one_user() out of line

cpu_tlbstate is exported because various TLB-related functions need access
to it, but cpu_tlbstate is sensitive information which should only be
accessed by well-contained kernel functions and not be directly exposed to
modules.

As a third step, move _flush_tlb_one_user() out of line and hide the
native function. The latter can be static when CONFIG_PARAVIRT is
disabled.

Consolidate the name space while at it and remove the pointless extra
wrapper in the paravirt code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092559.428213098@linutronix.de
---
 arch/x86/include/asm/paravirt.h |  1 +-
 arch/x86/include/asm/tlbflush.h | 53 +-----------------------------
 arch/x86/kernel/paravirt.c      |  5 +---
 arch/x86/mm/tlb.c               | 56 +++++++++++++++++++++++++++++++-
 arch/x86/platform/uv/tlb_uv.c   |  2 +-
 5 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 712e059..dcd6517 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -49,6 +49,7 @@ static inline void slow_down_io(void)
 
 void native_flush_tlb_local(void);
 void native_flush_tlb_global(void);
+void native_flush_tlb_one_user(unsigned long addr);
 
 static inline void __flush_tlb_local(void)
 {
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d66d16e..14c5b98 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -142,11 +142,10 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 
 void flush_tlb_local(void);
 void flush_tlb_global(void);
+void flush_tlb_one_user(unsigned long addr);
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
-#else
-#define __flush_tlb_one_user(addr)	__native_flush_tlb_one_user(addr)
 #endif
 
 struct tlb_context {
@@ -346,54 +345,6 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
 extern void initialize_tlbstate_and_flush(void);
 
 /*
- * Given an ASID, flush the corresponding user ASID.  We can delay this
- * until the next time we switch to it.
- *
- * See SWITCH_TO_USER_CR3.
- */
-static inline void invalidate_user_asid(u16 asid)
-{
-	/* There is no user ASID if address space separation is off */
-	if (!IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
-		return;
-
-	/*
-	 * We only have a single ASID if PCID is off and the CR3
-	 * write will have flushed it.
-	 */
-	if (!cpu_feature_enabled(X86_FEATURE_PCID))
-		return;
-
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return;
-
-	__set_bit(kern_pcid(asid),
-		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
-}
-
-/*
- * flush one page in the user mapping
- */
-static inline void __native_flush_tlb_one_user(unsigned long addr)
-{
-	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-
-	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
-
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return;
-
-	/*
-	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
-	 * Just use invalidate_user_asid() in case we are called early.
-	 */
-	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE))
-		invalidate_user_asid(loaded_mm_asid);
-	else
-		invpcid_flush_one(user_pcid(loaded_mm_asid), addr);
-}
-
-/*
  * flush everything
  */
 static inline void __flush_tlb_all(void)
@@ -432,7 +383,7 @@ static inline void __flush_tlb_one_kernel(unsigned long addr)
 	 * kernel address space and for its usermode counterpart, but it does
 	 * not flush it for other address spaces.
 	 */
-	__flush_tlb_one_user(addr);
+	flush_tlb_one_user(addr);
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 6094b00..5638e4a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -160,11 +160,6 @@ unsigned paravirt_patch_insns(void *insn_buff, unsigned len,
 	return insn_len;
 }
 
-static void native_flush_tlb_one_user(unsigned long addr)
-{
-	__native_flush_tlb_one_user(addr);
-}
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d548b98..2822602 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -24,6 +24,7 @@
 # define STATIC_NOPV			static
 # define __flush_tlb_local		native_flush_tlb_local
 # define __flush_tlb_global		native_flush_tlb_global
+# define __flush_tlb_one_user(addr)	native_flush_tlb_one_user(addr)
 #endif
 
 /*
@@ -118,6 +119,32 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 	*need_flush = true;
 }
 
+/*
+ * Given an ASID, flush the corresponding user ASID.  We can delay this
+ * until the next time we switch to it.
+ *
+ * See SWITCH_TO_USER_CR3.
+ */
+static inline void invalidate_user_asid(u16 asid)
+{
+	/* There is no user ASID if address space separation is off */
+	if (!IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
+		return;
+
+	/*
+	 * We only have a single ASID if PCID is off and the CR3
+	 * write will have flushed it.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_PCID))
+		return;
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	__set_bit(kern_pcid(asid),
+		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
+}
+
 static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
 {
 	unsigned long new_mm_cr3;
@@ -645,7 +672,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		unsigned long addr = f->start;
 
 		while (addr < f->end) {
-			__flush_tlb_one_user(addr);
+			flush_tlb_one_user(addr);
 			addr += 1UL << f->stride_shift;
 		}
 		if (local)
@@ -892,6 +919,33 @@ unsigned long __get_current_cr3_fast(void)
 EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
 
 /*
+ * Flush one page in the user mapping
+ */
+STATIC_NOPV void native_flush_tlb_one_user(unsigned long addr)
+{
+	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+
+	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	/*
+	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
+	 * Just use invalidate_user_asid() in case we are called early.
+	 */
+	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE))
+		invalidate_user_asid(loaded_mm_asid);
+	else
+		invpcid_flush_one(user_pcid(loaded_mm_asid), addr);
+}
+
+void flush_tlb_one_user(unsigned long addr)
+{
+	__flush_tlb_one_user(addr);
+}
+
+/*
  * Flush everything
  */
 STATIC_NOPV void native_flush_tlb_global(void)
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 6af766c..4ea6969 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -296,7 +296,7 @@ static void bau_process_message(struct msg_desc *mdp, struct bau_control *bcp,
 		flush_tlb_local();
 		stat->d_alltlb++;
 	} else {
-		__flush_tlb_one_user(msg->address);
+		flush_tlb_one_user(msg->address);
 		stat->d_onetlb++;
 	}
 	stat->d_requestee++;

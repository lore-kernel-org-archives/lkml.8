Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F9C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F267C21775
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDZSnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbgDZSnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:43:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CCCC061A0F;
        Sun, 26 Apr 2020 11:43:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEz-0007DA-UV; Sun, 26 Apr 2020 20:42:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A02CA1C0330;
        Sun, 26 Apr 2020 20:42:52 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:52 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Move __flush_tlb_global() out of line
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.336916818@linutronix.de>
References: <20200421092559.336916818@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657226.28353.3842688406760715239.tip-bot2@tip-bot2>
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

Commit-ID:     cd30d26cf307b45159cd629d60b989e582372afe
Gitweb:        https://git.kernel.org/tip/cd30d26cf307b45159cd629d60b989e582372afe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:33 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 11:00:27 +02:00

x86/tlb: Move __flush_tlb_global() out of line

cpu_tlbstate is exported because various TLB-related functions need
access to it, but cpu_tlbstate is sensitive information which should
only be accessed by well-contained kernel functions and not be directly
exposed to modules.

As a second step, move __flush_tlb_global() out of line and hide the
native function. The latter can be static when CONFIG_PARAVIRT is
disabled.

Consolidate the namespace while at it and remove the pointless extra
wrapper in the paravirt code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092559.336916818@linutronix.de
---
 arch/x86/include/asm/paravirt.h |  1 +-
 arch/x86/include/asm/tlbflush.h | 38 +-----------------------------
 arch/x86/kernel/paravirt.c      |  9 +-------
 arch/x86/mm/tlb.c               | 41 ++++++++++++++++++++++++++++++++-
 4 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f412450..712e059 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -48,6 +48,7 @@ static inline void slow_down_io(void)
 }
 
 void native_flush_tlb_local(void);
+void native_flush_tlb_global(void);
 
 static inline void __flush_tlb_local(void)
 {
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index fe1fd02..d66d16e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -141,11 +141,11 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 }
 
 void flush_tlb_local(void);
+void flush_tlb_global(void);
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
-#define __flush_tlb_global()		__native_flush_tlb_global()
 #define __flush_tlb_one_user(addr)	__native_flush_tlb_one_user(addr)
 #endif
 
@@ -372,40 +372,6 @@ static inline void invalidate_user_asid(u16 asid)
 }
 
 /*
- * flush everything
- */
-static inline void __native_flush_tlb_global(void)
-{
-	unsigned long cr4, flags;
-
-	if (static_cpu_has(X86_FEATURE_INVPCID)) {
-		/*
-		 * Using INVPCID is considerably faster than a pair of writes
-		 * to CR4 sandwiched inside an IRQ flag save/restore.
-		 *
-		 * Note, this works with CR4.PCIDE=0 or 1.
-		 */
-		invpcid_flush_all();
-		return;
-	}
-
-	/*
-	 * Read-modify-write to CR4 - protect it from preemption and
-	 * from interrupts. (Use the raw variant because this code can
-	 * be called from deep inside debugging code.)
-	 */
-	raw_local_irq_save(flags);
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	/* toggle PGE */
-	native_write_cr4(cr4 ^ X86_CR4_PGE);
-	/* write old PGE again and flush TLBs */
-	native_write_cr4(cr4);
-
-	raw_local_irq_restore(flags);
-}
-
-/*
  * flush one page in the user mapping
  */
 static inline void __native_flush_tlb_one_user(unsigned long addr)
@@ -439,7 +405,7 @@ static inline void __flush_tlb_all(void)
 	VM_WARN_ON_ONCE(preemptible());
 
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
-		__flush_tlb_global();
+		flush_tlb_global();
 	} else {
 		/*
 		 * !PGE -> !PCID (setup_pcid()), thus every flush is total.
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 4cb3d82..6094b00 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -160,15 +160,6 @@ unsigned paravirt_patch_insns(void *insn_buff, unsigned len,
 	return insn_len;
 }
 
-/*
- * Global pages have to be flushed a bit differently. Not a real
- * performance problem because this does not happen often.
- */
-static void native_flush_tlb_global(void)
-{
-	__native_flush_tlb_global();
-}
-
 static void native_flush_tlb_one_user(unsigned long addr)
 {
 	__native_flush_tlb_one_user(addr);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0611648..d548b98 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -23,6 +23,7 @@
 #else
 # define STATIC_NOPV			static
 # define __flush_tlb_local		native_flush_tlb_local
+# define __flush_tlb_global		native_flush_tlb_global
 #endif
 
 /*
@@ -891,6 +892,46 @@ unsigned long __get_current_cr3_fast(void)
 EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
 
 /*
+ * Flush everything
+ */
+STATIC_NOPV void native_flush_tlb_global(void)
+{
+	unsigned long cr4, flags;
+
+	if (static_cpu_has(X86_FEATURE_INVPCID)) {
+		/*
+		 * Using INVPCID is considerably faster than a pair of writes
+		 * to CR4 sandwiched inside an IRQ flag save/restore.
+		 *
+		 * Note, this works with CR4.PCIDE=0 or 1.
+		 */
+		invpcid_flush_all();
+		return;
+	}
+
+	/*
+	 * Read-modify-write to CR4 - protect it from preemption and
+	 * from interrupts. (Use the raw variant because this code can
+	 * be called from deep inside debugging code.)
+	 */
+	raw_local_irq_save(flags);
+
+	cr4 = this_cpu_read(cpu_tlbstate.cr4);
+	/* toggle PGE */
+	native_write_cr4(cr4 ^ X86_CR4_PGE);
+	/* write old PGE again and flush TLBs */
+	native_write_cr4(cr4);
+
+	raw_local_irq_restore(flags);
+}
+
+void flush_tlb_global(void)
+{
+	__flush_tlb_global();
+}
+EXPORT_SYMBOL_GPL(flush_tlb_global);
+
+/*
  * Flush the entire current user mapping
  */
 STATIC_NOPV void native_flush_tlb_local(void)

Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31098C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3852145D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDSUgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDSUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:36:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439CCC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:36:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQGfg-0007Ks-Rh; Sun, 19 Apr 2020 22:36:09 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 22E1BFFBA2;
        Sun, 19 Apr 2020 22:36:08 +0200 (CEST)
Message-Id: <20200419203336.226245149@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 19 Apr 2020 22:31:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch 06/15] x86/tlb: Move __flush_tlb_global() out of line
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

cpu_tlbstate is exported because various TLB related functions need access
to it, but cpu_tlbstate is sensitive information which should only be
accessed by well contained kernel functions and not be directly exposed to
modules.

The various TLB flush functions need access to cpu_tlbstate. As 2nd step
move __flush_tlb_global() out of line and hide the native function. The
latter can be static when CONFIG_PARAVIRT is disabled.

Consolidate the name space while at it and remove the pointless extra
wrapper in the paravirt code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h |    1 
 arch/x86/include/asm/tlbflush.h |   38 +------------------------------------
 arch/x86/kernel/paravirt.c      |    9 --------
 arch/x86/mm/tlb.c               |   41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 45 deletions(-)
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -48,6 +48,7 @@ static inline void slow_down_io(void)
 }
 
 void native_flush_tlb_local(void);
+void native_flush_tlb_global(void);
 
 static inline void __flush_tlb_local(void)
 {
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -141,11 +141,11 @@ static inline unsigned long build_cr3_no
 }
 
 void flush_tlb_local(void);
+void flush_tlb_global(void);
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
-#define __flush_tlb_global()		__native_flush_tlb_global()
 #define __flush_tlb_one_user(addr)	__native_flush_tlb_one_user(addr)
 #endif
 
@@ -372,40 +372,6 @@ static inline void invalidate_user_asid(
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
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -160,15 +160,6 @@ unsigned paravirt_patch_insns(void *insn
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
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -23,6 +23,7 @@
 #else
 # define STATIC_NOPV			static
 # define __flush_tlb_local		native_flush_tlb_local
+# define __flush_tlb_global		native_flush_tlb_global
 #endif
 
 /*
@@ -891,6 +892,46 @@ unsigned long __get_current_cr3_fast(voi
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


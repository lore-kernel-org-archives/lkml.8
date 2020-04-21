Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A882098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgDUJ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728607AbgDUJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:27:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A323DC061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:27:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQpBG-00082e-IR; Tue, 21 Apr 2020 11:27:02 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 091101002EE;
        Tue, 21 Apr 2020 11:27:02 +0200 (CEST)
Message-Id: <20200421092559.740388137@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 21 Apr 2020 11:20:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch V2 10/16] x86/tlb: Move __flush_tlb_all() out of line
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

Reduces the number of required exports to one and makes flush_tlb_global()
static to the TLB code.

flush_tlb_local() cannot be confined to the tlb code as the mtrr handling
requires a PGE-less flush.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/tlbflush.h |   23 +----------------------
 arch/x86/mm/tlb.c               |   29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 29 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -142,8 +142,8 @@ static inline unsigned long build_cr3_no
 
 struct flush_tlb_info;
 
+void __flush_tlb_all(void);
 void flush_tlb_local(void);
-void flush_tlb_global(void);
 void flush_tlb_one_user(unsigned long addr);
 void flush_tlb_one_kernel(unsigned long addr);
 void flush_tlb_others(const struct cpumask *cpumask,
@@ -341,27 +341,6 @@ static inline void cr4_set_bits_and_upda
 
 extern void initialize_tlbstate_and_flush(void);
 
-/*
- * flush everything
- */
-static inline void __flush_tlb_all(void)
-{
-	/*
-	 * This is to catch users with enabled preemption and the PGE feature
-	 * and don't trigger the warning in __native_flush_tlb().
-	 */
-	VM_WARN_ON_ONCE(preemptible());
-
-	if (boot_cpu_has(X86_FEATURE_PGE)) {
-		flush_tlb_global();
-	} else {
-		/*
-		 * !PGE -> !PCID (setup_pcid()), thus every flush is total.
-		 */
-		flush_tlb_local();
-	}
-}
-
 #define TLB_FLUSH_ALL	-1UL
 
 /*
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1018,12 +1018,6 @@ STATIC_NOPV void native_flush_tlb_global
 	raw_local_irq_restore(flags);
 }
 
-void flush_tlb_global(void)
-{
-	__flush_tlb_global();
-}
-EXPORT_SYMBOL_GPL(flush_tlb_global);
-
 /*
  * Flush the entire current user mapping
  */
@@ -1046,7 +1040,28 @@ void flush_tlb_local(void)
 {
 	__flush_tlb_local();
 }
-EXPORT_SYMBOL_GPL(flush_tlb_local);
+
+/*
+ * Flush everything
+ */
+void __flush_tlb_all(void)
+{
+	/*
+	 * This is to catch users with enabled preemption and the PGE feature
+	 * and don't trigger the warning in __native_flush_tlb().
+	 */
+	VM_WARN_ON_ONCE(preemptible());
+
+	if (boot_cpu_has(X86_FEATURE_PGE)) {
+		__flush_tlb_global();
+	} else {
+		/*
+		 * !PGE -> !PCID (setup_pcid()), thus every flush is total.
+		 */
+		flush_tlb_local();
+	}
+}
+EXPORT_SYMBOL_GPL(__flush_tlb_all);
 
 /*
  * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.


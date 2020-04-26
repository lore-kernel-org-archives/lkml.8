Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C644FC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B84D6216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDZSmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDZSmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09EC061A0F;
        Sun, 26 Apr 2020 11:42:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEs-0007Bc-Tt; Sun, 26 Apr 2020 20:42:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7AC8E1C0178;
        Sun, 26 Apr 2020 20:42:50 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:49 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Move __flush_tlb_all() out of line
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.740388137@linutronix.de>
References: <20200421092559.740388137@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792656994.28353.8288586181751834405.tip-bot2@tip-bot2>
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

Commit-ID:     4b04e6c236744635eb4852bd9690172734fa0a1c
Gitweb:        https://git.kernel.org/tip/4b04e6c236744635eb4852bd9690172734fa0a1c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 18:17:31 +02:00

x86/tlb: Move __flush_tlb_all() out of line

Reduce the number of required exports to one and make flush_tlb_global()
static to the TLB code.

flush_tlb_local() cannot be confined to the TLB code as the MTRR
handling requires a PGE-less flush.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200421092559.740388137@linutronix.de
---
 arch/x86/include/asm/tlbflush.h | 23 +----------------------
 arch/x86/mm/tlb.c               | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d064ae8..7401c6c 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -142,8 +142,8 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 
 struct flush_tlb_info;
 
+void __flush_tlb_all(void);
 void flush_tlb_local(void);
-void flush_tlb_global(void);
 void flush_tlb_one_user(unsigned long addr);
 void flush_tlb_one_kernel(unsigned long addr);
 void flush_tlb_others(const struct cpumask *cpumask,
@@ -341,27 +341,6 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
 
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
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 209799d..aabf8c7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1018,12 +1018,6 @@ STATIC_NOPV void native_flush_tlb_global(void)
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

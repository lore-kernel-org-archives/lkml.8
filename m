Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97550C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742F922247
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgDUJ1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728626AbgDUJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:27:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5BEC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:27:19 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQpBL-000859-Dt; Tue, 21 Apr 2020 11:27:07 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E9C69104099;
        Tue, 21 Apr 2020 11:27:06 +0200 (CEST)
Message-Id: <20200421092600.145772183@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 21 Apr 2020 11:20:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch V2 14/16] x86/tlb: Move PCID helpers where they are used
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

Aside of the fact that they are only used in the TLB code, especially
having the comment close to the actual implementation makes a lot of sense.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/tlbflush.h |  133 +---------------------------------------
 arch/x86/mm/tlb.c               |  120 ++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 127 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -13,133 +13,6 @@
 #include <asm/pti.h>
 #include <asm/processor-flags.h>
 
-/*
- * The x86 feature is called PCID (Process Context IDentifier). It is similar
- * to what is traditionally called ASID on the RISC processors.
- *
- * We don't use the traditional ASID implementation, where each process/mm gets
- * its own ASID and flush/restart when we run out of ASID space.
- *
- * Instead we have a small per-cpu array of ASIDs and cache the last few mm's
- * that came by on this CPU, allowing cheaper switch_mm between processes on
- * this CPU.
- *
- * We end up with different spaces for different things. To avoid confusion we
- * use different names for each of them:
- *
- * ASID  - [0, TLB_NR_DYN_ASIDS-1]
- *         the canonical identifier for an mm
- *
- * kPCID - [1, TLB_NR_DYN_ASIDS]
- *         the value we write into the PCID part of CR3; corresponds to the
- *         ASID+1, because PCID 0 is special.
- *
- * uPCID - [2048 + 1, 2048 + TLB_NR_DYN_ASIDS]
- *         for KPTI each mm has two address spaces and thus needs two
- *         PCID values, but we can still do with a single ASID denomination
- *         for each mm. Corresponds to kPCID + 2048.
- *
- */
-
-/* There are 12 bits of space for ASIDS in CR3 */
-#define CR3_HW_ASID_BITS		12
-
-/*
- * When enabled, PAGE_TABLE_ISOLATION consumes a single bit for
- * user/kernel switches
- */
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-# define PTI_CONSUMED_PCID_BITS	1
-#else
-# define PTI_CONSUMED_PCID_BITS	0
-#endif
-
-#define CR3_AVAIL_PCID_BITS (X86_CR3_PCID_BITS - PTI_CONSUMED_PCID_BITS)
-
-/*
- * ASIDs are zero-based: 0->MAX_AVAIL_ASID are valid.  -1 below to account
- * for them being zero-based.  Another -1 is because PCID 0 is reserved for
- * use by non-PCID-aware users.
- */
-#define MAX_ASID_AVAILABLE ((1 << CR3_AVAIL_PCID_BITS) - 2)
-
-/*
- * 6 because 6 should be plenty and struct tlb_state will fit in two cache
- * lines.
- */
-#define TLB_NR_DYN_ASIDS	6
-
-/*
- * Given @asid, compute kPCID
- */
-static inline u16 kern_pcid(u16 asid)
-{
-	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
-
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	/*
-	 * Make sure that the dynamic ASID space does not confict with the
-	 * bit we are using to switch between user and kernel ASIDs.
-	 */
-	BUILD_BUG_ON(TLB_NR_DYN_ASIDS >= (1 << X86_CR3_PTI_PCID_USER_BIT));
-
-	/*
-	 * The ASID being passed in here should have respected the
-	 * MAX_ASID_AVAILABLE and thus never have the switch bit set.
-	 */
-	VM_WARN_ON_ONCE(asid & (1 << X86_CR3_PTI_PCID_USER_BIT));
-#endif
-	/*
-	 * The dynamically-assigned ASIDs that get passed in are small
-	 * (<TLB_NR_DYN_ASIDS).  They never have the high switch bit set,
-	 * so do not bother to clear it.
-	 *
-	 * If PCID is on, ASID-aware code paths put the ASID+1 into the
-	 * PCID bits.  This serves two purposes.  It prevents a nasty
-	 * situation in which PCID-unaware code saves CR3, loads some other
-	 * value (with PCID == 0), and then restores CR3, thus corrupting
-	 * the TLB for ASID 0 if the saved ASID was nonzero.  It also means
-	 * that any bugs involving loading a PCID-enabled CR3 with
-	 * CR4.PCIDE off will trigger deterministically.
-	 */
-	return asid + 1;
-}
-
-/*
- * Given @asid, compute uPCID
- */
-static inline u16 user_pcid(u16 asid)
-{
-	u16 ret = kern_pcid(asid);
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	ret |= 1 << X86_CR3_PTI_PCID_USER_BIT;
-#endif
-	return ret;
-}
-
-struct pgd_t;
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
-{
-	if (static_cpu_has(X86_FEATURE_PCID)) {
-		return __sme_pa(pgd) | kern_pcid(asid);
-	} else {
-		VM_WARN_ON_ONCE(asid != 0);
-		return __sme_pa(pgd);
-	}
-}
-
-static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
-{
-	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
-	/*
-	 * Use boot_cpu_has() instead of this_cpu_has() as this function
-	 * might be called during early boot. This should work even after
-	 * boot because all CPU's the have same capabilities:
-	 */
-	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
-	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
-}
-
 struct flush_tlb_info;
 
 void __flush_tlb_all(void);
@@ -153,6 +26,12 @@ void flush_tlb_others(const struct cpuma
 #include <asm/paravirt.h>
 #endif
 
+/*
+ * 6 because 6 should be plenty and struct tlb_state will fit in two cache
+ * lines.
+ */
+#define TLB_NR_DYN_ASIDS	6
+
 struct tlb_context {
 	u64 ctx_id;
 	u64 tlb_gen;
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -49,6 +49,126 @@
 #define LAST_USER_MM_IBPB	0x1UL
 
 /*
+ * The x86 feature is called PCID (Process Context IDentifier). It is similar
+ * to what is traditionally called ASID on the RISC processors.
+ *
+ * We don't use the traditional ASID implementation, where each process/mm gets
+ * its own ASID and flush/restart when we run out of ASID space.
+ *
+ * Instead we have a small per-cpu array of ASIDs and cache the last few mm's
+ * that came by on this CPU, allowing cheaper switch_mm between processes on
+ * this CPU.
+ *
+ * We end up with different spaces for different things. To avoid confusion we
+ * use different names for each of them:
+ *
+ * ASID  - [0, TLB_NR_DYN_ASIDS-1]
+ *         the canonical identifier for an mm
+ *
+ * kPCID - [1, TLB_NR_DYN_ASIDS]
+ *         the value we write into the PCID part of CR3; corresponds to the
+ *         ASID+1, because PCID 0 is special.
+ *
+ * uPCID - [2048 + 1, 2048 + TLB_NR_DYN_ASIDS]
+ *         for KPTI each mm has two address spaces and thus needs two
+ *         PCID values, but we can still do with a single ASID denomination
+ *         for each mm. Corresponds to kPCID + 2048.
+ *
+ */
+
+/* There are 12 bits of space for ASIDS in CR3 */
+#define CR3_HW_ASID_BITS		12
+
+/*
+ * When enabled, PAGE_TABLE_ISOLATION consumes a single bit for
+ * user/kernel switches
+ */
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+# define PTI_CONSUMED_PCID_BITS	1
+#else
+# define PTI_CONSUMED_PCID_BITS	0
+#endif
+
+#define CR3_AVAIL_PCID_BITS (X86_CR3_PCID_BITS - PTI_CONSUMED_PCID_BITS)
+
+/*
+ * ASIDs are zero-based: 0->MAX_AVAIL_ASID are valid.  -1 below to account
+ * for them being zero-based.  Another -1 is because PCID 0 is reserved for
+ * use by non-PCID-aware users.
+ */
+#define MAX_ASID_AVAILABLE ((1 << CR3_AVAIL_PCID_BITS) - 2)
+
+/*
+ * Given @asid, compute kPCID
+ */
+static inline u16 kern_pcid(u16 asid)
+{
+	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	/*
+	 * Make sure that the dynamic ASID space does not confict with the
+	 * bit we are using to switch between user and kernel ASIDs.
+	 */
+	BUILD_BUG_ON(TLB_NR_DYN_ASIDS >= (1 << X86_CR3_PTI_PCID_USER_BIT));
+
+	/*
+	 * The ASID being passed in here should have respected the
+	 * MAX_ASID_AVAILABLE and thus never have the switch bit set.
+	 */
+	VM_WARN_ON_ONCE(asid & (1 << X86_CR3_PTI_PCID_USER_BIT));
+#endif
+	/*
+	 * The dynamically-assigned ASIDs that get passed in are small
+	 * (<TLB_NR_DYN_ASIDS).  They never have the high switch bit set,
+	 * so do not bother to clear it.
+	 *
+	 * If PCID is on, ASID-aware code paths put the ASID+1 into the
+	 * PCID bits.  This serves two purposes.  It prevents a nasty
+	 * situation in which PCID-unaware code saves CR3, loads some other
+	 * value (with PCID == 0), and then restores CR3, thus corrupting
+	 * the TLB for ASID 0 if the saved ASID was nonzero.  It also means
+	 * that any bugs involving loading a PCID-enabled CR3 with
+	 * CR4.PCIDE off will trigger deterministically.
+	 */
+	return asid + 1;
+}
+
+/*
+ * Given @asid, compute uPCID
+ */
+static inline u16 user_pcid(u16 asid)
+{
+	u16 ret = kern_pcid(asid);
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	ret |= 1 << X86_CR3_PTI_PCID_USER_BIT;
+#endif
+	return ret;
+}
+
+static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
+{
+	if (static_cpu_has(X86_FEATURE_PCID)) {
+		return __sme_pa(pgd) | kern_pcid(asid);
+	} else {
+		VM_WARN_ON_ONCE(asid != 0);
+		return __sme_pa(pgd);
+	}
+}
+
+static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
+{
+	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
+	/*
+	 * Use boot_cpu_has() instead of this_cpu_has() as this function
+	 * might be called during early boot. This should work even after
+	 * boot because all CPU's the have same capabilities:
+	 */
+	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
+	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
+}
+
+/*
  * We get here when we do something requiring a TLB invalidation
  * but could not go invalidate all of the contexts.  We do the
  * necessary invalidation by clearing out the 'ctx_id' which


Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FBFC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DF12053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3fCpAH8a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31mXZuxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgHOWDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgHOVvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D2EC09B04C;
        Sat, 15 Aug 2020 08:47:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:46:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597506411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvXsFKLYgG9imtnvQkz/GI8BrWBV6j9tKKoEh7WUZi8=;
        b=3fCpAH8aOpeyZ6g5tLVl+0CF+ZWK4dgcai6C3dUgOMAGR93MAaZutDwT5e5PbZkg17+bga
        NO/c460egX7I40+HH3qzaJtWHk24Y/7qfjKu/wqjrw42yDtrxErETIOyMIOsvDG942+3RX
        +x8N2ODSD/tfpPU4wMGJ3L1BKGSlTzCZqwU7h3kloWPij5vkbYZVFnm3i4QItcD/9iqL6Y
        vA1iu/NBnHDwme2RkfGvrNTE2sBwh2fHoHEoLigTjN+jaLIpLcpy0szilKJHUrl/4HC5b8
        Qs13VQpoT8K0wd3+C0leRpmhGOyE0uORi+Jmyxz+U7cwWx08NAD17WuKsiBWrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597506411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvXsFKLYgG9imtnvQkz/GI8BrWBV6j9tKKoEh7WUZi8=;
        b=31mXZuxZXQDFE6MgKHpLllUTXBgBBI8flbw/drdHe/egma1mS8y40jS3O9aLCfWr561lVB
        r64rdccOFyBNLtDw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Remove set_pte_at() pv-op
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200815100641.26362-6-jgross@suse.com>
References: <20200815100641.26362-6-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <159750641040.3192.3040793846858713127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     e1ac3e66d301e57472f31ebee81b916e9fa8b35b
Gitweb:        https://git.kernel.org/tip/e1ac3e66d301e57472f31ebee81b916e9fa8b35b
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Sat, 15 Aug 2020 12:06:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Aug 2020 13:52:12 +02:00

x86/paravirt: Remove set_pte_at() pv-op

On x86 set_pte_at() is now always falling back to set_pte(). So instead
of having this fallback after the paravirt maze just drop the
set_pte_at paravirt operation and let set_pte_at() use the set_pte()
function directly.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200815100641.26362-6-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h       |  8 +-------
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/include/asm/pgtable.h        |  7 +++----
 arch/x86/kernel/paravirt.c            |  1 -
 arch/x86/xen/mmu_pv.c                 |  8 --------
 include/trace/events/xen.h            | 20 --------------------
 6 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index e02c409..f0464b8 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -412,12 +412,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	PVOP_VCALL2(mmu.set_pte, ptep, pte.pte);
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-	PVOP_VCALL4(mmu.set_pte_at, mm, addr, ptep, pte.pte);
-}
-
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	PVOP_VCALL2(mmu.set_pmd, pmdp, native_pmd_val(pmd));
@@ -510,7 +504,7 @@ static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep)
 {
-	set_pte_at(mm, addr, ptep, __pte(0));
+	set_pte(ptep, __pte(0));
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f27c3fe..0fad9f6 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -242,8 +242,6 @@ struct pv_mmu_ops {
 
 	/* Pagetable manipulation functions */
 	void (*set_pte)(pte_t *ptep, pte_t pteval);
-	void (*set_pte_at)(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, pte_t pteval);
 	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
 
 	pte_t (*ptep_modify_prot_start)(struct vm_area_struct *vma, unsigned long addr,
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b836138..5e0dcc2 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -63,7 +63,6 @@ extern pmdval_t early_pmd_flags;
 #include <asm/paravirt.h>
 #else  /* !CONFIG_PARAVIRT_XXL */
 #define set_pte(ptep, pte)		native_set_pte(ptep, pte)
-#define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)
 
 #define set_pte_atomic(ptep, pte)					\
 	native_set_pte_atomic(ptep, pte)
@@ -1033,10 +1032,10 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 	return res;
 }
 
-static inline void native_set_pte_at(struct mm_struct *mm, unsigned long addr,
-				     pte_t *ptep , pte_t pte)
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte)
 {
-	native_set_pte(ptep, pte);
+	set_pte(ptep, pte);
 }
 
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e56a144..6c3407b 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -360,7 +360,6 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.release_p4d	= paravirt_nop,
 
 	.mmu.set_pte		= native_set_pte,
-	.mmu.set_pte_at		= native_set_pte_at,
 	.mmu.set_pmd		= native_set_pmd,
 
 	.mmu.ptep_modify_prot_start	= __ptep_modify_prot_start,
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 3273c98..eda7814 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -285,13 +285,6 @@ static void xen_set_pte(pte_t *ptep, pte_t pteval)
 	__xen_set_pte(ptep, pteval);
 }
 
-static void xen_set_pte_at(struct mm_struct *mm, unsigned long addr,
-		    pte_t *ptep, pte_t pteval)
-{
-	trace_xen_mmu_set_pte_at(mm, addr, ptep, pteval);
-	__xen_set_pte(ptep, pteval);
-}
-
 pte_t xen_ptep_modify_prot_start(struct vm_area_struct *vma,
 				 unsigned long addr, pte_t *ptep)
 {
@@ -2105,7 +2098,6 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.release_pmd = xen_release_pmd_init,
 
 	.set_pte = xen_set_pte_init,
-	.set_pte_at = xen_set_pte_at,
 	.set_pmd = xen_set_pmd_hyper,
 
 	.ptep_modify_prot_start = __ptep_modify_prot_start,
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index a5ccfa6..3b61b58 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -153,26 +153,6 @@ DECLARE_EVENT_CLASS(xen_mmu__set_pte,
 
 DEFINE_XEN_MMU_SET_PTE(xen_mmu_set_pte);
 
-TRACE_EVENT(xen_mmu_set_pte_at,
-	    TP_PROTO(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pteval),
-	    TP_ARGS(mm, addr, ptep, pteval),
-	    TP_STRUCT__entry(
-		    __field(struct mm_struct *, mm)
-		    __field(unsigned long, addr)
-		    __field(pte_t *, ptep)
-		    __field(pteval_t, pteval)
-		    ),
-	    TP_fast_assign(__entry->mm = mm;
-			   __entry->addr = addr;
-			   __entry->ptep = ptep;
-			   __entry->pteval = pteval.pte),
-	    TP_printk("mm %p addr %lx ptep %p pteval %0*llx (raw %0*llx)",
-		      __entry->mm, __entry->addr, __entry->ptep,
-		      (int)sizeof(pteval_t) * 2, (unsigned long long)pte_val(native_make_pte(__entry->pteval)),
-		      (int)sizeof(pteval_t) * 2, (unsigned long long)__entry->pteval)
-	);
-
 TRACE_DEFINE_SIZEOF(pmdval_t);
 
 TRACE_EVENT(xen_mmu_set_pmd,

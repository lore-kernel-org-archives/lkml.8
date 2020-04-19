Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A91C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F2D21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDSUgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgDSUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:36:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC459C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:36:11 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQGfa-0007IZ-F7; Sun, 19 Apr 2020 22:36:02 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 00CFA100EA1;
        Sun, 19 Apr 2020 22:36:02 +0200 (CEST)
Message-Id: <20200419203335.748016385@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 19 Apr 2020 22:31:38 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch 01/15] x86/tlb: Uninline __get_current_cr3_fast()
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

In preparation of unexporting cpu_tlbstate move __get_current_cr3_fast()
into the x86 TLB management code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mmu_context.h |   19 +------------------
 arch/x86/mm/tlb.c                  |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -225,24 +225,7 @@ static inline bool arch_vma_access_permi
 	return __pkru_allows_pkey(vma_pkey(vma), write);
 }
 
-/*
- * This can be used from process context to figure out what the value of
- * CR3 is without needing to do a (slow) __read_cr3().
- *
- * It's intended to be used for code like KVM that sneakily changes CR3
- * and needs to restore it.  It needs to be used very carefully.
- */
-static inline unsigned long __get_current_cr3_fast(void)
-{
-	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
-		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
-
-	/* For now, be very restrictive about when this can be called. */
-	VM_WARN_ON(in_nmi() || preemptible());
-
-	VM_BUG_ON(cr3 != __read_cr3());
-	return cr3;
-}
+unsigned long __get_current_cr3_fast(void);
 
 typedef struct {
 	struct mm_struct *mm;
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -844,6 +844,26 @@ void flush_tlb_kernel_range(unsigned lon
 }
 
 /*
+ * This can be used from process context to figure out what the value of
+ * CR3 is without needing to do a (slow) __read_cr3().
+ *
+ * It's intended to be used for code like KVM that sneakily changes CR3
+ * and needs to restore it.  It needs to be used very carefully.
+ */
+unsigned long __get_current_cr3_fast(void)
+{
+	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
+		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+
+	/* For now, be very restrictive about when this can be called. */
+	VM_WARN_ON(in_nmi() || preemptible());
+
+	VM_BUG_ON(cr3 != __read_cr3());
+	return cr3;
+}
+EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
+
+/*
  * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.
  * This means that the 'struct flush_tlb_info' that describes which mappings to
  * flush is actually fixed. We therefore set a single fixed struct and use it in


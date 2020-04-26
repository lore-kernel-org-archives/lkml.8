Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED9BC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92BA21775
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDZSnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgDZSnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:43:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D6C061A41;
        Sun, 26 Apr 2020 11:43:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEx-0007Eb-I7; Sun, 26 Apr 2020 20:42:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 33C051C0178;
        Sun, 26 Apr 2020 20:42:55 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:54 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Uninline __get_current_cr3_fast()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092558.848064318@linutronix.de>
References: <20200421092558.848064318@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657479.28353.17566281114631962456.tip-bot2@tip-bot2>
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

Commit-ID:     8c5cc19e94703182647dfccc164e4437a04539c8
Gitweb:        https://git.kernel.org/tip/8c5cc19e94703182647dfccc164e4437a04539c8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 24 Apr 2020 15:55:50 +02:00

x86/tlb: Uninline __get_current_cr3_fast()

cpu_tlbstate is exported because various TLB-related functions need
access to it, but cpu_tlbstate is sensitive information which should
only be accessed by well-contained kernel functions and not be directly
exposed to modules.

In preparation for unexporting cpu_tlbstate move __get_current_cr3_fast()
into the x86 TLB management code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200421092558.848064318@linutronix.de
---
 arch/x86/include/asm/mmu_context.h | 19 +------------------
 arch/x86/mm/tlb.c                  | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 4e55370..9608536 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -225,24 +225,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
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
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 66f96f2..ea6f98a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -844,6 +844,26 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
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

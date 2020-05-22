Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00866207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgEVJdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgEVJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:33:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D90C05BD43;
        Fri, 22 May 2020 02:33:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jc42z-0001Pq-BR; Fri, 22 May 2020 11:32:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C33151C0475;
        Fri, 22 May 2020 11:32:56 +0200 (CEST)
Date:   Fri, 22 May 2020 09:32:56 -0000
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kvm: Refactor L1D flush operations
Cc:     Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200510014803.12190-3-sblbir@amazon.com>
References: <20200510014803.12190-3-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <159013997669.17951.10091686973701417401.tip-bot2@tip-bot2>
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

Commit-ID:     e3efae20ec69e9a8c9db1ad81b37de629219bbc4
Gitweb:        https://git.kernel.org/tip/e3efae20ec69e9a8c9db1ad81b37de629219bbc4
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Sun, 10 May 2020 11:47:59 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 May 2020 18:12:19 +02:00

x86/kvm: Refactor L1D flush operations

Move the L1D flush functions into builtin code so they can be reused for
L1D flush on context switch.

Split them up into:
   - Hardware L1D flush
   - TLB pre-populating of L1D pages for software based flushing
   - Software based L1D flush

Adjust the KVM code accordingly.

[ tglx: Massaged changelog ]

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200510014803.12190-3-sblbir@amazon.com

---
 arch/x86/include/asm/cacheflush.h |  3 ++-
 arch/x86/kernel/l1d_flush.c       | 49 ++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.c            | 29 +-----------------
 3 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index bac56fc..21cc3b2 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -8,7 +8,10 @@
 
 #define L1D_CACHE_ORDER 4
 void clflush_cache_range(void *addr, unsigned int size);
+void l1d_flush_populate_tlb(void *l1d_flush_pages);
 void *l1d_flush_alloc_pages(void);
 void l1d_flush_cleanup_pages(void *l1d_flush_pages);
+void l1d_flush_sw(void *l1d_flush_pages);
+int l1d_flush_hw(void);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
index 4f298b7..32119ee 100644
--- a/arch/x86/kernel/l1d_flush.c
+++ b/arch/x86/kernel/l1d_flush.c
@@ -37,3 +37,52 @@ void l1d_flush_cleanup_pages(void *l1d_flush_pages)
 	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
 }
 EXPORT_SYMBOL_GPL(l1d_flush_cleanup_pages);
+
+void l1d_flush_populate_tlb(void *l1d_flush_pages)
+{
+	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+
+	asm volatile(
+		/* First ensure the pages are in the TLB */
+		"xorl	%%eax, %%eax\n"
+		".Lpopulate_tlb:\n\t"
+		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
+		"addl	$4096, %%eax\n\t"
+		"cmpl	%%eax, %[size]\n\t"
+		"jne	.Lpopulate_tlb\n\t"
+		"xorl	%%eax, %%eax\n\t"
+		"cpuid\n\t"
+		:: [flush_pages] "r" (l1d_flush_pages),
+		    [size] "r" (size)
+		: "eax", "ebx", "ecx", "edx");
+}
+EXPORT_SYMBOL_GPL(l1d_flush_populate_tlb);
+
+int l1d_flush_hw(void)
+{
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		return 0;
+	}
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(l1d_flush_hw);
+
+void l1d_flush_sw(void *l1d_flush_pages)
+{
+	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+
+	asm volatile(
+			/* Fill the cache */
+			"xorl	%%eax, %%eax\n"
+			".Lfill_cache:\n"
+			"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
+			"addl	$64, %%eax\n\t"
+			"cmpl	%%eax, %[size]\n\t"
+			"jne	.Lfill_cache\n\t"
+			"lfence\n"
+			:: [flush_pages] "r" (l1d_flush_pages),
+			[size] "r" (size)
+			: "eax", "ecx");
+}
+EXPORT_SYMBOL_GPL(l1d_flush_sw);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 225aa82..786d161 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5983,8 +5983,6 @@ unexpected_vmexit:
  */
 static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
-	int size = PAGE_SIZE << L1D_CACHE_ORDER;
-
 	/*
 	 * This code is only executed when the the flush mode is 'cond' or
 	 * 'always'
@@ -6013,32 +6011,11 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.l1d_flush++;
 
-	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+	if (!l1d_flush_hw())
 		return;
-	}
 
-	asm volatile(
-		/* First ensure the pages are in the TLB */
-		"xorl	%%eax, %%eax\n"
-		".Lpopulate_tlb:\n\t"
-		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
-		"addl	$4096, %%eax\n\t"
-		"cmpl	%%eax, %[size]\n\t"
-		"jne	.Lpopulate_tlb\n\t"
-		"xorl	%%eax, %%eax\n\t"
-		"cpuid\n\t"
-		/* Now fill the cache */
-		"xorl	%%eax, %%eax\n"
-		".Lfill_cache:\n"
-		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
-		"addl	$64, %%eax\n\t"
-		"cmpl	%%eax, %[size]\n\t"
-		"jne	.Lfill_cache\n\t"
-		"lfence\n"
-		:: [flush_pages] "r" (vmx_l1d_flush_pages),
-		    [size] "r" (size)
-		: "eax", "ebx", "ecx", "edx");
+	l1d_flush_populate_tlb(vmx_l1d_flush_pages);
+	l1d_flush_sw(vmx_l1d_flush_pages);
 }
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)

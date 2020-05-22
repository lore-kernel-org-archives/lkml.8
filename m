Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA7CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D802D206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgEVJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbgEVJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:33:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10DBC061A0E;
        Fri, 22 May 2020 02:32:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jc42y-0001P7-8e; Fri, 22 May 2020 11:32:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E7CF81C0475;
        Fri, 22 May 2020 11:32:55 +0200 (CEST)
Date:   Fri, 22 May 2020 09:32:55 -0000
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kvm: Refactor L1D flushing
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200510014803.12190-5-sblbir@amazon.com>
References: <20200510014803.12190-5-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <159013997582.17951.6885445528498270174.tip-bot2@tip-bot2>
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

Commit-ID:     3f768f0032dbc0657ed7e48f4735a3c4e49e25d7
Gitweb:        https://git.kernel.org/tip/3f768f0032dbc0657ed7e48f4735a3c4e49e25d7
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Sun, 10 May 2020 11:48:01 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 May 2020 18:12:20 +02:00

x86/kvm: Refactor L1D flushing

Move more L1D flush related code out of KVM/VMX into builtin code to allow
reuse for L1D flushing:

 - Move the initialization to l1d_flush_init_once() and remove the
   deallocation of the L1D flush pages.

   This avoids adding complex refcounting of users (VMX or tasks which
   opt into a L1D flush on context switch) for the price of a few pages
   potentially wasted when no users are left.

 - Unify the flush invocations as arch_l1d_flush() which attempts
   hardware flushing and falls back to the software implementation
   with the option of prepopulating the TLB entries first.

[ tglx: Massage changelog and add a paranoid check of the flush pages
  	pointer ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200510014803.12190-5-sblbir@amazon.com

---
 arch/x86/include/asm/cacheflush.h | 12 ++---
 arch/x86/kernel/l1d_flush.c       | 68 ++++++++++++++++++++++--------
 arch/x86/kvm/vmx/vmx.c            | 20 +--------
 3 files changed, 60 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index 21cc3b2..851d8f1 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -7,11 +7,13 @@
 #include <asm/special_insns.h>
 
 #define L1D_CACHE_ORDER 4
+
+enum l1d_flush_options {
+	L1D_FLUSH_POPULATE_TLB = 0x1,
+};
+
 void clflush_cache_range(void *addr, unsigned int size);
-void l1d_flush_populate_tlb(void *l1d_flush_pages);
-void *l1d_flush_alloc_pages(void);
-void l1d_flush_cleanup_pages(void *l1d_flush_pages);
-void l1d_flush_sw(void *l1d_flush_pages);
-int l1d_flush_hw(void);
+int l1d_flush_init_once(void);
+void arch_l1d_flush(enum l1d_flush_options options);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
index 32119ee..4662f90 100644
--- a/arch/x86/kernel/l1d_flush.c
+++ b/arch/x86/kernel/l1d_flush.c
@@ -4,10 +4,10 @@
 
 #include <asm/cacheflush.h>
 
-void *l1d_flush_alloc_pages(void)
+static void *l1d_flush_alloc_pages(void)
 {
 	struct page *page;
-	void *l1d_flush_pages = NULL;
+	void *flush_pages = NULL;
 	int i;
 
 	/*
@@ -17,7 +17,7 @@ void *l1d_flush_alloc_pages(void)
 	page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
 	if (!page)
 		return NULL;
-	l1d_flush_pages = page_address(page);
+	flush_pages = page_address(page);
 
 	/*
 	 * Initialize each page with a different pattern in
@@ -25,20 +25,13 @@ void *l1d_flush_alloc_pages(void)
 	 * virtualization case.
 	 */
 	for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
-		memset(l1d_flush_pages + i * PAGE_SIZE, i + 1,
+		memset(flush_pages + i * PAGE_SIZE, i + 1,
 				PAGE_SIZE);
 	}
-	return l1d_flush_pages;
+	return flush_pages;
 }
-EXPORT_SYMBOL_GPL(l1d_flush_alloc_pages);
 
-void l1d_flush_cleanup_pages(void *l1d_flush_pages)
-{
-	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
-}
-EXPORT_SYMBOL_GPL(l1d_flush_cleanup_pages);
-
-void l1d_flush_populate_tlb(void *l1d_flush_pages)
+static void l1d_flush_populate_tlb(void *l1d_flush_pages)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
@@ -56,9 +49,8 @@ void l1d_flush_populate_tlb(void *l1d_flush_pages)
 		    [size] "r" (size)
 		: "eax", "ebx", "ecx", "edx");
 }
-EXPORT_SYMBOL_GPL(l1d_flush_populate_tlb);
 
-int l1d_flush_hw(void)
+static int l1d_flush_hw(void)
 {
 	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
 		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
@@ -66,9 +58,8 @@ int l1d_flush_hw(void)
 	}
 	return -ENOTSUPP;
 }
-EXPORT_SYMBOL_GPL(l1d_flush_hw);
 
-void l1d_flush_sw(void *l1d_flush_pages)
+static void l1d_flush_sw(void *l1d_flush_pages)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
@@ -85,4 +76,45 @@ void l1d_flush_sw(void *l1d_flush_pages)
 			[size] "r" (size)
 			: "eax", "ecx");
 }
-EXPORT_SYMBOL_GPL(l1d_flush_sw);
+
+static void *l1d_flush_pages;
+static DEFINE_MUTEX(l1d_flush_mutex);
+
+/*
+ * Initialize and setup L1D flush once, each caller will reuse the
+ * l1d_flush_pages for flushing, no per CPU allocations or NUMA aware
+ * allocations at the moment.
+ */
+int l1d_flush_init_once(void)
+{
+	int ret = 0;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return -ENOTSUPP;
+
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D) || l1d_flush_pages)
+		return ret;
+
+	mutex_lock(&l1d_flush_mutex);
+	if (!l1d_flush_pages)
+		l1d_flush_pages = l1d_flush_alloc_pages();
+	ret = l1d_flush_pages ? 0 : -ENOMEM;
+	mutex_unlock(&l1d_flush_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(l1d_flush_init_once);
+
+void arch_l1d_flush(enum l1d_flush_options options)
+{
+	if (!l1d_flush_hw())
+		return;
+
+	if (WARN_ON_ONCE(!l1d_flush_pages))
+		return;
+
+	if (options & L1D_FLUSH_POPULATE_TLB)
+		l1d_flush_populate_tlb(l1d_flush_pages);
+
+	l1d_flush_sw(l1d_flush_pages);
+}
+EXPORT_SYMBOL_GPL(arch_l1d_flush);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 786d161..d489234 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -203,8 +203,6 @@ static const struct {
 	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required", false},
 };
 
-static void *vmx_l1d_flush_pages;
-
 static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
@@ -247,12 +245,9 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 		l1tf = VMENTER_L1D_FLUSH_ALWAYS;
 	}
 
-	if (l1tf != VMENTER_L1D_FLUSH_NEVER && !vmx_l1d_flush_pages &&
-	    !boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		vmx_l1d_flush_pages = l1d_flush_alloc_pages();
-		if (!vmx_l1d_flush_pages)
+	if (l1tf != VMENTER_L1D_FLUSH_NEVER)
+		if (l1d_flush_init_once())
 			return -ENOMEM;
-	}
 
 	l1tf_vmx_mitigation = l1tf;
 
@@ -6010,12 +6005,7 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 	}
 
 	vcpu->stat.l1d_flush++;
-
-	if (!l1d_flush_hw())
-		return;
-
-	l1d_flush_populate_tlb(vmx_l1d_flush_pages);
-	l1d_flush_sw(vmx_l1d_flush_pages);
+	arch_l1d_flush(L1D_FLUSH_POPULATE_TLB);
 }
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
@@ -7983,10 +7973,6 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 
 static void vmx_cleanup_l1d_flush(void)
 {
-	if (vmx_l1d_flush_pages) {
-		l1d_flush_cleanup_pages(vmx_l1d_flush_pages);
-		vmx_l1d_flush_pages = NULL;
-	}
 	/* Restore state so sysfs ignores VMX */
 	l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 }

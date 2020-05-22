Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4F6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D549F206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgEVJdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgEVJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:33:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7AAC08C5C0;
        Fri, 22 May 2020 02:33:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jc42z-0001QC-Iy; Fri, 22 May 2020 11:32:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 46FFA1C0095;
        Fri, 22 May 2020 11:32:57 +0200 (CEST)
Date:   Fri, 22 May 2020 09:32:57 -0000
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kvm: Refactor L1D flush page management
Cc:     Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200510014803.12190-2-sblbir@amazon.com>
References: <20200510014803.12190-2-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <159013997717.17951.6819922422442729397.tip-bot2@tip-bot2>
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

Commit-ID:     b9b3bc1c30be1f056c1c0564bc7268820ea8bf70
Gitweb:        https://git.kernel.org/tip/b9b3bc1c30be1f056c1c0564bc7268820ea8bf70
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Sun, 10 May 2020 11:47:58 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 May 2020 18:12:18 +02:00

x86/kvm: Refactor L1D flush page management

Split out the allocation and free routines and move them into builtin code
so they can be reused for the upcoming paranoid L1D flush on context switch
mitigation.

[ tglx: Add missing SPDX identifier and massage subject and changelog ]

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200510014803.12190-2-sblbir@amazon.com

---
 arch/x86/include/asm/cacheflush.h |  3 ++-
 arch/x86/kernel/Makefile          |  1 +-
 arch/x86/kernel/l1d_flush.c       | 39 ++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.c            | 25 ++-----------------
 4 files changed, 46 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/kernel/l1d_flush.c

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index 63feaf2..bac56fc 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -6,6 +6,9 @@
 #include <asm-generic/cacheflush.h>
 #include <asm/special_insns.h>
 
+#define L1D_CACHE_ORDER 4
 void clflush_cache_range(void *addr, unsigned int size);
+void *l1d_flush_alloc_pages(void);
+void l1d_flush_cleanup_pages(void *l1d_flush_pages);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index ba89cab..c04d218 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -156,3 +156,4 @@ ifeq ($(CONFIG_X86_64),y)
 endif
 
 obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
+obj-y						+= l1d_flush.o
diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
new file mode 100644
index 0000000..4f298b7
--- /dev/null
+++ b/arch/x86/kernel/l1d_flush.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mm.h>
+
+#include <asm/cacheflush.h>
+
+void *l1d_flush_alloc_pages(void)
+{
+	struct page *page;
+	void *l1d_flush_pages = NULL;
+	int i;
+
+	/*
+	 * This allocation for l1d_flush_pages is not tied to a VM/task's
+	 * lifetime and so should not be charged to a memcg.
+	 */
+	page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
+	if (!page)
+		return NULL;
+	l1d_flush_pages = page_address(page);
+
+	/*
+	 * Initialize each page with a different pattern in
+	 * order to protect against KSM in the nested
+	 * virtualization case.
+	 */
+	for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
+		memset(l1d_flush_pages + i * PAGE_SIZE, i + 1,
+				PAGE_SIZE);
+	}
+	return l1d_flush_pages;
+}
+EXPORT_SYMBOL_GPL(l1d_flush_alloc_pages);
+
+void l1d_flush_cleanup_pages(void *l1d_flush_pages)
+{
+	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
+}
+EXPORT_SYMBOL_GPL(l1d_flush_cleanup_pages);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8305097..225aa82 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -203,14 +203,10 @@ static const struct {
 	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required", false},
 };
 
-#define L1D_CACHE_ORDER 4
 static void *vmx_l1d_flush_pages;
 
 static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 {
-	struct page *page;
-	unsigned int i;
-
 	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
 		l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
 		return 0;
@@ -253,24 +249,9 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 
 	if (l1tf != VMENTER_L1D_FLUSH_NEVER && !vmx_l1d_flush_pages &&
 	    !boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		/*
-		 * This allocation for vmx_l1d_flush_pages is not tied to a VM
-		 * lifetime and so should not be charged to a memcg.
-		 */
-		page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
-		if (!page)
+		vmx_l1d_flush_pages = l1d_flush_alloc_pages();
+		if (!vmx_l1d_flush_pages)
 			return -ENOMEM;
-		vmx_l1d_flush_pages = page_address(page);
-
-		/*
-		 * Initialize each page with a different pattern in
-		 * order to protect against KSM in the nested
-		 * virtualization case.
-		 */
-		for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
-			memset(vmx_l1d_flush_pages + i * PAGE_SIZE, i + 1,
-			       PAGE_SIZE);
-		}
 	}
 
 	l1tf_vmx_mitigation = l1tf;
@@ -8026,7 +8007,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 static void vmx_cleanup_l1d_flush(void)
 {
 	if (vmx_l1d_flush_pages) {
-		free_pages((unsigned long)vmx_l1d_flush_pages, L1D_CACHE_ORDER);
+		l1d_flush_cleanup_pages(vmx_l1d_flush_pages);
 		vmx_l1d_flush_pages = NULL;
 	}
 	/* Restore state so sysfs ignores VMX */

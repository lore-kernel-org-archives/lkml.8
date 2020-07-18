Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7135C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEF820734
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595089474;
	bh=km2mzwtZ+FjNhtaMQXEWg0EuxYlrDbyzGAdxsGPwbwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1yZrBrhoKzdNO7Ak3ZgUq3Y3CKnSemhI/D3ZfXBOySckLeoTHnBJftiE0FZM+0CAw
	 kO8curJMQZ3oxpYSkix9Dkrl2t/O99awU6+7qAP8Tos03eLpS2V4O1gye4AhcudkxC
	 ChrXVDCgwimBZBF10qsRpY+6g6D5ZQIhT1QWxCFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGRQYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgGRQYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:24:10 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0150720734;
        Sat, 18 Jul 2020 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595089449;
        bh=km2mzwtZ+FjNhtaMQXEWg0EuxYlrDbyzGAdxsGPwbwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqNDWhd3xFmC2b0tXUdXJ+AsInllep5JA5RNocblgXsd5dYIBfk8+dsh/L9QtLvr6
         PxfXaJqz2AzdvusBty/jfjCgQXcEKmdIAyUNDx2kZTWPlS0ugCCv6BBH8z0iOnvY87
         dDkXVwEogi7zB+ISmYgs1VjILf79dte4Umo1ONJs=
Date:   Sat, 18 Jul 2020 19:23:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 3/7] vmalloc: Add text_alloc() and text_free()
Message-ID: <20200718162359.GA2919062@kernel.org>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
 <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:04:17AM +0300, Jarkko Sakkinen wrote:
> Introduce functions for allocating memory for dynamic trampolines, such
> as kprobes. An arch can promote the availability of these functions with
> CONFIG_ARCH_HAS_TEXT_ALLOC. Provide default/fallback implementation
> wrapping module_alloc() and module_memfree().
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/linux/vmalloc.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 0221f852a7e1..e981436e30b6 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -9,6 +9,7 @@
>  #include <asm/page.h>		/* pgprot_t */
>  #include <linux/rbtree.h>
>  #include <linux/overflow.h>
> +#include <linux/moduleloader.h>
>  
>  #include <asm/vmalloc.h>
>  
> @@ -249,4 +250,26 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  int register_vmap_purge_notifier(struct notifier_block *nb);
>  int unregister_vmap_purge_notifier(struct notifier_block *nb);
>  
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +/*
> + * Allocate memory to be used for dynamic trampoline code.
> + */
> +void *text_alloc(unsigned long size);
> +
> +/*
> + * Free memory returned from text_alloc().
> + */
> +void text_free(void *region);
> +#else
> +static inline void *text_alloc(unsigned long size)
> +{
> +	return module_alloc(size);
> +}
> +
> +static inline void text_free(void *region)
> +{
> +	module_memfree(region);
> +}

Using module_alloc() as the default implementation of generic
text_alloc() does not sound right to me.

I would suggest rename module_alloc() to text_alloc() on x86, as Peter
proposed and then add text_alloc_kprobes() that can be overridden by the
architectures. x86 could use text_alloc(), arm64 vmalloc() with options
of their choice and the fallback would remain module_alloc(). Something
like (untested) patch below:


From 928b6903e76ebf5790fc415f9eed390e400e5bc3 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Sat, 18 Jul 2020 19:13:02 +0300
Subject: [PATCH] kprobes: introduce text_alloc_kprobes() and
 text_free_kprobes()

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/Kconfig                       |  5 ++++-
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/kernel/probes/kprobes.c | 10 ++++++++--
 arch/x86/Kconfig                   |  3 ++-
 arch/x86/kernel/kprobes/core.c     |  9 ++++-----
 include/linux/kprobes.h            | 17 +++++++++++++++--
 kernel/kprobes.c                   |  8 ++++----
 7 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..c0589b3b3225 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -61,7 +61,7 @@ config OPROFILE_NMI_TIMER
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
+	depends on MODULES || HAVE_KPROBES_TEXT_ALLOC
 	depends on HAVE_KPROBES
 	select KALLSYMS
 	help
@@ -186,6 +186,9 @@ config HAVE_IOREMAP_PROT
 config HAVE_KPROBES
 	bool
 
+config HAVE_KPROBES_TEXT_ALLOC
+	bool
+
 config HAVE_KRETPROBES
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..abc0538b13ef 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -177,6 +177,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_KPROBES_TEXT_ALLOC
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 5290f17a4d80..fac8c6020040 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -118,13 +118,19 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
-void *alloc_insn_page(void)
+void *text_alloc_kprobes(unsigned long size)
 {
-	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
+	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
 			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
 			NUMA_NO_NODE, __builtin_return_address(0));
 }
 
+void text_free_kprobes(void *mem)
+{
+	lockdep_assert_irqs_enabled();
+	vfree(mem);
+}
+
 /* arm kprobe: install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 883da0abf779..d08b92f91531 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -190,6 +190,7 @@ config X86
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
+	select HAVE_KPROBES_TEXT_ALLOC
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_KRETPROBES
 	select HAVE_KVM
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index ada39ddbc922..a3e8f01c62d4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -418,12 +418,11 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
 	return len;
 }
 
-/* Make page to RO mode when allocate it */
-void *alloc_insn_page(void)
+void *text_alloc_kprobes(unsigned long size)
 {
 	void *page;
 
-	page = module_alloc(PAGE_SIZE);
+	page = text_alloc(size);
 	if (!page)
 		return NULL;
 
@@ -444,9 +443,9 @@ void *alloc_insn_page(void)
 }
 
 /* Recover page to RW mode before releasing it */
-void free_insn_page(void *page)
+void text_free_kprobes(void *page)
 {
-	module_memfree(page);
+	text_free(page);
 }
 
 static int arch_copy_kprobe(struct kprobe *p)
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 6adf90f248d7..dbc9c71d4ec4 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -27,6 +27,7 @@
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
+#include <linux/moduleloader.h>
 #include <asm/kprobes.h>
 
 #ifdef CONFIG_KPROBES
@@ -374,8 +375,20 @@ int enable_kprobe(struct kprobe *kp);
 
 void dump_kprobe(struct kprobe *kp);
 
-void *alloc_insn_page(void);
-void free_insn_page(void *page);
+#ifdef CONFIG_HAVE_KPROBES_TEXT_ALLOC
+void *text_alloc_kprobes(unsigned long size);
+void text_free_kprobes(void *page);
+#else
+static inline void *text_alloc_kprobes(unsigned long size)
+{
+	return module_alloc(size);
+}
+
+static inline void text_free_kprobes(void *page)
+{
+	module_memfree(page);
+}
+#endif
 
 #else /* !CONFIG_KPROBES: */
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2e97febeef77..c4f107682250 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -109,14 +109,14 @@ enum kprobe_slot_state {
 	SLOT_USED = 2,
 };
 
-void __weak *alloc_insn_page(void)
+static void *alloc_insn_page(void)
 {
-	return module_alloc(PAGE_SIZE);
+	return text_alloc_kprobes(PAGE_SIZE);
 }
 
-void __weak free_insn_page(void *page)
+static void free_insn_page(void *page)
 {
-	module_memfree(page);
+	text_free_kprobes(page);
 }
 
 struct kprobe_insn_cache kprobe_insn_slots = {
-- 
2.26.2


> +#endif
> +
>  #endif /* _LINUX_VMALLOC_H */
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

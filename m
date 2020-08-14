Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D1E20774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k89gPw1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgHNR3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgHNR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:21 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A96EC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:21 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id q19so7498742qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r38RFVTSLd39a5IgqHvrDDhgXMykJLxcJUtVzw/ztLU=;
        b=k89gPw1hPq2wJ8rV9u6UUbSraGzwBr28moBXi+a5ajthPSSFNgDzLbB7yD7E9VVduW
         bb1FPYG80QSJuOFlmro9W2sHggJVSzZb4PoCGw5e8mvd21JrIclIf+mTQ9WusHpxVmfG
         hAk4ETY+l+V4G5cIKpHSmNa9tsC+jM2LhzFeXOnZh9DXupz5s4/f0CJeHH/bb/+iLCXI
         sWc5pSDNh4dejREZORo/hp3bsnnN+6KyRF1It0dPJbNuSyBMdpJ/lxUh2iPelYprvnHB
         9iMHKrAGdqspXD0MNb/WHKEAVzWRaNtgXebWPlYiV1k2xIzKoufnpV/wWROlspteTtTi
         hdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r38RFVTSLd39a5IgqHvrDDhgXMykJLxcJUtVzw/ztLU=;
        b=TIYyM+/y6J0B2uHO1hqretuOJp0aNfnkFBvQbhzTAD+8IGd8ZR9vpmWOZ0bcysdfZV
         Om2ldIY3hj0Exl324YelWdqlg4yNA9INzgpTTT4zF6k02o+zulQ1WG6SiGBF4I6AGBaa
         qD4udjgprJ3B42q2PdRuQju3kw7TWJyl8UbZJYpudBQlalQk8ahYLNNOLWsZIsrAPE+z
         QyObe9QhOSM6jFVXLpstnihHNS8AndkH5xBYmsoEP4FmvEoz1GpIzJgnssZW5v5EgBxq
         oWZUbHAIsT/9mOuGx2nepId39FMBog5DWvhl0j0nhCLc2yEuKh0QtJdfG7P4Q9KLen5w
         HpkA==
X-Gm-Message-State: AOAM533wXKSV+6OWXK4yuUdhVbeIYf964/jm4hY6qReXMXdDc6tL85vT
        wKKXYnqXmZXLJF+/Q4ua6xiROQr7Ggj3Hb9u
X-Google-Smtp-Source: ABdhPJzPwzsCUtH6q3FBA06VRf3lQgmqmcjUr9G6+YfQA/bmj4JUsU/c1PJ+jnrjKX1u//YJ5oMhBAA6LfdIekt7
X-Received: by 2002:a0c:fa92:: with SMTP id o18mr3670188qvn.182.1597426100756;
 Fri, 14 Aug 2020 10:28:20 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:06 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When MTE is present, the GCR_EL1 register contains the tags mask that
allows to exclude tags from the random generation via the IRG instruction.

With the introduction of the new Tag-Based KASAN API that provides a
mechanism to reserve tags for special reasons, the MTE implementation
has to make sure that the GCR_EL1 setting for the kernel does not affect
the userspace processes and viceversa.

Save and restore the kernel/user mask in GCR_EL1 in kernel entry and exit.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/mte.h    |  8 ++++++++
 arch/arm64/kernel/asm-offsets.c |  3 +++
 arch/arm64/kernel/cpufeature.c  |  5 +++--
 arch/arm64/kernel/entry.S       | 28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/mte.c         | 19 +++++++++++++++++--
 5 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 733be1cb5c95..4929f744d103 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -21,6 +21,8 @@
 
 #include <asm/pgtable-types.h>
 
+extern u64 gcr_kernel_excl;
+
 void mte_clear_page_tags(void *addr);
 unsigned long mte_copy_tags_from_user(void *to, const void __user *from,
 				      unsigned long n);
@@ -59,6 +61,8 @@ u8 mte_get_mem_tag(void *addr);
 u8 mte_get_random_tag(void);
 void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
+void mte_init_tags(u64 max_tag);
+
 #else /* CONFIG_ARM64_MTE */
 
 /* unused if !CONFIG_ARM64_MTE, silence the compiler */
@@ -120,6 +124,10 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return addr;
 }
 
+static inline void mte_init_tags(u64 max_tag)
+{
+}
+
 #endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 0577e2142284..a1ef256cad4f 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -47,6 +47,9 @@ int main(void)
 #ifdef CONFIG_ARM64_PTR_AUTH
   DEFINE(THREAD_KEYS_USER,	offsetof(struct task_struct, thread.keys_user));
   DEFINE(THREAD_KEYS_KERNEL,	offsetof(struct task_struct, thread.keys_kernel));
+#endif
+#ifdef CONFIG_ARM64_MTE
+  DEFINE(THREAD_GCR_EL1_USER,	offsetof(struct task_struct, thread.gcr_user_excl));
 #endif
   BLANK();
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4d94af19d8f6..54bc3b315063 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1665,14 +1665,15 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
 	u64 mair;
 
-	/* all non-zero tags excluded by default */
-	write_sysreg_s(SYS_GCR_EL1_RRND | SYS_GCR_EL1_EXCL_MASK, SYS_GCR_EL1);
 	write_sysreg_s(0, SYS_TFSR_EL1);
 	write_sysreg_s(0, SYS_TFSRE0_EL1);
 
 	/* Enable Match-All at EL1 */
 	sysreg_clear_set(tcr_el1, 0, SYS_TCR_EL1_TCMA1);
 
+	/* Enable the kernel exclude mask for random tags generation */
+	write_sysreg_s((SYS_GCR_EL1_RRND | gcr_kernel_excl), SYS_GCR_EL1);
+
 	/*
 	 * CnP must be enabled only after the MAIR_EL1 register has been set
 	 * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index cde127508e38..a17fefb0571b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -172,6 +172,29 @@ alternative_else_nop_endif
 #endif
 	.endm
 
+	/* Note: tmp should always be a callee-saved register */
+	.macro mte_restore_gcr, el, tsk, tmp, tmp2
+#ifdef CONFIG_ARM64_MTE
+alternative_if_not ARM64_MTE
+	b	1f
+alternative_else_nop_endif
+	.if	\el == 0
+	ldr	\tmp, [\tsk, #THREAD_GCR_EL1_USER]
+	.else
+	ldr_l	\tmp, gcr_kernel_excl
+	.endif
+	/*
+	 * Calculate and set the exclude mask preserving
+	 * the RRND (bit[16]) setting.
+	 */
+	mrs_s	\tmp2, SYS_GCR_EL1
+	bfi	\tmp2, \tmp, #0, #16
+	msr_s	SYS_GCR_EL1, \tmp2
+	isb
+1:
+#endif
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -209,6 +232,8 @@ alternative_else_nop_endif
 
 	ptrauth_keys_install_kernel tsk, x20, x22, x23
 
+	mte_restore_gcr 1, tsk, x22, x23
+
 	scs_load tsk, x20
 	.else
 	add	x21, sp, #S_FRAME_SIZE
@@ -386,6 +411,8 @@ alternative_else_nop_endif
 	/* No kernel C function calls after this as user keys are set. */
 	ptrauth_keys_install_user tsk, x0, x1, x2
 
+	mte_restore_gcr 0, tsk, x0, x1
+
 	apply_ssbd 0, x0, x1
 	.endif
 
@@ -957,6 +984,7 @@ SYM_FUNC_START(cpu_switch_to)
 	mov	sp, x9
 	msr	sp_el0, x1
 	ptrauth_keys_install_kernel x1, x8, x9, x10
+	mte_restore_gcr 1, x1, x8, x9
 	scs_save x0, x8
 	scs_load x1, x8
 	ret
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 7717ea9bc2a7..cfac7d02f032 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -18,10 +18,14 @@
 
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
+#include <asm/kasan.h>
+#include <asm/kprobes.h>
 #include <asm/mte.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
+u64 gcr_kernel_excl __read_mostly;
+
 static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
 	pte_t old_pte = READ_ONCE(*ptep);
@@ -115,6 +119,13 @@ void * __must_check mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return ptr;
 }
 
+void mte_init_tags(u64 max_tag)
+{
+	u64 incl = ((1ULL << ((max_tag & MTE_TAG_MAX) + 1)) - 1);
+
+	gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
+}
+
 static void update_sctlr_el1_tcf0(u64 tcf0)
 {
 	/* ISB required for the kernel uaccess routines */
@@ -150,7 +161,11 @@ static void update_gcr_el1_excl(u64 excl)
 static void set_gcr_el1_excl(u64 excl)
 {
 	current->thread.gcr_user_excl = excl;
-	update_gcr_el1_excl(excl);
+
+	/*
+	 * SYS_GCR_EL1 will be set to current->thread.gcr_user_incl value
+	 * by mte_restore_gcr() in kernel_exit,
+	 */
 }
 
 void flush_mte_state(void)
@@ -184,7 +199,7 @@ void mte_suspend_exit(void)
 	if (!system_supports_mte())
 		return;
 
-	update_gcr_el1_excl(current->thread.gcr_user_excl);
+	update_gcr_el1_excl(gcr_kernel_excl);
 }
 
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
-- 
2.28.0.220.ged08abb693-goog


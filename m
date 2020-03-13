Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B92AC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C85206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9HIkdg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCMTwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36355 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbgCMTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so8648626qtb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FhTJdnl5pdkYt0oFxRR6UWqPDOG1Ij7jaDgGDQxS4k=;
        b=E9HIkdg9ipTI4OBD2Gh7AQJafEHFmNBLDR/+5818ytFUyTm8WS0nxSOPVCdx+iQfyz
         ViXsgdiiiFbVL56vXufRrUljG8/YmCk4GPg7mhz7PR1ufDER3+gv1KwcHWED/iAh1siF
         pg1B45ldfx0cLdFhzNvF34/NDRIpHpuhAjanMNoiKf8ZEh9+TNngUiRbstYV4ILafYTu
         t6qQejhH2gOb97f/WCrKB9BXhNgNhCsnKfx1gWniMrFzZ00s4QJczzWhx2u4DBft6vW1
         j5pVJQjoTVGQNmgeyK+l+s9XCaa4PP2ECTG1fWLCUpqCSCs0C/Ka3MDn0E0+elvI8YpC
         oqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FhTJdnl5pdkYt0oFxRR6UWqPDOG1Ij7jaDgGDQxS4k=;
        b=Z8lt7wYqAJu2sjbQwdECCqd/8BaQpCgXjpzNlRWTDd4YiLI/ad9wsjpRjVkeSVxdJb
         WSIAPu4u75rXM8qNDzb3s61piOPXV7kf3pbNTuUxbCQA482m/4rPqt03kkiRbFWXuLEa
         ZPlWiJBx09CuW3wOh2TzBtbzf549c6f6+LvXYYu8L38cy+yXWhsX22R3m9jBZV8IefD5
         5lt5LkLEILjJYBskZybMsurXzb0EFlXB7SvO6ThwwwoxdHVHr9erbYE7gxtTniTlAz34
         Buc3LMCkMkXxiqj+Cf9azYxbg93ooVuzKVBbQAi+zzLHuL/RXW8N1qKfT/+avB2XpsBe
         fpYg==
X-Gm-Message-State: ANhLgQ2GQb4H+UJQUFw/78G+yMjPJdG4RpyNtNRqmVQ2BhLDqLflHIRd
        kqjTztmKSTTiqUkLvw1ZmqlsMus=
X-Google-Smtp-Source: ADFU+vsNhxo+80FQeRsNJK4GehAK3NO4DmGu9aFZCtl2E3CIrklhP+YGQZCtDuNL2GoWjEt71KEkfA==
X-Received: by 2002:aed:2169:: with SMTP id 96mr14630820qtc.124.1584129151355;
        Fri, 13 Mar 2020 12:52:31 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:30 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 16/18] x86-32: Enable pt_regs based syscalls
Date:   Fri, 13 Mar 2020 15:51:42 -0400
Message-Id: <20200313195144.164260-17-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pt_regs based syscalls for 32-bit.  This makes the 32-bit native
kernel consistent with the 64-bit kernel, and improves the syscall
interface by not needing to push all 6 potential arguments onto the stack.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/Kconfig                       |   2 +-
 arch/x86/entry/common.c                |  15 ----
 arch/x86/entry/syscall_32.c            |  15 +---
 arch/x86/include/asm/syscall.h         |   6 --
 arch/x86/include/asm/syscall_wrapper.h | 111 ++++++++++++++-----------
 arch/x86/include/asm/syscalls.h        |  29 -------
 6 files changed, 64 insertions(+), 114 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 532f52b99094..b65f07a06549 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -30,7 +30,6 @@ config X86_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
-	select ARCH_HAS_SYSCALL_WRAPPER
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
@@ -79,6 +78,7 @@ config X86
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
+	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index c3a8e6513f74..76735ec813e6 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -334,20 +334,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
-#ifdef CONFIG_IA32_EMULATION
 		regs->ax = ia32_sys_call_table[nr](regs);
-#else
-		/*
-		 * It's possible that a 32-bit syscall implementation
-		 * takes a 64-bit parameter but nonetheless assumes that
-		 * the high bits are zero.  Make sure we zero-extend all
-		 * of the args.
-		 */
-		regs->ax = ia32_sys_call_table[nr](
-			(unsigned int)regs->bx, (unsigned int)regs->cx,
-			(unsigned int)regs->dx, (unsigned int)regs->si,
-			(unsigned int)regs->di, (unsigned int)regs->bp);
-#endif /* CONFIG_IA32_EMULATION */
 	}
 
 	syscall_return_slowpath(regs);
@@ -440,9 +427,7 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 }
 #endif
 
-#ifdef CONFIG_X86_64
 SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
 }
-#endif
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 41ec9c66fe15..097413c705ad 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -4,33 +4,22 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
+#include <linux/syscalls.h>
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#ifdef CONFIG_IA32_EMULATION
-/* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
 #define __SYSCALL_I386(nr, sym) extern asmlinkage long __ia32_##sym(const struct pt_regs *);
-#define __sys_ni_syscall __ia32_sys_ni_syscall
-#else /* CONFIG_IA32_EMULATION */
-#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-#define __sys_ni_syscall sys_ni_syscall
-#endif /* CONFIG_IA32_EMULATION */
 
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
 
-#ifdef CONFIG_IA32_EMULATION
 #define __SYSCALL_I386(nr, sym) [nr] = __ia32_##sym,
-#else /* CONFIG_IA32_EMULATION */
-#define __SYSCALL_I386(nr, sym) [nr] = sym,
-#endif /* CONFIG_IA32_EMULATION */
 
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_ia32_syscall_max] = &__sys_ni_syscall,
+	[0 ... __NR_ia32_syscall_max] = &__ia32_sys_ni_syscall,
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index f4d010d0fa30..bb427d8cb1ef 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,13 +16,7 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-#ifdef CONFIG_X86_64
 typedef asmlinkage long (*sys_call_ptr_t)(const struct pt_regs *);
-#else
-typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
-					  unsigned long, unsigned long,
-					  unsigned long, unsigned long);
-#endif /* CONFIG_X86_64 */
 extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 0f126e40a464..5e13e2caf2e4 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -11,6 +11,47 @@ struct pt_regs;
 extern asmlinkage long __x64_sys_ni_syscall(const struct pt_regs *regs);
 extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
+/*
+ * Instead of the generic __SYSCALL_DEFINEx() definition, the x86 version takes
+ * struct pt_regs *regs as the only argument of the syscall stub(s) named as:
+ * __x64_sys_*()         - 64-bit native syscall
+ * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
+ * __ia32_compat_sys_*() - 32-bit compat syscall
+ * __x32_compat_sys_*()  - 64-bit X32 compat syscall
+ *
+ * The registers are decoded according to the ABI:
+ * 64-bit: RDI, RSI, RDX, R10, R8, R9
+ * 32-bit: EBX, ECX, EDX, ESI, EDI, EBP
+ *
+ * The stub then passes the decoded arguments to the __se_sys_*() wrapper to
+ * perform sign-extension (omitted for zero-argument syscalls).  Finally the
+ * arguments are passed to the __do_sys_*() function which is the actual
+ * syscall.  These wrappers are marked as inline so the compiler can optimize
+ * the functions where appropriate.
+ *
+ * Example assembly (slightly re-ordered for better readability):
+ *
+ * <__x64_sys_recv>:		<-- syscall with 4 parameters
+ *	callq	<__fentry__>
+ *
+ *	mov	0x70(%rdi),%rdi	<-- decode regs->di
+ *	mov	0x68(%rdi),%rsi	<-- decode regs->si
+ *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
+ *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
+ *
+ *	xor	%r9d,%r9d	<-- clear %r9
+ *	xor	%r8d,%r8d	<-- clear %r8
+ *
+ *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
+ *				    which takes 6 arguments
+ *
+ *	cltq			<-- extend return value to 64-bit
+ *	retq			<-- return
+ *
+ * This approach avoids leaking random user-provided register content down
+ * the call chain.
+ */
+
 /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
 #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
 	__MAP(x,__SC_ARGS						\
@@ -68,6 +109,26 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __X64_SYS_NI(name)
 #endif /* CONFIG_X86_64 */
 
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+#define __IA32_SYS_STUB0(name)						\
+	__SYS_STUB0(ia32, sys_##name)
+
+#define __IA32_SYS_STUBx(x, name, ...)					\
+	__SYS_STUBx(ia32, sys##name,					\
+		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __IA32_COND_SYSCALL(name)					\
+	__COND_SYSCALL(ia32, sys_##name)
+
+#define __IA32_SYS_NI(name)						\
+	__SYS_NI(ia32, sys_##name)
+#else /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
+#define __IA32_SYS_STUB0(name)
+#define __IA32_SYS_STUBx(x, name, ...)
+#define __IA32_COND_SYSCALL(name)
+#define __IA32_SYS_NI(name)
+#endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
+
 #ifdef CONFIG_IA32_EMULATION
 /*
  * For IA32 emulation, we need to handle "compat" syscalls *and* create
@@ -90,27 +151,11 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __IA32_COMPAT_SYS_NI(name)					\
 	__SYS_NI(ia32, compat_sys_##name)
 
-#define __IA32_SYS_STUB0(name)						\
-	__SYS_STUB0(ia32, sys_##name)
-
-#define __IA32_SYS_STUBx(x, name, ...)					\
-	__SYS_STUBx(ia32, sys##name,					\
-		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
-
-#define __IA32_COND_SYSCALL(name)					\
-	__COND_SYSCALL(ia32, sys_##name)
-
-#define __IA32_SYS_NI(name)						\
-	__SYS_NI(ia32, sys_##name)
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
 #define __IA32_COMPAT_COND_SYSCALL(name)
 #define __IA32_COMPAT_SYS_NI(name)
-#define __IA32_SYS_STUB0(name)
-#define __IA32_SYS_STUBx(x, name, ...)
-#define __IA32_COND_SYSCALL(name)
-#define __IA32_SYS_NI(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -180,40 +225,6 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 #endif /* CONFIG_COMPAT */
 
-
-/*
- * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
- * struct pt_regs *regs as the only argument of the syscall stub named
- * __x64_sys_*(). It decodes just the registers it needs and passes them on to
- * the __se_sys_*() wrapper performing sign extension and then to the
- * __do_sys_*() function doing the actual job. These wrappers and functions
- * are inlined (at least in very most cases), meaning that the assembly looks
- * as follows (slightly re-ordered for better readability):
- *
- * <__x64_sys_recv>:		<-- syscall with 4 parameters
- *	callq	<__fentry__>
- *
- *	mov	0x70(%rdi),%rdi	<-- decode regs->di
- *	mov	0x68(%rdi),%rsi	<-- decode regs->si
- *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
- *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
- *
- *	xor	%r9d,%r9d	<-- clear %r9
- *	xor	%r8d,%r8d	<-- clear %r8
- *
- *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
- *				    which takes 6 arguments
- *
- *	cltq			<-- extend return value to 64-bit
- *	retq			<-- return
- *
- * This approach avoids leaking random user-provided register content down
- * the call chain.
- *
- * If IA32_EMULATION is enabled, this macro generates an additional wrapper
- * named __ia32_sys_*() which decodes the struct pt_regs *regs according
- * to the i386 calling convention (bx, cx, dx, si, di, bp).
- */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index 91b7b6e1a115..06cbdca634d6 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -17,33 +17,4 @@
 /* kernel/ioport.c */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
 
-#ifdef CONFIG_X86_32
-/*
- * These definitions are only valid on pure 32-bit systems; x86-64 uses a
- * different syscall calling convention
- */
-asmlinkage long sys_ioperm(unsigned long, unsigned long, int);
-asmlinkage long sys_iopl(unsigned int);
-
-/* kernel/ldt.c */
-asmlinkage long sys_modify_ldt(int, void __user *, unsigned long);
-
-/* kernel/signal.c */
-asmlinkage long sys_rt_sigreturn(void);
-
-/* kernel/tls.c */
-asmlinkage long sys_set_thread_area(struct user_desc __user *);
-asmlinkage long sys_get_thread_area(struct user_desc __user *);
-
-/* X86_32 only */
-
-/* kernel/signal.c */
-asmlinkage long sys_sigreturn(void);
-
-/* kernel/vm86_32.c */
-struct vm86_struct;
-asmlinkage long sys_vm86old(struct vm86_struct __user *);
-asmlinkage long sys_vm86(unsigned long, unsigned long);
-
-#endif /* CONFIG_X86_32 */
 #endif /* _ASM_X86_SYSCALLS_H */
-- 
2.24.1


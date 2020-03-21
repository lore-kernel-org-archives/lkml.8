Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98980C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AE821655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCUPbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:31:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgCUPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg52-0004y1-Vb; Sat, 21 Mar 2020 16:30:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7991D1C22E4;
        Sat, 21 Mar 2020 16:30:32 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:32 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Enable pt_regs based syscalls
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-17-brgerst@gmail.com>
References: <20200313195144.164260-17-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463205.28353.795563055304704323.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     25c619e59b395a8c970d339f9c714302738e350e
Gitweb:        https://git.kernel.org/tip/25c619e59b395a8c970d339f9c714302738e350e
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:42 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:24 +01:00

x86/entry/32: Enable pt_regs based syscalls

Enable pt_regs based syscalls for 32-bit.  This makes the 32-bit native
kernel consistent with the 64-bit kernel, and improves the syscall
interface by not needing to push all 6 potential arguments onto the stack.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Link: https://lkml.kernel.org/r/20200313195144.164260-17-brgerst@gmail.com

---
 arch/x86/Kconfig                       |   2 +-
 arch/x86/entry/common.c                |  15 +---
 arch/x86/entry/syscall_32.c            |  15 +---
 arch/x86/include/asm/syscall.h         |   6 +-
 arch/x86/include/asm/syscall_wrapper.h | 111 +++++++++++++-----------
 arch/x86/include/asm/syscalls.h        |  29 +------
 6 files changed, 64 insertions(+), 114 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea770..9df07b2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -30,7 +30,6 @@ config X86_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
-	select ARCH_HAS_SYSCALL_WRAPPER
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
@@ -80,6 +79,7 @@ config X86
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
+	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 149bf54..6062e8e 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -333,20 +333,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 
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
@@ -439,9 +426,7 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 }
 #endif
 
-#ifdef CONFIG_X86_64
 SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
 }
-#endif
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 41ec9c6..097413c 100644
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
index 1ef8d7b..e413c83 100644
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
index 0f126e4..5e13e2c 100644
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
index 91b7b6e..06cbdca 100644
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

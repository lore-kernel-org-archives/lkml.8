Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04204C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBBB20789
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgCUPaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38954 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgCUPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg5E-00053g-HL; Sat, 21 Mar 2020 16:30:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ECFCB1C22EB;
        Sat, 21 Mar 2020 16:30:38 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:38 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Refactor SYSCALL_DEFINE0 macros
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-3-brgerst@gmail.com>
References: <20200313195144.164260-3-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463855.28353.15888285041693958366.tip-bot2@tip-bot2>
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

Commit-ID:     d2b5de495ee9838b3752806c135afd43b76b1e8f
Gitweb:        https://git.kernel.org/tip/d2b5de495ee9838b3752806c135afd43b76b1e8f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:28 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:19 +01:00

x86/entry: Refactor SYSCALL_DEFINE0 macros

Pull the common code out from the SYSCALL_DEFINE0 macros into a new
__SYS_STUB0 macro.  Also conditionalize the X64 version in preparation for
enabling syscall wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200313195144.164260-3-brgerst@gmail.com

---
 arch/x86/include/asm/syscall_wrapper.h | 73 ++++++++++---------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a1c090b..45ad605 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -21,6 +21,12 @@ struct pt_regs;
 	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
 	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
 
+#define __SYS_STUB0(abi, name)						\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+		__alias(__do_##name);
+
 #define __SYS_STUBx(abi, name, ...)					\
 	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
 	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
@@ -30,10 +36,14 @@ struct pt_regs;
 	}
 
 #ifdef CONFIG_X86_64
+#define __X64_SYS_STUB0(name)						\
+	__SYS_STUB0(x64, sys_##name)
+
 #define __X64_SYS_STUBx(x, name, ...)					\
 	__SYS_STUBx(x64, sys##name,					\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 #else /* CONFIG_X86_64 */
+#define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_X86_64 */
 
@@ -46,34 +56,20 @@ struct pt_regs;
  * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
  * case as well.
  */
-#define __IA32_COMPAT_SYS_STUB0(x, name)				\
-	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__ia32_compat_sys_##name, ERRNO);		\
-	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys_##name();			\
-	}
+#define __IA32_COMPAT_SYS_STUB0(name)					\
+	__SYS_STUB0(ia32, compat_sys_##name)
 
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
 	__SYS_STUBx(ia32, compat_sys##name,				\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __IA32_SYS_STUB0(name)						\
+	__SYS_STUB0(ia32, sys_##name)
+
 #define __IA32_SYS_STUBx(x, name, ...)					\
 	__SYS_STUBx(ia32, sys##name,					\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
-/*
- * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
- * named __ia32_sys_*()
- */
-
-#define SYSCALL_DEFINE0(sname)						\
-	SYSCALL_METADATA(_##sname, 0);					\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
-	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);		\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
-
 #define COND_SYSCALL(name)							\
 	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
 	{									\
@@ -89,7 +85,9 @@ struct pt_regs;
 	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
+#define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_IA32_EMULATION */
 
@@ -100,20 +98,15 @@ struct pt_regs;
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
  * with x86_64 obviously do not need such care.
  */
-#define __X32_COMPAT_SYS_STUB0(x, name, ...)				\
-	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__x32_compat_sys_##name, ERRNO);		\
-	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys_##name();\
-	}
+#define __X32_COMPAT_SYS_STUB0(name)					\
+	__SYS_STUB0(x32, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
 	__SYS_STUBx(x32, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #else /* CONFIG_X86_X32 */
-#define __X32_COMPAT_SYS_STUB0(x, name)
+#define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_X86_X32 */
 
@@ -125,15 +118,12 @@ struct pt_regs;
  * of them.
  */
 #define COMPAT_SYSCALL_DEFINE0(name)					\
-	static long __se_compat_sys_##name(void);			\
-	static inline long __do_compat_sys_##name(void);		\
-	__IA32_COMPAT_SYS_STUB0(x, name)				\
-	__X32_COMPAT_SYS_STUB0(x, name)					\
-	static long __se_compat_sys_##name(void)			\
-	{								\
-		return __do_compat_sys_##name();			\
-	}								\
-	static inline long __do_compat_sys_##name(void)
+	static asmlinkage long						\
+	__do_compat_sys_##name(const struct pt_regs *__unused);		\
+	__IA32_COMPAT_SYS_STUB0(name)					\
+	__X32_COMPAT_SYS_STUB0(name)					\
+	static asmlinkage long						\
+	__do_compat_sys_##name(const struct pt_regs *__unused)
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
@@ -216,13 +206,14 @@ struct pt_regs;
  * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
  * macros to work correctly.
  */
-#ifndef SYSCALL_DEFINE0
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
-#endif
+	static asmlinkage long						\
+	__do_sys_##sname(const struct pt_regs *__unused);		\
+	__X64_SYS_STUB0(sname)						\
+	__IA32_SYS_STUB0(sname)						\
+	static asmlinkage long						\
+	__do_sys_##sname(const struct pt_regs *__unused)
 
 #ifndef COND_SYSCALL
 #define COND_SYSCALL(name) 							\

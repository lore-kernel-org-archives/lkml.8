Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31768C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057A520781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgCUPap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38886 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgCUPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg52-0004xj-Bo; Sat, 21 Mar 2020 16:30:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EF2421C22E5;
        Sat, 21 Mar 2020 16:30:31 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:31 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Drop asmlinkage from syscalls
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-18-brgerst@gmail.com>
References: <20200313195144.164260-18-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463166.28353.4814559802434057045.tip-bot2@tip-bot2>
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

Commit-ID:     0f78ff17112d8b3469b805ff4ea9780cc1e5c93b
Gitweb:        https://git.kernel.org/tip/0f78ff17112d8b3469b805ff4ea9780cc1e5c93b
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:43 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:25 +01:00

x86/entry: Drop asmlinkage from syscalls

asmlinkage is no longer required since the syscall ABI is now fully under
x86 architecture control.  This makes the 32-bit native syscalls a bit more
effecient by passing in regs via EAX instead of on the stack.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200313195144.164260-18-brgerst@gmail.com

---
 arch/x86/entry/syscall_32.c            |  2 +-
 arch/x86/entry/syscall_64.c            |  2 +-
 arch/x86/entry/syscall_x32.c           |  4 +--
 arch/x86/include/asm/syscall.h         |  2 +-
 arch/x86/include/asm/syscall_wrapper.h | 31 +++++++++++--------------
 5 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 097413c..86eb0d8 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -8,7 +8,7 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym) extern asmlinkage long __ia32_##sym(const struct pt_regs *);
+#define __SYSCALL_I386(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
 
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 66d3e65..1594ec7 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -11,7 +11,7 @@
 #define __SYSCALL_X32(nr, sym)
 #define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_64(nr, sym) extern asmlinkage long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_64(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 2fb09ef..3d8d70d 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -10,8 +10,8 @@
 
 #define __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_X32(nr, sym) extern asmlinkage long __x32_##sym(const struct pt_regs *);
-#define __SYSCALL_COMMON(nr, sym) extern asmlinkage long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
+#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
 #undef __SYSCALL_COMMON
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index e413c83..6435294 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,7 +16,7 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-typedef asmlinkage long (*sys_call_ptr_t)(const struct pt_regs *);
+typedef long (*sys_call_ptr_t)(const struct pt_regs *);
 extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 5e13e2c..e10efa1 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -8,8 +8,8 @@
 
 struct pt_regs;
 
-extern asmlinkage long __x64_sys_ni_syscall(const struct pt_regs *regs);
-extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
+extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
+extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 /*
  * Instead of the generic __SYSCALL_DEFINEx() definition, the x86 version takes
@@ -66,22 +66,21 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
 
 #define __SYS_STUB0(abi, name)						\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	long __##abi##_##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+	long __##abi##_##name(const struct pt_regs *regs)		\
 		__alias(__do_##name);
 
 #define __SYS_STUBx(abi, name, ...)					\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	long __##abi##_##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+	long __##abi##_##name(const struct pt_regs *regs)		\
 	{								\
 		return __se_##name(__VA_ARGS__);			\
 	}
 
 #define __COND_SYSCALL(abi, name)					\
-	asmlinkage __weak long						\
-	__##abi##_##name(const struct pt_regs *__unused)		\
+	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
 	{								\
 		return sys_ni_syscall();				\
 	}
@@ -192,11 +191,11 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * of them.
  */
 #define COMPAT_SYSCALL_DEFINE0(name)					\
-	static asmlinkage long						\
+	static long							\
 	__do_compat_sys_##name(const struct pt_regs *__unused);		\
 	__IA32_COMPAT_SYS_STUB0(name)					\
 	__X32_COMPAT_SYS_STUB0(name)					\
-	static asmlinkage long						\
+	static long							\
 	__do_compat_sys_##name(const struct pt_regs *__unused)
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
@@ -248,12 +247,10 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  */
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
-	static asmlinkage long						\
-	__do_sys_##sname(const struct pt_regs *__unused);		\
+	static long __do_sys_##sname(const struct pt_regs *__unused);	\
 	__X64_SYS_STUB0(sname)						\
 	__IA32_SYS_STUB0(sname)						\
-	static asmlinkage long						\
-	__do_sys_##sname(const struct pt_regs *__unused)
+	static long __do_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)						\
 	__X64_COND_SYSCALL(name)					\
@@ -268,8 +265,8 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * For VSYSCALLS, we need to declare these three syscalls with the new
  * pt_regs-based calling convention for in-kernel use.
  */
-asmlinkage long __x64_sys_getcpu(const struct pt_regs *regs);
-asmlinkage long __x64_sys_gettimeofday(const struct pt_regs *regs);
-asmlinkage long __x64_sys_time(const struct pt_regs *regs);
+long __x64_sys_getcpu(const struct pt_regs *regs);
+long __x64_sys_gettimeofday(const struct pt_regs *regs);
+long __x64_sys_time(const struct pt_regs *regs);
 
 #endif /* _ASM_X86_SYSCALL_WRAPPER_H */

Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05F1C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B0220776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCUPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:31:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgCUPaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg5A-00052o-GF; Sat, 21 Mar 2020 16:30:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7589C1C22EA;
        Sat, 21 Mar 2020 16:30:38 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:38 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Refactor COND_SYSCALL macros
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-4-brgerst@gmail.com>
References: <20200313195144.164260-4-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463814.28353.17562333830742067269.tip-bot2@tip-bot2>
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

Commit-ID:     6cc8d2b286d9e7168d72e342d1b031317cd7752b
Gitweb:        https://git.kernel.org/tip/6cc8d2b286d9e7168d72e342d1b031317cd7752b
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:29 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:19 +01:00

x86/entry: Refactor COND_SYSCALL macros

Pull the common code out from the COND_SYSCALL macros into a new
__COND_SYSCALL macro.  Also conditionalize the X64 version in preparation
for enabling syscall wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200313195144.164260-4-brgerst@gmail.com

---
 arch/x86/include/asm/syscall_wrapper.h | 44 ++++++++++++++-----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 45ad605..0117b25 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -35,6 +35,13 @@ struct pt_regs;
 		return __se_##name(__VA_ARGS__);			\
 	}
 
+#define __COND_SYSCALL(abi, name)					\
+	asmlinkage __weak long						\
+	__##abi##_##name(const struct pt_regs *__unused)		\
+	{								\
+		return sys_ni_syscall();				\
+	}
+
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)						\
 	__SYS_STUB0(x64, sys_##name)
@@ -42,9 +49,13 @@ struct pt_regs;
 #define __X64_SYS_STUBx(x, name, ...)					\
 	__SYS_STUBx(x64, sys##name,					\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __X64_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x64, sys_##name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
+#define __X64_COND_SYSCALL(name)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -63,6 +74,9 @@ struct pt_regs;
 	__SYS_STUBx(ia32, compat_sys##name,				\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __IA32_COMPAT_COND_SYSCALL(name)				\
+	__COND_SYSCALL(ia32, compat_sys_##name)
+
 #define __IA32_SYS_STUB0(name)						\
 	__SYS_STUB0(ia32, sys_##name)
 
@@ -70,15 +84,8 @@ struct pt_regs;
 	__SYS_STUBx(ia32, sys##name,					\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
-#define COND_SYSCALL(name)							\
-	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
-	{									\
-		return sys_ni_syscall();					\
-	}									\
-	asmlinkage __weak long __ia32_sys_##name(const struct pt_regs *__unused)\
-	{									\
-		return sys_ni_syscall();					\
-	}
+#define __IA32_COND_SYSCALL(name)					\
+	__COND_SYSCALL(ia32, sys_##name)
 
 #define SYS_NI(name)							\
 	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
@@ -87,8 +94,10 @@ struct pt_regs;
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_COMPAT_COND_SYSCALL(name)
 #define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
+#define __IA32_COND_SYSCALL(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -105,9 +114,12 @@ struct pt_regs;
 	__SYS_STUBx(x32, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __X32_COMPAT_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x32, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
+#define __X32_COMPAT_COND_SYSCALL(name)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -142,8 +154,8 @@ struct pt_regs;
  * kernel/time/posix-stubs.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name) 					\
-	cond_syscall(__ia32_compat_sys_##name);				\
-	cond_syscall(__x32_compat_sys_##name)
+	__IA32_COMPAT_COND_SYSCALL(name)				\
+	__X32_COMPAT_COND_SYSCALL(name)
 
 #define COMPAT_SYS_NI(name)						\
 	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
@@ -215,13 +227,9 @@ struct pt_regs;
 	static asmlinkage long						\
 	__do_sys_##sname(const struct pt_regs *__unused)
 
-#ifndef COND_SYSCALL
-#define COND_SYSCALL(name) 							\
-	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
-	{									\
-		return sys_ni_syscall();					\
-	}
-#endif
+#define COND_SYSCALL(name)						\
+	__X64_COND_SYSCALL(name)					\
+	__IA32_COND_SYSCALL(name)
 
 #ifndef SYS_NI
 #define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);

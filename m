Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF1C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC3320757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCUPax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38945 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgCUPap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg5C-00052M-VO; Sat, 21 Mar 2020 16:30:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0FC371C22E8;
        Sat, 21 Mar 2020 16:30:38 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:37 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Refactor SYS_NI macros
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-5-brgerst@gmail.com>
References: <20200313195144.164260-5-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463767.28353.6872538225094443265.tip-bot2@tip-bot2>
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

Commit-ID:     a74d187c2df3a382b8ab6227da34cba690e71e4d
Gitweb:        https://git.kernel.org/tip/a74d187c2df3a382b8ab6227da34cba690e71e4d
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:30 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:20 +01:00

x86/entry: Refactor SYS_NI macros

Pull the common code out from the SYS_NI macros into a new __SYS_NI macro.
Also conditionalize the X64 version in preparation for enabling syscall
wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200313195144.164260-5-brgerst@gmail.com

---
 arch/x86/include/asm/syscall_wrapper.h | 32 +++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 0117b25..1d96cce 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -42,6 +42,9 @@ struct pt_regs;
 		return sys_ni_syscall();				\
 	}
 
+#define __SYS_NI(abi, name)						\
+	SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers)
+
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)						\
 	__SYS_STUB0(x64, sys_##name)
@@ -52,10 +55,14 @@ struct pt_regs;
 
 #define __X64_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x64, sys_##name)
+
+#define __X64_SYS_NI(name)						\
+	__SYS_NI(x64, sys_##name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
 #define __X64_COND_SYSCALL(name)
+#define __X64_SYS_NI(name)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -77,6 +84,9 @@ struct pt_regs;
 #define __IA32_COMPAT_COND_SYSCALL(name)				\
 	__COND_SYSCALL(ia32, compat_sys_##name)
 
+#define __IA32_COMPAT_SYS_NI(name)					\
+	__SYS_NI(ia32, compat_sys_##name)
+
 #define __IA32_SYS_STUB0(name)						\
 	__SYS_STUB0(ia32, sys_##name)
 
@@ -87,17 +97,17 @@ struct pt_regs;
 #define __IA32_COND_SYSCALL(name)					\
 	__COND_SYSCALL(ia32, sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
-	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
-
+#define __IA32_SYS_NI(name)						\
+	__SYS_NI(ia32, sys_##name)
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
 #define __IA32_COMPAT_COND_SYSCALL(name)
+#define __IA32_COMPAT_SYS_NI(name)
 #define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
 #define __IA32_COND_SYSCALL(name)
+#define __IA32_SYS_NI(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -116,10 +126,14 @@ struct pt_regs;
 
 #define __X32_COMPAT_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x32, compat_sys_##name)
+
+#define __X32_COMPAT_SYS_NI(name)					\
+	__SYS_NI(x32, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
+#define __X32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -158,8 +172,8 @@ struct pt_regs;
 	__X32_COMPAT_COND_SYSCALL(name)
 
 #define COMPAT_SYS_NI(name)						\
-	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
-	SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
+	__IA32_COMPAT_SYS_NI(name)					\
+	__X32_COMPAT_SYS_NI(name)
 
 #endif /* CONFIG_COMPAT */
 
@@ -231,9 +245,9 @@ struct pt_regs;
 	__X64_COND_SYSCALL(name)					\
 	__IA32_COND_SYSCALL(name)
 
-#ifndef SYS_NI
-#define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
-#endif
+#define SYS_NI(name)							\
+	__X64_SYS_NI(name)						\
+	__IA32_SYS_NI(name)
 
 
 /*

Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6676C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32C520776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgCUPb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:31:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgCUPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg57-00051A-GR; Sat, 21 Mar 2020 16:30:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A56521C22E8;
        Sat, 21 Mar 2020 16:30:36 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:36 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Split X32 syscall table into its own file
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-8-brgerst@gmail.com>
References: <20200313195144.164260-8-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463634.28353.12540165408970276913.tip-bot2@tip-bot2>
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

Commit-ID:     2e487c357917b98adc6a6dafa612c435cad1af41
Gitweb:        https://git.kernel.org/tip/2e487c357917b98adc6a6dafa612c435cad1af41
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:33 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:21 +01:00

x86/entry/64: Split X32 syscall table into its own file

Since X32 has its own syscall table now, move it to a separate file.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Link: https://lkml.kernel.org/r/20200313195144.164260-8-brgerst@gmail.com

---
 arch/x86/entry/Makefile      |  1 +
 arch/x86/entry/syscall_64.c  | 27 ++-------------------------
 arch/x86/entry/syscall_x32.c | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/entry/syscall_x32.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 06fc70c..85eb381 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -14,4 +14,5 @@ obj-y				+= vdso/
 obj-y				+= vsyscall/
 
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
+obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
 
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 058dc1b..efb85c6 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,14 +8,13 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
+#define __SYSCALL_X32(nr, sym, qual)
+
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
-#define __SYSCALL_X32(nr, sym, qual) __SYSCALL_64(nr, sym, qual)
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
-#undef __SYSCALL_X32
 
 #define __SYSCALL_64(nr, sym, qual) [nr] = sym,
-#define __SYSCALL_X32(nr, sym, qual)
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
@@ -25,25 +24,3 @@ asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	[0 ... __NR_syscall_max] = &__x64_sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
-
-#undef __SYSCALL_64
-#undef __SYSCALL_X32
-
-#ifdef CONFIG_X86_X32_ABI
-
-#define __SYSCALL_64(nr, sym, qual)
-#define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
-
-asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_x32_max] = &__x64_sys_ni_syscall,
-#include <asm/syscalls_64.h>
-};
-
-#undef __SYSCALL_64
-#undef __SYSCALL_X32
-
-#endif
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
new file mode 100644
index 0000000..d144ced
--- /dev/null
+++ b/arch/x86/entry/syscall_x32.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* System call table for x32 ABI. */
+
+#include <linux/linkage.h>
+#include <linux/sys.h>
+#include <linux/cache.h>
+#include <linux/syscalls.h>
+#include <asm/asm-offsets.h>
+#include <asm/syscall.h>
+
+#define __SYSCALL_64(nr, sym, qual)
+
+#define __SYSCALL_X32(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#include <asm/syscalls_64.h>
+#undef __SYSCALL_X32
+
+#define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
+
+asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max+1] = {
+	/*
+	 * Smells like a compiler bug -- it doesn't work
+	 * when the & below is removed.
+	 */
+	[0 ... __NR_syscall_x32_max] = &__x64_sys_ni_syscall,
+#include <asm/syscalls_64.h>
+};

Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B2C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2031F20776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgCUPbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:31:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38903 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgCUPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg55-00050E-PW; Sat, 21 Mar 2020 16:30:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5EBAB1C22E4;
        Sat, 21 Mar 2020 16:30:35 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:34 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove syscall qualifier support
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-11-brgerst@gmail.com>
References: <20200313195144.164260-11-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463497.28353.2748858752720907008.tip-bot2@tip-bot2>
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

Commit-ID:     b5592e5c0d8682e0e82b42c91fd7265c3cce19e1
Gitweb:        https://git.kernel.org/tip/b5592e5c0d8682e0e82b42c91fd7265c3cce19e1
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:36 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:22 +01:00

x86/entry: Remove syscall qualifier support

Syscall qualifier support is no longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Link: https://lkml.kernel.org/r/20200313195144.164260-11-brgerst@gmail.com

---
 arch/x86/entry/syscall_32.c           |  6 +++---
 arch/x86/entry/syscall_64.c           |  6 +++---
 arch/x86/entry/syscall_x32.c          |  6 +++---
 arch/x86/entry/syscalls/syscalltbl.sh | 10 +---------
 arch/x86/um/sys_call_table_32.c       |  4 ++--
 arch/x86/um/sys_call_table_64.c       |  4 ++--
 6 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 3207cf6..9f4cab4 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -9,10 +9,10 @@
 
 #ifdef CONFIG_IA32_EMULATION
 /* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #define __sys_ni_syscall __ia32_sys_ni_syscall
 #else /* CONFIG_IA32_EMULATION */
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #define __sys_ni_syscall sys_ni_syscall
 #endif /* CONFIG_IA32_EMULATION */
@@ -20,7 +20,7 @@ extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned lon
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
 
-#define __SYSCALL_I386(nr, sym, qual) [nr] = sym,
+#define __SYSCALL_I386(nr, sym) [nr] = sym,
 
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 5dc6846..bce4821 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,13 +8,13 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_X32(nr, sym, qual)
+#define __SYSCALL_X32(nr, sym)
 
-#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
-#define __SYSCALL_64(nr, sym, qual) [nr] = sym,
+#define __SYSCALL_64(nr, sym) [nr] = sym,
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 95abb6d..21e306c 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,13 +8,13 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_64(nr, sym, qual)
+#define __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_X32(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
 
-#define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
+#define __SYSCALL_X32(nr, sym) [nr] = sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index 1af2be3..b0519dd 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -9,15 +9,7 @@ syscall_macro() {
     local nr="$2"
     local entry="$3"
 
-    # Entry can be either just a function name or "function/qualifier"
-    real_entry="${entry%%/*}"
-    if [ "$entry" = "$real_entry" ]; then
-        qualifier=
-    else
-        qualifier=${entry#*/}
-    fi
-
-    echo "__SYSCALL_${abi}($nr, $real_entry, $qualifier)"
+    echo "__SYSCALL_${abi}($nr, $entry)"
 }
 
 emit() {
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index a0d75c5..2ed81e5 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -26,11 +26,11 @@
 
 #define old_mmap sys_old_mmap
 
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
 #include <asm/syscalls_32.h>
 
 #undef __SYSCALL_I386
-#define __SYSCALL_I386(nr, sym, qual) [ nr ] = sym,
+#define __SYSCALL_I386(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index fa97740..7d057ea 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -36,11 +36,11 @@
 #define stub_execveat sys_execveat
 #define stub_rt_sigreturn sys_rt_sigreturn
 
-#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
 #include <asm/syscalls_64.h>
 
 #undef __SYSCALL_64
-#define __SYSCALL_64(nr, sym, qual) [ nr ] = sym,
+#define __SYSCALL_64(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 

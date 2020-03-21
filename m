Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BFBC43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C730D20786
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCUPas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38932 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgCUPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg5A-0004zu-7r; Sat, 21 Mar 2020 16:30:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D64B31C22E6;
        Sat, 21 Mar 2020 16:30:34 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:34 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Add __SYSCALL_COMMON()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-12-brgerst@gmail.com>
References: <20200313195144.164260-12-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463449.28353.8404279805273411879.tip-bot2@tip-bot2>
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

Commit-ID:     8210efcb153625d2bf4bb79875ddc78eee2aba3e
Gitweb:        https://git.kernel.org/tip/8210efcb153625d2bf4bb79875ddc78eee2aba3e
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:37 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:22 +01:00

x86/entry/64: Add __SYSCALL_COMMON()

Add a __SYSCALL_COMMON() macro to the syscall table, which simplifies syscalltbl.sh.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200313195144.164260-12-brgerst@gmail.com

---
 arch/x86/entry/syscall_64.c           |  1 +
 arch/x86/entry/syscall_x32.c          |  3 +++
 arch/x86/entry/syscalls/syscalltbl.sh | 22 ++--------------------
 arch/x86/um/sys_call_table_64.c       |  3 +++
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index bce4821..03645f9 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -9,6 +9,7 @@
 #include <asm/syscall.h>
 
 #define __SYSCALL_X32(nr, sym)
+#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
 
 #define __SYSCALL_64(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 21e306c..57a151a 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -11,10 +11,13 @@
 #define __SYSCALL_64(nr, sym)
 
 #define __SYSCALL_X32(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_COMMON(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
+#undef __SYSCALL_COMMON
 
 #define __SYSCALL_X32(nr, sym) [nr] = sym,
+#define __SYSCALL_COMMON(nr, sym) [nr] = sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index b0519dd..6106ed3 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -25,7 +25,7 @@ emit() {
     fi
 
     # For CONFIG_UML, we need to strip the __x64_sys prefix
-    if [ "$abi" = "64" -a "${entry}" != "${entry#__x64_sys}" ]; then
+    if [ "${entry}" != "${entry#__x64_sys}" ]; then
 	    umlentry="sys${entry#__x64_sys}"
     fi
 
@@ -53,24 +53,6 @@ emit() {
 grep '^[0-9]' "$in" | sort -n | (
     while read nr abi name entry compat; do
 	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
-	if [ "$abi" = "COMMON" -o "$abi" = "64" ]; then
-	    emit 64 "$nr" "$entry" "$compat"
-	    if [ "$abi" = "COMMON" ]; then
-		# COMMON means that this syscall exists in the same form for
-		# 64-bit and X32.
-		echo "#ifdef CONFIG_X86_X32_ABI"
-		emit X32 "$nr" "$entry" "$compat"
-		echo "#endif"
-	    fi
-	elif [ "$abi" = "X32" ]; then
-	    echo "#ifdef CONFIG_X86_X32_ABI"
-	    emit X32 "$nr" "$entry" "$compat"
-	    echo "#endif"
-	elif [ "$abi" = "I386" ]; then
-	    emit "$abi" "$nr" "$entry" "$compat"
-	else
-	    echo "Unknown abi $abi" >&2
-	    exit 1
-	fi
+	emit "$abi" "$nr" "$entry" "$compat"
     done
 ) > "$out"
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 7d057ea..2e8544d 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -36,6 +36,9 @@
 #define stub_execveat sys_execveat
 #define stub_rt_sigreturn sys_rt_sigreturn
 
+#define __SYSCALL_X32(nr, sym)
+#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
+
 #define __SYSCALL_64(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
 #include <asm/syscalls_64.h>
 

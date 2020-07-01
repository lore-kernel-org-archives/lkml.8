Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B51CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB9A2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="otdxNU23";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dwvr+6xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgGAIFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:05:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgGAIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:04:54 -0400
Date:   Wed, 01 Jul 2020 08:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593590691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=946tX4iKOUwH3H3vx3y7VvtSZZroSTJ3cWIecPuGdKw=;
        b=otdxNU23eJUWqZbX0GYnYJQfmQFZvP6+vKspoul9XhiuUEkSyIexVxQohshi/+CgWRjFwx
        GjABkd7DWYBbfxAcLsd7hSUPjODu7l9ZiNpoGEyEuYjcjyiYkRJigZ2w7KoFJMYsoKG5kq
        /DDYC+t/ixQI8MMU6VaJ4PY+CBMJpe5hbfA7O06YNDNAFDMfMWVXz4SHpsddB/HS24tkhr
        VPcmxXyEpg+hVhBcd+cSD5T7514UhZG8ghMgwSgXk5U7PWM4sPwA2Gck87/N50PqSAtwur
        eRv4ZkwloiMc7XgiyjBZ9R7uj4jISs+gCqMUrshAzIb7+OYwMSHIGbLIr+VN9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593590691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=946tX4iKOUwH3H3vx3y7VvtSZZroSTJ3cWIecPuGdKw=;
        b=Dwvr+6xC7zhrFRPZrXCxTJwKnWFKO/JDe0NZCv/2TXSJWUgywD/6I6EGviKo2pE2PEL0R3
        +5Luq15ZPm5toMBA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86: Consolidate and fix get/set_eflags() helpers
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <982ce58ae8dea2f1e57093ee894760e35267e751.1593191971.git.luto@kernel.org>
References: <982ce58ae8dea2f1e57093ee894760e35267e751.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159359069000.4006.14382531019906533863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cced0b24bb545bfe74fea96de84adc23c0146b05
Gitweb:        https://git.kernel.org/tip/cced0b24bb545bfe74fea96de84adc23c0146b05
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:21:16 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 10:00:27 +02:00

selftests/x86: Consolidate and fix get/set_eflags() helpers

There are several copies of get_eflags() and set_eflags() and they all are
buggy.  Consolidate them and fix them.  The fixes are:

Add memory clobbers.  These are probably unnecessary but they make sure
that the compiler doesn't move something past one of these calls when it
shouldn't.

Respect the redzone on x86_64.  There has no failure been observed related
to this, but it's definitely a bug.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/982ce58ae8dea2f1e57093ee894760e35267e751.1593191971.git.luto@kernel.org

---
 tools/testing/selftests/x86/Makefile              |  4 +-
 tools/testing/selftests/x86/helpers.h             | 41 ++++++++++++++-
 tools/testing/selftests/x86/single_step_syscall.c | 17 +------
 tools/testing/selftests/x86/syscall_arg_fault.c   | 21 +-------
 tools/testing/selftests/x86/syscall_nt.c          | 20 +-------
 tools/testing/selftests/x86/test_vsyscall.c       | 15 +-----
 tools/testing/selftests/x86/unwind_vdso.c         | 23 +--------
 7 files changed, 51 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/x86/helpers.h

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5f16821..d2796ea 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -70,10 +70,10 @@ all_64: $(BINARIES_64)
 
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
-$(BINARIES_32): $(OUTPUT)/%_32: %.c
+$(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
 
-$(BINARIES_64): $(OUTPUT)/%_64: %.c
+$(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
 	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
new file mode 100644
index 0000000..f5ff2a2
--- /dev/null
+++ b/tools/testing/selftests/x86/helpers.h
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __SELFTESTS_X86_HELPERS_H
+#define __SELFTESTS_X86_HELPERS_H
+
+#include <asm/processor-flags.h>
+
+static inline unsigned long get_eflags(void)
+{
+	unsigned long eflags;
+
+	asm volatile (
+#ifdef __x86_64__
+		"subq $128, %%rsp\n\t"
+		"pushfq\n\t"
+		"popq %0\n\t"
+		"addq $128, %%rsp"
+#else
+		"pushfl\n\t"
+		"popl %0"
+#endif
+		: "=r" (eflags) :: "memory");
+
+	return eflags;
+}
+
+static inline void set_eflags(unsigned long eflags)
+{
+	asm volatile (
+#ifdef __x86_64__
+		"subq $128, %%rsp\n\t"
+		"pushq %0\n\t"
+		"popfq\n\t"
+		"addq $128, %%rsp"
+#else
+		"pushl %0\n\t"
+		"popfl"
+#endif
+		:: "r" (eflags) : "flags", "memory");
+}
+
+#endif /* __SELFTESTS_X86_HELPERS_H */
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 1063328..120ac74 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -31,6 +31,8 @@
 #include <sys/ptrace.h>
 #include <sys/user.h>
 
+#include "helpers.h"
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -67,21 +69,6 @@ static unsigned char altstack_data[SIGSTKSZ];
 # define INT80_CLOBBERS
 #endif
 
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
-		      : : "rm" (eflags) : "flags");
-}
-
-#define X86_EFLAGS_TF (1UL << 8)
-
 static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index bc0ecc2..5b7abeb 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -15,30 +15,11 @@
 #include <setjmp.h>
 #include <errno.h>
 
-#ifdef __x86_64__
-# define WIDTH "q"
-#else
-# define WIDTH "l"
-#endif
+#include "helpers.h"
 
 /* Our sigaltstack scratch space. */
 static unsigned char altstack_data[SIGSTKSZ];
 
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
-		      : : "rm" (eflags) : "flags");
-}
-
-#define X86_EFLAGS_TF (1UL << 8)
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index 5fc82b9..970e5e1 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -13,29 +13,11 @@
 #include <signal.h>
 #include <err.h>
 #include <sys/syscall.h>
-#include <asm/processor-flags.h>
 
-#ifdef __x86_64__
-# define WIDTH "q"
-#else
-# define WIDTH "l"
-#endif
+#include "helpers.h"
 
 static unsigned int nerrs;
 
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
-		      : : "rm" (eflags) : "flags");
-}
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index a4f4d4c..c41f24b 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -20,6 +20,8 @@
 #include <setjmp.h>
 #include <sys/uio.h>
 
+#include "helpers.h"
+
 #ifdef __x86_64__
 # define VSYS(x) (x)
 #else
@@ -493,21 +495,8 @@ static int test_process_vm_readv(void)
 }
 
 #ifdef __x86_64__
-#define X86_EFLAGS_TF (1UL << 8)
 static volatile sig_atomic_t num_vsyscall_traps;
 
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushfq\n\tpopq %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("pushq %0\n\tpopfq" : : "rm" (eflags) : "flags");
-}
-
 static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t *)ctx_void;
diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 0075ccd..4c311e1 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -11,6 +11,8 @@
 #include <features.h>
 #include <stdio.h>
 
+#include "helpers.h"
+
 #if defined(__GLIBC__) && __GLIBC__ == 2 && __GLIBC_MINOR__ < 16
 
 int main()
@@ -53,27 +55,6 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		err(1, "sigaction");
 }
 
-#ifdef __x86_64__
-# define WIDTH "q"
-#else
-# define WIDTH "l"
-#endif
-
-static unsigned long get_eflags(void)
-{
-	unsigned long eflags;
-	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
-	return eflags;
-}
-
-static void set_eflags(unsigned long eflags)
-{
-	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
-		      : : "rm" (eflags) : "flags");
-}
-
-#define X86_EFLAGS_TF (1UL << 8)
-
 static volatile sig_atomic_t nerrs;
 static unsigned long sysinfo;
 static bool got_sysinfo = false;

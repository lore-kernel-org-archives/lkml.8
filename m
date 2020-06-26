Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182BE2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593192101;
	bh=0KwVrB5+YxkjHmsd7hVC3maB/s6RvbQqHOXJg0RYmMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hl9C8UGal1rpFzigb/OdvlODW26ieW5AYKi4Oz2ZOYAcVry+MJhE7WX+9LBjpSMVr
	 z60zYngkhhvEy8zjhiKbMRy7lq2lrLwQ7IumBOShhMs4i3qrxhNReHGXAI2mb8bTNj
	 jIE/NAMKX/HFMrCk+ZyVSnGBUI8Tv+wxe/8w+oHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgFZRVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgFZRVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:21:25 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417EB2088E;
        Fri, 26 Jun 2020 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192084;
        bh=0KwVrB5+YxkjHmsd7hVC3maB/s6RvbQqHOXJg0RYmMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxhaUmfUqHUyo1vrt2PKppNXpURYkC2hO8fY5LSyUKJuz2GjVTs3aj5/y9Ca1BJF4
         Gq18t52t4XkUwmyeeRvlTO2HJwRclsWkBrtj8qK02PQDzFhVBrMf0f670UwM0qZIR3
         uuSHLdAYGW8sUjLrgfO/NPNiS4Iv8BLxlbAeHiZU=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 6/6] selftests/x86: Consolidate and fix get/set_eflags() helpers
Date:   Fri, 26 Jun 2020 10:21:16 -0700
Message-Id: <982ce58ae8dea2f1e57093ee894760e35267e751.1593191971.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593191971.git.luto@kernel.org>
References: <cover.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had several copies of get_eflags() and set_eflags() and they were
all buggy.  Consolidate them and fix them.  The fixes are:

Add memory clobbers.  These are probably unnecessary but they make
sure sure that the compiler doesn't move something past one of these
calls when it shouldn't.

Respect the redzone on x86_64.  I haven't seen a failure related to
this, but it's definitely a bug.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/Makefile          |  4 +-
 tools/testing/selftests/x86/helpers.h         | 41 +++++++++++++++++++
 .../selftests/x86/single_step_syscall.c       | 17 +-------
 .../testing/selftests/x86/syscall_arg_fault.c | 21 +---------
 tools/testing/selftests/x86/syscall_nt.c      | 20 +--------
 tools/testing/selftests/x86/test_vsyscall.c   | 15 +------
 tools/testing/selftests/x86/unwind_vdso.c     | 23 +----------
 7 files changed, 51 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/x86/helpers.h

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 3ff94575d02d..6703c7906b71 100644
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
index 000000000000..f5ff2a2615df
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
index 1063328e275c..120ac741fe44 100644
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
index bc0ecc2e862e..5b7abebbcbb9 100644
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
index 5fc82b9cebed..970e5e14d96d 100644
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
index a4f4d4cf22c3..c41f24b517f4 100644
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
index 0075ccd65407..4c311e1af4c7 100644
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
-- 
2.25.4


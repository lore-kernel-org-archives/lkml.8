Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A72C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954A420781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgCUPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:31:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38902 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbgCUPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg56-00050i-OI; Sat, 21 Mar 2020 16:30:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E83E1C22E4;
        Sat, 21 Mar 2020 16:30:36 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:35 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Move max syscall number calculation to
 syscallhdr.sh
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-9-brgerst@gmail.com>
References: <20200313195144.164260-9-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463590.28353.3002123379230133878.tip-bot2@tip-bot2>
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

Commit-ID:     0872098804b5f44bab91f80b6df55df32894fee3
Gitweb:        https://git.kernel.org/tip/0872098804b5f44bab91f80b6df55df32894fee3
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:34 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:21 +01:00

x86/entry: Move max syscall number calculation to syscallhdr.sh

Instead of using an array in asm-offsets to calculate the max syscall
number, calculate it when writing out the syscall headers.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200313195144.164260-9-brgerst@gmail.com

---
 arch/x86/entry/syscall_32.c                 |  6 +--
 arch/x86/entry/syscall_64.c                 |  2 +-
 arch/x86/entry/syscall_x32.c                |  6 +--
 arch/x86/entry/syscalls/syscallhdr.sh       |  7 ++++-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |  1 +-
 arch/x86/include/asm/syscall.h              |  3 +--
 arch/x86/include/asm/unistd.h               |  7 ++++-
 arch/x86/kernel/asm-offsets_32.c            |  9 +-----
 arch/x86/kernel/asm-offsets_64.c            | 36 +--------------------
 arch/x86/um/sys_call_table_32.c             |  2 +-
 arch/x86/um/sys_call_table_64.c             |  2 +-
 arch/x86/um/user-offsets.c                  | 15 +--------
 12 files changed, 24 insertions(+), 72 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 7d17b3a..3207cf6 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -4,7 +4,7 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #ifdef CONFIG_IA32_EMULATION
@@ -22,11 +22,11 @@ extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned lon
 
 #define __SYSCALL_I386(nr, sym, qual) [nr] = sym,
 
-__visible const sys_call_ptr_t ia32_sys_call_table[__NR_syscall_compat_max+1] = {
+__visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_syscall_compat_max] = &__sys_ni_syscall,
+	[0 ... __NR_ia32_syscall_max] = &__sys_ni_syscall,
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index efb85c6..5dc6846 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -5,7 +5,7 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL_X32(nr, sym, qual)
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index d144ced..95abb6d 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -5,7 +5,7 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL_64(nr, sym, qual)
@@ -16,11 +16,11 @@
 
 #define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
 
-asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max+1] = {
+asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_syscall_x32_max] = &__x64_sys_ni_syscall,
+	[0 ... __NR_x32_syscall_max] = &__x64_sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
diff --git a/arch/x86/entry/syscalls/syscallhdr.sh b/arch/x86/entry/syscalls/syscallhdr.sh
index 12fbbcf..cc1e638 100644
--- a/arch/x86/entry/syscalls/syscallhdr.sh
+++ b/arch/x86/entry/syscalls/syscallhdr.sh
@@ -15,14 +15,21 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
     echo "#define ${fileguard} 1"
     echo ""
 
+    max=0
     while read nr abi name entry ; do
 	if [ -z "$offset" ]; then
 	    echo "#define __NR_${prefix}${name} $nr"
 	else
 	    echo "#define __NR_${prefix}${name} ($offset + $nr)"
         fi
+
+	max=$nr
     done
 
     echo ""
+    echo "#ifdef __KERNEL__"
+    echo "#define __NR_${prefix}syscall_max $max"
+    echo "#endif"
+    echo ""
     echo "#endif /* ${fileguard} */"
 ) > "$out"
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 9242b28..1e82bd4 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -13,6 +13,7 @@
  */
 #undef CONFIG_64BIT
 #undef CONFIG_X86_64
+#undef CONFIG_COMPAT
 #undef CONFIG_PGTABLE_LEVELS
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 8db3fdb..1ef8d7b 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -13,7 +13,6 @@
 #include <uapi/linux/audit.h>
 #include <linux/sched.h>
 #include <linux/err.h>
-#include <asm/asm-offsets.h>	/* For NR_syscalls */
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
@@ -28,8 +27,6 @@ extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
 #define ia32_sys_call_table sys_call_table
-#define __NR_syscall_compat_max __NR_syscall_max
-#define IA32_NR_syscalls NR_syscalls
 #endif
 
 #if defined(CONFIG_IA32_EMULATION)
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index a7dd080..c1c3d31 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -13,10 +13,13 @@
 #  define __ARCH_WANT_SYS_OLD_MMAP
 #  define __ARCH_WANT_SYS_OLD_SELECT
 
+#  define __NR_ia32_syscall_max __NR_syscall_max
+
 # else
 
 #  include <asm/unistd_64.h>
 #  include <asm/unistd_64_x32.h>
+#  include <asm/unistd_32_ia32.h>
 #  define __ARCH_WANT_SYS_TIME
 #  define __ARCH_WANT_SYS_UTIME
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64
@@ -26,6 +29,10 @@
 
 # endif
 
+# define NR_syscalls (__NR_syscall_max + 1)
+# define X32_NR_syscalls (__NR_x32_syscall_max + 1)
+# define IA32_NR_syscalls (__NR_ia32_syscall_max + 1)
+
 # define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 82826f2..0dcac42 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -5,11 +5,6 @@
 
 #include <asm/ucontext.h>
 
-#define __SYSCALL_I386(nr, sym, qual) [nr] = 1,
-static char syscalls[] = {
-#include <asm/syscalls_32.h>
-};
-
 /* workaround for a warning with -Wmissing-prototypes */
 void foo(void);
 
@@ -60,8 +55,4 @@ void foo(void)
 	BLANK();
 	OFFSET(stack_canary_offset, stack_canary, canary);
 #endif
-
-	BLANK();
-	DEFINE(__NR_syscall_max, sizeof(syscalls) - 1);
-	DEFINE(NR_syscalls, sizeof(syscalls));
 }
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 24d2fde..c2a4701 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -5,30 +5,6 @@
 
 #include <asm/ia32.h>
 
-#define __SYSCALL_64(nr, sym, qual) [nr] = 1,
-#define __SYSCALL_X32(nr, sym, qual)
-static char syscalls_64[] = {
-#include <asm/syscalls_64.h>
-};
-#undef __SYSCALL_64
-#undef __SYSCALL_X32
-
-#ifdef CONFIG_X86_X32_ABI
-#define __SYSCALL_64(nr, sym, qual)
-#define __SYSCALL_X32(nr, sym, qual) [nr] = 1,
-static char syscalls_x32[] = {
-#include <asm/syscalls_64.h>
-};
-#undef __SYSCALL_64
-#undef __SYSCALL_X32
-#endif
-
-#define __SYSCALL_I386(nr, sym, qual) [nr] = 1,
-static char syscalls_ia32[] = {
-#include <asm/syscalls_32.h>
-};
-#undef __SYSCALL_I386
-
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 #include <asm/kvm_para.h>
 #endif
@@ -90,17 +66,5 @@ int main(void)
 	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
 	BLANK();
 #endif
-
-	DEFINE(__NR_syscall_max, sizeof(syscalls_64) - 1);
-	DEFINE(NR_syscalls, sizeof(syscalls_64));
-
-#ifdef CONFIG_X86_X32_ABI
-	DEFINE(__NR_syscall_x32_max, sizeof(syscalls_x32) - 1);
-	DEFINE(X32_NR_syscalls, sizeof(syscalls_x32));
-#endif
-
-	DEFINE(__NR_syscall_compat_max, sizeof(syscalls_ia32) - 1);
-	DEFINE(IA32_NR_syscalls, sizeof(syscalls_ia32));
-
 	return 0;
 }
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 9649b5a..a0d75c5 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -7,7 +7,7 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <generated/user_constants.h>
+#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __NO_STUBS
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index c8bc7fb..fa97740 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -7,7 +7,7 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <generated/user_constants.h>
+#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __NO_STUBS
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index 5b37b7f..c51dd83 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -9,18 +9,6 @@
 #include <linux/ptrace.h>
 #include <asm/types.h>
 
-#ifdef __i386__
-#define __SYSCALL_I386(nr, sym, qual) [nr] = 1,
-static char syscalls[] = {
-#include <asm/syscalls_32.h>
-};
-#else
-#define __SYSCALL_64(nr, sym, qual) [nr] = 1,
-static char syscalls[] = {
-#include <asm/syscalls_64.h>
-};
-#endif
-
 #define DEFINE(sym, val) \
 	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
 
@@ -94,7 +82,4 @@ void foo(void)
 	DEFINE(UM_PROT_READ, PROT_READ);
 	DEFINE(UM_PROT_WRITE, PROT_WRITE);
 	DEFINE(UM_PROT_EXEC, PROT_EXEC);
-
-	DEFINE(__NR_syscall_max, sizeof(syscalls) - 1);
-	DEFINE(NR_syscalls, sizeof(syscalls));
 }

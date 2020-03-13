Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F72C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5A4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJYWlSa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCMTxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:53:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33479 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgCMTwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id p62so14715149qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVyWwFJqViC83OcoKVFg7qqvJmczpS8nLV1bfH3wEfY=;
        b=FJYWlSa0iFHDmYPqCNHxVXM60K0i+L7YdQWHwadM7xZtSRF426AYbgsezNsvccCfnk
         VVOprL2+3OqKYw3zMxNdr1GeKhUI/5gufWsAdCwH4zET5d6TtrMB0FTNmS8pb81LGhc3
         RMzEtXH9ITFgmlqpRKhSNZEyj25E5DRr/YpZUiCdhlwXhyBWW8lkDLXjw0gtESLVgCIT
         iO/ugnjFQLucaq3uETvTY15+wQPQUUedU8uOML8YheRjunM6KJkrpa7e8w1DTtqXVUQc
         OGuOYRqLl+PBXqORVKznx0c/AjGq1lxJJHILpbgGhniqiQ1kRbThEAnPMv0vMlQKauUD
         PIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVyWwFJqViC83OcoKVFg7qqvJmczpS8nLV1bfH3wEfY=;
        b=ICbr7YvUi9ZDOw2FNRxYuNKl3m7EbEN3g4t8bqp7yfD5ENPAIpADwSVc6fr+ikI1Il
         TtWVCrdx0IOUodMXyuZvxxUdxEIFlajgUDaniYz39xbFxt00Umt46ugWIdaRN0MDDPRg
         uE4cjDSsYovSHTNSUjq2nA2NTWBcgxLBrhkpESmG12v55c5M5Dzhg675jAZUjxqtpDBX
         ZA1qU8vNll8XBwH3QuCIl9TRgDenpoDaCGqunJ+Hf/Cqe8vOIujftt5U26MuMeBD7B9N
         nZFpq049fLr6RCTY8E60deUDpWlbqCL5G9Fvej4DfKOvgDHh+G97ao061EwWrpSkXV6b
         jbAA==
X-Gm-Message-State: ANhLgQ0quF0JwMl0dztRSN7jr60Guvi7QdRnxBsw0sXsIS+45tmXQHW5
        0V4gcEM2eq7rpmBW+cWYbPskd8s=
X-Google-Smtp-Source: ADFU+vug9MaMcE8moTva0rkR+CQWVRmPvewhPHJUYwyiFS6c4B0S9Pkh2/odlwFzBHdH9SN1nDH+FQ==
X-Received: by 2002:a37:9dc9:: with SMTP id g192mr14943877qke.50.1584129139858;
        Fri, 13 Mar 2020 12:52:19 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:19 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 08/18] x86: Move max syscall number calculation to syscallhdr.sh
Date:   Fri, 13 Mar 2020 15:51:34 -0400
Message-Id: <20200313195144.164260-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using an array in asm-offsets to calculate the max syscall
number, calculate it when writing out the syscall headers.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/syscall_32.c                 |  6 ++--
 arch/x86/entry/syscall_64.c                 |  2 +-
 arch/x86/entry/syscall_x32.c                |  6 ++--
 arch/x86/entry/syscalls/syscallhdr.sh       |  7 ++++
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |  1 +
 arch/x86/include/asm/syscall.h              |  3 --
 arch/x86/include/asm/unistd.h               |  7 ++++
 arch/x86/kernel/asm-offsets_32.c            |  9 ------
 arch/x86/kernel/asm-offsets_64.c            | 36 ---------------------
 arch/x86/um/sys_call_table_32.c             |  2 +-
 arch/x86/um/sys_call_table_64.c             |  2 +-
 arch/x86/um/user-offsets.c                  | 15 ---------
 12 files changed, 24 insertions(+), 72 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 7d17b3addbbb..3207cf685cde 100644
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
index efb85c6dce13..5dc6846979df 100644
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
index d144ced7f582..95abb6da0ecc 100644
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
index 12fbbcfe7ef3..cc1e63857427 100644
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
 
+    echo ""
+    echo "#ifdef __KERNEL__"
+    echo "#define __NR_${prefix}syscall_max $max"
+    echo "#endif"
     echo ""
     echo "#endif /* ${fileguard} */"
 ) > "$out"
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 9242b28418d5..1e82bd43286c 100644
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
index d20ffc518cf4..f4d010d0fa30 100644
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
index a7dd080749ce..c1c3d31b15c0 100644
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
index 2b4256ebe86e..6e043f295a60 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -7,11 +7,6 @@
 
 #include <asm/ucontext.h>
 
-#define __SYSCALL_I386(nr, sym, qual) [nr] = 1,
-static char syscalls[] = {
-#include <asm/syscalls_32.h>
-};
-
 /* workaround for a warning with -Wmissing-prototypes */
 void foo(void);
 
@@ -63,10 +58,6 @@ void foo(void)
 	OFFSET(stack_canary_offset, stack_canary, canary);
 #endif
 
-	BLANK();
-	DEFINE(__NR_syscall_max, sizeof(syscalls) - 1);
-	DEFINE(NR_syscalls, sizeof(syscalls));
-
 	BLANK();
 	DEFINE(EFI_svam, offsetof(efi_runtime_services_t, set_virtual_address_map));
 }
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 24d2fde30d00..c2a47016f243 100644
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
index 9649b5ad2ca2..a0d75c560030 100644
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
index c8bc7fb8cbd6..fa97740badd5 100644
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
index 5b37b7f952dd..c51dd8363d25 100644
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
-- 
2.24.1


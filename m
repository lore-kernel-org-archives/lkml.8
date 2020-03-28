Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DFFC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36C520716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgC1LGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:06:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55629 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgC1LGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:06:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9IC-0003ur-Ku; Sat, 28 Mar 2020 12:06:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3DA021C0470;
        Sat, 28 Mar 2020 12:06:20 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:06:19 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: arch_futex_atomic_op_inuser() calling
 conventions change
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539357984.28353.6725865463342062355.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a08971e9488d12a10a46eb433612229767b61fd5
Gitweb:        https://git.kernel.org/tip/a08971e9488d12a10a46eb433612229767b61fd5
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sun, 16 Feb 2020 10:17:27 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Fri, 27 Mar 2020 23:58:51 -04:00

futex: arch_futex_atomic_op_inuser() calling conventions change

Move access_ok() in and pagefault_enable()/pagefault_disable() out.
Mechanical conversion only - some instances don't really need
a separate access_ok() at all (e.g. the ones only using
get_user()/put_user(), or architectures where access_ok()
is always true); we'll deal with that in followups.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/futex.h      | 5 ++---
 arch/arc/include/asm/futex.h        | 5 +++--
 arch/arm/include/asm/futex.h        | 5 +++--
 arch/arm64/include/asm/futex.h      | 5 ++---
 arch/hexagon/include/asm/futex.h    | 5 ++---
 arch/ia64/include/asm/futex.h       | 5 ++---
 arch/microblaze/include/asm/futex.h | 5 ++---
 arch/mips/include/asm/futex.h       | 5 ++---
 arch/nds32/include/asm/futex.h      | 6 ++----
 arch/openrisc/include/asm/futex.h   | 5 ++---
 arch/parisc/include/asm/futex.h     | 5 +++--
 arch/powerpc/include/asm/futex.h    | 5 ++---
 arch/riscv/include/asm/futex.h      | 5 ++---
 arch/s390/include/asm/futex.h       | 4 ++--
 arch/sh/include/asm/futex.h         | 5 ++---
 arch/sparc/include/asm/futex_64.h   | 6 ++----
 arch/x86/include/asm/futex.h        | 5 ++---
 arch/xtensa/include/asm/futex.h     | 5 ++---
 include/asm-generic/futex.h         | 4 ++--
 kernel/futex.c                      | 5 ++---
 20 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/arch/alpha/include/asm/futex.h b/arch/alpha/include/asm/futex.h
index bfd3c01..da67afd 100644
--- a/arch/alpha/include/asm/futex.h
+++ b/arch/alpha/include/asm/futex.h
@@ -31,7 +31,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -53,8 +54,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/arc/include/asm/futex.h b/arch/arc/include/asm/futex.h
index 9d0d070..607d1c1 100644
--- a/arch/arc/include/asm/futex.h
+++ b/arch/arc/include/asm/futex.h
@@ -75,10 +75,12 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 #ifndef CONFIG_ARC_HAS_LLSC
 	preempt_disable();	/* to guarantee atomic r-m-w of futex op */
 #endif
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -101,7 +103,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
 #ifndef CONFIG_ARC_HAS_LLSC
 	preempt_enable();
 #endif
diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 83c391b..e133da3 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -134,10 +134,12 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret, tmp;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 #ifndef CONFIG_SMP
 	preempt_disable();
 #endif
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -159,7 +161,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
 #ifndef CONFIG_SMP
 	preempt_enable();
 #endif
diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 6cc26a1..97f6a63 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -48,7 +48,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 	int oldval = 0, ret, tmp;
 	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
-	pagefault_disable();
+	if (!access_ok(_uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -75,8 +76,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/hexagon/include/asm/futex.h b/arch/hexagon/include/asm/futex.h
index 0191f7c..6b9c554 100644
--- a/arch/hexagon/include/asm/futex.h
+++ b/arch/hexagon/include/asm/futex.h
@@ -36,7 +36,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -62,8 +63,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/ia64/include/asm/futex.h b/arch/ia64/include/asm/futex.h
index 2e106d4..1db26b4 100644
--- a/arch/ia64/include/asm/futex.h
+++ b/arch/ia64/include/asm/futex.h
@@ -50,7 +50,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -74,8 +75,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/microblaze/include/asm/futex.h b/arch/microblaze/include/asm/futex.h
index 8c90357..86131ed 100644
--- a/arch/microblaze/include/asm/futex.h
+++ b/arch/microblaze/include/asm/futex.h
@@ -34,7 +34,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -56,8 +57,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 1102207..2bf8f60 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -89,7 +89,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -116,8 +117,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
index 5213c65..4223f47 100644
--- a/arch/nds32/include/asm/futex.h
+++ b/arch/nds32/include/asm/futex.h
@@ -66,8 +66,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("move	%0, %3", ret, oldval, tmp, uaddr,
@@ -93,8 +93,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/openrisc/include/asm/futex.h b/arch/openrisc/include/asm/futex.h
index fe894e6..865e9cd 100644
--- a/arch/openrisc/include/asm/futex.h
+++ b/arch/openrisc/include/asm/futex.h
@@ -35,7 +35,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -57,8 +58,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
index d2c3e41..c10cc90 100644
--- a/arch/parisc/include/asm/futex.h
+++ b/arch/parisc/include/asm/futex.h
@@ -39,8 +39,10 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	int oldval, ret;
 	u32 tmp;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 	_futex_spin_lock_irqsave(uaddr, &flags);
-	pagefault_disable();
 
 	ret = -EFAULT;
 	if (unlikely(get_user(oldval, uaddr) != 0))
@@ -73,7 +75,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -EFAULT;
 
 out_pagefault_enable:
-	pagefault_enable();
 	_futex_spin_unlock_irqrestore(uaddr, &flags);
 
 	if (!ret)
diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index bc7d9d0..f187bb5 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -35,8 +35,9 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	allow_read_write_user(uaddr, uaddr, sizeof(*uaddr));
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -58,8 +59,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	*oval = oldval;
 
 	prevent_read_write_user(uaddr, uaddr, sizeof(*uaddr));
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index fdfaf7f..1b00bad 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -46,7 +46,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret = 0;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -73,8 +74,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/s390/include/asm/futex.h b/arch/s390/include/asm/futex.h
index 5e97a43..ed965c3 100644
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -28,8 +28,9 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	int oldval = 0, newval, ret;
 	mm_segment_t old_fs;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	old_fs = enable_sacf_uaccess();
-	pagefault_disable();
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("lr %2,%5\n",
@@ -54,7 +55,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	default:
 		ret = -ENOSYS;
 	}
-	pagefault_enable();
 	disable_sacf_uaccess(old_fs);
 
 	if (!ret)
diff --git a/arch/sh/include/asm/futex.h b/arch/sh/include/asm/futex.h
index 3190ec8..324fa68 100644
--- a/arch/sh/include/asm/futex.h
+++ b/arch/sh/include/asm/futex.h
@@ -34,7 +34,8 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 	u32 oldval, newval, prev;
 	int ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	do {
 		ret = get_user(oldval, uaddr);
@@ -67,8 +68,6 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 		ret = futex_atomic_cmpxchg_inatomic(&prev, uaddr, oldval, newval);
 	} while (!ret && prev != oldval);
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/sparc/include/asm/futex_64.h b/arch/sparc/include/asm/futex_64.h
index 0865ce7..84fffaa 100644
--- a/arch/sparc/include/asm/futex_64.h
+++ b/arch/sparc/include/asm/futex_64.h
@@ -35,11 +35,11 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret, tem;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	if (unlikely((((unsigned long) uaddr) & 0x3UL)))
 		return -EINVAL;
 
-	pagefault_disable();
-
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_cas_op("mov\t%4, %1", ret, oldval, uaddr, oparg);
@@ -60,8 +60,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 13c83fe..6bcd1c1 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -47,7 +47,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret, tem;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -70,8 +71,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
index 9646110..a1a27b2 100644
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -72,7 +72,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 #if XCHAL_HAVE_S32C1I || XCHAL_HAVE_EXCLUSIVE
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -99,8 +100,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 02970b1..3eab7ba 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -33,8 +33,9 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 	int oldval, ret;
 	u32 tmp;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	preempt_disable();
-	pagefault_disable();
 
 	ret = -EFAULT;
 	if (unlikely(get_user(oldval, uaddr) != 0))
@@ -67,7 +68,6 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 		ret = -EFAULT;
 
 out_pagefault_enable:
-	pagefault_enable();
 	preempt_enable();
 
 	if (ret == 0)
diff --git a/kernel/futex.c b/kernel/futex.c
index 0cf84c8..7fdd2c9 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1723,10 +1723,9 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 		oparg = 1 << oparg;
 	}
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
-
+	pagefault_disable();
 	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
+	pagefault_enable();
 	if (ret)
 		return ret;
 

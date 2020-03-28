Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B54C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FC620723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgC1LGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:06:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55617 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgC1LGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:06:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9IA-0003tg-NY; Sat, 28 Mar 2020 12:06:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4F66A1C0470;
        Sat, 28 Mar 2020 12:06:18 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:06:17 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86: convert arch_futex_atomic_op_inuser() to
 user_access_begin/user_access_end()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539357794.28353.3893609451334827069.tip-bot2@tip-bot2>
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

Commit-ID:     0ec33c0171a138bedc1a39f4fd70455416dca926
Gitweb:        https://git.kernel.org/tip/0ec33c0171a138bedc1a39f4fd70455416dca926
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sun, 16 Feb 2020 13:10:42 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Fri, 27 Mar 2020 23:58:53 -04:00

x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()

Lift stac/clac pairs from __futex_atomic_op{1,2} into arch_futex_atomic_op_inuser(),
fold them with access_ok() in there.  The switch in arch_futex_atomic_op_inuser()
is what has required the previous (objtool) commit...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/futex.h | 62 ++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 6bcd1c1..53c07ab 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -12,26 +12,33 @@
 #include <asm/processor.h>
 #include <asm/smap.h>
 
-#define __futex_atomic_op1(insn, ret, oldval, uaddr, oparg)	\
-	asm volatile("\t" ASM_STAC "\n"				\
-		     "1:\t" insn "\n"				\
-		     "2:\t" ASM_CLAC "\n"			\
+#define unsafe_atomic_op1(insn, oval, uaddr, oparg, label)	\
+do {								\
+	int oldval = 0, ret;					\
+	asm volatile("1:\t" insn "\n"				\
+		     "2:\n"					\
 		     "\t.section .fixup,\"ax\"\n"		\
 		     "3:\tmov\t%3, %1\n"			\
 		     "\tjmp\t2b\n"				\
 		     "\t.previous\n"				\
 		     _ASM_EXTABLE_UA(1b, 3b)			\
 		     : "=r" (oldval), "=r" (ret), "+m" (*uaddr)	\
-		     : "i" (-EFAULT), "0" (oparg), "1" (0))
+		     : "i" (-EFAULT), "0" (oparg), "1" (0));	\
+	if (ret)						\
+		goto label;					\
+	*oval = oldval;						\
+} while(0)
 
-#define __futex_atomic_op2(insn, ret, oldval, uaddr, oparg)	\
-	asm volatile("\t" ASM_STAC "\n"				\
-		     "1:\tmovl	%2, %0\n"			\
+
+#define unsafe_atomic_op2(insn, oval, uaddr, oparg, label)	\
+do {								\
+	int oldval = 0, ret, tem;				\
+	asm volatile("1:\tmovl	%2, %0\n"			\
 		     "\tmovl\t%0, %3\n"				\
 		     "\t" insn "\n"				\
 		     "2:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
 		     "\tjnz\t1b\n"				\
-		     "3:\t" ASM_CLAC "\n"			\
+		     "3:\n"					\
 		     "\t.section .fixup,\"ax\"\n"		\
 		     "4:\tmov\t%5, %1\n"			\
 		     "\tjmp\t3b\n"				\
@@ -40,41 +47,44 @@
 		     _ASM_EXTABLE_UA(2b, 4b)			\
 		     : "=&a" (oldval), "=&r" (ret),		\
 		       "+m" (*uaddr), "=&r" (tem)		\
-		     : "r" (oparg), "i" (-EFAULT), "1" (0))
+		     : "r" (oparg), "i" (-EFAULT), "1" (0));	\
+	if (ret)						\
+		goto label;					\
+	*oval = oldval;						\
+} while(0)
 
-static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
-	int oldval = 0, ret, tem;
-
-	if (!access_ok(uaddr, sizeof(u32)))
+	if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op1("xchgl %0, %2", ret, oldval, uaddr, oparg);
+		unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
 		break;
 	case FUTEX_OP_ADD:
-		__futex_atomic_op1(LOCK_PREFIX "xaddl %0, %2", ret, oldval,
-				   uaddr, oparg);
+		unsafe_atomic_op1(LOCK_PREFIX "xaddl %0, %2", oval,
+				   uaddr, oparg, Efault);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op2("orl %4, %3", ret, oldval, uaddr, oparg);
+		unsafe_atomic_op2("orl %4, %3", oval, uaddr, oparg, Efault);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op2("andl %4, %3", ret, oldval, uaddr, ~oparg);
+		unsafe_atomic_op2("andl %4, %3", oval, uaddr, ~oparg, Efault);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op2("xorl %4, %3", ret, oldval, uaddr, oparg);
+		unsafe_atomic_op2("xorl %4, %3", oval, uaddr, oparg, Efault);
 		break;
 	default:
-		ret = -ENOSYS;
+		user_access_end();
+		return -ENOSYS;
 	}
-
-	if (!ret)
-		*oval = oldval;
-
-	return ret;
+	user_access_end();
+	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 
 static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,

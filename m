Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC8C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2723208E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC0C2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:28:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47830 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgC0C2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:28:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHejd-003hFx-Qu; Fri, 27 Mar 2020 02:28:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 5/8] x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
Date:   Fri, 27 Mar 2020 02:28:33 +0000
Message-Id: <20200327022836.881203-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
References: <x86: unsafe_put-style macro for sigmask>
 <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Lift stac/clac pairs from __futex_atomic_op{1,2} into arch_futex_atomic_op_inuser(),
fold them with access_ok() in there.  The switch in arch_futex_atomic_op_inuser()
is what has required the previous (objtool) commit...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/futex.h | 62 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 6bcd1c1486d9..53c07ab63762 100644
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
-- 
2.11.0


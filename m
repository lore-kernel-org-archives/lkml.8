Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C6CC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD220663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCWSva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:51:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46950 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgCWSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:51:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGSAZ-0013hd-Iu; Mon, 23 Mar 2020 18:51:27 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
Date:   Mon, 23 Mar 2020 18:51:25 +0000
Message-Id: <20200323185127.252501-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
References: <20200323185057.GE23230@ZenIV.linux.org.uk>
 <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
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
 arch/x86/include/asm/futex.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 6bcd1c1486d9..cf6e57fb5b22 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -13,9 +13,8 @@
 #include <asm/smap.h>
 
 #define __futex_atomic_op1(insn, ret, oldval, uaddr, oparg)	\
-	asm volatile("\t" ASM_STAC "\n"				\
-		     "1:\t" insn "\n"				\
-		     "2:\t" ASM_CLAC "\n"			\
+	asm volatile("1:\t" insn "\n"				\
+		     "2:\n"					\
 		     "\t.section .fixup,\"ax\"\n"		\
 		     "3:\tmov\t%3, %1\n"			\
 		     "\tjmp\t2b\n"				\
@@ -25,13 +24,12 @@
 		     : "i" (-EFAULT), "0" (oparg), "1" (0))
 
 #define __futex_atomic_op2(insn, ret, oldval, uaddr, oparg)	\
-	asm volatile("\t" ASM_STAC "\n"				\
-		     "1:\tmovl	%2, %0\n"			\
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
@@ -42,12 +40,12 @@
 		       "+m" (*uaddr), "=&r" (tem)		\
 		     : "r" (oparg), "i" (-EFAULT), "1" (0))
 
-static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
+static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
 	int oldval = 0, ret, tem;
 
-	if (!access_ok(uaddr, sizeof(u32)))
+	if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 
 	switch (op) {
@@ -70,6 +68,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	default:
 		ret = -ENOSYS;
 	}
+	user_access_end();
 
 	if (!ret)
 		*oval = oldval;
-- 
2.11.0


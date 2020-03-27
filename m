Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB87C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E79120B80
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgC0C2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:28:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47832 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgC0C2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:28:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHejd-003hG3-Up; Fri, 27 Mar 2020 02:28:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 6/8] x86: don't reload after cmpxchg in unsafe_atomic_op2() loop
Date:   Fri, 27 Mar 2020 02:28:34 +0000
Message-Id: <20200327022836.881203-6-viro@ZenIV.linux.org.uk>
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

lock cmpxchg leaves the current value in eax; no need to reload it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/futex.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 53c07ab63762..d5d36f408ad0 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -34,17 +34,17 @@ do {								\
 do {								\
 	int oldval = 0, ret, tem;				\
 	asm volatile("1:\tmovl	%2, %0\n"			\
-		     "\tmovl\t%0, %3\n"				\
+		     "2:\tmovl\t%0, %3\n"			\
 		     "\t" insn "\n"				\
-		     "2:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
-		     "\tjnz\t1b\n"				\
-		     "3:\n"					\
+		     "3:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
+		     "\tjnz\t2b\n"				\
+		     "4:\n"					\
 		     "\t.section .fixup,\"ax\"\n"		\
-		     "4:\tmov\t%5, %1\n"			\
+		     "5:\tmov\t%5, %1\n"			\
 		     "\tjmp\t3b\n"				\
 		     "\t.previous\n"				\
-		     _ASM_EXTABLE_UA(1b, 4b)			\
-		     _ASM_EXTABLE_UA(2b, 4b)			\
+		     _ASM_EXTABLE_UA(1b, 5b)			\
+		     _ASM_EXTABLE_UA(3b, 5b)			\
 		     : "=&a" (oldval), "=&r" (ret),		\
 		       "+m" (*uaddr), "=&r" (tem)		\
 		     : "r" (oparg), "i" (-EFAULT), "1" (0));	\
-- 
2.11.0


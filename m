Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A15C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6668F22D07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IRTqSuaH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qf7anx6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgGWKnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:43:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgGWKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:44 -0400
Date:   Thu, 23 Jul 2020 10:43:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EncVA8AiNAS2JwxkkKojkF7tJXBLbz3fsL12OjBoWpY=;
        b=IRTqSuaHd0txxuCDns1RJ2eT4kjMs3on+bqtl5/HnaUoekZzaZiF8ONEJx8MHI+qvmiKfI
        GO6bFzW4CXXRX/H5bdPIXXJNwp+0qVZhmbbi1fpeWhQJjm1ci2Uwm4GYPvLWjrAHF8QNVw
        nC2UM2kxuZaTLeqMOfn1YaVU25oO9/nUPktqm5yaoDSynyKTraISMWPOG84dZ3C+sKUMpO
        XeN+hjDYT1XBQPTx3DupgAc9AEYUIw8z/LNGCsVuvln35G5+R/pNvrCFU6d2PLkAn4zPli
        oWFOuBAZMD23oRczV+0ySAaYYdvvX5LSknH1jJzYTJuYaVgxYj5WO0OQG3vykg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EncVA8AiNAS2JwxkkKojkF7tJXBLbz3fsL12OjBoWpY=;
        b=Qf7anx6ZtYRGcO0CpG4CrnV99Etc8xMfT8sQFbayKrssXS/6yczEuXm733uc3JyebGKlUO
        g8j+mHq4v14pD+Cg==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Clean up percpu_xchg_op()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-8-ndesaulniers@google.com>
References: <20200720204925.3654302-8-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102123.4006.9369357791516740311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     73ca542fbabb68deaa90130a8153cab1fa8288fe
Gitweb:        https://git.kernel.org/tip/73ca542fbabb68deaa90130a8153cab1fa8288fe
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:21 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:41 +02:00

x86/percpu: Clean up percpu_xchg_op()

The core percpu macros already have a switch on the data size, so the switch
in the x86 code is redundant and produces more dead code.

Also use appropriate types for the width of the instructions.  This avoids
errors when compiling with Clang.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
Link: https://lkml.kernel.org/r/20200720204925.3654302-8-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 61 ++++++++++------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 0776a11..ac6d7e7 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -215,46 +215,21 @@ do {									\
  * expensive due to the implied lock prefix.  The processor cannot prefetch
  * cachelines if xchg is used.
  */
-#define percpu_xchg_op(qual, var, nval)					\
+#define percpu_xchg_op(size, qual, _var, _nval)				\
 ({									\
-	typeof(var) pxo_ret__;						\
-	typeof(var) pxo_new__ = (nval);					\
-	switch (sizeof(var)) {						\
-	case 1:								\
-		asm qual ("\n\tmov "__percpu_arg(1)",%%al"		\
-		    "\n1:\tcmpxchgb %2, "__percpu_arg(1)		\
-		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
-			    : "q" (pxo_new__)				\
-			    : "memory");				\
-		break;							\
-	case 2:								\
-		asm qual ("\n\tmov "__percpu_arg(1)",%%ax"		\
-		    "\n1:\tcmpxchgw %2, "__percpu_arg(1)		\
-		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
-			    : "r" (pxo_new__)				\
-			    : "memory");				\
-		break;							\
-	case 4:								\
-		asm qual ("\n\tmov "__percpu_arg(1)",%%eax"		\
-		    "\n1:\tcmpxchgl %2, "__percpu_arg(1)		\
-		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
-			    : "r" (pxo_new__)				\
-			    : "memory");				\
-		break;							\
-	case 8:								\
-		asm qual ("\n\tmov "__percpu_arg(1)",%%rax"		\
-		    "\n1:\tcmpxchgq %2, "__percpu_arg(1)		\
-		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
-			    : "r" (pxo_new__)				\
-			    : "memory");				\
-		break;							\
-	default: __bad_percpu_size();					\
-	}								\
-	pxo_ret__;							\
+	__pcpu_type_##size pxo_old__;					\
+	__pcpu_type_##size pxo_new__ = __pcpu_cast_##size(_nval);	\
+	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]),		\
+				    "%[oval]")				\
+		  "\n1:\t"						\
+		  __pcpu_op2_##size("cmpxchg", "%[nval]",		\
+				    __percpu_arg([var]))		\
+		  "\n\tjnz 1b"						\
+		  : [oval] "=&a" (pxo_old__),				\
+		    [var] "+m" (_var)					\
+		  : [nval] __pcpu_reg_##size(, pxo_new__)		\
+		  : "memory");						\
+	(typeof(_var))(unsigned long) pxo_old__;			\
 })
 
 /*
@@ -354,9 +329,9 @@ do {									\
 #define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
 #define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
 #define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
-#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
-#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
-#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(1, volatile, pcp, nval)
+#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(2, volatile, pcp, nval)
+#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(4, volatile, pcp, nval)
 
 #define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
 #define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
@@ -409,7 +384,7 @@ do {									\
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 
 /*

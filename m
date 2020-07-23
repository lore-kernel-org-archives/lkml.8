Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04281C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45322086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vPDlNl22";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XneCMj83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgGWKn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:43:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57142 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgGWKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:47 -0400
Date:   Thu, 23 Jul 2020 10:43:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNshtPRKBY8CGtSMUHKwUEgpyLO2ktu1ONkl5+2sp7M=;
        b=vPDlNl227ougu4/z2obb7w08NIOsXS3DPN1CP2DLdf9KF/AG/9SEML+rEiIihvbK+eNL7z
        bYHO2QABpW1/0cksp2iupRZOX0uht1/mdQcvt1ITAazXkE53CFvO6sI2WdncA6q1lxDuSa
        XKMjly0GtvR/LaBvwqFSYHPblHhybTGmZo0N2rVAdGEm6LvN4g4i/05Pakd3lcXcuUOU+G
        oKw+uWu027UrIcKTUUQYO2JvG5Q+JoNzlJPOpCOhgAxpd+UFbN0oEu220MxMx8e3PWJnoX
        Jxwi30q4UWf8C4J7CJYJHmFJEYn7LZsdWPkV4nYdRRlPVQf/jBgPOUayaICi9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNshtPRKBY8CGtSMUHKwUEgpyLO2ktu1ONkl5+2sp7M=;
        b=XneCMj83qte9D26d1ic80OaApVuBq8HfNYFN7368/5Oc+htH3P3vuzEU4O98UYEnivYyNT
        wtlLvUzMnraGgPAw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Clean up percpu_add_op()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-5-ndesaulniers@google.com>
References: <20200720204925.3654302-5-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102299.4006.9727983750973308029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     33e5614a435ff8047d768e6501454ae1cc7f131f
Gitweb:        https://git.kernel.org/tip/33e5614a435ff8047d768e6501454ae1cc7f131f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:18 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:40 +02:00

x86/percpu: Clean up percpu_add_op()

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
Link: https://lkml.kernel.org/r/20200720204925.3654302-5-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h |  99 +++++++--------------------------
 1 file changed, 22 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a40d2e0..2a24f3c 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -130,64 +130,32 @@ do {									\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
+#define percpu_unary_op(size, qual, op, _var)				\
+({									\
+	asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))		\
+	    : [var] "+m" (_var));					\
+})
+
 /*
  * Generate a percpu add to memory instruction and optimize code
  * if one is added or subtracted.
  */
-#define percpu_add_op(qual, var, val)					\
+#define percpu_add_op(size, qual, var, val)				\
 do {									\
-	typedef typeof(var) pao_T__;					\
 	const int pao_ID__ = (__builtin_constant_p(val) &&		\
 			      ((val) == 1 || (val) == -1)) ?		\
 				(int)(val) : 0;				\
 	if (0) {							\
-		pao_T__ pao_tmp__;					\
+		typeof(var) pao_tmp__;					\
 		pao_tmp__ = (val);					\
 		(void)pao_tmp__;					\
 	}								\
-	switch (sizeof(var)) {						\
-	case 1:								\
-		if (pao_ID__ == 1)					\
-			asm qual ("incb "__percpu_arg(0) : "+m" (var));	\
-		else if (pao_ID__ == -1)				\
-			asm qual ("decb "__percpu_arg(0) : "+m" (var));	\
-		else							\
-			asm qual ("addb %1, "__percpu_arg(0)		\
-			    : "+m" (var)				\
-			    : "qi" ((pao_T__)(val)));			\
-		break;							\
-	case 2:								\
-		if (pao_ID__ == 1)					\
-			asm qual ("incw "__percpu_arg(0) : "+m" (var));	\
-		else if (pao_ID__ == -1)				\
-			asm qual ("decw "__percpu_arg(0) : "+m" (var));	\
-		else							\
-			asm qual ("addw %1, "__percpu_arg(0)		\
-			    : "+m" (var)				\
-			    : "ri" ((pao_T__)(val)));			\
-		break;							\
-	case 4:								\
-		if (pao_ID__ == 1)					\
-			asm qual ("incl "__percpu_arg(0) : "+m" (var));	\
-		else if (pao_ID__ == -1)				\
-			asm qual ("decl "__percpu_arg(0) : "+m" (var));	\
-		else							\
-			asm qual ("addl %1, "__percpu_arg(0)		\
-			    : "+m" (var)				\
-			    : "ri" ((pao_T__)(val)));			\
-		break;							\
-	case 8:								\
-		if (pao_ID__ == 1)					\
-			asm qual ("incq "__percpu_arg(0) : "+m" (var));	\
-		else if (pao_ID__ == -1)				\
-			asm qual ("decq "__percpu_arg(0) : "+m" (var));	\
-		else							\
-			asm qual ("addq %1, "__percpu_arg(0)		\
-			    : "+m" (var)				\
-			    : "re" ((pao_T__)(val)));			\
-		break;							\
-	default: __bad_percpu_size();					\
-	}								\
+	if (pao_ID__ == 1)						\
+		percpu_unary_op(size, qual, "inc", var);		\
+	else if (pao_ID__ == -1)					\
+		percpu_unary_op(size, qual, "dec", var);		\
+	else								\
+		percpu_to_op(size, qual, "add", var, val);		\
 } while (0)
 
 #define percpu_from_op(size, qual, op, _var)				\
@@ -228,29 +196,6 @@ do {									\
 	pfo_ret__;					\
 })
 
-#define percpu_unary_op(qual, op, var)			\
-({							\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm qual (op "b "__percpu_arg(0)	\
-		    : "+m" (var));			\
-		break;					\
-	case 2:						\
-		asm qual (op "w "__percpu_arg(0)	\
-		    : "+m" (var));			\
-		break;					\
-	case 4:						\
-		asm qual (op "l "__percpu_arg(0)	\
-		    : "+m" (var));			\
-		break;					\
-	case 8:						\
-		asm qual (op "q "__percpu_arg(0)	\
-		    : "+m" (var));			\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
-})
-
 /*
  * Add return operation
  */
@@ -388,9 +333,9 @@ do {									\
 #define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
 #define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
 #define raw_cpu_write_4(pcp, val)	percpu_to_op(4, , "mov", (pcp), val)
-#define raw_cpu_add_1(pcp, val)		percpu_add_op(, (pcp), val)
-#define raw_cpu_add_2(pcp, val)		percpu_add_op(, (pcp), val)
-#define raw_cpu_add_4(pcp, val)		percpu_add_op(, (pcp), val)
+#define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
+#define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
+#define raw_cpu_add_4(pcp, val)		percpu_add_op(4, , (pcp), val)
 #define raw_cpu_and_1(pcp, val)		percpu_to_op(1, , "and", (pcp), val)
 #define raw_cpu_and_2(pcp, val)		percpu_to_op(2, , "and", (pcp), val)
 #define raw_cpu_and_4(pcp, val)		percpu_to_op(4, , "and", (pcp), val)
@@ -419,9 +364,9 @@ do {									\
 #define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
 #define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
 #define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
-#define this_cpu_add_1(pcp, val)	percpu_add_op(volatile, (pcp), val)
-#define this_cpu_add_2(pcp, val)	percpu_add_op(volatile, (pcp), val)
-#define this_cpu_add_4(pcp, val)	percpu_add_op(volatile, (pcp), val)
+#define this_cpu_add_1(pcp, val)	percpu_add_op(1, volatile, (pcp), val)
+#define this_cpu_add_2(pcp, val)	percpu_add_op(2, volatile, (pcp), val)
+#define this_cpu_add_4(pcp, val)	percpu_add_op(4, volatile, (pcp), val)
 #define this_cpu_and_1(pcp, val)	percpu_to_op(1, volatile, "and", (pcp), val)
 #define this_cpu_and_2(pcp, val)	percpu_to_op(2, volatile, "and", (pcp), val)
 #define this_cpu_and_4(pcp, val)	percpu_to_op(4, volatile, "and", (pcp), val)
@@ -470,7 +415,7 @@ do {									\
 #ifdef CONFIG_X86_64
 #define raw_cpu_read_8(pcp)			percpu_from_op(8, , "mov", pcp)
 #define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
-#define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
+#define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
@@ -479,7 +424,7 @@ do {									\
 
 #define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
-#define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
+#define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(volatile, pcp, val)

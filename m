Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F420737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yV7BuWn3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0dVKVgCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgGWKoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgGWKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF8C0619E2;
        Thu, 23 Jul 2020 03:43:42 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5/sfq6W0B5VVrRZnEgUQALVJKfPO3YOd3FTpzDoOaE=;
        b=yV7BuWn3BvsREedGje9emEyxJq23HXFJFuqax3EMxcAkHaIbxbMDRDTz7c4EqPHOJCA5UG
        yARxXfpZOsYnWKBsMDxCaMB75hlIWH/ac1hBwWLzHtHYza59vpCMFzQCLclWaxQjCv9FDn
        W6pm27IxlYCNq3sQZb33dLLAywdMUtkfQgVAk2Pp/P2XQP5mzxylXogeeh07wRxmGeki2P
        ZpE3x4jg9iJi1XsHmA/ObSQZMdKUIm69xSgwAdgRtCql5jP71Aae0dc53We/EThlyWSjhS
        HEAxWXmpP2Spm1aDVNqm4l7k0l7f2/c/HoKyOc+79cM2u7YnG/iA11YMTwqHzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5/sfq6W0B5VVrRZnEgUQALVJKfPO3YOd3FTpzDoOaE=;
        b=0dVKVgCPPvMN7Qi2dwy1VV4re7IyYJyVPerZcdmANMJmGel+YfOyYPnGvmi05T5IhRdvuw
        bAGN41wwabmsDfBA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Clean up percpu_cmpxchg_op()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-9-ndesaulniers@google.com>
References: <20200720204925.3654302-9-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102065.4006.17572402018030858800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     ebcd580bed4a357ea894e6878d9099b3919f727f
Gitweb:        https://git.kernel.org/tip/ebcd580bed4a357ea894e6878d9099b3919f727f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:22 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:42 +02:00

x86/percpu: Clean up percpu_cmpxchg_op()

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
Link: https://lkml.kernel.org/r/20200720204925.3654302-9-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 58 ++++++++++------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index ac6d7e7..7efc0b5 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -236,39 +236,17 @@ do {									\
  * cmpxchg has no such implied lock semantics as a result it is much
  * more efficient for cpu local operations.
  */
-#define percpu_cmpxchg_op(qual, var, oval, nval)			\
+#define percpu_cmpxchg_op(size, qual, _var, _oval, _nval)		\
 ({									\
-	typeof(var) pco_ret__;						\
-	typeof(var) pco_old__ = (oval);					\
-	typeof(var) pco_new__ = (nval);					\
-	switch (sizeof(var)) {						\
-	case 1:								\
-		asm qual ("cmpxchgb %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
-			    : "q" (pco_new__), "0" (pco_old__)		\
-			    : "memory");				\
-		break;							\
-	case 2:								\
-		asm qual ("cmpxchgw %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
-			    : "r" (pco_new__), "0" (pco_old__)		\
-			    : "memory");				\
-		break;							\
-	case 4:								\
-		asm qual ("cmpxchgl %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
-			    : "r" (pco_new__), "0" (pco_old__)		\
-			    : "memory");				\
-		break;							\
-	case 8:								\
-		asm qual ("cmpxchgq %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
-			    : "r" (pco_new__), "0" (pco_old__)		\
-			    : "memory");				\
-		break;							\
-	default: __bad_percpu_size();					\
-	}								\
-	pco_ret__;							\
+	__pcpu_type_##size pco_old__ = __pcpu_cast_##size(_oval);	\
+	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
+	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
+				    __percpu_arg([var]))		\
+		  : [oval] "+a" (pco_old__),				\
+		    [var] "+m" (_var)					\
+		  : [nval] __pcpu_reg_##size(, pco_new__)		\
+		  : "memory");						\
+	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
 /*
@@ -336,16 +314,16 @@ do {									\
 #define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
 #define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
 #define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, , pcp, val)
-#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
-#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
-#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval)
 
 #define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
 #define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
 #define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, volatile, pcp, val)
-#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define percpu_cmpxchg8b_double(pcp1, pcp2, o1, o2, n1, n2)		\
@@ -376,7 +354,7 @@ do {									\
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
-#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
@@ -385,7 +363,7 @@ do {									\
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 
 /*
  * Pretty complex macro to generate cmpxchg16 instruction.  The instruction

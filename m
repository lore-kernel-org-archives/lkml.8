Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0E2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6650A20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BSFkVVa8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2HR06Du3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgGWKnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgGWKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE377C0619DC;
        Thu, 23 Jul 2020 03:43:43 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:43:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZCmVqk+9APQtNSGRxo90o6TkaEzzR5H4cD7Fa1F7PU=;
        b=BSFkVVa8yF3VQDJbn+ZYod98RU0SArS4g7j7xt9LMImzY4u8FNTLMfwKrmtMQGQoVFZ8YW
        GKwIiMsax9jNH01HYbJzMUthEb0o3/24NHcNCiK4h31PMb6LH/O/kuQEafgKF09Ng4Elzg
        0Fy8EW70GX+TAfixQlFvZQpu2ytv8w9m/0ePYjYPX0DnJEQoGPWYSfzN7U3bvlfu4c3iDR
        yhbMeETgLOaeEAjS6xFt1xUKQ+8hufCima+3/aYOtCwUAHaV0sGUDeFBdkOvkZ5VHrRF0d
        HI30dsYjL31WwtwSkm0kZcvPuGZ4d+uo8Ps9UHOFe2xw6EqJ4SyT/lt+vUudQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZCmVqk+9APQtNSGRxo90o6TkaEzzR5H4cD7Fa1F7PU=;
        b=2HR06Du336lJwh6iFObdkvaKjN9TAaDnDTbMu0pU55LXqrGsINWPs/oy6MAHP8zcBsMNRA
        OgLywF5hhKAm45Bw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Clean up percpu_add_return_op()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-7-ndesaulniers@google.com>
References: <20200720204925.3654302-7-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102181.4006.3294680559178200499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     bbff583b84a130d4d1234d68906c41690575be36
Gitweb:        https://git.kernel.org/tip/bbff583b84a130d4d1234d68906c41690575be36
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:20 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:41 +02:00

x86/percpu: Clean up percpu_add_return_op()

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
Link: https://lkml.kernel.org/r/20200720204925.3654302-7-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 51 ++++++++++------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 9bb5440..0776a11 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -199,34 +199,15 @@ do {									\
 /*
  * Add return operation
  */
-#define percpu_add_return_op(qual, var, val)				\
+#define percpu_add_return_op(size, qual, _var, _val)			\
 ({									\
-	typeof(var) paro_ret__ = val;					\
-	switch (sizeof(var)) {						\
-	case 1:								\
-		asm qual ("xaddb %0, "__percpu_arg(1)			\
-			    : "+q" (paro_ret__), "+m" (var)		\
-			    : : "memory");				\
-		break;							\
-	case 2:								\
-		asm qual ("xaddw %0, "__percpu_arg(1)			\
-			    : "+r" (paro_ret__), "+m" (var)		\
-			    : : "memory");				\
-		break;							\
-	case 4:								\
-		asm qual ("xaddl %0, "__percpu_arg(1)			\
-			    : "+r" (paro_ret__), "+m" (var)		\
-			    : : "memory");				\
-		break;							\
-	case 8:								\
-		asm qual ("xaddq %0, "__percpu_arg(1)			\
-			    : "+r" (paro_ret__), "+m" (var)		\
-			    : : "memory");				\
-		break;							\
-	default: __bad_percpu_size();					\
-	}								\
-	paro_ret__ += val;						\
-	paro_ret__;							\
+	__pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);	\
+	asm qual (__pcpu_op2_##size("xadd", "%[tmp]",			\
+				     __percpu_arg([var]))		\
+		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
+		    [var] "+m" (_var)					\
+		  : : "memory");					\
+	(typeof(_var))(unsigned long) (paro_tmp__ + _val);		\
 })
 
 /*
@@ -377,16 +358,16 @@ do {									\
 #define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 
-#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(, pcp, val)
-#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(, pcp, val)
-#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
+#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
+#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, , pcp, val)
 #define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 #define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 #define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
-#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(volatile, pcp, val)
-#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(volatile, pcp, val)
-#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
+#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
+#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, volatile, pcp, val)
 #define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
@@ -418,7 +399,7 @@ do {									\
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
-#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
@@ -427,7 +408,7 @@ do {									\
 #define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
-#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 

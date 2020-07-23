Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70639C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D08E20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EEWcmGEy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/7KidbpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgGWKoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgGWKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9644FC0619DC;
        Thu, 23 Jul 2020 03:43:45 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:43:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJK5JZB/QaJfzsy+XZaoRUvAHmRsPqn38fYisGeASgk=;
        b=EEWcmGEyq4+7KnzUGlG/C+JsdrFQ2dn1+vpgCCmbpDtxBWf9/3xjNBnc+YX896oaY9l36r
        Y8VBQK/I2PBUyTBWcdrWk1ya7F7EwHT1/ebgnkwG76mHT8MtFLPbOc+rHaW8H4j2UWYvlZ
        LiC0Sxpq/FwGCJyNiPCuSQ/uB3w/tXN9yGvS/HijIIrAkwwPvS7oGENPRh1gGI5ygdHqjG
        2oLnFPXMlddq/HoKask7d/sYxWTtMErlhiQBvDotMYzwnHzk9Neg9d96xiAw3JpDCXIebe
        VBknwW/Wkp0VqMk7+cNJN5PgdU9TxJCKcJOsKCWAPYi8RGa1ulGzkntBqJLHdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJK5JZB/QaJfzsy+XZaoRUvAHmRsPqn38fYisGeASgk=;
        b=/7KidbpXtVfmzJNCYvk26NEOHaM/jf/N5FWu7ZRh/7Lz1cmroFCQE5wbhtE6nGVhicEYEP
        bpoCifEzDo/6kvBA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Clean up percpu_from_op()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-4-ndesaulniers@google.com>
References: <20200720204925.3654302-4-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102360.4006.7358937995042957077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     bb631e3002840706362a7d76e3ebb3604cce91a7
Gitweb:        https://git.kernel.org/tip/bb631e3002840706362a7d76e3ebb3604cce91a7
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:17 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:39 +02:00

x86/percpu: Clean up percpu_from_op()

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
Link: https://lkml.kernel.org/r/20200720204925.3654302-4-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 50 ++++++++++------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index fb280fb..a40d2e0 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -190,33 +190,13 @@ do {									\
 	}								\
 } while (0)
 
-#define percpu_from_op(qual, op, var)			\
-({							\
-	typeof(var) pfo_ret__;				\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm qual (op "b "__percpu_arg(1)",%0"	\
-		    : "=q" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 2:						\
-		asm qual (op "w "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 4:						\
-		asm qual (op "l "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 8:						\
-		asm qual (op "q "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
-	pfo_ret__;					\
+#define percpu_from_op(size, qual, op, _var)				\
+({									\
+	__pcpu_type_##size pfo_val__;					\
+	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
+	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
+	    : [var] "m" (_var));					\
+	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define percpu_stable_op(op, var)			\
@@ -401,9 +381,9 @@ do {									\
  */
 #define this_cpu_read_stable(var)	percpu_stable_op("mov", var)
 
-#define raw_cpu_read_1(pcp)		percpu_from_op(, "mov", pcp)
-#define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
-#define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
+#define raw_cpu_read_2(pcp)		percpu_from_op(2, , "mov", pcp)
+#define raw_cpu_read_4(pcp)		percpu_from_op(4, , "mov", pcp)
 
 #define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
 #define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
@@ -433,9 +413,9 @@ do {									\
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
 
-#define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
+#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
+#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
 #define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
 #define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
 #define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
@@ -488,7 +468,7 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_8(pcp)			percpu_from_op(8, , "mov", pcp)
 #define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
@@ -497,7 +477,7 @@ do {									\
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
-#define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
 #define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)

Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A54C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03D020737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+oQCtXP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wS1Zsxvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgGWKno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgGWKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4683DC0619DC;
        Thu, 23 Jul 2020 03:43:42 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DARxHYHXw5JqOUdIb/Srd4HHWvIKnU1djuB2cjTQdaA=;
        b=q+oQCtXP8TCUsdhU9e6l0FM8s8jLalLxGDCATs5BvgE8oc+lc+wNgEc0/dXfkKQAK91vGV
        c/Bz6YI7m7m4RaJsjThW9ZkGr7ueNzpuGGfHImwBs/NFaymv8JwJkdHnPJdufZXZkZEzu4
        9s6cpFzcYL/AvBXX+FiredhpltmPavOVfkRyNYyEvxI5uf5rR3hTK5ZelVVTo+4np1D+wm
        Tho+H0oH0EgxhXqfPLmR1Dy8//gz2Nsluo6X2DqmQj+wPo6fM2X6CKRHghO+5cYRPpSzC4
        KO7LeOvTtJy4y7RP9yjXqr42aaFNPfe+WO1LIoGiMTFCboF60qqMl2atrxOkKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DARxHYHXw5JqOUdIb/Srd4HHWvIKnU1djuB2cjTQdaA=;
        b=wS1ZsxvsOgSggaqbmepcGN1UHcHcotbKl4/xaslPpD103vdyqJzSRsnQmGFMFKYPg7Moxn
        VInL07eHCP2PA0Cw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Clean up percpu_stable_op()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-10-ndesaulniers@google.com>
References: <20200720204925.3654302-10-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102007.4006.8331453073575810386.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     c94055fe93c8d00bfa23fa2cb9af080f7fc53aa0
Gitweb:        https://git.kernel.org/tip/c94055fe93c8d00bfa23fa2cb9af080f7fc53aa0
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:23 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:42 +02:00

x86/percpu: Clean up percpu_stable_op()

Use __pcpu_size_call_return() to simplify this_cpu_read_stable().
Also remove __bad_percpu_size() which is now unused.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
Link: https://lkml.kernel.org/r/20200720204925.3654302-10-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 41 +++++++++-------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 7efc0b5..cf2b9c2 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -85,7 +85,6 @@
 
 /* For arch-specific code, we can use direct single-insn ops (they
  * don't give an lvalue though). */
-extern void __bad_percpu_size(void);
 
 #define __pcpu_type_1 u8
 #define __pcpu_type_2 u16
@@ -167,33 +166,13 @@ do {									\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
-#define percpu_stable_op(op, var)			\
-({							\
-	typeof(var) pfo_ret__;				\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm(op "b "__percpu_arg(P1)",%0"	\
-		    : "=q" (pfo_ret__)			\
-		    : "p" (&(var)));			\
-		break;					\
-	case 2:						\
-		asm(op "w "__percpu_arg(P1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "p" (&(var)));			\
-		break;					\
-	case 4:						\
-		asm(op "l "__percpu_arg(P1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "p" (&(var)));			\
-		break;					\
-	case 8:						\
-		asm(op "q "__percpu_arg(P1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "p" (&(var)));			\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
-	pfo_ret__;					\
+#define percpu_stable_op(size, op, _var)				\
+({									\
+	__pcpu_type_##size pfo_val__;					\
+	asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")	\
+	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
+	    : [var] "p" (&(_var)));					\
+	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 /*
@@ -258,7 +237,11 @@ do {									\
  * per-thread variables implemented as per-cpu variables and thus
  * stable for the duration of the respective task.
  */
-#define this_cpu_read_stable(var)	percpu_stable_op("mov", var)
+#define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
+#define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
+#define this_cpu_read_stable_4(pcp)	percpu_stable_op(4, "mov", pcp)
+#define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
+#define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
 #define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
 #define raw_cpu_read_2(pcp)		percpu_from_op(2, , "mov", pcp)

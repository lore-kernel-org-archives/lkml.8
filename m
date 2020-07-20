Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7738EC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F29420672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwYVsBv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgGTUu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgGTUu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d27so22959196ybe.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/9STi9/0NspXnRy6zPc67lC+VCDfUlVQvLOON6i7x7A=;
        b=LwYVsBv9Di8WEZdb8Wwavzjv8/Uq2uVR4gKCsGfo3ZWAt8Wyw/sBOd6NQ2UueFe4tL
         z7mCIqzVXmQYihW0QfX/CKnuqpHqRXiOvJDyYPrLYS4L8sSTI9EyykWgbfmqVcNSyQxX
         AL+WyBtfnI0HYny/bGFwOxJTIyMnkVGb3LO5xBOE1veQJEmipcpIK3CpxGQCRhHgXAxX
         pM6SR94n7GLPp3cJXVwZw7CH+rPXUjz/bHLYHd4m90RgVPyvr+KyNYEmA7/YVc929onN
         uhHN5XpPsaT8/JtVzEfwfmwSAw9fEXr9zEouUVSb/+oPjc8rlRT2lZtFO47bcP0Zyrml
         7rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/9STi9/0NspXnRy6zPc67lC+VCDfUlVQvLOON6i7x7A=;
        b=c/ai8uKwvstwb9Xb+Dztq9fQHhhd4GgBU2tjcVSsk1TIAvhNMFp2ZgNA+ovxzOOQad
         MTVIO6ox5PGTXQuaJza1RWhhrZOxWM0jtapubbBiG2dRaX+hPPb4a9IfGkjFLtCX0J7y
         8FsHFctWcFAkj6CG5QilN9pg4tX9EI2B4blP07xBM9sGLcN+pM7WZaJTp58d1h7TP7iT
         QNVZhMcK/a3lX1fzWpGFPPzBaCn2AyjmPNqMkgvD+T0xvTdDHBmBdxwzybJoqpp+fiR0
         Hc1i2d8q7QtiL257ROMR5eiN+Vnj0Pe/4w1PPo94QAOIR2w/E/X5s2Pmtcrae7R3pRa8
         8gSA==
X-Gm-Message-State: AOAM533RjJbyFBYN1qPE+xfBKKHt9Bt/Pay/bg/DtbGkkUb7PPpXt7RR
        w9+pd6gscePED/8SeSOEHLxtLsgOr+wP8dT9DhU=
X-Google-Smtp-Source: ABdhPJy6j2P8wnJ2uibwMjlyNVkMb6nIbCdVvwrtPOB3XUTCu5DGrPasFnkdDH8cjEFk+/SrPYwYulWrBrFAYyyeIfg=
X-Received: by 2002:a25:3752:: with SMTP id e79mr36408711yba.263.1595278226481;
 Mon, 20 Jul 2020 13:50:26 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:22 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-9-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 08/11] x86/percpu: Clean up percpu_cmpxchg_op()
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <brgerst@gmail.com>

The core percpu macros already have a switch on the data size, so the switch
in the x86 code is redundant and produces more dead code.

Also use appropriate types for the width of the instructions.  This avoids
errors when compiling with Clang.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/percpu.h | 58 +++++++++++------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index ac6d7e76c0d4..7efc0b5c4ff0 100644
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
-- 
2.28.0.rc0.105.gf9edc3c819-goog


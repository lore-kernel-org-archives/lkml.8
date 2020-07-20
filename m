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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C461EC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A4520773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaIn59F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgGTUt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGTUtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:49:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EC2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:49:55 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 1so7658832qkm.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=63aVbZXiTq+rcFDCYht/Xn/AFytJVQi7yE6pi8x5zh8=;
        b=qaIn59F0o+15ii1MoBkYskWtntUneK1x/zFpp9PscsHB3HfrtasTvMNGO5eA2ShLf3
         iyOWH1xWSysUQc8n9a9nU9gQF0TK/gsm6EhEKozW1kO3t3L/ezSvaOfr0DKaaPTRZYxj
         WEcidbPzYfSyUgUQEgpOYhlKgEt8SzttR2sefCWL1u+Im7UJpemm94JqTJ8GBWw2xuv5
         rm4lmTLCCu/zi8YN5NTvBrqKhAyM8JwSTiEAE4giNzlFc5cCxHgLRBjzv+7oZxfHOPbg
         EEPux3ZGEgs7srcP+ncQ3W834ff4kokVLJbyp9BXyhVGD7lMbPPCoKDr6ldrg/60BXU+
         shLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=63aVbZXiTq+rcFDCYht/Xn/AFytJVQi7yE6pi8x5zh8=;
        b=Cqz723KzZyp5bz8vxHrvLJcJtz6tcgzIOWFcghdmhgtoqecFW+am6TVa462Xbz+jua
         h0jMPY7rDdwoShKgIG5nDdwD5NtU5C/7PMRsX1dk9/7LrtshdMaCADeqZK1maXxMCtnV
         4XKa5sYW9wW9fqh4tnHu9aeLZTXVe79S93fDsBaE6el6m6mPoNJTmCj4EKbfo1POAI63
         +S9eW4sC6KvF/7/Yim0MiypWToCf/JVbqq1eOQPChDSLVj4UVqqh7f7AeOhqAO/gzq6u
         tQDq6BsW/ODvDhvTnNz9Jol0r42EBD2Tk0jSRaKRAXBEDJrKFl+gBG7/GeZ717vRJJII
         ViTg==
X-Gm-Message-State: AOAM530Kn/hgrvEcvXw9wmTkDOtXYGYUxM1DOYn+GOGNKGk5uSUjsJeu
        tdaZhTa9z8qdV9XVfqgO/qBPLLRajV4W7ONbdGw=
X-Google-Smtp-Source: ABdhPJw/APgViNmCJ0vaOndzTRXGS2z+esVAEVdXTRiSC1FgCvZK/X7L2pwCjXnWEh6Qj1aIqh1M9NL9WIuxCoMiS84=
X-Received: by 2002:a0c:e008:: with SMTP id j8mr23695256qvk.87.1595278194308;
 Mon, 20 Jul 2020 13:49:54 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:16 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 02/11] x86/percpu: Clean up percpu_to_op()
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
 arch/x86/include/asm/percpu.h | 90 ++++++++++++++---------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 19838e4f7a8f..fb280fba94c5 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -117,37 +117,17 @@ extern void __bad_percpu_size(void);
 #define __pcpu_reg_imm_4(x) "ri" (x)
 #define __pcpu_reg_imm_8(x) "re" (x)
 
-#define percpu_to_op(qual, op, var, val)		\
-do {							\
-	typedef typeof(var) pto_T__;			\
-	if (0) {					\
-		pto_T__ pto_tmp__;			\
-		pto_tmp__ = (val);			\
-		(void)pto_tmp__;			\
-	}						\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm qual (op "b %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "qi" ((pto_T__)(val)));		\
-		break;					\
-	case 2:						\
-		asm qual (op "w %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "ri" ((pto_T__)(val)));		\
-		break;					\
-	case 4:						\
-		asm qual (op "l %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "ri" ((pto_T__)(val)));		\
-		break;					\
-	case 8:						\
-		asm qual (op "q %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "re" ((pto_T__)(val)));		\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
+#define percpu_to_op(size, qual, op, _var, _val)			\
+do {									\
+	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
+	if (0) {		                                        \
+		typeof(_var) pto_tmp__;					\
+		pto_tmp__ = (_val);					\
+		(void)pto_tmp__;					\
+	}								\
+	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	    : [var] "+m" (_var)						\
+	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
 /*
@@ -425,18 +405,18 @@ do {									\
 #define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
 #define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
 
-#define raw_cpu_write_1(pcp, val)	percpu_to_op(, "mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op(, "mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
+#define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
+#define raw_cpu_write_4(pcp, val)	percpu_to_op(4, , "mov", (pcp), val)
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(, (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(, (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(, (pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_to_op(, "or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_to_op(, "or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_and_1(pcp, val)		percpu_to_op(1, , "and", (pcp), val)
+#define raw_cpu_and_2(pcp, val)		percpu_to_op(2, , "and", (pcp), val)
+#define raw_cpu_and_4(pcp, val)		percpu_to_op(4, , "and", (pcp), val)
+#define raw_cpu_or_1(pcp, val)		percpu_to_op(1, , "or", (pcp), val)
+#define raw_cpu_or_2(pcp, val)		percpu_to_op(2, , "or", (pcp), val)
+#define raw_cpu_or_4(pcp, val)		percpu_to_op(4, , "or", (pcp), val)
 
 /*
  * raw_cpu_xchg() can use a load-store since it is not required to be
@@ -456,18 +436,18 @@ do {									\
 #define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_read_4(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
+#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
+#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
 #define this_cpu_add_1(pcp, val)	percpu_add_op(volatile, (pcp), val)
 #define this_cpu_add_2(pcp, val)	percpu_add_op(volatile, (pcp), val)
 #define this_cpu_add_4(pcp, val)	percpu_add_op(volatile, (pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_and_1(pcp, val)	percpu_to_op(1, volatile, "and", (pcp), val)
+#define this_cpu_and_2(pcp, val)	percpu_to_op(2, volatile, "and", (pcp), val)
+#define this_cpu_and_4(pcp, val)	percpu_to_op(4, volatile, "and", (pcp), val)
+#define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
+#define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
+#define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
 #define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
@@ -509,19 +489,19 @@ do {									\
  */
 #ifdef CONFIG_X86_64
 #define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
-#define raw_cpu_write_8(pcp, val)		percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
+#define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
 #define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
-- 
2.28.0.rc0.105.gf9edc3c819-goog


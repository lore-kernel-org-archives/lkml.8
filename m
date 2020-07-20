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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60701C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3055722BEF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XD68lI7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgGTUuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgGTUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD155C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x184so23056245ybx.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H8n8NlDA+XqQVjoji1oNapNAeXpu2S6QN9jGft1e7uI=;
        b=XD68lI7xPehueYlpXdeIT/uxNOTq2MH/uRdzjfw9Hy+Tvg/s9HmgWhlkM8gnq7TZVv
         mld+n/DBsUV64mBICeT5+lfaAqeGIqENtKwdF8zGmWcID2dbpWQ6bbjFjT0iD/b+VcLD
         UWZ5mRBMSG0EBlBkXt1KXJEcVuFSX4SP+kFu6Zjkp+evi24LjtqH0xjpgwqO19Pbyas7
         1Pv2+88TRv+5WUlNL+9K9gRyToYHqs/BtBJCWV5QYLBs5toDAmmz4Jk09QhiD9AnuqbG
         R7TQE5U83mUl7bDnJXQd/zPbEZMAf80Ew+wnezMIq5Y9yjk2N6158nJmn0XyIdAdQYyF
         jAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H8n8NlDA+XqQVjoji1oNapNAeXpu2S6QN9jGft1e7uI=;
        b=sLcF1Pd6GInQfUo1826ijlkrt4axafCXlR0FynQhVG28uMm/ZLPhHqhbglR3wb2Yt+
         qyIdMSAC4uawnXPsLCfCBdHs7tr5J877CqQMrrbtH/Nkvd+wnhFgMflwIFd6TSZdtt6g
         pbjXhX9JX2dr2vl5e2/VxiZ6zIWPIsRto7bVRIErQkhSCcoQpyg4TaebO7T251jT662o
         CUvWyQaU1Il9xprxYPmnMxPQlSvTJX72B5t0m0pz99hujjW3gdrzUT4zXjbjU0eBAVAb
         tKVpI7mQc5osNYJAtHjzIxoVg58WY2smxOcrCH8njCnm8M1VjJxEbcgqu4ecwdOG7H4Y
         oNTw==
X-Gm-Message-State: AOAM530i26TaxzVNDW2WaPJgPIbtaQXZ4nNQeNP41Zk6TppsXWA4WcKq
        fMLYnXabWwR1nlOA3uhHQR4CGtHEnUXEyI+jmQY=
X-Google-Smtp-Source: ABdhPJxmKsFYcqc/X/zp2ZJ/73eylx0YhW+4dbL2/LhkksUAgSeLnGyI6oodyuxDv9H4+0QvZRsQPZpU6z9u72TZkLU=
X-Received: by 2002:a25:641:: with SMTP id 62mr36056360ybg.484.1595278208076;
 Mon, 20 Jul 2020 13:50:08 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:18 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 04/11] x86/percpu: Clean up percpu_add_op()
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
 arch/x86/include/asm/percpu.h | 99 ++++++++---------------------------
 1 file changed, 22 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a40d2e055f58..2a24f3c795eb 100644
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
-- 
2.28.0.rc0.105.gf9edc3c819-goog


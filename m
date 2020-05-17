Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC66207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBOYlD+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEQP3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgEQP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:29:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA41C05BD0A
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ee19so3521469qvb.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqWDOFPx/ma94Tav72gjz5y+2u6huVkM8HpjL0ciamg=;
        b=tBOYlD+CMWtThMxxASU22C33wwi6bmFZbNOpvOEYcDTXZmiOjMb8Ww6tEz2rRvk30y
         fGnviWa4Rh449STxrxhFsnhWIZPtszo5btF53K6uT7lIXl2nbGrFgLDg3QhZK4+O31pR
         7AIlOIUBJGaA0mW1LNXqpSAMhswHNpCjnt0JEElf1z4I9WvUBrWdikOuGL/WKujnsQPo
         ayW+pcb/Nh9Wlnqgxz1dBreXnN1dWxJpeMHPerRRzw5dHNJ3KRTCMSR3ZV6F9UZqqmsQ
         ZtC4PqtWgcoAUULxj1H6n7gzM8JcecGuCvLs3u6oNohM+0DrByt2tBx99UrYeDPlY/1j
         SZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqWDOFPx/ma94Tav72gjz5y+2u6huVkM8HpjL0ciamg=;
        b=VGAFfvLAWD2Rti0NMKUcKAGrw3Be4917tpHIqffg6LIx8EdfOvmjcZDM7dS2y1CgC8
         MMU85NCRBdr3RQJJcjwSiLJRFux9RTFFW16UsjNnr+IHw4si0lbCTlJx2RRDjE6aJjQJ
         C+gfH8ovd7ipnld4agtlZiHR84V60wylNyAbh45yDR1kqc1vZIMsJzBq//D544IgUAYX
         Fn693dxIgoxAGcVxAce1p8I32UGwfUw0lh0OVdIb8XoO6baoz1y3JhvBHRzggecR2pVL
         pWRqT9h1QTl8ZNySVvQlRoENdqmOQb5SnTGDiS32aPlWUBp1n4nH6w1I44krEq1YvFUj
         DOzQ==
X-Gm-Message-State: AOAM533nIqRQw2slJpgYjOzx12qoynjBtmpJRbjZIhCtDg9nmcRiI8SI
        zomDxXgVPzcLA4U/OKC2HjbAHdVlxw==
X-Google-Smtp-Source: ABdhPJzrgazn2O1i1Mi7DbiwtnzAU+DkBkJbB9IYn9PjvsWx3sFGAyccWKmlxomq6l/n0T/In2wqkw==
X-Received: by 2002:a05:6214:a49:: with SMTP id ee9mr12226668qvb.9.1589729369942;
        Sun, 17 May 2020 08:29:29 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 63sm6234335qkh.120.2020.05.17.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 08:29:29 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 4/7] x86/percpu: Clean up percpu_add_op()
Date:   Sun, 17 May 2020 11:29:13 -0400
Message-Id: <20200517152916.3146539-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200517152916.3146539-1-brgerst@gmail.com>
References: <20200517152916.3146539-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core percpu macros already have a switch on the data size, so the switch
in the x86 code is redundant and produces more dead code.

Also use appropriate types for the width of the instructions.  This avoids
errors when compiling with Clang.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h | 99 ++++++++---------------------------
 1 file changed, 22 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 93f33202492d..21c5013a681a 100644
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
2.25.4


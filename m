Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFBDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B953A20774
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBM3hUIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgE3WLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgE3WLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:45 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C288EC08C5C9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:44 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so3094737iog.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POxMDPDzQKohFf4DOc41bQZFBG77uMJ8GuScvwOHFjM=;
        b=fBM3hUIjcP1eQ060stn08r+AzeBs5lyTXcTB5afTzHKsMpDGJZNCHaW/w6QZyfUr1g
         YTX9QLtY7Aw5fZTcbmSQZtipBXI2Z1tj75z8ZYlgthTG7QRsdxg8A+p1b6aaswa3rZiX
         0TRtzet+GS0Kp5iDnPhv9CXQWzzhzdmiBXoNyGMY+kwFRKzlq437MElF2e7RimaxMPD+
         PAYVYlj48IDNQwkYIVa5gCAGpMy/Wuq8degqODLGapOjcVnt3gF6kmf2AkkDMd3VvVGB
         yWxhuO0ncKzyGlfFDH4VoI8GplrZ1vPmLlcT2xEBMPmqrzwTpizejDUF1tPklV0AAKSb
         JQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POxMDPDzQKohFf4DOc41bQZFBG77uMJ8GuScvwOHFjM=;
        b=Kpi6A8XjsaIXuFue6juP22uZMt8IAWeBve/PWq4V4sGCKbZLdIG+PosyVnORtA0dIA
         Ek6QeDceoSQIcHV+0FYhFd8TzLk8FwlQ1AhoThEqrUOtvo2Z2b3nKpu9P4l11lz6RgYa
         l2mLytKB2HFVwwcDcmdxr87HyZNv00xGXnElJxy2KMFZQi+JDlbqpGMw+yQyB7fRZZy7
         DysX9SkGhE/98IInrMhKs/qmUZH4bzB6KK5uUjp5qgHf4CxLIPoa2+lQMBNciuVkltML
         WVjSKJOLf9yl8jCSCd4ctn3KpVfdT0UQVyYtIfM/6QlIpM5cKhgkjqyQ2W19cz36A2YL
         b99g==
X-Gm-Message-State: AOAM5331c153RGDpn9WtccQlzwkAaWkffYD1A5ZkdGaNWZVNmgCI6w26
        ccK90qGAGXbgx6ibZu4I4gknHT6ypQ==
X-Google-Smtp-Source: ABdhPJxko4NLbdiVexMavpix6iOtS/ZDua8RFhOtsroc7vcilkwjtcY3Aii4CyYsqxja9+YlDTopMA==
X-Received: by 2002:a02:245:: with SMTP id 66mr14254463jau.69.1590876703839;
        Sat, 30 May 2020 15:11:43 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:42 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 04/10] x86/percpu: Clean up percpu_add_op()
Date:   Sat, 30 May 2020 18:11:21 -0400
Message-Id: <20200530221127.459704-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
References: <20200530221127.459704-1-brgerst@gmail.com>
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
2.25.4


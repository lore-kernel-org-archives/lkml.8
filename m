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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD04C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CC3206F0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgEgRUaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgE3WLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgE3WLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB2AC08C5C9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s18so3171613ioe.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQvPiQc8ex+lNbpkm0sPDsoKLCC6rAxk/939DABushI=;
        b=UgEgRUaKi0yyiL/5GqWiamAGEQTUAV7+tVIA+AzXMZFjOavLJN3EOWTJox7c2jLwve
         /+Olarwss8+B5FxVawlItHzX2pEVccSoTHTzGNSSuh0H9LsEeLDg2wU9Ku8XZ4+2Wa2P
         3WhOGzV637RNCeJ2nAWGOBSVPJhlqV15qaagM216FNyNA5TyL2WXuj/rgKt414AARPPh
         RAJTGnbL5Sr9YhDoU5UjP7lhfCfxbbWzA7EaJo/bAj8mVECOLtiaD8EqPLJZDogkERzM
         DmF+Z630+EBVspB+/T3meUUoRmc1NP3nihXIYC/Sp7G+SKZ8fDuLwo44k1gO5AJW7zuD
         qzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQvPiQc8ex+lNbpkm0sPDsoKLCC6rAxk/939DABushI=;
        b=hWWUOw7wzHWSbfdtA4IxPIRMGs4BFCOx5rjRwp8j2wfLOqD1d57sRVb/8/LBG1QvsZ
         Tj1WvzSNDpqLP+GL3YDlDAcki2VoDOoOLK8ySjDeMOJpY57EOh6aRQrEjJ2KhGfmMjrX
         +1xeWdswGF3XvtJlPTFQ2G18GdkAFwFVLc9WZuAgBrTPe/vCu83aZfbIfvRWfkQAVbKr
         HXbCBWaHfXA3cngsDp4w7IkM0V2UH6CNdM8In/pnD2TmEjVgC8ZpnpxN1TqoXwSypD+0
         43CONrFSBuoGTiFjQI1gs59j/LwHjeYjhaT5Ma4U+h/wd5y422sNmLxcXaIysGY9hXeX
         SKEw==
X-Gm-Message-State: AOAM532ezAi3Q82zD5pKA4EH1CKE8JLVPJst5QNqtTdqSEryRVLTenmQ
        6LI9L351QjCIInEAsGsrAl0oZAM34Q==
X-Google-Smtp-Source: ABdhPJxgBMWNdoJd46kPiGhsIBEITyd+4MG4oiAuIF477La30bPqLhxrw9ksydtm22Acb8kC5/QX3Q==
X-Received: by 2002:a02:6007:: with SMTP id i7mr2111342jac.1.1590876701620;
        Sat, 30 May 2020 15:11:41 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:41 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 02/10] x86/percpu: Clean up percpu_to_op()
Date:   Sat, 30 May 2020 18:11:19 -0400
Message-Id: <20200530221127.459704-3-brgerst@gmail.com>
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
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
2.25.4


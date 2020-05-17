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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F8BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C07A207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP75/YwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgEQP3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgEQP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:29:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF478C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:33 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o19so6082315qtr.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GY4Jy7rnTiJ0kXrs7xMxihBrYL9Ask63QEduHqOBnn8=;
        b=ZP75/YwZhW0QWF2UjInjZ6pQyLz2V+sOWihhnYexKABHM1W77hBR/j4NLCl9Qzdrrf
         /Hm2fXN4dgplvbDFTcY+9EzXMwZhcfxx0q93v0fWMXRp5rzW8Gm3s/fmp1KHQxC5DP1K
         58ZH5cbqeWOWQKD/fRLLGfRDsH+GR9w0h2ULm5KAadmzXTAar74804VkhCkkqwXmipvo
         k+OaJMfDs++p5F/S5AMnF5bo1w0QaaWyR9NB+9QfcMgDt8Zh2uXV4LlhNjvAtdj070kX
         E8ZxOXWjx4J8pZl/x0Cq/gjnUCT8B8gcbA2uRZe28t0cJNac0NlWKNxVj+8zCVQoQWcb
         ORfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GY4Jy7rnTiJ0kXrs7xMxihBrYL9Ask63QEduHqOBnn8=;
        b=k00FVG/wvkVvhRjPjM1FB6Hky06wEe4qgKO5wEJbRMvM4SLgnAvqX7QrJl8YX8m+2s
         zJM5Qpnw3y3MlPaOPh+c5UX9X9hfjPAP8ZTc7D6mz82sRzMKZEJVJgnIVy7rMCenwNJv
         Et1feJvjEUPFyMC5daZ49jSG/9pmEc7e/fKC+h0HVsX3/l9Q5WBQKds7PVtXgSc5ibKO
         M+dRsIOgg/3Bam/FtvoeTuwFeJCVwqwdXL3vat0jcxo7hVhJMMqfE+EP4STR2nsnvoMO
         CyPQgW8e3LBoU8K3n69xA964aZXWg0WPaZ3pI61n9p9m8WdsEyR/YS7/u2DCLfA2rpZv
         /1PA==
X-Gm-Message-State: AOAM532rw6ajHyytuvHm0RtWS/z+PICu7iCZY5v4F/GpQqlbbF4aVnSi
        o+QDJFxGW8BOczTxupkjKy7w2qCJ6w==
X-Google-Smtp-Source: ABdhPJz/uipmlXaybHvF0kZVnvO1i0ab/5yUdYh6P0KdutJG7aglmZWHudCCr7XyuB93WoSnTmeRDA==
X-Received: by 2002:aed:3ff7:: with SMTP id w52mr12579261qth.148.1589729372645;
        Sun, 17 May 2020 08:29:32 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 63sm6234335qkh.120.2020.05.17.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 08:29:32 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 6/7] x86/percpu: Clean up percpu_xchg_op()
Date:   Sun, 17 May 2020 11:29:15 -0400
Message-Id: <20200517152916.3146539-7-brgerst@gmail.com>
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
 arch/x86/include/asm/percpu.h | 61 +++++++++++------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index ac8c391a190e..3c95ab3c99cd 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -215,46 +215,21 @@ do {									\
  * expensive due to the implied lock prefix.  The processor cannot prefetch
  * cachelines if xchg is used.
  */
-#define percpu_xchg_op(qual, var, nval)					\
+#define percpu_xchg_op(size, qual, _var, _nval)				\
 ({									\
-	typeof(var) pxo_ret__;						\
-	typeof(var) pxo_new__ = (nval);					\
-	switch (sizeof(var)) {						\
-	case 1:								\
-		asm qual ("\n\tmov "__percpu_arg(1)",%%al"		\
-		    "\n1:\tcmpxchgb %2, "__percpu_arg(1)		\
-		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
-			    : "q" (pxo_new__)				\
-			    : "memory");				\
-		break;							\
-	case 2:								\
-		asm qual ("\n\tmov "__percpu_arg(1)",%%ax"		\
-		    "\n1:\tcmpxchgw %2, "__percpu_arg(1)		\
-		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
-			    : "r" (pxo_new__)				\
-			    : "memory");				\
-		break;							\
-	case 4:								\
-		asm qual ("\n\tmov "__percpu_arg(1)",%%eax"		\
-		    "\n1:\tcmpxchgl %2, "__percpu_arg(1)		\
-		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
-			    : "r" (pxo_new__)				\
-			    : "memory");				\
-		break;							\
-	case 8:								\
-		asm qual ("\n\tmov "__percpu_arg(1)",%%rax"		\
-		    "\n1:\tcmpxchgq %2, "__percpu_arg(1)		\
-		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
-			    : "r" (pxo_new__)				\
-			    : "memory");				\
-		break;							\
-	default: __bad_percpu_size();					\
-	}								\
-	pxo_ret__;							\
+	__pcpu_type_##size pxo_old__;					\
+	__pcpu_type_##size pxo_new__ = __pcpu_cast_##size(_nval);	\
+	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]),		\
+				    "%[oval]")				\
+		  "\n1:\t"						\
+		  __pcpu_op2_##size("cmpxchg", "%[nval]",		\
+				    __percpu_arg([var]))		\
+		  "\n\tjnz 1b"						\
+		  : [oval] "=&a" (pxo_old__),				\
+		    [var] "+m" (_var)					\
+		  : [nval] __pcpu_reg_##size(, pxo_new__)		\
+		  : "memory");						\
+	(typeof(_var))(unsigned long) pxo_old__;			\
 })
 
 /*
@@ -354,9 +329,9 @@ do {									\
 #define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
 #define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
 #define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
-#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
-#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
-#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(1, volatile, pcp, nval)
+#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(2, volatile, pcp, nval)
+#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(4, volatile, pcp, nval)
 
 #define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
 #define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
@@ -409,7 +384,7 @@ do {									\
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 
 /*
-- 
2.25.4


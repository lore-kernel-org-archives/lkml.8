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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697FB207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsg3LbD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgEQP3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgEQP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:29:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F133C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id a4so3547140qvj.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ybz4m4ecFxhaZZ1S9QMgMNHojoGb32rYiQME41Obp3w=;
        b=qsg3LbD3OYh5u13E3cIqyHJzWh1b02FvL15VyLpPp75FfrUGT9Sca4JPBoF+gEmEHo
         G3v2BdbYc47djmpzjipJ1zMGLnil1rbotHsf6IAHGKXs7RnnfhgLbrxpv2+k8nOleMRU
         peU1aqOjCs2dUMmProixhddxq4Bs/xbNpSCBJin7ToyiiHOCFjIpJFvgW3Xj6Lt9ZJgQ
         b86iYzwNml5ST9dFQtIhGHsCfpZ+tDrnod9n8GyIJ4aHxdk7Hpzh1g8IJMug+qHhmkYt
         xvpjKIXOzkNu/wkzypro3WmYdw2tp0J+mnc+sPhLuHildjxrrkMY8466qYgX2eJxM4XD
         3esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ybz4m4ecFxhaZZ1S9QMgMNHojoGb32rYiQME41Obp3w=;
        b=ObzeMI7FIchukMuU65gdWdSdreCLg1mMn0scEaONW/kzvZZFz8W3BNPrxGUuZf4CMz
         CVFFlj7/b1LSAJoRoEIaGPCno1ARbbk2WF/ABKmTGIaDK+ozZjt3qHhXy9GJmwCQ7Q7M
         ynehgm0oyRFJiHYZMGJDhMJ1pO0yEI/ohFKKgH+aJwgfVxwwkfXmSDsj/WTsZdjpQAHo
         TKgzZ8Xptg48F3dJ8kop0Xbk046mbef0OuafCpvRsmeqjlAaYvZgWo9XsroTz5uX5yZr
         OZZKz+E5w7oubqtC2Vcc2TkbmwWbIoKsz/mu2WYaX5nHcE5cnvp867cIUkVcNJJ5zBci
         xUwg==
X-Gm-Message-State: AOAM533aZBuRJM9IqrlSBhUcR943ag7hQkUHiVdB+OO3YjHxYOrKBqTR
        WB1V8f0YPAm0RTt4pfiLSw3RYx9zAQ==
X-Google-Smtp-Source: ABdhPJwhTOAIRWrtPS9ZOrHNeaVLaHLdxTnW2MiQiZkjWqpQvI8ZiSI+uIlASibNhw1pM9QblkKvkA==
X-Received: by 2002:a0c:8c4f:: with SMTP id o15mr12028175qvb.201.1589729371283;
        Sun, 17 May 2020 08:29:31 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 63sm6234335qkh.120.2020.05.17.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 08:29:30 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 5/7] x86/percpu: Clean up percpu_add_return_op()
Date:   Sun, 17 May 2020 11:29:14 -0400
Message-Id: <20200517152916.3146539-6-brgerst@gmail.com>
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
 arch/x86/include/asm/percpu.h | 51 +++++++++++------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 21c5013a681a..ac8c391a190e 100644
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
-			    : "+re" (paro_ret__), "+m" (var)		\
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
 
-- 
2.25.4


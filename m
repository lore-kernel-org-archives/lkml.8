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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDDC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF3B20773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgwGYfJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgGTUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgGTUuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FFEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i62so22971429ybc.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qr1G39+WcPcTQOpLfSr1R0TatiitMUIoDWHFssxm+t4=;
        b=YgwGYfJw5QnjQG+P8j+jVB7gQFIOZnbK8YHAu11ZYD/FZ6CqrSEMkNNUqTeSFq1VVx
         4/MEgX9IlYzfwWgYEl6zNYcQ08vZnKPrrpiMq9b7dNis44znxS1GMw2W4TvzBko2P/Sw
         TDNo5AtYSIcVNq+tY3zjDWzk8D+LT6jQeFSlXr+5tX8NS0jHCoo8XWt5I2H/Pee6l5gr
         Ufv/c+T/lX8sSOBHZVgIJElgKwqnVIgW802oz6Dzqy6P1guROykHWO6aiEKCOZlHWSMM
         uvkNtoCB/axhnqaLze0jRfOzkcEN9KufoIyUyZCJvaoc3QLjz7W3nW7VQd1S9pEj8V9Z
         V85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qr1G39+WcPcTQOpLfSr1R0TatiitMUIoDWHFssxm+t4=;
        b=TlbPNzxLY0jmz8ytPNwUDmHOpxEaNc9WWV1FqbPKqsyXFO48e+jHHAhmcaxxyXh7Hv
         lNJ7DQW10J8s4tA5ieXXBlLzmPcUC/Y09kF/ACLUJRirdDwyV71YbXbSou97T7QHXS/o
         /N2YAeUNcrix87nj7j88PuN7xBKaBMsw4EtuwIeIx4SA3GsQmfPeYHiHdsq+wEWEYZix
         pXt5WUpMnkzfkqOJsXfpcIcvg+HQGfnjvkqsdLTVc6jAmUN9Ujx98U5tnBHWngLBXuyC
         GHX068UD2c1auUqqstXRxD5B4nS5uRsLk/cBrtE37gQLsTghSo2GI1sFQRIobmA5g8Tg
         ZhXg==
X-Gm-Message-State: AOAM532T8HcevvCzYK9ymRf5q1X2/ujZcJdJdfqrxeSoMRLjEWvrnwwn
        wzrVDba2CtSacz1bC7rJkorkgZSX0QVopLzRMic=
X-Google-Smtp-Source: ABdhPJz6QI1yAMnsMGfiPi9tdOEtyrTtAqy3O5Xr6P7Fl1l/aOgBVFAC7ulxRF6j0hkovmJ8h5ZsAf+hsTxKhep8cIQ=
X-Received: by 2002:a05:6902:6b2:: with SMTP id j18mr36704610ybt.178.1595278218312;
 Mon, 20 Jul 2020 13:50:18 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:20 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-7-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 06/11] x86/percpu: Clean up percpu_add_return_op()
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
 arch/x86/include/asm/percpu.h | 51 +++++++++++------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 9bb5440d98d3..0776a11e7e11 100644
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
-			    : "+r" (paro_ret__), "+m" (var)		\
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
2.28.0.rc0.105.gf9edc3c819-goog


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061E520672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0oYaHUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgGTUud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgGTUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC83C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i62so22972012ybc.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t/rXoQERR5pj1vBkNrq0HXWlaSRuz2vmMuIwif9Ddok=;
        b=G0oYaHUjQaYCEQsiULb1FkHUyf6Ws6k2kL/ZT6PlMtUwX2Htgrnc2dmV4ry+IG9WtR
         DTJ9LMsvw1uMntGHswGJOjFW97ZaEZ5Kue3RlHDxUkNJAnS1lsSBJXHJKrNlXtCnOOSo
         rc8X75FCQDv3dJaMIwWpbT531Ph3eE/zDV5SBWthR6U9kQ5bwyk5K4gTgNpsZh3sqJq3
         7ZJ+zB61Si36MBVE8pB2UpqisJUQ2Ru+cuJyezkpM/efy7RJtXkfDRZfUEXIQYuzTt8L
         yUqq78Di6USyGVhLGeHOkXTdrvpJz/TDBIzTUC+Ghf2aA0KTkWQZvYEKOfuSb8Df0hPq
         hiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t/rXoQERR5pj1vBkNrq0HXWlaSRuz2vmMuIwif9Ddok=;
        b=lT5F4gGFoXZlDqWpjfD+Vj8egf8ckCOfBWjfIccW5qcAPPMBofQqUnYguFuNiz484F
         kM8AFvK4ydy9GxH42sq2R2xY/Ingk6Ko6xrSKSEJOVOB8SD6Os3p42ptsGOgiLckRL15
         17L5u7dBT0GkQp6yP3jNH6LFvI4snXITboZ2f7oea4BaOYfSSsIg5tF54KnofE2aX8VF
         70sS9zAvWLaRcp6h2U7vEDXmr+eyodrFHShI7UXKYg667TPtg1ZH+s7qBr77K+W7JLn1
         ejSy72iy+aKBvBX6UH6cPFPvudXpamN5yYYrwqCTuRNc95qm0gEfys3jWieysXb07ne/
         o0ag==
X-Gm-Message-State: AOAM5304CJJWI5+NVp1aarHaorzysCvy3AypCvggqUMcf61cyJAPfIC+
        i0amsSGZRn/+l+5xe7DQzQYEW/wJvP/pzy5bSUA=
X-Google-Smtp-Source: ABdhPJwj6ngoYMCmqaH3hXnzs/03efS5QaqSc4ftE2ker70Lyz5O63H3RGgpTzOrUJt99uS/lCjhaI+5/4gwbPfNCTg=
X-Received: by 2002:a25:dc84:: with SMTP id y126mr37614831ybe.350.1595278230622;
 Mon, 20 Jul 2020 13:50:30 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:23 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-10-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 09/11] x86/percpu: Clean up percpu_stable_op()
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

Use __pcpu_size_call_return() to simplify this_cpu_read_stable().
Also remove __bad_percpu_size() which is now unused.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/percpu.h | 41 ++++++++++-------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 7efc0b5c4ff0..cf2b9c2a241e 100644
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
-- 
2.28.0.rc0.105.gf9edc3c819-goog


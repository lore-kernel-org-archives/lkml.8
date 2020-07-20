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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4CCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52F220672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lO+O4mHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgGTUu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgGTUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ACAC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 8so22848128ybc.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9frz7q+80dwOHjUq75HZy9e8vMrwxF3ixYJK0hAP0kI=;
        b=lO+O4mHS4xph9pZ3KZ3Uo8+vIR6Llv4LujG9jvQ9DG6bgCmJW+rr8HR2Y3h128pxSw
         jhcnpifT0l/da7+tUemSI9ksEGClzBlZBMxcjDCGwLmfvLamxOGxouSTlvz+P4jJAqLu
         BaoXIh7kbktbMpLADI70VZUXgKe+a47rRjM+Zhe6Mjfc00M2FopLuxg1ZUM+V/eBnofy
         aeRMXyF4+6vwlHWxjrzS1BKDdRZvMtSdUxlwoXchV5sxCWKSCkY+ZO2wiNO4+fU6/6Ec
         ULvewPn0clwOh+fS5Q57ywfLqAztBCsJs+5AkWoVIoAPPfg7qWLT0BnjTZPO68JuNvlv
         +snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9frz7q+80dwOHjUq75HZy9e8vMrwxF3ixYJK0hAP0kI=;
        b=kZdecCj4gERSKF1YUfEd/bML7cz6OEPUVS+JeGHXjC36KXiCwt2DPz7F9i3Y2eF2y3
         3hUxlVIUex03S7Sb/gFsfrm63f3cUHcRp//ZoVSmezOxKxcMrSa8O7Qi0qK8FJqVXt+n
         j7vyzd+sFxRq9gdyWkFknUCbuG724/YZE3MbMielT4JgpM24nmVkOpH3mH8R6Kjd7B2k
         EQDxE0oB78Xw0dM8e9epFFzwcjJ7UMuuoBG/UQHGQATWSVri41wUuaeJHjqXnYauTlNS
         Jag8VTyY/U5kthudyv6SszqS7/Dk44xFDmBSuo7kudSOViLL6/NO8JoFLj5WDNECJTrG
         PpOw==
X-Gm-Message-State: AOAM531vJ3YbO0i3v6t9+4Q0+UmcaSbOzW+gfdzOmVd1Z6+NRrnd8IxK
        XACTtywtqOicaZzbw7SaRXFDlKEOdZeqBxABmao=
X-Google-Smtp-Source: ABdhPJyL3i6GSJQYg+IP4//8U5lz3AYDexQ4qqkll7RancTuawnGk/RbVFDwgTotRpJ21aEXj6VvxB7TgaG0g79UbXs=
X-Received: by 2002:a25:c6c7:: with SMTP id k190mr40022859ybf.11.1595278223197;
 Mon, 20 Jul 2020 13:50:23 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:21 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-8-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 07/11] x86/percpu: Clean up percpu_xchg_op()
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
 arch/x86/include/asm/percpu.h | 61 +++++++++++------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 0776a11e7e11..ac6d7e76c0d4 100644
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
2.28.0.rc0.105.gf9edc3c819-goog


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38B720776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRLIZZ3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgE3WMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgE3WLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:49 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4EC08C5D1
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:47 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c8so3137069iob.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0WjK0e7hgwQHYo1aWVTXJ/dHNIzXbzevTz/cIfmq1Q=;
        b=oRLIZZ3JgdJu6h0ApjQ6OOQULR7BshXrLbWNBX/sz1mmhKQHtB25gwDONRXbjUuwCT
         Iv5rjAtWs1uFn2hS7d0WbuwZuq4HT0oyT7MPvHvl71KctAbWQk4ab25SdhuxGmdrXhMS
         JwKLaaRvQIClxnnwHZxX8ISTGHcM0QaAnzbU5uIv+h8UEPNLCmI/xEpd2duvTzm+uYQ6
         E9Eu/jIrwr3BjzjiJifxNuJhI1LXVoflE22YBU/r1dCMTR2bSmNpkUCkCx5B1MlfFa9d
         +G4OoInp21slCylewNUKnszobro/AVTV7dyX5s7XBH5Mx1ln+OMEdzg4/5Y81ifZKFE9
         JznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0WjK0e7hgwQHYo1aWVTXJ/dHNIzXbzevTz/cIfmq1Q=;
        b=efRn7bm/RnsurJgddV+4410uGwP8k9+wFIQDP36xcxhzL3aaj5ipmIxRzxy5OBXzR2
         91KuV2XSajhwZCrl6rRX92U5ymbM7BQKCkGn/TDH9i8F1N+98+PlT0r1YGfIWwYdlfKu
         +LEtmprx/Dj24ETX+L2j5yM9EE8dLK1WPiRVuWhHpqa1DbqtJ+j/bOT9Y5JVrBauNKVe
         B4DmYqcz5uWT6R2/gU1pFEw6kvt+YF/Q+FssCryfz/0Fz1nljqhayRe/mpl/vh/64W0Q
         qzbi1pghit3lUukz2pMHZnlwCFkB1KJylJ3elX2TX2RDmC2MKc3CI/aijPbP1gdQmYye
         2l7g==
X-Gm-Message-State: AOAM532tkeHl6fAVGIU8Di/SFVHoO+t75lQhHRjxjfaGyqOjWfBBy0JM
        VtPfRp72ZrOdPvGrupmiCGtOiHrfBA==
X-Google-Smtp-Source: ABdhPJyDfakVGuYfmg1sn4+VemwHEKMIQx0itA9oYJSDDNPRGdwxJNtm/JIoKv1xoTyH3i+93gWT6A==
X-Received: by 2002:a02:cc49:: with SMTP id i9mr6212076jaq.52.1590876706813;
        Sat, 30 May 2020 15:11:46 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:46 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 07/10] x86/percpu: Clean up percpu_xchg_op()
Date:   Sat, 30 May 2020 18:11:24 -0400
Message-Id: <20200530221127.459704-8-brgerst@gmail.com>
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
2.25.4


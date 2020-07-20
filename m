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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD22C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DB822C7B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PynqyNO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgGTUuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGTUuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC0C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w35so23158227ybi.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=moMBrUya8+f11J0lfoG20VXlS54zFWp92IgRf7/2Gwk=;
        b=PynqyNO2eV4KSO1NON0YdMlKrn3ICVzTrzjmZ/5xUPrqbtBhxeuNs+QS4b9Iz0NTEs
         RMOZAfxvHjgCgi4Tcx0DqQzO0A9w2T5afQbxYCH2JpjsdRap7jDlyubgkb2iNSetIXCs
         gjafUu4gxrFMBnrI/MJRqt03KcIee2VzoOv4GPx6TG2msQoNzlNShlbi+lti8rigo+E1
         lNocxqrxSXrPNfsWPvnP6/KyORTbOYDw7OYvJK0xhJEwpbWUIjjh6BpXiVBhcipB0vl2
         ARZWxZmSJD9twHzaBbuzmX3jD/0w0wPgfKGZ96CO7pFO27kdkPo579Fe2ODlPRvWfHLO
         gpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=moMBrUya8+f11J0lfoG20VXlS54zFWp92IgRf7/2Gwk=;
        b=jGmIZtgFnpTuY1ryuRarCYU4Lyd72z5+Z/0gwLVdp3hhe1QXPQSz50PQ+jwUI1GjZn
         b8pc9dTg13G+Tm+y9dN+Rw17UqXDsIOTUVXJviAkwKaTbrf71Qo7o+BAMTCFclDuD6iv
         Onjd1cytKNqcZZhRvmR3a+oMZKRG3OnilnZJqoNG6W5VP36I7YBn8p74uoPcfYYaD2l/
         dVHS1CHv+GMJe/upnBltrOY+bRg9ZcDqHQKot36lFrQFRzN+/OK47KjVS4+T4Ll2jLIP
         3xQ/z+r/HBfS069IzmxIYD7UCYJmqTd6vMrl0YlcAegFP/cO/GKKNQGt1/AipZ42G5wp
         MHPA==
X-Gm-Message-State: AOAM532sqWcgYC6OwSTo0sYLWs1ac0dvNRZfQNt/DP9baVHO2R95IJMR
        qTFltzpUXYxkCb4Yo0TEgOdPxrDFiMBrK1Wg5qc=
X-Google-Smtp-Source: ABdhPJzMJ1nS6WTVztw+3UMb983/YiSBVQ3xOY6VAoMqRYOC2NfFAAJA+5VDki2G5JMp4mE4Ke08nMJpqUzschnt8lw=
X-Received: by 2002:a25:138a:: with SMTP id 132mr36725992ybt.334.1595278201430;
 Mon, 20 Jul 2020 13:50:01 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:17 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 03/11] x86/percpu: Clean up percpu_from_op()
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
 arch/x86/include/asm/percpu.h | 50 +++++++++++------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index fb280fba94c5..a40d2e055f58 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -190,33 +190,13 @@ do {									\
 	}								\
 } while (0)
 
-#define percpu_from_op(qual, op, var)			\
-({							\
-	typeof(var) pfo_ret__;				\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm qual (op "b "__percpu_arg(1)",%0"	\
-		    : "=q" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 2:						\
-		asm qual (op "w "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 4:						\
-		asm qual (op "l "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 8:						\
-		asm qual (op "q "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
-	pfo_ret__;					\
+#define percpu_from_op(size, qual, op, _var)				\
+({									\
+	__pcpu_type_##size pfo_val__;					\
+	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
+	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
+	    : [var] "m" (_var));					\
+	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define percpu_stable_op(op, var)			\
@@ -401,9 +381,9 @@ do {									\
  */
 #define this_cpu_read_stable(var)	percpu_stable_op("mov", var)
 
-#define raw_cpu_read_1(pcp)		percpu_from_op(, "mov", pcp)
-#define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
-#define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
+#define raw_cpu_read_2(pcp)		percpu_from_op(2, , "mov", pcp)
+#define raw_cpu_read_4(pcp)		percpu_from_op(4, , "mov", pcp)
 
 #define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
 #define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
@@ -433,9 +413,9 @@ do {									\
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
 
-#define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
+#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
+#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
 #define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
 #define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
 #define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
@@ -488,7 +468,7 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_8(pcp)			percpu_from_op(8, , "mov", pcp)
 #define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
@@ -497,7 +477,7 @@ do {									\
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
-#define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
 #define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
-- 
2.28.0.rc0.105.gf9edc3c819-goog


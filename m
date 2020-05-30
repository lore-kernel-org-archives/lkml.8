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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF40C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8627A20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGe+j8KH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgE3WMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgE3WLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C04C008745
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k18so3186683ion.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WioOq0hKV6kFKCChNdKuttnuOw48RLC5l8o8PRGkfd4=;
        b=NGe+j8KHStZgxX+T5pYWOCrk1S5q5XtPVOlvhESSHuymtoioA679QaL2Js6W7yC5EZ
         DVrYn64owtKY1ROaIe2o7K+XI1Yy3kEbFbbIIWW9y/djLStpUGoslDMf1gEncPEERy9E
         kOqLKi5bIZAU3+QHYB+xh3O3qBMgPCl0yxR7hSlfH/WIm5QLiB4Y6JmPHlHQlze+RXqn
         kWbtp/76ZQV17vcE9EiV5G4cepnm2AQTBzL+Z55uLZKOGK6KRyeJ06sPOYtCbqwJjosQ
         KF/A2yDluMrHLmAdfsh4njpoeJ6Xnciu6B1o1EBou2hxUZG+QLpvS2Y1sHYURnCA/wip
         jVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WioOq0hKV6kFKCChNdKuttnuOw48RLC5l8o8PRGkfd4=;
        b=LPKebBmoI8hDPX9Oar/n/AGXa9DLXEYXD9ujpRiBQZDkp79kV4P7BzdawjI01oP1Gz
         61WjVmFCTto2I/YarFuDR41HjoSy7p4FLhipa3xLJ9vLJtLi3oCivOKiWx5p+/pu1p9z
         656LwgYJl5uhHqXayZhOCYerTc+YZm66OmFBiKMaDKaJ+48k05CntVQWthCscEEhhCnV
         +x+L7LaqcsuoZG6YD7YaNUhsYW5320tBeUb2NqcJnSa9kfB2FVlNdxIly8iuUm4A6RZP
         iF7hoP6kaciEAfT+TrTgDWx+T32/vSDsDIecOnrfihoYXuyTBuS69EDBVvlZMpVOlC9X
         8pOw==
X-Gm-Message-State: AOAM533i1Vr5Sm/Dn8b85dVjlWI0apSd6m4s53LSw7SOyCHh7kyzBJqc
        PrDt2DWSQlU4TH4jm5fGl2G77VV/zA==
X-Google-Smtp-Source: ABdhPJziiSxpBE7wDEDe0BMnPDPyE7GS6dAerCls2CemjpH9bFmzyxEn9Ghbvzj7xuELBsXqquv9nw==
X-Received: by 2002:a05:6638:419:: with SMTP id q25mr13335390jap.99.1590876708561;
        Sat, 30 May 2020 15:11:48 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:48 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 09/10] x86/percpu: Clean up percpu_stable_op()
Date:   Sat, 30 May 2020 18:11:26 -0400
Message-Id: <20200530221127.459704-10-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
References: <20200530221127.459704-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __pcpu_size_call_return() to simplify this_cpu_read_stable().
Also remove __bad_percpu_size() which is now unused.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
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
2.25.4


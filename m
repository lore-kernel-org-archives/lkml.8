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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D26EC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91FB20773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ut+dWC7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgGTUuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgGTUug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id t7so484711pjl.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+s/g7aIJprAPntFnrImPLRWCyu/2UEeG13Ydv/LyQTw=;
        b=Ut+dWC7SOOcNdFNw2LrNCEVgHBKJWfSVEgetFHfc6+Vdc98YTcX/dfZWQXKq3sj42+
         PUT4Rxi7Ehl1ZDKzUSbN0DeghSA5fYtqZFven9K+OT1yRBcu+Nswfly26Wif6g13r2LR
         FmFv+cp7DpLGRbfnWj/n0fNLq49rzqwE4PxI/sWLYkBmrUWisFuN6iGBukZpWKVuau5Q
         82U8atwWp0QMUhOj4tNctutdQ8fCsfXEEi3COMyen//uRV8jmzkuE9z2kT9yEBMZS6T+
         XSIwRjLFFt2SVkWPQdSvv4D/WgBeKKtDFpGh4AfTi2b9xUZX+mgdQ9T+tMxDDzkPihdk
         HLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+s/g7aIJprAPntFnrImPLRWCyu/2UEeG13Ydv/LyQTw=;
        b=UJfaAdjEPCeDlmBzQOCPmBWPwiyMLnfHd8f8aP93heaDp904TKmXmvqhbNjSSY6DBm
         sDA08dMDGP0hFP6ihAz/DJDkr5t9lfJCeD3jXNaXjYmnlWUPaXlXlwEYVUciirMJVMfq
         /vvimRab3jTNmIhhDqsHAt95Rgsm0Do1NIc38lznWApGFF9xqIGBU9QzjnMhx2L3QVzB
         LOwuvaW2OLqmioHAPN/l28LzcOOMdSEyKKHTgsEqbfthLqcOb7eekRMVWgRIKTe3Hg/N
         2zKPs6MJPAIZqsB0x5d0T/VX3lJ0kGFum7E8PwzgsIPkF4SyR83/67bQYBYNRxQHYvCy
         J9Qw==
X-Gm-Message-State: AOAM5312e76mhMeE+p8HoMFKgeFelVK4Ex8q86S35jK5UFeXKSUV7Sdy
        I+/G2SMOdRptb60a6Mo2RSUJxptGpIMtIb8sKh0=
X-Google-Smtp-Source: ABdhPJwsUgClcPtUeX9jeGNsUmOG9E94C+eWLi7pMMcx5w2/jryaZ3HW1MQCe4DxMhUWBBnR+/DBv8mVBFlRvH80Cco=
X-Received: by 2002:a17:90a:bf09:: with SMTP id c9mr1119491pjs.221.1595278235781;
 Mon, 20 Jul 2020 13:50:35 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:24 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-11-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 10/11] x86/percpu: Remove unused PER_CPU() macro
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

Also remove now unused __percpu_mov_op.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/percpu.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index cf2b9c2a241e..a3c33b79fb86 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -4,33 +4,15 @@
 
 #ifdef CONFIG_X86_64
 #define __percpu_seg		gs
-#define __percpu_mov_op		movq
 #else
 #define __percpu_seg		fs
-#define __percpu_mov_op		movl
 #endif
 
 #ifdef __ASSEMBLY__
 
-/*
- * PER_CPU finds an address of a per-cpu variable.
- *
- * Args:
- *    var - variable name
- *    reg - 32bit register
- *
- * The resulting address is stored in the "reg" argument.
- *
- * Example:
- *    PER_CPU(cpu_gdt_descr, %ebx)
- */
 #ifdef CONFIG_SMP
-#define PER_CPU(var, reg)						\
-	__percpu_mov_op %__percpu_seg:this_cpu_off, reg;		\
-	lea var(reg), reg
 #define PER_CPU_VAR(var)	%__percpu_seg:var
 #else /* ! SMP */
-#define PER_CPU(var, reg)	__percpu_mov_op $var, reg
 #define PER_CPU_VAR(var)	var
 #endif	/* SMP */
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog


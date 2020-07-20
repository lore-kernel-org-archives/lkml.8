Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86586C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2D620672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkS0Gag3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgGTUun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgGTUum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:42 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D91C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:41 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v16so12234859qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tXgM/MA7/QFcS0+HoEb1LtIEkU6uWRnwjEeT4D6Ysz0=;
        b=jkS0Gag3X8hUtraF1pVHFEHcKq1l8B4eWlzX0C+8Kjv4dDSBmXuRj1EahSphrQs1i5
         35dbzRuFAl7+0iW0rRshYfV4l1VMVsUQGJIvFlVAnfby5bsZYMkN43ilawn1Iwr+SXVc
         /xTZXlAdYTqJQe+RapYqD9Dkx/guyBZtvcYp/E2peHEvDOsHX+TGdxWI4iyrjQSobUFX
         euTPjYgG+j4tc50RUsPYCRYpa/7H+72TNPnM1bNOEziJIGT+mi0EbzHMOiAxmCa5g4GN
         gNkRhPJYuCzK6s1gskiDYndhWeXddLfinWMXRgMISQ7LkxhbgwTUNtAI18NozZinu5ad
         NA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tXgM/MA7/QFcS0+HoEb1LtIEkU6uWRnwjEeT4D6Ysz0=;
        b=bPNmglMvyLxoGg/QG4w5Vtv86XXYBdOrayS6M1d2/WTMBxvQLNLYMtzgAu+y77jc/b
         P1ZKVLOCBBviI2L+/Eh30wCzHJhnR6B6wqNboKMzH/3VWwc1/upBL6HKgf4aZ3oQ3TqS
         2ubskYzgbElmChOMrbL1CECLfB2QDxeB4jy1l+ViGGi6QZFQyDMBZ8/0kKUYL5A3++R1
         YymXUhmDUysyAjwurDV7o9E2kh8edW82zdOEWUKkcHlnyJuoWgxoSGewZWWSHR9D2s+y
         OXG13ZVNdfvRnXAEshT2+9rvMa20QHg2P/cm/pTfM529feX942DLqw4CKxpWFNgYwzj7
         A7tw==
X-Gm-Message-State: AOAM532YHAdsVFVBh9vJ+abMI6kLSgW7YPi4SRrRKLdAv/mk9d6PTYJF
        nawOIlyr4dLk4VJTV2zkEYqCJ2ncLmQJPXp49jg=
X-Google-Smtp-Source: ABdhPJz14dFOoBuPUFbrIPageIhnxzzSEJXfJjfr4f4k7gaqi4oG3PX4O1eclESBnMcBzYIhZv1qNUgUJU+Tf++VzRg=
X-Received: by 2002:a0c:ea26:: with SMTP id t6mr23459159qvp.220.1595278241089;
 Mon, 20 Jul 2020 13:50:41 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:25 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-12-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 11/11] x86: support i386 with Clang
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC and Clang are architecturally different, which leads to subtle
issues for code that's invalid but clearly dead. This can happen with
code that emulates polymorphism with the preprocessor and sizeof.

GCC will perform semantic analysis after early inlining and dead code
elimination, so it will not warn on invalid code that's dead. Clang
strictly performs optimizations after semantic analysis, so it will warn
for dead code.

Neither Clang nor GCC like this very much with -m32:

long long ret;
asm ("movb $5, %0" : "=q" (ret));

However, GCC can tolerate this variant:

long long ret;
switch (sizeof(ret)) {
case 1:
        asm ("movb $5, %0" : "=q" (ret));
        break;
case 8:;
}

Clang, on the other hand, won't accept that because it validates the
inline asm for the '1' case *before* the optimisation phase where it
realises that it wouldn't have to emit it anyway.

If LLVM (Clang's "back end") fails such as during instruction selection
or register allocation, it cannot provide accurate diagnostics
(warnings/errors) that contain line information, as the AST has been
discarded from memory at that point.

While there have been early discussions about having C/C++ specific
language optimizations in Clang via the use of MLIR, which would enable
such earlier optimizations, such work is not scoped and likely a
multi-year endeavor.

We also don't want to swap the use of "=q" with "=r". For 64b, it
doesn't matter. For 32b, it's possible that a 32b register without a 8b
lower alias (i.e. ESI, EDI, EBP) is selected which the assembler will
then reject.

With this, Clang can finally build an i386 defconfig.

Link: https://bugs.llvm.org/show_bug.cgi?id=33587
Link: https://github.com/ClangBuiltLinux/linux/issues/3
Link: https://github.com/ClangBuiltLinux/linux/issues/194
Link: https://github.com/ClangBuiltLinux/linux/issues/781
Link: https://lore.kernel.org/lkml/20180209161833.4605-1-dwmw2@infradead.org/
Link: https://lore.kernel.org/lkml/CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com/
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: David Woodhouse <dwmw2@infradead.org>
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/uaccess.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index dd3261f9f4ea..9d57556ad42f 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -314,11 +314,13 @@ do {									\
 
 #define __get_user_size(x, ptr, size, retval)				\
 do {									\
+	unsigned char x_u8__;						\
 	retval = 0;							\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1:								\
-		__get_user_asm(x, ptr, retval, "b", "=q");		\
+		__get_user_asm(x_u8__, ptr, retval, "b", "=q");		\
+		(x) = x_u8__;						\
 		break;							\
 	case 2:								\
 		__get_user_asm(x, ptr, retval, "w", "=r");		\
-- 
2.28.0.rc0.105.gf9edc3c819-goog


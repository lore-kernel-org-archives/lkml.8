Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B822EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E016218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSRXMR3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEHSGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726746AbgEHSGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:06:14 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96C7C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:06:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id l19so2878836qki.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Seq80qMnpV5lUbkXBM+vOtEwBiiBytr6Pd0tsbHxHk=;
        b=KSRXMR3dtf6i0Vu/WYcKhtiHWNQwjnJES99Zqdgjpv5uFksyP4Xk6V2OA0wJDJMbMu
         3HIFWvbtn7v60z/jkWEgIYf0uKnr4CDYlvgLZe3P9hBrtzo4fJN7S8ahrQB60zGy9WAH
         zD3QOn46FYuOP8xrnlGAO9LlDm8+hBhqDswgY5HPArWF6rALtrjxJKST0ItTbRCpo0pg
         YXs4W1B7GLOnZtBk97bfUW3xI2syxucVA3tBgf0ef2TvmrDqpcOQV+L7GhgmLiT41An/
         mhuRr+IfwGzTZIEzvP7wUQpI/zXZLAlnfode2nHSt6X5rzr7HW1bMqvPo/t+SRdyTcS+
         AJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Seq80qMnpV5lUbkXBM+vOtEwBiiBytr6Pd0tsbHxHk=;
        b=bpxy1tOXcfDq9sSohFZzyU1APkH/KRjQGtdwbjkrd7gB12MlnnS6BR6AKH/QWIckZi
         LgEqHx5fatWWBd5sP4K7NS39ZSosq08AmANwrmCk/NLX3IMZcqK/0btoNSCdPUeXTNBw
         vOfRUR3xdBbZKy7ZT8tc0bvblm9RKm4c0qrKLAJ9ykqeaqXM1lRK/EixOM7lr3qtgUIl
         mh6IPnRg994TFFqRIQMSyFgjTj/lskrByYy4Xz9lanC+bRPQToAXFxuUvZeYJAsvYBMn
         8yYlIgXj0w0EhrQ/LrjiWHAw7/LJftv0tPsANISrTQ5l8YmxCcZAXJjE7mebqVHd0akP
         1axg==
X-Gm-Message-State: AGi0PuYMDGff9PEe+T6oZGqxvo+DR2tuQ4HX9GLhuEaOeqNW+lHiQtE4
        bdJA2g0OCcnzfYi5ggdQ9Wc+JUWaWS8KehzuOes=
X-Google-Smtp-Source: APiQypIsgbDhDgIf6srlp2D5JZEGmR+qOgu3pjYhtLDbb5bdP2dLggJYkT/YyY7UkdtoSD+4td/VmRmSnvpjfgXAZ5E=
X-Received: by 2002:a0c:b601:: with SMTP id f1mr3695594qve.99.1588961172818;
 Fri, 08 May 2020 11:06:12 -0700 (PDT)
Date:   Fri,  8 May 2020 11:05:48 -0700
In-Reply-To: <8f53b69e-86cc-7ff9-671e-5e0a67ff75a2@zytor.com>
Message-Id: <20200508180549.212957-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <8f53b69e-86cc-7ff9-671e-5e0a67ff75a2@zytor.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v3] x86: bitops: fix build regression
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ilie Halip <ilie.halip@gmail.com>, x86@kernel.org,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is easily reproducible via CC=clang+CONFIG_STAGING=y+CONFIG_VT6656=m.

It turns out that if your config tickles __builtin_constant_p via
differences in choices to inline or not, these statements produce
invalid assembly:

$ cat foo.c
long a(long b, long c) {
  asm("orb\t%1, %0" : "+q"(c): "r"(b));
  return c;
}
$ gcc foo.c
foo.c: Assembler messages:
foo.c:2: Error: `%rax' not allowed with `orb'

Use the `%b` "x86 Operand Modifier" to instead force register allocation
to select a lower-8-bit GPR operand.

The "q" constraint only has meaning on -m32 otherwise is treated as
"r". Not all GPRs have low-8-bit aliases for -m32.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/961
Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers
Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: kernelci.org bot <bot@kernelci.org>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V2 -> V3:
* use `%b` "x86 Operand Modifier" instead of bitwise op then cast.
* reword commit message.
* add Brian and HPA suggested by tags
* drop Nathan & Sedat Tested by/reviewed by tags (new patch is different
  enough).

Changes V1 -> V2:
* change authorship/signed-off-by to Ilie
* add Nathan's Tested by/reviewed by
* update commit message slightly with info sent to HPA.

 arch/x86/include/asm/bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b392571c1f1d..03e24286e4eb 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -52,9 +52,9 @@ static __always_inline void
 arch_set_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "orb %1,%0"
+		asm volatile(LOCK_PREFIX "orb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" (CONST_MASK(nr) & 0xff)
+			: "iq" (CONST_MASK(nr))
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
@@ -72,9 +72,9 @@ static __always_inline void
 arch_clear_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "andb %1,%0"
+		asm volatile(LOCK_PREFIX "andb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" (CONST_MASK(nr) ^ 0xff));
+			: "iq" (~CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
-- 
2.26.2.645.ge9eca65c58-goog


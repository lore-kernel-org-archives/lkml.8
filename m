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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEBCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6F12070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjvUB1eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEHS24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbgEHS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:28:56 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22074C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:28:56 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g14so2905533qts.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gHn/2PDn6yjgb3WH2Lc+VyVXY4H0phF5Pi1gV5PCjZk=;
        b=rjvUB1eL7MzUUYdWtuJAUwfONXpWbiaW5x98GWLZRBmtGsh7aH3Bt/OtGn2CkgI4jt
         Y8Y2B2rLSZh4ueT/jkcCsS/uWV2wpJm+rBPnbrh23K+Co3EwfSrm0JK1picj8efKaQNs
         eLhZaMbm23NU/p+Vli/n+G7qrVeYJ+0lI1Za8fBB6gZKPKyNgdIG+BvqOUIdK9eYc0Ct
         wU3bc/WOzLbYjAimo3amzE8XAXkmYLFjz2kGQ3pSgwtuFKkG43c32ThK6zTLajBgPJTF
         tqzZfu0sqGuKRbcP8T0aWYPn34hLcEJ2dzLxVne8M7l2HPRSIdnKxVCqOgGqdpRz46Bw
         /BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gHn/2PDn6yjgb3WH2Lc+VyVXY4H0phF5Pi1gV5PCjZk=;
        b=R2RHWdSowS0QD3bpOtP85KyUD7TuPbh/edP+n4v0UGYGg+cjO0+OL4hBKJeHWB5fyw
         JlnP7YyLR6DJlnGH/81sVVRyXqZkFXbrHYtz3LzndtvuBdf9sWhhe9lYU6X3wVV7rdXs
         SigNtL29eV8oZtwquS/GIn5mn+DPXnO1U4QHIvTv0G2CIG3RWv9lxjTb+gquETKpm1Tk
         gkSixfgHwArziImNTqaoIY1lBZtifXarhRLNSf4k92RCA65QqH46Uh1cOD01sd2R7QYr
         NfAFc6E2zd5F+uwdNHJ/uAXk+eLelaMN9SBM5tY56dMcU+9+9tL7eOTcvmqnEOMcfEdf
         SssQ==
X-Gm-Message-State: AGi0PuaVbpENwocpMLNl/IPMfB6tsVsK/W8FT/wjuVElZ0PKARzR0iqW
        jUSYqgmbLCzBa5akWU1iokkzaCeRd/gymS7znIQ=
X-Google-Smtp-Source: APiQypIf3RpQQwqofMB63kChBe8hFGukiFuVZx9kg9C6iB4OleN/nHALl2EXggCM0j0aLsJC25suSlWfRl74K6AD6wI=
X-Received: by 2002:a0c:f1d1:: with SMTP id u17mr4080224qvl.146.1588962535235;
 Fri, 08 May 2020 11:28:55 -0700 (PDT)
Date:   Fri,  8 May 2020 11:28:35 -0700
In-Reply-To: <CAMzpN2ix+Ltu2_4ORaeqD0_6VmDUxTRDVbvaJ+Q9D8s-5p7Bhw@mail.gmail.com>
Message-Id: <20200508182835.228107-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAMzpN2ix+Ltu2_4ORaeqD0_6VmDUxTRDVbvaJ+Q9D8s-5p7Bhw@mail.gmail.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v4] x86: bitops: fix build regression
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
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
Changes V3 -> V4:
* drop (u8) cast from arch_change_bit() as well.

Changes V2 -> V3:
* use `%b` "x86 Operand Modifier" instead of bitwise op then cast.
* reword commit message.
* add Brian and HPA suggested by tags
* drop Nathan & Sedat Tested by/reviewed by tags (new patch is different
  enough).
* Take over authorship.

Changes V1 -> V2:
* change authorship/signed-off-by to Ilie
* add Nathan's Tested by/reviewed by
* update commit message slightly with info sent to HPA.

 arch/x86/include/asm/bitops.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b392571c1f1d..8a8b7bb9677b 100644
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
@@ -125,7 +125,7 @@ arch_change_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "xorb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)CONST_MASK(nr)));
+			: "iq" (CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
-- 
2.26.2.645.ge9eca65c58-goog


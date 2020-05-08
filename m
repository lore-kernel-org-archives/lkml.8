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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F601C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24742192A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmHF58mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgEHSdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727912AbgEHScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:32:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744BDC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:32:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j4so3112575ybj.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FPRqIEOz/J315Frt792WPRyPEbSrc7Yr875aFZ8nAdU=;
        b=fmHF58mRYnKl5h9O1RZdYYo4zIc6bO24baSAbYSafH8GC0KhGEgNKOCPvN6r2s9z6d
         sxGcjR7l+dVhWL6Ouc7Tag1kffLuNPz1kltEfg8/xUEKMgI4YDFvckGsS9/xQZEn9j5H
         1+gVH/51wePjhCjcwkl+UzVEyUnxFIgV4Xt9D8MB7sMe7Mv/hUtQu3IdWjjsbSniKwsG
         QhsK6y76IoYsYez+XtHQc8i1eMGoJT8Gyxhb4tQtnVdZ+uLrEfX80r/lnRmJSeeb9wrZ
         3ZRGYxu0tSXTIaIuH6vPxxltg6mxmc1qikLFmDcgzctt9uqOvd0//Nnc80eeQusKUUwa
         9dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FPRqIEOz/J315Frt792WPRyPEbSrc7Yr875aFZ8nAdU=;
        b=H+An76Ow8dVWZXG/b5OFW7QTuWeMrDERHl/ULvPTpTsboM2ELN4rDfnDU2C1ar4XL5
         0qiWSWSFIhxLqSWfTEABNLuezfMgou+mNX975qmocCM4kyamjhD9Gf/+HYe1JXy+Fazf
         9+BrvYAPbcgFupjQECVC1dv2f1w89vYidCxMAZdv2VCHWT81aZuT9z3oVOUMR8soYEBp
         jYfdPKGieaAIoWM1tLgPv3p7I6qQsIwPGdgDm7SgSF2qpVeTKjktUJaY4lsaaYdlyrgd
         iFRwR9GjBt1yWa72LxrbJP4EwS3gg0/QexQMbvElO0C2ne53HxDPnCw84peiao6qdlC0
         /k+Q==
X-Gm-Message-State: AGi0PubuU1byCegMhCNNFwHCjEODX4Ssxxn2hTV7Uf90zW2muie7T2Wj
        GHdSeQioa1vMZvJ5M8UwbnDFadyIatvR0uNFK/U=
X-Google-Smtp-Source: APiQypJm2V+ASHbtOEd8O5v0O279w3n8Y+g3e7MozHDUcMEV1M+wxJ/VOVa04jK5mlcKnN27JhUhvFaAdFXH/yRRjQM=
X-Received: by 2002:a25:db87:: with SMTP id g129mr7075314ybf.491.1588962754640;
 Fri, 08 May 2020 11:32:34 -0700 (PDT)
Date:   Fri,  8 May 2020 11:32:29 -0700
In-Reply-To: <20200508182835.228107-1-ndesaulniers@google.com>
Message-Id: <20200508183230.229464-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200508182835.228107-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v5] x86: bitops: fix build regression
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
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
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
Changes V4 -> V5:
* actually use `%b` in arch_change_bit().

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
 arch/x86/include/asm/bitops.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b392571c1f1d..35460fef39b8 100644
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
@@ -123,9 +123,9 @@ static __always_inline void
 arch_change_bit(long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
-		asm volatile(LOCK_PREFIX "xorb %1,%0"
+		asm volatile(LOCK_PREFIX "xorb %b1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)CONST_MASK(nr)));
+			: "iq" (CONST_MASK(nr)));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
-- 
2.26.2.645.ge9eca65c58-goog


Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F6FC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31FF20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgWb0Sh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgEESXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgEESW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:22:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 11:22:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 207so1378045pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PToLYAimVAsZtUfzGzNopJPy83pb8+TOtuhkhnpZbnA=;
        b=FgWb0Sh5Z3EcYyUZhECJJ4WRLshOPMOgvqWT4p4cYa5YQjLsklzTMRTvb5M+xfPSaq
         AP4Q9ob81bvD5lM0lLBw+uwe6NU0cwHsVnzwLQSFvzGWmr4B57OvihqTiAVo0QfcKa1Z
         UrRJ7zJZxVHhkCnulxTEjmENj912FhPejNRtFSUsSuvXp9q2lKbmnlNtWwUqmdsHaGZG
         Gm5p6nRHe6U2Ci5+Kvq867p42119l09rmT5y7yCebPrkIb08GK0TWc8H4YHgKsfFbFqk
         dmld3WpkQQ6In9tPUXdekz5X35xkllzQL5IiUuh9PLUh2bWAf/JOhbO4sYPT2HB2V/UM
         G4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PToLYAimVAsZtUfzGzNopJPy83pb8+TOtuhkhnpZbnA=;
        b=MTuShnDl58jL8tsgumeziZZVD+9jLDkiqNDYHLUrdvwuw2OoHPbotafVu4IFq1eC8J
         KvLJbUXKW1bv6yHDIwIPt12A0VBE92AuwYG2mrMzMtQZliAHZCrFtNDNKaq5gYEenk9F
         Yynlpi58CIjZVrdkwxYBmEAfym85iRtsfXF6jAAfoMbVNf1uqH0qX8CaZKewro84kTEk
         eDLJAMH4NiFcbBiuXUQw/vkqIc3qbLsTQVV2G/Wdi24rPlqAMhItxjiiMOryde/1zQ2E
         q6PrHjRbtXp8BoshV51bQyURHrpxkRxkMlKMfBVKKRDmFvwzsSIooz1/Cr4d44H8kuJs
         Rv/w==
X-Gm-Message-State: AGi0PubuSQxuhWfcT4PXE9ycAvv9nXzDZQ/dNpHA03kV5406Q5XjAu06
        WPKJXrn5jrPN7WQEvbhDgLOw+1lLgwqqYvJw+8fOEA==
X-Google-Smtp-Source: APiQypKSPWEyDKwJ3ovCYgt2orqxoiB29zoBVD6bokNDP4gPN8n1JHWythabwhZmSuTxa13QTc/5kNbanXXq98paRs0=
X-Received: by 2002:a63:6546:: with SMTP id z67mr3795479pgb.10.1588702977435;
 Tue, 05 May 2020 11:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200505174423.199985-1-ndesaulniers@google.com> <8A776DBC-03AF-485B-9AA6-5920E3C4ACB2@zytor.com>
In-Reply-To: <8A776DBC-03AF-485B-9AA6-5920E3C4ACB2@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 11:22:47 -0700
Message-ID: <CAKwvOdkcQwwpx5JMJpGg4cO3RLfoLtWvWjgnuXyzas1X3eyvWQ@mail.gmail.com>
Subject: Re: [PATCH] x86: bitops: fix build regression
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 11:07 AM <hpa@zytor.com> wrote:
>
> On May 5, 2020 10:44:22 AM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >From: Sedat Dilek <sedat.dilek@gmail.com>
> >
> >It turns out that if your config tickles __builtin_constant_p via
> >differences in choices to inline or not, this now produces invalid
> >assembly:
> >
> >$ cat foo.c
> >long a(long b, long c) {
> >  asm("orb\t%1, %0" : "+q"(c): "r"(b));
> >  return c;
> >}
> >$ gcc foo.c
> >foo.c: Assembler messages:
> >foo.c:2: Error: `%rax' not allowed with `orb'
> >
> >The "q" constraint only has meanting on -m32 otherwise is treated as
> >"r".
> >
> >This is easily reproducible via Clang+CONFIG_STAGING=y+CONFIG_VT6656=m,
> >or Clang+allyesconfig.
> >
> >Keep the masking operation to appease sparse (`make C=1`), add back the
> >cast in order to properly select the proper 8b register alias.
> >
> > [Nick: reworded]
> >
> >Cc: stable@vger.kernel.org
> >Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >Link: https://github.com/ClangBuiltLinux/linux/issues/961
> >Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
> >Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
> >Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> >Reported-by: kernelci.org bot <bot@kernelci.org>
> >Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Suggested-by: Ilie Halip <ilie.halip@gmail.com>
> >Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> >Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> >Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >---
> > arch/x86/include/asm/bitops.h | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/bitops.h
> >b/arch/x86/include/asm/bitops.h
> >index b392571c1f1d..139122e5b25b 100644
> >--- a/arch/x86/include/asm/bitops.h
> >+++ b/arch/x86/include/asm/bitops.h
> >@@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
> >       if (__builtin_constant_p(nr)) {
> >               asm volatile(LOCK_PREFIX "orb %1,%0"
> >                       : CONST_MASK_ADDR(nr, addr)
> >-                      : "iq" (CONST_MASK(nr) & 0xff)
> >+                      : "iq" ((u8)(CONST_MASK(nr) & 0xff))
> >                       : "memory");
> >       } else {
> >               asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> >@@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
> >       if (__builtin_constant_p(nr)) {
> >               asm volatile(LOCK_PREFIX "andb %1,%0"
> >                       : CONST_MASK_ADDR(nr, addr)
> >-                      : "iq" (CONST_MASK(nr) ^ 0xff));
> >+                      : "iq" ((u8)(CONST_MASK(nr) ^ 0xff)));
> >       } else {
> >               asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
> >                       : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
>
> Drop & 0xff and change ^ 0xff to ~.
>
> The redundancy is confusing.

Thanks for the review.  While I would also like to have less
redundancy, we have ourselves a catch-22 that that won't resolve.

Without the cast to u8, gcc and clang will not select low-8-bit
registers required for the `b` suffix on `orb` and `andb`, which
results in an assembler error.
Without the mask, sparse will warn about the upper bytes of the value
being truncated.
(I guess that would have been a more concise commit message).
-- 
Thanks,
~Nick Desaulniers

Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB273C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F383206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFxgVVwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgEER3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEER3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:29:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D250C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 10:29:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so1088433plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHcXHJ8ma+wHdOnq6wbVgZKgLxUnEELMmnMVXInJOCs=;
        b=QFxgVVwUcZjMbp8kD9oXT7EVHZUxsKuReDdqqKCVYXKWf2hOOValeougGSA5KojQjm
         HnYyb3Tyc3cKTJWNmy0j/kkImorKLiZ2MATkWbxwum7sPvSyLLDLWXSV9xQBRsjNhvCk
         nkO8uDEhaLjHQ2jYdj9Am4WKZdnV2O0cGHsVVzWetCni3Oe/GE+9Fc6IZOR+fAwGiq6U
         S3ex4fNAZ9fTplxoRFobYUBamjeiU+5zOMzEOz32x9o4k1kmvdKS6T8bSAtvyUcKDSr5
         2cQWBcNp6g4IBkT4d1XhVdhUf5o0mHUAnJLqxH2kl/V9Rm4RZ0YBzMz8uGcP2/Jmx231
         RfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHcXHJ8ma+wHdOnq6wbVgZKgLxUnEELMmnMVXInJOCs=;
        b=ZvrmCKOWZU5NTOYXOJneSLziTTIYQwMglVVFz6kQXihbS50bNR8ScWSTTXzm47cmER
         7ZDgUR8vq2k2Hm7twfod4gWp3Z19DkbTD+7X0Qh+jfEazwlcjGHvNIVW+JCD7KWx1IDY
         rHi9Ghwi3ovl9OgAa8tt33owQfU1e17TLjlcsZ7o76uJNn+s6tXaVDMZJbHQcAZkyFCF
         a0gVTBD6iWR7G5VRFB/1FJROUKAnxfXkyeSmbFbK9lVC+qnMU7q58vjuAyyx8XwOW4yb
         JH80hGwHMPZ2+NKBbVrmLLaIy2WCRpNcbV51fa2FvfpEvlnuR/QFwf52H3Nw4awdxVcF
         FqfQ==
X-Gm-Message-State: AGi0PubQ8H6dXK2fMINMMKW9G0W3GsF2yVhA7F6uqUL6A2w6CY+jcD2U
        9SfP67Yf9PbCKf80wY8DM2OSHH3EyUHZ0UK1jW/sCw==
X-Google-Smtp-Source: APiQypLeRLINeL1L1L0WYEwrIUEXGVU1ZCMgEauEPmxfA7PjUVfU4MWi6GMoRGCeE3CpyoNX55m7TUDjpHaiaU7TF5M=
X-Received: by 2002:a17:90a:6488:: with SMTP id h8mr4415749pjj.51.1588699752126;
 Tue, 05 May 2020 10:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
 <20200504193524.GA221287@google.com> <20200504181443.00007a3d@intel.com> <20200505151438.GP185537@smile.fi.intel.com>
In-Reply-To: <20200505151438.GP185537@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 10:29:01 -0700
Message-ID: <CAKwvOdn503VpMu6x5qtmeQrcVnwkAqu6gnoU0Pb99sX98aZPHQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] x86: fix bitops.h warning with a moved cast
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ilie Halip <ilie.halip@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 8:14 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 04, 2020 at 06:14:43PM -0700, Jesse Brandeburg wrote:
> > On Mon, 4 May 2020 12:51:12 -0700
> > Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > > Sorry for the very late report.  It turns out that if your config
> > > tickles __builtin_constant_p just right, this now produces invalid
> > > assembly:
> > >
> > > $ cat foo.c
> > > long a(long b, long c) {
> > >   asm("orb\t%1, %0" : "+q"(c): "r"(b));
> > >   return c;
> > > }
> > > $ gcc foo.c
> > > foo.c: Assembler messages:
> > > foo.c:2: Error: `%rax' not allowed with `orb'
> > >
> > > The "q" constraint only has meanting on -m32 otherwise is treated as
> > > "r".
> > >
> > > Since we have the mask (& 0xff), can we drop the `b` suffix from the
> > > instruction? Or is a revert more appropriate? Or maybe another way to
> > > skin this cat?
> >
> > Figures that such a small change can create problems :-( Sorry for the
> > thrash!
> >
> > The patches in the link below basically add back the cast, but I'm
> > interested to see if any others can come up with a better fix that
> > a) passes the above code generation test
> > b) still keeps sparse happy
> > c) passes the test module and the code inspection
> >
> > If need be I'm OK with a revert of the original patch to fix the issue
> > in the short term, but it seems to me there must be a way to satisfy
> > both tools.  We went through several iterations on the way to the final
> > patch that we might be able to pluck something useful from.
>
> For me the below seems to work:

Yep:
https://github.com/ClangBuiltLinux/linux/issues/961#issuecomment-623785987
https://github.com/ClangBuiltLinux/linux/issues/961#issuecomment-624162497
Sedat wrote the same patch 22 days ago; I didn't notice before
starting this thread.  I will sign off on his patch, add your
Suggested by tag, and send shortly.

>
>
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index b392571c1f1d1..139122e5b25b1 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
>         if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "orb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
> -                       : "iq" (CONST_MASK(nr) & 0xff)
> +                       : "iq" ((u8)(CONST_MASK(nr) & 0xff))
>                         : "memory");
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
>         if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "andb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
> -                       : "iq" (CONST_MASK(nr) ^ 0xff));
> +                       : "iq" ((u8)(CONST_MASK(nr) ^ 0xff)));
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


-- 
Thanks,
~Nick Desaulniers

Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EABC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891F220B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqU4WoJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgEFQtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730590AbgEFQsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E8C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:48:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 145so1260925pfw.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYzSetl93/pxTqOYZg3cigxftxW+mQd4kGIUi5KwOak=;
        b=FqU4WoJo+MTUD/KuwTuWbIi1/OIw/pyW/WVA3Ta5gFizuevTaucdpaWlqWdZDC9QV6
         Uorc0KUybzJHP7y6KidDbMyV9jl06Gfnwau4aly8fKI+HxFCl83TnxCUGWU0/hqTcLgu
         N7q5IMxBj3G46TivSejtqD3BWfgDnl1nI87HgXKhPaR8Hr2LjN9pSOMiPXFRDxqsZ/hV
         Y9uZ8BvvNgw/D9qAR/YVbLs7kk2JERu2M8rAD3laOXlVSI0Yk7OKy6m08Zx/JqL6XEnT
         C+wFEmlhWEye70V+mnCiPbFyRxBhZEqhLIMcsJYySOzmnm4+DURTY85OM7web784lVyb
         NK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYzSetl93/pxTqOYZg3cigxftxW+mQd4kGIUi5KwOak=;
        b=aZHT+RD5dyO79dBdv+OdbAZSmrQ5KefIVWRkO1VCvZP8Rk1XUSCKE3rreb+CruzTpe
         s4v8fCLixiPjcQePEswfpStVQnR/e7TNBUdhgLt7iX6J40sXmUt4sTm+ALgbnuUHnrGQ
         IPe/w1bnu40/LZ/EUYWbfJ9/xMtZ7Mp+WtqnEvzxsVcAX+DYEqfu9o6kIHnPQDEOcHz6
         in2WeT8lbhfC9kEOh3e7h5BCtqgi6OhAFoRyv6ZaKYukb3XqJ4pq7sx/C+sdyY0SauUQ
         ex2EbbCbOI1UB8KbBleY2LNmN3VjbuQRzs3qjk32NJSSPFWW87ZWeftxg00weZlM0wwV
         pc1g==
X-Gm-Message-State: AGi0PuZfIRkO9dzFbkirdpXpJg3eeABIaEX7TXXELtFDJigA2SE8zceV
        CJjhJdtOFq+eE/pNxLCpRwsc/Xq/jegmWLjv0iK5u0+3
X-Google-Smtp-Source: APiQypJPuB5aNYxOypntRL79UjBg9Im7SyOd5hvAG2g0VRMfZ0uw63UR2tZW30r3WUcvW1I8D7suUJE2CsbMOQO/kZA=
X-Received: by 2002:aa7:81cf:: with SMTP id c15mr9185836pfn.211.1588783733947;
 Wed, 06 May 2020 09:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <202005051617.F9B32B5526@keescook> <20200506001453.764332-1-Jason@zx2c4.com>
 <202005051953.AF54DA4@keescook> <20200506035351.GA599026@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200506035351.GA599026@ubuntu-s3-xlarge-x86>
From:   George Burgess <gbiv@google.com>
Date:   Wed, 6 May 2020 09:48:17 -0700
Message-ID: <CA+rzOEmt8MUiXZcN7LPz3yedteHodxLN20L1UPtb2qXKeuunrw@mail.gmail.com>
Subject: Re: [PATCH v2] security: disable FORTIFY_SOURCE on clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        arnd@arndb.de, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I took a bit to poke Clang here. Building an arbitrary file with
`CONFIG_FORTIFY_SOURCE=y`, none of the functions in this range
https://github.com/ClangBuiltLinux/linux/blob/0bee0cece/include/linux/string.h#L274-L468
have FORTIFY'ed definitions emitted by clang, i.e., the added FORTIFY checks
aren't helping. Happy to check other functions elsewhere if they exist,
but given that this entire block seems to be a functional nop...

Reviewed-by: George Burgess IV <gbiv@google.com>


On Tue, May 5, 2020 at 8:53 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, May 05, 2020 at 07:54:09PM -0700, Kees Cook wrote:
> > On Tue, May 05, 2020 at 06:14:53PM -0600, Jason A. Donenfeld wrote:
> > > clang-10 has a broken optimization stage that doesn't allow the
> > > compiler to prove at compile time that certain memcpys are within
> > > bounds, and thus the outline memcpy is always called, resulting in
> > > horrific performance, and in some cases, excessive stack frame growth.
> > > Here's a simple reproducer:
> > >
> > >     typedef unsigned long size_t;
> > >     void *c(void *dest, const void *src, size_t n) __asm__("memcpy");
> > >     extern inline __attribute__((gnu_inline)) void *memcpy(void *dest, const void *src, size_t n) { return c(dest, src, n); }
> > >     void blah(char *a)
> > >     {
> > >       unsigned long long b[10], c[10];
> > >       int i;
> > >
> > >       memcpy(b, a, sizeof(b));
> > >       for (i = 0; i < 10; ++i)
> > >         c[i] = b[i] ^ b[9 - i];
> > >       for (i = 0; i < 10; ++i)
> > >         b[i] = c[i] ^ a[i];
> > >       memcpy(a, b, sizeof(b));
> > >     }
> > >
> > > Compile this with clang-9 and clang-10 and observe:
> > >
> > > zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-10 -Wframe-larger-than=0 -O3 -c b.c -o c10.o
> > > b.c:5:6: warning: stack frame size of 104 bytes in function 'blah' [-Wframe-larger-than=]
> > > void blah(char *a)
> > >      ^
> > > 1 warning generated.
> > > zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-9 -Wframe-larger-than=0 -O3 -c b.c -o c9.o
> > >
> > > Looking at the disassembly of c10.o and c9.o, one can see that c9.o is
> > > properly optimized in the obvious way one would expect, while c10.o has
> > > blown up and includes extern calls to memcpy.
> > >
> > > But actually, for versions of clang earlier than 10, fortify source
> > > mostly does nothing. So, between being broken and doing nothing, it
> > > probably doesn't make sense to pretend to offer this option. So, this
> > > commit just disables it entirely when compiling with clang.
> > >
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: LKML <linux-kernel@vger.kernel.org>
> > > Cc: clang-built-linux <clang-built-linux@googlegroups.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: George Burgess <gbiv@google.com>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Link: https://bugs.llvm.org/show_bug.cgi?id=45802
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > Grudgingly,
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > --
> > Kees Cook
> >
>
> I feel like you should finish your investigation into how broken this
> actually is before we give it the hammer like this but if it is going
> in regardless...
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

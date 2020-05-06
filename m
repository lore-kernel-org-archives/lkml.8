Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5DAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE162073B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L0zsIjjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEFDfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 23:35:05 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:57539 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEFDfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 23:35:05 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d4b1984b
        for <linux-kernel@vger.kernel.org>;
        Wed, 6 May 2020 03:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=w5ijTqKozix4OEJYDh+ZB3lJIbM=; b=L0zsIj
        jgcud13jZ89v1eLww8RGzOESf/AWlCc+TZd/4CWa8Rd/Bok4fM/xAHeFxPkWp2zJ
        tp6dPGHnJFlqyGo8Z2CcZUQTDOsYtA2LNqJ4UJiC8TkMjHwl1z5CUrMSPhNET9tM
        bx4wnBP95GpICnJvh1tUVB2dkCjeze8jevr2PnyDG5fmetjUVFNTNaapyfBeDQL9
        R+V7QcJimXEdayXo2VGUQnh7AMHEpekY+pqVjHLgbHu7TsTXny6Vi81LJA/3nRyk
        124VKkGt0bNEiWA4wulK6JxkAEtmHC0qJs+iqc6CfsXsk32zhN5Tw3MZPXSmXeZR
        gDq8aKBA73Vl3ubA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a155db1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 6 May 2020 03:22:26 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id s10so399660iln.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 20:35:03 -0700 (PDT)
X-Gm-Message-State: AGi0PubF5dxLsD5dxLCe33Z22g28dO4x0UPPkPpgcSVylSyMGFGTsNIG
        LkvoN7R/zl8g82DsijOLwkeCXUyzwEoNf6+f374=
X-Google-Smtp-Source: APiQypK2oDZgNlFCK8APE5ivQm4g13SH0DT9OG3/kGjqW6k3JwqUOPduNbQvgnMNVeADSERuh5m+BdGY7bccCDWmcmI=
X-Received: by 2002:a92:5c82:: with SMTP id d2mr7181724ilg.231.1588736102459;
 Tue, 05 May 2020 20:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <202005051617.F9B32B5526@keescook> <20200506001453.764332-1-Jason@zx2c4.com>
 <202005051953.AF54DA4@keescook>
In-Reply-To: <202005051953.AF54DA4@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 5 May 2020 21:34:51 -0600
X-Gmail-Original-Message-ID: <CAHmME9ofHLjgB3KY9xwCkhK4V78KB_XUe1kzyizfx5yQRKo0JA@mail.gmail.com>
Message-ID: <CAHmME9ofHLjgB3KY9xwCkhK4V78KB_XUe1kzyizfx5yQRKo0JA@mail.gmail.com>
Subject: Re: [PATCH v2] security: disable FORTIFY_SOURCE on clang
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        George Burgess <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 8:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, May 05, 2020 at 06:14:53PM -0600, Jason A. Donenfeld wrote:
> > clang-10 has a broken optimization stage that doesn't allow the
> > compiler to prove at compile time that certain memcpys are within
> > bounds, and thus the outline memcpy is always called, resulting in
> > horrific performance, and in some cases, excessive stack frame growth.
> > Here's a simple reproducer:
> >
> >     typedef unsigned long size_t;
> >     void *c(void *dest, const void *src, size_t n) __asm__("memcpy");
> >     extern inline __attribute__((gnu_inline)) void *memcpy(void *dest, const void *src, size_t n) { return c(dest, src, n); }
> >     void blah(char *a)
> >     {
> >       unsigned long long b[10], c[10];
> >       int i;
> >
> >       memcpy(b, a, sizeof(b));
> >       for (i = 0; i < 10; ++i)
> >         c[i] = b[i] ^ b[9 - i];
> >       for (i = 0; i < 10; ++i)
> >         b[i] = c[i] ^ a[i];
> >       memcpy(a, b, sizeof(b));
> >     }
> >
> > Compile this with clang-9 and clang-10 and observe:
> >
> > zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-10 -Wframe-larger-than=0 -O3 -c b.c -o c10.o
> > b.c:5:6: warning: stack frame size of 104 bytes in function 'blah' [-Wframe-larger-than=]
> > void blah(char *a)
> >      ^
> > 1 warning generated.
> > zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-9 -Wframe-larger-than=0 -O3 -c b.c -o c9.o
> >
> > Looking at the disassembly of c10.o and c9.o, one can see that c9.o is
> > properly optimized in the obvious way one would expect, while c10.o has
> > blown up and includes extern calls to memcpy.
> >
> > But actually, for versions of clang earlier than 10, fortify source
> > mostly does nothing. So, between being broken and doing nothing, it
> > probably doesn't make sense to pretend to offer this option. So, this
> > commit just disables it entirely when compiling with clang.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: LKML <linux-kernel@vger.kernel.org>
> > Cc: clang-built-linux <clang-built-linux@googlegroups.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: George Burgess <gbiv@google.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Link: https://bugs.llvm.org/show_bug.cgi?id=45802
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Grudgingly,
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Do you want to take this into your tree to send to Linus? Seems like
security kconfig switches is in line with your usual submissions.

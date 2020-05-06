Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF9CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B7E2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV8kYDc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEFDxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 23:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEFDxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 23:53:53 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6F3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 20:53:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m18so285803otq.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 20:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OyhbL7JQAgJYt8Ohkmi+6EE1kJF1GD6e396x9FyAdy0=;
        b=UV8kYDc0jAzvCMYFWP9jErno2uoOmBbmEVElAVXKpi7PxrfdE2/nMnOHP5yQ1r3pzi
         aQD0RS/tHU0MFWec3yLcKE3eog8l/wdkUdEG02w/IDvAPgAfzyyc+1PGy+miWhNHX0F9
         DqjPPDgqj/gihbD75ytE3Z7uw4UOTxq7e+S5kihwgVEvW54piV3bFtw9xl5UKtSdhb4w
         VUvTs5fy1ZHRd/x6yWd415jIw+0QqpVQxbCjTaYy22OaSGJ3HMKWuwZ3DPIQyRO5roQ4
         tMlExGC8nxa3Bu4bAkzn1cvJTK4C2TdPmmceZiEcJlJeCo/ms1pv3gUuwd4RtSv9YD+g
         kqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OyhbL7JQAgJYt8Ohkmi+6EE1kJF1GD6e396x9FyAdy0=;
        b=W11Hz3eimcuNe3j6L4oy47v3M7eCVf7TqWEDjuKtMnXnn251cBQhIJOHEvkqJ3qhPn
         B8nli+MUcxdiCjbGCjavfNJBNOMOzJwsRGK0TwIFq18nZHB1Derx/voNvLlRrJmpmUs4
         osUxnZYjTiygFjaAsaVyBayPL0/zJxpohDyacoi8Vi6Mvdsloqw1TO31dHmx+PqYhI4N
         RCR5vNdt1zyAjCgXV0zo8tcdTogta0qHLDEaTSsD0YCi+Zh8uWrLc3xfru7BPlwMpL3i
         Cs2pnPSb2wX21y/gif8t2bPK7UuXOGQAs2DvSKCv329GPMq7I8sgpE2/I7P6RnIwUfVz
         psnA==
X-Gm-Message-State: AGi0PuY65oPzol4lujNNxJNocqgN1/4iDsttEftNZAFf/SFJEBoysoNn
        11gHQ7hkm5T5j9XndusBAJc=
X-Google-Smtp-Source: APiQypIOW0NS0P7hYtIEjuytklntBmS3XLFYVoI6cFMqSrteDdxuGQ3MrAidm0CEFHWVLFHTMPBxlg==
X-Received: by 2002:a05:6830:1be6:: with SMTP id k6mr4631845otb.299.1588737233082;
        Tue, 05 May 2020 20:53:53 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id l11sm311163oom.15.2020.05.05.20.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 20:53:52 -0700 (PDT)
Date:   Tue, 5 May 2020 20:53:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        arnd@arndb.de, George Burgess <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] security: disable FORTIFY_SOURCE on clang
Message-ID: <20200506035351.GA599026@ubuntu-s3-xlarge-x86>
References: <202005051617.F9B32B5526@keescook>
 <20200506001453.764332-1-Jason@zx2c4.com>
 <202005051953.AF54DA4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005051953.AF54DA4@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 07:54:09PM -0700, Kees Cook wrote:
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
> 
> -- 
> Kees Cook
> 

I feel like you should finish your investigation into how broken this
actually is before we give it the hammer like this but if it is going
in regardless...

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

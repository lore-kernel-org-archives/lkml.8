Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD67DC47259
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8AD20735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CtrPU/ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEFCyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgEFCyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:54:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB01C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 19:54:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so1660513plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nFXGw0XLR4Lxj/iYJ9GXVPgkpTjspiHc52ztftl9kYM=;
        b=CtrPU/ym1XyAp3kS+VHQDztyPVHh70Oaxl/urkBpLhdmahDd9Nqfu1Wcryp3/lqmAm
         eCrhQu1sH8OWtYdmzzHR2gcrDvZeOC+T9VQEbOjmCuach4zTNTVKSctXdZVfejqqmgHw
         hvJWkMT3/gyT9u8x7yqh9dVC7s/0VsJ8czq7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nFXGw0XLR4Lxj/iYJ9GXVPgkpTjspiHc52ztftl9kYM=;
        b=D6qdzDOs0DKVuU9uflhXgyxN35LRLdAdz8JUEZMgQ/2SVJZnpYrPNJvIR8j3eA/CZP
         9JtlTizhhHFzsUBrZGp/Y9IweKKYbpLx55rrmlFyfddv5XBDaIpUn5ICzvjtu5cH67tY
         1XvA6uhZGDyfTAdxom7p/UqknDYTrtcbvF3eYf7U5asD95oYkBrXPQ727+30bcB9lI1w
         1+qSdlokjbB3msOdO12F/dkrTEbinKA60wSX69MntlmlIQHe2x13J/YhqSpYz9IxKjjA
         Ai2UMegkj00mC8PmYRSzpKVJl/7u4NVmf9sLJNmqXvx6ttMvwhWVE2kQCuf3V6nEdwFV
         py5Q==
X-Gm-Message-State: AGi0PuYadTY3UNbD+1T7jWSpNfwiq1AZJ0rw03m8xJO0Q9nbeEkHjbiI
        Ysmc3E4b5/C8smrWCdpeUFNXNw==
X-Google-Smtp-Source: APiQypJr1BBrgwOOMtfZP3imq3eIH+j4glrAtl20GHwTjL4ZO4/4aDzXvbiIbXbYQnuxKnUI9YIOhw==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr6592771pjp.75.1588733651069;
        Tue, 05 May 2020 19:54:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cv21sm3319195pjb.23.2020.05.05.19.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 19:54:10 -0700 (PDT)
Date:   Tue, 5 May 2020 19:54:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        arnd@arndb.de, George Burgess <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] security: disable FORTIFY_SOURCE on clang
Message-ID: <202005051953.AF54DA4@keescook>
References: <202005051617.F9B32B5526@keescook>
 <20200506001453.764332-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506001453.764332-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 06:14:53PM -0600, Jason A. Donenfeld wrote:
> clang-10 has a broken optimization stage that doesn't allow the
> compiler to prove at compile time that certain memcpys are within
> bounds, and thus the outline memcpy is always called, resulting in
> horrific performance, and in some cases, excessive stack frame growth.
> Here's a simple reproducer:
> 
>     typedef unsigned long size_t;
>     void *c(void *dest, const void *src, size_t n) __asm__("memcpy");
>     extern inline __attribute__((gnu_inline)) void *memcpy(void *dest, const void *src, size_t n) { return c(dest, src, n); }
>     void blah(char *a)
>     {
>       unsigned long long b[10], c[10];
>       int i;
> 
>       memcpy(b, a, sizeof(b));
>       for (i = 0; i < 10; ++i)
>         c[i] = b[i] ^ b[9 - i];
>       for (i = 0; i < 10; ++i)
>         b[i] = c[i] ^ a[i];
>       memcpy(a, b, sizeof(b));
>     }
> 
> Compile this with clang-9 and clang-10 and observe:
> 
> zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-10 -Wframe-larger-than=0 -O3 -c b.c -o c10.o
> b.c:5:6: warning: stack frame size of 104 bytes in function 'blah' [-Wframe-larger-than=]
> void blah(char *a)
>      ^
> 1 warning generated.
> zx2c4@thinkpad /tmp/curve25519-hacl64-stack-frame-size-test $ clang-9 -Wframe-larger-than=0 -O3 -c b.c -o c9.o
> 
> Looking at the disassembly of c10.o and c9.o, one can see that c9.o is
> properly optimized in the obvious way one would expect, while c10.o has
> blown up and includes extern calls to memcpy.
> 
> But actually, for versions of clang earlier than 10, fortify source
> mostly does nothing. So, between being broken and doing nothing, it
> probably doesn't make sense to pretend to offer this option. So, this
> commit just disables it entirely when compiling with clang.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: clang-built-linux <clang-built-linux@googlegroups.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: George Burgess <gbiv@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://bugs.llvm.org/show_bug.cgi?id=45802
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Grudgingly,

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

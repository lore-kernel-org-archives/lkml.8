Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E311C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E537206A5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcE22RUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgEFA5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729247AbgEFA5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:57:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E5C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 17:57:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so156994pfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pScRr5uqbrTBSYc99OCu9vH2CIfzDW93aphY7TGoD6Q=;
        b=DcE22RUc5QSe9FWkmLfMcNHpBI2rRE0O5G3mwUwum+qRvPyAuqTBsVOVzTHSxt/KQR
         rEJjCspadfplu+J0sfgkwuXj97+iR7J/MJ5CtyTeinJQ8lMCIzedXsNC4mm3hSlM6TUb
         KENgeKUPB7HC8FwVz670VJjqbb+qR5WEmtuURGRVcaKF6n4sDedtoCjgxfv2etX0bGG7
         zfdLRuJE1S0qpy547LTS+9qUp9KkAYmzAMi1RdPLvzF4AzcOmH9gsIMM1Sq/SUTvLTrt
         WCgzzhajO8qloxoewbUNkSJsZjhi6ToBBRDR8I3eUHUJYPChayrAGkfa/nigWgL1+OVq
         Ge3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pScRr5uqbrTBSYc99OCu9vH2CIfzDW93aphY7TGoD6Q=;
        b=iDe9Y9aPeyPPCA70NDNBamSo8LT5m1fxhQdSaff1ZKF0Fn0e7XxJF4Eim0KObPLGxV
         i9fj2HlfTod+nvNHiN7NIqCAicn3ba1nTbkC5yt7qHmFxCm6/L/I5j34fHqkL26dWJpW
         QTz89BAAyMRfG3sh1lD2iJJ5lcyt0Tbs2TL/jqNmZWL7U7vtHKvtA01Ds+0JAlBZD7bz
         +fFoQf76OLOZ4lWFFBgO92qzYqbJ3ydeX2F2kn/3+hmcW5Vj66tr3hgPBzlsdneMf9CK
         PKwhGn5afYt0PVHvXbXWgPOI9b+iVUINFff4vrhMDoOn0tjcZ+vBs0FTyCDD8cr7wSad
         rMTQ==
X-Gm-Message-State: AGi0Puac0MF7QvEOQIfYlx2fCuCtB4SN93s+lSNa5fBoOHgrvHr2ws/R
        xozd8muVRkNcw2A6l8w2V5952WYmAY3MD0ZwVm8c9Q==
X-Google-Smtp-Source: APiQypKFsuu2bx8YXCOyCjbW9FiWI51JMYemMTwGsfaueRqLXD2z/Ju3Q18Zcm3CIgvJOOZk1ByLt+oh9AMu1xLth54=
X-Received: by 2002:a62:1452:: with SMTP id 79mr5771566pfu.108.1588726633271;
 Tue, 05 May 2020 17:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <202005051617.F9B32B5526@keescook> <20200506001453.764332-1-Jason@zx2c4.com>
In-Reply-To: <20200506001453.764332-1-Jason@zx2c4.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 17:57:02 -0700
Message-ID: <CAKwvOdkqns7dxd5Zec2eGA0T6HAxnN0-QKmzD9ULfRJ8kw_dyg@mail.gmail.com>
Subject: Re: [PATCH v2] security: disable FORTIFY_SOURCE on clang
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        George Burgess <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
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

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  security/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index cd3cc7da3a55..76bcfb3eb16f 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -191,6 +191,7 @@ config HARDENED_USERCOPY_PAGESPAN
>  config FORTIFY_SOURCE
>         bool "Harden common str/mem functions against buffer overflows"
>         depends on ARCH_HAS_FORTIFY_SOURCE
> +       depends on !CC_IS_CLANG
>         help
>           Detect overflows of buffers in common string and memory functions
>           where the compiler can determine and validate the buffer sizes.
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200506001453.764332-1-Jason%40zx2c4.com.



-- 
Thanks,
~Nick Desaulniers

Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44993C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168C920658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwETQq0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHSSfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:35:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60483C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:35:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f5so11229528plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ap3wyF3ycynr5I2+EM8mbSJRoPdo5xTYvxy7Dp4qm24=;
        b=hwETQq0wXaVfaizex/R8gHaGfoCM2GKQleOAKkwQ6JcAv+h5K3cXxq7qhaNR88U8co
         FEOSTDj8hFl7Nxf93dGPDK9v0pc9hv61YWnrCu5cFE5CbDyUWrgeYjJqr7gNlFM2vz5n
         iQRcXHgQJAad5F+qzfVQLAVx0mxEe0s9kpy4BjqtG9+AQhrOrIkneWE6imkC6KJhvT6I
         2dJJqKiboeMgZevprsiOhpRtfcwJ41euOCJ6h8c/WyiZoKqAXBWB8ANhRfElKEl4JPbn
         FqTkrr3KcwaDskmSOIJoIB290jpVhiMyK58M9iQYakKiVKXLoC1lADhUvu8WLR022+zT
         ZMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ap3wyF3ycynr5I2+EM8mbSJRoPdo5xTYvxy7Dp4qm24=;
        b=Zk3ON/Oa+pTQDAxfY3lAOel75DXUR5MxSZo8S7/owjRA4SZo2XWeeE0KrHbRkqBflt
         cMEuNtnDq+45KJMj/Mb/7rNJ8/ancuwgUsTqkysEi6aslzAoYJ7S5jLv7u/Q5VUj4JQO
         mBBB5XiOci3oWiI3cHGPWO/nIEkXHLEVjgHkzwZFQLtkG9JP05ZrbbiuYSG64BP87bPs
         z3tSVDtCaeRPstyJWqeNIW7iufnk846RMjHeuJ2M5mgf4bOMLXTVLyslugSDDJ0QTFZz
         jNoDbod8wrunp06SWupCiROJey6EOk9QKWIVh0uCQ242O6Mf19a1Mu6XDk2U3MVOVqep
         bwcg==
X-Gm-Message-State: AOAM530JpqEaqd7E5CaJMHk7w7KAi0fakFI5yla4qiGCUv0d8Xpw5kAI
        SfLnvj4T3N+Y1TJS4z3y6U2PmIjvgQZX3MUGq0nkDHDMS9Ul+g==
X-Google-Smtp-Source: ABdhPJzd63YN0/2X7zxtPO2NW9LgPl1WUs2+zFxGL00W4Rn/AphNiLe3DEe3YOYZeDHTubJarvPFD0yQaNX8q7QD2O0=
X-Received: by 2002:a17:90b:4a42:: with SMTP id lb2mr2276677pjb.25.1597862122566;
 Wed, 19 Aug 2020 11:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJLvqS1_O+yAQSZr-Lj49HdJyLpt3J_nW=otHLfEN4RA@mail.gmail.com>
 <20200819140816.3807604-1-nivedita@alum.mit.edu>
In-Reply-To: <20200819140816.3807604-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Aug 2020 11:35:11 -0700
Message-ID: <CAKwvOdn-mv1D1GEk3pWnPYsyzQRRk5qZFhSi0CYn6tRDo1O_iw@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string.c: Use freestanding environment
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 7:08 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> gcc can transform the loop in a naive implementation of memset/memcpy
> etc into a call to the function itself. This optimization is enabled by
> -ftree-loop-distribute-patterns.
>
> This has been the case for a while (see eg [0]), but gcc-10.x enables
> this option at -O2 rather than -O3 as in previous versions.
>
> Add -ffreestanding, which implicitly disables this optimization with
> gcc. It is unclear whether clang performs such optimizations, but
> hopefully it will also not do so in a freestanding environment.
>
> [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56888
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

For Clang:
For x86_64 defconfig:
This results in no change for the code generated.

For aarch64 defconfig:
This results in calls to bcmp being replaced with calls to memcmp in
strstr and strnstr.  I plan on adding -fno-built-bcmp then removing
bcmp anyways.  Not a bug either way, just noting the difference is
disassembly.

For arm defconfig:
This results in no change for the code generated.

I should check the other architectures we support, but my local build
doesn't have all backends enabled currently; we'll catch it once it's
being testing in -next if it's an issue, but I don't foresee it
(knocks on wood, famous last words, ...)

If it helps GCC not optimize these core functions into infinite
recursion, I'm for that, especially since I'd bet these get called
frequently and early on in boot, which is my least favorite time to
debug.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  lib/Makefile | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index e290fc5707ea..a4a4c6864f51 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -15,11 +15,16 @@ KCOV_INSTRUMENT_debugobjects.o := n
>  KCOV_INSTRUMENT_dynamic_debug.o := n
>  KCOV_INSTRUMENT_fault-inject.o := n
>
> +# string.o implements standard library functions like memset/memcpy etc.
> +# Use -ffreestanding to ensure that the compiler does not try to "optimize"
> +# them into calls to themselves.
> +CFLAGS_string.o := -ffreestanding
> +
>  # Early boot use of cmdline, don't instrument it
>  ifdef CONFIG_AMD_MEM_ENCRYPT
>  KASAN_SANITIZE_string.o := n
>
> -CFLAGS_string.o := -fno-stack-protector
> +CFLAGS_string.o += -fno-stack-protector
>  endif
>
>  # Used by KCSAN while enabled, avoid recursion.
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers

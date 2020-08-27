Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA36222BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAgk5+wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgH0HW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgH0HW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:22:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C670C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:22:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b9so3847134oiy.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nHYyDnDGU0SstXAm4qaNf6rFQtn/4uEmUBDoFdDHiDI=;
        b=cAgk5+wHgubtgnNdBBZNCrVs6B6Nx05jKGBCcKZxZr5GenekXuvXzpC84SZuhInHPw
         M8YECkQo+6ANeLWcIlK39VqoBvYWexpUBWUBokrl2BscDUHF2hbjUrokiTysi+ylo4Z6
         oMpEHD8nh+FXAYWuAgynRfvSK0SLhkuLs7NCdGySSe2FCeL4juT9hHXZaCFNFO5/RQgt
         w6gsjsCuSJI/eeIlWrvTIoWDd6wJLQYcvl8tFN21KyFZHUpK0sEwVXIjurH2RulajoG5
         ALrvRtS8VOZdM7ruX1XNXAow8KCQH3I0qElMj4969Q+gjvqJH/zGMfwLr2f3nfYqX+mN
         ZOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nHYyDnDGU0SstXAm4qaNf6rFQtn/4uEmUBDoFdDHiDI=;
        b=o0G4LLhMYpTVb4sjdLyMmInn1BDISIBLuNWuOdMVTPaCF4qPbdt/ZNirlw7BPTBBx+
         v4qSOfZpBB+hh5UTYszPZfk6U9EUl54qGgXAVME5pac/gvkLpcf7hOr+d13SWMbJJByC
         aYV9q3qtT5buIwaVg/RtD08hmwDX8Ymy5I8VZCkhP24I0kNcC3Sem+3IQuJCmT20+xY5
         MCGTQPNuUpIw4IZIZh0cFeRcLERm2yLx38q1f+eR/Btx6meJQbOrOHaXgp9Qr7VC+/qb
         aEchBY6XctbR0DeT+JxFk5E/EE2UPpAvkVnuuAJDGdHjsNczXxiMjjD2Qphb+xOwN+Uv
         TqdQ==
X-Gm-Message-State: AOAM530aCeE4hEtXwrprxSGd5K7m8Rm8PDyqbsJF3ANYSK6x9m4eImWl
        e7qGpjaHX+awxf+g9bTf/LCGBNmEj/8peBvPKBA=
X-Google-Smtp-Source: ABdhPJyw1DVjlkfy2n9wlQ6tG0Kkp9FMfkL5isxbfsnOGkxBIdIXCrmYwkIgB2YXkoRCLKSwlglwOKSB1q8PUj7qJL0=
X-Received: by 2002:a05:6808:311:: with SMTP id i17mr6336757oie.72.1598512944261;
 Thu, 27 Aug 2020 00:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200826201420.3414123-1-ndesaulniers@google.com>
In-Reply-To: <20200826201420.3414123-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 27 Aug 2020 09:22:13 +0200
Message-ID: <CA+icZUUKqMaN5rUjz+U9itZ9-3_4EoqdBTP+41+WUjr=UzPN-g@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:14 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> During Plumbers 2020, we voted to just support the latest release of
> Clang for now.  Add a compile time check for this.
>
> Older clang's may work, but we will likely drop workarounds for older
> versions.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/9
> Link: https://github.com/ClangBuiltLinux/linux/issues/941
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Nice to see This Is Happening!

See also my other replies to Kees and Nathan comments.

Acked-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>  include/linux/compiler-clang.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index cee0c728d39a..7338d3ffd240 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -3,6 +3,14 @@
>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>  #endif
>
> +#define CLANG_VERSION (__clang_major__ * 10000 \
> +                    + __clang_minor__ * 100    \
> +                    + __clang_patchlevel__)
> +
> +#if CLANG_VERSION < 100001
> +# error Sorry, your compiler is too old - please upgrade it.
> +#endif
> +
>  /* Compiler specific definitions for Clang compiler */
>
>  /* same as gcc, this was present in clang-2.6 so we can assume it works
> --
> 2.28.0.297.g1956fa8f8d-goog
>

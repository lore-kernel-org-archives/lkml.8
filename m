Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D54C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B920738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFHzn3Ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHZVmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:42:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9369C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:42:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y65so2979159qtd.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I8OxgVPu3Ggp6k0pbUz5wgXSCJd17wLp4qYHq+jsd/8=;
        b=pFHzn3Ft2sIoh5OQnAHj3rSAq/bkfrzvFjVIDKPQm+90kuMBtT9VE0nKtPD4KO7+fp
         iChJxd1chGImg00Ybpnk0kiab8+UloEUYeqxbVMvwm1C7wy0g1fXOEsc0RS5CAQ1CiCQ
         rrVKk6JHNkCbdijTo6zzWULXmkI/jFN6uOtDdCqzMjfCeZxaF3AxGKhX9/dkPE6mjmRt
         RlgQI2YAnbjetxdtx4TGaPGcNtQcZ4X0+hARl1/yiqwnL+jVYKTHUjUe5xHgKSi89Q3c
         2dASLack8eJzWnsIlblI1oCg41DypEI6mhxAY1VReWrS5qd41V/FgnFAZPMYXqen/8Ak
         zTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I8OxgVPu3Ggp6k0pbUz5wgXSCJd17wLp4qYHq+jsd/8=;
        b=lUqcT9cuD+AfAT+xsgSoN6YKQ4fZt6mAoSjyKQY5/5twuV6aaEPVfqQZ5SHIys8VWU
         qEfcvrKcJieqkBHfDDnskUJpg66ALLy5FkhEgouHxrGQEfs673mLrgCKGk5/M2CmzB9X
         G7BswsogzIDNS8zVs2SY7N+dOatnQO5gQ5D/8Lng1ezR0QcPpsvAlssMqtbAGnrG6U1i
         fabWj18ohSRzPZWspxKv0CTAJABl1Ri3kjh3zkDLqjLThjauODGVRgLQTg9U/bvETOca
         +eS661oVWQtCFZoCPdl3SiA6PpGJedINPNEvIpvHz8BTE2PxWOhapUa7Oia7QMa9g0mr
         Rjcw==
X-Gm-Message-State: AOAM530IquzV6ypc6UiO31F7eo7wxush+mhWaCILSQCb0NaRdwnWvIXb
        JyfuXHgX/7QvYiROsDAFAWo=
X-Google-Smtp-Source: ABdhPJz8HiX+pM3V46AsSQ6mTm7xSV8qGd0J1oSK1Tx/IAg4MP/csGC4m8yPKylDqeq3Zudlg8yMMg==
X-Received: by 2002:ac8:5504:: with SMTP id j4mr16547550qtq.357.1598478150655;
        Wed, 26 Aug 2020 14:42:30 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id b23sm203069qtp.41.2020.08.26.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 14:42:30 -0700 (PDT)
Date:   Wed, 26 Aug 2020 14:42:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
Message-ID: <20200826214228.GB1005132@ubuntu-n2-xlarge-x86>
References: <20200826201420.3414123-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826201420.3414123-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:14:19PM -0700, Nick Desaulniers wrote:
> During Plumbers 2020, we voted to just support the latest release of
> Clang for now.  Add a compile time check for this.
> 
> Older clang's may work, but we will likely drop workarounds for older
> versions.

I think this part of the commit message is a little wishy-washy. If we
are breaking the build for clang < 10.0.1, we are not saying "may work",
we are saying "won't work". Because of this, we should take the
opportunity to clean up behind us and revert/remove parts of:

87e0d4f0f37f ("kbuild: disable clang's default use of -fmerge-all-constants")
b0fe66cf0950 ("ARM: 8905/1: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer")
b9249cba25a5 ("arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support")
3acf4be23528 ("arm64: vdso: Fix compilation with clang older than 8")

This could be a series or a part of this commit, I do not have a
strong preference. If we are not going to clean up behind us, this
should be a warning and not an error.

> Link: https://github.com/ClangBuiltLinux/linux/issues/9
> Link: https://github.com/ClangBuiltLinux/linux/issues/941
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Otherwise, I agree with Kees's comments. With them addressed, feel free
to add:

Acked-by: Nathan Chancellor <natechancellor@gmail.com>

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
> +#define CLANG_VERSION (__clang_major__ * 10000	\
> +		     + __clang_minor__ * 100	\
> +		     + __clang_patchlevel__)
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

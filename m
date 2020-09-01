Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2437208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edgvh+aX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIAE6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAE56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:57:58 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A7C061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:57:56 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id m14so2224766qvt.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WkMMV5KfqKlAUNBzYZCx8Wlk7RJHSHOVVyqgVoAjcfI=;
        b=edgvh+aXOxwB9ngwCe0vRggHYKm6bej3nmlusDc9EU6i0wiw4po7g2IYU9yeWgJSP0
         L53Sh+IEGIodrvvbv9Ddfh5dDaEnNZHYLmlmAG8u8f5MlXYrs+io9S62XMi/+zLc7Z6J
         8nMW58eScu3xlBtNEGoq2Vn1Kc84V6grNjfwRA2oiO5hetymzYHDJr/pffb4riKwN3Uz
         sUnsV76BZOVxLFS00GGYWEX2IJLTUokOANPT/VqgYZRk/Wj2A9MhSn3RDK9sCvMi2SeV
         wL0WJmG6/lnbH5ZjLuj5NCHsRUxEfUYKGk7h3cksUVdtNhktN7cibrfnf0/aPnWQ2Pbq
         pXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WkMMV5KfqKlAUNBzYZCx8Wlk7RJHSHOVVyqgVoAjcfI=;
        b=rw9aQS7ap9F9rpM1pCeP8KjEZBL7LWxyuV52XXrOduRdqKDWXTKsj+WzgRhWohKpPu
         2FsUKXpsS28AtodxZUICB4VH3iZ/ctRZWqXozIyjdIwAhmMGQBhWwL5fnDBLQISfERJi
         kr+Zo4ip0VlYFnlLlXCN9m+w14e2KQl4UaSFwCt0/7DgAMMKj+aYh9b2kT9/6YXD84tP
         mURXvg7ahwG4FutlRkuOBkmOn2LepYfZCoKiE5r9d/kkP1TLJJwVVHkZOrM+cQUhtX3v
         Eho0cWCB8ZEHg3BrxA9vlzrRQPw7MGuiiN5FipUF1Vv6ONJbnJdLni6q+ieZx3YnXdcJ
         5KwQ==
X-Gm-Message-State: AOAM533jYZV6a0tbX5G8iMfbFTeQq6ta5M4AQKEs3aIfC0dHUacVlYvp
        f+qLqGeRBzI48LpFK2BPVC0=
X-Google-Smtp-Source: ABdhPJyE1UHDa7wfbBRHtEZTsjhsrumKH2JvhTk1r9+5puEnpF6kWoHaIY1Z7gc9jl4RrzVtsPoOHw==
X-Received: by 2002:a0c:e844:: with SMTP id l4mr193470qvo.154.1598936275487;
        Mon, 31 Aug 2020 21:57:55 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id k185sm237276qkd.94.2020.08.31.21.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 21:57:55 -0700 (PDT)
Date:   Mon, 31 Aug 2020 21:57:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] kasan: Remove mentions of unsupported Clang
 versions
Message-ID: <20200901045753.GE1561318@ubuntu-n2-xlarge-x86>
References: <20200901002326.1137289-1-ndesaulniers@google.com>
 <20200901002326.1137289-7-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901002326.1137289-7-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 05:23:25PM -0700, Nick Desaulniers wrote:
> From: Marco Elver <elver@google.com>
> 
> Since the kernel now requires at least Clang 10.0.1, remove any mention
> of old Clang versions and simplify the documentation.
> 
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  Documentation/dev-tools/kasan.rst | 4 ++--
>  lib/Kconfig.kasan                 | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 38fd5681fade..4abc84b1798c 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -13,10 +13,10 @@ KASAN uses compile-time instrumentation to insert validity checks before every
>  memory access, and therefore requires a compiler version that supports that.
>  
>  Generic KASAN is supported in both GCC and Clang. With GCC it requires version
> -8.3.0 or later. With Clang it requires version 7.0.0 or later, but detection of
> +8.3.0 or later. Any supported Clang version is compatible, but detection of
>  out-of-bounds accesses for global variables is only supported since Clang 11.
>  
> -Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
> +Tag-based KASAN is only supported in Clang.
>  
>  Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
>  riscv architectures, and tag-based KASAN is supported only for arm64.
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 047b53dbfd58..033a5bc67ac4 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -54,9 +54,9 @@ config KASAN_GENERIC
>  	  Enables generic KASAN mode.
>  
>  	  This mode is supported in both GCC and Clang. With GCC it requires
> -	  version 8.3.0 or later. With Clang it requires version 7.0.0 or
> -	  later, but detection of out-of-bounds accesses for global variables
> -	  is supported only since Clang 11.
> +	  version 8.3.0 or later. Any supported Clang version is compatible,
> +	  but detection of out-of-bounds accesses for global variables is
> +	  supported only since Clang 11.
>  
>  	  This mode consumes about 1/8th of available memory at kernel start
>  	  and introduces an overhead of ~x1.5 for the rest of the allocations.
> @@ -78,8 +78,7 @@ config KASAN_SW_TAGS
>  	  Enables software tag-based KASAN mode.
>  
>  	  This mode requires Top Byte Ignore support by the CPU and therefore
> -	  is only supported for arm64. This mode requires Clang version 7.0.0
> -	  or later.
> +	  is only supported for arm64. This mode requires Clang.
>  
>  	  This mode consumes about 1/16th of available memory at kernel start
>  	  and introduces an overhead of ~20% for the rest of the allocations.
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 

Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12822C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADEB208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHEFgC+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIAE4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAE4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:56:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB8C061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:56:04 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p65so38121qtd.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cpye1iaPTXp5G0yIMoK4Nn+LVQHWfQN0vtdnem2Drw8=;
        b=lHEFgC+RV5rKzrFXQPXjGKH6KaYzEIJSS5rmkBHLus0QdNJsIjgA/YpJnnBoN+bCb2
         fez2ALrJvB2AGvfNslVv9LPa0vj7tRDfPYgGrqMWHSY841bJ9aSlI0UJH5rjEsDWfSDg
         cAlpcY/n00EhV8EZCdaLIOkYW43uA+jYktN23B3iktgMqQSxmfd+nYpJhkXNUUXwGz1m
         im9zGsf5o91RAsEO6/AorU6ZPR+yA7ok3Mjao+18iW2okNnkMaFNCXtX01PHJhl5yIHl
         H17Dp2mTtAo2Cd4btbAA7yJc+hQY/+r3Mev4DGuSFTFyY0q3dSZH8sRAD87l41aArAkF
         P/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpye1iaPTXp5G0yIMoK4Nn+LVQHWfQN0vtdnem2Drw8=;
        b=fPjp529204qRDsgHblbTUVX+iqJSdjYa82pKTcfR6Y2nYJG5rfEQXfYy4kJJtJOmEX
         3LiW3T1peL1Ki7H3EFL/kmfBcNFZYEY3GGNNsEHIqmbqynmjdNK6zqYpJIOTDeNLnalx
         WSN3Q9h7g3uWXXnuvOIXubyByAx9RgjeAZRZVV7zJxcsDHrV7c6i1TcWQ1fsv6wNnC2Y
         8OVXxICRGk0u58AxdBxqqPksMwxmwu+ZQXS0vHsMixkDXD7TVvEGFRSDUF6Nh6dNE/Wy
         W9WYTRp0N7h0oV4lC/8U1bHbQoNFHCWEDFeBuXu5MWAJ+oR8K9cwMDcQcrZpwB438OGW
         l5Cg==
X-Gm-Message-State: AOAM530G0kfz4qz8ycQS/1LtfHtO002v2RRfodKvfWxSrsKRVPJCrwgM
        hVcJa05WnIG7YX4iGV7eeH0=
X-Google-Smtp-Source: ABdhPJzdkvLjcD8hxGtCYgQWc3Bya9s7v+K+EJumRXdbhj8dnQjXmFk5yc1c8VcGy17GgI/PSTQJSw==
X-Received: by 2002:ac8:376d:: with SMTP id p42mr4787879qtb.288.1598936163381;
        Mon, 31 Aug 2020 21:56:03 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id 203sm227897qke.59.2020.08.31.21.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 21:56:02 -0700 (PDT)
Date:   Mon, 31 Aug 2020 21:56:01 -0700
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
Subject: Re: [PATCH v2 4/7] Revert "arm64: vdso: Fix compilation with clang
 older than 8"
Message-ID: <20200901045601.GC1561318@ubuntu-n2-xlarge-x86>
References: <20200901002326.1137289-1-ndesaulniers@google.com>
 <20200901002326.1137289-5-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901002326.1137289-5-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 05:23:23PM -0700, Nick Desaulniers wrote:
> This reverts commit 3acf4be235280f14d838581a750532219d67facc.
> 
> The minimum supported version of clang is clang 10.0.1.
> 
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm64/kernel/vdso/Makefile | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 45d5cfe46429..04021a93171c 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -43,13 +43,6 @@ ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
>  endif
>  
> -# Clang versions less than 8 do not support -mcmodel=tiny
> -ifeq ($(CONFIG_CC_IS_CLANG), y)
> -  ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 80000; echo $$?),0)
> -    CFLAGS_REMOVE_vgettimeofday.o += -mcmodel=tiny
> -  endif
> -endif
> -
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
>  
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 

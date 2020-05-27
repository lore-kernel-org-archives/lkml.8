Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00305C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD73208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5MB/EUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbgE0PaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgE0P37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:29:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF69C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:29:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so11891646pgb.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EP0X4nrq+dBeA9FW2rwRe3EmgkIyPMB88g1VDoRBEaI=;
        b=C5MB/EUelkHYaUnsRBjOFiGEnFs9PexgRwbAFOu9NpZvqnQr+OxqhDGySPF9bm49El
         iKIZ+Se3vuVivuCerUxtMfmuC7tx4cF39KOt63DHgZujttsfjIPb6Mnx+abKbcukK/tW
         6ZZmjmg4scX5Q31spyqNXoivNx4TkGpL/3wdpsGBCpRvUrmAAqLpRHwKGEfe/jWHXWoM
         C25euxunkPqErY4dRJXhnJra4tBYqnZTuIxUQDQhEw9OUJfQVur5Oe/54q2tztPR2EJg
         JULZoKVt36cfGvfD1e91Zk0dqlBE0PnFT/K0aYgp2t9C38mpUllXaXKtj3F7MrJZWdT3
         Ir3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EP0X4nrq+dBeA9FW2rwRe3EmgkIyPMB88g1VDoRBEaI=;
        b=ZROVzqnrx7bjZmsv6ufEkm86CYwbiqYY0WappGywQu04VWdXvpSP6u2/zwy08XCcXU
         MycISxXlUonmFu5fjLajqtigR343xQ8lHaOPgww5iREst3ztj0qAOtZ2q4i3wApaLlpE
         BZMFq9YHdXaILPzEJigxwA7bsUQJvI4Gav6YaWHg/jmk/d34G8Xn+cvLxiK/q9a9Od9Y
         ffkWgJ+UmLUrIO6dAMrKkQZOhszx+H+L3WVpuJiwHYriVCToj8k0S7fCyNDf3msvaSGW
         QMHrg5G49p9Xu91LIpyEpjNQEjtTESSPpFCf+MjMa54N5eecQPSKVDqunEFuFdeVO69e
         3HHA==
X-Gm-Message-State: AOAM53147cxPa5qZ+qEF06V/acmD4HZIgMs1VexrgE81NL2p8m5RdFqS
        I1z/VLxkfuF3n8QaXxjU6s8=
X-Google-Smtp-Source: ABdhPJwDttBOyVCfq4OlBeyoqxSHAOYDOt8XsvD/jBT8tm2CLHVlzanGk87BsK/8d9FCOu4FttEEyw==
X-Received: by 2002:aa7:8c53:: with SMTP id e19mr4487122pfd.264.1590593398712;
        Wed, 27 May 2020 08:29:58 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id d2sm2409483pfc.7.2020.05.27.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:29:58 -0700 (PDT)
Date:   Wed, 27 May 2020 08:29:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org,
        clang-built-linux@googlegroups.com, paulmck@kernel.org,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
Message-ID: <20200527152955.GA3681123@ubuntu-s3-xlarge-x86>
References: <20200527103236.148700-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527103236.148700-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:32:36PM +0200, 'Marco Elver' via Clang Built Linux wrote:
> If the compiler supports C11's _Generic, use it to speed up compilation
> times of __unqual_scalar_typeof(). GCC version 4.9 or later and
> all supported versions of Clang support the feature (the oldest
> supported compiler that doesn't support _Generic is GCC 4.8, for which
> we use the slower alternative).
> 
> The non-_Generic variant relies on multiple expansions of
> __pick_integer_type -> __pick_scalar_type -> __builtin_choose_expr,
> which increases pre-processed code size, and can cause compile times to
> increase in files with numerous expansions of READ_ONCE(), or other
> users of __unqual_scalar_typeof().
> 
> Summary of compile-time benchmarking done by Arnd Bergmann [1]:
> 
> 	<baseline normalized time>  clang-11   gcc-9
> 	this patch                      0.78    0.91
> 	ideal                           0.76    0.86
> 
> [1] https://lkml.kernel.org/r/CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com
> 
> Further compile-testing done with:
> 	gcc 4.8, 4.9, 5.5, 6.4, 7.5, 8.4;
> 	clang 9, 10.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lkml.kernel.org/r/CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com
> ---
> Same version as in:
> https://lkml.kernel.org/r/20200526173312.GA30240@google.com
> ---
>  include/linux/compiler_types.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 5faf68eae204..a529fa263906 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -245,7 +245,9 @@ struct ftrace_likely_data {
>  /*
>   * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
>   *			       non-scalar types unchanged.
> - *
> + */
> +#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900
> +/*
>   * We build this out of a couple of helper macros in a vain attempt to
>   * help you keep your lunch down while reading it.
>   */
> @@ -267,6 +269,24 @@ struct ftrace_likely_data {
>  			__pick_integer_type(x, int,				\
>  				__pick_integer_type(x, long,			\
>  					__pick_integer_type(x, long long, x))))))
> +#else
> +/*
> + * If supported, prefer C11 _Generic for better compile-times. As above, 'char'
> + * is not type-compatible with 'signed char', and we define a separate case.
> + */
> +#define __scalar_type_to_expr_cases(type)				\
> +		type: (type)0, unsigned type: (unsigned type)0
> +
> +#define __unqual_scalar_typeof(x) typeof(				\
> +		_Generic((x),						\
> +			 __scalar_type_to_expr_cases(char),		\
> +			 signed char: (signed char)0,			\
> +			 __scalar_type_to_expr_cases(short),		\
> +			 __scalar_type_to_expr_cases(int),		\
> +			 __scalar_type_to_expr_cases(long),		\
> +			 __scalar_type_to_expr_cases(long long),	\
> +			 default: (x)))
> +#endif
>  
>  /* Is this type a native word size -- useful for atomic operations */
>  #define __native_word(t) \
> -- 
> 2.27.0.rc0.183.gde8f92d652-goog
> 

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build

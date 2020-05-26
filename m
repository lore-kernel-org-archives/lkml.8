Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CB3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D371D20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iuLiKeXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbgEZVgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgEZVgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:36:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B238C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pPz4T1JqBnfA3eSrgPWLUIAddODK4bFj5VmukAoBfaI=; b=iuLiKeXA0OG2Ud39pacyc8ST9w
        Cp52vIzq6HBov+mPZGS9QysSkt3nJMInXOkXbWKe8lH2hezVRnSW2s/3c/3Ua8zQCiWFRCthi2XxT
        1cBWRa1u/eaH1xBd2uJIRZn2DMJqf3ma8yYOEoc9ciUHWnPVFqeMvN7rkP8yyHPCV2Xg5kRhbbzpQ
        NWCpx/i6X/Itpbn5GUg1XB96lvFXNyW8mzlLg9kLLKREnj7JLvF5FdQwMhzcif+iTZUP2OXYhHtAf
        BrdQZmc/HRmUs+/3SuSm6RnoTv3beg57NKej89Ood5/kpee+1mxjAYIrYeCAumUuVW06xVNF2c5WD
        a/yUQILw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdhEx-0005So-Ma; Tue, 26 May 2020 21:36:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA9B89834AB; Tue, 26 May 2020 23:36:01 +0200 (CEST)
Date:   Tue, 26 May 2020 23:36:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement
 expression
Message-ID: <20200526213601.GF2483@worktop.programming.kicks-ass.net>
References: <20200521142047.169334-1-elver@google.com>
 <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
 <20200526120245.GB27166@willie-the-truck>
 <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
 <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
 <20200526173312.GA30240@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526173312.GA30240@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 07:33:12PM +0200, Marco Elver wrote:
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
> 

Yeah, this shaves around 5% off of my kernel builds. The _Atomic hack is
every so slightly faster on GCC but apparently doesn't work on clang --
also, it's disguisting :-)

Ack!

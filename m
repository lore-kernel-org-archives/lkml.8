Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA26C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1335B208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs79uMAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIAE5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAE5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:57:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1906C061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:57:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cr8so1499624qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RIJpNCkK5FQVXNXvvi2V2cWOQc/wyJO0hGvFWp5jPHE=;
        b=Cs79uMABpRcHICHGXIR5UMN8CCL+86nyKTUfm6aVs0CNG4j2/R2P0Di6lRIzOCONcq
         iFI4KV4IlHpaTOqg5fbPpUEgsEqagDlj0Mxd2ygYkRRG7BaYYt0Riui7D8e6HiZunYga
         vmrjS2EF6gmv5VWQVQKSg9oJTFkkEqRdhFmEHrO1H3h5yUhqS1rRP+tOJnadN483gmEv
         ewMWqcPVvxHcIqsSe753qvpdXz/g/NKYBC65btqZ6nCuWuk4iJBOOrws/Tdme8EwSfl+
         ULxmvMGx3qmgw9ZvToluI3DQMnTX+4g2P6aitvxszBMrV9zLkEDrNs+s4UukK1uPK0Tc
         wrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RIJpNCkK5FQVXNXvvi2V2cWOQc/wyJO0hGvFWp5jPHE=;
        b=UnQolFEicvUXyzRVObqFfDBJFvJkWH1KU14ZMpAtru0iNUZw0ruZjdXAeTFJ1oQn8b
         xqY+ptqUAiwqISO6ywsrFCmCT47x0VXi1HqQsk+WOKe7GttdhUajmV0cBwYTYf31wBOt
         Piv/WUFn1kMMHA6RZImhZGwfHtJEY2O3Cq37B0ewM/WKG0GA1ozqrnKBMUUXxzJKdtSR
         rap4bqgmmQPAEY6lpoFowClvdWxyPLg1IUPTJXmpiQ9P2Kc6gpI0Syiq0jL1SXMrlS2i
         7WjNEqxdFzMbdSOO2ptn1amOUioPJ9JoF2ldEsg39KkNIQvByf4FfpIRhsWJT0by6uyI
         iFhQ==
X-Gm-Message-State: AOAM533pVV9V5pqT+6+bPj1B9Xj5LvX02eSHBx5tuiY55syA4ejkTOZ4
        2eGxuaj8aaSjlFONtInwRvGYvOAyYIdIgw==
X-Google-Smtp-Source: ABdhPJybU9gdtYkTPBNKo8L9h2z919ZHAf6Bnah9Dbx8ky5AnULI3NiQWtarOxjiL5n+4PrIb3IUCw==
X-Received: by 2002:ad4:576c:: with SMTP id r12mr174085qvx.232.1598936226194;
        Mon, 31 Aug 2020 21:57:06 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id j4sm210942qkd.129.2020.08.31.21.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 21:57:05 -0700 (PDT)
Date:   Mon, 31 Aug 2020 21:57:03 -0700
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
Subject: Re: [PATCH v2 5/7] Partial revert "ARM: 8905/1: Emit __gnu_mcount_nc
 when using Clang 10.0.0 or newer"
Message-ID: <20200901045703.GD1561318@ubuntu-n2-xlarge-x86>
References: <20200901002326.1137289-1-ndesaulniers@google.com>
 <20200901002326.1137289-6-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901002326.1137289-6-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: Partially in commit message?

On Mon, Aug 31, 2020 at 05:23:24PM -0700, Nick Desaulniers wrote:
> This partially reverts commit b0fe66cf095016e0b238374c10ae366e1f087d11.
> 
> The minimum supported version of clang is now clang 10.0.1. We still
> want to pass -meabi=gnu.

Thank you for calling this out.

> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 82c197a248dd..09a7669eea1d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -83,7 +83,7 @@ config ARM
>  	select HAVE_FAST_GUP if ARM_LPAE
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> -	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && (CC_IS_GCC || CLANG_VERSION >= 100000)
> +	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>  	select HAVE_IDE if PCI || ISA || PCMCIA
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 

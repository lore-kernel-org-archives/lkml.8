Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE390C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6B020786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZ5flqUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHSSOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHSSOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:14:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA6FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:14:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so6244188pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4IFu7shAFZ4cq+fQUbjGl2XA19fNOk1l6Qpzfns4GcQ=;
        b=XZ5flqUELQYx7RXKhgoyR6e13wzn+Ak05CXKhYZ40i7+Sxc1e4tQkGynmf0p4XOvlG
         ofhFOdc3jtJkUaISvB7KcxJv/nSRS43/McXnpcIURhCffbwqs+XQLqfFWJ0sVL7oQWC8
         VbaQLFMb88RDC4MZkaIsqZzmOp2HBgL3DFJ5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4IFu7shAFZ4cq+fQUbjGl2XA19fNOk1l6Qpzfns4GcQ=;
        b=MH3xVD19AepTr0iaqFRqX1dOFptMNP2S7TDmVeS2IICzxQOKFdX52Os9cmhRBxs9PT
         AcPr0oCLcpzmE+nVokdHTyC0ZpDTtiLwqbYdbI6fHiFay6hDi9DmTifnhoCR9oqLVLF5
         Ob2sU1ugpt4ufsLNrX+Ti2OD/GhiL1C5IPxEDL/3I/JKmvWYogNUPRiXhAC+FivLIznk
         +hRKP5OL0aibAOuZR9vB6o9DX9O/XGE7UhNX8eH+11s6NUE9v0alBwnXC/YrLneBeJte
         zFWRkNaBnSbCGZLhpJaVp2Aoa7BpYhFlYKFz1FKLPakDonILSqHu30dQe37+Qc6trK95
         2aWQ==
X-Gm-Message-State: AOAM530vBWNmmSF0ldQMBNuyFUXsOZzZcsQEoG39LeysqGsFX/kdQP3R
        7kfwoIp/eOE2RKFTLk8jQbHO/zJ4Y10aog==
X-Google-Smtp-Source: ABdhPJzZu0ajG/Rgm+L5jIXEs1U/ToVIFDkCsmJUhQMYPUVmpsVorLDQg93dG5Msi3Cj29SgqtA+5w==
X-Received: by 2002:a62:26c2:: with SMTP id m185mr20440979pfm.115.1597860877043;
        Wed, 19 Aug 2020 11:14:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bv17sm3528421pjb.0.2020.08.19.11.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:14:35 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:14:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <xiang@kernel.org>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
Subject: Re: [PATCH 1/1] x86/boot/compressed: Use builtin mem functions for
 decompressor
Message-ID: <202008191111.4244B09D26@keescook>
References: <9753118F-84DD-44C4-8B8C-F45B8EE0FC14@fb.com>
 <20200804234817.3922187-1-nivedita@alum.mit.edu>
 <20200804234817.3922187-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804234817.3922187-2-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:48:17PM -0400, Arvind Sankar wrote:
> Since commits
> 
>   c041b5ad8640 ("x86, boot: Create a separate string.h file to provide standard string functions")
>   fb4cac573ef6 ("x86, boot: Move memcmp() into string.h and string.c")
> 
> the decompressor stub has been using the compiler's builtin memcpy,
> memset and memcmp functions, _except_ where it would likely have the
> largest impact, in the decompression code itself.
> 
> Remove the #undef's of memcpy and memset in misc.c so that the
> decompressor code also uses the compiler builtins.
> 
> The rationale given in the comment doesn't really apply: just because
> some functions use the out-of-line version is no reason to not use the
> builtin version in the rest.
> 
> Replace the comment with an explanation of why memzero and memmove are
> being #define'd.
> 
> Drop the suggestion to #undef in boot/string.h as well: the out-of-line
> versions are not really optimized versions, they're generic code that's
> good enough for the preboot environment. The compiler will likely
> generate better code for constant-size memcpy/memset/memcmp if it is
> allowed to.
> 
> Most decompressors' performance is unchanged, with the exception of LZ4
> and 64-bit ZSTD.
> 
> 	Before	After ARCH
> LZ4	  73ms	 10ms   32
> LZ4	 120ms	 10ms	64
> ZSTD	  90ms	 74ms	64
> 
> Measurements on QEMU on 2.2GHz Broadwell Xeon, using defconfig kernels.
> 
> Decompressor code size has small differences, with the largest being
> that 64-bit ZSTD decreases just over 2k. The largest code size increase
> was on 64-bit XZ, of about 400 bytes.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: Nick Terrell <nickrterrell@gmail.com>
> Tested-by: Nick Terrell <nickrterrell@gmail.com>

Did anyone pick this up? (Ingo can you snag it, or maybe akpm who took
the LZ4-specific patch already?) This looks sane to me and provides some
surprising performance benefits. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/boot/compressed/misc.c | 7 ++-----
>  arch/x86/boot/string.h          | 5 +----
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 39e592d0e0b4..e478e40fbe5a 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -30,12 +30,9 @@
>  #define STATIC		static
>  
>  /*
> - * Use normal definitions of mem*() from string.c. There are already
> - * included header files which expect a definition of memset() and by
> - * the time we define memset macro, it is too late.
> + * Provide definitions of memzero and memmove as some of the decompressors will
> + * try to define their own functions if these are not defined as macros.
>   */
> -#undef memcpy
> -#undef memset
>  #define memzero(s, n)	memset((s), 0, (n))
>  #define memmove		memmove
>  
> diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
> index 995f7b7ad512..a232da487cd2 100644
> --- a/arch/x86/boot/string.h
> +++ b/arch/x86/boot/string.h
> @@ -11,10 +11,7 @@ void *memcpy(void *dst, const void *src, size_t len);
>  void *memset(void *dst, int c, size_t len);
>  int memcmp(const void *s1, const void *s2, size_t len);
>  
> -/*
> - * Access builtin version by default. If one needs to use optimized version,
> - * do "undef memcpy" in .c file and link against right string.c
> - */
> +/* Access builtin version by default. */
>  #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
>  #define memset(d,c,l) __builtin_memset(d,c,l)
>  #define memcmp	__builtin_memcmp
> -- 
> 2.26.2
> 

-- 
Kees Cook

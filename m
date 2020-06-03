Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C40C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63EF2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmlTRC4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgFCXif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCXie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:38:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E538C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 16:38:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so2678149pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=261RUT31PuSmoranObguIYWCcctoAaPL9LPaG28MbCU=;
        b=JmlTRC4P+LHl2wjuekNmYIKEnD04fMoCLlZ0I/bKxc3s+wrPgOMkQpUa8tCRZWYVNQ
         RQk3XFYW9ggapHPcpi7C+gFEFykC6RpngWkj5aT8DTc3UV5kh++XlU2i9BHpur85EIrw
         qn2qk8wLyFnfBMQK0k7qez5Jl+psaL0sRQYXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=261RUT31PuSmoranObguIYWCcctoAaPL9LPaG28MbCU=;
        b=WSOYQlRUbxgVc5xhTRLRyq3+8NRHR4zDqupV/c5guRLqx6+68rffOcZllgrLsj/Jtm
         f0Tj8m9GDLojlbkWXUqNclZQEjoud9eYXh+uMqsnDtNQT3W5VtaFIGnu77GNpkAg8LSW
         hUM78Oqgfyb+Vt4J1L8cjXhF/ByLJx71dVYiK89VKeRGulzbMwH4JSa1RtOsOSnZVKkp
         aEncloHbzTMR3vFGbJU2fEWT0Xyj9ayNZg3nSEKsvi4I9j43U9++0XqBQgTFRK9gn2U1
         i9nHZPlL+QELAGqz8ZtXZUbliPUyTp50dXvxRBVkm/xQTlHlxCVnjOn40TKqQbSFxvXI
         YBnA==
X-Gm-Message-State: AOAM532yO3nTLgT7ucqpYy7PzkSVxKTQEl0MhsTiaRVMBji+vsNkSOXa
        rbFh5gwu9Z8UdgfOeY61sGJyAw==
X-Google-Smtp-Source: ABdhPJwu4vjgHI/sr/02FzeDWVOfrsTIi4ohngcW7RRLaBTVoASPovhFX0qIFpsYzUJ7p8kB3zlO7Q==
X-Received: by 2002:a62:1a0f:: with SMTP id a15mr1545975pfa.177.1591227514055;
        Wed, 03 Jun 2020 16:38:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm2431622pgg.43.2020.06.03.16.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:38:33 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:38:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
Message-ID: <202006031634.477F65AC53@keescook>
References: <202006031539.4198EA6@keescook>
 <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:04:31PM -0700, Joe Perches wrote:
> more odd uses (mostly in comments)
> 
> $ git grep -P -oh '\bIS_ENABLED\s*\(\s*\w+\s*\)'| \
>   sed -r 's/\s+//g'| \
>   grep -v '(CONFIG_' | \
>   sort | uniq -c | sort -rn

I think a missed a bunch because my grep was messy. :) This is much
easier to scan.

>       7 IS_ENABLED(DEBUG)
>       4 IS_ENABLED(cfg)
>       2 IS_ENABLED(opt_name)
>       2 IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)
>       2 IS_ENABLED(config)
>       2 IS_ENABLED(cond)
>       2 IS_ENABLED(__BIG_ENDIAN)
>       1 IS_ENABLED(x)
>       1 IS_ENABLED(PWM_DEBUG)
>       1 IS_ENABLED(option)
>       1 IS_ENABLED(DEBUG_RANDOM_TRIE)
>       1 IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)

These seem to be "as expected".

>       4 IS_ENABLED(DRM_I915_SELFTEST)
>       1 IS_ENABLED(STRICT_KERNEL_RWX)
>       1 IS_ENABLED(ETHTOOL_NETLINK)

But these are not.

> 
> STRICT_KERNEL_RWX is misused here in ppc
> 
> ---
> 
> Fix pr_warn without newline too.
> 
>  arch/powerpc/mm/book3s64/hash_utils.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index 51e3c15f7aff..dd60c5f2b991 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -660,11 +660,10 @@ static void __init htab_init_page_sizes(void)
>  		 * Pick a size for the linear mapping. Currently, we only
>  		 * support 16M, 1M and 4K which is the default
>  		 */
> -		if (IS_ENABLED(STRICT_KERNEL_RWX) &&
> +		if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) &&
>  		    (unsigned long)_stext % 0x1000000) {
>  			if (mmu_psize_defs[MMU_PAGE_16M].shift)
> -				pr_warn("Kernel not 16M aligned, "
> -					"disabling 16M linear map alignment");
> +				pr_warn("Kernel not 16M aligned, disabling 16M linear map alignment\n");
>  			aligned = false;
>  		}

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook

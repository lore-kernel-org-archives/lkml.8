Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9D7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14A921527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D7arZ+rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFQRyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgFQRyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:54:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CDC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:54:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so2534069pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+xBJoU5J77TMSnbRZSFhHX3Dp+sjAWUA2ZPGmdFDGcg=;
        b=D7arZ+rYMKO6IBlJVjJzYGvWYy4BqYpAZF05mQbib4+xctfxhPHMgJMPs9OsdTnpcu
         DVrOdGRQq2dnBQUYNnEXySnJwVfY8E60P/9+r3H4rxc/lPrEKIn13ppMk+TSdpRqYtuF
         A+7xr5IzglQ1/iHADByfwxPSyoqoBNfJrQbec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+xBJoU5J77TMSnbRZSFhHX3Dp+sjAWUA2ZPGmdFDGcg=;
        b=jmtJ/Opz5OyR2gVV/Gi5bsUR120y9OWczi5TK2sNjKxBtA7dpN/pOIk8K+AAvHaaIE
         W3SBPC/29iPuYs5zp6x7sTiRncC8HQys/Zxvoa76vXadW43WLcuMSZX+Vc2zMCi8ShNS
         hUy7nNURQzMEI1dkmn9puMc8OnlwIcqFgOKPpWYFPNBkIjqXTb/Bk5TpdN9gzcEgjVvi
         +LkzlMQwhJSO4vxcOYyE0vAQZlcm+xSxN+G+QJkjxqTGlOMSIDm4uN5hzNG32jE9GOfP
         0cFxtcpo6Fuf7Qk3cZT/V5/ZyD8cLrxDPJXqyDzMK4E/uoYrXfwm//a8x5W1SVTrS2aK
         j1zA==
X-Gm-Message-State: AOAM530+PuPS2rKlfuO7U1K1PkoWzu72Iha0GmGgQhImiwN96fT8clIi
        KHJwAJ2CUQfLfVcnd1DTSg3T/w==
X-Google-Smtp-Source: ABdhPJx+r7wpkQkHZx+QQI6IKh4SkzaSGt2+cXjyxOMdYSQaRluqVC41a1oNqCDDlrw7e8Lk4rOX/A==
X-Received: by 2002:a17:902:9882:: with SMTP id s2mr238216plp.112.1592416449904;
        Wed, 17 Jun 2020 10:54:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q145sm458842pfq.128.2020.06.17.10.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:54:09 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:54:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 6/9] mm, slub: introduce static key for slub_debug()
Message-ID: <202006171050.D48F4B7@keescook>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610163135.17364-7-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:31:32PM +0200, Vlastimil Babka wrote:
> One advantage of CONFIG_SLUB_DEBUG is that a generic distro kernel can be built
> with the option enabled, but it's inactive until simply enabled on boot,
> without rebuilding the kernel. With a static key, we can further eliminate the
> overhead of checking whether a cache has a particular debug flag enabled if we
> know that there are no such caches (slub_debug was not enabled during boot). We
> use the same mechanism also for e.g.  page_owner, debug_pagealloc or kmemcg
> functionality.
> 
> This patch introduces the static key and makes the general check for per-cache
> debug flags kmem_cache_debug() use it. This benefits several call sites,
> including (slow path but still rather frequent) __slab_free(). The next patches
> will add more uses.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 8dd2925448ae..24d3e5f832aa 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -114,13 +114,21 @@
>   * 			the fast path and disables lockless freelists.
>   */
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +#ifdef CONFIG_SLUB_DEBUG_ON
> +DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
> +#else
> +DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
> +#endif
> +#endif

Yet another potential future user of DEFINE_STATIC_KEY_MAYBE()[1], once
I get it landed. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

[1] https://lore.kernel.org/lkml/20200324203231.64324-2-keescook@chromium.org/

-- 
Kees Cook

Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B22C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D684A21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gg//lxpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgFQR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:56:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00CEC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:56:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so1660398pgk.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wah6b+5ElzkXhQSXMpu6WP+aPTNfFYkvhbkHvAkhKGg=;
        b=Gg//lxpFtcoeRTFSTUzVOxJMnX7aWTWzCrGG4vux8gR8wyyWdLJh9xPyFLuLZSYoyt
         sLoOoC9Czq0XyiX+HKkry+vk+0A2+y3TFmHLM7dzXsLjtXwfhI8Ryr8jgw0VQQvpOL/s
         U5UJOeITPqpeWC2NnNcRmwZ6WLh2uOnB2ddD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wah6b+5ElzkXhQSXMpu6WP+aPTNfFYkvhbkHvAkhKGg=;
        b=VBEvWhucCpx5MAgchVs3L2xagO02+6Q7z46wCgK2ngewNmKHlVE3i0rTmMahmupJpp
         DW9n3zQvztytXw0udIgmF/NZA8r0pKEClNCjuLCcms8nwSbzpfoFpnUPqJmuC4o2SgET
         /CA/Z7Xly63QMV3t0YmR5t1H2s8+PcyEMOlzQsb+Psv3mn03YkGylPEY0Ji5cpYOky5z
         rjyNfklbKj4KqIHPB7WSWLrfBJkMee1mNXlAEIZIIqZVLycEFLoVnlgkGApxmMv2MleB
         mNX+g4CC6srJXoC/kKW7N1tsgTX8q4I52Cf48CPKpKCheXSaLSBqi9tjSC1LDHxSgfeZ
         RSSg==
X-Gm-Message-State: AOAM533PmrD/cN/3aMMlPrIhL7Lp/BEeg76iDu7S+ZJzfgvDTuApmFbA
        9x3Yegg10l11JZOsVzreyn+SIA==
X-Google-Smtp-Source: ABdhPJwoRs2t9ywysSqyyKsH20UwIP5c2oKFuhH+rZ86gi/ru/XeeOa9CjITUhl6f1WA66aIvINaOA==
X-Received: by 2002:a62:1849:: with SMTP id 70mr7521391pfy.227.1592416604312;
        Wed, 17 Jun 2020 10:56:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w77sm513281pff.126.2020.06.17.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:56:43 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:56:42 -0700
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
Subject: Re: [PATCH 7/9] mm, slub: introduce kmem_cache_debug_flags()
Message-ID: <202006171055.64F6EB665@keescook>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-8-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610163135.17364-8-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:31:33PM +0200, Vlastimil Babka wrote:
> There are few places that call kmem_cache_debug(s) (which tests if any of debug
> flags are enabled for a cache) immediatelly followed by a test for a specific
> flag. The compiler can probably eliminate the extra check, but we can make the
> code nicer by introducing kmem_cache_debug_flags() that works like
> kmem_cache_debug() (including the static key check) but tests for specifig
> flag(s). The next patches will add more users.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 24d3e5f832aa..c8e8b4ae2451 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -122,18 +122,28 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  #endif
>  
> -static inline int kmem_cache_debug(struct kmem_cache *s)
> +/*
> + * Returns true if any of the specified slub_debug flags is enabled for the
> + * cache. Use only for flags parsed by setup_slub_debug() as it also enables
> + * the static key.
> + */
> +static inline int kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)

This should return slab_flag_t, yes?

>  {
>  #ifdef CONFIG_SLUB_DEBUG
>  	if (static_branch_unlikely(&slub_debug_enabled))
> -		return s->flags & SLAB_DEBUG_FLAGS;
> +		return s->flags & flags;
>  #endif
>  	return 0;
>  }
>  
> +static inline int kmem_cache_debug(struct kmem_cache *s)

And this too, as long as we're making changes here.

-- 
Kees Cook

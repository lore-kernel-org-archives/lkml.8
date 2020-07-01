Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019B2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFB320870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKw3y28u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGASwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgGASwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:52:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D448C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 11:52:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so11387270pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+/n+6AxpUg9QzHb5YBIhMhs6/emUx+VgYGqTlwi4IMw=;
        b=tKw3y28uTOBX9axPwIKFUPPmh0R0UNimy9v+qXphx9OQ+8fNirGczQwtCOYzkSUsDy
         XfzLwndgIx1YzhgqrfZPK9CvKHaLYAi7VQ3391n5HfRKx4FHEVrnIt1yL2HuBCa19s/N
         AeJA3vKm+9VAn/8DZ51lc7rNYGWTjrc6I16ml/wl8mJ2Sm5FHOdk4vyBoylbAm8tK12N
         4CXJ3//34hdOlLKx1qhUOqxZjYwGv1X4is1X51aZzRRFO/XsitFrxVDcDATtCxHD65lE
         9wczxCZw5jN9/ZRKYgD0SMLsCQhe9//H5HzOpmP3WjedI/z5/gwI8wlfL+7AowIKcUUy
         Hoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+/n+6AxpUg9QzHb5YBIhMhs6/emUx+VgYGqTlwi4IMw=;
        b=Z7IYLcHzRvFALjbGku2f6+Na+xAbQlwKe47qx4v6Ql4Lfaaq7Hq4GL/omTnD18UUZ7
         jrZqlBOOEYquwO6hpUXyt4iDheH63VWA19B2PVB5yt1XlIeKvxEOlHnFN1S2jF44g1h4
         gJ9x60Y7DPWEpibAssad+XCcAFcY0NhNWj6huA24mGiufJ36cZ4nrEVLrYNKSlSXaIK6
         hoNIn0kJqboG6IhzE3P+l2RRVhBY1yyhU5i5XATsQGIZOcSmNLZEW3Bwh/VflvkW9YJ2
         uVqNGD3lK3MK0sHPL+Z98FpAGmzjpEI7m9niMKthINYI0msf0pvLS23QUJikvR09PDDF
         /I/g==
X-Gm-Message-State: AOAM533xGthW9xmogUPvg4RPEcPf8EKF9SWsHUiEYZQxnQS0S9dqQUQU
        9XPKrR0rrrbF0mJYIjJq22GEhw==
X-Google-Smtp-Source: ABdhPJyXox+ncRoHMQBKw7ZwrumR4Fwo/GwuOgboLMouAMLOoRUv07ki2zYQREXcc1NMMx2OqJfdWw==
X-Received: by 2002:a65:4908:: with SMTP id p8mr20783609pgs.214.1593629559668;
        Wed, 01 Jul 2020 11:52:39 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id u20sm6359360pfm.152.2020.07.01.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 11:52:39 -0700 (PDT)
Date:   Wed, 1 Jul 2020 11:52:38 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Long Li <lonuxli.64@gmail.com>
cc:     willy@infradead.org, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, slab: Check GFP_SLAB_BUG_MASK before alloc_pages
 in kmalloc_order
In-Reply-To: <20200701151645.GA26223@lilong>
Message-ID: <alpine.DEB.2.23.453.2007011151280.1908531@chino.kir.corp.google.com>
References: <20200701151645.GA26223@lilong>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020, Long Li wrote:

> diff --git a/mm/slab.c b/mm/slab.c
> index ac7a223d9ac3..2850fe3c5fb8 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2573,13 +2573,9 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
>  	 * Be lazy and only check for valid flags here,  keeping it out of the
>  	 * critical path in kmem_cache_alloc().
>  	 */
> -	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
> -		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
> -		flags &= ~GFP_SLAB_BUG_MASK;
> -		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> -				invalid_mask, &invalid_mask, flags, &flags);
> -		dump_stack();
> -	}
> +	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> +		flags = kmalloc_invalid_flags(flags);
> +
>  	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
>  	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
>  

Is this name correct?  kmalloc_invalid_flags() masks off the invalid flags 
and returns the valid flags :)  Maybe kmalloc_check_flags()?

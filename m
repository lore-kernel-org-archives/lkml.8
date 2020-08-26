Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DA1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043222074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="zTWK1kAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHZQ2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgHZQ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:28:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D90C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:28:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u3so2429483qkd.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+AffAjKsRXV4iuuUyWXhmFhrbRKp4ijCwhOH6K1QUoM=;
        b=zTWK1kAaol1sXKzKa6Zh0erJPvRLYszBA6l3yTnCoVH1T8/16/AW1V2nsDX9y2EX9B
         vDiOxAlRGWwrxcKHjAxU7j78zHdQwgGe/v70HlXNkP5X2hCozTh8lik5JFO2+R01Ei67
         h9aE6og5sbeZ7AFl8Lu8+u4Ek1C+h9N66vnSS2jqAX7DwFlLUw8wTnH7RS4/hMhxJygL
         N2Y5K4YgzBaAhiNjLgLPYJO5vbwE102QQsoK+Ha2mp3sz4VVikKedZRfUVAz/iWuX19Y
         DmmVCSiYFWZc6j+9h4hnBnvooK7Kb0Jc2IWSn+vIp4ddlDhyvd2dEAXNN8LGa3SwG/Mw
         02QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+AffAjKsRXV4iuuUyWXhmFhrbRKp4ijCwhOH6K1QUoM=;
        b=ipLcEuQyD9TAAlrx856TX5BsiqF3u3Xseuu2Tmge9Jh5ZesH8FquchPLnaxTf5L2pE
         UPDUm+iTTXazF2QR48lcQVUcDAZsHHtYh9NYT4Bqllkfogp3+TsvBy7ArT2yd671Kw3l
         wsUNl+G8B6L6B+dyv1rXyBWKo1KdKLUxn0DCYy2eVtX4l9EkAykjwwZgliE6tjGQpQke
         5bFctWf2qP2thlZ3JMTwy13hiGQmpIM4U04CDuMHEfXhWdE2+YHIO3YXiVH4jOGT0Dti
         ZV+gexML/Y+EWBczsAyExOvdAEU/dBsOluSLqcnkUn64dYtIs9Z+Km89Cpkg4xoDixjF
         bp+A==
X-Gm-Message-State: AOAM531GBJpHOs4qPM8sONlkk5jr7Im1A8jyrY4ke2/+DFavwzP4qfVh
        mWaIilt3y1MCI09Fv3+Rcsqv0Q==
X-Google-Smtp-Source: ABdhPJwTQbQQGi2mb8+E7rQGX5gKMRxHvunIgPTVd+EFjbe2YlyqEYeZ1Qwf3MGM0SxxfCONGSdhZg==
X-Received: by 2002:a37:b307:: with SMTP id c7mr15128487qkf.33.1598459282888;
        Wed, 26 Aug 2020 09:28:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:412a])
        by smtp.gmail.com with ESMTPSA id o31sm2354152qte.65.2020.08.26.09.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:28:01 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:26:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mm: Use find_get_swap_page in memcontrol
Message-ID: <20200826162647.GA995045@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-3-willy@infradead.org>
 <20200826142002.GA988805@cmpxchg.org>
 <20200826145414.GS17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826145414.GS17456@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 03:54:14PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 26, 2020 at 10:20:02AM -0400, Johannes Weiner wrote:
> > On Wed, Aug 19, 2020 at 07:48:44PM +0100, Matthew Wilcox (Oracle) wrote:
> > > +	return find_get_swap_page(vma->vm_file->f_mapping,
> > > +			linear_page_index(vma, addr));
> > 
> > The refactor makes sense to me, but the name is confusing. We're not
> > looking for a swap page, we're primarily looking for a file page in
> > the page cache mapping that's handed in. Only in the special case
> > where it's a shmem mapping and there is a swap entry do we consult the
> > auxiliary swap cache.
> > 
> > How about find_get_page_or_swapcache()? find_get_page_shmemswap()?
> > Maybe you have a better idea. It's a fairly specialized operation that
> > isn't widely used, so a longer name isn't a bad thing IMO.
> 
> Yeah, I had trouble with the naming here too.
> 
> get_page_even_from_swap()
> find_get_shmem_page()
> 
> or maybe refactor the whole thing:
> 
> 	struct page *page = find_get_entry(mapping, index);
> 	page = find_swap_page(mapping, page);
> 
> struct page *find_swap_page(struct address_space *mapping, struct page *page)
> {
> 	swp_entry_t swp;
> 	struct swap_info_struct *si;
> 
> 	if (!xa_is_value(page))
> 		return page;
> 	if (!shmem_mapping(mapping))
> 		return NULL;
> 
> 	...
> }

Yeah, I like the idea of two lookups if we can't find a good name for
the operation that combines them. I'd just bubble the control flow
that links them up to the callsite - that still seems plenty compact
for two callsites, and keeps all the shmem magic in shmem code:

	page = find_get_entry(mapping, index);
	if (xa_is_value(page))
		if (shmem_mapping(mapping))
			page = lookup_shmem_swap_cache(page);
		else
			page = NULL;

So close to making radix_to_swp_entry() & co. private to shmem.c, too
- if it weren't for force_shm_swapin_readahead(). Ah well.

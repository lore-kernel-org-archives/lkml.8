Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC8BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D1F206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581613710;
	bh=rFeUJUSVKzIfDXtVnk4iEP7oAl9zX5RpvzeLOWgKYHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qEZuM5dIH6ylwECSSzOoXcc43+Ap734qzB/2ZzV+6o8wUYzMZFyTTiLd7cTq7lm/u
	 SzYw8ZKBkpJVAo61odtWgg/6O2oJ26MgNdYKBuGlnkMlhTUVq6DGMlrblW0zX2+amB
	 Y9NQq8mpFkANsvUUkt+Jn/q0kBFRVq8VdlSBpXvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgBMRI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:08:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37505 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgBMRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:08:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so7631075wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IFTjbZrH5PoyWG2b0U3TmFoaGHte+NO5dGEdKJcd8Bk=;
        b=leWWnyS0vvmyfO9rrsLeA97LKmsRC8woPOxRGbhtkZ5tqC4IOetV3DRTY173Y7dWs8
         +oMP2qaZYlmBUw7jrNvtgmKEC082iUDUZ1mQ2o4Q6uBES6W05+1p0zYGBWFJ73hvD+VF
         dSZr2mNgsJ5XD+YcfGBWuL3ietbzDT0lYWM4fZse2ArQS6iSPCrS+POqkR9s+W7FZDZZ
         RWlMCzCAJmUP/Y+ccgsWD3qoOexf8/Rw4jkRE4FLw3cbI1n5uc1yP4lniMDBuxFgfYlP
         eC8kiptn2hVXhNbCtRJnfa5+7UhjS9z5F34oqcIM6S8zyTHLMOI66gevIHFnMNqgeA52
         GYWQ==
X-Gm-Message-State: APjAAAVR+1F3awA1ADewMKIKC8w2XhcpvG+w2d4Qo0nsnH8PXfA/TvVO
        hCp5EYMslZJ61oSctnnYtng=
X-Google-Smtp-Source: APXvYqw7oRd11X4Q1kuJ+5pTf2fwuFkGJ8uTmvjuljKAOeWSDBuIwdPoNw5zUkKCRJ3W1rq1J9p4YA==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr6530095wml.44.1581613706455;
        Thu, 13 Feb 2020 09:08:26 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id v17sm3417734wrt.91.2020.02.13.09.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:08:25 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:08:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200213170824.GJ31689@dhcp22.suse.cz>
References: <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org>
 <20200128091352.GC18145@dhcp22.suse.cz>
 <20200128104857.GC6615@bombadil.infradead.org>
 <20200128113953.GA24244@dhcp22.suse.cz>
 <20200213074847.GB31689@dhcp22.suse.cz>
 <20200213164607.GR7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213164607.GR7778@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-02-20 08:46:07, Matthew Wilcox wrote:
> On Thu, Feb 13, 2020 at 08:48:47AM +0100, Michal Hocko wrote:
> > Can we pursue on this please? An explicit NOFS scope annotation with a
> > reference to compaction potentially locking up on pages in the readahead
> > would be a great start.
> 
> How about this (on top of the current readahead series):
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 29ca25c8f01e..32fd32b913da 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -160,6 +160,16 @@ unsigned long page_cache_readahead_limit(struct address_space *mapping,
>  		.nr_pages = 0,
>  	};
>  
> +	/*
> +	 * Partway through the readahead operation, we will have added
> +	 * locked pages to the page cache, but will not yet have submitted
> +	 * them for I/O.  Adding another page may need to allocate
> +	 * memory, which can trigger memory migration.	Telling the VM

I would go with s@migration@compaction@ because it would make it more
obvious that this is about high order allocations.

The patch looks ok other than that but FS people would be better than me
to give it a proper review.

It would be great if you could mention that this shouldn't be a real
problem for many(/most?) filesystems because they tend to have NOFS like
mask in the the mapping but we would love to remove that in future
hopefully so this change is really desiable.

Thanks!

> +	 * we're in the middle of a filesystem operation will cause it
> +	 * to not touch file-backed pages, preventing a deadlock.
> +	 */
> +	unsigned int nofs = memalloc_nofs_save();
> +
>  	/*
>  	 * Preallocate as many pages as we will need.
>  	 */
> @@ -217,6 +227,7 @@ unsigned long page_cache_readahead_limit(struct address_space *mapping,
>  	 */
>  	read_pages(&rac, &page_pool);
>  	BUG_ON(!list_empty(&page_pool));
> +	memalloc_nofs_restore(nofs);
>  	return rac.nr_pages;
>  }
>  EXPORT_SYMBOL_GPL(page_cache_readahead_limit);

-- 
Michal Hocko
SUSE Labs

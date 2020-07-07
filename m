Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3A8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADB52073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594122517;
	bh=zEJF04Es+dSkltrVYo1tks8J68o2nar8dXFzvVjDGPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rtSUGhkWgwdnGqPFraPJJtERTcg8gHX019ad8O3dtwZ+6IBX8buHk9QJp2jTX98l+
	 ICTWo83lpf1gS/qIscjO2JyaZ6euxr7ubLRXkAqn/v5+mhUZ4vtoJn9c+4XTlRNij0
	 dPszgyJFIuiIDmphtsI+WZj8kF7B+2A5xJQIIEbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgGGLsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:48:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgGGLse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:48:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so41801983wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41aS1ZfHl6tQOcJ9IX63S3z+J1tFBqJh+v8HwkSGNXY=;
        b=TFd6lu99C5AQPblhp57wa9uadaBkKg8ql7EBVSlzWhNhBVvp510OU/1FotztD9SywG
         p6EUEslXvX7klHBuc91bhudc8GWgISR2urimFg+nJ4XyKaGWy+504J7zOT8UVe2BWFfV
         7UVOC46xuCduEHQV4ve/BScoTK6KTI38aGLSBrdwcttR1pNgRIC6RER1qwI5Gzlumg9/
         rWFeKK0LmWZw7Z08S2IvFa9AYZ/qMKZRBatTZpV1ajKD28SUzxMrPnHRywdrXu438K14
         kUEsnH5KQvmr6NjtukJcmT+C8xwONqVCMqPrAUONxolfqd8n/p36pCqDaCcqGhwbbv8z
         tCKw==
X-Gm-Message-State: AOAM532nH9YbK/xvG+38dPBQH76mo6uANPLgs0WN0MNbPZm6CWZV7g3C
        i4oK+pmf8O2R+bvc8aYfFp8=
X-Google-Smtp-Source: ABdhPJzhWZqrDEV5ToM1M8J1p7YGNiEQbp9oCSRqUJ3tCj3GJ2b+BAssTUazKZCivg6iB3FjXyWmpQ==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr52035653wrq.171.1594122511923;
        Tue, 07 Jul 2020 04:48:31 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id l132sm778285wmf.6.2020.07.07.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:48:31 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:48:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 10/11] mm/memory-failure: remove a wrapper for
 alloc_migration_target()
Message-ID: <20200707114829.GL5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-11-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594107889-32228-11-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 16:44:48, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined standard migration target callback. Use it
> directly.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/memory-failure.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 609d42b6..3b89804 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1677,16 +1677,6 @@ int unpoison_memory(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(unpoison_memory);
>  
> -static struct page *new_page(struct page *p, unsigned long private)
> -{
> -	struct migration_target_control mtc = {
> -		.nid = page_to_nid(p),
> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> -	};
> -
> -	return alloc_migration_target(p, (unsigned long)&mtc);
> -}
> -
>  /*
>   * Safely get reference count of an arbitrary page.
>   * Returns 0 for a free page, -EIO for a zero refcount page
> @@ -1793,6 +1783,10 @@ static int __soft_offline_page(struct page *page)
>  	const char *msg_page[] = {"page", "hugepage"};
>  	bool huge = PageHuge(page);
>  	LIST_HEAD(pagelist);
> +	struct migration_target_control mtc = {
> +		.nid = NUMA_NO_NODE,
> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};

Is NUMA_NO_NODE really intended here? The original code has preferred to
stay on the same node. If this is intentional then the changelog should
be explicit about that.

>  
>  	/*
>  	 * Check PageHWPoison again inside page lock because PageHWPoison
> @@ -1829,8 +1823,8 @@ static int __soft_offline_page(struct page *page)
>  	}
>  
>  	if (isolate_page(hpage, &pagelist)) {
> -		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
> -					MIGRATE_SYNC, MR_MEMORY_FAILURE);
> +		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
>  		if (!ret) {
>  			bool release = !huge;
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs

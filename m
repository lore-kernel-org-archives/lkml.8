Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C4EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451032465B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAUen8s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgATNao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:30:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59685 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbgATNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579527042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=jPAzBN9XG7C1n7bOKW3O9zHcnFfsPL/ThYIrObalgyA=;
        b=FAUen8s76XQX5rDoN9d/GHIRzhK9Xl6wLMbwxuF5yOxBs8VXYTG23RztiBBU6njLA5K5tr
        75cKsNVbzaR8RYmcVXey+XVawi71zxV73uToGW2v0Jp3kuTC7ZqvyzuE8wZAa5OXXVrtf6
        jWfIxbP1WMXWKYbYFtMx4nTJoQfLYbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-Krw-Xtf6OTqmh6iQV1RH0A-1; Mon, 20 Jan 2020 08:30:36 -0500
X-MC-Unique: Krw-Xtf6OTqmh6iQV1RH0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68AAB1005510;
        Mon, 20 Jan 2020 13:30:35 +0000 (UTC)
Received: from [10.36.118.34] (unknown [10.36.118.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 110CA5C21A;
        Mon, 20 Jan 2020 13:30:33 +0000 (UTC)
Subject: Re: [PATCH -mm v2] mm/page_isolation: fix potential warning from user
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200120131909.813-1-cai@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <8c56268d-9b8a-f62e-eca9-7707852a2aaf@redhat.com>
Date:   Mon, 20 Jan 2020 14:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120131909.813-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.20 14:19, Qian Cai wrote:
> It makes sense to call the WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE)
> from start_isolate_page_range(), but should avoid triggering it from
> userspace, i.e, from is_mem_section_removable() because it could be a
> DoS if warn_on_panic is set.
> 
> While at it, simplify the code a bit by removing an unnecessary jump
> label and a local variable, so set_migratetype_isolate() could really
> return a bool.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Improve the commit log.
>     Warn for all start_isolate_page_range() users not just offlining.
> 
>  mm/page_alloc.c     | 11 ++++-------
>  mm/page_isolation.c | 30 +++++++++++++++++-------------
>  2 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 621716a25639..3c4eb750a199 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		if (is_migrate_cma(migratetype))
>  			return NULL;
>  
> -		goto unmovable;
> +		return page;
>  	}
>  
>  	for (; iter < pageblock_nr_pages; iter++) {
> @@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		page = pfn_to_page(pfn + iter);
>  
>  		if (PageReserved(page))
> -			goto unmovable;
> +			return page;
>  
>  		/*
>  		 * If the zone is movable and we have ruled out all reserved
> @@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  			unsigned int skip_pages;
>  
>  			if (!hugepage_migration_supported(page_hstate(head)))
> -				goto unmovable;
> +				return page;
>  
>  			skip_pages = compound_nr(head) - (page - head);
>  			iter += skip_pages - 1;
> @@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 * is set to both of a memory hole page and a _used_ kernel
>  		 * page at boot.
>  		 */
> -		goto unmovable;
> +		return page;
>  	}
>  	return NULL;
> -unmovable:
> -	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	return pfn_to_page(pfn + iter);
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index e70586523ca3..31f5516f5d54 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -15,12 +15,12 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/page_isolation.h>
>  
> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
> +static bool set_migratetype_isolate(struct page *page, int migratetype,
> +				    int isol_flags)

Why this change?

>  {
> -	struct page *unmovable = NULL;
> +	struct page *unmovable = ERR_PTR(-EBUSY);

Also, why this change?

>  	struct zone *zone;
>  	unsigned long flags;
> -	int ret = -EBUSY;
>  
>  	zone = page_zone(page);
>  
> @@ -49,21 +49,25 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  									NULL);
>  
>  		__mod_zone_freepage_state(zone, -nr_pages, mt);
> -		ret = 0;
>  	}
>  
>  out:
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -	if (!ret)
> +
> +	if (!unmovable) {
>  		drain_all_pages(zone);
> -	else if ((isol_flags & REPORT_FAILURE) && unmovable)
> -		/*
> -		 * printk() with zone->lock held will guarantee to trigger a
> -		 * lockdep splat, so defer it here.
> -		 */
> -		dump_page(unmovable, "unmovable page");
> -
> -	return ret;
> +	} else {
> +		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> +
> +		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
> +			/*

Why this change? (!IS_ERR)


Some things here look unrelated - or I am missing something :)

-- 
Thanks,

David / dhildenb


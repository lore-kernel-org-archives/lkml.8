Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28BAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE519246B8
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592687059;
	bh=o8uHws6VLwHyqYldC7EmQtIl/C7Bn2oBRr57FeHYGSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1OTOA+lWfIkBrOaSkpdrCTYX1gJK6Q2xbYBkthxbXnbNqOSAVzDcb7gwCey1FVv72
	 DTt3q/ELd0dOV8VohmFs2D13NywLwJFWWOPDe5s07o3QJbMgeP9dAy1yk+rQtL/dGj
	 x8A90+NSIgNRKeu8HLi/62kfKZ2NxBk4UALiq7rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgFTVAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgFTVAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:00:20 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 693FF206B7;
        Sat, 20 Jun 2020 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592686819;
        bh=o8uHws6VLwHyqYldC7EmQtIl/C7Bn2oBRr57FeHYGSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2AaUMIhThXFiP4OUgqM/0+7Ygl9MrmPX6icm5BrOMkpPZ88R8p9Zc62sBBR8inI2u
         0IVFC3benztc9rKUfOrNPLOPhpe2rAYTb8u/ImrNV+6yVV0qS2G5dbwoNJB8ESQsxq
         vkj1+4NL8K8BkZu/DRbDC2GIgPPWSlmc1yLSLTPQ=
Date:   Sat, 20 Jun 2020 14:00:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, slab: Fix sign conversion problem in
 memcg_uncharge_slab()
Message-Id: <20200620140018.a305aebd01b2cf4226547944@linux-foundation.org>
In-Reply-To: <20200620184719.10994-1-longman@redhat.com>
References: <20200620184719.10994-1-longman@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 14:47:19 -0400 Waiman Long <longman@redhat.com> wrote:

> It was found that running the LTP test on a PowerPC system could produce
> erroneous values in /proc/meminfo, like:
> 
>   MemTotal:       531915072 kB
>   MemFree:        507962176 kB
>   MemAvailable:   1100020596352 kB
> 
> Using bisection, the problem is tracked down to commit 9c315e4d7d8c
> ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").
> 
> In memcg_uncharge_slab() with a "int order" argument:
> 
>   unsigned int nr_pages = 1 << order;
>     :
>   mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);
> 
> The mod_lruvec_state() function will eventually call the
> __mod_zone_page_state() which accepts a long argument.  Depending on
> the compiler and how inlining is done, "-nr_pages" may be treated as
> a negative number or a very large positive number. Apparently, it was
> treated as a large positive number in that PowerPC system leading to
> incorrect stat counts. This problem hasn't been seen in x86-64 yet,
> perhaps the gcc compiler there has some slight difference in behavior.
> 
> It is fixed by making nr_pages a signed value. For consistency, a
> similar change is applied to memcg_charge_slab() as well.

This is somewhat disturbing.

> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -348,7 +348,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
>  					     gfp_t gfp, int order,
>  					     struct kmem_cache *s)
>  {
> -	unsigned int nr_pages = 1 << order;
> +	int nr_pages = 1 << order;
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  	int ret;
> @@ -388,7 +388,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
>  static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>  						struct kmem_cache *s)
>  {
> -	unsigned int nr_pages = 1 << order;
> +	int nr_pages = 1 << order;
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  

I grabbed the patch, but Roman's "mm: memcg/slab: charge individual
slab objects instead of pages"
(http://lkml.kernel.org/r/20200608230654.828134-10-guro@fb.com) deletes
both these functions.

It replaces the offending code with, afaict,


static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
					void *p)
{
	struct obj_cgroup *objcg;
	unsigned int off;

	if (!memcg_kmem_enabled() || is_root_cache(s))
		return;

	off = obj_to_index(s, page, p);
	objcg = page_obj_cgroups(page)[off];
	page_obj_cgroups(page)[off] = NULL;

	obj_cgroup_uncharge(objcg, obj_full_size(s));
	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
>>>			-obj_full_size(s));

	obj_cgroup_put(objcg);
}

-obj_full_size() returns size_t so I guess that's OK.



Also


static __always_inline void uncharge_slab_page(struct page *page, int order,
					       struct kmem_cache *s)
{
#ifdef CONFIG_MEMCG_KMEM
	if (memcg_kmem_enabled() && !is_root_cache(s)) {
		memcg_free_page_obj_cgroups(page);
		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
	}
#endif
	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
>>>			    -(PAGE_SIZE << order));
}

PAGE_SIZE is unsigned long so I guess that's OK as well.


Still, perhaps both could be improved.  Negating an unsigned scalar is
a pretty ugly thing to do.

Am I wrong in thinking that all those mod_foo() functions need careful
review?


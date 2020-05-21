Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88194C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAAD206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgEULBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:01:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgEULBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:01:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 85E87AFF5;
        Thu, 21 May 2020 11:01:42 +0000 (UTC)
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <0e0616f2-6c5a-8911-7d37-6f2027c2930b@suse.cz>
 <20200520210040.GC278395@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <266af2b2-41d0-368c-1896-1a7637389054@suse.cz>
Date:   Thu, 21 May 2020 13:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520210040.GC278395@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 11:00 PM, Roman Gushchin wrote:
> 
> From beeaecdac85c3a395dcfb99944dc8c858b541cbf Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Mon, 29 Jul 2019 18:18:42 -0700
> Subject: [PATCH v3.2 04/19] mm: slub: implement SLUB version of obj_to_index()
> 
> This commit implements SLUB version of the obj_to_index() function,
> which will be required to calculate the offset of obj_cgroup in the
> obj_cgroups vector to store/obtain the objcg ownership data.
> 
> To make it faster, let's repeat the SLAB's trick introduced by
> commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
> divide in obj_to_index()") and avoid an expensive division.
> 
> Vlastimil Babka noticed, that SLUB does have already a similar
> function called slab_index(), which is defined only if SLUB_DEBUG
> is enabled. The function does a similar math, but with a division,
> and it also takes a page address instead of a page pointer.
> 
> Let's remove slab_index() and replace it with the new helper
> __obj_to_index(), which takes a page address. obj_to_index()
> will be a simple wrapper taking a page pointer and passing
> page_address(page) into __obj_to_index().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Looks good!

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/slub_def.h | 16 ++++++++++++++++
>  mm/slub.c                | 15 +++++----------
>  2 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index d2153789bd9f..30e91c83d401 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -8,6 +8,7 @@
>   * (C) 2007 SGI, Christoph Lameter
>   */
>  #include <linux/kobject.h>
> +#include <linux/reciprocal_div.h>
>  
>  enum stat_item {
>  	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> @@ -86,6 +87,7 @@ struct kmem_cache {
>  	unsigned long min_partial;
>  	unsigned int size;	/* The size of an object including metadata */
>  	unsigned int object_size;/* The size of an object without metadata */
> +	struct reciprocal_value reciprocal_size;
>  	unsigned int offset;	/* Free pointer offset */
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	/* Number of per cpu partial objects to keep around */
> @@ -182,4 +184,18 @@ static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
>  	return result;
>  }
>  
> +/* Determine object index from a given position */
> +static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
> +					  void *addr, void *obj)
> +{
> +	return reciprocal_divide(kasan_reset_tag(obj) - addr,
> +				 cache->reciprocal_size);
> +}
> +
> +static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> +					const struct page *page, void *obj)
> +{
> +	return __obj_to_index(cache, page_address(page), obj);
> +}
> +
>  #endif /* _LINUX_SLUB_DEF_H */
> diff --git a/mm/slub.c b/mm/slub.c
> index 2df4d4a420d1..d605d18b3c1b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -313,12 +313,6 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
>  		__p < (__addr) + (__objects) * (__s)->size; \
>  		__p += (__s)->size)
>  
> -/* Determine object index from a given position */
> -static inline unsigned int slab_index(void *p, struct kmem_cache *s, void *addr)
> -{
> -	return (kasan_reset_tag(p) - addr) / s->size;
> -}
> -
>  static inline unsigned int order_objects(unsigned int order, unsigned int size)
>  {
>  	return ((unsigned int)PAGE_SIZE << order) / size;
> @@ -461,7 +455,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
>  	bitmap_zero(object_map, page->objects);
>  
>  	for (p = page->freelist; p; p = get_freepointer(s, p))
> -		set_bit(slab_index(p, s, addr), object_map);
> +		set_bit(__obj_to_index(s, addr, p), object_map);
>  
>  	return object_map;
>  }
> @@ -3682,6 +3676,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  	 */
>  	size = ALIGN(size, s->align);
>  	s->size = size;
> +	s->reciprocal_size = reciprocal_value(size);
>  	if (forced_order >= 0)
>  		order = forced_order;
>  	else
> @@ -3788,7 +3783,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
>  	map = get_map(s, page);
>  	for_each_object(p, s, addr, page->objects) {
>  
> -		if (!test_bit(slab_index(p, s, addr), map)) {
> +		if (!test_bit(__obj_to_index(s, addr, p), map)) {
>  			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
>  			print_tracking(s, p);
>  		}
> @@ -4513,7 +4508,7 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
>  	/* Now we know that a valid freelist exists */
>  	map = get_map(s, page);
>  	for_each_object(p, s, addr, page->objects) {
> -		u8 val = test_bit(slab_index(p, s, addr), map) ?
> +		u8 val = test_bit(__obj_to_index(s, addr, p), map) ?
>  			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
>  
>  		if (!check_object(s, page, p, val))
> @@ -4704,7 +4699,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
>  
>  	map = get_map(s, page);
>  	for_each_object(p, s, addr, page->objects)
> -		if (!test_bit(slab_index(p, s, addr), map))
> +		if (!test_bit(__obj_to_index(s, addr, p), map))
>  			add_location(t, s, get_track(s, p, alloc));
>  	put_map(map);
>  }
> 


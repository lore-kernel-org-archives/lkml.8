Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67AA20849
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgETNvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:51:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETNvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:51:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5774FAC46;
        Wed, 20 May 2020 13:51:49 +0000 (UTC)
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0e0616f2-6c5a-8911-7d37-6f2027c2930b@suse.cz>
Date:   Wed, 20 May 2020 15:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-5-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:46 PM, Roman Gushchin wrote:
> This commit implements SLUB version of the obj_to_index() function,
> which will be required to calculate the offset of obj_cgroup in the
> obj_cgroups vector to store/obtain the objcg ownership data.
> 
> To make it faster, let's repeat the SLAB's trick introduced by
> commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
> divide in obj_to_index()") and avoid an expensive division.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

There's already a slab_index() doing the same without the trick, with only
SLUB_DEBUG callers. Maybe just improve it and perhaps rename? (obj_to_index()
seems more descriptive). The difference is that it takes the result of
page_addr() instead of doing that, as it's being called in a loop on objects
from a single page, so you'd have to perhaps split to obj_to_index(page) and
__obj_to_index(addr) or something.

> ---
>  include/linux/slub_def.h | 9 +++++++++
>  mm/slub.c                | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index d2153789bd9f..200ea292f250 100644
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
> @@ -182,4 +184,11 @@ static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
>  	return result;
>  }
>  
> +static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> +					const struct page *page, void *obj)
> +{
> +	return reciprocal_divide(kasan_reset_tag(obj) - page_address(page),
> +				 cache->reciprocal_size);
> +}
> +
>  #endif /* _LINUX_SLUB_DEF_H */
> diff --git a/mm/slub.c b/mm/slub.c
> index 03071ae5ff07..8d16babe1829 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3660,6 +3660,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  	 */
>  	size = ALIGN(size, s->align);
>  	s->size = size;
> +	s->reciprocal_size = reciprocal_value(size);
>  	if (forced_order >= 0)
>  		order = forced_order;
>  	else
> 


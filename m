Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC41DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58AA20738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgEVS1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:27:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:34168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgEVS1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:27:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 41C61ACE6;
        Fri, 22 May 2020 18:27:19 +0000 (UTC)
Subject: Re: [PATCH v3 07/19] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-8-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <930fb5f4-0666-5db0-0fcf-a78171bf29be@suse.cz>
Date:   Fri, 22 May 2020 20:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-8-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:46 PM, Roman Gushchin wrote:
> Allocate and release memory to store obj_cgroup pointers for each
> non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> to the allocated space.
> 
> To distinguish between obj_cgroups and memcg pointers in case
> when it's not obvious which one is used (as in page_cgroup_ino()),
> let's always set the lowest bit in the obj_cgroup case.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

But I have a suggestion:

...

> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -191,4 +191,6 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
>  				 cache->reciprocal_size);
>  }
>  
> +extern int objs_per_slab(struct kmem_cache *cache);
> +
>  #endif /* _LINUX_SLUB_DEF_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7f87a0eeafec..63826e460b3f 100644

...

> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5992,4 +5992,9 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
>  {
>  	return -EIO;
>  }
> +
> +int objs_per_slab(struct kmem_cache *cache)
> +{
> +	return oo_objects(cache->oo);
> +}
>  #endif /* CONFIG_SLUB_DEBUG */
> 

It's somewhat unfortunate to function call just for this. Although perhaps
compiler can be smart enough as charge_slab_page() (that callse objs_per_slab())
is inline and called from alloc_slab_page() which is also in mm/slub.c.

But it might be also a bit wasteful in case SLUB doesn't manage to allocate its
desired order, but smaller. The actual number of objects is then in page->objects.

So ideally this should use something like objs_per_slab_page(cache, page) where
SLAB supplies cache->num and SLUB page->objects, both implementations inline,
and ignoring the other parameter?

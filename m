Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008A0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37E92074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgFEQYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:24:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgFEQYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:24:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A90C5AC5F;
        Fri,  5 Jun 2020 16:24:37 +0000 (UTC)
Subject: Re: [PATCH v5 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200527223404.1008856-1-guro@fb.com>
 <20200527223404.1008856-18-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d7cdecbc-db24-8ced-1a86-6f4534613763@suse.cz>
Date:   Fri, 5 Jun 2020 18:24:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527223404.1008856-18-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 12:34 AM, Roman Gushchin wrote:
> diff --git a/mm/slab.h b/mm/slab.h
> index c49a863adb63..57b425d623e5 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
...
> @@ -526,8 +430,7 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  	 * When kmemcg is not being used, both assignments should return the
>  	 * same value. but we don't want to pay the assignment price in that
>  	 * case. If it is not compiled in, the compiler should be smart enough
> -	 * to not do even the assignment. In that case, slab_equal_or_root
> -	 * will also be a constant.
> +	 * to not do even the assignment.
>  	 */
>  	if (!memcg_kmem_enabled() &&

Just realized that this test can go away - we don't have to call virt_to_cache()
due to kmemcg if there is just a single cache.

>  	    !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> @@ -535,7 +438,7 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  		return s;
>  
>  	cachep = virt_to_cache(x);
> -	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
> +	WARN_ONCE(cachep && cachep != s,
>  		  "%s: Wrong slab cache. %s but object is from %s\n",
>  		  __func__, s->name, cachep->name);
>  	return cachep;

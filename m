Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C47C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C69206D5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="I8fAtO4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGVDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:03:31 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B670C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:03:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g185so1030868qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qcKYLVt6/NNJuQkZbbwTmTKpZql0R6iO8Dr7nx85OkM=;
        b=I8fAtO4ClEbBWt+UUO3Dwt+srJXW10D9hX2anKmgKYvAo4vvj4pxdGmu17H/mzJ6mn
         FAg81y3+hc6lkj085UoPx4ih3+p+IMmEZFpbiZKE1l7Y6nNExdpBkeczCez7DVX+EO7M
         gUZTcSRWuZkQMZXUkCBgHteJyr51toiodbFaZL4gZqez/5V8kp9Zfj93sgH2L2KRwZfH
         +aPXM9V7cmMy8kPifCYLzy53IybZC/67MsJO3X3nuLGocXZpO4C7xL9Z2fpa65sXg/Al
         6Xyvi8JWx9Ml5Myj9DY/ItaJRUrFepMxsmAh+bDewEx2JXKnD7Jj0aAAWsWLCJO2euk7
         Z4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcKYLVt6/NNJuQkZbbwTmTKpZql0R6iO8Dr7nx85OkM=;
        b=pYHjpP4QgBUpq1hwJXhDK20+qoaTszG7GcXUo6MfS3tug0ae6KFAJC+4BnFPZ7gQG/
         neT+tPdYeXoLWZN8CQOPgBkZlJmkpFck/ZtFLnZO/8jL1KDj+JNIp8BpVOFklnXb9VUT
         UPdmjccBlV3Np/oW2FOVQbsy3kJifir+tm8CrLEInWPau156lJJa8Dbp/zsLCuN0boMg
         EKeGppIEsY3Oa7BP7otqSFlual2qTelRAuxycdphGjAP5QVBa/sxe4liZi2QKNdCvwz9
         dDjPyIriokMLJE+mKZTurJ5vFrJ2q3R5bHR8Z8nQeoClcgfm7k/sKIUMBtZ1dAllmNYW
         5bWQ==
X-Gm-Message-State: AGi0PuZGpbtuqhzENM355j1yBhX0oHKSMJ9As8fqwA3PLafCNWyo4QGj
        WlYcr3Sv++wJGjEiF2Tog1hlaA==
X-Google-Smtp-Source: APiQypItvXGM4KItpj88RhB6zhQ84OCvNwUjPostRndJDyIpGjl/afmtOuDKI4u1nGRdx60YieiyGA==
X-Received: by 2002:a05:620a:12dc:: with SMTP id e28mr17201367qkl.38.1588885410496;
        Thu, 07 May 2020 14:03:30 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 14sm5128001qkd.70.2020.05.07.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:03:29 -0700 (PDT)
Date:   Thu, 7 May 2020 17:03:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/19] mm: memcg/slab: obj_cgroup API
Message-ID: <20200507210314.GD161043@cmpxchg.org>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-7-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422204708.2176080-7-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:46:55PM -0700, Roman Gushchin wrote:
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -257,6 +257,78 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> +extern spinlock_t css_set_lock;
> +
> +static void obj_cgroup_release(struct percpu_ref *ref)
> +{
> +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> +	struct mem_cgroup *memcg;
> +	unsigned int nr_bytes;
> +	unsigned int nr_pages;
> +	unsigned long flags;
> +
> +	nr_bytes = atomic_read(&objcg->nr_charged_bytes);
> +	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> +	nr_pages = nr_bytes >> PAGE_SHIFT;

What guarantees that we don't have a partial page in there at this
point? I guess any outstanding allocations would pin the objcg, so
when it's released all objects have been freed.

But if that's true, how can we have full pages remaining in there now?

> @@ -2723,6 +2820,30 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  	return page->mem_cgroup;
>  }
>  
> +__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> +{
> +	struct obj_cgroup *objcg = NULL;
> +	struct mem_cgroup *memcg;
> +
> +	if (unlikely(!current->mm))
> +		return NULL;
> +
> +	rcu_read_lock();
> +	if (unlikely(current->active_memcg))
> +		memcg = rcu_dereference(current->active_memcg);
> +	else
> +		memcg = mem_cgroup_from_task(current);
> +
> +	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +		objcg = rcu_dereference(memcg->objcg);
> +		if (objcg && obj_cgroup_tryget(objcg))
> +			break;
> +	}
> +	rcu_read_unlock();
> +
> +	return objcg;
> +}

Thanks for moving this here from one of the later patches, it helps
understanding the life cycle of obj_cgroup better.

> +int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> +{
> +	struct mem_cgroup *memcg;
> +	unsigned int nr_pages, nr_bytes;
> +	int ret;
> +
> +	if (consume_obj_stock(objcg, size))
> +		return 0;
> +
> +	rcu_read_lock();
> +	memcg = obj_cgroup_memcg(objcg);
> +	css_get(&memcg->css);
> +	rcu_read_unlock();
> +
> +	nr_pages = size >> PAGE_SHIFT;
> +	nr_bytes = size & (PAGE_SIZE - 1);
> +
> +	if (nr_bytes)
> +		nr_pages += 1;
> +
> +	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);

If consume_obj_stock() fails because some other memcg is cached,
should this try to consume the partial page in objcg->nr_charged_bytes
before getting more pages?

> +	if (!ret && nr_bytes)
> +		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);

This will put the cgroup into the cache if the allocation resulted in
a partially free page.

But if this was a page allocation, we may have objcg->nr_cache_bytes
from a previous subpage allocation that we should probably put back
into the stock.

It's not a common case, I'm just trying to understand what
objcg->nr_cache_bytes holds and when it does so.

The rest of this patch looks good to me!

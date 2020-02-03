Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A93C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF32086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="AW5WD4X/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBCTcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:32:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35431 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:32:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id n17so11242529qtv.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0oiDcepj7ENq4i9AK7zud+zarETpPiKWcPxOnQfGJds=;
        b=AW5WD4X/olpAm5jVHiG0daJBfQSr7VOP2KQIJT4QR9uXoT1Sr8twaxvdQB/ouVfpMn
         lZ5SQFeBXYKgs7WA7Euwz1flwKSnZTYZOIA1WpCcRsnooYEd9nzv3tKjFKPJ93idKxKw
         vNqq8qjU5Orf7OGFQRu+/Y8qNf88QUQQ7ri0uH3dydqXGb3JC19x+DLaWqX30thcn/X4
         4M9YkFg086iOHlGMyp3BWqho+edsWu5eOCUeJ6x+xoDmojMbGE1XnTkGZYZJvcqiD/fz
         VUUi77rXZt0MZUmqcKgEYBKeRPQs5vck+VeK8BRBQ7R1Rn7MFgaQ1ZLh0Q0bF1EozlYm
         zWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0oiDcepj7ENq4i9AK7zud+zarETpPiKWcPxOnQfGJds=;
        b=Z/IhO55Xej0BVK9BEpoTH9Kfzjmmy1A9DgjLtHos6/JJqNRRbUA3FOGlKdCPYO4Ei8
         h507gaNywOnjA6VFL7ojZDdTz34T9DL0k4W4HyGfNBPGSqoXIvD8UkceYy+BMeAUTmWV
         Tk6ggsBXHVRArkFKyW1t4ELy5+s4TI8MXSlEfc5RFPuL5VCboJ5hqr1OFn/7n/V58Il0
         n0rbnHAV8a6uF2egKribXgHg1+6O0jBafIdeqRHtdtPmzXmWjDtgiXKYn57tIAiDtuML
         pigVVASeaIu+Ck+6XhqhyfgRsqiqehsCHZYxIjFdOZe7KXYQ2xbYuTeYmzwDd952Obzd
         edzQ==
X-Gm-Message-State: APjAAAUhmjmju4X6ebdGLVIIoOEtuXSsDgnYcP92p7UzAyWduYiKFZCH
        XyAeshrnCCPcsIAGSX5SfLMkaA==
X-Google-Smtp-Source: APXvYqwwjkOwERUQKWdbJ+BMrbsLAvau6+DVOXKn2agn7AXOx/ermcUffgAz4LbC0jjJEI0aVQ3SWA==
X-Received: by 2002:ac8:1835:: with SMTP id q50mr23903551qtj.210.1580758319810;
        Mon, 03 Feb 2020 11:31:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::fc2e])
        by smtp.gmail.com with ESMTPSA id t37sm10800117qth.0.2020.02.03.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 11:31:59 -0800 (PST)
Date:   Mon, 3 Feb 2020 14:31:58 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 15/28] mm: memcg/slab: obj_cgroup API
Message-ID: <20200203193158.GH1697@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-16-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-16-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:40AM -0800, Roman Gushchin wrote:
> Obj_cgroup API provides an ability to account sub-page sized kernel
> objects, which potentially outlive the original memory cgroup.
> 
> The top-level API consists of the following functions:
>   bool obj_cgroup_tryget(struct obj_cgroup *objcg);
>   void obj_cgroup_get(struct obj_cgroup *objcg);
>   void obj_cgroup_put(struct obj_cgroup *objcg);
> 
>   int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
>   void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
> 
>   struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg);
> 
> Object cgroup is basically a pointer to a memory cgroup with a per-cpu
> reference counter. It substitutes a memory cgroup in places where
> it's necessary to charge a custom amount of bytes instead of pages.
> 
> All charged memory rounded down to pages is charged to the
> corresponding memory cgroup using __memcg_kmem_charge().
> 
> It implements reparenting: on memcg offlining it's getting reattached
> to the parent memory cgroup. Each online memory cgroup has an
> associated active object cgroup to handle new allocations and the list
> of all attached object cgroups. On offlining of a cgroup this list is
> reparented and for each object cgroup in the list the memcg pointer is
> swapped to the parent memory cgroup. It prevents long-living objects
> from pinning the original memory cgroup in the memory.
> 
> The implementation is based on byte-sized per-cpu stocks. A sub-page
> sized leftover is stored in an atomic field, which is a part of
> obj_cgroup object. So on cgroup offlining the leftover is automatically
> reparented.
> 
> memcg->objcg is rcu protected.
> objcg->memcg is a raw pointer, which is always pointing at a memory
> cgroup, but can be atomically swapped to the parent memory cgroup. So
> the caller must ensure the lifetime of the cgroup, e.g. grab
> rcu_read_lock or css_set_lock.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -194,6 +195,22 @@ struct memcg_cgwb_frn {
>  	struct wb_completion done;	/* tracks in-flight foreign writebacks */
>  };
>  
> +/*
> + * Bucket for arbitrarily byte-sized objects charged to a memory
> + * cgroup. The bucket can be reparented in one piece when the cgroup
> + * is destroyed, without having to round up the individual references
> + * of all live memory objects in the wild.
> + */
> +struct obj_cgroup {
> +	struct percpu_ref refcnt;
> +	struct mem_cgroup *memcg;
> +	atomic_t nr_charged_bytes;
> +	union {
> +		struct list_head list;
> +		struct rcu_head rcu;
> +	};
> +};
> +
>  /*
>   * The memory controller data structure. The memory controller controls both
>   * page cache and RSS per cgroup. We would eventually like to provide
> @@ -306,6 +323,8 @@ struct mem_cgroup {
>  	int kmemcg_id;
>  	enum memcg_kmem_state kmem_state;
>  	struct list_head kmem_caches;
> +	struct obj_cgroup __rcu *objcg;
> +	struct list_head objcg_list;

These could use a comment, IMO.

	/*
	 * Active object acounting bucket, as well as
	 * reparented buckets from dead children with
	 * outstanding objects.
	 */

or something like that.

> @@ -257,6 +257,73 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> +extern spinlock_t css_set_lock;
> +
> +static void obj_cgroup_release(struct percpu_ref *ref)
> +{
> +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> +	unsigned int nr_bytes;
> +	unsigned int nr_pages;
> +	unsigned long flags;
> +
> +	nr_bytes = atomic_read(&objcg->nr_charged_bytes);
> +	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> +	nr_pages = nr_bytes >> PAGE_SHIFT;
> +
> +	if (nr_pages) {
> +		rcu_read_lock();
> +		__memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
> +		rcu_read_unlock();
> +	}
> +
> +	spin_lock_irqsave(&css_set_lock, flags);
> +	list_del(&objcg->list);
> +	mem_cgroup_put(obj_cgroup_memcg(objcg));
> +	spin_unlock_irqrestore(&css_set_lock, flags);

Heh, two obj_cgroup_memcg() lookups with different synchronization
rules.

I know that reparenting could happen in between the page uncharge and
the mem_cgroup_put(), and it would still be safe because the counters
are migrated atomically. But it seems needlessly lockless and complex.

Since you have to css_set_lock anyway, wouldn't it be better to do

	spin_lock_irqsave(&css_set_lock, flags);
	memcg = obj_cgroup_memcg(objcg);
	if (nr_pages)
		__memcg_kmem_uncharge(memcg, nr_pages);
	list_del(&objcg->list);
	mem_cgroup_put(memcg);
	spin_unlock_irqrestore(&css_set_lock, flags);

instead?

> +	percpu_ref_exit(ref);
> +	kfree_rcu(objcg, rcu);
> +}
> +
> +static struct obj_cgroup *obj_cgroup_alloc(void)
> +{
> +	struct obj_cgroup *objcg;
> +	int ret;
> +
> +	objcg = kzalloc(sizeof(struct obj_cgroup), GFP_KERNEL);
> +	if (!objcg)
> +		return NULL;
> +
> +	ret = percpu_ref_init(&objcg->refcnt, obj_cgroup_release, 0,
> +			      GFP_KERNEL);
> +	if (ret) {
> +		kfree(objcg);
> +		return NULL;
> +	}
> +	INIT_LIST_HEAD(&objcg->list);
> +	return objcg;
> +}
> +
> +static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> +				  struct mem_cgroup *parent)
> +{
> +	struct obj_cgroup *objcg;
> +
> +	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);

Can this actually race with new charges? By the time we are going
offline, where would they be coming from?

What happens if the charger sees a live memcg, but its memcg->objcg is
cleared? Shouldn't they have the same kind of lifetime, where as long
as the memcg can be charged, so can the objcg? What would happen if
you didn't clear memcg->objcg here?

> +	/* Paired with mem_cgroup_put() in objcg_release(). */
> +	css_get(&memcg->css);
> +	percpu_ref_kill(&objcg->refcnt);
> +
> +	spin_lock_irq(&css_set_lock);
> +	list_for_each_entry(objcg, &memcg->objcg_list, list) {
> +		css_get(&parent->css);
> +		xchg(&objcg->memcg, parent);
> +		css_put(&memcg->css);
> +	}

I'm having a pretty hard time following this refcounting.

Why does objcg only acquire a css reference on the way out? It should
hold one when objcg->memcg is set up, and put it when that pointer
goes away.

But also, objcg is already on its own memcg->objcg_list from the
start, so on the first reparenting we get a css ref, then move it to
the parent, then obj_cgroup_release() puts one it doesn't have ...?

Argh, help.

> @@ -2978,6 +3070,120 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	if (PageKmemcg(page))
>  		__ClearPageKmemcg(page);
>  }
> +
> +static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> +{
> +	struct memcg_stock_pcp *stock;
> +	unsigned long flags;
> +	bool ret = false;
> +
> +	local_irq_save(flags);
> +
> +	stock = this_cpu_ptr(&memcg_stock);
> +	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
> +		stock->nr_bytes -= nr_bytes;
> +		ret = true;
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
> +static void drain_obj_stock(struct memcg_stock_pcp *stock)
> +{
> +	struct obj_cgroup *old = stock->cached_objcg;
> +
> +	if (!old)
> +		return;
> +
> +	if (stock->nr_bytes) {
> +		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> +		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
> +
> +		if (nr_pages) {
> +			rcu_read_lock();
> +			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
> +			rcu_read_unlock();
> +		}
> +
> +		atomic_add(nr_bytes, &old->nr_charged_bytes);
> +		stock->nr_bytes = 0;
> +	}
> +
> +	obj_cgroup_put(old);
> +	stock->cached_objcg = NULL;
> +}
> +
> +static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
> +				     struct mem_cgroup *root_memcg)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (stock->cached_objcg) {
> +		memcg = obj_cgroup_memcg(stock->cached_objcg);
> +		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> +{
> +	struct memcg_stock_pcp *stock;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	stock = this_cpu_ptr(&memcg_stock);
> +	if (stock->cached_objcg != objcg) { /* reset if necessary */
> +		drain_obj_stock(stock);
> +		obj_cgroup_get(objcg);
> +		stock->cached_objcg = objcg;
> +		stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
> +	}
> +	stock->nr_bytes += nr_bytes;
> +
> +	if (stock->nr_bytes > PAGE_SIZE)
> +		drain_obj_stock(stock);
> +
> +	local_irq_restore(flags);
> +}
> +
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

I don't quite understand the lifetime rules here. You're holding the
rcu lock, so the memcg object cannot get physically freed while you
are looking it up. But you could be racing with an offlining and see
the stale memcg pointer. Isn't css_get() unsafe? Doesn't this need a
retry loop around css_tryget() similar to get_mem_cgroup_from_mm()?

> +
> +	nr_pages = size >> PAGE_SHIFT;
> +	nr_bytes = size & (PAGE_SIZE - 1);
> +
> +	if (nr_bytes)
> +		nr_pages += 1;
> +
> +	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> +	if (!ret && nr_bytes)
> +		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
> +
> +	css_put(&memcg->css);
> +	return ret;
> +}
> +
> +void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
> +{
> +	refill_obj_stock(objcg, size);
> +}
> +
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -3400,7 +3606,8 @@ static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> -	int memcg_id;
> +	struct obj_cgroup *objcg;
> +	int memcg_id, ret;
>  
>  	if (cgroup_memory_nokmem)
>  		return 0;
> @@ -3412,6 +3619,15 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>  	if (memcg_id < 0)
>  		return memcg_id;
>  
> +	objcg = obj_cgroup_alloc();
> +	if (!objcg) {
> +		memcg_free_cache_id(memcg_id);
> +		return ret;
> +	}
> +	objcg->memcg = memcg;
> +	rcu_assign_pointer(memcg->objcg, objcg);
> +	list_add(&objcg->list, &memcg->objcg_list);

This self-hosting significantly adds to my confusion. It'd be a lot
easier to understand ownership rules and references if this list_add()
was done directly to the parent's list at the time of reparenting, not
here.

If the objcg holds a css reference, right here is where it should be
acquired. Then transferred in reparent and put during release.

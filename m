Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B93C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3030206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgIGPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:48:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730208AbgIGPnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:43:39 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 74F9B4109E8431945181;
        Mon,  7 Sep 2020 16:43:24 +0100 (IST)
Received: from localhost (10.52.124.38) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 7 Sep 2020
 16:43:23 +0100
Date:   Mon, 7 Sep 2020 16:41:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marco Elver <elver@google.com>
CC:     <glider@google.com>, <akpm@linux-foundation.org>,
        <catalin.marinas@arm.com>, <cl@linux.com>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <mark.rutland@arm.com>,
        <penberg@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <andreyknvl@google.com>, <aryabinin@virtuozzo.com>,
        <luto@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <dvyukov@google.com>, <edumazet@google.com>,
        <gregkh@linuxfoundation.org>, <mingo@redhat.com>,
        <jannh@google.com>, <corbet@lwn.net>, <keescook@chromium.org>,
        <peterz@infradead.org>, <cai@lca.pw>, <tglx@linutronix.de>,
        <will@kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
Message-ID: <20200907164148.00007899@Huawei.com>
In-Reply-To: <20200907134055.2878499-2-elver@google.com>
References: <20200907134055.2878499-1-elver@google.com>
        <20200907134055.2878499-2-elver@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.38]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 15:40:46 +0200
Marco Elver <elver@google.com> wrote:

> From: Alexander Potapenko <glider@google.com>
> 
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.
> 
> KFENCE is designed to be enabled in production kernels, and has near
> zero performance overhead. Compared to KASAN, KFENCE trades performance
> for precision. The main motivation behind KFENCE's design, is that with
> enough total uptime KFENCE will detect bugs in code paths not typically
> exercised by non-production test workloads. One way to quickly achieve a
> large enough total uptime is when the tool is deployed across a large
> fleet of machines.
> 
> KFENCE objects each reside on a dedicated page, at either the left or
> right page boundaries. The pages to the left and right of the object
> page are "guard pages", whose attributes are changed to a protected
> state, and cause page faults on any attempted access to them. Such page
> faults are then intercepted by KFENCE, which handles the fault
> gracefully by reporting a memory access error.
> 
> Guarded allocations are set up based on a sample interval (can be set
> via kfence.sample_interval). After expiration of the sample interval, a
> guarded allocation from the KFENCE object pool is returned to the main
> allocator (SLAB or SLUB). At this point, the timer is reset, and the
> next allocation is set up after the expiration of the interval.
> 
> To enable/disable a KFENCE allocation through the main allocator's
> fast-path without overhead, KFENCE relies on static branches via the
> static keys infrastructure. The static branch is toggled to redirect the
> allocation to KFENCE. To date, we have verified by running synthetic
> benchmarks (sysbench I/O workloads) that a kernel compiled with KFENCE
> is performance-neutral compared to the non-KFENCE baseline.
> 
> For more details, see Documentation/dev-tools/kfence.rst (added later in
> the series).
> 
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Interesting bit of work. A few trivial things inline I spotted whilst having
a first read through.

Thanks,

Jonathan

> +
> +static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
> +{
> +	/*
> +	 * Note: for allocations made before RNG initialization, will always
> +	 * return zero. We still benefit from enabling KFENCE as early as
> +	 * possible, even when the RNG is not yet available, as this will allow
> +	 * KFENCE to detect bugs due to earlier allocations. The only downside
> +	 * is that the out-of-bounds accesses detected are deterministic for
> +	 * such allocations.
> +	 */
> +	const bool right = prandom_u32_max(2);
> +	unsigned long flags;
> +	struct kfence_metadata *meta = NULL;
> +	void *addr = NULL;

I think this is set in all paths, so no need to initialize here.

> +
> +	/* Try to obtain a free object. */
> +	raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
> +	if (!list_empty(&kfence_freelist)) {
> +		meta = list_entry(kfence_freelist.next, struct kfence_metadata, list);
> +		list_del_init(&meta->list);
> +	}
> +	raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> +	if (!meta)
> +		return NULL;
> +
> +	if (unlikely(!raw_spin_trylock_irqsave(&meta->lock, flags))) {
> +		/*
> +		 * This is extremely unlikely -- we are reporting on a
> +		 * use-after-free, which locked meta->lock, and the reporting
> +		 * code via printk calls kmalloc() which ends up in
> +		 * kfence_alloc() and tries to grab the same object that we're
> +		 * reporting on. While it has never been observed, lockdep does
> +		 * report that there is a possibility of deadlock. Fix it by
> +		 * using trylock and bailing out gracefully.
> +		 */
> +		raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
> +		/* Put the object back on the freelist. */
> +		list_add_tail(&meta->list, &kfence_freelist);
> +		raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> +
> +		return NULL;
> +	}
> +
> +	meta->addr = metadata_to_pageaddr(meta);
> +	/* Unprotect if we're reusing this page. */
> +	if (meta->state == KFENCE_OBJECT_FREED)
> +		kfence_unprotect(meta->addr);
> +
> +	/* Calculate address for this allocation. */
> +	if (right)
> +		meta->addr += PAGE_SIZE - size;
> +	meta->addr = ALIGN_DOWN(meta->addr, cache->align);
> +
> +	/* Update remaining metadata. */
> +	metadata_update_state(meta, KFENCE_OBJECT_ALLOCATED);
> +	/* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
> +	WRITE_ONCE(meta->cache, cache);
> +	meta->size = right ? -size : size;
> +	for_each_canary(meta, set_canary_byte);
> +	virt_to_page(meta->addr)->slab_cache = cache;
> +
> +	raw_spin_unlock_irqrestore(&meta->lock, flags);
> +
> +	/* Memory initialization. */
> +
> +	/*
> +	 * We check slab_want_init_on_alloc() ourselves, rather than letting
> +	 * SL*B do the initialization, as otherwise we might overwrite KFENCE's
> +	 * redzone.
> +	 */
> +	addr = (void *)meta->addr;
> +	if (unlikely(slab_want_init_on_alloc(gfp, cache)))
> +		memzero_explicit(addr, size);
> +	if (cache->ctor)
> +		cache->ctor(addr);
> +
> +	if (CONFIG_KFENCE_FAULT_INJECTION && !prandom_u32_max(CONFIG_KFENCE_FAULT_INJECTION))
> +		kfence_protect(meta->addr); /* Random "faults" by protecting the object. */
> +
> +	atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCATED]);
> +	atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCS]);
> +
> +	return addr;
> +}

...

> +
> +size_t kfence_ksize(const void *addr)
> +{
> +	const struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +
> +	/*
> +	 * Read locklessly -- if there is a race with __kfence_alloc(), this
> +	 * most certainly is either a use-after-free, or invalid access.
> +	 */
> +	return meta ? abs(meta->size) : 0;
> +}
> +
> +void *kfence_object_start(const void *addr)
> +{
> +	const struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +
> +	/*
> +	 * Read locklessly -- if there is a race with __kfence_alloc(), this
> +	 * most certainly is either a use-after-free, or invalid access.

To my reading using "most certainly" makes this statement less clear

Read locklessly -- if there is a race with __kfence_alloc() this
is either a use-after-free or invalid access.

Same for other cases of that particular "most certainly".

> +	 */
> +	return meta ? (void *)meta->addr : NULL;
> +}
> +
> +void __kfence_free(void *addr)
> +{
> +	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +
> +	if (unlikely(meta->cache->flags & SLAB_TYPESAFE_BY_RCU))
> +		call_rcu(&meta->rcu_head, rcu_guarded_free);
> +	else
> +		kfence_guarded_free(addr, meta);
> +}
> +
> +bool kfence_handle_page_fault(unsigned long addr)
> +{
> +	const int page_index = (addr - (unsigned long)__kfence_pool) / PAGE_SIZE;
> +	struct kfence_metadata *to_report = NULL;
> +	enum kfence_error_type error_type;
> +	unsigned long flags;
> +
> +	if (!is_kfence_address((void *)addr))
> +		return false;
> +
> +	if (!READ_ONCE(kfence_enabled)) /* If disabled at runtime ... */
> +		return kfence_unprotect(addr); /* ... unprotect and proceed. */
> +
> +	atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
> +
> +	if (page_index % 2) {
> +		/* This is a redzone, report a buffer overflow. */
> +		struct kfence_metadata *meta = NULL;

Not need to set to NULL here as assigned 3 lines down.

> +		int distance = 0;
> +
> +		meta = addr_to_metadata(addr - PAGE_SIZE)

> +		if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
> +			to_report = meta;
> +			/* Data race ok; distance calculation approximate. */
> +			distance = addr - data_race(meta->addr + abs(meta->size));
> +		}
> +
> +		meta = addr_to_metadata(addr + PAGE_SIZE);
> +		if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
> +			/* Data race ok; distance calculation approximate. */
> +			if (!to_report || distance > data_race(meta->addr) - addr)
> +				to_report = meta;
> +		}
> +
> +		if (!to_report)
> +			goto out;
> +
> +		raw_spin_lock_irqsave(&to_report->lock, flags);
> +		to_report->unprotected_page = addr;
> +		error_type = KFENCE_ERROR_OOB;
> +
> +		/*
> +		 * If the object was freed before we took the look we can still
> +		 * report this as an OOB -- the report will simply show the
> +		 * stacktrace of the free as well.
> +		 */
> +	} else {
> +		to_report = addr_to_metadata(addr);
> +		if (!to_report)
> +			goto out;
> +
> +		raw_spin_lock_irqsave(&to_report->lock, flags);
> +		error_type = KFENCE_ERROR_UAF;
> +		/*
> +		 * We may race with __kfence_alloc(), and it is possible that a
> +		 * freed object may be reallocated. We simply report this as a
> +		 * use-after-free, with the stack trace showing the place where
> +		 * the object was re-allocated.
> +		 */
> +	}
> +
> +out:
> +	if (to_report) {
> +		kfence_report_error(addr, to_report, error_type);
> +		raw_spin_unlock_irqrestore(&to_report->lock, flags);
> +	} else {
> +		/* This may be a UAF or OOB access, but we can't be sure. */
> +		kfence_report_error(addr, NULL, KFENCE_ERROR_INVALID);
> +	}
> +
> +	return kfence_unprotect(addr); /* Unprotect and let access proceed. */
> +}
...


Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F023C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EE420753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Fo9KNuvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgELW5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELW5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:57:05 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4384C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:57:05 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v15so3129494qvr.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uw6rcMifPeMm4u4SGK3ZasDqkkdkPJx5dwRBOhb9iZ0=;
        b=Fo9KNuvX7TEGQgNrP52TRDep9vxdmN6lPqGfnpBGIBh9wjAB8AKtPP/Vqb7ViMW3Di
         xeZMTfN09TVP/s7ZQCmIHH6jhRiLYTAVIXIXOKudV3tl//5uF0X1/kzjgfSM0Oj4ULck
         l9NVd3YzTKjAgXRt1YRh1wvOsXex1hNf1OeCa15HKUtQo0QJ1FzMZDMAoeG3lnguurKt
         0JWFTTsPu0tf03pF6ik2qK3NFsWA5Jd1mhl1QDdfSF2jSgYTBz4rzbkZ+kU8mbOSG5kh
         QZvtN4Ycns0x0bwu3qCEvWkT/drJsG/nWpo8qETwaKR0X3pbeDhn9MS07P7Sp57k0GJK
         6zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uw6rcMifPeMm4u4SGK3ZasDqkkdkPJx5dwRBOhb9iZ0=;
        b=bRh4PyquBOl8AwcQ6mWOjqZbgG3d92NcU3/GiozILvwbKqnzoJxvlxwZHA83qXP3bv
         PplJQbTJtcStm7WvAjdW9zZC2m+zeld50r13BYXfKJyL3YXkhNbk9wQ2IvLWB9z3rNpw
         3hU/DzYarLPVmc5FlYdNSt8T89wXdFyoiyydM/ag5BBuhvY7+7xC2McdE47dEFtznOzv
         mNK9ri8wxe8Dx0ZD4pVyO8AjyTZ0PHp0NZdyZ8nkCSgBX/JBjQkvJMmgdSy4lc3i5DgV
         ZMOIEv5z2ojLgq6mFFWkAfvyIl5k8jxS9Kb897NP53zlh3yldADo3arYDR0eF4VbeZMJ
         KsiQ==
X-Gm-Message-State: AGi0PuYNiXVROfC859oMVIZ5UI3mLpaCb+nYJQI9+3IdAZZjwN5CE8Q9
        i+BMjtdU23yzUdYzrqqxapj9Cw==
X-Google-Smtp-Source: APiQypIVWK4DOItsAwZSF++TtWpZGg68EDxJaQnUCromDwnEvmQDQRxuDhdiWxCkFJmry65ErRlOuQ==
X-Received: by 2002:ad4:4d44:: with SMTP id m4mr18915485qvm.236.1589324224935;
        Tue, 12 May 2020 15:57:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id h185sm12160202qkc.19.2020.05.12.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:57:04 -0700 (PDT)
Date:   Tue, 12 May 2020 18:56:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/19] mm: memcg/slab: obj_cgroup API
Message-ID: <20200512225645.GA488426@cmpxchg.org>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-7-guro@fb.com>
 <20200507210314.GD161043@cmpxchg.org>
 <20200507222631.GA81857@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507222631.GA81857@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 03:26:31PM -0700, Roman Gushchin wrote:
> On Thu, May 07, 2020 at 05:03:14PM -0400, Johannes Weiner wrote:
> > On Wed, Apr 22, 2020 at 01:46:55PM -0700, Roman Gushchin wrote:
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -257,6 +257,78 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
> > >  }
> > >  
> > >  #ifdef CONFIG_MEMCG_KMEM
> > > +extern spinlock_t css_set_lock;
> > > +
> > > +static void obj_cgroup_release(struct percpu_ref *ref)
> > > +{
> > > +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> > > +	struct mem_cgroup *memcg;
> > > +	unsigned int nr_bytes;
> > > +	unsigned int nr_pages;
> > > +	unsigned long flags;
> > > +
> > > +	nr_bytes = atomic_read(&objcg->nr_charged_bytes);
> > > +	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> > > +	nr_pages = nr_bytes >> PAGE_SHIFT;
> > 
> > What guarantees that we don't have a partial page in there at this
> > point? I guess any outstanding allocations would pin the objcg, so
> > when it's released all objects have been freed.
> 
> Right, this is exactly the reason why there can't be a partial page
> at this point.
> 
> > 
> > But if that's true, how can we have full pages remaining in there now?
> 
> Imagine the following sequence:
> 1) CPU0: objcg == stock->cached_objcg
> 2) CPU1: we do a small allocation (e.g. 92 bytes), page is charged
> 3) CPU1: a process from another memcg is allocating something, stock if flushed,
>    objcg->nr_charged_bytes = PAGE_SIZE - 92
> 5) CPU0: we do release this object, 92 bytes are added to stock->nr_bytes
> 6) CPU0: stock is flushed, 92 bytes are added to objcg->nr_charged_bytes
> 
> In the result, nr_charged_bytes == PAGE_SIZE. This PAGE will be uncharged
> in obj_cgroup_release().
> 
> I've double checked this, it's actually pretty easy to trigger in the real life.

Ah, so no outstanding allocations, but a full page split between the
percpu cache and objcg->nr_charged_bytes.

Would it simplify things if refill_obj_stock() drained on >= PAGE_SIZE
stock instead of > PAGE_SIZE?

Otherwise, the scenario above would be good to have as a comment as
the drain on release is not self-explanatory.

> > > +int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> > > +{
> > > +	struct mem_cgroup *memcg;
> > > +	unsigned int nr_pages, nr_bytes;
> > > +	int ret;
> > > +
> > > +	if (consume_obj_stock(objcg, size))
> > > +		return 0;
> > > +
> > > +	rcu_read_lock();
> > > +	memcg = obj_cgroup_memcg(objcg);
> > > +	css_get(&memcg->css);
> > > +	rcu_read_unlock();
> > > +
> > > +	nr_pages = size >> PAGE_SHIFT;
> > > +	nr_bytes = size & (PAGE_SIZE - 1);
> > > +
> > > +	if (nr_bytes)
> > > +		nr_pages += 1;
> > > +
> > > +	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> > 
> > If consume_obj_stock() fails because some other memcg is cached,
> > should this try to consume the partial page in objcg->nr_charged_bytes
> > before getting more pages?
> 
> We can definitely do it, but I'm not sure if it's good for the performance.
> 
> Dealing with nr_charged_bytes will require up to two atomic writes,
> so calling __memcg_kmem_charge() can be faster if memcg is cached
> on percpu stock.

Hm, but it's the slowpath. And sooner or later somebody has to deal
with the remaining memory in there.

> > > +	if (!ret && nr_bytes)
> > > +		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
> > 
> > This will put the cgroup into the cache if the allocation resulted in
> > a partially free page.
> > 
> > But if this was a page allocation, we may have objcg->nr_cache_bytes
> > from a previous subpage allocation that we should probably put back
> > into the stock.
> 
> Yeah, we can do this, but I don't know if there will be any benefits.

It's mostly about understanding the code.

> Actually we don't wanna to touch objcg->nr_cache_bytes too often, as
> it can become a contention point if there are many threads allocating
> in the memory cgroup.
> 
> So maybe we want to do the opposite: relax it a bit and stop flushing
> it on every stock refill and flush only if it exceeds a certain value.

That could be useful, yes.

> > It's not a common case, I'm just trying to understand what
> > objcg->nr_cache_bytes holds and when it does so.
> 
> So it's actually a centralized leftover from the rounding of the actual
> charge to the page size.

It would be good to add code comments explaining this.

Thanks!

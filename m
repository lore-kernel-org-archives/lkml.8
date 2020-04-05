Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF67FC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 23:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760AB20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 23:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MuV/D3/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgDEXac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 19:30:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38687 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgDEXac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 19:30:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so14482492qke.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RdhzDJg5iRfSS3hO6TyJKwEvq9hTC6c8q8XumCdLai4=;
        b=MuV/D3/Aja/ikbJ6Q8Qn4+IPqibWLtNUmt2Db6BV0tPuX5qhNwA5u9aewRnMO+AwGz
         Glil/K/QqMVpNwghfULgX6IG6m4gRD7Phn6oZBEV7CZhIB0VlgE+3SitKw/5UdF9ZxCF
         rMtA4S/ooAsGEb6F9kwp2Ynj2JzoGNSJCjico=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdhzDJg5iRfSS3hO6TyJKwEvq9hTC6c8q8XumCdLai4=;
        b=scmI+1vJFVDadyI2U6XJV0104HRaQdOqhtNgCwiYDxBSfusWNUHPvGXyu8K+Ru4QcY
         Q3vKK79+OKU6X4qjJmgpkEjF2tfdXPludeufYq+F2u/NIZ8Ee40UncgUIrZD6tu6wMcv
         4/Ta6MfjhmiqPkrwhHvAKP/gOnyJFCj0UhMR9DX+do0zk1cbW5as11rX1B+1u+SxDCu0
         GtA58x36RTPHW6s7/saMn9PCI73ZdV2aCBN0aKYDu3Cl6SuV/9Ryj03CpQ774e4cCeu6
         CEaqElaA2f99zUXqdVBWzgjPijJ8K+QzadD0R7VajCuzZIdxTH5R+IXyBlsptIWumai8
         ngFw==
X-Gm-Message-State: AGi0PuYRaL8uMEfXT5md+M3oJcqxDe6KlqE5n1CcH4/PPl1sT+jryFKC
        BxmM3sjJ6fCec07TscE9tNO4VA==
X-Google-Smtp-Source: APiQypJ54/PUV/a8KS1q28f3jf3snxJZAE6J37JNA4d1J76AOnNTxg7hJ0zLRa6D4aX2T5PRxlYxlQ==
X-Received: by 2002:a05:620a:4e:: with SMTP id t14mr2770534qkt.196.1586129430013;
        Sun, 05 Apr 2020 16:30:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x89sm13493576qtd.43.2020.04.05.16.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 16:30:29 -0700 (PDT)
Date:   Sun, 5 Apr 2020 19:30:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200405233028.GC83565@google.com>
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200404195129.GA83565@google.com>
 <20200405172105.GA7539@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405172105.GA7539@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,

On Sun, Apr 05, 2020 at 07:21:05PM +0200, Uladzislau Rezki wrote:
> On Sat, Apr 04, 2020 at 03:51:29PM -0400, Joel Fernandes wrote:
> > On Fri, Apr 03, 2020 at 07:30:51PM +0200, Uladzislau Rezki (Sony) wrote:
> > > Maintain an emergency pool for each CPU with some
> > > extra objects. There is read-only sysfs attribute,
> > > the name is "rcu_nr_emergency_objs". It reflects
> > > the size of the pool. As for now the default value
> > > is 3.
> > > 
> > > The pool is populated when low memory condition is
> > > detected. Please note it is only for headless case
> > > it means when the regular SLAB is not able to serve
> > > any request, the pool is used.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > Hi Vlad,
> > 
> > One concern I have is this moves the problem a bit further down. My belief is
> > we should avoid the likelihood of even needing an rcu_head allocated for the
> > headless case, to begin with - than trying to do damage-control when it does
> > happen. The only way we would end up needing an rcu_head is if we could not
> > allocate an array.
> > 
> Let me share my view on all such caching. I think that now it becomes less as
> the issue, because of we have now https://lkml.org/lkml/2020/4/2/383 patch.
> I see that it does help a lot. I tried to simulate low memory condition and 
> apply high memory pressure with that. I did not manage to trigger the
> "synchronize rcu" path at all. It is because of using much more permissive
> parameters when we request a memory from the SLAB(direct reclaim, etc...).

That's a good sign that we don't hit this path in your tests.

I guess also, with your latest patch on releasing the lock to be in a
non-atomic context, and then doing the allocation, it became even more
permissive? If you drop that patch and tried, do you still not hit the
synchronous path more often?

Could you also try introducing memory pressure by reducing your system's
total memory and see how it behaves?

> > So instead of adding a pool for rcu_head allocations, how do you feel about
> > pre-allocation of the per-cpu cache array instead, which has the same effect
> > as you are intending?
> > 
> In the v2 i have a list of such objects. It is also per-CPU(it is scaled to CPUs),
> but the difference is, those objects require much less memory, it is 8 + sizeof(struct
> rcu_head) bytes comparing to one page. Therefore the memory footprint is lower.

Yes, true. That is one drawback is it higher memory usage. But if you have at
least 1 kfree_rcu() request an each CPU, then pre-allocation does not
increase memory usage any more than it already has right now. Unless, we
extend my proposal to cache more than 2 pages per-cpu which I think you
mentioned below.

> I have doubts that we would ever hit this emergency list, because of mentioned
> above patch, but from the other hand i can not say and guarantee 100%. Just in
> case, we may keep it. 

You really have to hit OOM in your tests to trigger it I suppose. Basically
the emergency pool improves situation under OOM, but otherwise does not
improve it due to the direct-reclaim that happens as you mentioned. Right?

> Paul, could you please share your view and opinion? It would be appreciated :)
> 
> > This has 3 benefits:
> > 1. It scales with number of CPUs, no configuration needed.
> > 2. It makes the first kfree_rcu() faster and less dependent on an allocation
> >    succeeding.
> > 3. Much simpler code, no new structures or special handling.
> > 4. In the future we can extend it to allocate more than 2 pages per CPU using
> >    the same caching mechanism.
> > 
> > The obvious drawback being its 2 pages per CPU but at least it scales by
> > number of CPUs. Something like the following (just lightly tested):
> > 
> > ---8<-----------------------
> > 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH] rcu/tree: Preallocate the per-cpu cache for kfree_rcu()
> > 
> > In recent changes, we have made it possible to use kfree_rcu() without
> > embedding an rcu_head in the object being free'd. This requires dynamic
> > allocation. In case dynamic allocation fails due to memory pressure, we
> > would end up synchronously waiting for an RCU grace period thus hurting
> > kfree_rcu() latency.
> > 
> > To make this less probable, let us pre-allocate the per-cpu cache so we
> > depend less on the dynamic allocation succeeding. This also has the
> > effect of making kfree_rcu() slightly faster at run time.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 6172e6296dd7d..9fbdeb4048425 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4251,6 +4251,11 @@ static void __init kfree_rcu_batch_init(void)
> >  			krcp->krw_arr[i].krcp = krcp;
> >  		}
> >  
> > +		krcp->bkvcache[0] =  (struct kvfree_rcu_bulk_data *)
> > +					__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > +		krcp->bkvcache[1] =  (struct kvfree_rcu_bulk_data *)
> > +					__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > +
> >  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> >  		krcp->initialized = true;
> >  	}
> We pre-allocate it, but differently comparing with your proposal :) I do not see
> how it can improve things. The difference is you do it during initializing or booting  
> phase. In case of current code it will pre-allocate and cache one page after first
> calling of the kvfree_call_rcu(), say in one second. So basically both variants are
> the same.

Well, one proposal is only 5 lines extra ;-). That has got to be at least a
bit appealing ;-) ;-).

> But i think that we should allow to be used two pages as cached ones, no matter 
> whether it is vmalloc ptrs. or SLAB ones. So basically, two cached pages can be
> used by vmalloc path and SLAB path. And probably it makes sense because of two
> phases: one is when we collect pointers, second one is memory reclaim path. Thus
> one page per one phase, i.e. it would be paired.

You are saying this with regard to my proposal right?  I agree number of
pages could be increased. The caching mechanism already in-place could be
starting point for that extension.

Thanks, Vlad!

 - Joel

> Thanks, Joel!
> 
> --
> Vlad Rezki

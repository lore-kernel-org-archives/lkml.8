Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EAAC2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0442B2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586244286;
	bh=EqY31fKJP9OMRl2fgXHFpMNxoO5yHyte1+SnI61Ut2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uo5OwjrtnW0R/RFz2kHDCwiHkkCoa/5eGTLdFmHjWlwc1Z0Wltp21VKQd8+84mB8v
	 NPuXzfXscCyshXN/aDT5euGcRdKU/oCZX+X+HvkimYiO8QqggK5n5jOIK+QIjt9GpK
	 Z5lfvUx+N2qHouEfTozzLEjirSqB3RzYTwlP6gc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgDGHYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:24:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44233 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDGHYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:24:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so2568501wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 00:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6FnIuOZPi/ruTZydug6G1Y7/h7rJsp6Y+RjBmISzyY=;
        b=hbRKeFevB0/QvXWxcrfP39sTcHKYRCDHXDFsbkEFjImvLwkJ3+byN7FJk7r1orVZaU
         NxXuvskWK0Se9HThUHu7YATdFkIXLkABSBmJ6slAc/35/TF8o6rLM6LOMNAmVQ2gFOe5
         Qnr+xEPM/cdaEl/Ftf6B//mRpjsoA3Ev7iUOkiK9Yu8A0oLQoRzF11nCHb1hVd+tkOYO
         yQDjdATKhv9Gi4waxGSCkCYSyzFkwYt/Jd1S3JBKpL4ndC7HxedNrpDg5qXjnsSj545n
         rozZyqt3YULEmacoHqgyMwIy1nGXcKQ30E9Ps+0AcTYO7WuiEG2gQPBjdf+dYtI87p2m
         tSfA==
X-Gm-Message-State: AGi0PubGNJSyaZfIz2Vu2KVLCJjtwai/0L3tIFJrA1r3cXyvq1wyx25X
        nYP5B1j8tXcU8jw+n3zGrc8=
X-Google-Smtp-Source: APiQypKfOL4a/WUufFiUv2U4j0JDcB1NNo6X9GIZA69ARU1CAw7jrsKOaFLG0D0a7uyrutia1pxTzA==
X-Received: by 2002:adf:9e8c:: with SMTP id a12mr1120975wrf.273.1586244281615;
        Tue, 07 Apr 2020 00:24:41 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id n64sm1076078wme.45.2020.04.07.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 00:24:40 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:24:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
Message-ID: <20200407072439.GG18914@dhcp22.suse.cz>
References: <20200403083543.11552-1-mhocko@kernel.org>
 <20200403083543.11552-2-mhocko@kernel.org>
 <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
 <87blo8xnz2.fsf@notabene.neil.brown.name>
 <20200406070137.GC19426@dhcp22.suse.cz>
 <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
 <875zecw1n6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zecw1n6.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-04-20 11:00:29, Neil Brown wrote:
> On Mon, Apr 06 2020, John Hubbard wrote:
> 
> > On 4/6/20 12:01 AM, Michal Hocko wrote:
[...]
> >> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> >> index e5b817cb86e7..9cacef1a3ee0 100644
> >> --- a/include/linux/gfp.h
> >> +++ b/include/linux/gfp.h
> >> @@ -110,6 +110,11 @@ struct vm_area_struct;
> >>    * the caller guarantees the allocation will allow more memory to be freed
> >>    * very shortly e.g. process exiting or swapping. Users either should
> >>    * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
> >> + * Users of this flag have to be extremely careful to not deplete the reserve
> >> + * completely and implement a throttling mechanism which controls the consumption
> >> + * of the reserve based on the amount of freed memory.
> >> + * Usage of a pre-allocated pool (e.g. mempool) should be always considered before
> >> + * using this flag.
> 
> I think this version is pretty good.

Thanks! I will stick with it then.

[...]

> I think it is hard to write rules because the rules are a bit spongey.

Exactly! And the more specific we are the more likely people are going
to follow literally. And we do not want that. We want people to be aware
of the limitation but want them to think hard before using the flag.

> With mempools, we have a nice clear rule.  When you allocate from a
> mempool you must have a clear path to freeing that allocation which will
> not block on memory allocation except from a subordinate mempool.  This
> implies a partial ordering between mempools.  When you have layered
> block devices the path through the layers from filesystem down to
> hardware defines the order.  It isn't enforced, but it is quite easy to
> reason about.
> 
> GFP_MEMALLOC effectively provides multiple mempools.  So it could
> theoretically deadlock if multiple long dependency chains
> happened. i.e. if 1000 threads each make a GFP_MEMALLOC allocation and
> then need to make another one before the first can be freed - then you
> hit problems.  There is no formal way to guarantee that this doesn't
> happen.  We just say "be gentle" and minimize the users of this flag,
> and keep more memory in reserve than we really need.
> Note that 'threads' here might not be Linux tasks.  If you have an IO
> request that proceed asynchronously, moving from queue to queue and
> being handled by different task, then each one is a "thread" for the
> purpose of understanding mem-alloc dependency.
> 
> So maybe what I really should focus on is not how quickly things happen,
> but how many happen concurrently.  The idea of throttling is to allow
> previous requests to complete before we start too many more.
> 
> With Swap-over-NFS, some of the things that might need to be allocated
> are routing table entries.  These scale with the number of NFS servers
> rather than the number of IO requests, so they are not going to cause
> concurrency problems.
> We also need memory to store replies, but these never exceed the number
> of pending requests, so there is limited concurrency there.
> NFS can send a lot of requests in parallel, but the main limit is the
> RPC "slot table" and while that grows dynamically, it does so with
> GFP_NOFS, so it can block or fail (I wonder if that should explicitly
> disable the use of the reserves).
> 
> So there a limit on concurrency imposed by non-GFP_MEMALLOC allocations

This really makes sense to mention in the allocation manual
(Documentation/core-api/memory-allocation.rst) as suggested by John.
Care to make it into a patch?
-- 
Michal Hocko
SUSE Labs

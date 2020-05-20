Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7155FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9F5207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="BotXs/mL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgETNAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETNAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:00:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B748C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:00:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so2465700wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TpMC+O+XlzL+C0BKEnXPSztb/9dUjzsQPX3tUclIreE=;
        b=BotXs/mLCyzu1sfB0nunwdbZ42kE+iyB6dgUu0l97QF9yf28/SUmZY0atRMQP1Sxwh
         pD3BC/x4MQrtyEcByT1fMjsZmOrIWbNrsvoYpyO4de74aAQu49gZHuVw8S09T+IKuJzW
         SKLUFq1uBbxdLCxh2WA1aJa8T3QnGg/RsOidkhji7FtI0Oeki0NhwSp+KgleVaSByOZX
         Pf3lNmqwCfZ0gkvwuXJFceSuxZ8kCCAyLw/uoBgHTnZCqu7Zc4nB1/d7fc78EP6UoRFJ
         aMkeFkcZPZAlVn9JlcTq6gv6raNVJDfDHTRamrlX362+Y68WZdCzfsjQn0P5aeAp69vs
         m4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TpMC+O+XlzL+C0BKEnXPSztb/9dUjzsQPX3tUclIreE=;
        b=I6Wwz1uNdN1Df92IgjiXofJd7F2+MfkBtajb+jYhBLTgrEuWB5i1r96qQWKs3pnGYM
         aCctTRN3nfiuR0cTvtDRWG/jKH46eD5s8mqKEwwEyZw93AN8YUWVMsl4LNenFfteubaH
         1X/ggGjoozL8Qe8CwRnViHrIZFLLrBbbYBA7IRPKoVnSS/7K6ejnumK734joev6ckkoD
         J/3NHoFksRYi9IPMPhK0ZNn8yafOfACTr+lK4+PQfJ3CaejxzQs5ycavKJ7NzEFt79fm
         8s+M1Owaj+99K7Sz0sonZLfhzlFy7NuPTICnPowURJ71hvhgiqG5oeuBtyaTr6ZjDDMI
         SFiw==
X-Gm-Message-State: AOAM533GqRqmEf4G/lT4ZxurKB9S7j2ILXA2Sc7xGfPwyJdNk7zLQS+d
        0XZHU9mCfIlsINjZ2+u/8j3rLA==
X-Google-Smtp-Source: ABdhPJxwaRqj4h5/8vE/gHjjSWUbR29Z08JjHkWgQdWHPQwt20cq5MJnti2HtUH05/Dq3BtEla2UHQ==
X-Received: by 2002:a05:600c:290d:: with SMTP id i13mr4430861wmd.81.1589979651059;
        Wed, 20 May 2020 06:00:51 -0700 (PDT)
Received: from localhost (05462bf6.skybroadband.com. [5.70.43.246])
        by smtp.gmail.com with ESMTPSA id a8sm2730849wrg.85.2020.05.20.06.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 06:00:50 -0700 (PDT)
Date:   Wed, 20 May 2020 14:00:49 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf ordered_events: Optimise event object reuse
Message-ID: <20200520130049.GC19431@codeblueprint.co.uk>
References: <20200515210151.2058-1-matt@codeblueprint.co.uk>
 <20200518120408.GD3726797@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518120408.GD3726797@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May, at 02:04:08PM, Jiri Olsa wrote:
> On Fri, May 15, 2020 at 10:01:51PM +0100, Matt Fleming wrote:
> > ordered_event objects can be placed on the free object cache list in any
> > order which means future allocations may not return objects at
> > sequential locations in memory. Getting non-contiguous objects from the
> > free cache has bad consequences when later iterating over those objects
> > in ordered_events__queue().
> > 
> > For example, large perf.data files can contain trillions of events and
> > since objects that are next to each other in the free cache linked list
> > can point to pretty much anywhere in the object address space, lots of
> > cycles in ordered_events__queue() are spent servicing DTLB misses.
> > 
> > Implement the free object cache using the in-kernel implementation of
> > interval trees so that objects can always be allocated from the free
> > object cache in sequential order, improving spatial locality and
> > reducing DTLB misses.
> > 
> > Here are some numbers showing the speed up (reducing in execution time)
> > when running perf sched latency on sched events data and perf report on
> > HW_CPU_CYCLES.
> 
> really nice, few questions below
> 
> > 
> >  $ perf stat --null -r 10 -- bash -c \
> > 	"export PAGER=cat ; perf sched latency -i $file --stdio &>/dev/null"
> > 
> >   Nr events     File Size   Before    After    Speed up
> > --------------  ---------  --------  -------  ----------
> >   123318457470     29MB     0.2149    0.2440    -13.5%
> 
> should we be concerned about small data and the extra processing?
 
I didn't look into this slowdown originally because it's ~2.9 ms, but
FYI it looks like this is caused by:

 - Longer code paths (more instructions)
 - More branches
 - More branch mispredicts

> maybe we could add some option that disables this, at leat to be
> able to compare times in the future
 
Sure. Do you mean a command-line option or build-time config?

> > diff --git a/tools/include/linux/interval_tree_generic.h b/tools/include/linux/interval_tree_generic.h
> > new file mode 100644
> > index 000000000000..aaa8a0767aa3
> > --- /dev/null
> > +++ b/tools/include/linux/interval_tree_generic.h
> > @@ -0,0 +1,187 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > +  Interval Trees
> > +  (C) 2012  Michel Lespinasse <walken@google.com>
> > +
> > +
> > +  include/linux/interval_tree_generic.h
> > +*/
> > +
> > +#include <linux/rbtree_augmented.h>
> > +
> > +/*
> > + * Template for implementing interval trees
> > + *
> > + * ITSTRUCT:   struct type of the interval tree nodes
> > + * ITRB:       name of struct rb_node field within ITSTRUCT
> > + * ITTYPE:     type of the interval endpoints
> > + * ITSUBTREE:  name of ITTYPE field within ITSTRUCT holding last-in-subtree
> > + * ITSTART(n): start endpoint of ITSTRUCT node n
> > + * ITLAST(n):  last endpoint of ITSTRUCT node n
> > + * ITSTATIC:   'static' or empty
> > + * ITPREFIX:   prefix to use for the inline tree definitions
> > + *
> > + * Note - before using this, please consider if generic version
> > + * (interval_tree.h) would work for you...
> 
> the interval_tree.h looks like what you have added with the generic
> header.. is there some reason to use the _generic header?
 
Yes, the _generic version contains the actual implementation of
interval trees, so you need both.

> please add the header file also to check-headers.sh

Done!
 
> > diff --git a/tools/perf/tests/free-object-cache.c b/tools/perf/tests/free-object-cache.c
> > new file mode 100644
> > index 000000000000..e4395ece7d2b
> > --- /dev/null
> > +++ b/tools/perf/tests/free-object-cache.c
> > @@ -0,0 +1,200 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "tests.h"
> > +#include <linux/kernel.h>
> > +
> > +#define ordered_events__flush_time __test_ordered_events__flush_time
> > +#define ordered_events__first_time __test_ordered_events__first_time
> > +#define ordered_events__delete __test_ordered_events__delete
> > +#define ordered_events__init __test_ordered_events__init
> > +#define ordered_events__free __test_ordered_events__free
> > +#define ordered_events__queue __test_ordered_events__queue
> > +#define ordered_events__reinit __test_ordered_events__reinit
> > +#define ordered_events__flush __test_ordered_events__flush
> 
> I'm excited to see these tests, but why is above needed?
> 
> can't you use ordered-events interface as it is? you used only
> exported functions right?
 
Nope, the tests in this file are unit tests so I'm testing
free_cache_{get,put} which are file-local functions by #include'ing
ordered-events.c.

The above define are required to avoid duplicate symbol errors at
link-time, e.g.

  util/perf-in.o: In function `ordered_events__flush_time':
  /home/matt/src/kernels/linux/tools/perf/util/ordered-events.c:461: multiple definition of `ordered_events__flush_time'
  tests/perf-in.o:/home/matt/src/kernels/linux/tools/perf/tests/../util/ordered-events.c:461: first defined here

There are other ways to resolve this (linker flags to change the
symbols) but I couldn't find any precedent with that, so this seemed
like the easiest and most obvious solution. I'm happy to fix this up any
other way if you have suggestions though.

> > +static struct ordered_event *free_cache_get(struct ordered_events *oe)
> > +{
> > +	struct interval_tree_node *it;
> > +	struct ordered_event *new;
> > +	size_t bytes = sizeof(*new);
> > +
> > +	it = interval_tree_iter_first(&oe->cache, 0, ULONG_MAX);
> > +	if (!it)
> > +		return NULL;
> > +
> > +	/* Has the cache memory been exhausted? */
> > +	assert(cache_region_size(it) >= bytes);
> > +
> > +	new = (void *)it->start;
> > +	interval_tree_remove(it, &oe->cache);
> > +
> > +	it->start += bytes;
> > +	if (cache_region_size(it))
> > +		interval_tree_insert(it, &oe->cache);
> 
> in case we did not use the whole node, do we need to remove
> and insert back the node? it should be still the lowest node
> in the tree no? we could just fix 'start'

Hmm.. I originally did this remove/insert dance to be sure that the
rbtree semantics are maintained. But I think you're right that adjusting
->start cannot cause this rbtree node to move places in the tree and the
->start value isn't stored anywhere other than this interval_tree node
(a copy of ->last, on the other hand, can be stored in the parent node).

> > diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
> > index 0920fb0ec6cc..20d108baa572 100644
> > --- a/tools/perf/util/ordered-events.h
> > +++ b/tools/perf/util/ordered-events.h
> > @@ -3,9 +3,15 @@
> >  #define __ORDERED_EVENTS_H
> >  
> >  #include <linux/types.h>
> > +#include <linux/interval_tree.h>
> >  
> >  struct perf_sample;
> >  
> > +struct cache_region {
> > +	struct interval_tree_node node;
> > +	size_t len;
> > +};
> 
> ^^^ this looks like some leftover

Oops :) Yes, you're right. This should not be here.

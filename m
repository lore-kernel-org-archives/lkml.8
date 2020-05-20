Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B35C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA51D20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmcDX7Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgETVwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:52:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33648 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728032AbgETVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590011560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K1eoD/CbeHmAwwQM5Kk034bbHXePj0f8t/9qXqJL1eo=;
        b=VmcDX7JwTf5ihf5iii8uXNNaZvG3/HQRgQrgiB0lBEopLAiEir8ET0MLa0fEIWhBqPPn+Z
        99nx67sMGwfnZlSrI7zZqRBIL7d6iue5UtqiEL2hCH3rGtlv9zRGmcU9DBcwR0h+LDhCox
        6c/RzkEUDOP47ZK3u/xW/b8+2WRd01I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-JYwh_Y0HPJqVYzbY5uaHLg-1; Wed, 20 May 2020 17:52:37 -0400
X-MC-Unique: JYwh_Y0HPJqVYzbY5uaHLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 629918015CF;
        Wed, 20 May 2020 21:52:36 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 25AE960C05;
        Wed, 20 May 2020 21:52:34 +0000 (UTC)
Date:   Wed, 20 May 2020 23:52:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf ordered_events: Optimise event object reuse
Message-ID: <20200520215234.GO157452@krava>
References: <20200515210151.2058-1-matt@codeblueprint.co.uk>
 <20200518120408.GD3726797@krava>
 <20200520130049.GC19431@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520130049.GC19431@codeblueprint.co.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:00:49PM +0100, Matt Fleming wrote:
> On Mon, 18 May, at 02:04:08PM, Jiri Olsa wrote:
> > On Fri, May 15, 2020 at 10:01:51PM +0100, Matt Fleming wrote:
> > > ordered_event objects can be placed on the free object cache list in any
> > > order which means future allocations may not return objects at
> > > sequential locations in memory. Getting non-contiguous objects from the
> > > free cache has bad consequences when later iterating over those objects
> > > in ordered_events__queue().
> > > 
> > > For example, large perf.data files can contain trillions of events and
> > > since objects that are next to each other in the free cache linked list
> > > can point to pretty much anywhere in the object address space, lots of
> > > cycles in ordered_events__queue() are spent servicing DTLB misses.
> > > 
> > > Implement the free object cache using the in-kernel implementation of
> > > interval trees so that objects can always be allocated from the free
> > > object cache in sequential order, improving spatial locality and
> > > reducing DTLB misses.
> > > 
> > > Here are some numbers showing the speed up (reducing in execution time)
> > > when running perf sched latency on sched events data and perf report on
> > > HW_CPU_CYCLES.
> > 
> > really nice, few questions below
> > 
> > > 
> > >  $ perf stat --null -r 10 -- bash -c \
> > > 	"export PAGER=cat ; perf sched latency -i $file --stdio &>/dev/null"
> > > 
> > >   Nr events     File Size   Before    After    Speed up
> > > --------------  ---------  --------  -------  ----------
> > >   123318457470     29MB     0.2149    0.2440    -13.5%
> > 
> > should we be concerned about small data and the extra processing?
>  
> I didn't look into this slowdown originally because it's ~2.9 ms, but
> FYI it looks like this is caused by:
> 
>  - Longer code paths (more instructions)
>  - More branches
>  - More branch mispredicts
> 
> > maybe we could add some option that disables this, at leat to be
> > able to compare times in the future
>  
> Sure. Do you mean a command-line option or build-time config?

command line option would be great

SNIP

> > > diff --git a/tools/perf/tests/free-object-cache.c b/tools/perf/tests/free-object-cache.c
> > > new file mode 100644
> > > index 000000000000..e4395ece7d2b
> > > --- /dev/null
> > > +++ b/tools/perf/tests/free-object-cache.c
> > > @@ -0,0 +1,200 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "tests.h"
> > > +#include <linux/kernel.h>
> > > +
> > > +#define ordered_events__flush_time __test_ordered_events__flush_time
> > > +#define ordered_events__first_time __test_ordered_events__first_time
> > > +#define ordered_events__delete __test_ordered_events__delete
> > > +#define ordered_events__init __test_ordered_events__init
> > > +#define ordered_events__free __test_ordered_events__free
> > > +#define ordered_events__queue __test_ordered_events__queue
> > > +#define ordered_events__reinit __test_ordered_events__reinit
> > > +#define ordered_events__flush __test_ordered_events__flush
> > 
> > I'm excited to see these tests, but why is above needed?
> > 
> > can't you use ordered-events interface as it is? you used only
> > exported functions right?
>  
> Nope, the tests in this file are unit tests so I'm testing
> free_cache_{get,put} which are file-local functions by #include'ing
> ordered-events.c.
> 
> The above define are required to avoid duplicate symbol errors at
> link-time, e.g.
> 
>   util/perf-in.o: In function `ordered_events__flush_time':
>   /home/matt/src/kernels/linux/tools/perf/util/ordered-events.c:461: multiple definition of `ordered_events__flush_time'
>   tests/perf-in.o:/home/matt/src/kernels/linux/tools/perf/tests/../util/ordered-events.c:461: first defined here
> 
> There are other ways to resolve this (linker flags to change the
> symbols) but I couldn't find any precedent with that, so this seemed
> like the easiest and most obvious solution. I'm happy to fix this up any
> other way if you have suggestions though.

hum, could we just make free_cache_{get,put} public?

thanks,
jirka


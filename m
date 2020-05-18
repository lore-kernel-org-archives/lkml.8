Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D05C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECA2207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHmCJpW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgERMET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:04:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgERMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589803456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRnMC+lnT7sk2nKvfE9UPjmIBKn/psqZ0aN8wjwDhtw=;
        b=DHmCJpW+WXtARIZ9nOeqy7SrMal9M+6QpPU/ZU/2QjTc87sM0+nER+tuem2Ekjf2Y2/rmC
        M6zpaQZnDRxteLl/AF8/LDuIGwIMSF9V+rpqRxww70522e9A2Xf7bUW6WUac1hWVqjw2v9
        IFBaK0dV0IXX9F4XK6G5Ln3S5Io/Hl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-N9_yDv4QMKeEux82p5uKWQ-1; Mon, 18 May 2020 08:04:12 -0400
X-MC-Unique: N9_yDv4QMKeEux82p5uKWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 372A08015CF;
        Mon, 18 May 2020 12:04:11 +0000 (UTC)
Received: from krava (unknown [10.40.196.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0799D1053B1D;
        Mon, 18 May 2020 12:04:09 +0000 (UTC)
Date:   Mon, 18 May 2020 14:04:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf ordered_events: Optimise event object reuse
Message-ID: <20200518120408.GD3726797@krava>
References: <20200515210151.2058-1-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515210151.2058-1-matt@codeblueprint.co.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 10:01:51PM +0100, Matt Fleming wrote:
> ordered_event objects can be placed on the free object cache list in any
> order which means future allocations may not return objects at
> sequential locations in memory. Getting non-contiguous objects from the
> free cache has bad consequences when later iterating over those objects
> in ordered_events__queue().
> 
> For example, large perf.data files can contain trillions of events and
> since objects that are next to each other in the free cache linked list
> can point to pretty much anywhere in the object address space, lots of
> cycles in ordered_events__queue() are spent servicing DTLB misses.
> 
> Implement the free object cache using the in-kernel implementation of
> interval trees so that objects can always be allocated from the free
> object cache in sequential order, improving spatial locality and
> reducing DTLB misses.
> 
> Here are some numbers showing the speed up (reducing in execution time)
> when running perf sched latency on sched events data and perf report on
> HW_CPU_CYCLES.

really nice, few questions below

> 
>  $ perf stat --null -r 10 -- bash -c \
> 	"export PAGER=cat ; perf sched latency -i $file --stdio &>/dev/null"
> 
>   Nr events     File Size   Before    After    Speed up
> --------------  ---------  --------  -------  ----------
>   123318457470     29MB     0.2149    0.2440    -13.5%

should we be concerned about small data and the extra processing?

maybe we could add some option that disables this, at leat to be
able to compare times in the future

>  1651500885357    260MB     3.1205    1.9855    +36.4%
>  3470519751785    506MB     6.1821    3.8941    +37.0%
>  8213765551679   1100MB    13.4875    8.5079    +36.9%
> 15900515973759   1946MB    23.4069   15.0960    +35.5%

SNIP

> diff --git a/tools/include/linux/interval_tree_generic.h b/tools/include/linux/interval_tree_generic.h
> new file mode 100644
> index 000000000000..aaa8a0767aa3
> --- /dev/null
> +++ b/tools/include/linux/interval_tree_generic.h
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> +  Interval Trees
> +  (C) 2012  Michel Lespinasse <walken@google.com>
> +
> +
> +  include/linux/interval_tree_generic.h
> +*/
> +
> +#include <linux/rbtree_augmented.h>
> +
> +/*
> + * Template for implementing interval trees
> + *
> + * ITSTRUCT:   struct type of the interval tree nodes
> + * ITRB:       name of struct rb_node field within ITSTRUCT
> + * ITTYPE:     type of the interval endpoints
> + * ITSUBTREE:  name of ITTYPE field within ITSTRUCT holding last-in-subtree
> + * ITSTART(n): start endpoint of ITSTRUCT node n
> + * ITLAST(n):  last endpoint of ITSTRUCT node n
> + * ITSTATIC:   'static' or empty
> + * ITPREFIX:   prefix to use for the inline tree definitions
> + *
> + * Note - before using this, please consider if generic version
> + * (interval_tree.h) would work for you...

the interval_tree.h looks like what you have added with the generic
header.. is there some reason to use the _generic header?

please add the header file also to check-headers.sh

> + */
> +
> +#define INTERVAL_TREE_DEFINE(ITSTRUCT, ITRB, ITTYPE, ITSUBTREE,		      \
> +			     ITSTART, ITLAST, ITSTATIC, ITPREFIX)	      \
> +									      \
> +/* Callbacks for augmented rbtree insert and remove */			      \
> +									      \
> +RB_DECLARE_CALLBACKS_MAX(static, ITPREFIX ## _augment,			      \
> +			 ITSTRUCT, ITRB, ITTYPE, ITSUBTREE, ITLAST)	      \
> +									      \
> +/* Insert / remove interval nodes from the tree */			      \
> +									      \
> +ITSTATIC void ITPREFIX ## _insert(ITSTRUCT *node,			      \

SNIP

> diff --git a/tools/perf/tests/free-object-cache.c b/tools/perf/tests/free-object-cache.c
> new file mode 100644
> index 000000000000..e4395ece7d2b
> --- /dev/null
> +++ b/tools/perf/tests/free-object-cache.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "tests.h"
> +#include <linux/kernel.h>
> +
> +#define ordered_events__flush_time __test_ordered_events__flush_time
> +#define ordered_events__first_time __test_ordered_events__first_time
> +#define ordered_events__delete __test_ordered_events__delete
> +#define ordered_events__init __test_ordered_events__init
> +#define ordered_events__free __test_ordered_events__free
> +#define ordered_events__queue __test_ordered_events__queue
> +#define ordered_events__reinit __test_ordered_events__reinit
> +#define ordered_events__flush __test_ordered_events__flush

I'm excited to see these tests, but why is above needed?

can't you use ordered-events interface as it is? you used only
exported functions right?

> +
> +#include "../util/ordered-events.c"
> +
> +static void *alloc_cache(unsigned int num_objs)
> +{
> +	void *ptr = calloc(sizeof(struct ordered_event), num_objs);
> +	return ptr;
> +}
> +
> +static inline struct ordered_event *
> +cache_obj_entry(void *ptr, unsigned int index)
> +{

SNIP

> +static struct ordered_event *free_cache_get(struct ordered_events *oe)
> +{
> +	struct interval_tree_node *it;
> +	struct ordered_event *new;
> +	size_t bytes = sizeof(*new);
> +
> +	it = interval_tree_iter_first(&oe->cache, 0, ULONG_MAX);
> +	if (!it)
> +		return NULL;
> +
> +	/* Has the cache memory been exhausted? */
> +	assert(cache_region_size(it) >= bytes);
> +
> +	new = (void *)it->start;
> +	interval_tree_remove(it, &oe->cache);
> +
> +	it->start += bytes;
> +	if (cache_region_size(it))
> +		interval_tree_insert(it, &oe->cache);

in case we did not use the whole node, do we need to remove
and insert back the node? it should be still the lowest node
in the tree no? we could just fix 'start'

> +	else
> +		free(it);
> +
> +	return new;
> +}
> +

SNIP

> diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
> index 0920fb0ec6cc..20d108baa572 100644
> --- a/tools/perf/util/ordered-events.h
> +++ b/tools/perf/util/ordered-events.h
> @@ -3,9 +3,15 @@
>  #define __ORDERED_EVENTS_H
>  
>  #include <linux/types.h>
> +#include <linux/interval_tree.h>
>  
>  struct perf_sample;
>  
> +struct cache_region {
> +	struct interval_tree_node node;
> +	size_t len;
> +};

^^^ this looks like some leftover

thanks,
jirka

> +
>  struct ordered_event {
>  	u64			timestamp;
>  	u64			file_offset;
> @@ -39,7 +45,7 @@ struct ordered_events {
>  	u64				 max_alloc_size;
>  	u64				 cur_alloc_size;
>  	struct list_head		 events;
> -	struct list_head		 cache;
> +	struct rb_root_cached		 cache;
>  	struct list_head		 to_free;
>  	struct ordered_events_buffer	*buffer;
>  	struct ordered_event		*last;
> -- 
> 2.17.1
> 


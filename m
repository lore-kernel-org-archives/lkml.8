Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43AC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6FF20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="W3DY1kzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBCUex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:34:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36316 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgBCUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:34:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id w25so15654991qki.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 12:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vD4OaD6/Gu08Tv/eWLm2QG4l2LOcwWo02bsHVNhYVEQ=;
        b=W3DY1kzjGYRaQaDtq2ZYG1aZxLOR7ajyPdRtTamhizsDcB/cyjSjh5XRHFBA9iCHva
         fsxvDp7ShuBRZnOMZmW7pA3Y5guojMO9S+oOh11qPvpAoNYgygM9Coy+EtHWbt+dzAxz
         nymZW8joGe5Vj+WBlgcaHsMAM3enIIe825VxnEbtQcRXW5EVouOS4Qr4JOmbkQlV60RE
         Br79AFZv5RgJC6JbD/B1lTVtsi/z9nsg6M9x3CPYeB2mwcg3SXWlu6HTlkzAZFx1wQOY
         Qn8N0UCnOV3TeAMhET8najN9YueeVvnODYE1eWTz0KE1YdNHZIQPInFc2jjtl5XmQBl3
         CHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vD4OaD6/Gu08Tv/eWLm2QG4l2LOcwWo02bsHVNhYVEQ=;
        b=B5uzzlxwnjLBikrRGxVwRW20/zstl6kZZd1DXn0zGwlPDWhFKJXfQnKqIaZrwAGpYn
         pDTVs0rVFZumEH7zyjZ7pdjKcLxeNiRTgdqde/5TZ+vOmegWjIw8lwQcKUvM687ZCACs
         3UXtftKbB6JhqYMwAu/TV8iFsf0LufZTw5AmwDoj+ZhJzX2bwmumbNiFscZEMn9DufDI
         XYF+JLxMWunJ79ZlgOYuBijKkLZybm7t5cwCl1aI+pOmQZkWfDusOi7+WRvthLnPPbFS
         6HtIJeQyILpREKmb9abnHW6geZGtLHUaHAAWqASNzGhrORYdsyTe1mKigoJuOlhtdHKx
         +mog==
X-Gm-Message-State: APjAAAVltKuUYNh6zRtWhnQn9AArkPr0r2AAmeYVEPL3ty6gIt+d5YrX
        msz/GaBrdATX9S7IQT80Yg27vA==
X-Google-Smtp-Source: APXvYqzyJpvTPAQNuO333DHFMTSybUxePPApluL4ereGDZzQa5rPBTdzb1jyqc/jIvL27oY7+5IubA==
X-Received: by 2002:a05:620a:909:: with SMTP id v9mr12691741qkv.138.1580762092138;
        Mon, 03 Feb 2020 12:34:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:6320])
        by smtp.gmail.com with ESMTPSA id v4sm9703099qkj.64.2020.02.03.12.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:34:51 -0800 (PST)
Date:   Mon, 3 Feb 2020 15:34:50 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 12/28] mm: vmstat: use s32 for vm_node_stat_diff in
 struct per_cpu_nodestat
Message-ID: <20200203203450.GA6380@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-13-guro@fb.com>
 <20200203175818.GF1697@cmpxchg.org>
 <20200203182506.GA3700@xps.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203182506.GA3700@xps.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:25:06AM -0800, Roman Gushchin wrote:
> On Mon, Feb 03, 2020 at 12:58:18PM -0500, Johannes Weiner wrote:
> > On Mon, Jan 27, 2020 at 09:34:37AM -0800, Roman Gushchin wrote:
> > > Currently s8 type is used for per-cpu caching of per-node statistics.
> > > It works fine because the overfill threshold can't exceed 125.
> > > 
> > > But if some counters are in bytes (and the next commit in the series
> > > will convert slab counters to bytes), it's not gonna work:
> > > value in bytes can easily exceed s8 without exceeding the threshold
> > > converted to bytes. So to avoid overfilling per-cpu caches and breaking
> > > vmstats correctness, let's use s32 instead.
> > > 
> > > This doesn't affect per-zone statistics. There are no plans to use
> > > zone-level byte-sized counters, so no reasons to change anything.
> > 
> > Wait, is this still necessary? AFAIU, the node counters will account
> > full slab pages, including free space, and only the memcg counters
> > that track actual objects will be in bytes.
> > 
> > Can you please elaborate?
> 
> It's weird to have a counter with the same name (e.g. NR_SLAB_RECLAIMABLE_B)
> being in different units depending on the accounting scope.
> So I do convert all slab counters: global, per-lruvec,
> and per-memcg to bytes.

Since the node counters tracks allocated slab pages and the memcg
counter tracks allocated objects, arguably they shouldn't use the same
name anyway.

> Alternatively I can fork them, e.g. introduce per-memcg or per-lruvec
> NR_SLAB_RECLAIMABLE_OBJ
> NR_SLAB_UNRECLAIMABLE_OBJ

Can we alias them and reuse their slots?

	/* Reuse the node slab page counters item for charged objects */
	MEMCG_SLAB_RECLAIMABLE = NR_SLAB_RECLAIMABLE,
	MEMCG_SLAB_UNRECLAIMABLE = NR_SLAB_UNRECLAIMABLE,

> and keep global counters untouched. If going this way, I'd prefer to make
> them per-memcg, because it will simplify things on charging paths:
> now we do get task->mem_cgroup->obj_cgroup in the pre_alloc_hook(),
> and then obj_cgroup->mem_cgroup in the post_alloc_hook() just to
> bump per-lruvec counters.

I don't quite follow. Don't you still have to update the global
counters?

> Btw, I wonder if we really need per-lruvec counters at all (at least
> being enabled by default). For the significant amount of users who
> have a single-node machine it doesn't bring anything except performance
> overhead.

Yeah, for single-node systems we should be able to redirect everything
to the memcg counters, without allocating and tracking lruvec copies.

> For those who have multiple nodes (and most likely many many
> memory cgroups) it provides way too many data except for debugging
> some weird mm issues.
> I guess in the absolute majority of cases having global per-node + per-memcg
> counters will be enough.

Hm? Reclaim uses the lruvec counters.

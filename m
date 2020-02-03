Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF140C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954A920838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="zyIaKgcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBCWj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:39:57 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33118 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:39:57 -0500
Received: by mail-qv1-f65.google.com with SMTP id z3so7669104qvn.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lnf5qSOR3Nb9OsfKa1i8yMz+LDP/mlxReDeXQiLk4Vg=;
        b=zyIaKgcHYVH9w9aAnmil6tqVBOdVJTTFgTKxa3O/oFMqBDXZy4efUIziZf5MJCAgI9
         1iJ/U/yFxHG8AtwZpKglJ1irzVfmlvh0iLnOR1jJxcbLXMfGwTH2qEp3nTR8/HgWk1Z+
         ZcXifH8AgcKLonZ9a2qRKL6DVZ3s63Pe9NdNhF/fXKuO92C4/hbyB63i1AaFpzWqX0vE
         zHAPxZn3RmDD0DNGcyF/xwzCHZgsmD/u3tBRLUSwf4nN9crZ6eGmszJ7I+9UrEuRbkaJ
         4puwtMdVjCukC18pSuv2PhmGADKqof4AgUFibXH8Ge0c5BOBQ2yl8jUMolGfm7uPWY6C
         7UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lnf5qSOR3Nb9OsfKa1i8yMz+LDP/mlxReDeXQiLk4Vg=;
        b=ksXK/xDawetyhgT66A0j74FuZrc3W0AHdgDQ7eNo7ivw5ypshN/RrfOA8SoAZ2ZP7K
         a0yG5yV2tzqdUerDzaGGeGEc0gGWOW31eoHDlaj3MSSaCcARARQzdtAsozOBt58OJYcG
         Jgdyu5+69vEMRiyXezvUjbvcH1JzL1RwpnQe5eaRM7/uHFzhGOCkMYkX/MLLfDl/XrFK
         SEHVYuJkE1jGGrJUAqPittgPGZVgZ/Ve5imwYpEAkZbImClSGpVbTKibCruhRFA8nofF
         NW9AMQbuZNtSjTCu6FBEM3PVJ0dyRQXLSAvsOh8HzHd5b3R3Vk+SfSyVSIpYpOFJpKcp
         ygfw==
X-Gm-Message-State: APjAAAWiGHm5OloPmYPVQK4/AA5Ztn1tH3iYpqD85hwd6588I+/5NOzd
        oa6eLCv/d1nqHwRnvtxldFmEyQ==
X-Google-Smtp-Source: APXvYqzDmHTw9RvC1sAlfRuRhPRUYdvVcjiqgzOnuxMAmq0EQLjgGe/w/heUvyU3io0w81zdyzi8PQ==
X-Received: by 2002:a0c:ffc9:: with SMTP id h9mr25301780qvv.50.1580769595745;
        Mon, 03 Feb 2020 14:39:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:6320])
        by smtp.gmail.com with ESMTPSA id w2sm10758228qtd.97.2020.02.03.14.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 14:39:54 -0800 (PST)
Date:   Mon, 3 Feb 2020 17:39:54 -0500
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
Message-ID: <20200203223954.GE6380@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-13-guro@fb.com>
 <20200203175818.GF1697@cmpxchg.org>
 <20200203182506.GA3700@xps.dhcp.thefacebook.com>
 <20200203203450.GA6380@cmpxchg.org>
 <20200203222853.GD6781@xps.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203222853.GD6781@xps.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 02:28:53PM -0800, Roman Gushchin wrote:
> On Mon, Feb 03, 2020 at 03:34:50PM -0500, Johannes Weiner wrote:
> > On Mon, Feb 03, 2020 at 10:25:06AM -0800, Roman Gushchin wrote:
> > > On Mon, Feb 03, 2020 at 12:58:18PM -0500, Johannes Weiner wrote:
> > > > On Mon, Jan 27, 2020 at 09:34:37AM -0800, Roman Gushchin wrote:
> > > > > Currently s8 type is used for per-cpu caching of per-node statistics.
> > > > > It works fine because the overfill threshold can't exceed 125.
> > > > > 
> > > > > But if some counters are in bytes (and the next commit in the series
> > > > > will convert slab counters to bytes), it's not gonna work:
> > > > > value in bytes can easily exceed s8 without exceeding the threshold
> > > > > converted to bytes. So to avoid overfilling per-cpu caches and breaking
> > > > > vmstats correctness, let's use s32 instead.
> > > > > 
> > > > > This doesn't affect per-zone statistics. There are no plans to use
> > > > > zone-level byte-sized counters, so no reasons to change anything.
> > > > 
> > > > Wait, is this still necessary? AFAIU, the node counters will account
> > > > full slab pages, including free space, and only the memcg counters
> > > > that track actual objects will be in bytes.
> > > > 
> > > > Can you please elaborate?
> > > 
> > > It's weird to have a counter with the same name (e.g. NR_SLAB_RECLAIMABLE_B)
> > > being in different units depending on the accounting scope.
> > > So I do convert all slab counters: global, per-lruvec,
> > > and per-memcg to bytes.
> > 
> > Since the node counters tracks allocated slab pages and the memcg
> > counter tracks allocated objects, arguably they shouldn't use the same
> > name anyway.
> > 
> > > Alternatively I can fork them, e.g. introduce per-memcg or per-lruvec
> > > NR_SLAB_RECLAIMABLE_OBJ
> > > NR_SLAB_UNRECLAIMABLE_OBJ
> > 
> > Can we alias them and reuse their slots?
> > 
> > 	/* Reuse the node slab page counters item for charged objects */
> > 	MEMCG_SLAB_RECLAIMABLE = NR_SLAB_RECLAIMABLE,
> > 	MEMCG_SLAB_UNRECLAIMABLE = NR_SLAB_UNRECLAIMABLE,
> 
> Yeah, lgtm.
> 
> Isn't MEMCG_ prefix bad because it makes everybody think that it belongs to
> the enum memcg_stat_item?

Maybe, not sure that's a problem. #define CG_SLAB_RECLAIMABLE perhaps?

> > > and keep global counters untouched. If going this way, I'd prefer to make
> > > them per-memcg, because it will simplify things on charging paths:
> > > now we do get task->mem_cgroup->obj_cgroup in the pre_alloc_hook(),
> > > and then obj_cgroup->mem_cgroup in the post_alloc_hook() just to
> > > bump per-lruvec counters.
> > 
> > I don't quite follow. Don't you still have to update the global
> > counters?
> 
> Global counters are updated only if an allocation requires a new slab
> page, which isn't the most common path.

Right.

> In generic case post_hook is required because it's the only place where
> we have both page (to get the node) and memcg pointer.
> 
> If NR_SLAB_RECLAIMABLE is tracked only per-memcg (as MEMCG_SOCK),
> then post_hook can handle only the rare "allocation failed" case.
> 
> I'm not sure here what's better.

If it's tracked only per-memcg, you still have to account it every
time you charge an object to a memcg, no? How is it less frequent than
acconting at the lruvec level?

> > > Btw, I wonder if we really need per-lruvec counters at all (at least
> > > being enabled by default). For the significant amount of users who
> > > have a single-node machine it doesn't bring anything except performance
> > > overhead.
> > 
> > Yeah, for single-node systems we should be able to redirect everything
> > to the memcg counters, without allocating and tracking lruvec copies.
> 
> Sounds good. It can lead to significant savings on single-node machines.
> 
> > 
> > > For those who have multiple nodes (and most likely many many
> > > memory cgroups) it provides way too many data except for debugging
> > > some weird mm issues.
> > > I guess in the absolute majority of cases having global per-node + per-memcg
> > > counters will be enough.
> > 
> > Hm? Reclaim uses the lruvec counters.
> 
> Can you, please, provide some examples? It looks like it's mostly based
> on per-zone lruvec size counters.

It uses the recursive lruvec state to decide inactive_is_low(),
whether refaults are occuring, whether to trim cache only or go for
anon etc. We use it to determine refault distances and how many shadow
nodes to shrink.

Grep for lruvec_page_state().

> Anyway, it seems to be a little bit off from this patchset, so let's
> discuss it separately.

True

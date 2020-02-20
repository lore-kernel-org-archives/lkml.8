Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F2C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8E42068F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="l51yhkuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgBTOl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:41:59 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43851 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgBTOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:41:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id g21so2989904qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KgbFEoscP48mjVdnl3aSH+kUhdeWQePC7wbq6bCa4AI=;
        b=l51yhkuYtGjX8vKxaBvsS/B8GZzoCQr91t6X70oS24fKcX6vJmPlWYHVbH4cB3pjl0
         5qs4wzApaOlZuHtPSnm8fZhN9OtFb/+ehbVoV5pR+PXhGahDzS60vF7nWbnZPI4ti8v3
         5CFjdvUwF2//teO1Oz8M9yB7KX/AT0nxUuVCwnl4LfukO00wgIFbWtkTsyRjq7pThyUn
         SyODh0ewSHxw/Ai/JXo2rIwKG0+LHLyVOF6QyHFXLFbIRyGgcXByyHfFdH3+rDfMrZSm
         t6MdatyRR+5T8vJBkUuk2eR4bf7+AG4MqffGfFnSAvSJSJN/SgifddKfeQDb8i2lA78s
         z1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KgbFEoscP48mjVdnl3aSH+kUhdeWQePC7wbq6bCa4AI=;
        b=hqKW0ICFXWHrkZWgcwgU0UzaIBtGQC6cHlnTIGjSDnCsb6DRKQCPgzRE2kCGwzg091
         ss9SPHflXyPXvX3jpVSuRS6YO45fdspbNPN3Z/FzG89N/rP24zhYurMpddy1LUuKIPiU
         /MVtforyKY8T6Gbjcho1TZ0iO9Yw9hWCzDeNeGlAmwjZQWn4NPu2E2sqz2zp6M0I5XdR
         O+4uCJnb8hrMGad/xrhRLINv7fgtLwX0LoaJLaM8CoNhtBpwKsOAWfhNxv7B6PSe4LAP
         Pja0wZAC1d/fG6a7mzJojAbHtoaKs8nCLr5KYaDFzCuPU3xDgLQOfN4GJaNdQfA/XfmA
         JEow==
X-Gm-Message-State: APjAAAUQnjNP7x6VvvpDs3/oUApKyhkWZ4luNRJNF3h+EzHhUWznzfo+
        sJZEbl61pjMV9M/MuZmcHu5KW94eceY=
X-Google-Smtp-Source: APXvYqwEv/5U/QFxIfjUoLGU9KuOmPp21CM34cBTZ3WJpeLXohEa/5gRM0HCWC3li/taBpa8gEHzzg==
X-Received: by 2002:ac8:34b2:: with SMTP id w47mr26126481qtb.142.1582209716681;
        Thu, 20 Feb 2020 06:41:56 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id z27sm1813153qtv.11.2020.02.20.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:41:55 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:41:54 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200220144154.GA61895@cmpxchg.org>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219211735.GD54486@cmpxchg.org>
 <20200220094639.GD20509@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220094639.GD20509@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:46:39AM +0100, Michal Hocko wrote:
> On Wed 19-02-20 16:17:35, Johannes Weiner wrote:
> > On Wed, Feb 19, 2020 at 08:53:32PM +0100, Michal Hocko wrote:
> > > On Wed 19-02-20 14:16:18, Johannes Weiner wrote:
> [...]
> > > > [ This is generally work in process: for example, if you isolate
> > > >   workloads with memory.low, kswapd cpu time isn't accounted to the
> > > >   cgroup that causes it. Swap IO issued by kswapd isn't accounted to
> > > >   the group that is getting swapped.
> > > 
> > > Well, kswapd is a system activity and as such it is acceptable that it
> > > is accounted to the system. But in this case we are talking about a
> > > memcg configuration which influences all other workloads by stealing CPU
> > > cycles from them 
> > 
> > From a user perspective this isn't a meaningful distinction.
> > 
> > If I partition my memory among containers and one cgroup is acting
> > out, I would want the culprit to be charged for the cpu cycles the
> > reclaim is causing. Whether I divide my machine up using memory.low or
> > using memory.max doesn't really matter: I'm choosing between the two
> > based on a *memory policy* I want to implement - work-conserving vs
> > non-conserving. I shouldn't have to worry about the kernel tracking
> > CPU cycles properly in the respective implementations of these knobs.
> > 
> > So kswapd is very much a cgroup-attributable activity, *especially* if
> > I'm using memory.low to delineate different memory domains.
> 
> While I understand what you are saying I do not think this is easily
> achievable with the current implementation. The biggest problem I can
> see is that you do not have a clear information who to charge for
> the memory shortage on a particular NUMA node with a pure low limit
> based balancing because the limit is not NUMA aware. Besides that the
> origin of the memory pressure might be outside of any memcg.  You can
> punish/account all memcgs in excess in some manner, e.g. proportionally
> to their size/excess but I am not really sure how fair that will
> be. Sounds like an interesting project but also sounds like tangent to
> this patch.
> 
> High/Max limits are quite different because they are dealing with
> the internal memory pressure and you can attribute it to the
> cgroup/hierarchy which is in excess. There is a clear domain to reclaim
> from. This is an easier model to reason about IMHO.

They're not different. memory.low is just a usage limit that happens
to be enforcecd lazily rather than immediately.

If I'm setting memory.high or memory.max and I allocate beyond it, my
memory will be reclaimed with the limit as the target.

If I'm setting memory.low and I allocate beyond it, my memory will
eventually be reclaimed with the limit as the target.

In either case, the cgroup who allocated the memory that is being
reclaimed is the one obviously responsible for the reclaim work. Why
would the time of limit enforcement change that?

If on the other hand an allocation reclaims you below your limit, such
as can happen with a NUMA-bound allocation, whether it's high, max, or
low, then that's their cost to pay. But it's not really that important
what we do in that case - the memcg settings aren't NUMA aware so that
whole scenario is out of the purview of the controller anyway.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d6085115c7f2..24fe6e9e64b1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2651,6 +2651,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		bool account_cpu = current_is_kswapd() || current_work();
 		unsigned long reclaimed;
 		unsigned long scanned;
 
@@ -2673,6 +2674,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				continue;
 			}
 			memcg_memory_event(memcg, MEMCG_LOW);
+			account_cpu = false;
 			break;
 		case MEMCG_PROT_NONE:
 			/*
@@ -2688,11 +2690,17 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		reclaimed = sc->nr_reclaimed;
 		scanned = sc->nr_scanned;
 
+		if (account_cpu)
+			use_cpu_of_cgroup(memcg->css.cgroup);
+
 		shrink_lruvec(lruvec, sc);
 
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
 
+		if (account_cpu)
+			unuse_cpu_of_cgroup();
+
 		/* Record the group's reclaim efficiency */
 		vmpressure(sc->gfp_mask, memcg, false,
 			   sc->nr_scanned - scanned,


> > > without much throttling on the consumer side - especially when the
> > > memory is reclaimable without a lot of sleeping or contention on
> > > locks etc.
> > 
> > The limiting factor on the consumer side is IO. Reading a page is way
> > more costly than reclaiming it, which is why we built our isolation
> > stack starting with memory and IO control and are only now getting to
> > working on proper CPU isolation.
> > 
> > > I am absolutely aware that we will never achieve a perfect isolation due
> > > to all sorts of shared data structures, lock contention and what not but
> > > this patch alone just allows spill over to unaccounted work way too
> > > easily IMHO.
> > 
> > I understand your concern about CPU cycles escaping, and I share
> > it. My point is that this patch isn't adding a problem that isn't
> > already there, nor is it that much of a practical concern at the time
> > of this writing given the state of CPU isolation in general.
> 
> I beg to differ here. Ppu controller should be able to isolate user
> contexts performing high limit reclaim now. Your patch is changing that
> functionality to become unaccounted for a large part and that might be
> seen as a regression for those workloads which partition the system by
> using high limit and also rely on cpu controller because workloads are
> CPU sensitive.
>
> Without the CPU controller support this patch is not complete and I do
> not see an absolute must to marge it ASAP because it is not a regression
> fix or something we cannot live without.

I think you're still thinking in a cgroup1 reality, where you would
set a memory limit in isolation and then eat a ton of CPU pushing up
against it.

In comprehensive isolation setups implemented in cgroup2, "heavily"
reclaimed containers are primarily IO bound on page faults, refaults,
writeback. The reclaim cost is a small part of it, and as I said, in a
magnitude range for which the CPU controller is currently too heavy.

We can carry this patch out of tree until the CPU controller is fixed,
but I think the reasoning to keep it out is not actually based on the
practical reality of a cgroup2 world.

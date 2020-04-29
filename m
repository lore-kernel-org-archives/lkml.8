Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64AC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4822082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ndIkV6Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD2O1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2O1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:27:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F6C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:27:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o135so2113622qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aWtaTTSNTzK+8VtJHmNxXi4ve7kZo3n6KV5SYDQbS9I=;
        b=ndIkV6QfmD4PZV4Z0gk7BymE8uvcokLZlAam1EshLYJTdQtA2p0eUPC+Hmx9hBfXvN
         hZ50Ak/UHf9Fra322cv86xXt0zYopr1qPtueLJGLTrAmwLgQLEDW2tpuZp9xuCg3UYeb
         1pRV5GpAbKffqyU5Nb7kexzabW+dXiIZIOaSixhmNuh/LuudbFkn4dDzWbloJuphK4SW
         K7NazNpTDV5jO+391IEE/olFqy3szjBdunZlILubAuzJjMyEnYkCf6SjhVa48kEaHLCy
         CZeLpzlFOuGPaybdZhd0YNmq43ykaEt7GiZJbsLKyAVQpCusw266ZIQntmf9f7oBI4a0
         dg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aWtaTTSNTzK+8VtJHmNxXi4ve7kZo3n6KV5SYDQbS9I=;
        b=PVlztWG8+p81HAIxcgOG3gN1ejOgn3WR7rtoSAEikuDcmo89K/uSfQvUir8w4XDJLI
         h4YhSWXKyOQoZu3VzYqoSA2oF5eYuY88kzz4MMqQIaz2vZAzDOYYAEER9u0J39hmt4Aw
         aPzOHbUe0e0BoWjMQYWBhwpWf5laQpZmdLZ9aXiay0xP4DaT0LeZrbwtDYzMCgYh/Uey
         ktBanXlzLl+CRfVueX9XWPD/x0IWBOZCaNxdXPE1znASyrtlW1VxowYcOjOSia+aw3wy
         JPlQ4zrhonol2YDqowKN55o3CSjXB0w57oBNJ1OfP/nRR5wYbtUSw8mC0dp6wWSmzbLm
         43UQ==
X-Gm-Message-State: AGi0PuZSYX5PguHQWLdw9lNpOdauLiPcnn6oCD7WqX8ZPy+0uQ1zh+xd
        yLTNGXFInTUDBYNmMGUxYqjhwg==
X-Google-Smtp-Source: APiQypLiOpvbdB3+NWJLeDMk2IFfTw8C7tKZxWfmSGnuL4vmPVmeeniA4NGqql1pqHGsRRREiU1c8g==
X-Received: by 2002:a37:7786:: with SMTP id s128mr33937820qkc.497.1588170429291;
        Wed, 29 Apr 2020 07:27:09 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id i6sm15584097qkk.123.2020.04.29.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:27:08 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:27:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200429142707.GC5054@cmpxchg.org>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz>
 <20200429140330.GA5054@cmpxchg.org>
 <CALOAHbCC-oT+CwzyokNfomEMf0GdzpipBeZJjnnE8RrPPZ_Maw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCC-oT+CwzyokNfomEMf0GdzpipBeZJjnnE8RrPPZ_Maw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:17:21PM +0800, Yafang Shao wrote:
> On Wed, Apr 29, 2020 at 10:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Apr 29, 2020 at 12:15:10PM +0200, Michal Hocko wrote:
> > > On Tue 28-04-20 19:26:47, Chris Down wrote:
> > > > From: Yafang Shao <laoar.shao@gmail.com>
> > > >
> > > > A cgroup can have both memory protection and a memory limit to isolate
> > > > it from its siblings in both directions - for example, to prevent it
> > > > from being shrunk below 2G under high pressure from outside, but also
> > > > from growing beyond 4G under low pressure.
> > > >
> > > > Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> > > > implemented proportional scan pressure so that multiple siblings in
> > > > excess of their protection settings don't get reclaimed equally but
> > > > instead in accordance to their unprotected portion.
> > > >
> > > > During limit reclaim, this proportionality shouldn't apply of course:
> > > > there is no competition, all pressure is from within the cgroup and
> > > > should be applied as such. Reclaim should operate at full efficiency.
> > > >
> > > > However, mem_cgroup_protected() never expected anybody to look at the
> > > > effective protection values when it indicated that the cgroup is above
> > > > its protection. As a result, a query during limit reclaim may return
> > > > stale protection values that were calculated by a previous reclaim cycle
> > > > in which the cgroup did have siblings.
> > > >
> > > > When this happens, reclaim is unnecessarily hesitant and potentially
> > > > slow to meet the desired limit. In theory this could lead to premature
> > > > OOM kills, although it's not obvious this has occurred in practice.
> > >
> > > Thanks this describes the underlying problem. I would be also explicit
> > > that the issue should be visible only on tail memcgs which have both
> > > max/high and protection configured and the effect depends on the
> > > difference between the two (the smaller it is the largrger the effect).
> > >
> > > There is no mention about the fix. The patch resets effective values for
> > > the reclaim root and I've had some concerns about that
> > > http://lkml.kernel.org/r/20200424162103.GK11591@dhcp22.suse.cz.
> > > Johannes has argued that other races are possible and I didn't get to
> > > think about it thoroughly. But this patch is introducing a new
> > > possibility of breaking protection. If we want to have a quick and
> > > simple fix that would be easier to backport to older kernels then I
> > > would feel much better if we simply workedaround the problem as
> > > suggested earlier http://lkml.kernel.org/r/20200423061629.24185-1-laoar.shao@gmail.com
> > > We can rework the effective values calculation to be more robust against
> > > races on top of that because this is likely a more tricky thing to do.
> >
> > Well, can you please *do* think more thoroughly about what I wrote,
> > instead of pushing for an alternative patch on gut feeling alone?
> >
> > Especially when you imply that this should be a stable patch.
> >
> > Not only does your alternative patch not protect against the race you
> > are worried about, the race itself doesn't matter. Racing reclaimers
> > will write their competing views of the world into the shared state on
> > all other levels anyway.
> >
> > And that's okay. If the configuration and memory usage is such that
> > there is at least one reclaimer that scans without any protection
> > (like a limit reclaimer), it's not a problem when a second reclaimer
> > that meant to do protected global reclaim will also do one iteration
> > without protection. It's no different than if a second thread had
> > entered limit reclaim through another internal allocation.
> >
> > There is no semantical violation with the race in your patch or the
> > race in this patch. Any effective protection that becomes visible is
> > 1) permitted by the configuration, but 2) also triggered *right now*
> > by an acute need to reclaim memory with these parameters.
> >
> > The *right now* part is important. That's what's broken before either
> > patch, and that's what we're fixing: to see really, really *old* stale
> > that might not be representative of the config semantics anymore.
> >
> > Since you haven't linked to my email, here is my counter argument to
> > the alternative patch "fixing" this race somehow.
> >
> > A reclaim:
> >
> >   root
> >      `- A (low=2G, max=3G -> elow=0)
> >         `- A1 (low=0G -> elow=0)
> >
> > Global reclaim:
> >
> >   root
> >      `- A (low=2G, max=3G -> elow=2G)
> >         `- A1 (low=0G -> elow=2G)
> >
> > During global reclaim, A1 is supposed to have 2G effective low
> > protection. If A limit reclaim races, it can set A1's elow to
> > 0.
> 
> Before the commit  8a931f801340c2be ("mm: memcontrol: recursive
> memory.low protection"), the A1's elow should be 0, while after this
> commit A1's elow is 2G.
> That is a behavior change.

Yes, that was an intentional change around the inheritance rules.

And your alternative patch doesn't fix the race you are (wrongly)
worried about under these rules.

What's your point, exactly?

> Then this case gives us another example why accessing emin and elow in
> the very deap reclaiming code (get_scan_count) is the root of ALL
> EVIL.

You must be confusing this software engineering list with a witch
doctor conference.

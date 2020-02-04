Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DBC35249
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2571620732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="E0/9on/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBDCrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:47:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38457 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBDCrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:47:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id c24so13240932qtp.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UyYJJqcFkeJNY00fHjSiYtuioSfijfxWttZDn1o+A2M=;
        b=E0/9on/7kE0yBBvr+TXfd8zbZMBwUclKE4DntYTMrzeyPC0LGoQiku1rSefpBav+Q+
         wfM+uNXIopm3z7zJ6hD7levaCsDKxRqJTqLYXnllQZ8HGuDg9aAUQZVqIF25R6tg2Fdv
         123Gd9d/AqhsPb5NOt2xqJCpvN+feYMjwICpbT42BDYO0ArhDLfz5Ru3MOyS2+KP1Hgq
         9zPpbkusbLvAHvuWYHSoz9W7umiHGHpc0YNetB/ZBPy2cpAa3QgW3USppLMV4DOImT8G
         ehcixbVII1jPNelY8jApYas/pCbdRgiYWM2G4uqOI6Sjff8AdLLsi6vjVQ9GNgvqEYOR
         AIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UyYJJqcFkeJNY00fHjSiYtuioSfijfxWttZDn1o+A2M=;
        b=Ga+FZBKddM5ZFszYWIshFNdnESySw8hYXp8Dz9I8jWxFlB0PBEmZyklBwgCpf8YeF/
         0AYBHBg3C9QfEb3x3LW1rxSnNF1Hjttzhyo+wXElb4yXVyar0fku2u/yNmeOY1MwuunY
         7EKO03m+8P9ZUOhFH87vta/o2Gx4g9FVkiQ/ZAW0O3SX5czBt1n67m26XN1rz142Dtii
         CADeJpluzMLluDsvHlYirZJh7/vq2csWlaz9n2B+DmBGQUo6aHz+7jytjP66cu0HlJIs
         FaazDhqjFKPJvnP+Pf/aLyuaFVKiYDuF5bgORddA18c0Sbfy7y3n3Jm+Ju5LgqEw+Ttq
         7zZA==
X-Gm-Message-State: APjAAAVMIXIN3H50qgne6JbOxIcO3l+qlnwj1JLajuSsMovtOtUC0njV
        P00sgnBS14QAFyyJoRT+tJFv/uomC9A=
X-Google-Smtp-Source: APXvYqwm2gqRiWZ4/zbhg2aCKDAUdKEn5IFKs8iI5eWmNdls1pfNASCsQRj+3vJ2wVytHtFsX9mXCw==
X-Received: by 2002:ac8:5353:: with SMTP id d19mr25938475qto.313.1580784426277;
        Mon, 03 Feb 2020 18:47:06 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id o7sm10356446qkd.119.2020.02.03.18.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:47:05 -0800 (PST)
Date:   Mon, 3 Feb 2020 21:47:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 21/28] mm: memcg/slab: use a single set of kmem_caches
 for all memory cgroups
Message-ID: <20200204024704.GA9027@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-22-guro@fb.com>
 <20200203195048.GA4396@cmpxchg.org>
 <20200203205834.GA6781@xps.dhcp.thefacebook.com>
 <20200203221734.GA7345@cmpxchg.org>
 <20200204011505.GA9138@xps.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204011505.GA9138@xps.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 05:15:05PM -0800, Roman Gushchin wrote:
> On Mon, Feb 03, 2020 at 05:17:34PM -0500, Johannes Weiner wrote:
> > On Mon, Feb 03, 2020 at 12:58:34PM -0800, Roman Gushchin wrote:
> > > On Mon, Feb 03, 2020 at 02:50:48PM -0500, Johannes Weiner wrote:
> > > > On Mon, Jan 27, 2020 at 09:34:46AM -0800, Roman Gushchin wrote:
> > > > > This is fairly big but mostly red patch, which makes all non-root
> > > > > slab allocations use a single set of kmem_caches instead of
> > > > > creating a separate set for each memory cgroup.
> > > > > 
> > > > > Because the number of non-root kmem_caches is now capped by the number
> > > > > of root kmem_caches, there is no need to shrink or destroy them
> > > > > prematurely. They can be perfectly destroyed together with their
> > > > > root counterparts. This allows to dramatically simplify the
> > > > > management of non-root kmem_caches and delete a ton of code.
> > > > 
> > > > This is definitely going in the right direction. But it doesn't quite
> > > > explain why we still need two sets of kmem_caches?
> > > > 
> > > > In the old scheme, we had completely separate per-cgroup caches with
> > > > separate slab pages. If a cgrouped process wanted to allocate a slab
> > > > object, we'd go to the root cache and used the cgroup id to look up
> > > > the right cgroup cache. On slab free we'd use page->slab_cache.
> > > > 
> > > > Now we have slab pages that have a page->objcg array. Why can't all
> > > > allocations go through a single set of kmem caches? If an allocation
> > > > is coming from a cgroup and the slab page the allocator wants to use
> > > > doesn't have an objcg array yet, we can allocate it on the fly, no?
> > > 
> > > Well, arguably it can be done, but there are few drawbacks:
> > > 
> > > 1) On the release path you'll need to make some extra work even for
> > >    root allocations: calculate the offset only to find the NULL objcg pointer.
> > > 
> > > 2) There will be a memory overhead for root allocations
> > >    (which might or might not be compensated by the increase
> > >    of the slab utilization).
> > 
> > Those two are only true if there is a wild mix of root and cgroup
> > allocations inside the same slab, and that doesn't really happen in
> > practice. Either the machine is dedicated to one workload and cgroups
> > are only enabled due to e.g. a vendor kernel, or you have cgrouped
> > systems (like most distro systems now) that cgroup everything.
> 
> It's actually a questionable statement: we do skip allocations from certain
> contexts, and we do merge slab caches.
> 
> Most likely it's true for certain slab_caches and not true for others.
> Think of kmalloc-* caches.

With merging it's actually really hard to say how sparse or dense the
resulting objcgroup arrays would be. It could change all the time too.

> Also, because obj_cgroup vectors will not be freed without underlying pages,
> most likely the percentage of pages with obj_cgroups will grow with uptime.
> In other words, memcg allocations will fragment root slab pages.

I understand the first part of this paragraph, but not the second. The
objcgroup vectors will be freed when the slab pages get freed. But the
partially filled slab pages can be reused by any types of allocations,
surely? How would this cause the pages to fragment?

> > > 3) I'm working on percpu memory accounting that resembles the same scheme,
> > >    except that obj_cgroups vector is created for the whole percpu block.
> > >    There will be root- and memcg-blocks, and it will be expensive to merge them.
> > >    I kinda like using the same scheme here and there.
> > 
> > It's hard to conclude anything based on this information alone. If
> > it's truly expensive to merge them, then it warrants the additional
> > complexity. But I don't understand the desire to share a design for
> > two systems with sufficiently different constraints.
> > 
> > > Upsides?
> > > 
> > > 1) slab utilization might increase a little bit (but I doubt it will have
> > >    a huge effect, because both merging sets should be relatively big and well
> > >    utilized)
> > 
> > Right.
> > 
> > > 2) eliminate memcg kmem_cache dynamic creation/destruction. it's nice,
> > >    but there isn't so much code left anyway.
> > 
> > There is a lot of complexity associated with the cache cloning that
> > isn't the lines of code, but the lifetime and synchronization rules.
> 
> Quite opposite: the patchset removes all the complexity (or 90% of it),
> because it makes the kmem_cache lifetime independent from any cgroup stuff.
> 
> Kmem_caches are created on demand on the first request (most likely during
> the system start-up), and destroyed together with their root counterparts
> (most likely never or on rmmod). First request means globally first request,
> not a first request from a given memcg.
> 
> Memcg kmem_cache lifecycle has nothing to do with memory/obj_cgroups, and
> after creation just matches the lifetime of the root kmem caches.
> 
> The only reason to keep the async creation is that some kmem_caches
> are created very early in the boot process, long before any cgroup
> stuff is initialized.

Yes, it's independent of the obj_cgroup and memcg, and yes it's
simpler after your patches. But I'm not talking about the delta, I'm
trying to understand the end result.

And the truth is there is a decent chunk of code and tentacles spread
throughout the slab/cgroup code to clone, destroy, and handle the
split caches, as well as the branches/indirections on every cgrouped
slab allocation.

Yet there is no good explanation for why things are done this way
anywhere in the changelog, the cover letter, or the code. And it's
hard to get a satisfying answer even to direct questions about it.

Forget about how anything was before your patches and put yourself
into the shoes of somebody who comes at the new code without any
previous knowledge. "It was even worse before" just isn't a satisfying
answer.

> > And these two things are the primary aspects that make my head hurt
> > trying to review this patch series.
> > 
> > > So IMO it's an interesting direction to explore, but not something
> > > that necessarily has to be done in the context of this patchset.
> > 
> > I disagree. Instead of replacing the old coherent model and its
> > complexities with a new coherent one, you are mixing the two. And I
> > can barely understand the end result.
> > 
> > Dynamically cloning entire slab caches for the sole purpose of telling
> > whether the pages have an obj_cgroup array or not is *completely
> > insane*. If the controller had followed the obj_cgroup design from the
> > start, nobody would have ever thought about doing it like this.
> 
> It's just not true. The whole point of having root- and memcg sets is
> to be able to not look for a NULL pointer in the obj_cgroup vector on
> releasing of the root object. In other words, it allows to keep zero
> overhead for root allocations. IMHO it's an important thing, and calling
> it *completely insane* isn't the best way to communicate.

But you're trading it for the indirection of going through a separate
kmem_cache for every single cgroup-accounted allocation. Why is this a
preferable trade-off to make?

I'm asking basic questions about your design choices. It's not okay to
dismiss this with "it's an interesting direction to explore outside
the context this patchset".

> > From a maintainability POV, we cannot afford merging it in this form.
> 
> It sounds strange: the patchset eliminates 90% of the complexity,
> but it's unmergeable because there are 10% left.

No, it's unmergeable if you're unwilling to explain and document your
design choices when somebody who is taking the time and effort to look
at your patches doesn't understand why things are the way they are.

We are talking about 1500 lines of complicated core kernel code. They
*have* to make sense to people other than you if we want to have this
upstream.

> I agree that it's an arguable question if we can tolerate some
> additional overhead on root allocations to eliminate these additional
> 10%, but I really don't think it's so obvious that even discussing
> it is insane.

Well that's exactly my point.

> Btw, there is another good idea to explore (also suggested by Christopher
> Lameter): we can put memcg/objcg pointer into the slab page, avoiding
> an extra allocation.

I agree with this idea, but I do think that's a bit more obviously in
optimization territory. The objcg is much larger than a pointer to it,
and it wouldn't significantly change the alloc/free sequence, right?

Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72579C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4460F20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwcQeZtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEONo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgEONo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:44:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529E5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:44:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u15so2314525ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQZCcj+2JGTArdtmPobmCtQJjTTWbjUcr2DcXN7Bysk=;
        b=bwcQeZtvBT3ap8qSUelaXtkjqURtDK5YcwFZzgcqAgSRVcOkFMG5yGPE3TtE6wzG7m
         4md+3sb7p7V3v/G+O9IQ2N+yCfuKfOjZb++cX7f0PHWHkNV0WdfJ7LtnFac8/YevP94m
         GApLJt9dk/ILL20YUAo40ph7QY7oMe/UkMPnQpf+9hk6LFOtAGuG8y9MUm81qsHXFCfM
         orlyEE330bK4FFvOAOcEbBw8dVrabURiFe/LxJoSShaobqKdSkCIlIkHf9zjU6VEFXZN
         yDYbTRYjc5ujLi8DMoIxvGrXee2VIZgv/VYCEq/Qj3jkBVg1+opR1mPkZFG04US7RoQD
         zr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQZCcj+2JGTArdtmPobmCtQJjTTWbjUcr2DcXN7Bysk=;
        b=lKJuF18ZNnY1ml+5XIklcCzSgrQnd6CpxNfK4LBHihTAjdi15EG8oPA46ZQkGPMd49
         FO192phzsAhXHgm8ID6819q/S4F3QM81HwIfkqKdML+OJzTGB3t3ggt0m3dPPdZieCrv
         5UhqLO+sKMDwq377gOB3h9PT/iTjA65I6FanzSIsOP6KfD9EfGEGdCEAamaRHqFhGsiT
         v0pKLeWpIvAPa+W9PnrQ7IMBpUDa1ZnDvmXjjX82OAsjWy75blkkurw7jlftP2DZiXwT
         ioVItPp8puk9zcgDvmQYE6Janho1cCPcUDF68Es9eQpKrrLrQjkzE6o2LhO7DpmJWmZi
         q6hw==
X-Gm-Message-State: AOAM532hC8plA1GOZD7xWGK9PticNrTOR4GJJhmeQej/LYda8RHOPDGa
        VVUlnQxRa3lrWjZFuvHLjx28x1IjbALQSMKB+T2nXA==
X-Google-Smtp-Source: ABdhPJy4axkqYK5Ps1y4CemlDYwXND6nG68gA6azFpJh3sKJsMxHGHKkm+IZyiZgCuvlFQtsIKx5GlaOidGcZErf2eQ=
X-Received: by 2002:a2e:b0c8:: with SMTP id g8mr73575ljl.270.1589550295489;
 Fri, 15 May 2020 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200508170630.94406-1-shakeelb@google.com> <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
 <20200515082955.GJ29153@dhcp22.suse.cz> <20200515132421.GC591266@cmpxchg.org>
In-Reply-To: <20200515132421.GC591266@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 May 2020 06:44:44 -0700
Message-ID: <CALvZod7SdgXv0Dmm3q5H=EH4dzg8pXZenMUaDObfoRv5EX-Pkw@mail.gmail.com>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 6:24 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 15, 2020 at 10:29:55AM +0200, Michal Hocko wrote:
> > On Sat 09-05-20 07:06:38, Shakeel Butt wrote:
> > > On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > > > > One way to measure the efficiency of memory reclaim is to look at the
> > > > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > > > not updated consistently at the system level and the ratio of these are
> > > > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > > > reclaim while pgrefill gets updated for global as well as cgroup
> > > > > reclaim.
> > > > >
> > > > > Please note that this difference is only for system level vmstats. The
> > > > > cgroup stats returned by memory.stat are actually consistent. The
> > > > > cgroup's pgsteal contains number of reclaimed pages for global as well
> > > > > as cgroup reclaim. So, one way to get the system level stats is to get
> > > > > these stats from root's memory.stat, so, expose memory.stat for the root
> > > > > cgroup.
> > > > >
> > > > >       from Johannes Weiner:
> > > > >       There are subtle differences between /proc/vmstat and
> > > > >       memory.stat, and cgroup-aware code that wants to watch the full
> > > > >       hierarchy currently has to know about these intricacies and
> > > > >       translate semantics back and forth.
> >
> > Can we have those subtle differences documented please?
> >
> > > > >
> > > > >       Generally having the fully recursive memory.stat at the root
> > > > >       level could help a broader range of usecases.
> > > >
> > > > The changelog begs the question why we don't just "fix" the
> > > > system-level stats. It may be useful to include the conclusions from
> > > > that discussion, and why there is value in keeping the stats this way.
> > > >
> > >
> > > Right. Andrew, can you please add the following para to the changelog?
> > >
> > > Why not fix the stats by including both the global and cgroup reclaim
> > > activity instead of exposing root cgroup's memory.stat? The reason is
> > > the benefit of having metrics exposing the activity that happens
> > > purely due to machine capacity rather than localized activity that
> > > happens due to the limits throughout the cgroup tree. Additionally
> > > there are userspace tools like sysstat(sar) which reads these stats to
> > > inform about the system level reclaim activity. So, we should not
> > > break such use-cases.
> > >
> > > > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > >
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > Thanks a lot.
> >
> > I was quite surprised that the patch is so simple TBH. For some reason
> > I've still had memories that we do not account for root memcg (likely
> > because mem_cgroup_is_root(memcg) bail out in the try_charge. But stats
> > are slightly different here.
>
> Yep, we skip the page_counter for root, but keep in mind that cgroup1
> *does* have a root-level memory.stat, so (for the most part) we've
> been keeping consumer stats for the root level the whole time.
>
> > counters because they are not really all the same. E.g.
> > - mem_cgroup_charge_statistics accounts for each memcg
>
> Yep, that's heritage from cgroup1.
>
> > - memcg_charge_kernel_stack relies on pages being associated with a
> >   memcg and that in turn relies on __memcg_kmem_charge_page which bails
> >   out on root memcg
>
> You're right. It should only bypass the page_counter, but still set
> page->mem_cgroup = root_mem_cgroup, just like user pages.
>
> This counter also doesn't get exported on cgroup1, so it would indeed
> be a new bug. It needs to be fixed before this patch here.
>
> > - memcg_charge_slab (NR_SLAB*) skips over root memcg as well
>
> Same thing with these two.

Yes, we skip page_counter for root but not the stats. I will go over
all the stats and make sure we are not skipping the stats for root.

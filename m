Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD28A2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrZQX7GJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgGJTTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgGJTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:19:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88426C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:19:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r19so7649147ljn.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+/ZpUV9Tne4bK1xpzXtQG1xnjDQvm0MBQHRZpe8AKo=;
        b=SrZQX7GJ/Kzlw7h1SoI4rLoG7YGWqAT/kts4Om0DARGMfvQ+gkwU91XHLDByWaZPKr
         IoYy4s39ckACTY2bkjVyoBhXim+W3EULp1zDxw6MMTAeKt9oTeFxWHogTuPIvA8iXUDw
         Zczvd4dOYsYW1xQZz4YXUbxDyYS3XHJWc89DzZRjAfGNrqq+9P563ReWl16DhDZQL51V
         9Yspg+SEe7+FbfqOWkkMymkTEuxTqEx9tUplIbsBELrvMgRsd9LFGZTl9sjshweklDQn
         M+nVoOCtjCNi558ol0/dG/X9JBVZyEu5AVsAsr88olD3n7pfKtPVsEBZRtwQ/JIAqNCJ
         1Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+/ZpUV9Tne4bK1xpzXtQG1xnjDQvm0MBQHRZpe8AKo=;
        b=IjBPlgxlzqboYRAu+0zSj2VU18QRcu/iEngOB7MIyY6KgX4DxawShki6vLDCR96d0Y
         cJIQSJ3riBttX378+VS3ENFvAzvc+E3ROvyZX/5NKBz9M+nWviYpyI+SLO9DLFS9qq8N
         AQA6moGf2Ut/l9XZMy3yhi4ENDHULPn7lA/jkqXEqQqCKwNgC/RjEaZovm2vkF+Dap8q
         tPJ3eWoujOPt/9mk0beF6Gp9VhvyG07dwtVZc4j8VBdeDlqh/J94DmmQfHPEWcIvRSLa
         Iy6sw5zbQ/3Qn3d3JcBuTwfPluf7aflT+V38eyUyKQEnzTzlMOfSd/kLTNUpeXWnc2vl
         5stg==
X-Gm-Message-State: AOAM533ul2H6v01YUOVRGmL24d+Ix/upSo0h73AmqBn5hw/pRJvAzb5a
        PG2Hs2DZMCGsX4gSS+xAMBoEkvSwZ1v0ursTaE6R+g==
X-Google-Smtp-Source: ABdhPJzFoBkdGox40ei+klbQof0Gx0aadBK6ptgvGIgeyE4rH15dG1JqNPii8/FCJemts6XHE9l+BcstW37Cp3UGcYM=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr3900690lji.446.1594408788744;
 Fri, 10 Jul 2020 12:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200709194718.189231-1-guro@fb.com> <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com> <20200710184205.GB350256@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200710184205.GB350256@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jul 2020 12:19:37 -0700
Message-ID: <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering memory.high
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:42 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Jul 10, 2020 at 07:12:22AM -0700, Shakeel Butt wrote:
> > On Fri, Jul 10, 2020 at 5:29 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> > > > Memory.high limit is implemented in a way such that the kernel
> > > > penalizes all threads which are allocating a memory over the limit.
> > > > Forcing all threads into the synchronous reclaim and adding some
> > > > artificial delays allows to slow down the memory consumption and
> > > > potentially give some time for userspace oom handlers/resource control
> > > > agents to react.
> > > >
> > > > It works nicely if the memory usage is hitting the limit from below,
> > > > however it works sub-optimal if a user adjusts memory.high to a value
> > > > way below the current memory usage. It basically forces all workload
> > > > threads (doing any memory allocations) into the synchronous reclaim
> > > > and sleep. This makes the workload completely unresponsive for
> > > > a long period of time and can also lead to a system-wide contention on
> > > > lru locks. It can happen even if the workload is not actually tight on
> > > > memory and has, for example, a ton of cold pagecache.
> > > >
> > > > In the current implementation writing to memory.high causes an atomic
> > > > update of page counter's high value followed by an attempt to reclaim
> > > > enough memory to fit into the new limit. To fix the problem described
> > > > above, all we need is to change the order of execution: try to push
> > > > the memory usage under the limit first, and only then set the new
> > > > high limit.
> > >
> > > Shakeel would this help with your pro-active reclaim usecase? It would
> > > require to reset the high limit right after the reclaim returns which is
> > > quite ugly but it would at least not require a completely new interface.
> > > You would simply do
> > >         high = current - to_reclaim
> > >         echo $high > memory.high
> > >         echo infinity > memory.high # To prevent direct reclaim
> > >                                     # allocation stalls
> > >
> >
> > This will reduce the chance of stalls but the interface is still
> > non-delegatable i.e. applications can not change their own memory.high
> > for the use-cases like application controlled proactive reclaim and
> > uswapd.
>
> Can you, please, elaborate a bit more on this? I didn't understand
> why.
>

Sure. Do we want memory.high a CFTYPE_NS_DELEGATABLE type file? I
don't think so otherwise any job on a system can change their
memory.high and can adversely impact the isolation and memory
scheduling of the system.

Next we have to agree that there are valid use-cases to allow
applications to reclaim from their cgroups and I think uswapd and
proactive reclaim are valid use-cases. Let's suppose memory.high is
the only way to trigger reclaim but the application can not write to
their top level memory.high, so, it has to create a dummy cgroup of
which it has write access to memory.high and has to move itself to
that dummy cgroup to use memory.high to trigger reclaim for
uswapd/proactive-reclaim.

Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5ADC3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270562067D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dZNCxSNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404938AbgBNQxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:53:19 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:36541 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389160AbgBNQxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:53:16 -0500
Received: by mail-pl1-f179.google.com with SMTP id a6so3942139plm.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x8BCXrO9eJtgPAUB6vuqATbB26XX9eqm0jHFKZb49U4=;
        b=dZNCxSNcXxB3bE0nh2CIFgPidqOGS4EBZ8YazqoEarxcUhdXayrcd2R8ADOkZ0grM7
         ipSHDbCdoilwRvdUPApZTJu5Ye2q8HKguTDuPYXIpXK9prusKzJpoSQgXRrqA/VO6Nx7
         ep1bUDEc92yfLUBDYBdmMlyFHgUQ9t3FDGG21Yy8Vnf1BwOv0XiyNc0QShGu7Clmg6gp
         kOba/wVrWzmKUp83KRnLXgCbRgbzcsWAE3mJBeDm1i6BhzAisG7sjPCLPS1xV8ed3rVJ
         JpOS7/nP/htUnf7beVfOkcDQEme6MwJoXEjzj7XhvSHNmmL4tLeLmG7oRcmal3lgSkmx
         f03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8BCXrO9eJtgPAUB6vuqATbB26XX9eqm0jHFKZb49U4=;
        b=TCrsvdN55xyNC9YevEhTnY2jU80UuFVXGeLiSCyK9luyeiVtCVTgfBsvCKzGNPdVmA
         dyNFje6QA7fuypKItlfx8X8yNsMMLtjzJGrSPEgiQTs/RnN3xICu6JaEYGcWO6piSU3m
         tY98Dm3NgFDWu7GTnX/kqCQqcp6J2TcGd2td2myk9KxvV89ihAzNi4FKQS4yOBf734sA
         ItAFj1eyeIx8WncrXTJ5kMwmWUB4hbPp1z6DZDEUVVgrOrMi2Wv84olggu5oPEXiGxi6
         fVnLmiKXvsjog2/9nTaQxcCcQiyaLCQHuxLJ1WBOHnWHY7KdaUDubOfQeM6DY9m/lhNI
         e3+g==
X-Gm-Message-State: APjAAAUCPUxrIpiVCoCzpZnBoR9QI1l1uDSTY4fC9FYUhEpCGXH8AwV/
        nR/snZBY2hol0t4OoVpVohB3xCixDcU=
X-Google-Smtp-Source: APXvYqw6D3Kv+/KVVTiDcIt4WSaVRWfPeQMnhLCAMqIqF6NZlvA1h/Vu+XbPS10PBQAUsWd9kIr6Wg==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr4717269pjb.33.1581699195004;
        Fri, 14 Feb 2020 08:53:15 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::31db])
        by smtp.gmail.com with ESMTPSA id q7sm7661921pgk.62.2020.02.14.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 08:53:14 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:53:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200214165311.GA253674@cmpxchg.org>
References: <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
 <20200214151318.GC31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214151318.GC31689@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:13:18PM +0100, Michal Hocko wrote:
> On Fri 14-02-20 08:57:28, Tejun Heo wrote:
> [...]
> 
> Sorry to skip over a large part of your response. The discussion in this
> thread got quite fragmented already and I would really like to conclude
> to something.
> 
> > > I believe I have already expressed the configurability concern elsewhere
> > > in the email thread. It boils down to necessity to propagate
> > > protection all the way up the hierarchy properly if you really need to
> > > protect leaf cgroups that are organized without a resource control in
> > > mind. Which is what systemd does.
> > 
> > But that doesn't work for other controllers at all. I'm having a
> > difficult time imagining how making this one control mechanism work
> > that way makes sense. Memory protection has to be configured together
> > with IO protection to be actually effective.
> 
> Please be more specific. If the protected workload is mostly in-memory,
> I do not really see how IO controller is relevant. See the example of
> the DB setup I've mentioned elsewhere.

Say you have the following tree:

                         root
                       /     \
               system.slice  user.slice
               /    |           |
           cron  journal     user-100.slice
                                |
                             session-c2.scope
                                |          \
                             the_workload  misc

You're saying you want to prioritize the workload above everything
else in the system: system tasks, other users' stuff, even other stuff
running as your own user. Therefor you configure memory.low on the
workload and propagate the value up the tree. So far so good, memory
is protected.

However, what you've really done just now is flattened the resource
hierarchy. You configured the_workload not just more important than
its sibling "misc", but you actually pulled it up the resource tree
and declared it more important than what's running in other sessions,
what users are running, and even the system software. Your cgroup tree
still reflects process ownership, but it doesn't actually reflect the
resource hierarchy you just configured.

And that is something that other controllers do not support: you
cannot give IO weight to the_workload without also making the c2
session more important than other sessions, user 100 more important
than other users, and user.slice more important than system.slice.

Memory is really the only controller in which this kind of works.

And yes, maybe you're talking about a highly specific case where
the_workload is mostly in memory and also doesn't need any IO capacity
and you have CPU to spare, so this is good enough for you and you
don't care about the other controllers in that particular usecase.

But the discussion is about the broader approach to resource control:
if other controllers already require the cgroup hierarchy to reflect
resource hierarchy, memory shouldn't be different just because.

And in practice, most workloads *do* in fact need comprehensive
control. Which workload exclusively needs memory, but no IO, and no
CPU? If you only control for memory, lower priority workloads tend to
eat up your CPU doing reclaim and your IO doing paging.

So when talking about the design and semantics of one controller, you
have to think about this comprehensively.

The proper solution to implement the kind of resource hierarchy you
want to express in cgroup2 is to reflect it in the cgroup tree. Yes,
the_workload might have been started by user 100 in session c2, but in
terms of resources, it's prioritized over system.slice and user.slice,
and so that's the level where it needs to sit:

                               root
                       /        |                 \
               system.slice  user.slice       the_workload
               /    |           |
           cron  journal     user-100.slice
                                |
                             session-c2.scope
                                |
                             misc

Then you can configure not just memory.low, but also a proper io
weight and a cpu weight. And the tree correctly reflects where the
workload is in the pecking order of who gets access to resources.

> > As for cgroup hierarchy being unrelated to how controllers behave, it
> > frankly reminds me of cgroup1 memcg flat hierarchy thing I'm not sure
> > how that would actually work in terms of resource isolation. Also, I'm
> > not sure how systemd forces such configurations and I'd think systemd
> > folks would be happy to fix them if there are such problems. Is the
> > point you're trying to make "because of systemd, we have to contort
> > how memory controller behaves"?
> 
> No, I am just saying and as explained in reply to Johannes, there are
> practical cases where the cgroup hierarchy reflects organizational
> structure as well.

There is nothing wrong with that, and systemd does it per default. But
it also doesn't enable resource control domains per default.

Once you do split up resource domains, you cannot express both
hierarchies in a single tree. And cgroup2 controllers are designed
such that resource domain hierarchy takes precedence.

It's perfectly fine to launch the workload in a different/new resource
domain. This doesn't conflict with systemd, and is in fact supported
by it. See the Slice= attribute (systemd.resource_control(5)).

Sure you need to be privileged to do this, but you also need to be
privileged to set memory.low on user.slice...

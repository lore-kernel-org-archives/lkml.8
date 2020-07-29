Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4991C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CC92083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v23BGnv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgG2Pbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Pbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:31:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8B4C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:31:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s16so10288218ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMeyNl/YEFo9jsdBtV0Ewno5/AetGS5V1mo5zWRK34w=;
        b=v23BGnv5jqHqaVKTCmWas4+MNmFdeSPsoMW6klb2HNXQESBQg0J336Elj73Cq47tVl
         2wdAwaOHf3IZQUvS8LiC3w72kCrGGxNdzpe/pet54t/U+/LSEmP8PGVd5KMJpvMPCveU
         jm1/hThjiCiAuaEjpJblZLDjXSMqRfMG2+NkajW77QszAevSZS58PQqhSpF0FfLDLlFy
         IFbS6kT7RdNFPyZ6gma06J+JEk9vln93SNCP4ifs4fE9D9+Y31rCVFUi9n/XfiUKGtqB
         8JMvXNWZe/L//xR4Kh/+go+TWtSh954Qkm287V5y47Gz4VWNajlzZJPnjQNesHu7Ty7O
         QlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMeyNl/YEFo9jsdBtV0Ewno5/AetGS5V1mo5zWRK34w=;
        b=tMkeEX7T2qFfHVSyjyXGJAz41lt9fA+o5/OwbeJQuxhAdLfEW3MBjA7YBenI4htsVC
         wC1Qv8IeNN52LBc5OM02jiXRUfskX5eIj7P5IWG4GGsj9fI1cQS/ZAluGBdv8h+hoOIA
         qSl80i6cHDEGm6i5HgpcJmnjW3S/U9lhiSH/tE5Of3ORbx8ryqNGxEOsKCLQKl+Vfnid
         S8o8sFNW+MiTiJX9hNv6YDSj9bs76fNjLc5umOSAkMJoR5Rc6KWgUcD8o+pVE8+Ukd5s
         kZ9Dlhh9a7nrktEgmvPwqQZQySfsXcRFooTu03BsfZG7ktB5JrO6ym89fUA9/SpjghHX
         Cogg==
X-Gm-Message-State: AOAM532P9g3K/4IXa3wZNoaFNrO6QrhOBMEm4Bf5tL+eFIRp6gG/3Fw4
        oR6aRuhLQRawC0SuhdrXVwZ4kLnMaKRdDomzn69ERg==
X-Google-Smtp-Source: ABdhPJyI8qc29rns9dXHG0oc0JEPnWfGWcNX+IOeYkGrx2a1w2l5uUMoZHmTpRWS/l/JTn89UMDlJsEwRgpcw7m8Y6g=
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr6264537ljf.58.1596036701488;
 Wed, 29 Jul 2020 08:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7MZaE52408O6eGNpGGW77xFTyr56YK0F7qjNH1HX98MQ@mail.gmail.com>
 <20200718133106.4787-1-sjpark@amazon.com>
In-Reply-To: <20200718133106.4787-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 29 Jul 2020 08:31:29 -0700
Message-ID: <CALvZod6cd4698njE+_dQ6UiL=uRL9xm=aKVm5=-sV28T9Y+fVw@mail.gmail.com>
Subject: Re: Re: [PATCH v18 02/14] mm: Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Ian Rogers <irogers@google.com>,
        jolsa@redhat.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
        mark.rutland@arm.com, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, rppt@kernel.org,
        sblbir@amazon.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 6:31 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> On Fri, 17 Jul 2020 19:47:50 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > On Mon, Jul 13, 2020 at 1:43 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > DAMON is a data access monitoring framework subsystem for the Linux
> > > kernel.  The core mechanisms of DAMON make it
> > >
> > >  - accurate (the monitoring output is useful enough for DRAM level
> > >    memory management; It might not appropriate for CPU Cache levels,
> > >    though),
> > >  - light-weight (the monitoring overhead is low enough to be applied
> > >    online), and
> > >  - scalable (the upper-bound of the overhead is in constant range
> > >    regardless of the size of target workloads).
> > >
> > > Using this framework, therefore, the kernel's memory management
> > > mechanisms can make advanced decisions.  Experimental memory management
> > > optimization works that incurring high data accesses monitoring overhead
> > > could implemented again.  In user space, meanwhile, users who have some
> > > special workloads can write personalized applications for better
> > > understanding and optimizations of their workloads and systems.
> > >
> > > This commit is implementing only the stub for the module load/unload,
> > > basic data structures, and simple manipulation functions of the
> > > structures to keep the size of commit small.  The core mechanisms of
> > > DAMON will be implemented one by one by following commits.
> > >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > > Reviewed-by: Varad Gautam <vrd@amazon.de>
> > > ---
> > >  include/linux/damon.h |  63 ++++++++++++++
> > >  mm/Kconfig            |  12 +++
> > >  mm/Makefile           |   1 +
> > >  mm/damon.c            | 188 ++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 264 insertions(+)
> > >  create mode 100644 include/linux/damon.h
> > >  create mode 100644 mm/damon.c
> > >
> > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > new file mode 100644
> > > index 000000000000..c8f8c1c41a45
> > > --- /dev/null
> > > +++ b/include/linux/damon.h
> > > @@ -0,0 +1,63 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * DAMON api
> > > + *
> > > + * Copyright 2019-2020 Amazon.com, Inc. or its affiliates.
> > > + *
> > > + * Author: SeongJae Park <sjpark@amazon.de>
> > > + */
> > > +
> [...]
> > > +
> > > +/**
> > > + * struct damon_task - Represents a monitoring target task.
> > > + * @pid:               Process id of the task.
> > > + * @regions_list:      Head of the monitoring target regions of this task.
> > > + * @list:              List head for siblings.
> > > + *
> > > + * If the monitoring target address space is task independent (e.g., physical
> > > + * memory address space monitoring), @pid should be '-1'.
> > > + */
> > > +struct damon_task {
> > > +       int pid;
> >
> > Storing and accessing pid like this is racy. Why not save the "struct
> > pid" after getting the reference? I am still going over the usage,
> > maybe storing mm_struct would be an even better choice.
> >
> > > +       struct list_head regions_list;
> > > +       struct list_head list;
> > > +};
> > > +
> [...]
> > > +
> > > +#define damon_get_task_struct(t) \
> > > +       (get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
> >
> > You need at least rcu lock around find_vpid(). Also you need to be
> > careful about the context. If you accept my previous suggestion then
> > you just need to do this in the process context which is registering
> > the pid (no need to worry about the pid namespace).
> >
> > I am wondering if there should be an interface to register processes
> > with DAMON using pidfd instead of integer pid.
>
> Good points!  I will use pidfd for this purpose, instead.
>
> BTW, 'struct damon_task' was introduced while DAMON supports only virtual
> address spaces and recently extended to support physical memory address
> monitoring case by defining an exceptional pid (-1) for such case.  I think it
> doesn't smoothly fit with the design.
>
> Therefore, I would like to change it with more general named struct, e.g.,
>
>     struct damon_target {
>             void *id;
>             struct list_head regions_list;
>             struct list_head list;
>     };
>
> The 'id' field will be able to store or point pid_t, struct mm_struct, struct
> pid, or anything relevant, depending on the target address space.
>
> Only one part of the address space independent logics of DAMON, namely
> 'kdamon_need_stop()', uses '->pid' of the 'struct damon_task'.  It will be
> introduced by the next patch ("mm/damon: Implement region based sampling").
> Therefore, the conversion will be easy.  For the part, I could add another
> callback, e.g.,
>
>     struct damon_ctx {
>             [...]
>             bool (*is_target_valid)(struct damon_target *t);
>     };
>
> And let the address space specific primitives to implement this.
>
> Then, damon_get_task_struct() and damon_get_mm() will be introduced by the
> sixth patch ("mm/damon: Implement callbacks for the virtual memory address
> spaces") as a part of the virtual address space specific primitives
> implementation.
>
> I gonna make the change in the next spin.  If you have some opinions on this,
> please let me know.
>
>

Sorry for the late response. I think the general direction you are
taking is fine but there are still some open questions. I am trying to
reason if 'address space' is general enough abstraction for different
types of monitoring targets. It fits well for the 'processes' targets.
For the physical memory, the monitoring part of the abstraction (i.e.
damon_ctx) seems fine but I am not sure about the optimization part
(i.e. [merge|split]_regions) which raises the question that should the
merge/split functionality be part of the abstraction.

I am also very interested in the 'cgroups' as the target and I am not
sure if 'address space' is the right abstraction for the cgroups as
well. Well we can think of cgroups as a combination of tasks but
cgroup also contains unmapped pages. So, maybe it is a combination of
virtual and physical address space targets damon can monitor but I am
still not clear how to specify that in the abstractions provided by
damon. Anyways these are the questions for later and we can start
simple with just processes but I would like to not expose these
abstractions/interfaces to userspace otherwise it would be really hard
to change later.

Another topic I want to discuss is managing/charging the resource
(cpu) usage of monitoring. Yes, damon with optimization has low cpu
cost but as the number of targets increase the cpu cost will increase
which will be in a range which can not be ignored as system overhead.
At the moment, it seems like there is one kthread doing all the
monitoring, since we can control the cpu usage of kthreads, it might
make sense to allow different kthreads for different sets of targets
(processes in a cgroup).

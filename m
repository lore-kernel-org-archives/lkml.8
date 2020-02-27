Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66935C4BA37
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55524679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZwEf35I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgB0Cmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:42:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38778 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgB0Cmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:42:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id 2so636739oiz.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 18:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OW5v2P+LSdHS4v5JcggrkJ7ZUtwIkEYZFO52ZY5VGhU=;
        b=PZwEf35I/dEgIcHg7QsSUzFVC1TKdWeDTasub32dGzCUNVtHmsL2qWWMKq4nLAyPep
         Sso4gaGlQ1Q4o1C6g5aPZFe4BLCkXTsW2kN2daVqgyBSuoPdxU8jmWtgMiJOXPZmMh7Y
         Vdh6qmLRYKjSaZBQzsIfDjsuVmWOnwXN0Qor9kbInMYLgANjfcQ2CU7erbCTXd4GZOP2
         ln1Wt1vdCXw6FgGvczZpXfS6ZuWYNMmI4s46VMls5az78DDJEPxDNRl40hfddrlU8bve
         1S0eSQ5qE65sHmpxws2y5xxNfOlz0CRsi4BXWrwh5h4BO3zQlBZrr+H5srPkRCvGXRAI
         kZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OW5v2P+LSdHS4v5JcggrkJ7ZUtwIkEYZFO52ZY5VGhU=;
        b=evqlHn7fmH6LFKapGL+LJe5qHiXd7Xsf5MlmNNNtmr4A6OMnaEnUkIaMk639bTGzHV
         uYPMzjeB8cOMQBL89/G1yQ1zvoZejpoZIIAJUbUCpLqZEseByoqhfGeK9EKifzXO9KFi
         joMiCPuX5MUpGdTx2XuOzlTSK94+yPT7APsx0xH6RbHJaikUpdeo2pZHMosVhG3Xui+7
         huAqjPFzAyUP7kWya48x0bIr2gas+WjudUp2JprKkelAD2NQR6k3V8t3FnfuW9koHgVh
         hV569s5Id4dnYjdk5hJ81lDamB+DpbQZltUnIppysacWC4dK2AI3V56zjE500OTeNro2
         GfDw==
X-Gm-Message-State: APjAAAWW2O0FEyQUVYd2JV5Hsivi9bMB/5YwhyH/7XWfXGzlXRcIwosv
        TeoTYQHd6ZjLGUaIFq1e2GzKe4FSJo3OqrXNvd13G11p
X-Google-Smtp-Source: APXvYqzzMJQhWRv/aSoVqGACRnlVtYLnJqQhlD8EjJDn+1jzgHxok24dzWDYsCA8FSKGt2hLnfPr6eoH5BN9elAZnfU=
X-Received: by 2002:aca:4183:: with SMTP id o125mr1608610oia.125.1582771369059;
 Wed, 26 Feb 2020 18:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20200219181219.54356-1-hannes@cmpxchg.org> <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
 <20200226222642.GB30206@cmpxchg.org> <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
In-Reply-To: <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Feb 2020 18:42:37 -0800
Message-ID: <CALvZod6xA4CXP5njy18LcxDx255M4zwVvzZ48E-sMcWpJ_LhGg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 4:12 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 2/26/20 2:26 PM, Johannes Weiner wrote:
> > On Wed, Feb 26, 2020 at 12:25:33PM -0800, Shakeel Butt wrote:
> >> On Wed, Feb 19, 2020 at 10:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >>> We have received regression reports from users whose workloads moved
> >>> into containers and subsequently encountered new latencies. For some
> >>> users these were a nuisance, but for some it meant missing their SLA
> >>> response times. We tracked those delays down to cgroup limits, which
> >>> inject direct reclaim stalls into the workload where previously all
> >>> reclaim was handled my kswapd.
> >>>
> >>> This patch adds asynchronous reclaim to the memory.high cgroup limit
> >>> while keeping direct reclaim as a fallback. In our testing, this
> >>> eliminated all direct reclaim from the affected workload.
> >>>
> >>> memory.high has a grace buffer of about 4% between when it becomes
> >>> exceeded and when allocating threads get throttled. We can use the
> >>> same buffer for the async reclaimer to operate in. If the worker
> >>> cannot keep up and the grace buffer is exceeded, allocating threads
> >>> will fall back to direct reclaim before getting throttled.
> >>>
> >>> For irq-context, there's already async memory.high enforcement. Re-use
> >>> that work item for all allocating contexts, but switch it to the
> >>> unbound workqueue so reclaim work doesn't compete with the workload.
> >>> The work item is per cgroup, which means the workqueue infrastructure
> >>> will create at maximum one worker thread per reclaiming cgroup.
> >>>
> >>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >>> ---
> >>>   mm/memcontrol.c | 60 +++++++++++++++++++++++++++++++++++++------------
> >>>   mm/vmscan.c     | 10 +++++++--
> >> This reminds me of the per-memcg kswapd proposal from LSFMM 2018
> >> (https://lwn.net/Articles/753162/).
> > Ah yes, I remember those discussions. :)
> >
> > One thing that has changed since we tried to implement this last was
> > the workqueue concurrency code. We don't have to worry about a single
> > thread or fixed threads per cgroup, because the workqueue code has
> > improved significantly to handle concurrency demands, and having one
> > work item per cgroup makes sure we have anywhere between 0 threads and
> > one thread per cgroup doing this reclaim work, completely on-demand.
>
> Yes, exactly. Our in-house implementation was just converted to use
> workqueue instead of dedicated kernel thread for each cgroup.
>
> >
> > Also, with cgroup2, memory and cpu always have overlapping control
> > domains, so the question who to account the work to becomes a much
> > easier one to answer.
> >
> >> If I understand this correctly, the use-case is that the job instead
> >> of direct reclaiming (potentially in latency sensitive tasks), prefers
> >> a background non-latency sensitive task to do the reclaim. I am
> >> wondering if we can use the memory.high notification along with a new
> >> memcg interface (like memory.try_to_free_pages) to implement a user
> >> space background reclaimer. That would resolve the cpu accounting
> >> concerns as the user space background reclaimer can share the cpu cost
> >> with the task.
> > The idea is not necessarily that the background reclaimer is lower
> > priority work, but that it can execute in parallel on a separate CPU
> > instead of being forced into the execution stream of the main work.
> >
> > So we should be able to fully resolve this problem inside the kernel,
> > without going through userspace, by accounting CPU cycles used by the
> > background reclaim worker to the cgroup that is being reclaimed.
>
> Actually I'm wondering if we really need account CPU cycles used by
> background reclaimer or not. For our usecase (this may be not general),
> the purpose of background reclaimer is to avoid latency sensitive
> workloads get into direct relcaim (avoid the stall from direct relcaim).
> In fact it just "steal" CPU cycles from lower priority or best-effort
> workloads to guarantee latency sensitive workloads behave well. If the
> "stolen" CPU cycles are accounted, it means the latency sensitive
> workloads would get throttled from somewhere else later, i.e. by CPU share.
>
> We definitely don't want to the background reclaimer eat all CPU cycles.
> So, the whole background reclaimer is opt in stuff. The higher level
> cluster management and administration components make sure the cgroups
> are setup correctly, i.e. enable for specific cgroups, setup watermark
> properly, etc.
>
> Of course, this may be not universal and may be just fine for some
> specific configurations or usecases.
>

IMHO this makes a very good case for user space background reclaimer.
We have much more flexibility to run that reclaimer in the same cgroup
whose memory its reclaiming (i.e. sharing cpu quota) or maybe in a
separate cgroup with stolen CPU from best effort or low priority jobs.

Shakeel

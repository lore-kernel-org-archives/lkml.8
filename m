Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34298C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA4E20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKF0pVSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgEGRuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:50:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36497 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588873806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=isKMmPB0uJvXQWR9LP8AOc/de3hjqJMm8osrCYq98w4=;
        b=TKF0pVSjPFhY6d61dNOvF09d9CMU4eU+qxv31VNNwvfIPJH4RTmYRXcuzKtnziJnkzXDoe
        +7D/3JVe+lEakbX4KcUhZ3ubyYhT3CihDNJ2b6WEIzl4BbXgn1aLpUriiEuVy8/fBavMsV
        O+2Pf0g93hgjpP7fdAkQALO9lH/GhXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-PaccLmy4PHaFdKaj9tsmuQ-1; Thu, 07 May 2020 13:50:04 -0400
X-MC-Unique: PaccLmy4PHaFdKaj9tsmuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1732107ACF7;
        Thu,  7 May 2020 17:50:02 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-114.phx2.redhat.com [10.3.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFCD3708EA;
        Thu,  7 May 2020 17:49:36 +0000 (UTC)
Date:   Thu, 7 May 2020 13:49:34 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200507174934.GD19331@lorien.usersys.redhat.com>
References: <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net>
 <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net>
 <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:29:44PM +0200 Jirka Hladky wrote:
> Hi Mel,
> 
> we are not targeting just OMP applications. We see the performance
> degradation also for other workloads, like SPECjbb2005 and
> SPECjvm2008. Even worse, it also affects a higher number of threads.
> For example, comparing 5.7.0-0.rc2 against 5.6 kernel, on 4 NUMA
> server with 2x AMD 7351 CPU, we see performance degradation 22% for 32
> threads (the system has 64 CPUs in total). We observe this degradation
> only when we run a single SPECjbb binary. When running 4 SPECjbb
> binaries in parallel, there is no change in performance between 5.6
> and 5.7.
> 
> That's why we are asking for the kernel tunable, which we would add to
> the tuned profile. We don't expect users to change this frequently but
> rather to set the performance profile once based on the purpose of the
> server.
> 
> If you could prepare a patch for us, we would be more than happy to
> test it extensively. Based on the results, we can then evaluate if
> it's the way to go. Thoughts?
>

I'm happy to spin up a patch once I'm sure what exactly the tuning would
effect. At an initial glance I'm thinking it would be the imbalance_min
which is currently hardcoded to 2. But there may be something else...


Cheers,
Phil


> Thanks a lot!
> Jirka
> 
> On Thu, May 7, 2020 at 5:54 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Thu, May 07, 2020 at 05:24:17PM +0200, Jirka Hladky wrote:
> > > Hi Mel,
> > >
> > > > > Yes, it's indeed OMP.  With low threads count, I mean up to 2x number of
> > > > > NUMA nodes (8 threads on 4 NUMA node servers, 16 threads on 8 NUMA node
> > > > > servers).
> > > >
> > > > Ok, so we know it's within the imbalance threshold where a NUMA node can
> > > > be left idle.
> > >
> > > we have discussed today with my colleagues the performance drop for
> > > some workloads for low threads counts (roughly up to 2x number of NUMA
> > > nodes). We are worried that it can be a severe issue for some use
> > > cases, which require a full memory bandwidth even when only part of
> > > CPUs is used.
> > >
> > > We understand that scheduler cannot distinguish this type of workload
> > > from others automatically. However, there was an idea for a * new
> > > kernel tunable to control the imbalance threshold *. Based on the
> > > purpose of the server, users could set this tunable. See the tuned
> > > project, which allows creating performance profiles [1].
> > >
> >
> > I'm not completely opposed to it but given that the setting is global,
> > I imagine it could have other consequences if two applications ran
> > at different times have different requirements. Given that it's OMP,
> > I would have imagined that an application that really cared about this
> > would specify what was needed using OMP_PLACES. Why would someone prefer
> > kernel tuning or a tuned profile over OMP_PLACES? After all, it requires
> > specific knowledge of the application even to know that a particular
> > tuned profile is needed.
> >
> > --
> > Mel Gorman
> > SUSE Labs
> >
> 
> 
> -- 
> -Jirka
> 

-- 


Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4DF20838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WevyCnOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEGQaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:30:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53577 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726308AbgEGQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588868999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7iMCcJ0qsnQwLB3wwMjiGDP/YW9nSq1UVvNlnZHm78=;
        b=WevyCnOpqs1K2QRjJtvprM91QoQRP2Ow6UlHmTioxFiXeXPd+88GoqFl2PoiZyguoDpaqG
        xlD6fn8VRT0uqBUJ8fAuFTNf4kXFlatu1NILPS3+RRNew9wmxsw1aFaOEk90MiE8b5dm+V
        whrdL1tn2JNEPF6t1I8QUw5wq2SJHd0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-_D2I7j4LOeuuVKFW714jXA-1; Thu, 07 May 2020 12:29:57 -0400
X-MC-Unique: _D2I7j4LOeuuVKFW714jXA-1
Received: by mail-ed1-f69.google.com with SMTP id x14so2624863edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 09:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7iMCcJ0qsnQwLB3wwMjiGDP/YW9nSq1UVvNlnZHm78=;
        b=mszSMVu6e4K2mSLcw7I86zT3rNZLAs0gEnaVoDq7/0AY1sQvAmdV/PYSPcs05ugfzD
         561qexuCG3KxVJN1ybWRO6C1GbRXtWp+C5ciyzSWHztTrOsebHnLw7EXxZg9gcH55eqs
         PIjHj0EXJk1Zq5v+ABboi8C1jMCvmtWiV5n3POfSiespE2nvAmIfBh7B2YoFbYV1e1Cq
         fTSfo26LIC0/dYhg4JrRyCwHjNh0ItHjzEhawE2gRZpWzRXeXFSrBY1HW3HVB/NuSEAu
         YvbghwmxVoxQtAU59b6BPCEgdcLmUM+UmiFPGdcXuhMSlC5SndBkPVb29/iV2CaPP9Vy
         tYSw==
X-Gm-Message-State: AGi0PuZVLyNCTbBx+K+j1dJ2lWhcPzTn28njDtAZOkwuOqH9tTcQYU3M
        kRPL2rg0Co9rSiah31bEA7QIU+x8YPfXfy7GmOwdAwIXXw4Rzgcxob2HjcYUgkrDL3OPvMoR4l7
        /b9ZL0mGlVlBBJxhuD6EQZDHIc+J/O2jkWKMvMT12
X-Received: by 2002:a17:907:2069:: with SMTP id qp9mr13369331ejb.137.1588868996404;
        Thu, 07 May 2020 09:29:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypI/tAK72ofsR0W7siiARMS+UqHhSIuek7idqi6/W26qVAvJz1p0lEni/R1zsrh7MCp33PsxHvorkj/Tp1DUTxU=
X-Received: by 2002:a17:907:2069:: with SMTP id qp9mr13369301ejb.137.1588868996149;
 Thu, 07 May 2020 09:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net> <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net> <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
In-Reply-To: <20200507155422.GD3758@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 7 May 2020 18:29:44 +0200
Message-ID: <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

we are not targeting just OMP applications. We see the performance
degradation also for other workloads, like SPECjbb2005 and
SPECjvm2008. Even worse, it also affects a higher number of threads.
For example, comparing 5.7.0-0.rc2 against 5.6 kernel, on 4 NUMA
server with 2x AMD 7351 CPU, we see performance degradation 22% for 32
threads (the system has 64 CPUs in total). We observe this degradation
only when we run a single SPECjbb binary. When running 4 SPECjbb
binaries in parallel, there is no change in performance between 5.6
and 5.7.

That's why we are asking for the kernel tunable, which we would add to
the tuned profile. We don't expect users to change this frequently but
rather to set the performance profile once based on the purpose of the
server.

If you could prepare a patch for us, we would be more than happy to
test it extensively. Based on the results, we can then evaluate if
it's the way to go. Thoughts?

Thanks a lot!
Jirka

On Thu, May 7, 2020 at 5:54 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, May 07, 2020 at 05:24:17PM +0200, Jirka Hladky wrote:
> > Hi Mel,
> >
> > > > Yes, it's indeed OMP.  With low threads count, I mean up to 2x number of
> > > > NUMA nodes (8 threads on 4 NUMA node servers, 16 threads on 8 NUMA node
> > > > servers).
> > >
> > > Ok, so we know it's within the imbalance threshold where a NUMA node can
> > > be left idle.
> >
> > we have discussed today with my colleagues the performance drop for
> > some workloads for low threads counts (roughly up to 2x number of NUMA
> > nodes). We are worried that it can be a severe issue for some use
> > cases, which require a full memory bandwidth even when only part of
> > CPUs is used.
> >
> > We understand that scheduler cannot distinguish this type of workload
> > from others automatically. However, there was an idea for a * new
> > kernel tunable to control the imbalance threshold *. Based on the
> > purpose of the server, users could set this tunable. See the tuned
> > project, which allows creating performance profiles [1].
> >
>
> I'm not completely opposed to it but given that the setting is global,
> I imagine it could have other consequences if two applications ran
> at different times have different requirements. Given that it's OMP,
> I would have imagined that an application that really cared about this
> would specify what was needed using OMP_PLACES. Why would someone prefer
> kernel tuning or a tuned profile over OMP_PLACES? After all, it requires
> specific knowledge of the application even to know that a particular
> tuned profile is needed.
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka


Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F32EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082DC206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdpPWItD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgCLRHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:07:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36576 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbgCLRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584032826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pou48natwVAOL5ibEHgzrpyDUrATr5dT40KwpqtjSdc=;
        b=TdpPWItDIOD2nvS3fqdjTen9yCB2bnuzx35PKxVH2JpKcP+Xdvz8ARrUAPIMUvVykub6qQ
        mstvWo+17pwOaN8x/Mc6qvQUM0VwaWgmHFhXsVCVEx2vesaSGXaHDIVIboMt2IZBelUV70
        nRPww5s28xu0l7081Oy0HpSYgNroLCI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-bvw3th6KP7-PVy15IH6MKg-1; Thu, 12 Mar 2020 13:07:04 -0400
X-MC-Unique: bvw3th6KP7-PVy15IH6MKg-1
Received: by mail-wm1-f71.google.com with SMTP id w12so2124943wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Pou48natwVAOL5ibEHgzrpyDUrATr5dT40KwpqtjSdc=;
        b=LsJjuK5Ifq2EjYkSXvyAThFqXBUNLw5obthDfo0B53AxI1WcgcdrS/ju5iJ38YFi5V
         jRW/yQbUqPBtPPCbMVZ4aNJZpdtdjwh7HnoLSvItLwJ+KDHNtKIb7MnT42FkCQZGeKQy
         N7OBHTNHVZ+2L8Z9Hio+83dS6iEg1XK7dP8Tjb8YOa9l/DSJ03njoE/bi1SyC3obBl3G
         a3OC0vF99YhcfVpAXU9lsyD2Mw/Qf3+pYG8EsThJstyvBwQwGEeA7uS1LOk2hI2hxneN
         glVKJdxw0+gIZNDSBmv3RZXsuQ79uY7bDof/flOMxAHFYAkP3GlB/M/r3JCwVP4uNEWl
         BIRw==
X-Gm-Message-State: ANhLgQ2cQJlRWfHzpxTEN75awdTv3yT3XMAifvUKzTxJm3DVxexpFNbi
        QSOhWv5NJf53QuLptG9IXqwyR5e+wOSAFVU8htYQvpmRO53O03ukkKtt9tbdNdWZOgayzmV6QLp
        P2/5Vo0cjNnS5ke3ukZUligGp9Ckcbaq3NQNVYnN6
X-Received: by 2002:a5d:414d:: with SMTP id c13mr12501273wrq.40.1584032823275;
        Thu, 12 Mar 2020 10:07:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt5l7qlGcrEh5p+/sZCDc0to9Wjr3aHjAZrUXKdxt7Jyk/HqVmvVeRJtiVdwY6wTDs+RyruWmKv/csfepNgHls=
X-Received: by 2002:a5d:414d:: with SMTP id c13mr12501239wrq.40.1584032822978;
 Thu, 12 Mar 2020 10:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb> <20200309203625.GU3818@techsingularity.net>
 <20200312095432.GW3818@techsingularity.net> <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net>
In-Reply-To: <20200312155640.GX3818@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 12 Mar 2020 18:06:51 +0100
Message-ID: <CAE4VaGALRsggp4Z3g01y1v=q5A=8OqGLuwOeD8oj7P-BkdWNBw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> find it unlikely that is common because who acquires such a large machine
> and then uses a tiny percentage of it.

I generally agree, but I also want to make a point that AMD made these
large systems much more affordable with their EPYC CPUs. The 8 NUMA
node server we are using costs under $8k.

>
> This is somewhat of a dilemma. Without the series, the load balancer and
> NUMA balancer use very different criteria on what should happen and
> results are not stable.

Unfortunately, I see instabilities also for the series. This is again
for the sp_C test with 8 threads executed on dual-socket AMD 7351
(EPYC Naples) server with 8 NUMA nodes. With the series applied, the
runtime varies from 86 to 165 seconds! Could we do something about it?
The runtime of 86 seconds would be acceptable. If we could stabilize
this case and get consistent runtime around 80 seconds, the problem
would be gone.

Do you experience the similar instability of results on your HW for
sp_C with low thread counts?

Runtime with this series applied:
 $ grep "Time in seconds" *log
sp.C.x.defaultRun.008threads.loop01.log: Time in seconds =
      125.73
sp.C.x.defaultRun.008threads.loop02.log: Time in seconds =
       87.54
sp.C.x.defaultRun.008threads.loop03.log: Time in seconds =
       86.93
sp.C.x.defaultRun.008threads.loop04.log: Time in seconds =
      165.98
sp.C.x.defaultRun.008threads.loop05.log: Time in seconds =
      114.78

For comparison, here are vanilla kernel results:
$ grep "Time in seconds" *log
sp.C.x.defaultRun.008threads.loop01.log: Time in seconds =
       59.83
sp.C.x.defaultRun.008threads.loop02.log: Time in seconds =
       67.72
sp.C.x.defaultRun.008threads.loop03.log: Time in seconds =
       63.62
sp.C.x.defaultRun.008threads.loop04.log: Time in seconds =
       55.01
sp.C.x.defaultRun.008threads.loop05.log: Time in seconds =
       65.20

> In *general*, I found that the series won a lot more than it lost across
> a spread of workloads and machines but unfortunately it's also an area
> where counter-examples can be found.

OK, fair enough. I understand that there will always be trade-offs
when making changes to scheduler like this. And I agree that cases
with higher system load (where is series is helpful) outweigh the
performance drops for low threads counts. I was hoping that it would
be possible to improve the small threads results while keeping the
gains for other scenarios:-)  But let's be realistic - I would be
happy to fix the extreme case mentioned above. The other issues where
performance drop is about 20% are OK with me and are outweighed by the
gains for different scenarios.

Thanks again for looking into it. I know that covering all cases is
hard. I very much appreciate what you do!

Jirka


On Thu, Mar 12, 2020 at 4:56 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Mar 12, 2020 at 01:10:36PM +0100, Jirka Hladky wrote:
> > Hi Mel,
> >
> > thanks a lot for analyzing it!
> >
> > My big concern is that the performance drop for low threads counts (roughly
> > up to 2x number of NUMA nodes) is not just a rare corner case, but it might
> > be more common.
>
> That is hard to tell. In my case I was seeing the problem running a HPC
> workload, dedicated to that machine and using only 6% of available CPUs. I
> find it unlikely that is common because who acquires such a large machine
> and then uses a tiny percentage of it. Rember also the other points I made
> such as 1M migrations happening in the first few seconds just trying to
> deal with the load balancer and NUMA balancer fighting each other. While
> that might happen to be good for SP, it's not universally good behaviour
> and I've dealt with issues in the past whereby the NUMA balancer would
> get confused and just ramp up the frequency it samples and migrates trying
> to override the load balancer.
>
> > We see the drop for the following benchmarks/tests,
> > especially on 8 NUMA nodes servers. However, four and even 2 NUMA node
> > servers are affected as well.
> >
> > Numbers show average performance drop (median of runtime collected from 5
> > subsequential runs) compared to vanilla kernel.
> >
> > 2x AMD 7351 (EPYC Naples), 8 NUMA nodes
> > ===================================
> > NAS: sp_C test: -50%, peak perf. drop with 8 threads
>
> I hadn't tested 8 threads specifically I think that works out as
> using 12.5% of the available machine. The allowed imbalance between
> nodes means that some SP instances will stack on the same node but not
> the same CPU.
>
> > NAS: mg_D: -10% with 16 threads
>
> While I do not have the most up to date figures available, I found the
> opposite trend at 21 threads (the test case I used were 1/3rd available
> CPUs and as close to maximum CPUs as possible). There I found it was 10%
> faster for an 8 node machine.
>
> For 4 nodes, using a single JVM was performance neutral *on average* but
> much less variable. With one JVM per node, there was a mix of small <2%
> regressions for some thread counts and up to 9% faster on others.
>
> > SPECjvm2008: co_sunflow test: -20% (peak drop with 8 threads)
> > SPECjvm2008: compress and cr_signverify tests: -10%(peak drop with 8
> > threads)
>
> I didn't run SPECjvm for multiple thread sizes so I don't have data yet
> and may not have for another day at least.
>
> > SPECjbb2005: -10% for 16 threads
> >
>
> I found this to depend in the number of JVMs used and the thread count.
> Slower at low thread counts, faster at higher thread counts but with
> more stable results with the series applied and less NUMA balancer
> activity.
>
> This is somewhat of a dilemma. Without the series, the load balancer and
> NUMA balancer use very different criteria on what should happen and
> results are not stable. In some cases acting randomly happens to work
> out and in others it does not and overall it depends on the workload and
> machine. It's very highly dependent on both the workload and the machine
> and it's a question if we want to continue dealing with two parts of the
> scheduler disagreeing on what criteria to use or try to improve the
> reconciled load and memory balancer sharing similar logic.
>
> In *general*, I found that the series won a lot more than it lost across
> a spread of workloads and machines but unfortunately it's also an area
> where counter-examples can be found.
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka


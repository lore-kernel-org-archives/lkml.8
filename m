Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C50FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1CB20731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ilv8XMT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgIJVvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:51:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725797AbgIJVud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599774629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4FUs3JbOa8AtGjAgz2MjlWZiYCyo4PYB+gQDfmnahM=;
        b=Ilv8XMT73UjCzJG/hm/22zniv8DK1tjhLb2qohTvdVwRNFtBo4YQOD63za1bna/Xhil+xo
        Db6WQJ0m7XwvQIpEbr+d2tAAec8RUi3qvL49MIImNpT+wgtYcYdjgDErBlz9+pXA0/J7gT
        V85WDfoDFQqotKOiiv4PkCIO7GCMuPk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-GKcBVg2vPKyQbayta1MPkg-1; Thu, 10 Sep 2020 17:50:17 -0400
X-MC-Unique: GKcBVg2vPKyQbayta1MPkg-1
Received: by mail-ej1-f71.google.com with SMTP id f17so3519819ejq.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 14:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4FUs3JbOa8AtGjAgz2MjlWZiYCyo4PYB+gQDfmnahM=;
        b=IfliaB8i2TIXdWcrkUV6+iH6Vf29bEQRYSTn6rVUeLNoTyk1kYE7PGNCp1itVB+E13
         dKy/bu4ifbRaS4m0m880HpnX0hJh7guggrB1t/0LDh65XYPrJOXxsOoKh7Jp9UkZ4AgK
         IPKIOprrw2Pd1ODDbo6rqKezJQS7Yb4GorA7tT7So5JAwxL8HWjd1KiPNn0ruFd1BFu2
         HVDtDtBkPXtx2/pX3HbvTgcB8Veq2SFtIal7eGiU9mprN1gAb3AXlY6mWUiX7jXqD6L4
         Px3B0dTz++X7LQlMybN0uRYPehlCz4t6BAfZHOfE00Acl40fkx8ohc3VDaC9hQVuyHaw
         rkwQ==
X-Gm-Message-State: AOAM5333v+zZxIJBzKbHXAudAYU60TnvKAt+2fCxhIcT6pSY9qzX69Wz
        1humTkBNgeC61eOdb5ITomEvcD1xES5vgXHG1nTK/BhLXQfHzI1yJPD7QgopRGD3VD45x+hZW3M
        eJXsP9TgoIQlsI3VsHFaZg4s5psbDwIy7oRw7hGvP
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr11330995edw.251.1599774615741;
        Thu, 10 Sep 2020 14:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy/jhPJAjvYYGUXgseAjBboxP0QgJ2TICNkzgqq3uq2jA6KuPMKaRN5a+h9AsfFnbz9yzoZLA9erozthNxHPc=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr11330972edw.251.1599774615373;
 Thu, 10 Sep 2020 14:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200907072708.8664-1-song.bao.hua@hisilicon.com>
 <20200907092717.GD3117@suse.de> <9c8e148805bc4da1a2bfdd72f1c76f06@hisilicon.com>
 <20200907123106.GA28232@linux.vnet.ibm.com> <20200908010717.12436-1-hdanton@sina.com>
In-Reply-To: <20200908010717.12436-1-hdanton@sina.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 10 Sep 2020 23:50:04 +0200
Message-ID: <CAE4VaGDVmAmSY1pkiDPGUm=F_0aTtaqjC7D11_ExCpSJ_Mhhmg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: use dst group while checking imbalance for
 NUMA balancer
To:     Hillf Danton <hdanton@sina.com>, Mel Gorman <mgorman@suse.de>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Jiri Vozar <jvozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hilf and Mel,

thanks a lot for bringing this to my attention. We have tested the
proposed patch and we are getting excellent results so far!

1) Threads stability has improved a lot. We see much fewer threads
migrations. Check for example this heatmap based on the mpstat results
collected while running sp.C test from the NAS benchmark. sp.C was run
with 16 threads on a dual-socket AMD 7351 server with 8 NUMA nodes:
5.9 vanilla https://drive.google.com/file/d/10rojhTSQUSu-1aGQi-srr99SmVQ3Llgo/view?usp=sharing
5.9 with the patch
https://drive.google.com/file/d/1eZdTBWvWMNvdvXqitwAlcKZ7gb-ySQUl/view?usp=sharing

The heatmaps are generated from the mpstat output (there are 5
different runs at one picture). We collect CPU utilization every 5
seconds. Lighter color corresponds to lower CPU utilization. Light
color means that the thread may have run on different CPUs during that
5 seconds. Solid straight lines, on the other hand, mean that thread
was running on the same CPU all the time. The difference is striking.

We see significantly fewer threads migrations across many different
tests - NAS, SPECjbb2005, SPECjvm2008

2) We see also performance improvement in terms of runtime, especially
at low load scenarios (number of threads being roughly equal to the 2*
number of NUMA nodes). It fixes the performance drop which we see
since 5.7 kernel, discussed for example here:
https://lore.kernel.org/lkml/CAE4VaGB7+sR1nf3Ux8W=hgN46gNXRYr0uBWJU0oYnk7h00Y_dw@mail.gmail.com/

The biggest improvements are for the NAS and the SPECjvm2008
benchmarks (typically between 20-50%). SPECjbb2005 shows also
improvements, around 10%. This is again on NUMA servers at the low
utilization. You can find snapshots of some results here:
https://drive.google.com/drive/folders/1k3Gb-vlI7UjPZZcLkoL2W2VB_zqxIJ3_?usp=sharing

@Mel - could you please test the proposed patch? I know you have good
coverage for the inter-process communication benchmarks which may show
different behavior than benchmarks which we use. I hope that fewer
threads migrations might show positive effects also for these tests.
Please give it a try.

Thanks a lot!
Jirka


On Tue, Sep 8, 2020 at 3:07 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Mon, 7 Sep 2020 18:01:06 +0530 Srikar Dronamraju wrote:
> > > > On Mon, Sep 07, 2020 at 07:27:08PM +1200, Barry Song wrote:
> > > > > Something is wrong. In find_busiest_group(), we are checking if src has
> > > > > higher load, however, in task_numa_find_cpu(), we are checking if dst
> > > > > will have higher load after balancing. It seems it is not sensible to
> > > > > check src.
> > > > > It maybe cause wrong imbalance value, for example, if
> > > > > dst_running = env->dst_stats.nr_running + 1 results in 3 or above, and
> > > > > src_running = env->src_stats.nr_running - 1 results in 1;
> > > > > The current code is thinking imbalance as 0 since src_running is smaller
> > > > > than 2.
> > > > > This is inconsistent with load balancer.
> > > > >
>
> Hi Srikar and Barry
> >
> > I have observed the similar behaviour what Barry Song has documented with a
> > simple ebizzy with less threads on a 2 node system
>
> Thanks for your testing.
> >
> > ebizzy -t 6 -S 100
> >
> > We see couple of ebizzy threads moving back and forth between the 2 nodes
> > because of numa balancer and load balancer trying to do the exact opposite.
> >
> > However with Barry's patch, couple of tests regress heavily. (Any numa
> > workload that has shared numa faults).
> > For example:
> > perf bench numa mem --no-data_rand_walk -p 1 -t 6 -G 0 -P 3072 -T 0 -l 50 -c
> >
> > I also don't understand the rational behind checking for dst_running in numa
> > balancer path. This almost means no numa balancing in lightly loaded scenario.
> >
> > So agree with Mel that we should probably test more scenarios before
> > we accept this patch.
>
> Take a look at Jirka's work [1] please if you have any plan to do some
> more tests.
>
> [1] https://lore.kernel.org/lkml/CAE4VaGB7+sR1nf3Ux8W=hgN46gNXRYr0uBWJU0oYnk7h00Y_dw@mail.gmail.com/
> >
> > > >
> > > > It checks the conditions if the move was to happen. Have you evaluated
> > > > this for a NUMA balancing load and confirmed it a) balances properly and
> > > > b) does not increase the scan rate trying to "fix" the problem?
> > >
> > > I think the original code was trying to check if the numa migration
> > > would lead to new imbalance in load balancer. In case src is A, dst is B, and
> > > both of them have nr_running as 2. A moves one task to B, then A
> > > will have 1, B will have 3. In load balancer, A will try to pull task
> > > from B since B's nr_running is larger than min_imbalance. But the code
> > > is saying imbalance=0 by finding A's nr_running is smaller than
> > > min_imbalance.
> > >
> > > Will share more test data if you need.
> > >
> > > >
> > > > --
> > > > Mel Gorman
> > > > SUSE Labs
> > >
> > > Thanks
> > > Barry
> >
> > --
> > Thanks and Regards
> > Srikar Dronamraju
>
>


-- 
-Jirka


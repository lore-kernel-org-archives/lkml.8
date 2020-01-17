Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F002072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0sQzer/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgAQOYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:24:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54712 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbgAQOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579271048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzsaHSCUD75TZ7+xKuPNPOJ5ysoYdae+9/LBQByLKak=;
        b=R0sQzer/44mIGrTzpiANzwaUnW2gTl6ryc0hwreBV9hmg46idF9J0aSVVEqldG5Ujpz+Q3
        albAYGprnLHAhjYzA9J2u0p14hWj1vZYFcGwSlItY3ogJMYOF3oM/nIsVHLku/cqsXwTs3
        z0VFBR6utEM1Yi6uCtMPi+V5t71sQ4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-yK72FegDOsqS6p-nLDpTOw-1; Fri, 17 Jan 2020 09:24:04 -0500
X-MC-Unique: yK72FegDOsqS6p-nLDpTOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CCE2800D5C;
        Fri, 17 Jan 2020 14:24:02 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF7897DB4F;
        Fri, 17 Jan 2020 14:24:00 +0000 (UTC)
Date:   Fri, 17 Jan 2020 09:23:59 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200117142358.GA6339@pauld.bos.csb>
References: <20200114101319.GO3466@techsingularity.net>
 <20200116163529.GP3466@techsingularity.net>
 <CAKfTPtBznUt20QFzeQBPELcmN6+F=BOx09oSqVMzSGvXF5ByHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBznUt20QFzeQBPELcmN6+F=BOx09oSqVMzSGvXF5ByHg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 17, 2020 at 02:08:13PM +0100 Vincent Guittot wrote:
> Hi Mel,
> 
> 
> On Thu, 16 Jan 2020 at 17:35, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Tue, Jan 14, 2020 at 10:13:20AM +0000, Mel Gorman wrote:
> > > Changelog since V3
> > > o Allow a fixed imbalance a basic comparison with 2 tasks. This turned out to
> > >   be as good or better than allowing an imbalance based on the group weight
> > >   without worrying about potential spillover of the lower scheduler domains.
> > >
> > > Changelog since V2
> > > o Only allow a small imbalance when utilisation is low to address reports that
> > >   higher utilisation workloads were hitting corner cases.
> > >
> > > Changelog since V1
> > > o Alter code flow                                             vincent.guittot
> > > o Use idle CPUs for comparison instead of sum_nr_running      vincent.guittot
> > > o Note that the division is still in place. Without it and taking
> > >   imbalance_adj into account before the cutoff, two NUMA domains
> > >   do not converage as being equally balanced when the number of
> > >   busy tasks equals the size of one domain (50% of the sum).
> > >
> > > The CPU load balancer balances between different domains to spread load
> > > and strives to have equal balance everywhere. Communicating tasks can
> > > migrate so they are topologically close to each other but these decisions
> > > are independent. On a lightly loaded NUMA machine, two communicating tasks
> > > pulled together at wakeup time can be pushed apart by the load balancer.
> > > In isolation, the load balancer decision is fine but it ignores the tasks
> > > data locality and the wakeup/LB paths continually conflict. NUMA balancing
> > > is also a factor but it also simply conflicts with the load balancer.
> > >
> > > This patch allows a fixed degree of imbalance of two tasks to exist
> > > between NUMA domains regardless of utilisation levels. In many cases,
> > > this prevents communicating tasks being pulled apart. It was evaluated
> > > whether the imbalance should be scaled to the domain size. However, no
> > > additional benefit was measured across a range of workloads and machines
> > > and scaling adds the risk that lower domains have to be rebalanced. While
> > > this could change again in the future, such a change should specify the
> > > use case and benefit.
> > >
> >
> > Any thoughts on whether this is ok for tip or are there suggestions on
> > an alternative approach?
> 
> I have just finished to run some tests on my system with your patch
> and I haven't seen any noticeable any changes so far which was a bit
> expected. The tests that I usually run, use more than 4 tasks on my 2
> nodes system; the only exception is perf sched  pipe and the results
> for this test stays the same with and without your patch. I'm curious
> if this impacts Phil's tests which run LU.c benchmark with some
> burning cpu tasks
>

I'm not seeing much meaningful difference with this real v4 versus what I 
posted earlier. It seems to have tightened up the range in some cases, but 
otherwise it's hard to see much difference, which is a good thing. I'll 
put the eye chart below for the curious. 

I'll see if the perf team has time to run a full suite on it. But for this
case it looks fine.


Cheers,
Phil


The lbv4* one is the non-official v4 from the email thread. The other v4
is the real posted one. Otherwise the rest of this is the same as I posted
the other day, which described the test. https://lkml.org/lkml/2020/1/7/840


GROUP - LU.c and cpu hogs in separate cgroups
Mop/s - Higher is better
============76_GROUP========Mop/s===================================
	min	q1	median	q3	max
5.4.0	 1671.8	 4211.2	 6103.0	 6934.1	 7865.4
5.4.0	 1777.1	 3719.9	 4861.8	 5822.5	13479.6
5.4.0	 2015.3	 2716.2	 5007.1	 6214.5	 9491.7
5.5-rc2	27641.0	30684.7	32091.8	33417.3	38118.1
5.5-rc2	27386.0	29795.2	32484.1	36004.0	37704.3
5.5-rc2	26649.6	29485.0	30379.7	33116.0	36832.8
lbv3	28496.3	29716.0	30634.8	32998.4	40945.2
lbv3	27294.7	29336.4	30186.0	31888.3	35839.1
lbv3	27099.3	29325.3	31680.1	35973.5	39000.0
lbv4*	27936.4	30109.0	31724.8	33150.7	35905.1
lbv4*	26431.0	29355.6	29850.1	32704.4	36060.3
lbv4*	27436.6	29945.9	31076.9	32207.8	35401.5
lbv4	28006.3	29861.1	31993.1	33469.3	34060.7
lbv4	28468.2	30057.7	31606.3	31963.5	35348.5
lbv4	25016.3	28897.5	29274.4	30229.2	36862.7

Runtime - Lower is better
============76_GROUP========time====================================
	min	q1	median	q3	max
5.4.0	259.2	294.92	335.39	484.33	1219.61
5.4.0	151.3	351.1	419.4	551.99	1147.3
5.4.0	214.8	328.16	407.27	751.03	1011.77
5.5-rc2	 53.49	 61.03	 63.56	 66.46	  73.77
5.5-rc2  54.08	 56.67	 62.78	 68.44	  74.45
5.5-rc2	 55.36	 61.61	 67.14	 69.16	  76.51
lbv3	 49.8	 61.8	 66.59	 68.62	  71.55
lbv3	 56.89	 63.95	 67.55	 69.51	  74.7
lbv3	 52.28	 56.68	 64.38	 69.54	  75.24
lbv4*	 56.79	 61.52	 64.3	 67.73	  72.99
lbv4*	 56.54	 62.36	 68.31	 69.47	  77.14
lbv4*	 57.6	 63.33	 65.64	 68.11	  74.32
lbv4	 59.86	 60.93	 63.74	 68.28	  72.81
lbv4	 57.68	 63.79	 64.52	 67.84	  71.62
lbv4	 55.31	 67.46	 69.66	 70.56	  81.51

NORMAL - LU.c and cpu hogs all in one cgroup
Mop/s - Higher is better
============76_NORMAL========Mop/s===================================
	min	q1	median	q3	max
5.4.0	32912.6	34047.5	36739.4	39124.1	41592.5
5.4.0	29937.7	33060.6	34860.8	39528.8	43328.1
5.4.0	31851.2	34281.1	35284.4	36016.8	38847.4
5.5-rc2	30475.6	32505.1	33977.3	34876	36233.8
5.5-rc2	30657.7	31301.1	32059.4	34396.7	38661.8
5.5-rc2	31022	32247.6	32628.9	33245	38572.3
lbv3	30606.4	32794.4	34258.6	35699	38669.2
lbv3	29722.7	30558.9	32731.2	36412	40752.3
lbv3	30297.7	32568.3	36654.6	38066.2	38988.3
lbv4*	30084.9	31227.5	32312.8	33222.8	36039.7
lbv4*	29875.9	32903.6	33803.1	34519.3	38663.5
lbv4*	27923.3	30631.1	32666.9	33516.7	36663.4
lbv4	30401.4	32559.5	33268.3	35012.9	35953.9
lbv4	29372.5	30677	32081.7	33734.2	39326.8
lbv4	29583.7	30432.5	32542.9	33170.5	34123.1

Runtime - Lower is better
============76_NORMAL========time====================================
	min	q1	median	q3	max
5.4.0	49.02	52.115	55.58	59.89	61.95
5.4.0	47.06	51.615	58.57	61.68	68.11
5.4.0	52.49	56.615	57.795	59.48	64.02
5.5-rc2	56.27	58.47	60.02	62.735	66.91
5.5-rc2	52.74	59.295	63.605	65.145	66.51
5.5-rc2	52.86	61.335	62.495	63.23	65.73
lbv3	52.73	57.12	59.52	62.19	66.62
lbv3	50.03	56.02	62.39	66.725	68.6
lbv3	52.3	53.565	55.65	62.645	67.3
lbv4*	56.58	61.375	63.135	65.3	67.77
lbv4*	52.74	59.07	60.335	61.97	68.25
lbv4*	55.61	60.835	62.42	66.635	73.02
lbv4	56.71	58.235	61.295	62.63	67.07
lbv4	51.85	60.535	63.56	66.54	69.42
lbv4	59.75	61.48	62.655	67	68.92



 
> >
> > --
> > Mel Gorman
> > SUSE Labs
> 

-- 


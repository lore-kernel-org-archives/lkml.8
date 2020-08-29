Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D07C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 05:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEAB20791
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 05:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgH2Fci convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 01:32:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3077 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbgH2Fcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 01:32:35 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 58DCEB73A6DF0DE8F321;
        Sat, 29 Aug 2020 13:32:31 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 29 Aug 2020 13:32:31 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 29 Aug 2020 13:32:30 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sat, 29 Aug 2020 13:32:31 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC] sched/topology: NUMA topology limitations
Thread-Topic: [RFC] sched/topology: NUMA topology limitations
Thread-Index: AdZ9wnXtzQTRsfy/TeONv+XCq4dqYgAACfmw
Date:   Sat, 29 Aug 2020 05:32:31 +0000
Message-ID: <422fb2cfe1d24fca8efa74ba23d8754b@hisilicon.com>
References: <6a5f06ff4ecb4f34bd7e9890dc07fb99@hisilicon.com>
In-Reply-To: <6a5f06ff4ecb4f34bd7e9890dc07fb99@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.125]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [RFC] sched/topology: NUMA topology limitations
> 
> (For those of you who already got this one: sorry! I messed up LKML and
> Vincent's addresses)
> 
> Hi,
> 
> Some of you may have noticed me struggling to plug some topology holes in
> [1]. While digging in there I realized there are some non-obvious limitations
> wrt supported NUMA topologies; IMO if we don't feel like they should be
> "fixed", they should at the very least be documented somewhere.
> 
> I should get to ramble about this at this year's (v)LPC during the scheduler
> µconf, but this isn't really trivial so I figured an email wouldn't hurt. I tried to
> package it into reasonable segments - this is still a pretty big wall of text, so
> use of coffee/tea/beer is recommended.
> 
> Spoiler alert: I don't have solutions for these yet.
> 
> Diameter issue
> ==============
> 
> Definition
> ++++++++++
> 
> Each unique NUMA distance gets an index in sched_domains_numa_distance[],
> and as the big wall of text atop topology.c::build_balance_mask() mentions
> this can be seen as an array of hops. i.e. in the following table:
> 
>       0  1
>   0: 10 20
>   1: 20 10
> 
>   sched_domains_numa_distance = { 10, 20 };
> 
> distance 10 is 0 hops (i.e. identity distance), distance 20 is 1 hop. This isn't
> strictly speaking always true, as e.g. two consecutive distance values could
> represent the same number of hops (with one path slightly "longer" than the
> other), but it makes explaining that mess a bit easier.
> 
> I'm using 'diameter' in the NoC meaning of the term, i.e. the longest shortest
> path between any two nodes, in # of hops.
> 
> Diameter <= 2
> +++++++++++++
> 
> AFAIU, one of the issues I'm encountering in [1] is that the scheduler topology
> code cannot cope with a NUMA diameter > 2. I've looked into what's already
> out there, but haven't found any (x86) machine that violates this rule. Below
> are some examples.
> 
> AMD Epyc
> --------
> 
> node   0   1   2   3   4   5   6   7
>   0:  10  16  16  16  32  32  32  32
>   1:  16  10  16  16  32  32  32  32
>   2:  16  16  10  16  32  32  32  32
>   3:  16  16  16  10  32  32  32  32
>   4:  32  32  32  32  10  16  16  16
>   5:  32  32  32  32  16  10  16  16
>   6:  32  32  32  32  16  16  10  16
>   7:  32  32  32  32  16  16  16  10
> 
> Here, diameter=2
> 
> Opteron 6174
> ------------
> 
> This is the 4-node one, which looks like this:
> 
> node  0  1  2  3
>   0: 10 20 20 20
>   1: 20 10 20 20
>   2: 20 20 10 20
>   3: 20 20 20 10
> 
>   0 ----- 3
>   | \   / |
>   |   X   |
>   | /   \ |
>   1 ----- 2
> 
> Clearly this is diameter=1
> 
> AMD Bulldozer
> -------------
> 
> I'm using the topology described in decade of wasted cores [2]; I'm not going
> to bother reproducing the distance table, the topology looks like:
> 
>    _______________________
>   /        _____________  \
>   |       /              \|
>   0 ----- 4 ----- 5 ----- 1
>   | \   / | \   / | \   / |
>   |   X   |   X   |   X   |
>   | /   \ | /   \ | /   \ |
>   6 ----- 2 ----- 3 ----- 7
>   |       \______________/|
>   \_______________________/
> 
> Which is diameter=2 (assuming equal edge weights)
> 
> Diameter > 2
> ++++++++++++
> 
> I haven't found other NUMA systems out there with a diameter > 2 other than
> the one I'm rambling about in [1]. Nevertheless, I think there are some
> theoretical setups that aren't too insane (at least less than [1]).
> 
> One of them is a 6-node mesh, which is diameter=3 and would look like:
> 
>   0 ----- 5
>   |       |
>   1 ----- 4
>   |       |
>   2 ----- 3
> 
> A more convoluted one would be a 12-node "spidergon"; it's a ring with an
> even number of nodes N, each node is connected to both of its neighbours and
> there is an interlink between node X and node (X + N/2) % N. I won't pretend I
> can draw it in ASCII, but that again gives us a diameter of 3.
> 
> Case study w/ QEMU
> ++++++++++++++++++
> 
> Setup
> -----
> 
> The topology I'll describe below is a simplified version of the one in [1], as it is
> the smallest reproducer of the issue. Morten has been calling this a
> "segmented bus".
> 
>    1 ----- 0
>    |
>    |
>    |
>    2 ----- 3
> 
> node   0   1   2   3
>   0:  10  20  30  40
>   1:  20  10  20  30
>   2:  30  20  10  20
>   3:  40  30  20  10
> 
> Diameter here is 3. I can recreate this with the following qemu
> incantation:
> 
>   $ qemu-system-aarch64 -kernel Image -initrd rootfs.cpio -append \
>                       'console=ttyAMA0 earlycon=pl011,0x9000000
> root=/dev/vda debug earlyprintk=serial sched_debug' \
>                       -smp cores=4 -nographic -m 512 -cpu cortex-a53
> -machine virt \
>                       -numa node,cpus=0,nodeid=0 -numa
> node,cpus=1,nodeid=1, \
>                       -numa node,cpus=2,nodeid=2, -numa
> node,cpus=3,nodeid=3, \
>                       -numa dist,src=0,dst=1,val=20, -numa
> dist,src=0,dst=2,val=30, \
>                       -numa dist,src=0,dst=3,val=40, -numa
> dist,src=1,dst=2,val=20, \
>                       -numa dist,src=1,dst=3,val=30, -numa
> dist,src=2,dst=3,val=20
> 
> If you boot the above with CONFIG_SCHED_DEBUG, you'll get:
> 
> [    0.245896] CPU0 attaching sched-domain(s):
> [    0.246133]  domain-0: span=0-1 level=NUMA
> [    0.246592]   groups: 0:{ span=0 cap=1011 }, 1:{ span=1 cap=1008 }
> [    0.246998]   domain-1: span=0-2 level=NUMA
> [    0.247145]    groups: 0:{ span=0-1 mask=0 cap=2019 }, 2:{ span=1-3
> mask=2 cap=3025 }
> [    0.247454] ERROR: groups don't span domain->span

Hi Valtentin,
Thanks for your email. It seems it is quite clear. May I ask what is the real harm
when group 2 is actually out of the span of diameter 2 here? What will happen when group2
doesn't span cpu0_domain1->span?
In domain-1, will scheduler fail to do load balance between group0 and group2?

> [    0.247654]    domain-2: span=0-3 level=NUMA
> [    0.247892]     groups: 0:{ span=0-2 mask=0 cap=3021 }, 3:{ span=1-3
> mask=3 cap=3047 }

Here domain-2 includes all span from 0 to 3, so that means we should still be able to do
load balance in domain-2 between cpu0 and cpu3 even we fail in domain-1?

> 
> [    0.248915] CPU1 attaching sched-domain(s):
> [    0.249050]  domain-0: span=0-2 level=NUMA
> [    0.249181]   groups: 1:{ span=1 cap=1008 }, 2:{ span=2 cap=1002 },
> 0:{ span=0 cap=1011 }
> [    0.249661]   domain-1: span=0-3 level=NUMA
> [    0.249810]    groups: 1:{ span=0-2 mask=1 cap=3034 }, 3:{ span=2-3
> mask=3 cap=2023 }
> 
> [    0.250381] CPU2 attaching sched-domain(s):
> [    0.250565]  domain-0: span=1-3 level=NUMA
> [    0.250710]   groups: 2:{ span=2 cap=1002 }, 3:{ span=3 cap=999 },
> 1:{ span=1 cap=1008 }
> [    0.250992]   domain-1: span=0-3 level=NUMA
> [    0.251129]    groups: 2:{ span=1-3 mask=2 cap=3025 }, 0:{ span=0-1
> mask=0 cap=2019 }
> 
> [    0.251474] CPU3 attaching sched-domain(s):
> [    0.251606]  domain-0: span=2-3 level=NUMA
> [    0.251772]   groups: 3:{ span=3 cap=999 }, 2:{ span=2 cap=1002 }
> [    0.252439]   domain-1: span=1-3 level=NUMA
> [    0.252587]    groups: 3:{ span=2-3 mask=3 cap=2023 }, 1:{ span=0-2
> mask=1 cap=3034 }
> [    0.252859] ERROR: groups don't span domain->span
> [    0.253009]    domain-2: span=0-3 level=NUMA
> [    0.253153]     groups: 3:{ span=1-3 mask=3 cap=3047 }, 0:{ span=0-2
> mask=0 cap=3021 }
> 
> Why we get this
> ---------------
> 
> The sched_domains we get here are NUMA<=20, NUMA<=30, NUMA<=40.
> 
> There's no problem with the sched_domain spans, those are directly derived
> from sched_domains_numa_masks[][] and that works just fine. We then build
> the sched_groups using those spans, see
> 
>   build_overlap_sched_groups()
> 
> Let's have a look at what happens for the first domain on CPU0 (node0) and
> CPU2 (node2). This would be NUMA<=20 (i.e. 1 hop), whose groups are the
> spanned CPUs:
> 
>   CPU0 (node0)
>   NUMA<=20 span=[0-1], groups=(0), (1)
> 
>   CPU2 (node2)
>   NUMA<=20 span=[1-3], groups=(2), (3), (1)
> 
> So far so good, nothing outlandish here. However, when we get to building
> NUMA<=30 (i.e. 2 hops), this falls apart:
> 
>   CPU0
>   NUMA<=30 span=[0-2], groups=(0-1), (1-3) <<< sched_domain_span(CPU2,
> NUMA<=20)
>                                ^^^
>                 sched_domain_span(CPU0, NUMA<=20)
> 
> CPU3 (node3) is very much *not* <= 30 distance (2 hops) away from CPU0
> (node0), but we have a group that spans it anyway, because of the
> aforementioned code. IOW, we are creating a completely bogus transitivity
> relation that sort of looks like:
> 
>   For any nodes i, j, k, and hop count x > 1:
>     node_distance(i, j) <= sched_domains_numa_distance[x]
>     AND
>     node_distance(j, k) <= sched_domains_numa_distance[x-1]
>     IMPLIES
>     node_distance(i, k) <= sched_domains_numa_distance[x]
> 
> Which becomes in our example:
> 
>    node_distance(0, 2) <= sched_domains_numa_distance[2] # 30
>    AND
>    node_distance(2, 3) <= sched_domains_numa_distance[1] # 20
>    IMPLIES (bogusly!)
>    node_distance(0, 3) <= sched_domains_numa_distance[2] # 30
> 
> This actually works for diameters == 2 (given everything is covered by 2 hops
> anyway) but falls apart for bigger diameters, as is the case here.
> 
> Implications of fixing this
> ---------------------------
> 
> Clearly the current sched_group setup for such topologies is not what we
> want: this disturbs load balancing on the 'corrupted' domains.
> 
> If we *do* want to support systems like this, then we have other problems to
> solve. Currently, on the aforementioned QEMU setup, we have:
> 
>   CPU0-domain1
>     group0: span=0-2, mask=0
>     group2: span=1-3, mask=2

Your kernel log is:
[    0.246998]   domain-1: span=0-2 level=NUMA
[    0.247145]    groups: 0:{ span=0-1 mask=0 cap=2019 }, 2:{ span=1-3
mask=2 cap=3025 }

it seems group0 should be:
group0: span=0-1, mask=0

but not
group0: span=0-2, mask=0 ?

is it a typo here?

>   CPU1-domain1
>     group1: span=0-2, mask=1
>     group3: span=2-3, mask=3
>   CPU2-domain1
>     group2: span=1-3, mask=2
>     group0: span=0-1, mask=0
>   CPU3-domain1
>     group3: span=2-3, mask=3
>     group1: span=0-2, mask=1
> 
> We would want to "fix" this into:
> 
>   CPU0-domain1
>     group0: span=0-2, mask=0
>   - group2: span=1-3, mask=2
>   + group?: span=1-2, mask=??

It seems sensible to move span 3 out of the groups of cpu0-domain1.

>   CPU1-domain1
>     group1: span=0-2, mask=1
>     group3: span=2-3, mask=3
>   CPU2-domain1
>     group2: span=1-3, mask=2
>     group0: span=0-1, mask=0
>   CPU3-domain1
>     group3: span=2-3, mask=3
>   - group1: span=0-2, mask=1
>   + group?: span=1-2, mask=??

Again, it seems sensible to move span 0 out of the group of cpu3-domain1.
> 
> I've purposedly left a blank for the balance mask, because there isn't really any
> valid choice. No CPU will have this (1-2) group as its local group at domain1
> (NUMA<=30); worse than that, we actually have now 5 unique groups at this
> topology level despite having only 4 CPUs: there are no CPUs left to use as
> identifier of that "new" group (i.e. owner of sched_group_capacity).
> 
> Even if we find some form of unique identifier for that group, it still isn't the
> local group of any CPU at any topology level. Since
> update_group_capacity() only updates the capacity of the local group, we
> don't have any way to update the capacity of such groups - unless we start
> updating more than the local group, which will get ugly real quick.
> 
> 
> That's as far as I got to. If you got to here, thank you for your time, and as
> always, comments / feedback are most welcome.

What is the real harm you have seen in load balance? Have you even tried
to make cpu0,cpu1,cpu2 busy and wake-up more tasks in cpu0? Will cpu3
join to share the loading in your qemu topology?

> 
> Links
> =====
> 
> [1]:
> https://lkml.kernel.org/r/20200324125533.17447-1-valentin.schneider@arm.
> com/
> [2]: https://www.ece.ubc.ca/~sasha/papers/eurosys16-final29.pdf
> 

Thanks
Barry


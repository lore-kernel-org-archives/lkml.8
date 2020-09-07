Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F2C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469DF2078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgIGJqL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:46:11 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:52642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbgIGJqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:46:11 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id C932CA238EC1CD0FD2CB;
        Mon,  7 Sep 2020 17:46:08 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 7 Sep 2020 17:44:04 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 7 Sep 2020 17:44:03 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 7 Sep 2020 17:44:04 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mel Gorman <mgorman@suse.de>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
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
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH] sched/fair: use dst group while checking imbalance for
 NUMA balancer
Thread-Topic: [PATCH] sched/fair: use dst group while checking imbalance for
 NUMA balancer
Thread-Index: AQHWhOi4NR3jMQOEjUuGVuHcF7fpAalcYjqAgACG3OA=
Date:   Mon, 7 Sep 2020 09:44:03 +0000
Message-ID: <9c8e148805bc4da1a2bfdd72f1c76f06@hisilicon.com>
References: <20200907072708.8664-1-song.bao.hua@hisilicon.com>
 <20200907092717.GD3117@suse.de>
In-Reply-To: <20200907092717.GD3117@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mel Gorman [mailto:mgorman@suse.de]
> Sent: Monday, September 7, 2020 9:27 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com;
> vincent.guittot@linaro.org; dietmar.eggemann@arm.com;
> bsegall@google.com; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Mel Gorman <mgorman@techsingularity.net>;
> Peter Zijlstra <a.p.zijlstra@chello.nl>; Valentin Schneider
> <valentin.schneider@arm.com>; Phil Auld <pauld@redhat.com>; Hillf Danton
> <hdanton@sina.com>; Ingo Molnar <mingo@kernel.org>
> Subject: Re: [PATCH] sched/fair: use dst group while checking imbalance for
> NUMA balancer
> 
> On Mon, Sep 07, 2020 at 07:27:08PM +1200, Barry Song wrote:
> > Something is wrong. In find_busiest_group(), we are checking if src has
> > higher load, however, in task_numa_find_cpu(), we are checking if dst
> > will have higher load after balancing. It seems it is not sensible to
> > check src.
> > It maybe cause wrong imbalance value, for example, if
> > dst_running = env->dst_stats.nr_running + 1 results in 3 or above, and
> > src_running = env->src_stats.nr_running - 1 results in 1;
> > The current code is thinking imbalance as 0 since src_running is smaller
> > than 2.
> > This is inconsistent with load balancer.
> >
> 
> It checks the conditions if the move was to happen. Have you evaluated
> this for a NUMA balancing load and confirmed it a) balances properly and
> b) does not increase the scan rate trying to "fix" the problem?

I think the original code was trying to check if the numa migration
would lead to new imbalance in load balancer. In case src is A, dst is B, and
both of them have nr_running as 2. A moves one task to B, then A
will have 1, B will have 3. In load balancer, A will try to pull task
from B since B's nr_running is larger than min_imbalance. But the code
is saying imbalance=0 by finding A's nr_running is smaller than
min_imbalance.

Will share more test data if you need.

> 
> --
> Mel Gorman
> SUSE Labs

Thanks
Barry

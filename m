Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8411DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CD120709
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qH5jGKPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgIGMkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:40:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729171AbgIGMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:31:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087C2HT6133168;
        Mon, 7 Sep 2020 08:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=YZHJ1yk1JMa7zpuMCoB+JWzcHL9OFCTS02DHZs3uxzM=;
 b=qH5jGKPSHixfG3SP10G2id4zDRlv1X6GB+b0tAJF6b6tH6i13QuArp/2QrLB+v+d0b89
 bLq7bswIeC5TWCvn2Dvut9VMnJk/Ng5+ZtR7TO5P/tceguZ7Wba60xO//M6o71KEY7Zu
 rB6lGZCYScL8yqt1YrXl/NTBuRACBgMjC+clahv7WG2V5adIGCD5pU5lriclITZY7wNV
 sIKq41PN8TljqZvEndqi7blf9Q0tefuxVAjg4LeQhiaeOmdDVnZK2dJ+8MXyN8C4zekA
 +GhuQr3/nsEjja2ejA+qJtDuQYbFuhxtP35dgdy4tSjegNpglTdFPIwdVrbZi+n7kzuG hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33djpxv56v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 08:31:15 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 087C3c3n139019;
        Mon, 7 Sep 2020 08:31:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33djpxv561-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 08:31:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 087CTxiT025667;
        Mon, 7 Sep 2020 12:31:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8acnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 12:31:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 087CTbhm64684518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 12:29:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7DF242049;
        Mon,  7 Sep 2020 12:31:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18BF442042;
        Mon,  7 Sep 2020 12:31:07 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  7 Sep 2020 12:31:06 +0000 (GMT)
Date:   Mon, 7 Sep 2020 18:01:06 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Mel Gorman <mgorman@suse.de>,
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
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: use dst group while checking imbalance for
 NUMA balancer
Message-ID: <20200907123106.GA28232@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200907072708.8664-1-song.bao.hua@hisilicon.com>
 <20200907092717.GD3117@suse.de>
 <9c8e148805bc4da1a2bfdd72f1c76f06@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9c8e148805bc4da1a2bfdd72f1c76f06@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_06:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > On Mon, Sep 07, 2020 at 07:27:08PM +1200, Barry Song wrote:
> > > Something is wrong. In find_busiest_group(), we are checking if src has
> > > higher load, however, in task_numa_find_cpu(), we are checking if dst
> > > will have higher load after balancing. It seems it is not sensible to
> > > check src.
> > > It maybe cause wrong imbalance value, for example, if
> > > dst_running = env->dst_stats.nr_running + 1 results in 3 or above, and
> > > src_running = env->src_stats.nr_running - 1 results in 1;
> > > The current code is thinking imbalance as 0 since src_running is smaller
> > > than 2.
> > > This is inconsistent with load balancer.
> > >

I have observed the similar behaviour what Barry Song has documented with a
simple ebizzy with less threads on a 2 node system

ebizzy -t 6 -S 100

We see couple of ebizzy threads moving back and forth between the 2 nodes
because of numa balancer and load balancer trying to do the exact opposite.

However with Barry's patch, couple of tests regress heavily. (Any numa
workload that has shared numa faults).
For example:
perf bench numa mem --no-data_rand_walk -p 1 -t 6 -G 0 -P 3072 -T 0 -l 50 -c

I also don't understand the rational behind checking for dst_running in numa
balancer path. This almost means no numa balancing in lightly loaded scenario.

So agree with Mel that we should probably test more scenarios before
we accept this patch.

> > 
> > It checks the conditions if the move was to happen. Have you evaluated
> > this for a NUMA balancing load and confirmed it a) balances properly and
> > b) does not increase the scan rate trying to "fix" the problem?
> 
> I think the original code was trying to check if the numa migration
> would lead to new imbalance in load balancer. In case src is A, dst is B, and
> both of them have nr_running as 2. A moves one task to B, then A
> will have 1, B will have 3. In load balancer, A will try to pull task
> from B since B's nr_running is larger than min_imbalance. But the code
> is saying imbalance=0 by finding A's nr_running is smaller than
> min_imbalance.
> 
> Will share more test data if you need.
> 
> > 
> > --
> > Mel Gorman
> > SUSE Labs
> 
> Thanks
> Barry

-- 
Thanks and Regards
Srikar Dronamraju

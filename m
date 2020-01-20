Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34151C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C7020684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgATIJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:09:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgATIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:09:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K87X6E092802
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 03:09:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkye9mwt5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 03:09:46 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 20 Jan 2020 08:09:44 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 08:09:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00K89c5w57737244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 08:09:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 356F4A4040;
        Mon, 20 Jan 2020 08:09:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54EDA4055;
        Mon, 20 Jan 2020 08:09:35 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 20 Jan 2020 08:09:35 +0000 (GMT)
Date:   Mon, 20 Jan 2020 13:39:35 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200114101319.GO3466@techsingularity.net>
 <20200117175631.GC20112@linux.vnet.ibm.com>
 <20200117215853.GS3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200117215853.GS3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 20012008-0008-0000-0000-0000034AFB1F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012008-0009-0000-0000-00004A6B5CE9
Message-Id: <20200120080935.GD20112@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-19_08:2020-01-16,2020-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2020-01-17 21:58:53]:

> On Fri, Jan 17, 2020 at 11:26:31PM +0530, Srikar Dronamraju wrote:
> > * Mel Gorman <mgorman@techsingularity.net> [2020-01-14 10:13:20]:
> > 
> > We certainly are seeing better results than v1.
> > However numa02, numa03, numa05, numa09 and numa10 still seem to regressing, while
> > the others are improving.
> > 
> > While numa04 improves by 14%, numa02 regress by around 12%.
> > 

> Ok, so it's both a win and a loss. This is a curiousity that this patch
> may be the primary factor given that the logic only triggers when the
> local group has spare capacity and the busiest group is nearly idle. The
> test cases you describe should have fairly busy local groups.
> 

Right, your code only seems to affect when the local group has spare
capacity and the busiest->sum_nr_running <=2 

> > 
> > numa01 is a set of 2 process each running 128 threads;
> > each thread doing 50 loops on 3GB process shared memory operations.
> 
> Are the shared operations shared between the 2 processes? 256 threads
> in total would more than exceed the capacity of a local group, even 128
> threads per process would exceed the capacity of the local group. In such
> a situation, much would depend on the locality of the accesses as well
> as any shared accesses.

Except for numa02 and numa07, (both handle local memory operations) all
shared operations are within the process. i.e per process sharing.

> 
> > numa02 is a single process with 256 threads;
> > each thread doing 800 loops on 32MB thread local memory operations.
> > 
> 
> This one is more interesting. False sharing shouldn't be an issue so the
> threads should be independent.
> 
> > numa03 is a single process with 256 threads;
> > each thread doing 50 loops on 3GB process shared memory operations.
> > 
> 
> Similar.

This is similar to numa01. Except now all threads belong to just one
process.

> 
> > numa04 is a set of 8 process (as many nodes) each running 32 threads;
> > each thread doing 50 loops on 3GB process shared memory operations.
> > 
> 
> Less clear as you don't say what is sharing the memory operations.

all sharing is within the process. In Numa04/numa09, I try to spawn as many
process as the number of nodes, other than that its same as Numa02.

> 
> > numa05 is a set of 16 process (twice as many nodes) each running 16 threads;
> > each thread doing 50 loops on 3GB process shared memory operations.
> > 
> 
> > Details below:
> 
> How many iterations for each test? 

I run 5 iterations. Want me to run with more iterations?

> 
> 
> > ./numa02.sh      Real:  78.87      82.31      80.59      1.72     -12.7187%
> > ./numa02.sh      Sys:   81.18      85.07      83.12      1.94     -35.0337%
> > ./numa02.sh      User:  16303.70   17122.14   16712.92   409.22   -12.5182%
> 
> Before range: 58 to 72
> After range: 78 to 82
> 
> This one is more interesting in general. Can you add trace_printks to
> the check for SD_NUMA the patch introduces and dump the sum_nr_running
> for both local and busiest when the imbalance is ignored please? That
> might give some hint as to the improper conditions where imbalance is
> ignored.

Can be done. Will get back with the results. But do let me know if you want
to run with more iterations or rerun the tests.

> 
> However, knowing the number of iterations would be helpful. Can you also
> tell me if this is consistent between boots or is it always roughly 12%
> regression regardless of the number of iterations?
> 

I have only measured for 5 iterations and I haven't repeated to see if the
numbers are consistent.

> > ./numa03.sh      Real:  477.20     528.12     502.66     25.46    -4.85219%
> > ./numa03.sh      Sys:   88.93      115.36     102.15     13.21    -25.629%
> > ./numa03.sh      User:  119120.73  129829.89  124475.31  5354.58  -3.8219%
> 
> Range before: 471 to 485
> Range after: 477 to 528
> 
> > ./numa04.sh      Real:  374.70     414.76     394.73     20.03    14.6708%
> > ./numa04.sh      Sys:   357.14     379.20     368.17     11.03    3.27294%
> > ./numa04.sh      User:  87830.73   88547.21   88188.97   358.24   5.7113%
> 
> Range before: 450 -> 454
> Range after:  374 -> 414
> 
> Big gain there but the fact the range changed so much is a concern and
> makes me wonder if this case is stable from boot to boot. 
> 
> > ./numa05.sh      Real:  369.50     401.56     385.53     16.03    -5.64937%
> > ./numa05.sh      Sys:   718.99     741.02     730.00     11.01    -3.76438%
> > ./numa05.sh      User:  84989.07   85271.75   85130.41   141.34   -1.48142%
> > 
> 
> Big range changes again but the shared memory operations complicate
> matters. I think it's best to focus on numa02 for and identify if there
> is an improper condition where the patch has an impact, the local group
> has high utilisation but spare capacity while the busiest group is
> almost completely idle.
> 
> > vmstat for numa01
> 
> I'm not going to comment in detail on these other than noting that NUMA
> balancing is heavily active in all cases which may be masking any effect
> of the patch and may have unstable results in general.
> 
> > <SNIP vmstat>
> > <SNIP description of loads that showed gains>
> >
> > numa09 is a set of 8 process (as many nodes) each running 4 threads;
> > each thread doing 50 loops on 3GB process shared memory operations.
> > 
> 
> No description of shared operations but NUMA balancing is very active so
> sharing is probably between processes.
> 
> > numa10 is a set of 16 process (twice as many nodes) each running 2 threads;
> > each thread doing 50 loops on 3GB process shared memory operations.
> > 
> 
> Again, shared accesses without description and heavy NUMA balancing
> activity.
> 
> So bottom line, a lot of these cases have shared operations where NUMA
> balancing decisions should dominate and make it hard to detect any impact
> from the patch. The exception is numa02 so please add tracing and dump
> out local and busiest sum_nr_running when the imbalance is ignored. I
> want to see if it's as simple as the local group is very busy but has
> capacity where the busiest group is almost idle. I also want to see how
> many times over the course of the numa02 workload that the conditions
> for the patch are even met.
> 

-- 
Thanks and Regards
Srikar Dronamraju


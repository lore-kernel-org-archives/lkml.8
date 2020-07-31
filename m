Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C43C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034082067D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgGaHgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:36:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731652AbgGaHgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:36:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V7XFaA154943;
        Fri, 31 Jul 2020 03:36:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mecy138u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 03:36:26 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06V7XxFc157001;
        Fri, 31 Jul 2020 03:36:26 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mecy138d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 03:36:26 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V7a2pI002176;
        Fri, 31 Jul 2020 07:36:24 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 32gcyd8ttm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 07:36:24 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V7aOEc57672034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 07:36:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54970AE05F;
        Fri, 31 Jul 2020 07:36:24 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC9C5AE064;
        Fri, 31 Jul 2020 07:36:23 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.51.118])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jul 2020 07:36:23 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id C7B482E2FB9; Fri, 31 Jul 2020 13:06:18 +0530 (IST)
Date:   Fri, 31 Jul 2020 13:06:18 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v4 09/10] Powerpc/smp: Create coregroup domain
Message-ID: <20200731073618.GA28399@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com>
 <20200727053230.19753-10-srikar@linux.vnet.ibm.com>
 <jhjr1sviswg.mognet@arm.com>
 <20200729061355.GA14603@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729061355.GA14603@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_02:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar, Valentin,

On Wed, Jul 29, 2020 at 11:43:55AM +0530, Srikar Dronamraju wrote:
> * Valentin Schneider <valentin.schneider@arm.com> [2020-07-28 16:03:11]:
>

[..snip..]

> At this time the current topology would be good enough i.e BIGCORE would
> always be equal to a MC. However in future we could have chips that can have
> lesser/larger number of CPUs in llc than in a BIGCORE or we could have
> granular or split L3 caches within a DIE. In such a case BIGCORE != MC.
> 
> Also in the current P9 itself, two neighbouring core-pairs form a quad.
> Cache latency within a quad is better than a latency to a distant core-pair.
> Cache latency within a core pair is way better than latency within a quad.
> So if we have only 4 threads running on a DIE all of them accessing the same
> cache-lines, then we could probably benefit if all the tasks were to run
> within the quad aka MC/Coregroup.
> 
> I have found some benchmarks which are latency sensitive to benefit by
> having a grouping a quad level (using kernel hacks and not backed by
> firmware changes). Gautham also found similar results in his experiments
> but he only used binding within the stock kernel.
> 
> I am not setting SD_SHARE_PKG_RESOURCES in MC/Coregroup sd_flags as in MC
> domain need not be LLC domain for Power.

I am observing that SD_SHARE_PKG_RESOURCES at L2 provides the best
results for POWER9 in terms of cache-benefits during wakeup.  On a
POWER9 Boston machine, running a producer-consumer test case
(https://github.com/gautshen/misc/blob/master/producer_consumer/producer_consumer.c)

The test case creates two threads, one Producer and another
Consumer. Both work on a fairly large shared array of size 64M.  In an
interation the Producer performs stores to 1024 random locations and
wakes up the Consumer. In the Consumer's iteration, loads from those
exact 1024 locations.

We measure the number of Consumer iterations per second and the
average time for each Consumer iteration. The smaller the time, the
better it is.

The following results are when I pinned the Producer and Consumer to
different combinations of CPUs to cover Small core , Big-core,
Neighbouring Big-core, Far off core within the same chip, and across
chips. There is a also a case where they are not affined anywhere, and
we let the scheduler wake them up correctly.

We find the best results when the Producer and Consumer are within the
same L2 domain. These numbers are also close to the numbers that we
get when we let the Scheduler wake them up (where LLC is L2).

## Same Small core (4 threads: Shares L1, L2, L3, Frequency Domain)

Consumer affined to  CPU 3
Producer affined to  CPU 1
    4698 iterations, avg time: 20034 ns
    4951 iterations, avg time: 20012 ns
    4957 iterations, avg time: 19971 ns
    4968 iterations, avg time: 19985 ns
    4970 iterations, avg time: 19977 ns


## Same Big Core (8 threads: Shares L2, L3, Frequency Domain)

Consumer affined to  CPU 7
Producer affined to  CPU 1
    4580 iterations, avg time: 19403 ns
    4851 iterations, avg time: 19373 ns
    4849 iterations, avg time: 19394 ns
    4856 iterations, avg time: 19394 ns
    4867 iterations, avg time: 19353 ns

## Neighbouring Big-core (Faster data-snooping from L2. Shares L3, Frequency Domain)

Producer affined to  CPU 1
Consumer affined to  CPU 11
    4270 iterations, avg time: 24158 ns
    4491 iterations, avg time: 24157 ns
    4500 iterations, avg time: 24148 ns
    4516 iterations, avg time: 24164 ns
    4518 iterations, avg time: 24165 ns


## Any other Big-core from Same Chip (Shares L3)

Producer affined to  CPU 1
Consumer affined to  CPU 87
    4176 iterations, avg time: 27953 ns
    4417 iterations, avg time: 27925 ns
    4415 iterations, avg time: 27934 ns
    4417 iterations, avg time: 27983 ns
    4430 iterations, avg time: 27958 ns


## Different Chips (No cache-sharing)

Consumer affined to  CPU 175
Producer affined to  CPU 1
    3277 iterations, avg time: 50786 ns
    3063 iterations, avg time: 50732 ns
    2831 iterations, avg time: 50737 ns
    2859 iterations, avg time: 50688 ns
    2849 iterations, avg time: 50722 ns

## Without affining them (Let Scheduler wake-them up appropriately)
Consumer affined to  CPU 0-175
Producer affined to  CPU 0-175
    4821 iterations, avg time: 19412 ns
    4863 iterations, avg time: 19435 ns
    4855 iterations, avg time: 19381 ns
    4811 iterations, avg time: 19458 ns
    4892 iterations, avg time: 19429 ns


--
Thanks and Regards
gautham.

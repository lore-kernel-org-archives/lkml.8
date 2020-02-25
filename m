Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C461C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B7524683
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgBYFNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:13:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727009AbgBYFNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:13:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P5CEZo033893;
        Tue, 25 Feb 2020 00:13:10 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yaxt7y46q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 00:13:10 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01P5DAgw035881;
        Tue, 25 Feb 2020 00:13:10 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yaxt7y46h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 00:13:10 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01P5Bc7u014021;
        Tue, 25 Feb 2020 05:13:09 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 2yaux69acc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 05:13:09 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01P5D8Cs43385310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 05:13:08 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B628136051;
        Tue, 25 Feb 2020 05:13:08 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C31F13604F;
        Tue, 25 Feb 2020 05:13:08 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.114])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 05:13:08 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 1E3352E2E07; Tue, 25 Feb 2020 10:43:06 +0530 (IST)
Date:   Tue, 25 Feb 2020 10:43:06 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        peterz@infradead.org, dsmythies@telus.net,
        daniel.lezcano@linaro.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, pratik.sampat@in.ibm.com,
        pratik.r.sampat@gmail.com
Subject: Re: [RFC 0/1] Weighted approach to gather and use history in TEO
 governor
Message-ID: <20200225051306.GG12846@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200222070002.12897-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222070002.12897-1-psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_01:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pratik,

On Sat, Feb 22, 2020 at 12:30:01PM +0530, Pratik Rajesh Sampat wrote:
> Currently the TEO governor apart from the TEO timer and hit/miss/early
> hit buckets; also gathers history of 8 intervals and if there are
> significant idle durations less than the current, then it decides if a
> shallower state must be chosen.
> 
> The current sliding history window does do a fair job at prediction,
> however, the hard-coded window can be a limiting factor for an accurate
> prediction and having the window size increase can also linearly affect
> both space and time complexity of the prediction.
> 
> To complement the current moving window history, an approach is devised
> where each idle state separately maintains a weight for itself and its
> counterpart idle states to form a probability distribution.
> 
> When a decision needs to be made, the TEO governor selects an idle state
> based on its timer and other hits/early hits metric. After which, the
> probability distribution of that selected idle state is looked at which
> gives insight into how probable that state is to occur if picked.
> 
> The probability distribution is nothing but a n*n matrix, where
> n = drv->state_count.
> Each entry in the array signifies a weight for that row.
> The weights can vary from the range [0-10000].
> 
> For example:
> state_mat[1][2] = 3000 means that previously when state 1 was selected,
> the probability that state 2 will occur is 30%.

Could you clarify what this means ? Do you mean that when state 1 is
selected, the probability that the CPU will be in state 1 for the
duration corresponding to state 2's residency is 30% ?

Further more, this means that during idle state selection we have O(n)
complexity if n is the number of idle states, since we want to select
a state where we are more likely to reside ?

> The trailing zeros correspond to having more resolution while increasing
> or reducing the weights for correction.
> 
> Currently, for selection of an idle state based on probabilities, a
> weighted random number generator is used to choose one of the idle
> states. Naturally, the states with higher weights are more likely to be
> chosen.
> 
> On wakeup, the weights are updated. The state with which it should have
> woken up with (could be the hit / miss / early hit state) is increased
> in weight by the "LEARNING_RATE" % and the rest of the states for that
> index are reduced by the same factor.

So we only update the weight in just one cell ?

To use the example above, if we selected state 1, and we resided in it
for a duration corresponding to state 2's residency, we will only
update state_mat[1][2] ?

> 
> The advantage of this approach is that unlimited history of idle states
> can be maintained in constant overhead, which can help in more accurate
> prediction for choosing idle states.
> 
> The advantage of unlimited history can become a possible disadvantage as
> the lifetime history for that thread may make the weights stale and
> influence the choosing of idle states which may not be relevant
> anymore.

Can the effect of this staleless be observed ? For instance, if we
have a particular idle entry/exit pattern for a very long duration,
say a few 10s of minutes and then the idle entry/exit pattern changes,
how bad will the weighted approach be compared to the current TEO
governor ?




> Aging the weights could be a solution for that, although this RFC does
> not cover the implementation for that.
> 
> Having a finer view of the history in addition to weighted randomized
> salt seems to show some promise in terms of saving power without
> compromising performance.
> 
> Benchmarks:
> Note: Wt. TEO governor represents the governor after the proposed change
> 
> Schbench
> ========
> Benchmarks wakeup latencies
> Scale of measurement:
> 1. 99th percentile latency - usec
> 2. Power - Watts
> 
> Command: $ schbench -c 30000 -s 30000 -m 6 -r 30 -t <Threads>
> Varying parameter: -t
> 
> Machine: IBM POWER 9
> 
> +--------+-------------+-----------------+-----------+-----------------+
> | Threads| TEO latency | Wt. TEO latency | TEO power | Wt. TEO power   |
> +--------+-------------+-----------------+-----------+-----------------+
> | 2      | 979         | 949  ( +3.06%)  | 38        | 36  ( +5.26%)   |
> | 4      | 997         | 1042 ( -4.51%)  | 51        | 39  ( +23.52%)  |
> | 8      | 1158        | 1050 ( +9.32%)  | 89        | 63  ( +29.21%)  |
> | 16     | 1138        | 1135 ( +0.26%)  | 105       | 117 ( -11.42%)  |
> +--------+-------------+-----------------+-----------+-----------------+
> 
> Sleeping Ebizzy
> ===============
> Program to generate workloads resembling web server workloads.
> The benchmark is customized to allow for a sleep interval -i
> Scale of measurement:
> 1. Number of records/s
> 2. systime (s)
> 
> Parameters:
> 1. -m => Always use mmap instead of malloc
> 2. -M => Never use mmap
> 3. -S <seconds> => Number of seconds to run
> 4. -i <interval> => Sleep interval
> 
> Machine: IBM POWER 9
> 
> +-------------------+-------------+-------------------+-----------+---------------+
> | Parameters        | TEO records | Wt. TEO records   | TEO power | Wt. TEO power |
> +-------------------+-------------+-------------------+-----------+---------------+
> | -S 60 -i 10000    | 1115000     | 1198081 ( +7.45%) | 149       | 150 ( -0.66%) |
> | -m -S 60 -i 10000 | 15879       | 15513   ( -2.30%) | 23        | 22  ( +4.34%) |
> | -M -S 60 -i 10000 | 72887       | 77546   ( +6.39%) | 104       | 103 ( +0.96%) |
> +-------------------+-------------+-------------------+-----------+---------------+
> 
> Hackbench
> =========
> Creates a specified number of pairs of schedulable entities
> which communicate via either sockets or pipes and time how long  it
> takes for each pair to send data back and forth.
> Scale of measurement:
> 1. Time (s)
> 2. Power (watts)
> 
> Command: Sockets: $ hackbench -l <Messages>
>          Pipes  : $ hackbench --pipe -l <Messages>
> Varying parameter: -l
> 
> Machine: IBM POWER 9
> 
> +----------+------------+-------------------+----------+-------------------+
> | Messages | TEO socket | Wt. TEO socket    | TEO pipe | Wt. TEO pipe      |
> +----------+------------+-------------------+----------+-------------------+
> | 100      | 0.042      | 0.043   ( -2.32%) | 0.031    | 0.032   ( +3.12%) |
> | 1000     | 0.258      | 0.272   ( +5.14%) | 0.301    | 0.312   ( -3.65%) |
> | 10000    | 2.397      | 2.441   ( +1.80%) | 5.642    | 5.092   ( +9.74%) |
> | 100000   | 23.691     | 23.730  ( -0.16%) | 57.762   | 57.857  ( -0.16%) |
> | 1000000  | 234.103    | 233.841 ( +0.11%) | 559.807  | 592.304 ( -5.80%) |
> +----------+------------+-------------------+----------+-------------------+
> 
> Power :Socket: Consistent between 135-140 watts for both TEO and Wt. TEO
>        Pipe: Consistent between 125-130 watts for both TEO and Wt. TEO
> 
>


Could you also provide power measurements for the duration when the
system is completely idle for each of the variants of TEO governor ?
Is it the case that the benefits that we are seeing above are only due
to Wt. TEO being more conservative than TEO governor by always
choosing a shallower state ?





> 
> Pratik Rajesh Sampat (1):
>   Weighted approach to gather and use history in TEO governor
> 
>  drivers/cpuidle/governors/teo.c | 95 +++++++++++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
> 

--
Thanks and Regards
gautham.

Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF4AC3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 08:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B5246AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 08:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgB2I7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 03:59:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbgB2I7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 03:59:01 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01T8rjTh036481
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 03:59:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfhs1kq7a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 03:58:59 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Sat, 29 Feb 2020 08:58:58 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 29 Feb 2020 08:58:55 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01T8vtUK48169262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 08:57:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D59BA4054;
        Sat, 29 Feb 2020 08:58:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2783A405C;
        Sat, 29 Feb 2020 08:58:51 +0000 (GMT)
Received: from [9.199.55.146] (unknown [9.199.55.146])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 29 Feb 2020 08:58:51 +0000 (GMT)
Subject: Re: [RFC 1/1] Weighted approach to gather and use history in TEO
 governor
To:     ego@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        peterz@infradead.org, dsmythies@telus.net,
        daniel.lezcano@linaro.org, svaidy@linux.ibm.com,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
References: <20200222070002.12897-1-psampat@linux.ibm.com>
 <20200222070002.12897-2-psampat@linux.ibm.com>
 <20200225061857.GH12846@in.ibm.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Date:   Sat, 29 Feb 2020 14:28:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225061857.GH12846@in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022908-0016-0000-0000-000002EB63E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022908-0017-0000-0000-0000334E9FF4
Message-Id: <af2e45f2-3e20-77f3-690d-a1f0b296cf43@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-29_02:2020-02-28,2020-02-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=1 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002290067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gautham,

Snip [...]

>
> I know this is an RFC patch, not meant for inclusion, but it is good
> practice to have your Signed-off-by.
>
Sorry about that, my bad.



Snip [...]

>> +	/*
>> +	 * Rearrange the weight distribution of the state, increase the weight
>> +	 * by the LEARNING RATE % for the idle state that was supposed to be
>> +	 * chosen and reduce by the same amount for rest of the states
>> +	 *
>> +	 * If the weights are greater than (100 - LEARNING_RATE) % or lesser
>> +	 * than LEARNING_RATE %, do not increase or decrease the confidence
>> +	 * respectively
>> +	 */
>> +	for (i = 0; i < drv->state_count; i++) {
>> +		unsigned int delta;
>> +
>> +		if (idx == -1)
>> +			break;
>> +		if (i ==  idx) {
>> +			delta = (LEARNING_RATE * cpu_data->state_mat[last_idx][i]) / 100;
>> +			if (cpu_data->state_mat[last_idx][i] + delta >=
>> +			    (100 - LEARNING_RATE) * 100)
>> +				continue;
>> +			cpu_data->state_mat[last_idx][i] += delta;
>> +			continue;
>> +		}
>> +		delta = (LEARNING_RATE * cpu_data->state_mat[last_idx][i]) /
>> +			((drv->state_count - 1) * 100);
>
> What happens when drv->state_count == 1?

In that case, the idx has to be 0 and the weights go on increasing upto
(100 - LEARNING_RATE) %. However that would not affect how states are
chosen. Although I could break if we have only one state and spare us some cycles.

>> +		if (cpu_data->state_mat[last_idx][i] - delta <=
>> +		    LEARNING_RATE * 100)
>> +			continue;
>> +		cpu_data->state_mat[last_idx][i] -= delta;
> So, even update takes O(n) time, since we have to increase the weight
> for one state, and correspondingly decrease the state for all the
> other states.

Yes it does take O(n).

>
>> +	}
>> +
>>   	/*
>>   	 * Save idle duration values corresponding to non-timer wakeups for
>>   	 * pattern detection.
>> @@ -244,7 +288,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>   	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
>>   	u64 duration_ns;
>>   	unsigned int hits, misses, early_hits;
>> -	int max_early_idx, prev_max_early_idx, constraint_idx, idx, i;
>> +	int max_early_idx, prev_max_early_idx, constraint_idx, idx, i, og_idx;
>>   	ktime_t delta_tick;
>>
>>   	if (dev->last_state_idx >= 0) {
>> @@ -374,10 +418,13 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>   	if (constraint_idx < idx)
>>   		idx = constraint_idx;
>>
>> +	og_idx = idx;
>> +
>>   	if (idx < 0) {
>>   		idx = 0; /* No states enabled. Must use 0. */
>>   	} else if (idx > 0) {
>> -		unsigned int count = 0;
>> +		unsigned int count = 0, sum_weights = 0, weights_list[CPUIDLE_STATE_MAX];
>> +		int i, j = 0, rnd_wt, rnd_num = 0;
>>   		u64 sum = 0;
>>
>>   		/*
>> @@ -412,6 +459,29 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>   								       idx, avg_ns);
>>   			}
>>   		}
>> +		/*
>> +		 * In case, the recent history yields a shallower state, then
>> +		 * the probability distribution is looked at.
>> +		 * The weighted random number generator uses the weights as a
>> +		 * bias to choose the next idle state
>> +		 */
>> +		if (og_idx != idx) {
>> +			for (i = 0; i <= idx; i++) {
>
> So it seems like we are restricting our choice to states no deeper
> than the selected state.
>
> Is it not possible that cpu_data->state_mat[idx][j] has the
> maximum weight when j > idx ? If yes, why are we leaving those states
> out ?

It is certainly possible, however, the idea is that the state
selected because of a timer is the deepest it could have gone unless interrupted
otherwise for which it may have to choose a shallower state.

Having said that, timers can get cancelled prompting to choose a deeper state,
however, it may not be often enough for us to start amounting in the mix.
Certainly more testing of various workloads is required to determine if that
is indeed the case.

>> +				if (dev->states_usage[i].disable)
>> +					continue;
>> +				sum_weights += cpu_data->state_mat[idx][i];
>> +				weights_list[j++] = sum_weights;
>> +			}
> Assume that cpu_data->stat_mat[idx] = {4, 5, 6, 9}
> weight_list[] = {4, 9, 15, 24}
>
>> +			get_random_bytes(&rnd_num, sizeof(rnd_num));
>> +			rnd_num = rnd_num % 100;
> Assume rnd_num = 50.
>> +			rnd_wt = (rnd_num * sum_weights) / 100;
>
> Then, rnd_wt = 12.
>
>  From the logic, below, it appears that you want to pick the shallowest
> state i at which rnd_wt < weights_list[i]. In which case it would be
> the state corresponding to the weight 6 (as the cumulative weight at
> that point is 15).
>
>
>> +			for (i = 0; i < j; i++) {
>> +				if (rnd_wt < weights_list[i])
>> +					break;
>> +				rnd_wt -= weights_list[i];
>
> And yet, because of this additional subtraction, after the first
> iteration of this loop, rnd_wt = 12 - 4 = 8, which means that you will
> end up picking the state corresponding to weight 5 (cumulative weight
> being 9 at this point).
>
> This doesn't seem right.

You're right. I've made a mistake here.
The line: rnd_wt -= weights_list[i]; is not needed and throws the algorithm off.

I've re-run the benchmarks again to check for the affects.
Although I see some variation in results, however I do see the algorithm improve
over the conventional TEO.

Initial weight distribution 60-40.
Learning rate: 10%

Schbench
+---------+-------------+----------------+-----------+--------------+
| Threads | TEO latency | Wt.TEO latency | TEO power | Wt.TEO power |
+---------+-------------+----------------+-----------+--------------|
| 2       | 979         | 947(+3.26%)    | 38        | 34(+10.52%)  |
|---------|-------------|----------------|-----------|--------------|
| 4       | 997         | 1110(-11.34%)  | 51        | 41(+19.60%)  |
|---------|-------------|----------------|-----------|--------------|
| 8       | 1158        | 1070(+7.59%)   | 89        | 71(+20.22%)  |
|---------|-------------|----------------|-----------|--------------|
| 16      | 1138        | 1334(-17.22%)  | 105       | 101(+3.80%)  |
+---------+-------------+----------------+-----------+--------------+

Hackbench
+-------------------+-------------+-----------------+-----------+--------------+
| Parameters        | TEO records | Wt.TEO records  | TEO power | Wt.TEO power |
+-------------------+-------------+-----------------+-----------+--------------+
| -S 60 -i 10000    | 1115000     | 1180442(+5.86%) | 149       | 147(+1.34%)  |
|-------------------|-------------|-----------------|-----------|--------------|
| -m -S 60 -i 10000 | 15879       | 15953(+0.46%)   | 23        | 22(+4.34%)   |
|-------------------|-------------|-----------------|-----------|--------------|
| -M -S 60 -i 10000 | 72887       | 75454(+3.52%)   | 104       | 100(+3.84%)  |
+-------------------+-------------+-----------------+-----------+--------------+

>> +			}
>> +			idx = i;
>> +		}
>>   	}
>>
>>   	/*
>> @@ -468,13 +538,28 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>>   			     struct cpuidle_device *dev)
>>   {
>>   	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
>> -	int i;
>> +	int i, j;
>>
>>   	memset(cpu_data, 0, sizeof(*cpu_data));
>>
>>   	for (i = 0; i < INTERVALS; i++)
>>   		cpu_data->intervals[i] = U64_MAX;
>>
>> +	/*
>> +	 * Populate initial weights for each state
>> +	 * The stop state is initially more biased for itself.
>> +	 *
>> +	 * Currently the initial distribution of probabilities are 70%-30%.
>> +	 * The trailing 0s are for increased resolution.
>> +	 */
>> +	for (i = 0; i < drv->state_count; i++) {
>> +		for (j = 0; j < drv->state_count; j++) {
>> +			if (i == j)
>> +				cpu_data->state_mat[i][j] = 7000;
>> +			else
>> +				cpu_data->state_mat[i][j] = 3000 / (drv->state_count - 1);
>
>> +		}
>> +	}
>>   	return 0;
>>   }
>>
>> -- 
>> 2.17.1
>>
---

Pratik


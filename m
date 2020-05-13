Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44009CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3DE206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgEMLPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:15:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730567AbgEMLPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:15:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DB1xpa022374;
        Wed, 13 May 2020 07:15:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3101m17sxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 07:15:05 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04DBAo9K061317;
        Wed, 13 May 2020 07:15:05 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3101m17swb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 07:15:05 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04DBF2k9020086;
        Wed, 13 May 2020 11:15:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3100uc0jnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 11:15:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04DBF0OB57082046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 11:15:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 275BCAE045;
        Wed, 13 May 2020 11:15:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7DC1AE04D;
        Wed, 13 May 2020 11:14:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.94.237])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 May 2020 11:14:54 +0000 (GMT)
Subject: Re: [PATCH v5 3/4] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
From:   Parth Shah <parth@linux.ibm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20200228090755.22829-1-parth@linux.ibm.com>
 <20200228090755.22829-4-parth@linux.ibm.com>
 <00bf190a-6d84-48aa-83cb-b25e6c24777c@arm.com>
 <6fc4bbba-c024-1248-4837-977f0adba2d3@linux.ibm.com>
Message-ID: <c5e16960-3e81-5c89-f765-5a4e08622958@linux.ibm.com>
Date:   Wed, 13 May 2020 16:44:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6fc4bbba-c024-1248-4837-977f0adba2d3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_04:2020-05-11,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 cotscore=-2147483648 impostorscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/20 3:11 PM, Parth Shah wrote:
> 
> 
> On 5/11/20 4:43 PM, Dietmar Eggemann wrote:
>> On 28/02/2020 10:07, Parth Shah wrote:
>>> Introduce the latency_nice attribute to sched_attr and provide a
>>> mechanism to change the value with the use of sched_setattr/sched_getattr
>>> syscall.
>>>
>>> Also add new flag "SCHED_FLAG_LATENCY_NICE" to hint the change in
>>> latency_nice of the task on every sched_setattr syscall.
>>>
>>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>>> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
>>
>> [...]
>>
>> ndif /* _UAPI_LINUX_SCHED_TYPES_H */
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 866ea3d2d284..cd1fb9c8be26 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4710,6 +4710,9 @@ static void __setscheduler_params(struct task_struct *p,
>>>  	p->rt_priority = attr->sched_priority;
>>>  	p->normal_prio = normal_prio(p);
>>>  	set_load_weight(p, true);
>>> +
>>> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
>>> +		p->latency_nice = attr->sched_latency_nice;
>>>  }
>>
>> How do you make sure that p->latency_nice can be set independently from
>> p->static_prio?
>>
>> AFAICS, util_clamp achieves this by relying on SCHED_FLAG_KEEP_PARAMS,
>> so completely bypassing __setscheduler_params() and using it's own
>> __setscheduler_uclamp().
>>
> 
> Right. good catch.
> Use of SCHED_FLAG_LATENCY_NICE/SCHED_FLAG_ALL is must to change
> latency_nice value, but currently setting latency_nice value also changes
> static_prio.
> 
> One possible solution here is to move the above code to _setscheduler():
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6031ec58c7ae..44bcbf060718 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4731,9 +4731,6 @@ static void __setscheduler_params(struct task_struct *p,
>         p->rt_priority = attr->sched_priority;
>         p->normal_prio = normal_prio(p);
>         set_load_weight(p, true);
> -
> -       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> -               p->latency_nice = attr->sched_latency_nice;
>  }
> 
>  /* Actually do priority change: must hold pi & rq lock. */
> @@ -4749,6 +4746,13 @@ static void __setscheduler(struct rq *rq, struct
> task_struct *p,
> 
>         __setscheduler_params(p, attr);
> 
> +       /*
> +        * Change latency_nice value only when SCHED_FLAG_LATENCY_NICE or
> +        * SCHED_FLAG_ALL sched_flag is set.
> +        */
> +       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> +               p->latency_nice = attr->sched_latency_nice;
> +
> 
> This should allow setting value only on above flags, also restricts setting
> the value when SCHED_FLAG_KEEP_PARAMS/SCHED_FLAG_KEEP_ALL is passed.

and also get rid of __setscheduler_params(p, attr) when
attr->sched_flags == SCHED_FLAG_LATENCY_NICE

Other way is surely to bypass keep_param check just like UCLAMP.

> 
> 
> Thanks,
> Parth
> 

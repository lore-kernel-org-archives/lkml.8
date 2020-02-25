Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41243C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A99A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgBYPE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:04:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729870AbgBYPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:04:28 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PExW4H009745
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:04:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ycy1py430-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:04:22 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Feb 2020 15:04:11 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Feb 2020 15:04:05 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PF37RX46858616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 15:03:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A916852054;
        Tue, 25 Feb 2020 15:04:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.92.137])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 07A2452051;
        Tue, 25 Feb 2020 15:03:55 +0000 (GMT)
Subject: Re: [PATCH v4 3/4] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-4-parth@linux.ibm.com>
 <20200225065409.GK28029@codeaurora.org>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Tue, 25 Feb 2020 20:33:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200225065409.GK28029@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022515-0012-0000-0000-0000038A29F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022515-0013-0000-0000-000021C6CCF3
Message-Id: <f44fb56c-d9d9-a132-d953-bcbee8c03dda@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_05:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002250118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/20 12:24 PM, Pavan Kondeti wrote:
> On Mon, Feb 24, 2020 at 02:29:17PM +0530, Parth Shah wrote:
> 
> [...]
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 65b6c00d6dac..e1dc536d4ca3 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4723,6 +4723,8 @@ static void __setscheduler_params(struct task_struct *p,
>>  	p->rt_priority = attr->sched_priority;
>>  	p->normal_prio = normal_prio(p);
>>  	set_load_weight(p, true);
>> +
>> +	p->latency_nice = attr->sched_latency_nice;
>>  }
> 
> We don't want this when SCHED_FLAG_LATENCY_NICE is not set in
> attr->flags.
> 
> The user may pass SCHED_FLAG_KEEP_PARAMS | SCHED_FLAG_LATENCY_NICE to
> change only latency nice value. So we have to update latency_nice
> outside __setscheduler_params(), I think.


AFAICT, passing SCHED_FLAG_KEEP_PARAMS with any other flag will prevent us
from changing the latency_nice value because of the below code flow:

__sched_setscheduler()
	__setscheduler()
		if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) return;
		__setscheduler_params()

whereas, one thing we still can do is add if condition when setting the
value, i.e.,

@@ -4724,7 +4724,8 @@ static void __setscheduler_params(struct task_struct *p,
        p->normal_prio = normal_prio(p);
        set_load_weight(p, true);

-       p->latency_nice = attr->sched_latency_nice;
+       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
+               p->latency_nice = attr->sched_latency_nice;
 }


> 
>>  
>>  /* Actually do priority change: must hold pi & rq lock. */
>> @@ -4880,6 +4882,13 @@ static int __sched_setscheduler(struct task_struct *p,
>>  			return retval;
>>  	}
>>  
>> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
>> +		if (attr->sched_latency_nice > MAX_LATENCY_NICE)
>> +			return -EINVAL;
>> +		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
>> +			return -EINVAL;
>> +	}
>> +
>>  	if (pi)
>>  		cpuset_read_lock();
>>  
>> @@ -4914,6 +4923,9 @@ static int __sched_setscheduler(struct task_struct *p,
>>  			goto change;
>>  		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>>  			goto change;
>> +		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
>> +		    attr->sched_latency_nice != p->latency_nice)
>> +			goto change;
>>  
>>  		p->sched_reset_on_fork = reset_on_fork;
>>  		retval = 0;
>> @@ -5162,6 +5174,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>>  	    size < SCHED_ATTR_SIZE_VER1)
>>  		return -EINVAL;
>>  
>> +	if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
>> +	    size < SCHED_ATTR_SIZE_VER2)
>> +		return -EINVAL;
>>  	/*
>>  	 * XXX: Do we want to be lenient like existing syscalls; or do we want
>>  	 * to be strict and return an error on out-of-bounds values?
>> @@ -5391,6 +5406,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>>  	else
>>  		kattr.sched_nice = task_nice(p);
>>  
>> +	kattr.sched_latency_nice = p->latency_nice;
>> +
> 
> Can you consider printing latency_nice value in proc_sched_show_task() in this
> patch/series?

Sure, I will add it.


Thanks,
Parth


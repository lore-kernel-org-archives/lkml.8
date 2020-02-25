Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB9CC35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EADC21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgBYGrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:47:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbgBYGrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:47:41 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P6jOwI071567
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 01:47:40 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1as9208-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 01:47:40 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Feb 2020 06:47:38 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Feb 2020 06:47:33 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01P6kZfH45744390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 06:46:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85A6652051;
        Tue, 25 Feb 2020 06:47:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.187])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 158BA5204E;
        Tue, 25 Feb 2020 06:47:29 +0000 (GMT)
Subject: Re: [PATCH v4 4/4] sched/core: Add permission checks for setting the
 latency_nice value
To:     Qais Yousef <qais.yousef@arm.com>, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        tim.c.chen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, David.Laight@ACULAB.COM, pjt@google.com,
        pavel@ucw.cz, tj@kernel.org, dhaval.giani@oracle.com,
        qperret@google.com
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-5-parth@linux.ibm.com>
 <20200224132905.32sdpbydnzypib47@e107158-lin.cambridge.arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Tue, 25 Feb 2020 12:17:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200224132905.32sdpbydnzypib47@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022506-0016-0000-0000-000002EA0157
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022506-0017-0000-0000-0000334D2B4D
Message-Id: <9a4132f2-62cc-4132-1c6d-964ed679afc7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_01:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/20 6:59 PM, Qais Yousef wrote:
> On 02/24/20 14:29, Parth Shah wrote:
>> Since the latency_nice uses the similar infrastructure as NICE, use the
>> already existing CAP_SYS_NICE security checks for the latency_nice. This
>> should return -EPERM for the non-root user when trying to set the task
>> latency_nice value to any lower than the current value.
>>
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> 
> I'm not against this, so I'm okay if it goes in as is.
> 
> But IMO the definition of this flag is system dependent and I think it's
> prudent to keep it an admin only configuration.
> 
> It'd be hard to predict how normal application could use and depend on this
> feature in the future, which could tie our hand in terms of extending it.
> 

I am fine with this going in too. But just to lie down the fact on single
page and starting the discussion, here are the pros and cons for including
this permission checks:

Pros:
=====
- Having this permission checks will allow only root users to promote the
task, meaning lowering the latency_nice of the task. This is required in
case when the admin has increased the latency_nice value of a task and
non-root user can not lower it.
- In absence of this check, the non-root user can decrease the latency_nice
value against the admin configured value.

Cons:
=====
- This permission check prevents the non-root user to lower the value. This
is a problem when the user itself has increased the latency_nice value in
the past but fails to lower it again.
- After task fork, non-root user cannot lower the inherited child task's
latency_nice value, which might be a problem in the future for extending
this latency_nice ideas for different optimizations.


> I can't argue hard about this though. But I do feel going further and have
> a sched_feature() for each optimization that uses this flag could be necessary
> too.

I agree to your point.


Thanks,
Parth

> 
> Thanks
> 
> --
> Qais Yousef
> 
>> ---
>>  kernel/sched/core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index e1dc536d4ca3..f883e1d3cd10 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4887,6 +4887,10 @@ static int __sched_setscheduler(struct task_struct *p,
>>  			return -EINVAL;
>>  		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
>>  			return -EINVAL;
>> +		/* Use the same security checks as NICE */
>> +		if (attr->sched_latency_nice < p->latency_nice &&
>> +		    !can_nice(p, attr->sched_latency_nice))
>> +			return -EPERM;
>>  	}
>>  
>>  	if (pi)
>> -- 
>> 2.17.2
>>


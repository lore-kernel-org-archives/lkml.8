Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C558C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E76207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P91CGiLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBTQjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:39:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47220 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgBTQjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:39:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KGXdxM054114;
        Thu, 20 Feb 2020 16:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7aZLNQP35QhFkj5lw6YZu/PAuEqphcnivyC1yq+L0zE=;
 b=P91CGiLl+KUFIcTX4NWDqhE9PIWXHQev196tVNB9OC8IESW9qFyXKAj0P4ralImk8P6o
 CrL7T7s6nuuuPm2RCUihLekSpoxkEZbaP+xFzY8BfqJZu2bxe39tB3sv74FEmitw0pA2
 ekdUyrfgYCMnGzoC+jZC1D89aU346KzLnu8vHrcfM/PH/NkHF7pmLbHcwmIryqsYMiNV
 2rYCjIh7lJ4pDvpqsHLgqUm7crpFV/wyJuImjxIZTq1sF+gSoHjuObpVSbGA28vhrgaS
 7gGk20tB1i0cuhjPIX30Pa2+qfUbgDlOca8ILK23v0lcQFJZYlJavrt16fGawjNbMXoF Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y8udkjybh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 16:35:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KGWRdv151155;
        Thu, 20 Feb 2020 16:35:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y8udd4dyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 16:35:02 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KGZ0r7024885;
        Thu, 20 Feb 2020 16:35:00 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 08:34:59 -0800
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Parth Shah <parth@linux.ibm.com>, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        dhaval.giani@oracle.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, pavel@ucw.cz, qperret@qperret.net,
        David.Laight@ACULAB.COM, pjt@google.com, tj@kernel.org
References: <20200116120230.16759-1-parth@linux.ibm.com>
 <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
 <971909ed-d4e0-6afa-d20b-365ede5a195e@linux.ibm.com>
 <8e984496-e89b-d96c-d84e-2be7f0958ea4@oracle.com>
 <1e216d18-7ec0-4a0d-e124-b730d6e03e6f@oracle.com>
 <de5d8886-6f70-a3fa-8061-5877cd1d98f5@linux.ibm.com>
 <7429e0ae-41ff-e9c4-dd65-3ef1919f5f50@linux.ibm.com>
 <a332d633-7826-b85d-5d9f-5e34f9de084a@oracle.com>
 <20200220150343.dvweamfnk257pg7z@e107158-lin.cambridge.arm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <9bb1437b-3de0-b0ca-6319-6be903b0758d@oracle.com>
Date:   Thu, 20 Feb 2020 11:34:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200220150343.dvweamfnk257pg7z@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=2 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=2
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 10:03 AM, Qais Yousef wrote:
> On 02/20/20 09:30, chris hyser wrote:
>>> The below diff works out well enough in-order to align permission checks
>>> with NICE.
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 2bfcff5623f9..ef4a397c9170 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4878,6 +4878,10 @@ static int __sched_setscheduler(struct task_struct *p,
>>>                           return -EINVAL;
>>>                   if (attr->sched_latency_nice < MIN_LATENCY_NICE)
>>>                           return -EINVAL;
>>> +               /* Use the same security checks as NICE */
>>> +               if (attr->sched_latency_nice < p->latency_nice &&
>>> +                   !can_nice(p, attr->sched_latency_nice))
>>> +                       return -EPERM;
>>>           }
>>>
>>>           if (pi)
>>>
>>> With the above in effect,
>>> A non-root user can only increase the value upto +19, and once increased
>>> cannot be decreased. e.g., a user once sets the value latency_nice = 19,
>>> the same user cannot set the value latency_nice = 18. This is the same
>>> effect as with NICE.
>>>
>>> Is such permission checks required?
>>>
>>> Unlike NICE, we are going to use latency_nice for scheduler hints only, and
>>> so won't it make more sense to allow a user to increase/decrease the values
>>> of their owned tasks?
>>
>> Whether called a hint or not, it is a trade-off to reduce latency of select
>> tasks at the expense of the throughput of the other tasks in the the system.
> 
> Does it actually affect the throughput of the other tasks? I thought this will
> allow the scheduler to reduce latencies, for instance, when selecting which cpu
> it should land on. I can't see how this could hurt other tasks.

This is why it is hard to argue about pure abstractions. The primary idea mentioned so far for how these latencies are 
reduced is by short cutting the brute-force search for something idle. If you don't find an idle cpu because you didn't 
spend the time to look, then you pre-empted a task, possibly with a large nice warm cache footprint that was cranking 
away on throughput. It is ultimately going to be the usual latency vs throughput trade off. If latency reduction were 
"free" we wouldn't need a per task attribute. We would just do the reduction for all tasks, everywhere, all the time.

> 
> Can you expand on the scenario you have in mind please?

Hopefully, the above helps. It was my original plan to introduce this with a data laden RFC on the topic, but I felt the 
need to respond to Parth immediately. I'm not currently pushing any particular change.

-chrish

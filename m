Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B573C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7B1208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqI5avTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgBTObQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:31:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57220 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBTObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:31:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KETDDZ124063;
        Thu, 20 Feb 2020 14:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=X6pL3zOnm9JQ9tnqVAzQ/9xKOKIHN26ntaweySKw0h8=;
 b=lqI5avTbxQrNzF0EC8aTVszSyowiUC4wBhGMtwYc4VqZrBV3Bc0NyfIzMEb/DutYGaDA
 4x06K2YS6f9oJe0byFDw9yJljCeZ/lC1prR10A5w6vCbGzBMsbGPWcEo1fN0cqU2xNzl
 pI1cFHL+YHWbRCukYReDt9yMaN5CJ/nB2TLMplTKPCcZukqK9a9DinkYv8EOhggEZd3H
 qGRP+WQRsVOc4NJfvbWf5h1IMBojazVNcTA0MRR3QeditZWZPTOoW2qRl9AXwfJ74aTT
 bGN2bihrshOoeH1c/wkcF/s0JowCWKkqm4G/zQpHEBSlCo/a7zlyZlw5//tZR81x+/gA Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8udda1hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 14:30:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KESFqG092301;
        Thu, 20 Feb 2020 14:30:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y8udda8q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 14:30:46 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KEUh01011340;
        Thu, 20 Feb 2020 14:30:43 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 06:30:42 -0800
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
To:     Parth Shah <parth@linux.ibm.com>, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        dhaval.giani@oracle.com, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, qais.yousef@arm.com, pavel@ucw.cz,
        qperret@qperret.net, David.Laight@ACULAB.COM, pjt@google.com,
        tj@kernel.org
References: <20200116120230.16759-1-parth@linux.ibm.com>
 <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
 <971909ed-d4e0-6afa-d20b-365ede5a195e@linux.ibm.com>
 <8e984496-e89b-d96c-d84e-2be7f0958ea4@oracle.com>
 <1e216d18-7ec0-4a0d-e124-b730d6e03e6f@oracle.com>
 <de5d8886-6f70-a3fa-8061-5877cd1d98f5@linux.ibm.com>
 <7429e0ae-41ff-e9c4-dd65-3ef1919f5f50@linux.ibm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <a332d633-7826-b85d-5d9f-5e34f9de084a@oracle.com>
Date:   Thu, 20 Feb 2020 09:30:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7429e0ae-41ff-e9c4-dd65-3ef1919f5f50@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/20 3:50 AM, Parth Shah wrote:
> 
> 
> On 2/20/20 2:04 PM, Parth Shah wrote:
>>
>>
>> On 2/19/20 11:53 PM, chris hyser wrote:
>>>
>>>
>>> On 2/19/20 9:15 AM, chris hyser wrote:
>>>>
>>>>
>>>> On 2/19/20 5:09 AM, Parth Shah wrote:
>>>>> Hi Chris,
>>>>>
>>>>> On 2/19/20 4:30 AM, chris hyser wrote:
>>>>>> On 2/17/20 3:57 AM, Parth Shah wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 1/16/20 5:32 PM, Parth Shah wrote:
>>>>>>>> This is the 3rd revision of the patch set to introduce
>>>>>>>> latency_{nice/tolerance} as a per task attribute.
>>>>>>>>
>>>>>>>> The previous version can be found at:
>>>>>>>> v1: https://lkml.org/lkml/2019/11/25/151
>>>>>>>> v2: https://lkml.org/lkml/2019/12/8/10
>>>>>>>>
>>>>>>>> Changes in this revision are:
>>>>>>>> v2 -> v3:
>>>>>>>> - This series changes the longer attribute name to "latency_nice" as per
>>>>>>>>      the comment from Dietmar Eggemann
>>>>>>>> https://lkml.org/lkml/2019/12/5/394
>>>>>>>> v1 -> v2:
>>>>>>>> - Addressed comments from Qais Yousef
>>>>>>>> - As per suggestion from Dietmar, moved content from newly created
>>>>>>>>      include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
>>>>>>>> - Extend sched_setattr() to support latency_tolerance in tools
>>>>>>>> headers UAPI
>>>>>>>>
>>>>>>>>
>>>>>>>> Introduction:
>>>>>>>> ==============
>>>>>>>> This patch series introduces a new per-task attribute latency_nice to
>>>>>>>> provide the scheduler hints about the latency requirements of the
>>>>>>>> task [1].
>>>>>>>>
>>>>>>>> Latency_nice is a ranged attribute of a task with the value ranging
>>>>>>>> from [-20, 19] both inclusive which makes it align with the task nice
>>>>>>>> value.
>>>>>>>>
>>>>>>>> The value should provide scheduler hints about the relative latency
>>>>>>>> requirements of tasks, meaning the task with "latency_nice = -20"
>>>>>>>> should have lower latency requirements than compared to those tasks with
>>>>>>>> higher values. Similarly a task with "latency_nice = 19" can have higher
>>>>>>>> latency and hence such tasks may not care much about latency.
>>>>>>>>
>>>>>>>> The default value is set to 0. The usecases discussed below can use this
>>>>>>>> range of [-20, 19] for latency_nice for the specific purpose. This
>>>>>>>> patch does not implement any use cases for such attribute so that any
>>>>>>>> change in naming or range does not affect much to the other (future)
>>>>>>>> patches using this. The actual use of latency_nice during task wakeup
>>>>>>>> and load-balancing is yet to be coded for each of those usecases.
>>>>>>>>
>>>>>>>> As per my view, this defined attribute can be used in following ways
>>>>>>>> for a
>>>>>>>> some of the usecases:
>>>>>>>> 1 Reduce search scan time for select_idle_cpu():
>>>>>>>> - Reduce search scans for finding idle CPU for a waking task with lower
>>>>>>>>      latency_nice values.
>>>>>>>>
>>>>>>>> 2 TurboSched:
>>>>>>>> - Classify the tasks with higher latency_nice values as a small
>>>>>>>>      background task given that its historic utilization is very low, for
>>>>>>>>      which the scheduler can search for more number of cores to do task
>>>>>>>>      packing.  A task with a latency_nice >= some_threshold (e.g, == 19)
>>>>>>>>      and util <= 12.5% can be background tasks.
>>>>>>>>
>>>>>>>> 3 Optimize AVX512 based workload:
>>>>>>>> - Bias scheduler to not put a task having (latency_nice == -20) on a
>>>>>>>>      core occupying AVX512 based workload.
>>>>>>>>
>>>>>>>>
>>>>>>>> Series Organization:
>>>>>>>> ====================
>>>>>>>> - Patch 1: Add new attribute latency_nice to task_struct.
>>>>>>>> - Patch 2: Clone parent task's attribute to the child task on fork
>>>>>>>> - Patch 3: Add support for sched_{set,get}attr syscall to modify
>>>>>>>>               latency_nice of the task
>>>>>>>>
>>>>>>>>
>>>>>>>> The patch series can be applied on tip/sched/core at the
>>>>>>>> commit 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
>>>>>>>>
>>>>>>>>
>>>>>>>> References:
>>>>>>>> ============
>>>>>>>> [1]. Usecases for the per-task latency-nice attribute,
>>>>>>>>         https://lkml.org/lkml/2019/9/30/215
>>>>>>>> [2]. Task Latency-nice, "Subhra Mazumdar",
>>>>>>>>         https://lkml.org/lkml/2019/8/30/829
>>>>>>>> [3]. Introduce per-task latency_tolerance for scheduler hints,
>>>>>>>>         https://lkml.org/lkml/2019/12/8/10
>>>>>>>>
>>>>>>>>
>>>>>>>> Parth Shah (3):
>>>>>>>>      sched: Introduce latency-nice as a per-task attribute
>>>>>>>>      sched/core: Propagate parent task's latency requirements to the
>>>>>>>> child
>>>>>>>>        task
>>>>>>>>      sched: Allow sched_{get,set}attr to change latency_nice of the task
>>>>>>>>
>>>>>>>>     include/linux/sched.h            |  1 +
>>>>>>>>     include/uapi/linux/sched.h       |  4 +++-
>>>>>>>>     include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
>>>>>>>>     kernel/sched/core.c              | 21 +++++++++++++++++++++
>>>>>>>>     kernel/sched/sched.h             | 18 ++++++++++++++++++
>>>>>>>>     tools/include/uapi/linux/sched.h |  4 +++-
>>>>>>>>     6 files changed, 65 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> Its been a long time and few revisions since the beginning of the
>>>>>>> discussion around the latency-nice. Hence thought of asking if there
>>>>>>> is/are
>>>>>>> any further work that needs to be done for adding latency-nice
>>>>>>> attribute or
>>>>>>> am I missing any piece in here?
>>>>>>
>>>>>> All, I was asked to take a look at the original latency_nice patchset.
>>>>>> First, to clarify objectives, Oracle is not interested in trading
>>>>>> throughput for latency. What we found is that the DB has specific tasks
>>>>>> which do very little but need to do this as absolutely quickly as
>>>>>> possible,
>>>>>> ie extreme latency sensitivity. Second, the key to latency reduction in
>>>>>> the
>>>>>> task wakeup path seems to be limiting variations of "idle cpu" search. The
>>>>>> latter particularly interests me as an example of "platform size based
>>>>>> latency" which I believe to be important given all the varying size VMs
>>>>>> and
>>>>>> containers.
>>>>>>
>>>>>> Parth, I've been using your v3 patchset as the basis of an investigation
>>>>>> into the measurable effects of short-circuiting this search. I'm not quite
>>>>>> ready to put anything out, but the patchset is working well. The only
>>>>>
>>>>> That's a good news as you are able to get a usecase of this patch-set.
>>>>>
>>>>>> feedback I have is that currently non-root can set the value negative
>>>>>> which
>>>>>> is inconsistent with 'nice' and I would think a security hole.
>>>>>>
>>>>>
>>>>> I would assume you mean 'latency_nice' here.
>>>>>
>>>>>   From my testing, I was not able to set values for any root owned task's
>>>>> latency_nice value by the non-root user. Also, my patch-set just piggybacks
>>>>> on the already existing sched_setattr syscall and hence it should not allow
>>>>> non-root user to do any modifications. Can you confirm this by changing
>>>>> nice (renice) value of a root task from non-root user.
>>>>>
>>>>> I have done the sanity check in the code and thinking where it could
>>>>> possibly have gone wrong. So, can you please specify what values were you
>>>>> able to set outside the [-20, 19] range?
>>>>
>>>> The checks prevent being outside that range. But negative numbers -20 to
>>>> -1 did not need root. Let me dig some more. I verified this explicitly
>>>> before sending the email so something is up.
>>>
>>> I went digging. This is absolutely repeatable. I checked that I do not
>>> unknowingly have CAP_SYS_NICE as a user. So first, are we tying
>>> latency_nice to CAP_SYS_NICE? Seems like a reasonable thing, but not sure I
>>> saw this stated anywhere. Second, the only capability checked in
>>> __sched_setscheduler() in the patch I have is CAP_SYS_NICE and those checks
>>> will not return a -EPERM for a negative latency_tolerance (in the code, aka
>>> latency_nice). Do I have the correct version of the code? Am I missing
>>> something?
>>
>> You are right. I have not added permission checks for setting the
>> latency_nice value. For the task_nice, non-root user has no permission to
>> set the value lower than the current value which is not the case with the
>> latency_nice.
>>
>> In order to align with the permission checks like task_nice, I will add the
>> check similar to task_nice and send out the v4 of the series soon.
>>
>>
>> Thanks for pointing out.
>> - Parth
>>
> 
> The below diff works out well enough in-order to align permission checks
> with NICE.
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2bfcff5623f9..ef4a397c9170 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4878,6 +4878,10 @@ static int __sched_setscheduler(struct task_struct *p,
>                          return -EINVAL;
>                  if (attr->sched_latency_nice < MIN_LATENCY_NICE)
>                          return -EINVAL;
> +               /* Use the same security checks as NICE */
> +               if (attr->sched_latency_nice < p->latency_nice &&
> +                   !can_nice(p, attr->sched_latency_nice))
> +                       return -EPERM;
>          }
> 
>          if (pi)
> 
> With the above in effect,
> A non-root user can only increase the value upto +19, and once increased
> cannot be decreased. e.g., a user once sets the value latency_nice = 19,
> the same user cannot set the value latency_nice = 18. This is the same
> effect as with NICE.
> 
> Is such permission checks required?
> 
> Unlike NICE, we are going to use latency_nice for scheduler hints only, and
> so won't it make more sense to allow a user to increase/decrease the values
> of their owned tasks?

Whether called a hint or not, it is a trade-off to reduce latency of select tasks at the expense of the throughput of 
the other tasks in the the system. If any of the other tasks belong to other users, you would presumably require permission.

-chrish


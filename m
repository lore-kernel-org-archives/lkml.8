Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12313C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4048208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBTIe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:34:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726501AbgBTIe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:34:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K8T6cj194720
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 03:34:27 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubwfxd2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 03:34:27 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 20 Feb 2020 08:34:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Feb 2020 08:34:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01K8YJC150921684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 08:34:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7998A4C04A;
        Thu, 20 Feb 2020 08:34:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2471B4C040;
        Thu, 20 Feb 2020 08:34:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Feb 2020 08:34:16 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
To:     chris hyser <chris.hyser@oracle.com>, vincent.guittot@linaro.org,
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
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 20 Feb 2020 14:04:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1e216d18-7ec0-4a0d-e124-b730d6e03e6f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022008-0016-0000-0000-000002E8840A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022008-0017-0000-0000-0000334B9F53
Message-Id: <de5d8886-6f70-a3fa-8061-5877cd1d98f5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/20 11:53 PM, chris hyser wrote:
> 
> 
> On 2/19/20 9:15 AM, chris hyser wrote:
>>
>>
>> On 2/19/20 5:09 AM, Parth Shah wrote:
>>> Hi Chris,
>>>
>>> On 2/19/20 4:30 AM, chris hyser wrote:
>>>> On 2/17/20 3:57 AM, Parth Shah wrote:
>>>>>
>>>>>
>>>>> On 1/16/20 5:32 PM, Parth Shah wrote:
>>>>>> This is the 3rd revision of the patch set to introduce
>>>>>> latency_{nice/tolerance} as a per task attribute.
>>>>>>
>>>>>> The previous version can be found at:
>>>>>> v1: https://lkml.org/lkml/2019/11/25/151
>>>>>> v2: https://lkml.org/lkml/2019/12/8/10
>>>>>>
>>>>>> Changes in this revision are:
>>>>>> v2 -> v3:
>>>>>> - This series changes the longer attribute name to "latency_nice" as per
>>>>>>     the comment from Dietmar Eggemann
>>>>>> https://lkml.org/lkml/2019/12/5/394
>>>>>> v1 -> v2:
>>>>>> - Addressed comments from Qais Yousef
>>>>>> - As per suggestion from Dietmar, moved content from newly created
>>>>>>     include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
>>>>>> - Extend sched_setattr() to support latency_tolerance in tools
>>>>>> headers UAPI
>>>>>>
>>>>>>
>>>>>> Introduction:
>>>>>> ==============
>>>>>> This patch series introduces a new per-task attribute latency_nice to
>>>>>> provide the scheduler hints about the latency requirements of the
>>>>>> task [1].
>>>>>>
>>>>>> Latency_nice is a ranged attribute of a task with the value ranging
>>>>>> from [-20, 19] both inclusive which makes it align with the task nice
>>>>>> value.
>>>>>>
>>>>>> The value should provide scheduler hints about the relative latency
>>>>>> requirements of tasks, meaning the task with "latency_nice = -20"
>>>>>> should have lower latency requirements than compared to those tasks with
>>>>>> higher values. Similarly a task with "latency_nice = 19" can have higher
>>>>>> latency and hence such tasks may not care much about latency.
>>>>>>
>>>>>> The default value is set to 0. The usecases discussed below can use this
>>>>>> range of [-20, 19] for latency_nice for the specific purpose. This
>>>>>> patch does not implement any use cases for such attribute so that any
>>>>>> change in naming or range does not affect much to the other (future)
>>>>>> patches using this. The actual use of latency_nice during task wakeup
>>>>>> and load-balancing is yet to be coded for each of those usecases.
>>>>>>
>>>>>> As per my view, this defined attribute can be used in following ways
>>>>>> for a
>>>>>> some of the usecases:
>>>>>> 1 Reduce search scan time for select_idle_cpu():
>>>>>> - Reduce search scans for finding idle CPU for a waking task with lower
>>>>>>     latency_nice values.
>>>>>>
>>>>>> 2 TurboSched:
>>>>>> - Classify the tasks with higher latency_nice values as a small
>>>>>>     background task given that its historic utilization is very low, for
>>>>>>     which the scheduler can search for more number of cores to do task
>>>>>>     packing.  A task with a latency_nice >= some_threshold (e.g, == 19)
>>>>>>     and util <= 12.5% can be background tasks.
>>>>>>
>>>>>> 3 Optimize AVX512 based workload:
>>>>>> - Bias scheduler to not put a task having (latency_nice == -20) on a
>>>>>>     core occupying AVX512 based workload.
>>>>>>
>>>>>>
>>>>>> Series Organization:
>>>>>> ====================
>>>>>> - Patch 1: Add new attribute latency_nice to task_struct.
>>>>>> - Patch 2: Clone parent task's attribute to the child task on fork
>>>>>> - Patch 3: Add support for sched_{set,get}attr syscall to modify
>>>>>>              latency_nice of the task
>>>>>>
>>>>>>
>>>>>> The patch series can be applied on tip/sched/core at the
>>>>>> commit 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
>>>>>>
>>>>>>
>>>>>> References:
>>>>>> ============
>>>>>> [1]. Usecases for the per-task latency-nice attribute,
>>>>>>        https://lkml.org/lkml/2019/9/30/215
>>>>>> [2]. Task Latency-nice, "Subhra Mazumdar",
>>>>>>        https://lkml.org/lkml/2019/8/30/829
>>>>>> [3]. Introduce per-task latency_tolerance for scheduler hints,
>>>>>>        https://lkml.org/lkml/2019/12/8/10
>>>>>>
>>>>>>
>>>>>> Parth Shah (3):
>>>>>>     sched: Introduce latency-nice as a per-task attribute
>>>>>>     sched/core: Propagate parent task's latency requirements to the
>>>>>> child
>>>>>>       task
>>>>>>     sched: Allow sched_{get,set}attr to change latency_nice of the task
>>>>>>
>>>>>>    include/linux/sched.h            |  1 +
>>>>>>    include/uapi/linux/sched.h       |  4 +++-
>>>>>>    include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
>>>>>>    kernel/sched/core.c              | 21 +++++++++++++++++++++
>>>>>>    kernel/sched/sched.h             | 18 ++++++++++++++++++
>>>>>>    tools/include/uapi/linux/sched.h |  4 +++-
>>>>>>    6 files changed, 65 insertions(+), 2 deletions(-)
>>>>>>
>>>>>
>>>>> Its been a long time and few revisions since the beginning of the
>>>>> discussion around the latency-nice. Hence thought of asking if there
>>>>> is/are
>>>>> any further work that needs to be done for adding latency-nice
>>>>> attribute or
>>>>> am I missing any piece in here?
>>>>
>>>> All, I was asked to take a look at the original latency_nice patchset.
>>>> First, to clarify objectives, Oracle is not interested in trading
>>>> throughput for latency. What we found is that the DB has specific tasks
>>>> which do very little but need to do this as absolutely quickly as
>>>> possible,
>>>> ie extreme latency sensitivity. Second, the key to latency reduction in
>>>> the
>>>> task wakeup path seems to be limiting variations of "idle cpu" search. The
>>>> latter particularly interests me as an example of "platform size based
>>>> latency" which I believe to be important given all the varying size VMs
>>>> and
>>>> containers.
>>>>
>>>> Parth, I've been using your v3 patchset as the basis of an investigation
>>>> into the measurable effects of short-circuiting this search. I'm not quite
>>>> ready to put anything out, but the patchset is working well. The only
>>>
>>> That's a good news as you are able to get a usecase of this patch-set.
>>>
>>>> feedback I have is that currently non-root can set the value negative
>>>> which
>>>> is inconsistent with 'nice' and I would think a security hole.
>>>>
>>>
>>> I would assume you mean 'latency_nice' here.
>>>
>>>  From my testing, I was not able to set values for any root owned task's
>>> latency_nice value by the non-root user. Also, my patch-set just piggybacks
>>> on the already existing sched_setattr syscall and hence it should not allow
>>> non-root user to do any modifications. Can you confirm this by changing
>>> nice (renice) value of a root task from non-root user.
>>>
>>> I have done the sanity check in the code and thinking where it could
>>> possibly have gone wrong. So, can you please specify what values were you
>>> able to set outside the [-20, 19] range?
>>
>> The checks prevent being outside that range. But negative numbers -20 to
>> -1 did not need root. Let me dig some more. I verified this explicitly
>> before sending the email so something is up.
> 
> I went digging. This is absolutely repeatable. I checked that I do not
> unknowingly have CAP_SYS_NICE as a user. So first, are we tying
> latency_nice to CAP_SYS_NICE? Seems like a reasonable thing, but not sure I
> saw this stated anywhere. Second, the only capability checked in
> __sched_setscheduler() in the patch I have is CAP_SYS_NICE and those checks
> will not return a -EPERM for a negative latency_tolerance (in the code, aka
> latency_nice). Do I have the correct version of the code? Am I missing
> something?

You are right. I have not added permission checks for setting the
latency_nice value. For the task_nice, non-root user has no permission to
set the value lower than the current value which is not the case with the
latency_nice.

In order to align with the permission checks like task_nice, I will add the
check similar to task_nice and send out the v4 of the series soon.


Thanks for pointing out.
- Parth

> 
> -chrish
> 


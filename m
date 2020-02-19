Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC4C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F1124670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B0Qe2dWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBSSYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:24:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38646 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSSYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:24:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JII3DO014201;
        Wed, 19 Feb 2020 18:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jbnJM4rNIjNPmdRErzdwMajsBuKjiG4qkFUf4wgYzzw=;
 b=B0Qe2dWSxtA6r5nKemWGbirRURsnjuEEoAe3HTjmgJE02PyuwyPMBiE4S4nNbknK1UKC
 AiySEgqqRJm8IsYVUWWM4tpR2iozjt0gfQdVRT9msQVRwt7buMVLXfa3eAC+iyCyrkdd
 DaZ6+clacMnGMdLn5UDP6SSuoRdKivWw53DVM0aHIu9xAL6qGiIi+qrPBig23glNyQ0x
 YuwmalOcZxEZJrLbWGrw8HSg8Oo7yxtQxzFa2IKayuQhFKmPiCFjapDGyKvUDeBrRZWI
 9NdRv6sXLfZ/3NfCGC7XpOif0gTvSSI8E/z6LPue93wcOpXyPc4VKHgmygWZ5gdQino2 AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y8ud14yd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 18:23:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JIIDWO056046;
        Wed, 19 Feb 2020 18:23:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y8udb0ayx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 18:23:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JINYdi027994;
        Wed, 19 Feb 2020 18:23:35 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 10:23:34 -0800
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
From:   chris hyser <chris.hyser@oracle.com>
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
Message-ID: <1e216d18-7ec0-4a0d-e124-b730d6e03e6f@oracle.com>
Date:   Wed, 19 Feb 2020 13:23:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8e984496-e89b-d96c-d84e-2be7f0958ea4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/20 9:15 AM, chris hyser wrote:
> 
> 
> On 2/19/20 5:09 AM, Parth Shah wrote:
>> Hi Chris,
>>
>> On 2/19/20 4:30 AM, chris hyser wrote:
>>> On 2/17/20 3:57 AM, Parth Shah wrote:
>>>>
>>>>
>>>> On 1/16/20 5:32 PM, Parth Shah wrote:
>>>>> This is the 3rd revision of the patch set to introduce
>>>>> latency_{nice/tolerance} as a per task attribute.
>>>>>
>>>>> The previous version can be found at:
>>>>> v1: https://lkml.org/lkml/2019/11/25/151
>>>>> v2: https://lkml.org/lkml/2019/12/8/10
>>>>>
>>>>> Changes in this revision are:
>>>>> v2 -> v3:
>>>>> - This series changes the longer attribute name to "latency_nice" as per
>>>>>     the comment from Dietmar Eggemann https://lkml.org/lkml/2019/12/5/394
>>>>> v1 -> v2:
>>>>> - Addressed comments from Qais Yousef
>>>>> - As per suggestion from Dietmar, moved content from newly created
>>>>>     include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
>>>>> - Extend sched_setattr() to support latency_tolerance in tools headers UAPI
>>>>>
>>>>>
>>>>> Introduction:
>>>>> ==============
>>>>> This patch series introduces a new per-task attribute latency_nice to
>>>>> provide the scheduler hints about the latency requirements of the task [1].
>>>>>
>>>>> Latency_nice is a ranged attribute of a task with the value ranging
>>>>> from [-20, 19] both inclusive which makes it align with the task nice
>>>>> value.
>>>>>
>>>>> The value should provide scheduler hints about the relative latency
>>>>> requirements of tasks, meaning the task with "latency_nice = -20"
>>>>> should have lower latency requirements than compared to those tasks with
>>>>> higher values. Similarly a task with "latency_nice = 19" can have higher
>>>>> latency and hence such tasks may not care much about latency.
>>>>>
>>>>> The default value is set to 0. The usecases discussed below can use this
>>>>> range of [-20, 19] for latency_nice for the specific purpose. This
>>>>> patch does not implement any use cases for such attribute so that any
>>>>> change in naming or range does not affect much to the other (future)
>>>>> patches using this. The actual use of latency_nice during task wakeup
>>>>> and load-balancing is yet to be coded for each of those usecases.
>>>>>
>>>>> As per my view, this defined attribute can be used in following ways for a
>>>>> some of the usecases:
>>>>> 1 Reduce search scan time for select_idle_cpu():
>>>>> - Reduce search scans for finding idle CPU for a waking task with lower
>>>>>     latency_nice values.
>>>>>
>>>>> 2 TurboSched:
>>>>> - Classify the tasks with higher latency_nice values as a small
>>>>>     background task given that its historic utilization is very low, for
>>>>>     which the scheduler can search for more number of cores to do task
>>>>>     packing.  A task with a latency_nice >= some_threshold (e.g, == 19)
>>>>>     and util <= 12.5% can be background tasks.
>>>>>
>>>>> 3 Optimize AVX512 based workload:
>>>>> - Bias scheduler to not put a task having (latency_nice == -20) on a
>>>>>     core occupying AVX512 based workload.
>>>>>
>>>>>
>>>>> Series Organization:
>>>>> ====================
>>>>> - Patch 1: Add new attribute latency_nice to task_struct.
>>>>> - Patch 2: Clone parent task's attribute to the child task on fork
>>>>> - Patch 3: Add support for sched_{set,get}attr syscall to modify
>>>>>              latency_nice of the task
>>>>>
>>>>>
>>>>> The patch series can be applied on tip/sched/core at the
>>>>> commit 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
>>>>>
>>>>>
>>>>> References:
>>>>> ============
>>>>> [1]. Usecases for the per-task latency-nice attribute,
>>>>>        https://lkml.org/lkml/2019/9/30/215
>>>>> [2]. Task Latency-nice, "Subhra Mazumdar",
>>>>>        https://lkml.org/lkml/2019/8/30/829
>>>>> [3]. Introduce per-task latency_tolerance for scheduler hints,
>>>>>        https://lkml.org/lkml/2019/12/8/10
>>>>>
>>>>>
>>>>> Parth Shah (3):
>>>>>     sched: Introduce latency-nice as a per-task attribute
>>>>>     sched/core: Propagate parent task's latency requirements to the child
>>>>>       task
>>>>>     sched: Allow sched_{get,set}attr to change latency_nice of the task
>>>>>
>>>>>    include/linux/sched.h            |  1 +
>>>>>    include/uapi/linux/sched.h       |  4 +++-
>>>>>    include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
>>>>>    kernel/sched/core.c              | 21 +++++++++++++++++++++
>>>>>    kernel/sched/sched.h             | 18 ++++++++++++++++++
>>>>>    tools/include/uapi/linux/sched.h |  4 +++-
>>>>>    6 files changed, 65 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> Its been a long time and few revisions since the beginning of the
>>>> discussion around the latency-nice. Hence thought of asking if there is/are
>>>> any further work that needs to be done for adding latency-nice attribute or
>>>> am I missing any piece in here?
>>>
>>> All, I was asked to take a look at the original latency_nice patchset.
>>> First, to clarify objectives, Oracle is not interested in trading
>>> throughput for latency. What we found is that the DB has specific tasks
>>> which do very little but need to do this as absolutely quickly as possible,
>>> ie extreme latency sensitivity. Second, the key to latency reduction in the
>>> task wakeup path seems to be limiting variations of "idle cpu" search. The
>>> latter particularly interests me as an example of "platform size based
>>> latency" which I believe to be important given all the varying size VMs and
>>> containers.
>>>
>>> Parth, I've been using your v3 patchset as the basis of an investigation
>>> into the measurable effects of short-circuiting this search. I'm not quite
>>> ready to put anything out, but the patchset is working well. The only
>>
>> That's a good news as you are able to get a usecase of this patch-set.
>>
>>> feedback I have is that currently non-root can set the value negative which
>>> is inconsistent with 'nice' and I would think a security hole.
>>>
>>
>> I would assume you mean 'latency_nice' here.
>>
>>  From my testing, I was not able to set values for any root owned task's
>> latency_nice value by the non-root user. Also, my patch-set just piggybacks
>> on the already existing sched_setattr syscall and hence it should not allow
>> non-root user to do any modifications. Can you confirm this by changing
>> nice (renice) value of a root task from non-root user.
>>
>> I have done the sanity check in the code and thinking where it could
>> possibly have gone wrong. So, can you please specify what values were you
>> able to set outside the [-20, 19] range?
> 
> The checks prevent being outside that range. But negative numbers -20 to -1 did not need root. Let me dig some more. I 
> verified this explicitly before sending the email so something is up.

I went digging. This is absolutely repeatable. I checked that I do not unknowingly have CAP_SYS_NICE as a user. So 
first, are we tying latency_nice to CAP_SYS_NICE? Seems like a reasonable thing, but not sure I saw this stated 
anywhere. Second, the only capability checked in __sched_setscheduler() in the patch I have is CAP_SYS_NICE and those 
checks will not return a -EPERM for a negative latency_tolerance (in the code, aka latency_nice). Do I have the correct 
version of the code? Am I missing something?

-chrish


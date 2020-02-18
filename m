Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE92C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D4024654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jBmXAvOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBRXBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:01:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRXBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:01:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IMs4ce130613;
        Tue, 18 Feb 2020 23:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2jm1vtYXrgUaPury/ZK7GJHjnig0MDzvN+F1MFqzKJ0=;
 b=jBmXAvOxbNvHcuFE35sR0ak/w+bcUO34Icg7Rqlm5a0of63q2CxL9hVmBioX7n1fLTe0
 Cs6BdikPGkQZC8A5Ra6O0NOorm2V5spSEKRUjxr/GYJKJ3oZzKkfCEklzosb8EfQgtLV
 +pvbcRD5iSOvLk2ngH2iO4+iF5wwB0TOfIXr1V4fiUWYYLWXfGe+CmtbAXQEMtmj3ddc
 amRaR1ba9155DP1KC+2x16dD8+mly5dgQj5Nud7covADofJ5Y728RUlDy7CDtBf5c5Lo
 wGf6iMB7htCSkKLg+zDDZgF/1gAkzThg1jFmlgI7DOstLKiNnbOA7E3khWqobklvhpAB ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y699rsejv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 23:00:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IMwPWd049835;
        Tue, 18 Feb 2020 23:00:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y82c29jgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 23:00:33 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01IN0Rhn013552;
        Tue, 18 Feb 2020 23:00:28 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 15:00:27 -0800
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
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
Date:   Tue, 18 Feb 2020 18:00:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 3:57 AM, Parth Shah wrote:
> 
> 
> On 1/16/20 5:32 PM, Parth Shah wrote:
>> This is the 3rd revision of the patch set to introduce
>> latency_{nice/tolerance} as a per task attribute.
>>
>> The previous version can be found at:
>> v1: https://lkml.org/lkml/2019/11/25/151
>> v2: https://lkml.org/lkml/2019/12/8/10
>>
>> Changes in this revision are:
>> v2 -> v3:
>> - This series changes the longer attribute name to "latency_nice" as per
>>    the comment from Dietmar Eggemann https://lkml.org/lkml/2019/12/5/394
>> v1 -> v2:
>> - Addressed comments from Qais Yousef
>> - As per suggestion from Dietmar, moved content from newly created
>>    include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
>> - Extend sched_setattr() to support latency_tolerance in tools headers UAPI
>>
>>
>> Introduction:
>> ==============
>> This patch series introduces a new per-task attribute latency_nice to
>> provide the scheduler hints about the latency requirements of the task [1].
>>
>> Latency_nice is a ranged attribute of a task with the value ranging
>> from [-20, 19] both inclusive which makes it align with the task nice
>> value.
>>
>> The value should provide scheduler hints about the relative latency
>> requirements of tasks, meaning the task with "latency_nice = -20"
>> should have lower latency requirements than compared to those tasks with
>> higher values. Similarly a task with "latency_nice = 19" can have higher
>> latency and hence such tasks may not care much about latency.
>>
>> The default value is set to 0. The usecases discussed below can use this
>> range of [-20, 19] for latency_nice for the specific purpose. This
>> patch does not implement any use cases for such attribute so that any
>> change in naming or range does not affect much to the other (future)
>> patches using this. The actual use of latency_nice during task wakeup
>> and load-balancing is yet to be coded for each of those usecases.
>>
>> As per my view, this defined attribute can be used in following ways for a
>> some of the usecases:
>> 1 Reduce search scan time for select_idle_cpu():
>> - Reduce search scans for finding idle CPU for a waking task with lower
>>    latency_nice values.
>>
>> 2 TurboSched:
>> - Classify the tasks with higher latency_nice values as a small
>>    background task given that its historic utilization is very low, for
>>    which the scheduler can search for more number of cores to do task
>>    packing.  A task with a latency_nice >= some_threshold (e.g, == 19)
>>    and util <= 12.5% can be background tasks.
>>
>> 3 Optimize AVX512 based workload:
>> - Bias scheduler to not put a task having (latency_nice == -20) on a
>>    core occupying AVX512 based workload.
>>
>>
>> Series Organization:
>> ====================
>> - Patch 1: Add new attribute latency_nice to task_struct.
>> - Patch 2: Clone parent task's attribute to the child task on fork
>> - Patch 3: Add support for sched_{set,get}attr syscall to modify
>>    	     latency_nice of the task
>>
>>
>> The patch series can be applied on tip/sched/core at the
>> commit 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
>>
>>
>> References:
>> ============
>> [1]. Usecases for the per-task latency-nice attribute,
>>       https://lkml.org/lkml/2019/9/30/215
>> [2]. Task Latency-nice, "Subhra Mazumdar",
>>       https://lkml.org/lkml/2019/8/30/829
>> [3]. Introduce per-task latency_tolerance for scheduler hints,
>>       https://lkml.org/lkml/2019/12/8/10
>>
>>
>> Parth Shah (3):
>>    sched: Introduce latency-nice as a per-task attribute
>>    sched/core: Propagate parent task's latency requirements to the child
>>      task
>>    sched: Allow sched_{get,set}attr to change latency_nice of the task
>>
>>   include/linux/sched.h            |  1 +
>>   include/uapi/linux/sched.h       |  4 +++-
>>   include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
>>   kernel/sched/core.c              | 21 +++++++++++++++++++++
>>   kernel/sched/sched.h             | 18 ++++++++++++++++++
>>   tools/include/uapi/linux/sched.h |  4 +++-
>>   6 files changed, 65 insertions(+), 2 deletions(-)
>>
> 
> Its been a long time and few revisions since the beginning of the
> discussion around the latency-nice. Hence thought of asking if there is/are
> any further work that needs to be done for adding latency-nice attribute or
> am I missing any piece in here?

All, I was asked to take a look at the original latency_nice patchset. First, to clarify objectives, Oracle is not 
interested in trading throughput for latency. What we found is that the DB has specific tasks which do very little but 
need to do this as absolutely quickly as possible, ie extreme latency sensitivity. Second, the key to latency reduction 
in the task wakeup path seems to be limiting variations of "idle cpu" search. The latter particularly interests me as an 
example of "platform size based latency" which I believe to be important given all the varying size VMs and containers.

Parth, I've been using your v3 patchset as the basis of an investigation into the measurable effects of short-circuiting 
this search. I'm not quite ready to put anything out, but the patchset is working well. The only feedback I have is that 
currently non-root can set the value negative which is inconsistent with 'nice' and I would think a security hole.

-chrish

Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62F1C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE63A2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zkvbz5AZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFQhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:37:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgCFQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:37:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026GO3jm057857;
        Fri, 6 Mar 2020 16:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9ZCQRPE4NdnV5SiDVz+scsYqRIMTLEQ9Pcsn2lnmDDI=;
 b=Zkvbz5AZq/9hJV58lqyFWgxGe8nW2hHrkmgqgTq8AcuycF7ItnWv40QCKM2BeOVIdzik
 tHmpzGDGbzUKomAD01t9OIpmeMMfGyMKHoSgbjZthSX5CoE6cdE5EEXel7tqFgVxobUz
 TefJK2rS4mDKWxAhq0TZ9nKKkWoqoiZBOAMS0fHqQDp6HMymEFVYwgblwo/ff/bDqeMe
 it5vo6zeb76/zU0cJJ0qcvvGGUTrYqaVfDd/xDmGOH0WMkjrKNfehkOXX5l+00PRjmgS
 sY0uEnlgq9RTq2asNHXIQWTB2h3TfBUb5RLsReH+KW8+qFLnfY0TBY//t7CtUd7L4i3k ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ykgys2vyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 16:36:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026GDOLN155623;
        Fri, 6 Mar 2020 16:36:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yg1h655wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 16:36:22 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 026GaD9C014797;
        Fri, 6 Mar 2020 16:36:14 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 08:36:13 -0800
Subject: Re: [PATCH v5 0/4] Introduce per-task latency_nice for scheduler
 hints
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        pkondeti@codeaurora.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20200228090755.22829-1-parth@linux.ibm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <2bf111d3-bc0a-80ef-29e4-b8487701e428@oracle.com>
Date:   Fri, 6 Mar 2020 11:36:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200228090755.22829-1-parth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 4:07 AM, Parth Shah wrote:
> This is the 5th revision of the patch set to introduce latency_nice as a
> per task attribute.
> 
> The previous version can be found at:
> v1: https://lkml.org/lkml/2019/11/25/151
> v2: https://lkml.org/lkml/2019/12/8/10
> v3: https://lkml.org/lkml/2020/1/16/319
> v4: https://lkml.org/lkml/2020/2/24/216
> 
> Changes in this revision are:
> v4->v5:
> - Added debugging prints in /proc/<pid>/sched for latency_nice ( based on
>    suggestion from Pavan Kondeti )
> - Initialized init_task with latency_nice = 0
> - Collected review tag and added few minor fixes.
> v3->v4:
> - Based on Chris's comment, added security check to refrain non-root user
>    set lower value than the current latency_nice values.
> v2 -> v3:
> - This series changes the longer attribute name to "latency_nice" as per
>    the comment from Dietmar Eggemann https://lkml.org/lkml/2019/12/5/394
> v1 -> v2:
> - Addressed comments from Qais Yousef
> - As per suggestion from Dietmar, moved content from newly created
>    include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
> - Extend sched_setattr() to support latency_tolerance in tools headers UAPI
> 
> 
> Introduction:
> ==============
> This patch series introduces a new per-task attribute latency_nice to
> provide the scheduler hints about the latency requirements of the task [1].
> 
> Latency_nice is a ranged attribute of a task with the value ranging
> from [-20, 19] both inclusive which makes it align with the task nice
> value.
> 
> The value should provide scheduler hints about the relative latency
> requirements of tasks, meaning the task with "latency_nice = -20"
> should have lower latency requirements than compared to those tasks with
> higher values. Similarly a task with "latency_nice = 19" can have higher
> latency and hence such tasks may not care much about latency.
> 
> The default value is set to 0. The usecases discussed below can use this
> range of [-20, 19] for latency_nice for the specific purpose. This
> patch does not implement any use cases for such attribute so that any
> change in naming or range does not affect much to the other (future)
> patches using this. The actual use of latency_nice during task wakeup
> and load-balancing is yet to be coded for each of those usecases.
> 
> As per my view, this defined attribute can be used in following ways for a
> some of the usecases:
> 1 Reduce search scan time for select_idle_cpu():
> - Reduce search scans for finding idle CPU for a waking task with lower
>    latency_nice values.
> 
> 2 TurboSched:
> - Classify the tasks with higher latency_nice values as a small
>    background task given that its historic utilization is very low, for
>    which the scheduler can search for more number of cores to do task
>    packing.  A task with a latency_nice >= some_threshold (e.g, == 19)
>    and util <= 12.5% can be background tasks.
> 
> 3 Optimize AVX512 based workload:
> - Bias scheduler to not put a task having (latency_nice == -20) on a
>    core occupying AVX512 based workload.
> 
> 
> Series Organization:
> ====================
> - Patch 1-3: Add support for latency_nice attr in the task struct using
>    	     sched_{set,get}attr syscall
> - Patch 4  : Add permission checks for setting the value.
> 
> 
> The patch series can be applied on tip/sched/core at the
> commit a0f03b617c3b ("sched/numa: Stop an exhastive search if a reasonable swap candidate or idle CPU is found")
> 
> 
> References:
> ============
> [1]. Usecases for the per-task latency-nice attribute,
>       https://lkml.org/lkml/2019/9/30/215
> [2]. Task Latency-nice, "Subhra Mazumdar",
>       https://lkml.org/lkml/2019/8/30/829
> [3]. Introduce per-task latency_tolerance for scheduler hints,
>       https://lkml.org/lkml/2019/12/8/10
> 
> 
> 
> Parth Shah (4):
>    sched: Introduce latency-nice as a per-task attribute
>    sched/core: Propagate parent task's latency requirements to the child
>      task
>    sched: Allow sched_{get,set}attr to change latency_nice of the task
>    sched/core: Add permission checks for setting the latency_nice value
> 
>   include/linux/sched.h            |  1 +
>   include/uapi/linux/sched.h       |  4 +++-
>   include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
>   init/init_task.c                 |  1 +
>   kernel/sched/core.c              | 26 ++++++++++++++++++++++++++
>   kernel/sched/debug.c             |  1 +
>   kernel/sched/sched.h             | 18 ++++++++++++++++++
>   tools/include/uapi/linux/sched.h |  4 +++-
>   8 files changed, 72 insertions(+), 2 deletions(-)

I've now had a chance to test and play with this a fair amount. It looks good, meets the need. Thanks Parth.

-chrish

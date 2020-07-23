Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20933C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A97206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGWJdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:33:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19413 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgGWJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:33:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06N9We1o014827;
        Thu, 23 Jul 2020 05:33:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f1pn1j2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:33:33 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N9XXjv017778;
        Thu, 23 Jul 2020 05:33:33 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f1pn1j1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:33:33 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N9FLoN025752;
        Thu, 23 Jul 2020 09:33:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 32brbgu5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 09:33:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06N9XSci63242332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 09:33:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E25F3A405B;
        Thu, 23 Jul 2020 09:33:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 653ECA405C;
        Thu, 23 Jul 2020 09:33:25 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.85.82.72])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 09:33:25 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
Subject: Re: [SchedulerTaskPacking] Small background task packing
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
 <39cc4666-6355-fb9f-654d-e85e1852bc6f@linux.ibm.com>
 <CAKfTPtAxcdQ=bNapyvsrG_Cb6p8h2ut4=waiSPmay+tNxF8fZQ@mail.gmail.com>
Message-ID: <1c58efd6-91c0-3295-0f93-2eb45b2f0b6f@linux.ibm.com>
Date:   Thu, 23 Jul 2020 15:03:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAxcdQ=bNapyvsrG_Cb6p8h2ut4=waiSPmay+tNxF8fZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 7/20/20 8:50 PM, Vincent Guittot wrote:
> Hi Parth,
> 
> On Thu, 9 Jul 2020 at 14:09, Parth Shah <parth@linux.ibm.com> wrote:
>>
>>> A) Name:
>>
>> Small background task packing
>>
>>> B) Target behaviour:
>>
>> All fair task wakeup follows a procedure of finding an idle CPU and
>> waking the task on this idle CPU. There are two major wakeup paths:
>> 1. Slow-path: Wake up the task on an idle CPU which is in the shallowest
>> idle states by searching in the highest sched_domain flagged with
>> SD_BALANCE_FORK or SD_BALANCE_EXEC.
>> 2. Fast-path: Wake up the task on an idle CPU in the LLC sched_domain of
>> the waker CPU. There are optimization to bias task placement on prev_cpu or
>> wake_cpu of the task. This path is majorly used except in few cases like
>> during fork() and exec().
>>
>> This assumption of picking an idle CPU is fair in-order to uniformly
>> consume system resources. But not all tasks deserves to wakeup an idle core
>> as it can hurt power consumption. For e.g. like small background tasks
>> waking up an idle core and runs only for very small duration. Reducing
>> number of active cores allows busier cores to boost frequency and hence
>> saving power can also result in performance benefits.
>>
>> There is no mechanism in existing wake up path to detect small
>> background tasks which can be packed on fewer cores.
>>
>>> C) Existing control paths:
>>
>> fair:: .select_task_rq = select_task_rq_fair
>>
>> fair::select_task_rq_fair()
>>     // 1) Slow-path: find idle CPU with shallowest idle states
>>     find_idlest_cpu()
>>
>>     // 2) Fast-path: find idle CPU
>>     fair:select_idle_sibling()
>>         // Wake up on idle core if available
>>         fair:select_idle_core()
>>         // Else wakeup on idle CPU if available
>>         fair:select_idle_cpu()
>>         fair:select_idle_smt()
>>
>>
>> There are multiple ways to call fair:select_task_rq_fair();
>>
>> // 1) try_to_wake_up which should lead to fast-path
>>    core::try_to_wake_up()
>>       cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
>>
>> // 2) wake_up_new_task which should lead to slow-path
>>    core::wake_up_new_task()
>>       __set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK,0));
>>
>> // 3) sched_exec which should lead to slow-path
>>    core::sched_exec()
>>       dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p),
>> SD_BALANCE_EXEC, 0);
>>
>>> D) Desired behaviour:
>>
>> Latency tolerant tasks with small utilization should be packed
>> on a busy core rather than waking up a new core/CPU.
>>
>> Upon detecting small-background tasks, different code-path can be used to
>> search for a busy core as described below;
>>
>> sched/fair.c:
>> static inline bool is_small_bg_task(struct task_struct *p)
>> {
>>         if (is_latency_tolerant(p) &&
>>             (task_util(p) > (SCHED_CAPACITY_SCALE >> 3)))
> 
> This condition seems to be quite arbitrary and probably works on your
> current platform but other platforms might want another threshold. Is
> there a way to know how much utilization can be added to a CPU which
> would not use more capacity than the extra capacity that is provided
> by the turbo mode ?
> 

I guess not because we will have to predict if adding a task to the CPU
will hit power limit or thermal limit.
Predicting power limit is complicated, one complexity is in finding the
current idle-state of all CPUs in the DIE which is not possible in servers
(because hardware may use different C-state than the one requested by
cpuidle driver)
Other complexity is in detecting thermal limit which will require
determining the nature of the workload e.g. SIMD/FPU based workload will
burn more power than ALU workloads and heat up the core.

So this is heuristics at the end which might need to be tuned for each
system. We can either have arch specific threshold defined in kernel,
kernel parameter or something like that.

> Also you may want to use task_util_est() instead of task_util() to
> make sure that the small background task has low chance to become a
> large one and not use more capacity than the one provided by turbo at
> the end
> 

I agree. using task_util_est() will be better here for estimating near
future utilization.


>>                 return true;
>>
>>         return false;
>> }
>>
>> sched/fair.c: in select_task_rq_fair()
>>
>> if (sd_flag & SD_BALANCE_WAKE) {
>>         if (is_small_bg_task(p)) {
>>                 // New proposed wakeup path to do task packing
>>                 new_cpu = select_non_idle_core(p, prev_cpu);
>>                 if (new_cpu >= 0)
>>                         return new_cpu;
>>         }
>> }
>>
>> where select_non_idle_core() searches for a busy core already running some
>> tasks and selects an idle CPU in that busy core to pack the waking task.
>>
>> Complete code can be found on TurboSched patches [1].
>>
>>> E) Existing knobs (if any): reference to whatever existing tunable
>>
>> There are no existing knob which can hint the scheduler about the latency
>> nature of task. Detecting latency nature of the task can help in
>> classifying task as small background tasks to be packed on fewer number of
>> cores.
>>
>> There are user-space hacks to do task packing for background tasks with the
>> use of cpuset.cpus or sched_setaffinity() to manually affine the process to
>> fewer  dedicated cores.
>>
>>> F) Existing knobs (if any): one paragraph description of the limitations
>>
>> Sysadmin/user has to define cpumask for each process (aka task pinning)
>> which is static in nature. There are multiple limitations to pin the small
>> background tasks;
>>
>> - In presence of just one small background task, there is no power
>> consumption benefit here. It would be preferable to pin it to busy CPU.
>>
>> - If a task changes the behavior in its life-cycle then sysadmin will have
>> to manually pin/unpin such tasks. This is limitation of user to classify
>> tasks as only "background "one and cannot say if and when it will be
>> "small" in utilization.
>>
>> - Sysadmin cannot change the task's affinity mask based on the scheduling
>> pattern to give most optimal performance and energy consumption.
>>
>>> G) Proportionality Analysis: check the nature of the target behavior
>>
>> Task packing has to be noninvasive in nature, meaning only the tasks which
>> are latency tolerant should be packed on fewer cores. Providing this
>> behavior needs a run-time tunable knob which can hint the scheduler on
>> whether the waking task can be packed or not.
>>
>> Upon detecting the nature of the task, a specific wakeup path can be followed:
>> 1. On latency-tolerant tasks with low utilization, a new proposed
>> scheduling wakeup path will be followed to do packing
>> 2. On latency-sensitive task, an exiting approach of wakeup can be used.
>>
>>> H) Range Analysis: identify meaningful ranges
>>
>> The new knob can be binary input accepting 0/1, where 0 means
>> latency-sensitive and 1 means latency-tolerant task.
>>
>> Latency-sensitive tasks (value = 0) can search idle CPU in only the llc
>> sched_domain while the latency-tolerance (value = 1) tasks can go across
>> llc sched_domain (just like in slow-path) but here in-order to search for a
>> busy core.
>>
>> Mapping analysis:
>> ================
>> The latency_nice proposal [2] offers a [-20, 19] range which can be
>> mapped into a binary switch, e.g. using a threshold based function.
>>
>> However, it is possible to extend the concept of finding busy core by
>> limiting the time spent on searching based on the latency_nice value from
>> range [-20, 19] where value of 19 indicates searching in the whole chip for
>> a busy core, whereas value of 10 could mean search for half of the cores in
>> the chip.
>>
>>> I) System-Wide tuning: which knobs are required
>>
>> The latency_nice provided knobs should be enough to get the desired
>> effect.
>>
>>> J) Per-Task tuning: which knobs are required
>>
>> sched_setscheduler() is sufficient.
>>
>>> K) Task-Group tuning: which knobs are required
>>
>> A single attribute classifying task-group as latency_nice or
>> latency_tolerant is sufficient.
>>
>>
>>> .:: References
>>> ==============
>>
>> [1] [RFC v6 0/5] TurboSched: A scheduler for sustaining Turbo Frequencies
>>     for longer durations
>>     https://lkml.org/lkml/2020/1/21/39
>> [2] [PATCH v5 0/4] Introduce per-task latency_nice for scheduler hints
>>     Message-ID: 20200228090755.22829-1-parth@linux.ibm.com
>>     https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com
>> [3] TurboSched: the return of small-task packing
>>     https://lwn.net/Articles/792471/
>>     https://www.phoronix.com/scan.php?page=news_item&px=Linux-TurboSched-V4

Thanks,
Parth

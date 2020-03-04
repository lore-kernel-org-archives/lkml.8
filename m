Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A11C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096732146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbgCDTTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:19:42 -0500
Received: from foss.arm.com ([217.140.110.172]:38686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDTTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 551651FB;
        Wed,  4 Mar 2020 11:19:40 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33803F6C4;
        Wed,  4 Mar 2020 11:19:34 -0800 (PST)
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com>
 <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
 <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com>
 <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
 <CAKfTPtBZ2X8i6zMgrA1gNJmwoSnyRc76yXmLZEwboJmF-R9QVg@mail.gmail.com>
 <b664f050-72d6-a483-be0a-8504f687f225@de.ibm.com>
 <20200228163545.GA18662@vingu-book>
 <be45b190-d96c-1893-3ef0-f574eb595256@de.ibm.com>
 <49a2ebb7-c80b-9e2b-4482-7f9ff938417d@de.ibm.com>
 <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
 <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
 <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com>
 <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7be92e79-731b-220d-b187-d38bde80ad16@arm.com>
Date:   Wed, 4 Mar 2020 20:19:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 04/03/2020 18:42, Christian Borntraeger wrote:
> 
> 
> On 04.03.20 16:26, Vincent Guittot wrote:
>> On Tue, 3 Mar 2020 at 08:55, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>>
>>> On Tue, 3 Mar 2020 at 08:37, Christian Borntraeger
>>> <borntraeger@de.ibm.com> wrote:
>>>>
>>>>
>>>>
>> [...]
>>>>>>> ---
>>>>>>>  kernel/sched/fair.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>>> index 3c8a379c357e..beb773c23e7d 100644
>>>>>>> --- a/kernel/sched/fair.c
>>>>>>> +++ b/kernel/sched/fair.c
>>>>>>> @@ -4035,8 +4035,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>>>>>>             __enqueue_entity(cfs_rq, se);
>>>>>>>     se->on_rq = 1;
>>>>>>>
>>>>>>> +   list_add_leaf_cfs_rq(cfs_rq);
>>>>>>>     if (cfs_rq->nr_running == 1) {
>>>>>>> -           list_add_leaf_cfs_rq(cfs_rq);
>>>>>>>             check_enqueue_throttle(cfs_rq);
>>>>>>>     }
>>>>>>>  }
>>>>>>
>>>>>> Now running for 3 hours. I have not seen the issue yet. I can tell tomorrow if this fixes
>>>>>> the issue.
>>>>>
>>>>>
>>>>> Still running fine. I can tell for sure tomorrow, but I have the impression that this makes the
>>>>> WARN_ON go away.
>>>>
>>>> So I guess this change "fixed" the issue. If you want me to test additional patches, let me know.
>>>
>>> Thanks for the test. For now, I don't have any other patch to test. I
>>> have to look more deeply how the situation happens.
>>> I will let you know if I have other patch to test
>>
>> So I haven't been able to figure out how we reach this situation yet.
>> In the meantime I'm going to make a clean patch with the fix above.
>>
>> Is it ok if I add a reported -by and a tested-by you ?
> 
> Sure-
> I just realized that this system has something special. Some month ago I created 2 slices
> $ head /etc/systemd/system/*.slice
> ==> /etc/systemd/system/machine-production.slice <==
> [Unit]
> Description=VM production
> Before=slices.target
> Wants=machine.slice
> [Slice]
> CPUQuota=2000%
> CPUWeight=1000
> 
> ==> /etc/systemd/system/machine-test.slice <==
> [Unit]
> Description=VM production
> Before=slices.target
> Wants=machine.slice
> [Slice]
> CPUQuota=300%
> CPUWeight=100
> 
> 
> And the guests are then put into these slices. that also means that this test will never use more than the 2300%.
> No matter how much CPUs the system has.

If you could run this debug patch on top of your un-patched kernel, it would tell us which task (in the enqueue case)
and which taskgroup is causing that.

You could then further dump the appropriate taskgroup directory under the cpu cgroup mountpoint
(to see e.g. the CFS bandwidth data). 

I expect more than one hit since assert_list_leaf_cfs_rq() uses SCHED_WARN_ON, hence WARN_ONCE.

--8<--
From b709758f476ee4cfc260eceedc45ebcc50d93074 Mon Sep 17 00:00:00 2001
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Sat, 29 Feb 2020 11:07:05 +0000
Subject: [PATCH] test: rq->tmp_alone_branch != &rq->leaf_cfs_rq_list

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c8a379c357e..69fc30db7440 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4619,6 +4619,15 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			break;
 	}
 
+	if (rq->tmp_alone_branch != &rq->leaf_cfs_rq_list) {
+		char path[64];
+
+		sched_trace_cfs_rq_path(cfs_rq, path, 64);
+
+		printk("CPU%d path=%s on_list=%d nr_running=%d\n",
+		       cpu_of(rq), path, cfs_rq->on_list, cfs_rq->nr_running);
+	}
+
 	assert_list_leaf_cfs_rq(rq);
 
 	if (!se)
@@ -5320,6 +5329,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		}
 	}
 
+	if (rq->tmp_alone_branch != &rq->leaf_cfs_rq_list) {
+		char path[64];
+
+		cfs_rq = cfs_rq_of(&p->se);
+
+		sched_trace_cfs_rq_path(cfs_rq, path, 64);
+
+		printk("CPU%d path=%s on_list=%d nr_running=%d p=[%s %d]\n",
+		       cpu_of(rq), path, cfs_rq->on_list, cfs_rq->nr_running,
+		       p->comm, p->pid);
+	}
+
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
-- 
2.17.1

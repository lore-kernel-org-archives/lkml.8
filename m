Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1DAC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EB0206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGWJbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:31:44 -0400
Received: from foss.arm.com ([217.140.110.172]:42600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgGWJbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:31:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57609D6E;
        Thu, 23 Jul 2020 02:31:43 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34AE13F66F;
        Thu, 23 Jul 2020 02:31:41 -0700 (PDT)
Subject: [SchedulerWakeupLatency] Skip energy aware task placement
To:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>,
        Quentin Perret <qperret@google.com>
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2aa4b838-c298-ec7d-08f3-caa50cc87dc2@arm.com>
Date:   Thu, 23 Jul 2020 11:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87imfi2qbk.derkling@matbug.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2020 09:29, Patrick Bellasi wrote:

> .:: Scheduler Wakeup Path Requirements Collection Template
> ==========================================================
> 
> A) Name: unique one-liner name for the proposed use-case

[SchedulerWakeupLatency] Skip energy aware task placement

> B) Target behaviour: one paragraph to describe the wakeup path issue

The search for the most energy-efficient CPU over the Performance
Domains (PDs) by consulting the Energy Model (EM), i.e. the estimation
on how much energy a PD consumes if the task migrates to one of its
CPUs, adds a certain amount of latency to task placement.

For some tasks this extra latency could be too high. A good example here
are the Android display pipeline tasks, UIThread and RenderThread. They
have to be placed on idle CPUs with a faster wakeup mechanism than the
energy aware wakeup path (A) to guarantee the smallest amount of dropped
or delayed frames (a.k.a. jank).

In Linux kernel mainline there is currently no mechanism for latency
sensitive tasks to allow that the energy aware wakeup path (A) is
skipped and the fast path (B) taken instead.

> C) Existing control paths: reference to code paths to justify B)

select_task_rq_fair()
{
        ...

	if (wakeup)
		if (asym_cpucapacity && EM && schedutil)
			new_cpu = find_energy_efficient_cpu();    <- (A)
			if (new_cpu >= 0)
				return new_cpu;
	
        ...

	if (unlikely(sd))
		/* slow path */
	else if (sd_flag & wakeup)
                /* fast path */
		new_cpu = select_idle_sibling() {
			if (asym_cpucapacity)
				new_cpu = select_idle_capacity(); <- (B)
				if (new_cpu >= 0)
					return new_cpu;
		}

        ...

        return new_cpu;
}

> D) Desired behaviour: one paragraph to describe the desired update

A mechanism for a task to skip the energy aware wakeup (A) and fallback
into the fast path (B).

> E) Existing knobs (if any): reference to whatever existing tunable

There are no existing ways to control this behaviour in Linux kernel
mainline.

There is the concept of 'prefer idle' in Android which is tightly
coupled with the proprietary cgroup controller schedtune.

> F) Existing knobs (if any): one paragraph description of the limitations

Schedtune will be replaced by mainline uclamp in upcoming Android
releases. There is no per-task 'prefer idle' interface.

> G) Proportionality Analysis: check the nature of the target behavior

The use case requires that a task either cares about latency or not.

> H) Range Analysis: identify meaningful ranges

The knob can be defined as latency sensitive (i.e. prefer an idle CPU)
or as not latency sensitive.

Mapping Analysis:

If required by other use-cases, the binary range requirement can easily
be covered by a wider, more fine grained latency sensitive range.

> I) System-Wide tuning: which knobs are required

No system-wide tuning required.

> J) Per-Task tuning: which knobs are required

The proposal is a per-task flag, indicating whether the task is latency
sensitive or not.

> K) Task-Group tuning: which knobs are required

Currently Android uses the 'prefer idle' mechanism only on task-groups
and not on individual tasks.

Therefore a per task-group implementation would be required. The
implementation should respect the cgroup resource distribution models
[1], [2].

> .:: References
> ==============

[1] LWN: The many faces of "latency nice"
    https://lwn.net/Articles/820659

[2] Control Group v2: Resource Distribution Models
    https://www.kernel.org/doc/Documentation/admin-guide/cgroup-v2.rst

Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83416C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2EC2077D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbgFWHtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:49:31 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:33369 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbgFWHta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:49:30 -0400
Received: by mail-ej1-f66.google.com with SMTP id n24so20649228ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=l09/8jo/rEHXkzrKqwLw2bzjE9TUHXuLUACt0K57wZI=;
        b=AZ9jN7czsMZOwbrgFMdFYy7i4nrsvN+KrRZNTy7IqZmUCuHg0UUZHE32TAckOuNbOz
         AY/edgv9pzUJpmDKu/yQUCULLzRbL+xFNzq1Lb5xmlECQ9L2u/+XorV0+x0cSn7bbHri
         Xkx25j5uq3zVSFKwZGFdNUSkOminGC6B4w50rRpGcVfiPUIAvp/jOYizEJLyJsL8iEkP
         ZhvtOsDSkCH+eh1uKjRCAYz4KVp1foAdOzOCVVErH7kVgdd1zwvstZvgPZxGDCPJTK/5
         msaML3DD4UvH0EguJTZ3Csd9EBlXw+mOS7yMyYAx0MuMqjC+oMR2W5cafqlZJVauNsyY
         4Itw==
X-Gm-Message-State: AOAM530cI5RNfR4C3HCtpGtFVu4InROGXesm+XaIfAmpSsFDP7G/gMRI
        /owPGEN3aW02740F04RhwTM=
X-Google-Smtp-Source: ABdhPJwj5pP7MDpsdnXw7cj4Ajtks15J+7Czd+L3XDdUAxS0P2q7MWVoTd2hPLTHEIUi4qMOoIyGTg==
X-Received: by 2002:a17:906:16d3:: with SMTP id t19mr18407664ejd.297.1592898567680;
        Tue, 23 Jun 2020 00:49:27 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id k8sm13923072edn.28.2020.06.23.00.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:49:26 -0700 (PDT)
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net> <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net> <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: [SchedulerWakeupLatency] Per-task vruntime wakeup bonus
In-reply-to: <87imfi2qbk.derkling@matbug.net>
Message-ID: <87blla2pdt.derkling@matbug.net>
Date:   Tue, 23 Jun 2020 09:49:18 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 23, 2020 at 09:29:03 +0200, Patrick Bellasi <patrick.bellasi@matbug.net> wrote...

> .:: Scheduler Wakeup Path Requirements Collection Template
> ==========================================================
>
> A) Name

Runtime tunable vruntime wakeup bonus.


> B) Target behavior

All SCHED_OTHER tasks get the same (max) vruntime wakeup bonus. This
bonus affects the chance the task has to preempt the currently running
task. Some tasks, which are (known to be) latency tolerant, should have
a smaller chance to preempt a (known to be) latency sensitive task. To
the contrary, latency sensitive tasks should have a higher chance to
preempt a currently running latency tolerant task.

This task specific distinction is not provided by the current
implementation and all SCHED_OTHER tasks are handled according to the
same simple, system-wide and not run-time tunable policy.


> C) Existing control paths

Assuming:

 C: CFS task currently running on CPUx
 W: CFS task waking up on the same CPUx

And considering the overall simplified workflow:

core::try_to_wake_up()

  // 1) Select on which CPU W will run
  core::select_task_rq()
    fair::select_task_rq_fair()

  // 2) Enqueue W on the selected CPU
  core::ttwu_queue()
    core::ttwu_do_activate()
      core::activate_task()
        core::enqueue_task()
          fair::enqueue_task_fair()
            fair::enqueue_entity()

              // 3) Set W's vruntime bonus
              fair::place_entity()
                se->vruntime = ...

      // 4) Check if C can be preempted by W
      core::ttwu_do_wakeup()
        core::check_preempt_curr()
          fair::check_preempt_curr()
            fair::check_preempt_wakeup(curr, se)
              fair::wakeup_preempt_entity(curr, se)
                vdiff = curr.vruntime - se.vruntime
                return vdiff > wakeup_gran(se)

We see that W preempts C iff:

   vdiff > wakeup_gran(se)

Since:

enqueue_entity(cfs_rq, se, flags)
  place_entity(cfs_rq, se, initial=0)
    thresh = sysctl_sched_latency / (GENTLE_FAIR_SLEEPERS ? 2 : 1)
    vruntime = cfs_rq->min_vruntime - thresh
    se->vruntime = max_vruntime(se->vruntime, vruntime)

a waking task's W.vruntime can get a "vruntime bonus" up to:
 - 1   scheduler latency (w/  GENTLE_FAIR_SLEEPERS)
 - 1/2 scheduler latency (w/o GENTLE_FAIR_SLEEPERS)


> D) Desired behavior

The "vruntime bonus" (thresh) computed in place_entity() should have a
per-task definition, which defaults to the current implementation.

A bigger vruntime bonus can be configured for latency sensitive tasks.
A smaller vruntime bonus can be configured for latency tolerant tasks.

TL;DR

The "vruntime bonus" is meant to give sleepers a compensation for the
service deficit due to them not having (possibly) fully consumed their
assigned fair CPU quota within the current sched_latency interval, see:

  commit 51e0304ce6e5 ("sched: Implement a gentler fair-sleepers feature")

The scheduler does that based on a conservative assumption: when a task
sleeps it gives up a portion (P) of its fair CPU bandwidth share in the
current sched_latency period.
Willing to be FAIR, i.e. each task gets a FAIR quota of the CPU in each
sched_latency period, the scheduler wants to give back P to waking
tasks.

However, striving to minimize overheads and complexity, the CFS
scheduler does that using a simple heuristic: each task waking up gets a
bonus, which is capped at one sched_latency period, independently from
"its nature".

What the scheduler completely disregards is that being completely FAIR
is not always necessary. Depending on the nature of a task, not all
tasks require a bonus. To the contrary:

 - a GENTLE_FAIR_SLEEPERS bonus given to a background task could result
   in preempting a latency sensitive currently running task

 - giving only 1/2 scheduler latency bonus to a latency sensitive task
   could result in that task being preempted before it completes its
   current activation.


> E) Existing knobs

The SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true) defined vruntime bonus value
can be considered the current mainline default value.

This means that "all" CFS tasks waking up will get a

   0.5 * sysctl_sched_latency

vruntime bonus wrt the cfs_rq->min_vruntime.


> F) Existing knobs limitations

GENTLE_FAIR_SLEEPERS is a system-wide knob and it's not run-time
tunable on production systems (being a SCHED_DEBUG feature).

Thus, the sched_feature should be removed and replaced by a per-task
knob.


> G) Proportionality Analysis

The value of the vruntime bonus directly affects the chance a task has
to preempt the currently running task.

Indeed, from the code analysis in C:

  thresh = sysctl_sched_latency / (GENTLE_FAIR_SLEEPERS ? 2 : 1)

is the "wakeup bonus", which is used as:

  vruntime = cfs_rq->min_vruntime - thresh
  se->vruntime = max_vruntime(se->vruntime, vruntime)
  vdiff = curr.vruntime - se.vruntime

  preempt condition: vdiff > wakeup_gran(se)


> H) Range Analysis

The new per-task knob can cover the range [0..sysctl_sched_latency]

Latency sensitive tasks will get sysctl_sched_latency as bonus.
Latency tolerant tasks will get 0.

Values lower than the default sysctl_sched_latency/2 will require
special capabilities (e.g. CAP_SYS_NICE). OTHA, a task can relax
its wakeup latency requirement by asking for a bonus smaller than the
default.

Mapping Analysis: check if the range can be mapped into a generic one
=================

The latency_nice proposal [2] offers a [-20, 19] range which can be
easily mapped into a vruntime bonus range, e.g. using a simpler linear
transformation function.

A more elaborated mapping could be defined, based on recomputed
constants, to provide a relative constant increment.


> I) System-Wide tuning

The latency_nice provided knobs should be enough to get the desired
effect.

In (the remote) case a range wider than the one proposed in [H] should
be required, perhaps an additional sysctl_sched_latency's multiplier
knob could be required.


> J) Per-Task tuning

The latency_nice provided knobs.


> K) Task-Group tuning

For tasks-groups, similarly to what uclamp does, a pair of
latency_nice_{min,max} clamps should be enough.

The task-specific latency_nice requested value will be restricted by the
task group's clamps.


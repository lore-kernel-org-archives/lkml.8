Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE6FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497F220780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgFWH3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:29:39 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:46184 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbgFWH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:29:39 -0400
Received: by mail-ej1-f68.google.com with SMTP id p20so20498092ejd.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:date:mime-version;
        bh=r6iBQ+a2psL8/1ILnpQrZHrTmcPpkjqZptSkXvzX8Eg=;
        b=T9oFbPnWpGwSyRhsb/QenBP5D/C2Nx1b08qSV1qI0icMOVO1xV5iUiJcybBRq8sM6D
         5nHoqpUltQA5Bke+wyM1IAEvDd4zYwxxuUar/lf2qVbnrBBkJAm88VRJQ2nhZf2NWgqJ
         Om10SPL6ZqHPzmc/krglaDb3m8u5Mbcr1YzducPC46XN89KJb6i5Lih7gJNNE3yJfGjC
         cBZtTkVbB1m6aA63WjGmy55C/rMs094AsjZI3UdIQeNfuBP/o0pNq7NYsicRQ4+s7Gbw
         YUrA341zSfXeY/za+Ym9eI3yVYIBp5jhToF6kENr8cbrORd3vrwiwR7zzS8QgcmDrV/1
         vSOQ==
X-Gm-Message-State: AOAM533YjTDYDUlCo1iWxLe1BpaWLN7OgpUDMFZOVTFBOquOo0OA9xN7
        5m59Rb5uhNJTRFuy/YNIEDk=
X-Google-Smtp-Source: ABdhPJw14PEhroxBRn5Ky9cJUsdoVIXcoM1ev4h6Rn3pgF0r/zi0Uh3FgGUizQTYAZJGzKx9nefgFg==
X-Received: by 2002:a17:906:b88c:: with SMTP id hb12mr18414146ejb.483.1592897376297;
        Tue, 23 Jun 2020 00:29:36 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id u3sm14601451edx.25.2020.06.23.00.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:29:35 -0700 (PDT)
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net> <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net> <87eer42clt.derkling@matbug.net>
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
Subject: Scheduler wakeup path tuning surface: Use-Cases and Requirements
Message-ID: <87imfi2qbk.derkling@matbug.net>
Date:   Tue, 23 Jun 2020 09:29:03 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since last year's OSPM Summit we started conceiving the idea that task
wakeup path could be better tuned for certain classes of workloads
and usage scenarios. Various people showed interest for a possible
tuning interface for the scheduler wakeup path.


.:: The Problem
===============

The discussions we had so far [1] have not been effective in clearly
identifying if a common tuning surface is possible. The last discussion
at this year's OSPM Summit [2,3] was also kind of inconclusive and left
us with the message: start by collecting the requirements and then see
what interface fits them the best.

General consensus is that a unified interface can be challenging and
maybe not feasible. However, generalisation is also a value
and we should strive for it whenever it's possible.

Someone might think that we did not put enough effort in the analysis of
requirements. Perhaps what we missed so far is also a structured and
organised way to collect requirements which also can help in factoring
out the things they have in common.


.:: The Proposal
================

This thread aims at providing a guided template for the description of
different task wakeup use-cases. It does that by setting a series of
questions aimed at precisely describing what's "currently broken", what
we would like to have instead and how we could achieve it.

What we propose here is that, for each wakeup use-case, we start
by replying to this email to provide the required details/comments for
a predefined list of questions. This will generate independent
discussion threads. Each thread will be free to focus on a specific
proposal but still all the thread will be reasoning around a common set
of fundamental concepts.

The hope is that, by representing all the use-cases as sufficiently
detailed responses to a common set of questions, once the discussion
settles down, we can more easily verify if there are common things
surfacing which then can be naturally wrapped into a unified user-space
API.

A first use-case description, following the template guidelines, will
be posted shortly after this message. This also will provide an example
for how to use the template.

NOTE: Whenever required, pseudo-code or simplified C can be used.

I hope this can drive a fruitful discussion in preparation for LPC!

Best,
Patrick


---8<--- For templates submissions: reply only to the following ---8<---


.:: Scheduler Wakeup Path Requirements Collection Template
==========================================================

A) Name: unique one-liner name for the proposed use-case

B) Target behaviour: one paragraph to describe the wakeup path issue

C) Existing control paths: reference to code paths to justify B)

   Assuming v5.6 as the reference kernel, this section should provide
   links to code paths such as, e.g.

   fair.c:3917
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/fair.c?h=v5.6#n3917

   Alternatively code snippets can be added inline, e.g.

        /*
	 * The 'current' period is already promised to the current tasks,
	 * however the extra weight of the new task will slow them down a
	 * little, place the new task so that it fits in the slot that
	 * stays open at the end.
	 */
	if (initial && sched_feat(START_DEBIT))
		vruntime += sched_vslice(cfs_rq, se);

   NOTE: if the use-case exists only outside the mainline Linux kernel
         this section can stay empty

D) Desired behaviour: one paragraph to describe the desired update

   NOTE: the current mainline expression is assumed to be correct
         for existing use-cases. Thus, here we are looking for run-time
         tuning of those existing features.

E) Existing knobs (if any): reference to whatever existing tunable

   Some features can already be tuned, but perhaps only via compile time
   knobs, SCHED_FEATs or system wide tunable.
   If that's the case, we should document them here and explain how they
   currently work and what are (if any) the implicit assumptions, e.g.
   what is the currently implemented scheduling policy/heuristic.

F) Existing knobs (if any): one paragraph description of the limitations

   If the existing knobs are not up to the job for this use-case,
   shortly explain here why. It could be because a tuning surface is
   already there but it's hardcoded (e.g. compile time knob) or too
   coarse grained (e.g. a SCHED_FEAT).

G) Proportionality Analysis: check the nature of the target behavior

   Goal here is to verify and discuss if the behaviour (B) has a
   proportional nature: different values of the control knobs (E) are
   expected to produce different effects for (B).
   
   Special care should be taken to check if the target behaviour has an
   intrinsically "binary nature", i.e. only two values make really
   sense. In this case it would be very useful to argument why a
   generalisation towards a non-binary behaviours does NOT make sense.

H) Range Analysis: identify meaningful ranges

   If (G) was successfully, i.e. there is a proportional correlation
   between (E) and (B), discuss here about a meaningful range for (E)
   and (F).

I) System-Wide tuning: which knobs are required

   If required, list new additional tunables here, how they should be
   exposed and (if required) which scheduling classes will be affected.

J) Per-Task tuning: which knobs are required

   Describe which knobs should be added and which task specific API
   (e.g. sched_setscheduler(), prctl(), ...) they should be used.

K) Task-Group tuning: which knobs are required

   If the use-case can benefit from a task-group tuning, here it should
   **briefly described** how the expected behaviour can be mapped on a
   cgroup v2 unified hierarchy.

   NOTE: implementation details are not required but we should be able
         to hint at which cgroup v2 resource distribution model [5]
         should be applied.


---8<--- For templates submissions: exclude the following ---8<---


.:: References
==============

[1] [Discussion v2] Usecases for the per-task latency-nice attribute
    Message-ID: 2bd46086-43ff-f130-8720-8eec694eb55b@linux.ibm.com
    https://lore.kernel.org/lkml/2bd46086-43ff-f130-8720-8eec694eb55b@linux.ibm.com

[2] Latency Nice: Implementation and UseCases for Scheduler Optmizations
    https://ospm.lwn.net/playback/presentation/2.0/playback.html?meetingId=380dd88f044f67ee4c94d0a2a4fb7c3f46cb6391-1589459486615&t=42m37s

[3] LWN: The many faces of "latency nice"
    https://lwn.net/Articles/820659

[4] [PATCH v5 0/4] Introduce per-task latency_nice for scheduler hints
    Message-ID: 20200228090755.22829-1-parth@linux.ibm.com
    https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com

[5] Control Group v2: Resource Distribution Models
    https://www.kernel.org/doc/Documentation/admin-guide/cgroup-v2.rst


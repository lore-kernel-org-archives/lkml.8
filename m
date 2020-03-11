Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D777C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28402072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgCKSQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:16:48 -0400
Received: from foss.arm.com ([217.140.110.172]:53172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbgCKSQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:16:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1D151FB;
        Wed, 11 Mar 2020 11:16:46 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B73DE3F6CF;
        Wed, 11 Mar 2020 11:16:45 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/9] sched: Streamline select_task_rq() & select_task_rq_fair()
Date:   Wed, 11 Mar 2020 18:15:52 +0000
Message-Id: <20200311181601.18314-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been staring at select_task_rq_fair() for some time now, and have come
to "hate" the usage of the sd_flag parameter. It is used as both an
indicator of the wakeup type (ttwu/fork/exec) and as a domain walk search
target. CFS is the only class doing this, the other classes just need the
wakeup type but get passed a domain flag instead.

This series gets rid of select_task_rq()'s sd_flag parameter and also tries
to optimize select_task_rq_fair().

This is based on tip/sched/core at:
a0f03b617c3b ("sched/numa: Stop an exhastive search if a reasonable swap candidate or idle CPU is found")

Patches
=======

o Patch 1 is a simple dead parameter cleanup
o Patches 2-4 get rid of SD_LOAD_BALANCE
o Patches 5-6 involve getting rid of the sd_flag parameter for
  select_task_rq(). 
o Patch 7 is an extra cleanup in the select_task_rq_fair() region.
o Patches 8-9 split the want_affine vs !want_affine paths of
  select_task_rq_fair(), which unearths a small optimization. Sort of a
  single patch split in two for the sake of review.

Testing
=======

Testing was done against a slightly older tip/sched/core at:
25ac227a25ac ("sched/fair: Remove wake_cap()")

I got annoyed by the variance in my 500 iteration runs, so I scripted
something to run batches of 5k iterations. It looks pretty stable from one
batch to another. I also stared at some boxplots to convince myself I
wasn't needlessly making things worse - you too can stare at them here [1].

Note: the 'X%' stats are the percentiles, so 50% is the 50th percentile.

Juno r0
-------

2+4 big.LITTLE. SD levels are {MC, DIE}.

Hackbench
~~~~~~~~~

15000 iterations of
  $ hackbench
(lower is better):

|       |   -PATCH |   +PATCH |  DELTA |
|-------+----------+----------+--------|
| mean  | 0.622235 | 0.618834 | -0.55% |
| std   | 0.018121 | 0.017579 | -2.99% |
| min   | 0.571000 | 0.573000 | +0.35% |
| 50%   | 0.620000 | 0.617000 | -0.48% |
| 75%   | 0.633000 | 0.629000 | -0.63% |
| 99%   | 0.674000 | 0.669000 | -0.74% |
| max   | 0.818000 | 0.756000 | -7.58% |

The boxplot shows a single outlier to the very left for both commits, which
are the minimums reported above. Other than that, +PATCH has somewhat lower
outliers on the righthand side: worst cases are a tad better.

Sysbench
~~~~~~~~

15000 iterations of
  $ sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=6 run
(higher is better):

|       |       -PATCH |       +PATCH |   DELTA |
|-------+--------------+--------------+---------|
| mean  | 15318.954000 | 15628.416933 |  +2.02% |
| std   |   235.466202 |   205.162730 | -12.87% |
| min   | 13025.000000 | 13554.000000 |  +4.06% |
| 50%   | 15366.000000 | 15681.000000 |  +2.05% |
| 75%   | 15497.000000 | 15765.000000 |  +1.73% |
| 99%   | 15651.000000 | 15893.000000 |  +1.55% |
| max   | 15716.000000 | 15972.000000 |  +1.63% |

That's overall a tad better.

Dual-socket Xeon E5
-------------------

Each socket is 10 cores w/ SMT2 - 40 CPUs total. SD levels are
{SMT, MC, NUMA}.

Hackbench
~~~~~~~~~

25000 iterations of
  $ hackbench -l 1000
(lower is better):

|       |       -PATCH |       +PATCH |  DELTA |
|-------+--------------+--------------+--------|
| mean  |     0.946312 |     0.944685 | -0.17% |
| std   |     0.006419 |     0.006447 | +0.44% |
| min   |     0.906000 |     0.897000 | -0.99% |
| 50%   |     0.947000 |     0.945000 | -0.21% |
| 75%   |     0.950000 |     0.949000 | -0.11% |
| 99%   |     0.959000 |     0.958000 | -0.10% |
| max   |     0.988000 |     0.967000 | -2.13% |

The boxplot shows that the min improvement is some sort of fluke - it's a
single point standing out on the left. The mean *is* slightly lowered,
which most likely comes from +PATCH having less high-value outliers.

I looked into some statistical tests, but my samples distribution isn't a
normal distribution (which is a requirement for most of them). This
actually can't happen by construction according to [2], since hackbench
outputs the maximum of a set of random of variables. We could instead use
the average of all sender/receiver pairs, or even the invidual time taken
per each pair; that being said, I don't think each value produced by a pair
could be seen as independent variables, given that there'll be more > 1
task per CPU.

Wilcoxon's test [3] gives me a p-value of ~1e-182, so there *is* a
significant difference between the two datasets, but it does not say if the
difference is in the mean, variance, or any other parameter of the
distribution.

Sysbench
~~~~~~~~~

25000 iterations of
  $ sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=40 run
(higher is better):

|       |       -PATCH |       +PATCH |   DELTA |
|-------+--------------+--------------+---------|
| mean  | 23937.937560 | 24280.668640 |  +1.43% |
| std   |   547.139948 |   484.963639 | -11.36% |
| min   | 21526.000000 | 21917.000000 |  +1.82% |
| 50%   | 24032.000000 | 24374.000000 |  +1.42% |
| 75%   | 24355.000000 | 24638.000000 |  +1.16% |
| 99%   | 24869.010000 | 25084.000000 |  +0.86% |
| max   | 25410.000000 | 25623.000000 |  +0.84% |

As with the Juno, that's overall a tad better.

Takeaway
--------

The TL;DR for those fancy stats seems to be: it's hard to say much about
hackbench, and sysbench likes it a bit. The important thing for me is to
not introduce regressions with my stupid change, and AFAICT it is the case.

Links
=====

[1]: https://htmlpreview.github.io/?https://gist.githubusercontent.com/valschneider/433b3772d1776c52214dd05be2ab2f03/raw/316fbd9f774fa381c60731511c881a3360111563/streamline_v2_bplots.html
[2]: https://en.wikipedia.org/wiki/Fisher%E2%80%93Tippett%E2%80%93Gnedenko_theorem
[3]: https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.wilcoxon.html#scipy.stats.wilcoxon

Revisions
=========

v1 -> v2
--------
o Removed the 'RFC' tag
o Made the sd_flags syctl read-only
o Removed the SD_LOAD_BALANCE flag
o Cleaned up ugly changes thanks to the above

Valentin Schneider (9):
  sched/fair: find_idlest_group(): Remove unused sd_flag parameter
  sched/debug: Make sd->flags sysctl read-only
  sched: Remove checks against SD_LOAD_BALANCE
  sched/topology: Kill SD_LOAD_BALANCE
  sched: Add WF_TTWU, WF_EXEC wakeup flags
  sched: Kill select_task_rq()'s sd_flag parameter
  sched/fair: Dissociate wakeup decisions from SD flag value
  sched/fair: Split select_task_rq_fair want_affine logic
  sched/topology: Define and use shortcut pointers for wakeup sd_flag
    scan

 include/linux/sched/topology.h | 29 +++++++------
 kernel/sched/core.c            | 10 ++---
 kernel/sched/deadline.c        |  4 +-
 kernel/sched/debug.c           |  2 +-
 kernel/sched/fair.c            | 75 +++++++++++++++++++---------------
 kernel/sched/idle.c            |  2 +-
 kernel/sched/rt.c              |  4 +-
 kernel/sched/sched.h           | 13 ++++--
 kernel/sched/stop_task.c       |  2 +-
 kernel/sched/topology.c        | 43 +++++++++----------
 10 files changed, 98 insertions(+), 86 deletions(-)

--
2.24.0


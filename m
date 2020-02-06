Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6576C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA1820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgBFTUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:20:13 -0500
Received: from foss.arm.com ([217.140.110.172]:33644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgBFTUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:20:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7B1A1FB;
        Thu,  6 Feb 2020 11:20:11 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94E783F52E;
        Thu,  6 Feb 2020 11:20:10 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org,
        pkondeti@codeaurora.org
Subject: [PATCH v4 0/4] sched/fair: Capacity aware wakeup rework
Date:   Thu,  6 Feb 2020 19:19:53 +0000
Message-Id: <20200206191957.12325-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is about replacing the current wakeup logic for asymmetric CPU
capacity topologies, i.e. wake_cap().

Details are in patch 1, the TL;DR is that wake_cap() works fine for
"legacy" big.LITTLE systems (e.g. Juno), since the Last Level Cache (LLC)
domain of a CPU only spans CPUs of the same capacity, but somewhat broken
for newer DynamIQ systems (e.g. Dragonboard 845C), since the LLC domain of
a CPU can span all CPUs in the system. Both example boards are supported in
mainline.

A bit of history
================

Due to the old Energy Model (EM) used until Android Common Kernel v4.14
which grafted itself onto the sched domain hierarchy, mobile topologies
have been represented with "phantom domains"; IOW we'd make a DynamIQ
topology look like a big.LITTLE one:

actual hardware:

  +-------------------+
  |        L3         |
  +----+----+----+----+
  | L2 | L2 | L2 | L2 |
  +----+----+----+----+
  |CPU0|CPU1|CPU2|CPU3|
  +----+----+----+----+
     ^^^^^     ^^^^^
    LITTLEs    bigs

vanilla/mainline topology:

  MC [       ]
      0 1 2 3

phantom domains topology:

  DIE [        ]
  MC  [   ][   ]
       0 1  2 3

With the newer, mainline EM this is no longer required, and wake_cap() is
the last sticking point to getting rid of this legacy crud. More details
and examples are in patch 1.

Notes
=====

This removes the use of SD_BALANCE_WAKE for asymmetric CPU capacity
topologies (which are the last mainline users of that flag), as such it
shouldn't be a surprise that this comes with significant improvements to
wake-intensive workloads: wakeups no longer go through the
select_task_rq_fair() slow-path.

Testing
=======

I've picked sysbench --test=threads to mimic Peter's testing mentioned in

  commit 182a85f8a119 ("sched: Disable wakeup balancing")

Sysbench results are the number of events handled in a fixed amount of
time, so higher is better. Hackbench results are the usual time taken for
the thing, so lower is better.

Note: the 'X%' stats are the percentiles, so 50% is the 50th percentile.

Juno r0 ("legacy" big.LITTLE)
+++++++++++++++++++++++++++++

This is 2 bigs and 4 LITTLEs:

  +---------------+ +-------+
  |      L2       | |  L2   |
  +---+---+---+---+ +---+---+
  | L | L | L | L | | B | B |
  +---+---+---+---+ +---+---+


100 iterations of 'hackbench':

|      |   -PATCH |   +PATCH | DELTA (%) |
|------+----------+----------+-----------|
| mean | 0.631040 | 0.619610 |    -1.811 |
| std  | 0.025486 | 0.015798 |   -38.013 |
| min  | 0.582000 | 0.594000 |    +2.062 |
| 50%  | 0.628500 | 0.617500 |    -1.750 |
| 75%  | 0.645500 | 0.630000 |    -2.401 |
| 99%  | 0.697060 | 0.669030 |    -4.021 |
| max  | 0.703000 | 0.672000 |    -4.410 |

100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=6 run':

|      |       -PATCH |       +PATCH | DELTA (%) |
|------+--------------+--------------+-----------|
| mean | 10267.760000 | 15137.930000 |   +47.432 |
| std  |  3110.439815 |   412.275289 |   -86.745 |
| min  |  7186.000000 | 14061.000000 |   +95.672 |
| 50%  |  9019.500000 | 15255.500000 |   +69.139 |
| 75%  | 12711.000000 | 15472.500000 |   +21.725 |
| 99%  | 15749.290000 | 15683.470000 |    -0.418 |
| max  | 15877.000000 | 15730.000000 |    -0.926 |

Note: you'll notice the results aren't as good as with v3; from playing
around with v4 this seems to come from removing the (broken) capacity_orig
heuristic. 

Pixel3 (DynamIQ)
++++++++++++++++

Ideally I would have used a DB845C but had a few issues with mine, so I
went with a mainline-ish Pixel3 instead [1]. It's still the same SoC under
the hood (Snapdragon 845), which has 4 bigs and 4 LITTLEs:

  +-------------------------------+
  |               L3              |
  +---+---+---+---+---+---+---+---+
  | L2| L2| L2| L2| L2| L2| L2| L2|
  +---+---+---+---+---+---+---+---+
  | L | L | L | L | B | B | B | B |
  +---+---+---+---+---+---+---+---+

Default topology (single MC domain)
-----------------------------------

100 iterations of 'hackbench -l 200'

|      |   -PATCH |   +PATCH | DELTA (%) |
|------+----------+----------+-----------|
| mean | 1.131360 | 1.102560 |    -2.546 |
| std  | 0.116322 | 0.101999 |   -12.313 |
| min  | 0.935000 | 0.935000 |    +0.000 |
| 50%  | 1.099000 | 1.097500 |    -0.136 |
| 75%  | 1.211250 | 1.157750 |    -4.417 |
| 99%  | 1.401020 | 1.338210 |    -4.483 |
| max  | 1.502000 | 1.359000 |    -9.521 |

100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':

|      |      -PATCH |      +PATCH | DELTA (%) |
|------+-------------+-------------+-----------|
| mean | 7108.310000 | 8731.610000 |   +22.837 |
| std  |  199.431854 |  206.826912 |    +3.708 |
| min  | 6655.000000 | 8251.000000 |   +23.982 |
| 50%  | 7107.500000 | 8705.000000 |   +22.476 |
| 75%  | 7255.500000 | 8868.250000 |   +22.228 |
| 99%  | 7539.540000 | 9155.520000 |   +21.433 |
| max  | 7593.000000 | 9207.000000 |   +21.256 |

Phantom domains (MC + DIE)
--------------------------

This is mostly included for the sake of completeness.

100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':

|      |      -PATCH |      +PATCH | DELTA (%) |
|------+-------------+-------------+-----------|
| mean | 7317.940000 | 9328.470000 |   +27.474 |
| std  |  460.372682 |  181.528886 |   -60.569 |
| min  | 5888.000000 | 8832.000000 |   +50.000 |
| 50%  | 7271.000000 | 9348.000000 |   +28.566 |
| 75%  | 7497.500000 | 9477.250000 |   +26.405 |
| 99%  | 8464.390000 | 9634.160000 |   +13.820 |
| max  | 8602.000000 | 9650.000000 |   +12.183 |

Revisions
=========

v3 -> v4
--------
o Removed max capacity_orig heuristic (Dietmar)
o (new patch) Removed for_each_lower_domain() (Dietmar)
o Made select_idle_sibling() bail out after going through
  select_idle_capacity() (Pavan)
o Added use of sched_idle_cpu() in select_idle_capacity() (Pavan)
o Corrected the signoff order in patch 1

v2 -> v3
--------
o Added missing sync_entity_load_avg() (Quentin)
o Added fallback CPU selection (maximize capacity)
o Added special case for CPU hogs: task_fits_capacity() will always return 'false'
  for tasks that are simply too big, due to the margin.

v1 -> v2
--------
o Removed unrelated select_idle_core() change

[1]: https://git.linaro.org/people/amit.pundir/linux.git/log/?h=blueline-mainline-tracking

Morten Rasmussen (3):
  sched/fair: Add asymmetric CPU capacity wakeup scan
  sched/topology: Remove SD_BALANCE_WAKE on asymmetric capacity systems
  sched/fair: Kill wake_cap()

Valentin Schneider (1):
  sched: Remove for_each_lower_domain()

 kernel/sched/fair.c     | 86 +++++++++++++++++++++++++++--------------
 kernel/sched/sched.h    |  2 -
 kernel/sched/topology.c | 15 ++-----
 3 files changed, 60 insertions(+), 43 deletions(-)

--
2.24.0


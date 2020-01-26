Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6299DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380A820702
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAZUJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:09:56 -0500
Received: from foss.arm.com ([217.140.110.172]:37670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgAZUJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:09:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58A2B1FB;
        Sun, 26 Jan 2020 12:09:55 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 212C93F68E;
        Sun, 26 Jan 2020 12:09:54 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: [PATCH v3 0/3] sched/fair: Capacity aware wakeup rework
Date:   Sun, 26 Jan 2020 20:09:31 +0000
Message-Id: <20200126200934.18712-1-valentin.schneider@arm.com>
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
| mean | 0.631040 | 0.617040 |    -2.219 |
| std  | 0.025486 | 0.017176 |   -32.606 |
| min  | 0.582000 | 0.580000 |    -0.344 |
| 50%  | 0.628500 | 0.613500 |    -2.387 |
| 75%  | 0.645500 | 0.625000 |    -3.176 |
| 99%  | 0.697060 | 0.668020 |    -4.166 |
| max  | 0.703000 | 0.670000 |    -4.694 |

100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=6 run':

|      |       -PATCH |       +PATCH | DELTA (%) |
|------+--------------+--------------+-----------|
| mean | 10267.760000 | 15767.580000 |   +53.564 |
| std  |  3110.439815 |   151.040712 |   -95.144 |
| min  |  7186.000000 | 15206.000000 |  +111.606 |
| 50%  |  9019.500000 | 15778.500000 |   +74.938 |
| 75%  | 12711.000000 | 15873.500000 |   +24.880 |
| 99%  | 15749.290000 | 16042.100000 |    +1.859 |
| max  | 15877.000000 | 16052.000000 |    +1.102 |

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
| mean | 1.131360 | 1.127490 |    -0.342 |
| std  | 0.116322 | 0.084154 |   -27.654 |
| min  | 0.935000 | 0.984000 |    +5.241 |
| 50%  | 1.099000 | 1.115500 |    +1.501 |
| 75%  | 1.211250 | 1.182500 |    -2.374 |
| 99%  | 1.401020 | 1.343070 |    -4.136 |
| max  | 1.502000 | 1.350000 |   -10.120 |


100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':

|      |      -PATCH |      +PATCH | DELTA (%) |
|------+-------------+-------------+-----------|
| mean | 7108.310000 | 8724.770000 |   +22.740 |
| std  |  199.431854 |  185.383188 |    -7.044 |
| min  | 6655.000000 | 8288.000000 |   +24.538 |
| 50%  | 7107.500000 | 8712.500000 |   +22.582 |
| 75%  | 7255.500000 | 8846.250000 |   +21.925 |
| 99%  | 7539.540000 | 9080.970000 |   +20.445 |
| max  | 7593.000000 | 9177.000000 |   +20.861 |

Phantom domains (MC + DIE)
--------------------------

This is mostly included for the sake of completeness.

100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':

|      |      -PATCH |       +PATCH | DELTA (%) |
|------+-------------+--------------+-----------|
| mean | 7317.940000 |  9888.270000 |   +35.124 |
| std  |  460.372682 |   225.019185 |   -51.122 |
| min  | 5888.000000 |  9277.000000 |   +57.558 |
| 50%  | 7271.000000 |  9879.500000 |   +35.875 |
| 75%  | 7497.500000 | 10023.750000 |   +33.695 |
| 99%  | 8464.390000 | 10318.320000 |   +21.903 |
| max  | 8602.000000 | 10350.000000 |   +20.321 |

Revisions
=========

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

 kernel/sched/fair.c     | 89 +++++++++++++++++++++++++++--------------
 kernel/sched/topology.c | 15 ++-----
 2 files changed, 63 insertions(+), 41 deletions(-)

--
2.24.0


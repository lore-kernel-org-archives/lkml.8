Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCAAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBC02072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbgAXNDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:03:44 -0500
Received: from foss.arm.com ([217.140.110.172]:51430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbgAXNDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:03:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1B51FB;
        Fri, 24 Jan 2020 05:03:43 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2168E3F68E;
        Fri, 24 Jan 2020 05:03:42 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: [PATCH v2 0/3] sched/fair: Capacity aware wakeup rework
Date:   Fri, 24 Jan 2020 13:02:10 +0000
Message-Id: <20200124130213.24886-1-valentin.schneider@arm.com>
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

|       |   -PATCH |   +PATCH | DELTA (%) |
|-------+----------+----------+-----------|
| mean  | 0.622300 | 0.613000 |    -1.494 |
| std   | 0.028886 | 0.015178 |   -47.456 |
| min   | 0.579000 | 0.585000 |    +1.036 |
| 50%   | 0.619500 | 0.610000 |    -1.533 |
| 75%   | 0.633250 | 0.621000 |    -1.934 |
| 99%   | 0.680270 | 0.649110 |    -4.581 |
| max   | 0.806000 | 0.660000 |   -18.114 |

100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=6 run':

|       |       -PATCH |       +PATCH | DELTA(%) |
|-------+--------------+--------------+----------|
| mean  |  9695.500000 | 12556.930000 |  +29.513 |
| std   |  2897.875263 |  2941.268452 |   +1.497 |
| min   |  7011.000000 |  6800.000000 |   -3.010 |
| 50%   |  8305.000000 | 13636.500000 |  +64.196 |
| 75%   | 11924.500000 | 15273.250000 |  +28.083 |
| 99%   | 15310.140000 | 15558.860000 |   +1.625 |
| max   | 15522.000000 | 15644.000000 |   +0.786 |

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

|       |   -PATCH |   +PATCH | DELTA (%) |
|-------+----------+----------+-----------|
| mean  | 1.165010 | 1.116370 |    -4.175 |
| std   | 0.124682 | 0.111952 |   -10.210 |
| min   | 0.962000 | 0.936000 |    -2.703 |
| 50%   | 1.133500 | 1.090000 |    -3.838 |
| 75%   | 1.251500 | 1.186000 |    -5.234 |
| 99%   | 1.483050 | 1.350040 |    -8.969 |
| max   | 1.488000 | 1.354000 |    -9.005 |

100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':

|       |      -PATCH |     +PATCH | DELTA (%) |
|-------+-------------+------------+-----------|
| mean  | 7108.310000 | 8455.97000 |   +18.959 |
| std   |  199.431854 |  248.27939 |   +24.493 |
| min   | 6655.000000 | 7875.00000 |   +18.332 |
| 50%   | 7107.500000 | 8454.50000 |   +18.952 |
| 75%   | 7255.500000 | 8622.50000 |   +18.841 |
| 99%   | 7539.540000 | 8981.21000 |   +19.121 |
| max   | 7593.000000 | 9101.00000 |   +19.860 |

Phantom domains (MC + DIE)
--------------------------

This is mostly included for the sake of completeness.

100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':

|       |      -PATCH |      +PATCH | DELTA (%) |
|-------+-------------+-------------+-----------|
| mean  | 5568.930000 | 7884.180000 |   +41.574 |
| std   |  238.341587 |  218.808407 |    -8.195 |
| min   | 4961.000000 | 7222.000000 |   +45.575 |
| 50%   | 5575.500000 | 7885.500000 |   +41.431 |
| 75%   | 5711.500000 | 8031.250000 |   +40.615 |
| 99%   | 6178.000000 | 8395.670000 |   +35.896 |
| max   | 6178.000000 | 8462.000000 |   +36.970 |

Revisions
=========

v1 -> v2:
  Removed unrelated select_idle_core() change

[1]: https://git.linaro.org/people/amit.pundir/linux.git/log/?h=blueline-mainline-tracking

Morten Rasmussen (3):
  sched/fair: Add asymmetric CPU capacity wakeup scan
  sched/topology: Remove SD_BALANCE_WAKE on asymmetric capacity systems
  sched/fair: Kill wake_cap()

 kernel/sched/fair.c     | 67 +++++++++++++++++++++++------------------
 kernel/sched/topology.c | 15 ++-------
 2 files changed, 41 insertions(+), 41 deletions(-)

--
2.24.0


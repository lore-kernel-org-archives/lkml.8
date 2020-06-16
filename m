Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B494C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327BC208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q61ZhbGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgFPQsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:48:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCFAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:48:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so9777738pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/IyDiwGx0oynfsQU8HCCpuJVEgVM4xzXK9Jk5hyXYC0=;
        b=Q61ZhbGfc5L3uIDx20QZd44uD3YwcXr2H55A5T8Covz/Qpjs6/TT3seh/fAywcd1Fp
         MRkl3+i+IMsnJLTeRK0CCZOpPaF7Y60i3ku4l1DBhSqwgoFVSVAN5e/7YLiVdDe2JuEP
         SIlofdBvruZbaqUREj+SeOkwcL4f3/Q9aZlDnXJ0SwiKKmVgxvZ/ZcvOyuUvxJz8Al8M
         Rw9ijSSIQ+rcJHlFbmse0Uyzf9ykLwWpkfwVmajr0rwe9eIaXI2N57og5aaTNDoxl7+m
         nE5x/ewPbW9f8ysue3wthmCpWDYhwmaMW+hbAzgINUUWqm15sqyc0Tdzwv+cFCY6neul
         uTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/IyDiwGx0oynfsQU8HCCpuJVEgVM4xzXK9Jk5hyXYC0=;
        b=iK1YIpFQoWmTunvGPI1OzkJkLIjSMG08wvwQbL689ygZyTiJo/W/lM1kbBt7npFCyE
         wVO7qTTHdILhoPGwE4ghvRU5pp2x/BnRANrMaMa71Kyo5RopW+qV/Gjlb8j3MPm7cFVO
         3smKmpf6f0XgOTZERQZkExBGcIDsvN2ZCYn6A0rs4wcYOCe+UzhWgmOkCD/3I1c+g6tl
         /vdUcyuaqTD5J+5SDrsTBLrMwleYieaT7/H2QrcHw34/j31SSIq9Ss31+r7u2mRsf7CE
         HtyuwbXzmygzbKEWRuKgVDxDCa5GRyWV/4nbNn1B+rGnVYbpJcUy9gkEqmIQ9dEWrGGt
         CLzA==
X-Gm-Message-State: AOAM530rxlhk/5+lsVRusWaxMn6WBiPnxlbgE/46vnaxgMXAfRksOwSX
        YlAlvM0T6KwVBiN0wE8vMv2oVhdzCxKRjg==
X-Google-Smtp-Source: ABdhPJz/mlc5zTb7G0kE7sT/lRuIrCQbvQhNqCawVmpbBmxrep8fen4outpgAzGX6g8an8daQ9dlHQ==
X-Received: by 2002:a63:f40f:: with SMTP id g15mr2706536pgi.285.1592326084647;
        Tue, 16 Jun 2020 09:48:04 -0700 (PDT)
Received: from Trinity.hsd1.ma.comcast.net ([2601:189:8200:19b0:2c35:a6a0:b6d1:51a])
        by smtp.gmail.com with ESMTPSA id h8sm14862665pgm.16.2020.06.16.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:48:03 -0700 (PDT)
From:   peter.puhov@linaro.org
To:     linux-kernel@vger.kernel.org
Cc:     peter.puhov@linaro.org, robert.foley@linaro.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH] sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal
Date:   Tue, 16 Jun 2020 12:48:00 -0400
Message-Id: <20200616164801.18644-1-peter.puhov@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Puhov <peter.puhov@linaro.org>

In slow path, when selecting idlest group, if both groups have type 
group_has_spare, only idle_cpus count gets compared.
As a result, if multiple tasks are created in a tight loop,
and go back to sleep immediately 
(while waiting for all tasks to be created), 
they may be scheduled on the same core, because CPU is back to idle
when the new fork happen.

For example:
sudo perf record -e sched:sched_wakeup_new -- \
                                  sysbench threads --threads=4 run
...
    total number of events:              61582
...
sudo perf script
sysbench 129378 [006] 74586.633466: sched:sched_wakeup_new: 
                            sysbench:129380 [120] success=1 CPU:007
sysbench 129378 [006] 74586.634718: sched:sched_wakeup_new: 
                            sysbench:129381 [120] success=1 CPU:007
sysbench 129378 [006] 74586.635957: sched:sched_wakeup_new: 
                            sysbench:129382 [120] success=1 CPU:007
sysbench 129378 [006] 74586.637183: sched:sched_wakeup_new: 
                            sysbench:129383 [120] success=1 CPU:007

This may have negative impact on performance for workloads with frequent
creation of multiple threads.

In this patch we using group_util to select idlest group if both groups 
have equal number of idle_cpus. In this case newly created tasks would be
better distributed. It is possible to use nr_running instead of group_util,
but result is less predictable.

With this patch:
sudo perf record -e sched:sched_wakeup_new -- \
                                    sysbench threads --threads=4 run
...
    total number of events:              74401
...
sudo perf script
sysbench 129455 [006] 75232.853257: sched:sched_wakeup_new: 
                            sysbench:129457 [120] success=1 CPU:008
sysbench 129455 [006] 75232.854489: sched:sched_wakeup_new: 
                            sysbench:129458 [120] success=1 CPU:009
sysbench 129455 [006] 75232.855732: sched:sched_wakeup_new: 
                            sysbench:129459 [120] success=1 CPU:010
sysbench 129455 [006] 75232.856980: sched:sched_wakeup_new: 
                            sysbench:129460 [120] success=1 CPU:011

We tested this patch with following benchmarks:
  perf bench -f simple sched pipe -l 4000000
  perf bench -f simple sched messaging -l 30000
  perf bench -f simple  mem memset -s 3GB -l 15 -f default
  perf bench -f simple futex wake -s -t 640 -w 1
  sysbench cpu --threads=8 --cpu-max-prime=10000 run
  sysbench memory --memory-access-mode=rnd --threads=8 run
  sysbench threads --threads=8 run
  sysbench mutex --mutex-num=1 --threads=8 run
  hackbench --loops 20000
  hackbench --pipe --threads --loops 20000
  hackbench --pipe --threads --loops 20000 --datasize 4096

and found some performance improvements in:
  sysbench threads
  sysbench mutex
  perf bench futex wake
and no regressions in others.

master: 'commit b3a9e3b9622a ("Linux 5.8-rc1")' 
$> sysbench threads --threads=16 run
	sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)
	Running the test with following options:
	Number of threads: 16
	Initializing random number generator from current time
	Initializing worker threads...
	Threads started!
	General statistics:
		total time:                          10.0079s
		total number of events:              45526 << higher is better
	Latency (ms):
			min:                                  0.36
			avg:                                  3.52
			max:                                 54.22
			95th percentile:                     23.10
			sum:                             160044.33
	Threads fairness:
		events (avg/stddev):           2845.3750/94.18
		execution time (avg/stddev):   10.0028/0.00

With patch:
$> sysbench threads --threads=16 run
	sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)
	Running the test with following options:
	Number of threads: 16
	Initializing random number generator from current time
	Initializing worker threads...
	Threads started!
	General statistics:
		total time:                          10.0053s
		total number of events:              56567  << higher is better
	Latency (ms):
			min:                                  0.36
			avg:                                  2.83
			max:                                 27.65
			95th percentile:                     18.95
			sum:                             160003.83

	Threads fairness:
		events (avg/stddev):           3535.4375/147.38
		execution time (avg/stddev):   10.0002/0.00

master: 'commit b3a9e3b9622a ("Linux 5.8-rc1")' 
$> sysbench mutex --mutex-num=1 --threads=32 run
	sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)
	Running the test with following options:
	Number of threads: 32
	Initializing random number generator from current time
	Initializing worker threads...
	Threads started!
	General statistics:
		total time:                          1.0415s << lower is better
		total number of events:              32
	Latency (ms):
			min:                                940.57
			avg:                                959.24
			max:                               1041.05
			95th percentile:                    960.30
			sum:                              30695.84
	Threads fairness:
		events (avg/stddev):           1.0000/0.00
		execution time (avg/stddev):   0.9592/0.02

With patch:
@> sysbench mutex --mutex-num=1 --threads=32 run
	sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)
	Running the test with following options:
	Number of threads: 32
	Initializing random number generator from current time
	Initializing worker threads...
	Threads started!
	General statistics:
		total time:                          0.9209s  << lower is better
		total number of events:              32
	Latency (ms):
			min:                                867.37
			avg:                                892.09
			max:                                920.70
			95th percentile:                    909.80
			sum:                              28546.84
	Threads fairness:
		events (avg/stddev):           1.0000/0.00
		execution time (avg/stddev):   0.8921/0.01

master: 'commit b3a9e3b9622a ("Linux 5.8-rc1")'
$> perf bench futex wake -s -t 128 -w 1
	# Running 'futex/wake' benchmark:
	Run summary [PID 2414]: blocking on 128 threads 
			(at [private] futex 0xaaaab663a154), waking up 1 at a time.
	Wokeup 128 of 128 threads in 0.2852 ms (+-1.86%) << lower is better

With patch:
$> perf bench futex wake -s -t 128 -w 1
	# Running 'futex/wake' benchmark:
	Run summary [PID 5057]: blocking on 128 threads 
			(at [private] futex 0xaaaace461154), waking up 1 at a time.
	Wokeup 128 of 128 threads in 0.2705 ms (+-1.84%) << lower is better

Signed-off-by: Peter Puhov <peter.puhov@linaro.org>
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..abcbdf80ee75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8662,8 +8662,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
 
 	case group_has_spare:
 		/* Select group with most idle CPUs */
-		if (idlest_sgs->idle_cpus >= sgs->idle_cpus)
+		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
 			return false;
+
+		/* Select group with lowest group_util */
+		if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
+			idlest_sgs->group_util <= sgs->group_util)
+			return false;
+
 		break;
 	}
 
-- 
2.20.1


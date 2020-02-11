Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE171C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AC720661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZ8OTvm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgBKRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:47:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52798 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgBKRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:47:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so4723448wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fjygYp7tABMf5L/EZRwinKbMPx8VTXvT25w8ysjzWTw=;
        b=UZ8OTvm/dznGw0AsCrvMPn6PdSpg6y9vTEelAgqmbXFkK0M7W3ZwP+pVEdSxRFhZVC
         XPWwFdXIUSyFGIsmawWz1/ZuBc3T9CXbyzuDXN+gGW0pfJ7smqUs2rvjVlOetDoTI6eJ
         n8PqZuBV77w6/X7RnoI69BAE09cX4wI4OQLXt2AhqvuxFB/zm9bc7nPFXYyXYxhP7Xzo
         euXZO7cJKBjCnNi4sTFknalgDw+zI7bLDib7+G4OEqOf22JInG/1BALd0GrBeCWNkSV3
         lRiSl2FY+C4PISO4rA+i1PUvCueJU/g4jMDnb5ynA+lXCGh4rfO53TJnBxbVbyyuFk+6
         Q63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fjygYp7tABMf5L/EZRwinKbMPx8VTXvT25w8ysjzWTw=;
        b=c89jEw4l2P2nZUFLstDEzXwK2nYCUWan1q7F+Bgqg8G1fA3/hyeOTU7uqxiRRbumfX
         KDVxLUjKSHaXWcdCoqrT0r1qtGxQ2foST54LsTFNdSs3KKvFNjgFB/c8XopHsySlktHJ
         KRUXs2Iwls665KasI5IerxVvB1FDmd4orxlI1up2IznUhMsdscYdjNlUz5QMA8NIfNP0
         Gjx69kO1ow8D/Y2VjbK+tzTou/C4AuIUpCiT5pcvE75Fm9rnnlFUjQUnqsnWZNcNKCMq
         CQtNWhrotpUm5mpRlzlsNdILpRTJDKN+90u1gij2kzrt8Pb1vhEIUhpLDHTEcBAbfJtA
         yG1w==
X-Gm-Message-State: APjAAAVd8XVPrkzLKfCdi0Gb8SunzjjsbJ+Gl5lYbgR/NAuyKCg05iZc
        gLCDUSqp0+izk2M/Znr6KTfOTg==
X-Google-Smtp-Source: APXvYqwiim6pLgFut+znToSZ6lbbj/z21X4uWOx4DnYNoi6AXw/Hu2fZWg99PgcOqF4gjmTG2xJ0IA==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr6749804wmc.123.1581443222384;
        Tue, 11 Feb 2020 09:47:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:39bd:f3e9:9eaa:e898])
        by smtp.gmail.com with ESMTPSA id s12sm6104764wrw.20.2020.02.11.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:47:01 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/4] remove runnable_load_avg and improve group_classify
Date:   Tue, 11 Feb 2020 18:46:47 +0100
Message-Id: <20200211174651.10330-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA load balancing is the last remaining piece of code that uses the 
runnable_load_avg of PELT to balance tasks between nodes. The normal
load_balance has replaced it by a better description of the current state
of the group of cpus.  The same policy can be applied to the numa
balancing.

Once unused, runnable_load_avg can be replaced by a simpler runnable_avg
signal that tracks the waiting time of tasks on rq. Currently, the state
of a group of CPUs is defined thanks to the number of running task and the
level of utilization of rq. But the utilization can be temporarly low
after the migration of a task whereas the rq is still overloaded with
tasks. In such case where tasks were competing for the rq, the
runnable_avg will stay high after the migration.

Some hackbench results:

- small arm64 dual quad cores system
hackbench -l (2560/#grp) -g #grp

grp    tip/sched/core         +patchset              improvement
1       1,327(+/-10,06 %)     1,247(+/-5,45 %)       5,97 %
4       1,250(+/- 2,55 %)     1,207(+/-2,12 %)       3,42 %
8       1,189(+/- 1,47 %)     1,179(+/-1,93 %)       0,90 %
16      1,221(+/- 3,25 %)     1,219(+/-2,44 %)       0,16 %						

- large arm64 2 nodes / 224 cores system
hackbench -l (256000/#grp) -g #grp

grp    tip/sched/core         +patchset              improvement
1      14,197(+/- 2,73 %)     13,917(+/- 2,19 %)     1,98 %
4       6,817(+/- 1,27 %)      6,523(+/-11,96 %)     4,31 %
16      2,930(+/- 1,07 %)      2,911(+/- 1,08 %)     0,66 %
32      2,735(+/- 1,71 %)      2,725(+/- 1,53 %)     0,37 %
64      2,702(+/- 0,32 %)      2,717(+/- 1,07 %)    -0,53 %
128     3,533(+/-14,66 %)     3,123(+/-12,47 %)     11,59 %
256     3,918(+/-19,93 %)     3,390(+/- 5,93 %)     13,47 %

The significant improvement for 128 and 256 should be taken with care
because of some instabilities over iterations without the patchset.

The table below shows figures of the classification of sched group during
load balance (idle, newly or busy lb) with the disribution according to
the number of running tasks for:
    hackbench -l 640 -g 4 on octo cores

                 tip/sched/core  +patchset
state
has spare            3973        1934	
        nr_running					
            0        1965        1858
            1         518          56
            2         369          18
            3         270           2
            4+        851           0
						
fully busy            546        1018	
        nr_running					
            0           0           0
            1         546        1018
            2           0           0
            3           0           0
            4+          0           0
						
overloaded           2109        3056	
        nr_running					
            0           0           0
            1           0           0
            2         241         483
            3         170         348
            4+       1698        2225

total                6628        6008	

Without the patchset, there is a significant number of time that a CPU has
spare capacity with more than 1 running task. Although this is a valid
case, this is not a state that should often happen when 160 tasks are
competing on 8 cores like for this test. The patchset fixes the situation
by taking into account the runnable_avg, which stays high after the
migration of a task on another CPU.

Vincent Guittot (4):
  sched/fair: reorder enqueue/dequeue_task_fair path
  sched/numa: replace runnable_load_avg by load_avg
  sched/fair: replace runnable load average by runnable average
  sched/fair: Take into runnable_avg to classify group

 include/linux/sched.h |  17 ++-
 kernel/sched/core.c   |   2 -
 kernel/sched/debug.c  |  17 +--
 kernel/sched/fair.c   | 335 ++++++++++++++++++++++--------------------
 kernel/sched/pelt.c   |  45 +++---
 kernel/sched/sched.h  |  29 +++-
 6 files changed, 241 insertions(+), 204 deletions(-)

-- 
2.17.1


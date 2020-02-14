Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65942C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E91624670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXFW7H0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgBNP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:27:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50376 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgBNP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:27:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so10344450wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+6mQp/Hzs3J1YYs/fQR/pMVLynsZKSsK9C0Wv5QL8Gs=;
        b=dXFW7H0PB6zI2Fmu4lv/4p/ACc3BZ/6c4y1KSDJ25Mc3XoZ8xhSPGnmdhREYAaDAxo
         QLGw8/qBgNgk6YA8LSANjtds1rGRwt11VWSHEB0UQ3WIyfamWGEnHOY93llA6grWKuVw
         Yg3DuakCy2r8vTq6Y++1uT7R29nKgPepqxwDYMSroKcsQiYyQAFsKn75V5r0yJzmN/JI
         pQB+YrJxlEYfmy1H8MubvnGbTlZgNhyanq5S7lfSDCIm6IoXvUdsSnEwaJ3Inu4RFNnj
         /X0kcfj2tUCyO06vECIMSh8d5ywQARlzY9EQ0nBnWRH8mBTAmdhoPyQEetIRrI2ufVSt
         57Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+6mQp/Hzs3J1YYs/fQR/pMVLynsZKSsK9C0Wv5QL8Gs=;
        b=rfjI6wXwF+pOBupLIcLM4ZOeSSXktq8fAyuKDksjKyK+ICh2Q2TgR19tGbMecpGeJW
         +6eoFcL4qtVOFHcL1fpc4/jv9/FT7qcXdbzMeW0m3Isr0ahjPljAA9lZDFq6idGiD/sD
         LwjYBSa+xzojq3kvl13SX87nKZPF+tmng6PPbgN5QlVEV7WW3hfKAAIrEpd025lIVNJY
         lISFbUmwfbhdZ8oYKBsS5JUC83x8nkQT3TKNsTF6hMxGyetjb8ZOcikgU2XK0JIDOVco
         nfwE6InrqGnM1bpo/X989OW8Gchmc0o7OfqFbE8Zs6kEgBm8BsqPSsw8Nna06D2nHJh+
         1sVg==
X-Gm-Message-State: APjAAAWPpNkOtgZ9JtBkuBc6LJ9RQJROsDhb7jXsPvK97wW5j1BxMjxz
        uK8AWi97TiMKuldXUo2a3AfCF4n+NgJG/Q==
X-Google-Smtp-Source: APXvYqyd8KTgQtpAlS/pkeChGgHJyXoYz3Kab73yvuAMzwpSf7rbHNGNfFlm9A/vMJhAvB1HC3neDQ==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr5214053wmf.63.1581694059956;
        Fri, 14 Feb 2020 07:27:39 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b5b3:5d19:723a:398f])
        by smtp.gmail.com with ESMTPSA id c13sm7442963wrn.46.2020.02.14.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:27:38 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/5] remove runnable_load_avg and improve group_classify
Date:   Fri, 14 Feb 2020 16:27:24 +0100
Message-Id: <20200214152729.6059-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new version stays quite close to the previous one and should 
replace without problems the previous one that part of Mel's patchset:
https://lkml.org/lkml/2020/2/14/156

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

Changes since RFC:
- fix come comment and typo
- split in 2 patches the removale of runnable_load_avg and the addition of
  runnbale_avg

Vincent Guittot (5):
  sched/fair: Reorder enqueue/dequeue_task_fair path
  sched/numa: Replace runnable_load_avg by load_avg
  sched/pelt: Remove unused runnable load average
  sched/pelt: Add a new runnable average signal
  sched/fair: Take into account runnable_avg to classify group


 include/linux/sched.h |  33 +++--
 kernel/sched/core.c   |   2 -
 kernel/sched/debug.c  |  17 +--
 kernel/sched/fair.c   | 337 ++++++++++++++++++++++--------------------
 kernel/sched/pelt.c   |  45 +++---
 kernel/sched/sched.h  |  29 +++-
 6 files changed, 247 insertions(+), 216 deletions(-)

-- 
2.17.1


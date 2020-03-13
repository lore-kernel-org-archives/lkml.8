Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09897C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D081620658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vpaN+NIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCMX32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:29:28 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44184 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMX32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:29:28 -0400
Received: by mail-qv1-f66.google.com with SMTP id w5so5619654qvp.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69w0IAqxf9mqjiQh6d+eU21vBcUH24Ogd6Z5EgYS968=;
        b=vpaN+NISRDEGC/3fS1vQcHRYNTL4vGCwS15Hgl8FWFc6Ey+vgruYdyK1G397WSjtFO
         /wgShAnlT0fhRpFyTcruxZXNAn3fLqLG8SQ/A/hIBsUKS54YDgxIRXVJVBNNsqkZIIXT
         ve9RBOYuJRonGCuGe/NVoTBrCHHVLn21KC0Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69w0IAqxf9mqjiQh6d+eU21vBcUH24Ogd6Z5EgYS968=;
        b=OXwzshbklgttF4VKzcGKBwDfqgTx186N/snkf8ZODK0GZnk2+SVQpqjSlCVqjeEiqH
         Zqd10LdpDf2+kjE9JpquZxa8K1dHB/gNQL0qK7tYuOXCqlZcUC+vg07p6pjSB6gfx8fy
         tbWzaVh7CmAKkpW5wPxNzdbckKMq5FlsBLrd6XJuvb96oIZSzYTspb3pqE/djCiWEPnT
         QQMR33hg/UmKxQbi1w50vQ9Qv/ph9seBAT5mzEPxk2Gf2TB2kvxW6hwywWZ2k7txbyES
         N75FblciSdvg1I/gwiuLA/o0tStv87VR/qXRyAX1XVLFdxca9E+0ReQdz1jQFkQfUag1
         yGjw==
X-Gm-Message-State: ANhLgQ39SzCQsvrHbLRD5FMr0JPTFzeYfu2xHit88M5InBogwLyKIYcv
        qszFlrQt+oApfQyJTUzuXL6BuS+vwMA=
X-Google-Smtp-Source: ADFU+vt5J5Ut4zQIOZV7bmd7wASp+G/ZaYwfScA2MWJpW94XAiNWPdq8ud62G5O2ql9Q76zhEZF4bg==
X-Received: by 2002:a0c:ebcc:: with SMTP id k12mr13538558qvq.69.1584142167093;
        Fri, 13 Mar 2020 16:29:27 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x51sm10143593qtj.82.2020.03.13.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:29:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        vpillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, peterz@infradead.org,
        paulmck@kernel.org, Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: Use RCU-sched in core-scheduling balancing logic
Date:   Fri, 13 Mar 2020 19:29:18 -0400
Message-Id: <20200313232918.62303-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_read_unlock() can incur an infrequent deadlock in
sched_core_balance(). Fix this by using the RCU-sched flavor instead.

This fixes the following spinlock recursion observed when testing the
core scheduling patches on PREEMPT=y kernel on ChromeOS:

[    3.240891] BUG: spinlock recursion on CPU#2, swapper/2/0
[    3.240900]  lock: 0xffff9cd1eeb28e40, .magic: dead4ead, .owner: swapper/2/0, .owner_cpu: 2
[    3.240905] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.4.22htcore #4
[    3.240908] Hardware name: Google Eve/Eve, BIOS Google_Eve.9584.174.0 05/29/2018
[    3.240910] Call Trace:
[    3.240919]  dump_stack+0x97/0xdb
[    3.240924]  ? spin_bug+0xa4/0xb1
[    3.240927]  do_raw_spin_lock+0x79/0x98
[    3.240931]  try_to_wake_up+0x367/0x61b
[    3.240935]  rcu_read_unlock_special+0xde/0x169
[    3.240938]  ? sched_core_balance+0xd9/0x11e
[    3.240941]  __rcu_read_unlock+0x48/0x4a
[    3.240945]  __balance_callback+0x50/0xa1
[    3.240949]  __schedule+0x55a/0x61e
[    3.240952]  schedule_idle+0x21/0x2d
[    3.240956]  do_idle+0x1d5/0x1f8
[    3.240960]  cpu_startup_entry+0x1d/0x1f
[    3.240964]  start_secondary+0x159/0x174
[    3.240967]  secondary_startup_64+0xa4/0xb0
[   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]

Cc: vpillai <vpillai@digitalocean.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Aubrey Li <aubrey.intel@gmail.com>
Cc: peterz@infradead.org
Cc: paulmck@kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3045bd50e249..037e8f2e2686 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4735,7 +4735,7 @@ static void sched_core_balance(struct rq *rq)
 	struct sched_domain *sd;
 	int cpu = cpu_of(rq);
 
-	rcu_read_lock();
+	rcu_read_lock_sched();
 	raw_spin_unlock_irq(rq_lockp(rq));
 	for_each_domain(cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -4748,7 +4748,7 @@ static void sched_core_balance(struct rq *rq)
 			break;
 	}
 	raw_spin_lock_irq(rq_lockp(rq));
-	rcu_read_unlock();
+	rcu_read_unlock_sched();
 }
 
 static DEFINE_PER_CPU(struct callback_head, core_balance_head);
-- 
2.25.1.481.gfbce0eb801-goog


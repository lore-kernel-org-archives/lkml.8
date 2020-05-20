Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3176C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E52120873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HMo1TGmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgETWs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgETWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:48:26 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF07BC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:48:26 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id er16so2230599qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RStaSzm0BE79LxWHy0r6BH6gCPvj9qWnIh+kjRrtDqs=;
        b=HMo1TGmoIadolO348/feUnNKreceXmNKSpkmSSZBAfVlijoSVb7QdgroRmplfbn43Q
         fRlJiTkyVCaEUr2sZuc7m3WQVaJC6ui1ntFR0I5Os/tIeou8a10HOEjN4v6OW0QjFezt
         VZyINWgAw8VPK+6riAK0tl6vVs4lAnSmPjXr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RStaSzm0BE79LxWHy0r6BH6gCPvj9qWnIh+kjRrtDqs=;
        b=o6ma8TYdqyFt6Kf79sufuYGp1RCYojrM+bu2aO3Qydwrx4F0LQXhX1Ts52mCp1O4bo
         d+s30TA4XrCdonV7wfMNNO8NlljPeTlAZKuMaQYc0RsFeUXS9jFTZTqssBhACzjFb9wQ
         Talt7bE6TUbc8cbD9QXb0rLSK+83V/XPdeL8LyNdeEze4A/11rithtqT33ociLcuZKWb
         qN7P1+bipr4N+ZPgVozoBxT/X2v/INZMsnck+NkSpEul6WNWNjeARXlQfzaoHXm9xBRf
         8cILjx9be+xGcYf5dODCGex3He8v8iG4BsmFtXlyn6R9OUCDZ2/tlrWU0Zow1iACqBcE
         pqNQ==
X-Gm-Message-State: AOAM530twvJ98I6WkOaL1aCzTwNW+weR0bwwE96dNUupFdGgDBQaSTNN
        D3HbHb4zZmtzj9X3Hn/j7A3MRg==
X-Google-Smtp-Source: ABdhPJx6kwE258pbhfEt1te9GYfBlCarhExCr10+mjpGezARIkHTrNcpY3adcrfm7+5RiLYQTARiKg==
X-Received: by 2002:a0c:b78a:: with SMTP id l10mr7528048qve.121.1590014905916;
        Wed, 20 May 2020 15:48:25 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c3sm3451258qtp.24.2020.05.20.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:48:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        paulmck@kernel.org
Subject: [PATCH RFC] sched: Use sched-RCU in core-scheduling balancing logic
Date:   Wed, 20 May 2020 18:48:18 -0400
Message-Id: <20200520224818.78930-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_read_unlock() can incur an infrequent deadlock in
sched_core_balance(). Fix this by using sched-RCU instead.

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
Change-Id: I1a4bf0cd1426b3c21ad5de44719813ad4ee5805e
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 780514d03da47..b8ca6fcaaaf06 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4897,7 +4897,7 @@ static void sched_core_balance(struct rq *rq)
 	struct sched_domain *sd;
 	int cpu = cpu_of(rq);
 
-	rcu_read_lock();
+	rcu_read_lock_sched();
 	raw_spin_unlock_irq(rq_lockp(rq));
 	for_each_domain(cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -4910,7 +4910,7 @@ static void sched_core_balance(struct rq *rq)
 			break;
 	}
 	raw_spin_lock_irq(rq_lockp(rq));
-	rcu_read_unlock();
+	rcu_read_unlock_sched();
 }
 
 static DEFINE_PER_CPU(struct callback_head, core_balance_head);
-- 
2.26.2.761.g0e0b3e54be-goog


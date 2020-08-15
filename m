Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFADC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE35620639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VihnvLNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgHOWHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgHOVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7893C06137C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so10203621qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+tcxwumkRlUZ+dHGtXtIYsQuEL+Suyx+IL7hWNPqcc=;
        b=VihnvLNvi7fm/vGqgwWniK4q9Or33o+fcFfy+4EuCI3nBUqnUwu8O3wSniZsFgcLCS
         GY6mFAh35OeVrNRthiK7QsdLWO2TMOOhNdFi9s3S0qhKs4rv/1IOYEchKmV9ykmg7/Hv
         SFnRliiY/Op3UGMVKaeKOw/fdaLBkJ4y/sMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+tcxwumkRlUZ+dHGtXtIYsQuEL+Suyx+IL7hWNPqcc=;
        b=g678YFPunSHOAmjoBfSOTNbrcsEykGwDhWpqHRaiLeoV2sHbHAXNAAy77m/yamdLAV
         GsIpQkVNPtQygoK9oEGb7lPK50cVNCWIQJRVxtvi4CliZ3EZqcss0zolkIQ1r1gfIww4
         QJR66xtt/GRfAn30lZJ63+QRSoNWxSEs4ad06uEAYXehkog+PQVIdWiQFoT9k3B18Tnz
         75xDnKkE/4CZYbxJ6LsBVfx5DpzDYUVY5vLhIJm1Wc2nfXadDOdlKqhqCa6RyiyVrI8C
         jIYz/s6ncYG95LqrEQrdPLr4lN51UvMYBdis+pnEkvGQV/hyWuHt79dyb0EI1oSlacey
         m/9w==
X-Gm-Message-State: AOAM5331eSVxW7ZndcdWwF9L83fmtPG7pqD+468vTsSD6uBIrLPKODOM
        Z4aw/VHGIlEfUuFt5Q4ND1djU0YX8gKYqw==
X-Google-Smtp-Source: ABdhPJzr0EEDBpbBOEXApU/v6u5K2CG1nZZpgKij0Si6BF6meTqNfC2rIq+6NLuHjNL/DOCii/AYwQ==
X-Received: by 2002:a37:a953:: with SMTP id s80mr4511361qke.239.1597461574990;
        Fri, 14 Aug 2020 20:19:34 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 11/12] sched/coresched: Check for dynamic changes in smt_mask
Date:   Fri, 14 Aug 2020 23:19:07 -0400
Message-Id: <20200815031908.1015049-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

There are multiple loops in pick_next_task that iterate over CPUs in
smt_mask. During a hotplug event, sibling could be removed from the
smt_mask while pick_next_task is running. So we cannot trust the mask
across the different loops. This can confuse the logic.

Add a retry logic if smt_mask changes between the loops.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 48a49168e57f..5da5b2317b21 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4613,6 +4613,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
 	int i, j, cpu, occ = 0;
+	int smt_weight;
 	bool need_sync;
 
 	if (!sched_core_enabled(rq))
@@ -4648,6 +4649,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	cpu = cpu_of(rq);
 	smt_mask = cpu_smt_mask(cpu);
 
+retry_select:
+	smt_weight = cpumask_weight(smt_mask);
+
 	/*
 	 * core->core_task_seq, rq->core_pick_seq, rq->core_sched_seq
 	 *
@@ -4691,6 +4695,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
 
+			/*
+			 * During hotplug online a sibling can be added in
+			 * the smt_mask * while we are here. If so, we would
+			 * need to restart selection by resetting all over.
+			 */
+			if (unlikely(smt_weight != cpumask_weight(smt_mask)))
+				goto retry_select;
+
 			if (rq_i->core_pick)
 				continue;
 
@@ -4790,7 +4802,15 @@ next_class:;
 	for_each_cpu_or(i, smt_mask, cpumask_of(cpu)) {
 		struct rq *rq_i = cpu_rq(i);
 
-		WARN_ON_ONCE(!rq_i->core_pick);
+		WARN_ON_ONCE(smt_weight == cpumask_weight(smt_mask) && !rq->core_pick);
+
+		/*
+		 * During hotplug online a sibling can be added in the smt_mask
+		 * while we are here. We might have missed picking a task for it.
+		 * Ignore it now as a schedule on that sibling will correct itself.
+		 */
+		if (!rq_i->core_pick)
+			continue;
 
 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
 			rq_i->core_forceidle = true;
-- 
2.28.0.220.ged08abb693-goog


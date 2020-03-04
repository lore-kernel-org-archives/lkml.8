Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AC0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F09A20842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1vPrGbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgCDLvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:51:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37798 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCDLva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:51:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id a141so1557803wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xMdW8PIER+wuVM2ELm0gxhpZN1TOjwXYWAEUqQETAek=;
        b=n1vPrGbxQGRpzIb31a3vN7OEsSO7ZeA9lL/n7PBMhXQCm+5eU94H/N0pSfD0KOVkh5
         S2J3gWHr62hlYfjvaCnwKIWZhlkZVO2ZbIOVyTjdUtpgUuV6iI7FRxT7+RWEjXIsjVxw
         8CS7585565e2e8pSXNA69eXHbHZBUHvsP9m7E8Z9vrwuWQeTdGDK7iNup6/QF4nclr1e
         zUJEZBGZUkLiiWUxC91H+fZjqXDTFjN7V0r4kFxI9ulcyAyb9mwfXNFJvQOVuagkeNhb
         C5Y3gfe3QU6rEDNNP1GMCvfuWmWJsJVFcyzf9a/E6FEa+WSRif2UZB3zDh2pjTWVC7zy
         9S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xMdW8PIER+wuVM2ELm0gxhpZN1TOjwXYWAEUqQETAek=;
        b=kJG7yMmL4UBcrdaZkiChMo5+KuObzxRh+hfrRLLe31z6/plONp+H/+lfopRT+LrdOt
         erLKvksS+b02dZqbCemZaSzWgyTJXUcOHYpLvIDWhQ2SlXXODOn0wMZE9PXnoaR/vUFY
         e2WY+JymlW2xfLltjfEsrHDKBzFmsGpZWGjGPctXGYB6RoXpPsZv4asKzEDgsYuttkja
         JAPi5q6jIjX0FHcnZ9OE+xeeGc+gqt+F5fWvkNMOx5n6ob9D6q0dR8qeHHNpEo+IkYVu
         2a4H04vIAfQHIxA3EIEqI28pxZMKM8CtgsQ03kLMKbRslyMZRRs6HH1f7bsPWipBRonG
         KCMw==
X-Gm-Message-State: ANhLgQ2rjXudEN95WSLnlsR8pRikbkvMakjWKlW/8ZVHOtlsrt4XgHb+
        +FIjW+xtAmoUJAVjMigCJTJuUA==
X-Google-Smtp-Source: ADFU+vtYUm0YzXkottIaoNL6VcDQD2tQRoZwDbcXGrBAY38gsWYDUBgCxn1qpaEXS54vpov7QqF5MA==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr3530226wmj.66.1583322688195;
        Wed, 04 Mar 2020 03:51:28 -0800 (PST)
Received: from localhost.localdomain (40.162.129.77.rev.sfr.net. [77.129.162.40])
        by smtp.gmail.com with ESMTPSA id t3sm38946733wrx.38.2020.03.04.03.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:51:27 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH] sched: fair: Use the earliest break even
Date:   Wed,  4 Mar 2020 12:48:44 +0100
Message-Id: <20200304114844.17700-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the idle CPU selection process occuring in the slow path via the
find_idlest_group_cpu() function, we pick up in priority an idle CPU
with the shallowest idle state otherwise we fall back to the least
loaded CPU.

In order to be more energy efficient but without impacting the
performances, let's use another criteria: the break even deadline.

At idle time, when we store the idle state the CPU is entering in, we
compute the next deadline where the CPU could be woken up without
spending more energy to sleep.

At the selection process, we use the shallowest CPU but in addition we
choose the one with the minimal break even deadline instead of relying
on the idle_timestamp. When the CPU is idle, the timestamp has less
meaning because the CPU could have wake up and sleep again several times
without exiting the idle loop. In this case the break even deadline is
more relevant as it increases the probability of choosing a CPU which
reached its break even.

Tested on a synquacer 24 cores, 6 sched domains:

sched/perf and messaging does not show a performance regression. Ran
10 times schbench and adrestia.

with break-even deadline:
-------------------------
schbench *99.0th        : 14844.8
adrestia / periodic     : 57.95
adrestia / single       : 49.3

Without break-even deadline:
----------------------------
schbench / *99.0th      : 15017.6
adrestia / periodic     : 57
adrestia / single       : 55.4

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/fair.c  | 18 ++++++++++++++++--
 kernel/sched/idle.c  |  9 ++++++++-
 kernel/sched/sched.h | 20 ++++++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..520c5e822fdd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 {
 	unsigned long load, min_load = ULONG_MAX;
 	unsigned int min_exit_latency = UINT_MAX;
+	s64 min_break_even = S64_MAX;
 	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
 	int shallowest_idle_cpu = -1;
@@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 		if (available_idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
+			s64 break_even = idle_get_break_even(rq);
+			
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
 				 * We give priority to a CPU whose idle state
@@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				 * of any idle timestamp.
 				 */
 				min_exit_latency = idle->exit_latency;
+				min_break_even = break_even;
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
-			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
-				   rq->idle_stamp > latest_idle_timestamp) {
+			} else if ((idle && idle->exit_latency == min_exit_latency) &&
+				   break_even < min_break_even) {
+				/*
+				 * We give priority to the shallowest
+				 * idle states with the minimal break
+				 * even deadline to decrease the
+				 * probability to choose a CPU which
+				 * did not reach its break even yet
+				 */
+				min_break_even = break_even;
+				shallowest_idle_cpu = i;
+			} else if (!idle && rq->idle_stamp > latest_idle_timestamp) {
 				/*
 				 * If equal or no active idle state, then
 				 * the most recently idled CPU might have
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index b743bf38f08f..189cd51cd474 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -19,7 +19,14 @@ extern char __cpuidle_text_start[], __cpuidle_text_end[];
  */
 void sched_idle_set_state(struct cpuidle_state *idle_state)
 {
-	idle_set_state(this_rq(), idle_state);
+	struct rq *rq = this_rq();
+	ktime_t kt;
+
+	if (likely(idle_state)) {
+		kt = ktime_add_ns(ktime_get(), idle_state->exit_latency_ns);
+		idle_set_state(rq, idle_state);
+		idle_set_break_even(rq, ktime_to_ns(kt));
+	}
 }
 
 static int __read_mostly cpu_idle_force_poll;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2a0caf394dd4..abf2d2e73575 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1015,6 +1015,7 @@ struct rq {
 #ifdef CONFIG_CPU_IDLE
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
+	s64			break_even;
 #endif
 };
 
@@ -1850,6 +1851,16 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 
 	return rq->idle_state;
 }
+
+static inline void idle_set_break_even(struct rq *rq, s64 break_even)
+{
+	rq->break_even = break_even;
+}
+
+static inline s64 idle_get_break_even(struct rq *rq)
+{
+	return rq->break_even;
+}
 #else
 static inline void idle_set_state(struct rq *rq,
 				  struct cpuidle_state *idle_state)
@@ -1860,6 +1871,15 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 {
 	return NULL;
 }
+
+static inline void idle_set_break_even(struct rq *rq, s64 break_even)
+{
+}
+
+static inline s64 idle_get_break_even(struct rq *rq)
+{
+	return 0;
+}
 #endif
 
 extern void schedule_idle(void);
-- 
2.17.1


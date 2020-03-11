Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ECBC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E720737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lI5F1xuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgCKU2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:28:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38683 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKU2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:28:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id h83so105567wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dX7B1r1d1CAGPZyodDK/1CMQ7MpGTybHRBmnbhPP2iw=;
        b=lI5F1xuZdiXovN4AIax8f2G+RmJTUrYWzKo6syDNsucfZTwmMychb355pHM35/6QD6
         wv2ELYSlvoA3fwR9UR5MrUMpMPE1uKNMHtpxTvcEAU5XT/JKOJV3s6CBkaueY8GqWC4Q
         Zw76OceM22bnn8OOO48pR4cYzFEuIQSm6mqiWbG+i1qy5PWc81tLAehZbzqNFhVV6D0n
         yPMqoSwdcw2ujkYn8V0/4tnemZDx+QCmFuJN/DzmfRUEae3BJmTaMbzXhG/xBKRLfzzY
         9o6O6Mj7Gkcck3DOnQuLY458scqdCqlZsVeUfJlQfU8ZqbOHt4aFK2t7gxmXK86B0+Rr
         Ez2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dX7B1r1d1CAGPZyodDK/1CMQ7MpGTybHRBmnbhPP2iw=;
        b=P3Puw8KjRkRPjDUaintazM8PxgG+Dd7aeRxRWlQEEVsZIH4gEVVJzASNT3AciGBdNn
         xJMwEyyUva4/8H3FeDsPGkeEA3ZrpBj62N8rZBnJcOCZPOSt3FSuk4KKdoEgA4eSDvE6
         Nb0XqNMqXGXFWqoH8/iL4z40Fqg3yes6lhWEvmWbntjmH8Jd/BzkFBmf83EFNUWIy0PS
         LQ448h926rzShUNinunszQLwTP/Qz1yBWC7Zw1g8tKMX0sQ9Sv0kcGeS0abeN7a1oUHv
         j8w/UnPTyyIsGac3wXwzeMKZFIWkcXTubMLhRL6potCCEk0DDqRsUF/AOFNaJxJULgaw
         Ak1A==
X-Gm-Message-State: ANhLgQ2+an9ZEZJCIL2A9d8Ry35u+yi+JuJK5motkxqe2n6rFz5tzFjM
        mgVUF7p3whYSOIGbaLtw9lCD7g==
X-Google-Smtp-Source: ADFU+vvG7xlyMnZ9IW1Gzi6Wu9bJQJsCDoOS27SvqZqiyKSOB/5g3WlCYcT372Xu2FkPgbzdHnJ9HQ==
X-Received: by 2002:a05:600c:258c:: with SMTP id 12mr520562wmh.140.1583958515201;
        Wed, 11 Mar 2020 13:28:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:b03a:cf7a:80f1:c987])
        by smtp.gmail.com with ESMTPSA id d18sm9190677wrq.22.2020.03.11.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 13:28:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        valentin.schneider@arm.com
Subject: [PATCH V2] sched: fair: Use the earliest break even
Date:   Wed, 11 Mar 2020 21:26:25 +0100
Message-Id: <20200311202625.13629-1-daniel.lezcano@linaro.org>
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

Tested on:
 - a synquacer 24 cores, 6 sched domains
 - a hikey960 HMP 8 cores, 2 sched domains, with the EAS and energy probe

sched/perf and messaging does not show a performance regression. Ran
50 times schbench, adrestia and forkbench.

The tools described at https://lwn.net/Articles/724935/

 --------------------------------------------------------------
| Synquacer             | With break even | Without break even |
 --------------------------------------------------------------
| schbench *99.0th	|      14844.8    |         15017.6    |
| adrestia / periodic	|        57.95    |              57    |
| adrestia / single	|         49.3    |            55.4    |
 --------------------------------------------------------------
| Hikey960              | With break even | Without break even |
 --------------------------------------------------------------
| schbench *99.0th	|      56140.8    |           56256    |
| schbench energy	|      153.575    |         152.676    |
| adrestia / periodic	|         4.98    |             5.2    |
| adrestia / single	|         9.02    |            9.12    |
| adrestia energy	|         1.18    |           1.233    |
| forkbench             |        7.971    |            8.05    |
| forkbench energy      |         9.37    |            9.42    |
 --------------------------------------------------------------

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/fair.c  | 18 ++++++++++++++++--
 kernel/sched/idle.c  |  8 +++++++-
 kernel/sched/sched.h | 20 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b5d5e5e701e..8bd6ea148db7 100644
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
index b743bf38f08f..3342e7bae072 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -19,7 +19,13 @@ extern char __cpuidle_text_start[], __cpuidle_text_end[];
  */
 void sched_idle_set_state(struct cpuidle_state *idle_state)
 {
-	idle_set_state(this_rq(), idle_state);
+	struct rq *rq = this_rq();
+
+	idle_set_state(rq, idle_state);
+
+	if (idle_state)
+		idle_set_break_even(rq, ktime_get_ns() +
+				    idle_state->exit_latency_ns);
 }
 
 static int __read_mostly cpu_idle_force_poll;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2a0caf394dd4..eef1e535e2c2 100644
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
+	WRITE_ONCE(rq->break_even, break_even);
+}
+
+static inline s64 idle_get_break_even(struct rq *rq)
+{
+	return READ_ONCE(rq->break_even);
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


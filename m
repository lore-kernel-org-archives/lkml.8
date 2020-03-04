Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A448EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CE42465D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="VRArdCg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbgCDRAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:24 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43751 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388359AbgCDRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:19 -0500
Received: by mail-qv1-f66.google.com with SMTP id eb12so1086167qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sADPx7OazgDOOwf9vPVwiEhiMqBnjU05KKPLLLHmsf8=;
        b=VRArdCg2YbL7VSkoVn3asMtrVkek7/6ogjXXNu4ALg0abU/NZyc1hELW0vP/JxJmcq
         EvfrVHB+S6BC4wb8VJ6gmiUyTcyQAyDQpNdI9xsF2z/hNYLfmxTDv4q3tu/idjJs2Grf
         qU+rmkgN3qBFUbWzq5y18p7/TYSWBG3ivgdWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sADPx7OazgDOOwf9vPVwiEhiMqBnjU05KKPLLLHmsf8=;
        b=UXvwyR8/yzKbJPRyT7j2OcpEVATnisM508RmE4Hx/1cAmCCTDeKe10qR3F9jVQgjmM
         vRFlelwhm2ywJCXsvjb3x76FkGa1jhElYVCjx9NEqd3zXsX/OQzfR3MVwg1H5J8FZe2T
         sQ6t7qI/Uzhdaj1+vgk1MB/sAr/D64sfSRa/00pvJIeb+rNl3A91/BwZfF1F5goMO/MC
         /yn+yWh3Royjhic7T1J/6HLeFOzLBLTkUbTYO0JUyvYPLBVakW/eqsvPAwbCMGPT1diI
         RQnTnAPRFo4kPLEJh5AIo4oL0fW5HpnNe5fHAosNjRwkAbCMZ/FTaD2Hx/6C7LGEKtON
         7B9Q==
X-Gm-Message-State: ANhLgQ0gNpAmhgYOoeAjt/QYWGxbVa101sl/hmQOk/q0Sl7jJYLHnPHO
        ap/pQTH3wtBC8j8ze9xRVZ2HcfaOwjS7AA==
X-Google-Smtp-Source: ADFU+vs5ogT/Xwifa7hgfLpnOGmo1RpXbpwRK/EwzRy2ca/Ybve+s+Kc2s55v7my6OuTei0vxntOdQ==
X-Received: by 2002:a05:6214:907:: with SMTP id dj7mr2819421qvb.245.1583341217783;
        Wed, 04 Mar 2020 09:00:17 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id t29sm15010113qtt.20.2020.03.04.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:17 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: [RFC PATCH 10/13] sched: Trivial forced-newidle balancer
Date:   Wed,  4 Mar 2020 17:00:00 +0000
Message-Id: <f402d614d8ffbf7bfb58399833731c919e3f95c6.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When a sibling is forced-idle to match the core-cookie; search for
matching tasks to fill the core.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |   1 +
 kernel/sched/core.c   | 131 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c   |   1 +
 kernel/sched/sched.h  |   6 ++
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 80ec54706282..c9406a5b678f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -685,6 +685,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned int			core_occupation;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 556bf054b896..18ee8e10a171 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -218,6 +218,21 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	return match;
 }
 
+static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+{
+	struct rb_node *node = &p->core_node;
+
+	node = rb_next(node);
+	if (!node)
+		return NULL;
+
+	p = container_of(node, struct task_struct, core_node);
+	if (p->core_cookie != cookie)
+		return NULL;
+
+	return p;
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -4369,7 +4384,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
-	int i, j, cpu;
+	int i, j, cpu, occ = 0;
 	bool need_sync = false;
 
 	cpu = cpu_of(rq);
@@ -4476,6 +4491,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				goto done;
 			}
 
+			if (!is_idle_task(p))
+				occ++;
+
 			rq_i->core_pick = p;
 
 			/*
@@ -4501,6 +4519,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				} else {
 					/*
@@ -4540,6 +4559,8 @@ next_class:;
 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
 			rq_i->core_forceidle = true;
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu)
 			continue;
 
@@ -4555,6 +4576,114 @@ next_class:;
 	return next;
 }
 
+static bool try_steal_cookie(int this, int that)
+{
+	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
+	struct task_struct *p;
+	unsigned long cookie;
+	bool success = false;
+
+	local_irq_disable();
+	double_rq_lock(dst, src);
+
+	cookie = dst->core->core_cookie;
+	if (!cookie)
+		goto unlock;
+
+	if (dst->curr != dst->idle)
+		goto unlock;
+
+	p = sched_core_find(src, cookie);
+	if (p == src->idle)
+		goto unlock;
+
+	do {
+		if (p == src->core_pick || p == src->curr)
+			goto next;
+
+		if (!cpumask_test_cpu(this, &p->cpus_mask))
+			goto next;
+
+		if (p->core_occupation > dst->idle->core_occupation)
+			goto next;
+
+		p->on_rq = TASK_ON_RQ_MIGRATING;
+		deactivate_task(src, p, 0);
+		set_task_cpu(p, this);
+		activate_task(dst, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+
+		resched_curr(dst);
+
+		success = true;
+		break;
+
+next:
+		p = sched_core_next(p, cookie);
+	} while (p);
+
+unlock:
+	double_rq_unlock(dst, src);
+	local_irq_enable();
+
+	return success;
+}
+
+static bool steal_cookie_task(int cpu, struct sched_domain *sd)
+{
+	int i;
+
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+		if (i == cpu)
+			continue;
+
+		if (need_resched())
+			break;
+
+		if (try_steal_cookie(cpu, i))
+			return true;
+	}
+
+	return false;
+}
+
+static void sched_core_balance(struct rq *rq)
+{
+	struct sched_domain *sd;
+	int cpu = cpu_of(rq);
+
+	rcu_read_lock();
+	raw_spin_unlock_irq(rq_lockp(rq));
+	for_each_domain(cpu, sd) {
+		if (!(sd->flags & SD_LOAD_BALANCE))
+			break;
+
+		if (need_resched())
+			break;
+
+		if (steal_cookie_task(cpu, sd))
+			break;
+	}
+	raw_spin_lock_irq(rq_lockp(rq));
+	rcu_read_unlock();
+}
+
+static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+
+void queue_core_balance(struct rq *rq)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	if (!rq->core->core_cookie)
+		return;
+
+	if (!rq->nr_running) /* not forced idle */
+		return;
+
+	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static struct task_struct *
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 46c18e3dab13..b2f08431f0f1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -395,6 +395,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	queue_core_balance(rq);
 }
 
 static struct task_struct *pick_task_idle(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ef9e08e5da6a..552c80b70757 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1057,6 +1057,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+extern void queue_core_balance(struct rq *rq);
+
 void sched_core_add(struct rq *rq, struct task_struct *p);
 void sched_core_remove(struct rq *rq, struct task_struct *p);
 
@@ -1072,6 +1074,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+static inline void queue_core_balance(struct rq *rq)
+{
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.17.1


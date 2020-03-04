Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB09C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A062820658
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="TxyonjsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbgCDRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36196 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388374AbgCDRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id u25so2332742qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4bsjMovkwgawW7FUXP1JiJFQIK3+Hyda7U4iU54bPrA=;
        b=TxyonjsA7uD+j2WSiYAXbIU3VZwHbhl1Gp24lb+qdD7KxFJJ3f1aucxyoWTko19LNR
         wtiPxPj4CYOVvP2oGy/VF95K1JPXL31wMrELHBkUZqpwS2za6ExZ1NJlgXuUnxY8bocY
         Lt9LV/e9UQQG+Ju7gxW+puFxCfiM+coK+XADY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4bsjMovkwgawW7FUXP1JiJFQIK3+Hyda7U4iU54bPrA=;
        b=KipLq4KQOYoqbnPqOx5qDGLT5n7stggsjCQLiL1fDBrf+oUbuOYOeo+tK12CFIQRaY
         nj/l84niCo3c5eLwceWrJiIfIiCyAAvebfZjswTT0eq3uZpQAmlMUMopFyGv0kXHi4lI
         m/rmth7F0DuLt82e+wQfq1j1zK7crbsfOhAat4196nn9dT9AGnxtgPBrwUZEgEHDFoby
         u+jDhJ+WLY/6Y7lnTeWhkBfefC5WOQStEeql9u6AS6wvO/fCf0FemGL1Oz+fEEJGR7hJ
         cLidDhQgD0xeDd3qG+fhevdZCxRRs3jP5jrDlHvW1zw4a9xeSXdsTeFl/QPwwRga91/z
         Y3Lg==
X-Gm-Message-State: ANhLgQ3AZYl9iAEYz+oS4cxpW+jr+aJuovivGwZxNhU5MyRzwIJfHV9g
        4wmgYJccsp5qKQUrb7aZ0bMLUw==
X-Google-Smtp-Source: ADFU+vvmK452KqNG0xGbXuG6iXJWIqtj7ZeHUgAiZrCyxQYZr4vENDfzQKPV7aGRGe+9NSL02Waapg==
X-Received: by 2002:a37:f502:: with SMTP id l2mr3579248qkk.76.1583341221142;
        Wed, 04 Mar 2020 09:00:21 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id x44sm13241963qtc.88.2020.03.04.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:20 -0800 (PST)
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
Subject: [RFC PATCH 13/13] sched: Debug bits...
Date:   Wed,  4 Mar 2020 17:00:03 +0000
Message-Id: <24c0294bb28dc7d2f984ce3aeae5d0a85fd33671.1583332765.git.vpillai@digitalocean.com>
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

Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 11e5a2a494ac..a01df3e0b11e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -110,6 +110,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -315,12 +319,16 @@ static void __sched_core_enable(void)
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
+
+	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
 {
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
+
+	printk("core sched disabled\n");
 }
 
 void sched_core_get(void)
@@ -4460,6 +4468,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			put_prev_task(rq, prev);
 			set_next_task(rq, next);
 		}
+
+		trace_printk("pick pre selected (%u %u %u): %s/%d %lx\n",
+			     rq->core->core_task_seq,
+			     rq->core->core_pick_seq,
+			     rq->core_sched_seq,
+			     next->comm, next->pid,
+			     next->core_cookie);
+
 		return next;
 	}
 
@@ -4540,6 +4556,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
+				trace_printk("unconstrained pick: %s/%d %lx\n",
+					     next->comm, next->pid, next->core_cookie);
+
 				goto done;
 			}
 
@@ -4548,6 +4567,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 			rq_i->core_pick = p;
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -4564,6 +4586,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
@@ -4591,6 +4615,7 @@ next_class:;
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
 	rq->core_sched_seq = rq->core->core_pick_seq;
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -4616,11 +4641,20 @@ next_class:;
 		if (i == cpu)
 			continue;
 
-		if (rq_i->curr != rq_i->core_pick)
+		if (rq_i->curr != rq_i->core_pick) {
+			trace_printk("IPI(%d)\n", i);
 			resched_curr(rq_i);
+		}
 
 		/* Did we break L1TF mitigation requirements? */
-		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+		if (unlikely(!cookie_match(next, rq_i->core_pick))) {
+			trace_printk("[%d]: cookie mismatch. %s/%d/0x%lx/0x%lx\n",
+				     rq_i->cpu, rq_i->core_pick->comm,
+				     rq_i->core_pick->pid,
+				     rq_i->core_pick->core_cookie,
+				     rq_i->core->core_cookie);
+			WARN_ON_ONCE(1);
+		}
 	}
 
 done:
@@ -4659,6 +4693,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
@@ -7287,6 +7325,8 @@ int sched_cpu_starting(unsigned int cpu)
 		WARN_ON_ONCE(rq->core && rq->core != core_rq);
 		rq->core = core_rq;
 	}
+
+	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
 #endif /* CONFIG_SCHED_CORE */
 
 	sched_rq_cpu_starting(cpu);
-- 
2.17.1


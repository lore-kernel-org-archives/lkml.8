Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB633C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD782065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="EsiBj06E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgF3VeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgF3VeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:34:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2768C03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:34:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so9979494pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WcvE7JAuPHDDzdMoQR1rksQHBDPFbnVuufXjLlTocNo=;
        b=EsiBj06EYMuYtamJn8zALmqja7clBzqKtLSqUhInUucvoZQANEOUXEMJKxy7VqxAO0
         NEGRYMv65xZfiXeaAgZXgjjGzFw0BbH0G783qWB6rNNG7Vl4npzmm7ZcPJzc202XTojo
         H2X7p2Km16sBAg7qS8rIruGxN21EQQkKf4B2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WcvE7JAuPHDDzdMoQR1rksQHBDPFbnVuufXjLlTocNo=;
        b=Wh9q2JW1SPtbBXzTEYlBfohNSrtNDlYEHyLr++ivRa9oy7ajl/x2RWTPtFWKvoyQ5D
         VUMVxDJAYZ/S0ZwdJDd2+Ye8VevLN/SyCAOUmotdl0//qjhDVXz1dMm46BfUJp/irOVr
         O8cl9hDAZmm980qicfrli7LtTX9Y7XF51bJ2UwE3vPuimbMX33BgimZyKLHivgknchDs
         D7LqyrAoS6bKnbRyJbke1Cor6FQnOnITwPPpbzrh5NOKNkt+X96yajk5eW1KbscsgGTX
         VKqrtRgX2hatU2FyNThQGIWBdZhbjBct06OCM/1jOk7WH88Bbozn+v4KwmG1hBCUMh1J
         ewiw==
X-Gm-Message-State: AOAM533AuS0I3d/HHX40c9S5XkDRp0JIeJ/6hli+PdO6aUCHPv5f9kr2
        K29nu4NvNEvO6ZQnQ4sV8x0ivQ==
X-Google-Smtp-Source: ABdhPJzFOfQsA0OKZp7LSI5CSbuWyY91iR4qKVhRRqnrHC+Qouv4AgllU4j1liDPjgZBKKARulLNag==
X-Received: by 2002:a62:6142:: with SMTP id v63mr2853216pfb.179.1593552842290;
        Tue, 30 Jun 2020 14:34:02 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id a68sm3181323pje.35.2020.06.30.14.34.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:34:01 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RFC PATCH 16/16] sched: Debug bits...
Date:   Tue, 30 Jun 2020 21:32:37 +0000
Message-Id: <20543884f2f97fe59b5d0900734b424f08145d56.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
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
index 2ec56970d6bb..0362102fa3d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -105,6 +105,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -302,12 +306,16 @@ static void __sched_core_enable(void)
 
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
@@ -4477,6 +4485,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
 
@@ -4551,6 +4567,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
+				trace_printk("unconstrained pick: %s/%d %lx\n",
+					     next->comm, next->pid, next->core_cookie);
+
 				goto done;
 			}
 
@@ -4559,6 +4578,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 			rq_i->core_pick = p;
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -4575,6 +4597,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
@@ -4602,6 +4626,7 @@ next_class:;
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
 	rq->core_sched_seq = rq->core->core_pick_seq;
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -4624,11 +4649,20 @@ next_class:;
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
@@ -4667,6 +4701,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
@@ -7305,6 +7343,8 @@ int sched_cpu_starting(unsigned int cpu)
 		WARN_ON_ONCE(rq->core && rq->core != core_rq);
 		rq->core = core_rq;
 	}
+
+	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
 #endif /* CONFIG_SCHED_CORE */
 
 	sched_rq_cpu_starting(cpu);
-- 
2.17.1


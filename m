Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1C120897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="I2SkpLGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH1Txt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgH1TxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:53:11 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FB7C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:53:11 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so446221qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3cg1ZPjz32Y/tjzNdfUmbeqzQJ8095wGN0FJ7vkXlWw=;
        b=I2SkpLGfDcVX+/Ew6Qj0r5qHhhsLIDJCEFbyioEagBt18EHLvO/vRDHXrH8hAsHVOX
         LsFiEIipfIcL9/DwsrkXJKUW5YeF9NQ051FMK29uudpvgdMf00hOdXM6UZhTt6awxqK9
         tmBXm2sE4+YQzrEYCIe75fnNsaE8YMkHv7LVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3cg1ZPjz32Y/tjzNdfUmbeqzQJ8095wGN0FJ7vkXlWw=;
        b=f5vjTtO4gm8eNHaDagvyMEE0BtPJl4gHwnl8orDPryC9YTf431mu9rC+ESbmUS8QmD
         eLv1xxQv43j/3yrjLrzg/d8gYpAC+QIHcpn0p/jd9Sf1w4J2U6f4mpmfsSIzuTt9dhHr
         4qvv1VF9z3deLNXmWjFqeOQMVXvSuStt7GwrZ1gnn6bugrNCMPWUnk+FfOKg7nr0O4g/
         oupgttxH4eAq/y17ajEjJuESMjxQqFTKmSvO/JtFsRR1CNLd76wjPr9EQ3VtRNhyEQgH
         YpDr/4m9ZcFAudSOp4MU4WTFJ9C0UErOr6BZ98eqXUxg/wb8yIFS/vT/shpH4Uolnk6n
         ed4A==
X-Gm-Message-State: AOAM530N5PIm1OtYXI6co9EQJYlvJHePYbkftJtg+O/AXJVt62E/Q2Dz
        YnJVgs3g0xlNvkib42AMQITujQ==
X-Google-Smtp-Source: ABdhPJzNpS/kGScKeDCR1Nv7C/VQk78BrlqI1cnOsrzudwbRe1GG+7URsj9H3or+JbfzJ2U+lKkMlQ==
X-Received: by 2002:ac8:4889:: with SMTP id i9mr3100895qtq.353.1598644390414;
        Fri, 28 Aug 2020 12:53:10 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:53:09 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 23/23] sched: Debug bits...
Date:   Fri, 28 Aug 2020 15:51:24 -0400
Message-Id: <1dba1ec6f0846402eb80755b5f7b44efb6237e6d.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5f77e575bbac..def25fe5e0d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -123,6 +123,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -320,12 +324,16 @@ static void __sched_core_enable(void)
 
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
@@ -4977,6 +4985,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
 
@@ -5062,6 +5078,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
+				trace_printk("unconstrained pick: %s/%d %lx\n",
+					     next->comm, next->pid, next->core_cookie);
 				goto done;
 			}
 
@@ -5070,6 +5088,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 			rq_i->core_pick = p;
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -5086,6 +5107,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
@@ -5114,6 +5137,7 @@ next_class:;
 
 	/* Something should have been selected for current CPU */
 	WARN_ON_ONCE(!next);
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -5145,12 +5169,20 @@ next_class:;
 			continue;
 
 		if (rq_i->curr != rq_i->core_pick) {
+			trace_printk("IPI(%d)\n", i);
 			WRITE_ONCE(rq_i->core_pick_seq, rq->core->core_task_seq);
 			resched_curr(rq_i);
 		}
 
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
@@ -5189,6 +5221,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
@@ -7900,6 +7936,8 @@ int sched_cpu_starting(unsigned int cpu)
 			rq->core = core_rq;
 		}
 	}
+
+	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
 #endif /* CONFIG_SCHED_CORE */
 
 	sched_rq_cpu_starting(cpu);
-- 
2.17.1


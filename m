Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B658FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9021420897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="d9JUYenw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgH1TzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgH1Twi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ADDC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n129so664733qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jzrDh8F1P7cj1/y8+1Q53tboBr/LZN7b1bXIb97ZFkc=;
        b=d9JUYenwSdG7ij1501kfI889mz+/FGM4ww5MiOn9H4ciJO3E7YVPF6CtqqeqgcM+Wm
         sd0pLrP7UFrKqMO+G6WQeLW5DHeyIp3maLQr4BXYLiLuSunWE+BIH8zvdiowvkrkglf2
         SZiZd2n8jRuVMnzVgxrIgKxAsSMlhMYZrUcrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jzrDh8F1P7cj1/y8+1Q53tboBr/LZN7b1bXIb97ZFkc=;
        b=N9VgxqjSY/b8HzY5NDYrZDeF6dpuB06QDMJtPVsXnr5fseUJkgs2FTb/LdYm/YLqme
         Y9cWmrneBG3JjNqbli05nAsgkALyIZe6jl0/ZV8+0sZyUbBLVi6/DjPq8gps/PYI3SD+
         wlqu1InUKmErKSLdOzatwxWxAqg0Bkppe5MLOloT11Qz+Xyvs7tQ4N9WazfeZl1yUijy
         wFaoOjQaQl3BeByk42PWyRv6PZ+2L4c+j+DDgJXjG+kZ0pAFZYDEXl3ci88BxhBYqzoM
         sXfZvZfdLL0oA5kR1c7E4AVt4/q1q9P80sO/nD/88JbjpTIgrMRGRZwDO1U3ip2QM2uu
         6IUQ==
X-Gm-Message-State: AOAM533UOOmu5YYKDh1eXcfUpOcfM5gkeygrkZBAeVEWFJ43xxbiGKto
        vjRaoBLpLs4C3mgq2Vz1pTraeQ==
X-Google-Smtp-Source: ABdhPJy/ssNRSQuLFGbjjjR+HqY0OyyhHRvc84AVYsJpPMLnuRQwmohEktPJ7FcPxXI1S+cRu9sPfQ==
X-Received: by 2002:a37:d8d:: with SMTP id 135mr740147qkn.59.1598644357227;
        Fri, 28 Aug 2020 12:52:37 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:36 -0700 (PDT)
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
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: [RFC PATCH v7 09/23] sched/fair: Fix forced idle sibling starvation corner case
Date:   Fri, 28 Aug 2020 15:51:10 -0400
Message-Id: <7d50f038cef452c78213b7c513a98b3286476701.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

If there is only one long running local task and the sibling is
forced idle, it  might not get a chance to run until a schedule
event happens on any cpu in the core.

So we check for this condition during a tick to see if a sibling
is starved and then give it a chance to schedule.

Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/fair.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 285002a2f641..409edc736297 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10631,6 +10631,40 @@ static void rq_offline_fair(struct rq *rq)
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_SCHED_CORE
+static inline bool
+__entity_slice_used(struct sched_entity *se)
+{
+	return (se->sum_exec_runtime - se->prev_sum_exec_runtime) >
+		sched_slice(cfs_rq_of(se), se);
+}
+
+/*
+ * If runqueue has only one task which used up its slice and if the sibling
+ * is forced idle, then trigger schedule to give forced idle task a chance.
+ */
+static void resched_forceidle_sibling(struct rq *rq, struct sched_entity *se)
+{
+	int cpu = cpu_of(rq), sibling_cpu;
+
+	if (rq->cfs.nr_running > 1 || !__entity_slice_used(se))
+		return;
+
+	for_each_cpu(sibling_cpu, cpu_smt_mask(cpu)) {
+		struct rq *sibling_rq;
+		if (sibling_cpu == cpu)
+			continue;
+		if (cpu_is_offline(sibling_cpu))
+			continue;
+
+		sibling_rq = cpu_rq(sibling_cpu);
+		if (sibling_rq->core_forceidle) {
+			resched_curr(sibling_rq);
+		}
+	}
+}
+#endif
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -10654,6 +10688,11 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled(rq))
+		resched_forceidle_sibling(rq, &curr->se);
+#endif
 }
 
 /*
-- 
2.17.1


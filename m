Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D445DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBC62072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="gugh5DJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgF3VdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgF3VdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E92C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j4so9017711plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=p3fES35YITsidZ4eGLne/2ofjR3Ab7HGCf2PrO4zrIE=;
        b=gugh5DJ6sIVVBrAwPiy1GUqAB9GtT/TRlyBP1Igs9PIF65ybl/IAgLezi+690CMUg7
         nboZgWjgClg73e3TqH0YqOeqKB8F32t3oj6tlGF6JRID4e+ouRS5QkZC2wSpatqVT86Y
         uKxoXFOLbgvMq6nxW9C8N6ZaUvZKI7TvHUBpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=p3fES35YITsidZ4eGLne/2ofjR3Ab7HGCf2PrO4zrIE=;
        b=CDBUzfVCVr4WAsn/FTy1kUmLLy11QWnyckzW0aEH7ecuj7mmql9CMoIgk0yylrOQaA
         XVAaOqkN9qTFrLu6h9VMPswTH9GMA6XHo3fOgLzLei9zrzzdCIgBJkrRsvmnzdQ1eMlK
         9ZFDQE2Yl/ffHJFXESV6jKYQux0K4kNB/gJ8KKM+M4YxVMiR6dGRahYma2C1/B7NJhtl
         R3FTY9Ur0tO1Tn0Y9nykXpIG7DgKInjOaqPBMsLfxPR2tR9P8lQ+uaF16IU9bplPijmM
         jNwsoIrfZgWqgyD5IB343wKoZWtXWRgtatyfO+n1AvBCZbT2mY7LK9E3PKUKG22v1rWn
         E8jQ==
X-Gm-Message-State: AOAM532VEUBDAuaA0kc7sj7W2HLkj/wJREba9yL88EETP8RnZgQhq94o
        Oi8qbbugl4H3PwVNjJVnwFzARw==
X-Google-Smtp-Source: ABdhPJz4FyDNGiv3OQLIB/KtU/jnyRzOszvtSrYbjsiyRgAVDuZysxEX51x/OYeGYXJ8DX5x2BzRFw==
X-Received: by 2002:a17:90a:17ab:: with SMTP id q40mr22174737pja.152.1593552800477;
        Tue, 30 Jun 2020 14:33:20 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id e16sm3594311pff.180.2020.06.30.14.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:20 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        subhra.mazumdar@oracle.com, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RFC PATCH 07/16] sched/fair: Fix forced idle sibling starvation corner case
Date:   Tue, 30 Jun 2020 21:32:28 +0000
Message-Id: <d8ff57c098623e701cc3a8b37f667542f9b8d218.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: vpillai <vpillai@digitalocean.com>

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
index ae17507533a0..49fb93296e35 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10613,6 +10613,40 @@ static void rq_offline_fair(struct rq *rq)
 
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
@@ -10636,6 +10670,11 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
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


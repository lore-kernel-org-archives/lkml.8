Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58587C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D45206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CLaLDaVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgHOV4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgHOVwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:14 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8819C06137A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:33 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 2so10162586qkf.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbniwNR3aKZ0L4CoWzsSoDjZIVxcefGHSxeEpUJZ0hc=;
        b=CLaLDaVSSaOthzY7gj1/EAO/pRnF2RWI6hfa4ynUe7KqmWc+DGlX2ACZOU1gh16HxH
         aodTD9ByW0xt4FgXGtwGU/SD7Kn16uBl6/ThKLo2j/c6IDaMkhBwWj7k6ckY62nKCIbL
         KRdpyOXY4T3U2n9LwDx7jNU0zXN1Zn0yFS5oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbniwNR3aKZ0L4CoWzsSoDjZIVxcefGHSxeEpUJZ0hc=;
        b=eatPwjN8X6lfIDZr9f9SqPQ377W6cyTUhLEpwjh++UuchvI9+nT0O725IYNaIXzrV/
         vVCnfOZpMfZX9DB/f3yLnpMe1kY8bkwzvDQNp51d8RvTbmi1UENefIULDYbfb4isFWro
         yPwM1CDhgj77Ckvrjv5SDhZ+1mywh8CG+uAaeC9Xj5ey6MLN2Nn929jv1LqJmgQrtQcL
         srzBypTSu7lDF5ndaLpVzlTvAC3VmdrUlw8NWQvTa8oNuVlkdJJTMG4uyPK63bHnkJPX
         HeenCisWIu0Chzx2yXJY0qVFztWhK40OYeYgnz4dSDH0SbM9kCAG0BdGTLxYnIiYngOI
         LN3g==
X-Gm-Message-State: AOAM532XKhFQ2ORbjmeSBxvVGMrNbRJ8fyM3fDFv1z1FJclVMV5i094d
        JhByhSpFcaej1J40XPWGK7ymmdxPRu6kjw==
X-Google-Smtp-Source: ABdhPJy8ThSw7e+zQhabD7gscM+Z8WPky9F7ZtlinM8kmEMwHAZW3RtkxPL4s0Cn3FOUVzK0AQ9s2w==
X-Received: by 2002:a37:9c7:: with SMTP id 190mr4379796qkj.303.1597461572672;
        Fri, 14 Aug 2020 20:19:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:32 -0700 (PDT)
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
Subject: [PATCH RFC 09/12] sched/coresched: Use for_each_cpu(_wrap)_or for pick_next_task
Date:   Fri, 14 Aug 2020 23:19:05 -0400
Message-Id: <20200815031908.1015049-10-joel@joelfernandes.org>
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

During a CPU hotplug event, schedule would be called with the hotplugged CPU
not in the cpumask. So use for_each_cpu(_wrap)_or to include the current cpu in
the task pick loop.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ff13254ed317..3e9df8221c62 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4663,7 +4663,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
-	for_each_cpu(i, smt_mask) {
+	for_each_cpu_or(i, smt_mask, cpumask_of(cpu)) {
 		struct rq *rq_i = cpu_rq(i);
 
 		trace_printk("CPU %d is in smt_mask, resetting\n", i);
@@ -4685,7 +4685,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 */
 	for_each_class(class) {
 again:
-		for_each_cpu_wrap(i, smt_mask, cpu) {
+		for_each_cpu_wrap_or(i, smt_mask, cpumask_of(cpu), cpu) {
 			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
 
@@ -4774,6 +4774,9 @@ next_class:;
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
 	rq->core_sched_seq = rq->core->core_pick_seq;
+
+	/* Something should have been selected for current CPU */
+	WARN_ON_ONCE(!next);
 	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
@@ -4784,7 +4787,7 @@ next_class:;
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_cpu_or(i, smt_mask, cpumask_of(cpu)) {
 		struct rq *rq_i = cpu_rq(i);
 
 		WARN_ON_ONCE(!rq_i->core_pick);
-- 
2.28.0.220.ged08abb693-goog


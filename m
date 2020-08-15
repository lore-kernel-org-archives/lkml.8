Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A777DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E16B204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="StWlDLaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgHOVyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgHOVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:36 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171EFC06137D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 77so10195377qkm.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwsOWE3cvymHDK4XxTdA3wF4GOr+2WPCQ6wnKRbw/jI=;
        b=StWlDLaq0MYdU1CWVuIg/J4GYVc+68Ndih7GA3RYvlHvpUIZIf7YgKHremE+6JTJUO
         xexuEqSkh+h37IgJdNAHSFAgEgU12rarmHYgKhMF2OPIcgpQ0OBxq9Tb+z80eovyzwwB
         QRRN5uoJO8eH3cecRwWPlUIGRwBTM9VQqnDQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwsOWE3cvymHDK4XxTdA3wF4GOr+2WPCQ6wnKRbw/jI=;
        b=dWLd9od2/rQ6WpiCzTKetr+gtHypOM2rCNeLJLs/dIZbJv6HxKydsasu51LccbdYpc
         Sed/YZIvqE5Ceu10ZChbo5rT+dtiCX+Fud7CCKd5NLt1Frq8daXWTJzXhUeqO9DeQJkm
         cEliPBiqigIO2pFISgrL3UinnzVGDdSDZ2lrYcskxl5pmV7UPp/4+iNpB+e7VYV9zsGg
         4gOmcn3oyLjMy0ROk5zhBGyuDDFN9NjbgAirCKhFnIefOEazXZgVS8GL1SXegNkkAqk1
         AZV8BMr7A6eGfBVszngwOtvvSXEAo4tKZ0r7TY57vQkLY/KMtxnAqtTyO99eVNtPR6IR
         FDtQ==
X-Gm-Message-State: AOAM5303h16MSR6lnG1WX9HOzhEP2yd+38crig79kNPKk6aZgvsZHi3g
        EWuyQ/wQ5ugfBcctscsIgN/vvjMFAiXoEw==
X-Google-Smtp-Source: ABdhPJx44+TLrchsQPKRwFKQTIlzobQZ2Jz2LhMGXzrQarb2Y05Zm7y8T8+orKvYxQaBtCnZCupZhw==
X-Received: by 2002:a05:620a:1009:: with SMTP id z9mr4628395qkj.107.1597461576169;
        Fri, 14 Aug 2020 20:19:36 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:35 -0700 (PDT)
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
Subject: [PATCH RFC 12/12] sched/coresched: rq->core should be set only if not previously set
Date:   Fri, 14 Aug 2020 23:19:08 -0400
Message-Id: <20200815031908.1015049-13-joel@joelfernandes.org>
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

During hotplug events, smt_mask would not contain all the CPUs in a core and
this can cause reassigning of rq->core, which breaks the core-wide counters
that are needed for tracking kernel-mode entry/exits.

This patch therefore makes sure that rq->core does not change once it is set.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5da5b2317b21..464493f3a759 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7519,21 +7519,25 @@ int sched_cpu_starting(unsigned int cpu)
 	struct rq *rq, *core_rq = NULL;
 	int i;
 
-	for_each_cpu(i, smt_mask) {
-		rq = cpu_rq(i);
-		if (rq->core && rq->core == rq)
-			core_rq = rq;
-		init_irq_work(&rq->core_irq_work, sched_core_irq_work);
-	}
+	core_rq = cpu_rq(cpu)->core;
+
+	if (!core_rq) {
+		for_each_cpu(i, smt_mask) {
+			rq = cpu_rq(i);
+			if (rq->core && rq->core == rq)
+				core_rq = rq;
+			init_irq_work(&rq->core_irq_work, sched_core_irq_work);
+		}
 
-	if (!core_rq)
-		core_rq = cpu_rq(cpu);
+		if (!core_rq)
+			core_rq = cpu_rq(cpu);
 
-	for_each_cpu(i, smt_mask) {
-		rq = cpu_rq(i);
+		for_each_cpu(i, smt_mask) {
+			rq = cpu_rq(i);
 
-		WARN_ON_ONCE(rq->core && rq->core != core_rq);
-		rq->core = core_rq;
+			WARN_ON_ONCE(rq->core && rq->core != core_rq);
+			rq->core = core_rq;
+		}
 	}
 
 	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
-- 
2.28.0.220.ged08abb693-goog


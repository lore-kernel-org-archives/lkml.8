Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD9DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA042087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="feoBSY+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgIAFKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:10:16 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81597C061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:10:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di5so3427240qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HIjzshVH9ch0OyyaPM6796FwEH4a4FkXLBYplM11gSA=;
        b=feoBSY+UEOrQb6ruKfivWQ8Sa8Uv4pwZaWmm22Bx1QPFRppxVWc9k/7bOd1CnFI0ja
         1Nfh2nbyJgLbakkhOcLeisNnmdpGi+3TLuoGhH7kDeaJpBq0SUgFHR/fZVxWjhD6l+p2
         Mawq/tYX2eknjsjDhz26LViTBF2hJq0OAlkBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HIjzshVH9ch0OyyaPM6796FwEH4a4FkXLBYplM11gSA=;
        b=I+BdY7ye/zfHWH6f9vCL4x1eLuC/7xBfGQ3tSfBAGv1F0X3zuaEL+d8LffuAFwFZ7M
         OFBHFMEmtfsTY9MqEiHNorvAwy/GYlqvMbS2tOxLz77gZFpC4D63ZsgCLQ0Tls9Wv5PH
         4oS6jX8ODNU+3ctJS3mmu/EtyZwmLh2Fl7CYIqSXSlwwSZgIDOhAgDIuI+RYi11IXKUW
         YID+QSVoNs+tBJzF4ZenEt8gpnkaAglEW9xAFEsXgo/9xH8Gb2Nb8rOD/iqVgNgakDzb
         JF6ctV2K7R9sE+WZoJtJawUTLDzUNfB5WWgFmiRPeLW41FcngJjYuZNISmOCg3qhhWIq
         52bA==
X-Gm-Message-State: AOAM530dMwVV7iJAiUEv6f5I2bnKf6G0whW7no7FzOIORukluNDITDr+
        qo70LUGElftyfI+blbF/yV7NXw==
X-Google-Smtp-Source: ABdhPJz3Ld2cwXBwg7KCJ5dKoKUhxo98vFuCyUbL+5yG4hzMRwdkfYScwDgwIjpXOWXppSj9vdwusA==
X-Received: by 2002:ad4:4c89:: with SMTP id bs9mr228526qvb.210.1598937015377;
        Mon, 31 Aug 2020 22:10:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id o72sm248439qka.113.2020.08.31.22.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 22:10:14 -0700 (PDT)
Date:   Tue, 1 Sep 2020 01:10:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     peterz@infradead.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200901051014.GA3993517@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
 <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 09:47:19AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 06:02:25PM -0400, Vineeth Pillai wrote:
> > On 8/28/20 4:51 PM, Peter Zijlstra wrote:
> 
> > > So where do things go side-ways?
> 
> > During hotplug stress test, we have noticed that while a sibling is in
> > pick_next_task, another sibling can go offline or come online. What
> > we have observed is smt_mask get updated underneath us even if
> > we hold the lock. From reading the code, looks like we don't hold the
> > rq lock when the mask is updated. This extra logic was to take care of that.
> 
> Sure, the mask is updated async, but _where_ is the actual problem with
> that?

Hi Peter,

I tried again and came up with the simple patch below which handles all
issues and does not cause any more crashes. I added elaborate commit messages
and code comments enlisting all the issues. Hope it makes sense now. IMHO any
other solutions seems unclear or overhead. The simple solution below Just
Works (Tm) and does not add overhead.

Let me know what you think, thanks.

---8<-----------------------

From 546c5b48f372111589117f51fd79ac1e9493c7e7 Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Tue, 1 Sep 2020 00:56:36 -0400
Subject: [PATCH] sched/core: Hotplug fixes to pick_next_task()

The follow 3 cases need to be handled to avoid crashes in pick_next_task() when
CPUs in a core are going offline or coming online.

1. The stopper task is switching into idle when it is brought down by CPU
hotplug. It is not in the cpu_smt_mask so nothing need be selected for it.
Further, the current code ends up not selecting anything for it, not even idle.
This ends up causing crashes in set_next_task(). Just do the __pick_next_task()
selection which will select the idle task. No need to do core-wide selection as
other siblings will handle it for themselves when they call schedule.

2. The rq->core_pick for a sibling in a core can be NULL if no selection was
made for it because it was either offline or went offline during a sibling's
core-wide selection. In this case, do a core-wide selection. In this case, we
have to completely ignore the checks:
        if (rq->core->core_pick_seq == rq->core->core_task_seq &&
	    rq->core->core_pick_seq != rq->core_sched_seq)

Otherwise, it would again end up crashing like #1.

3. The 'Rescheduling siblings' loop of pick_next_task() is quite fragile. It
calls various functions on rq->core_pick which could very well be NULL because:
An online sibling might have gone offline before a task could be picked for it,
or it might be offline but later happen to come online, but its too late and
nothing was picked for it. Just ignore the siblings for which nothing could be
picked. This avoids any crashes that may occur in this loop that assume
rq->core_pick is not NULL.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 717122a3dca1..4966e9f14f39 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4610,13 +4610,24 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
 
+	cpu = cpu_of(rq);
+
+	/* Stopper task is switching into idle, no need core-wide selection. */
+	if (cpu_is_offline(cpu))
+		return __pick_next_task(rq, prev, rf);
+
 	/*
 	 * If there were no {en,de}queues since we picked (IOW, the task
 	 * pointers are all still valid), and we haven't scheduled the last
 	 * pick yet, do so now.
+	 *
+	 * rq->core_pick can be NULL if no selection was made for a CPU because
+	 * it was either offline or went offline during a sibling's core-wide
+	 * selection. In this case, do a core-wide selection.
 	 */
 	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
-	    rq->core->core_pick_seq != rq->core_sched_seq) {
+	    rq->core->core_pick_seq != rq->core_sched_seq &&
+	    !rq->core_pick) {
 		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
 
 		next = rq->core_pick;
@@ -4629,7 +4640,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	put_prev_task_balance(rq, prev, rf);
 
-	cpu = cpu_of(rq);
 	smt_mask = cpu_smt_mask(cpu);
 
 	/*
@@ -4761,7 +4771,15 @@ next_class:;
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
-		WARN_ON_ONCE(!rq_i->core_pick);
+		/*
+		 * An online sibling might have gone offline before a task
+		 * could be picked for it, or it might be offline but later
+		 * happen to come online, but its too late and nothing was
+		 * picked for it.  That's Ok - it will pick tasks for itself,
+		 * so ignore it.
+		 */
+		if (!rq_i->core_pick)
+			continue;
 
 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
 			rq_i->core_forceidle = true;
-- 
2.28.0.402.g5ffc5be6b7-goog


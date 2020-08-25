Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA879C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37A820738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ifb0ZO37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHYSq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:46:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30010 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbgHYSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598381183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yv62KVZ2y8sIUWkWiUl26dzjgg8e6IxrYk2AS4k3VmM=;
        b=Ifb0ZO37eTQdTHn2/5svcE8/YP+QBb0FohTPXX29T80gjxOkyinMk9SaAvoN4oq/LyrC/2
        iNrredK8SzEZrLMO7eKIVfrh9rt3yo9B/tDFiVBKSpbBt5EJFvIuWEdgRNCNg5fqjqBaNg
        SeBNjZ2QdXI5YvrXcm7jSEtzVuIKAHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-RdUUoSWtNj-ovDDyvBqtLg-1; Tue, 25 Aug 2020 14:46:21 -0400
X-MC-Unique: RdUUoSWtNj-ovDDyvBqtLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7B3E100854F;
        Tue, 25 Aug 2020 18:46:20 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-10.gru2.redhat.com [10.97.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FBD25C1C2;
        Tue, 25 Aug 2020 18:46:20 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 36099409D608; Tue, 25 Aug 2020 15:44:50 -0300 (-03)
Message-ID: <20200825184414.442457749@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 25 Aug 2020 15:41:48 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/2] nohz: try to avoid IPI when configuring per-CPU posix timer
References: <20200825184147.948670309@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
performed (to re-read the dependencies and possibly not re-enter
nohz_full on a given CPU).

A common case is for applications that run on nohz_full= CPUs 
to not use POSIX timers (eg DPDK). This patch skips the IPI 
in case the task allowed mask does not intersect with nohz_full= CPU mask,
when going through tick_nohz_dep_set_signal.

This reduces interruptions to nohz_full= CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/tick.h           |   11 +++++++----
 kernel/time/posix-cpu-timers.c |    4 ++--
 kernel/time/tick-sched.c       |   27 +++++++++++++++++++++++++--
 3 files changed, 34 insertions(+), 8 deletions(-)

Index: linux-2.6/include/linux/tick.h
===================================================================
--- linux-2.6.orig/include/linux/tick.h
+++ linux-2.6/include/linux/tick.h
@@ -207,7 +207,8 @@ extern void tick_nohz_dep_set_task(struc
 				   enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
-extern void tick_nohz_dep_set_signal(struct signal_struct *signal,
+extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
+				     struct signal_struct *signal,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
@@ -252,11 +253,12 @@ static inline void tick_dep_clear_task(s
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_clear_task(tsk, bit);
 }
-static inline void tick_dep_set_signal(struct signal_struct *signal,
+static inline void tick_dep_set_signal(struct task_struct *tsk,
+				       struct signal_struct *signal,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
-		tick_nohz_dep_set_signal(signal, bit);
+		tick_nohz_dep_set_signal(tsk, signal, bit);
 }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit)
@@ -284,7 +286,8 @@ static inline void tick_dep_set_task(str
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
-static inline void tick_dep_set_signal(struct signal_struct *signal,
+static inline void tick_dep_set_signal(struct task_struct *tsk,
+				       struct signal_struct *signal,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit) { }
Index: linux-2.6/kernel/time/posix-cpu-timers.c
===================================================================
--- linux-2.6.orig/kernel/time/posix-cpu-timers.c
+++ linux-2.6/kernel/time/posix-cpu-timers.c
@@ -523,7 +523,7 @@ static void arm_timer(struct k_itimer *t
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
 	else
-		tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
+		tick_dep_set_signal(p, p->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 /*
@@ -1358,7 +1358,7 @@ void set_process_cpu_timer(struct task_s
 	if (*newval < *nextevt)
 		*nextevt = *newval;
 
-	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
+	tick_dep_set_signal(tsk, tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -302,6 +302,27 @@ static void tick_nohz_dep_set_all(atomic
 }
 
 /*
+ * Set bit on nohz full dependency, kicking all cpus
+ * only if task can run on nohz full CPUs.
+ */
+static void tick_nohz_dep_set_all_cond(struct task_struct *tsk,
+				       atomic_t *dep,
+				       enum tick_dep_bits bit)
+{
+	int prev;
+	unsigned long flags;
+
+	prev = atomic_fetch_or(BIT(bit), dep);
+	if (prev)
+		return;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (cpumask_intersects(&tsk->cpus_mask, tick_nohz_full_mask))
+		tick_nohz_full_kick_all();
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+}
+
+/*
  * Set a global tick dependency. Used by perf events that rely on freq and
  * by unstable clock.
  */
@@ -382,9 +403,11 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_ta
  * Set a per-taskgroup tick dependency. Posix CPU timers need this in order to elapse
  * per process timers.
  */
-void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits bit)
+void tick_nohz_dep_set_signal(struct task_struct *tsk,
+			      struct signal_struct *sig,
+			      enum tick_dep_bits bit)
 {
-	tick_nohz_dep_set_all(&sig->tick_dep_mask, bit);
+	tick_nohz_dep_set_all_cond(tsk, &sig->tick_dep_mask, bit);
 }
 
 void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bit)



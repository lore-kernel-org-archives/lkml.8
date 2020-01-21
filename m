Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B77AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F9824125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJIQ5Cnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgAUKfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:35:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=et4RlvUeOkCtUnhuSYbRl6HA7YBgNI1b2eb9AQ7Bu7g=; b=ZJIQ5CnzMhpg81at8gIF7EAM+e
        NpAk6n6JqQyaj/XvmM2/4Hoah19eqvQq6/GVYSSug9wO3tALXiGX89jU3yguB2hWaSwsbCIku7OFn
        fMk70GIJZXu7xwdklj5f4qG/oZaqmdXs0l4lFJS+3bjOS18gDCYnEhbRS9DVPwaK8oeI1xSTlpSF5
        YsCWPdRgO6OJYFDR+TxQaWFQUFIn42/a5sUSlUczfdxrGIl34/fifHMfvBpMOr2I1s2rLIStAFXO4
        FFYX8CytLgPX97DkSPyAqEYi+J0tkcWND8BPq1QFb16bIW70Mf2Vg1Suh6kheYybjwWmBL+6POJY/
        bfW18+lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itqsI-00019I-5k; Tue, 21 Jan 2020 10:35:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7A07300B8D;
        Tue, 21 Jan 2020 11:33:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA6A020146B6C; Tue, 21 Jan 2020 11:35:06 +0100 (CET)
Date:   Tue, 21 Jan 2020 11:35:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Message-ID: <20200121103506.GH14914@hirez.programming.kicks-ass.net>
References: <20200120101652.GM14879@hirez.programming.kicks-ass.net>
 <F96BF662-BB11-4AFB-BF05-CB1720441A92@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F96BF662-BB11-4AFB-BF05-CB1720441A92@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:35:09PM -0500, Qian Cai wrote:
> > On Jan 20, 2020, at 5:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > Bah.. that's horrible. Surely we can find a better place to do this in
> > the whole hotplug machinery.
> > 
> > Perhaps you can have takedown_cpu() do the mmdrop()?
> 
> The problem is that no all arch_cpu_idle_dead() will call
> idle_task_exit(). For example, alpha and parisc are not, so it needs

How is that not broken? If the idle thread runs on an active_mm, we need
to drop that reference. This needs fixing regardless.

> to deal with some kind of ifdef dance in takedown_cpu() to
> conditionally call mmdrop() which sounds even more horrible?
> 
> If you really prefer it anyway, maybe something like touching every arch’s __cpu_die() to also call mmdrop() depends on arches?
> 
> BTW, how to obtain the other CPU’s current task mm? Is that cpu_rq(cpu)->curr->active_mm?

Something like this; except you'll need to go audit archs to make sure
they all call idle_task_exit() and/or put in comments on why they don't
have to (perhaps their bringup switches them to &init_mm unconditionally
and the switch_mm() is not required).

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af713fb..2b4d8a69e8d9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -564,6 +564,23 @@ static int bringup_cpu(unsigned int cpu)
 	return bringup_wait_for_ap(cpu);
 }
 
+static int finish_cpu(unsigned int cpu)
+{
+	struct task_struct *idle = idle_thread_get(cpu);
+	struct mm_struct *mm = idle->active_mm;
+
+	/*
+	 * idle_task_exit() will have switched to &init_mm, now
+	 * clean up any remaining active_mm state.
+	 */
+
+	if (mm == &init_mm)
+		return;
+
+	idle->active_mm = &init_mm;
+	mmdrop(mm);
+}
+
 /*
  * Hotplug state machine related functions
  */
@@ -1434,7 +1451,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_BRINGUP_CPU] = {
 		.name			= "cpu:bringup",
 		.startup.single		= bringup_cpu,
-		.teardown.single	= NULL,
+		.teardown.single	= finish_cpu,
 		.cant_stop		= true,
 	},
 	/* Final state before CPU kills itself */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc007604..8f049fb77a3d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6188,13 +6188,14 @@ void idle_task_exit(void)
 	struct mm_struct *mm = current->active_mm;
 
 	BUG_ON(cpu_online(smp_processor_id()));
+	BUG_ON(current != this_rq()->idle);
 
 	if (mm != &init_mm) {
 		switch_mm(mm, &init_mm, current);
-		current->active_mm = &init_mm;
 		finish_arch_post_lock_switch();
 	}
-	mmdrop(mm);
+
+	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
 /*

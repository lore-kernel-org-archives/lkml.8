Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CCEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B499020723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kvLZF1xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGCKkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGCKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:40:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0FDC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fmVZy/L7vQSjkLgXMS2UoYcdHGF2DttwAYv3wCpQ/6I=; b=kvLZF1xJUMQ2Kl3DH0zhSAOgAh
        upfnmRJi7AVzkPipzkFQLK+6prEEmNZi8MB7MEDm0C3dPJaKJdricuEPl7mC/Ehnuj16AzBQ/vPEf
        rMSTJM+bSwGBcfZrcXj1bAvKAHx+e6jY2YOn4BSNPMx1VX/fE5y3PS+GKQGc05/caT4FpY0F3tS/e
        zfFOp+40+jPzsS0Hlo9k1BlBy94jW+AhHi2Eb+ZT2LUs1gJORPxGNZ8WCxLwu383hG7wX2AISBF6U
        pu7e6Iy/xGVDgHLz/MM97dXnPzB/7m1aB0K+Cbp8Tqe/xgCuAKn9Il5Vbg965fSyPhLc0ovX3kpyB
        KlwAcMew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrJ7U-0006QM-Nt; Fri, 03 Jul 2020 10:40:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA0C030411F;
        Fri,  3 Jul 2020 12:40:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA98A20B0AB14; Fri,  3 Jul 2020 12:40:33 +0200 (CEST)
Date:   Fri, 3 Jul 2020 12:40:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200703104033.GK117543@hirez.programming.kicks-ass.net>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703090226.GV4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:02:26AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 02, 2020 at 10:36:27PM +0100, Mel Gorman wrote:
> 
> > > commit c6e7bd7afaeb3af55ffac122828035f1c01d1d7b (refs/bisect/bad)
> > > Author: Peter Zijlstra <peterz@infradead.org>
> 
> > Peter, I'm not supremely confident about this but could it be because
> > "p->sched_contributes_to_load = !!task_contributes_to_load(p)" potentially
> > happens while a task is still being dequeued? In the final stages of a
> > task switch we have
> > 
> >         prev_state = prev->state;
> >         vtime_task_switch(prev);
> >         perf_event_task_sched_in(prev, current);
> >         finish_task(prev);
> > 
> > finish_task is when p->on_cpu is cleared after the state is updated.
> > With the patch, we potentially update sched_contributes_to_load while
> > p->state is transient so if the check below is true and ttwu_queue_wakelist
> > is used then sched_contributes_to_load was based on a transient value
> > and potentially wrong.
> 
> I'm not seeing it. Once a task hits schedule(), p->state doesn't change,
> except through wakeup.
> 
> And while dequeue depends on p->state, it doesn't change it.
> 
> At this point in ttwu() we know p->on_rq == 0, which implies dequeue has
> started, which means we've (at least) stopped executing the task -- we
> started or finished schedule().
> 
> Let me stare at this more...

So ARM/Power/etc.. can speculate the load such that the
task_contributes_to_load() value is from before ->on_rq.

The compiler might similar re-order things -- although I've not found it
doing so with the few builds I looked at.

So I think at the very least we should do something like this. But i've
no idea how to reproduce this problem.

Mel's patch placed it too far down, as the WF_ON_CPU path also relies on
this, and by not resetting p->sched_contributes_to_load it would skew
accounting even worse.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fcd56f04b706..cba8a56d0f7f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2799,9 +2799,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	}
 
 #ifdef CONFIG_SMP
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
-
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 	 * possible to, falsely, observe p->on_cpu == 0.
@@ -2823,6 +2820,9 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	smp_rmb();
 
+	p->sched_contributes_to_load = !!task_contributes_to_load(p);
+	p->state = TASK_WAKING;
+
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
 	 * this task as prev, considering queueing p on the remote CPUs wake_list

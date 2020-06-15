Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9932C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821822067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXykYu6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgFOQlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbgFOQlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:41:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7LuY4oP/Ae5Vicv3QaUp0hzRom8eAXJcz6uKt/S03vU=; b=GXykYu6ggGOh3TZnYvrW2zjpMx
        1swQBHT81LnTympTTOMoIEfSxYE3MhVzQ+ahw3BTqpZiGU1X/oLPEu0U40rVsyXzyJ8n9SkgP/r4M
        6HPysHro5LML2h/5+TIjxeMyznjUx1T5O4RbIDAK5Qj64MMptWjtTKxayVjlqYds+IvcRm7lxcYiK
        dL5vR3NgQenKk0/LZ14IWwpDzQq1SS/2jkMExdnw39H56pSziyBupAkBlwYAut6ZYUnMxfcqgigwH
        TPmV3ODMQgheZvfummSHBRFm65K/QiRGdZbw8sWywEjhSVJ56y/XqvheyPZK0emoaX7WBcdfhLE0d
        kS+YLQxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jksAE-0004Ss-EV; Mon, 15 Jun 2020 16:40:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9A613003E1;
        Mon, 15 Jun 2020 18:40:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82D96203B8160; Mon, 15 Jun 2020 18:40:48 +0200 (CEST)
Date:   Mon, 15 Jun 2020 18:40:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200615164048.GC2531@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615162330.GF2723@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 09:23:30AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 15, 2020 at 02:56:54PM +0200, Peter Zijlstra wrote:
> > Hi,
> > 
> > So Paul reported rcutorture hitting a NULL dereference, and patch #1 fixes it.
> > 
> > Now, patch #1 is obviously correct, but I can't explain how exactly it leads to
> > the observed NULL pointer dereference. The NULL pointer deref happens in
> > find_matching_se()'s last while() loop when is_same_group() fails even though
> > both parents are NULL.
> 
> My bisection of yet another bug sometimes hits the scheduler NULL pointer
> dereference on older commits.  I will try out patch #2.

Thanks! I've got 16*TREE03 running since this morning, so far so nothing :/
(FWIW that's 16/9 times overcommit, idle time fluctuates around 10%).

> Whether this is reassuring or depressing, I have no idea.  :-/

Worrysome at least, I don't trust stuff I can't explain.

> > The only explanation I have for that is that we just did an activate_task()
> > while: 'task_cpu(p) != cpu_of(rq)', because then 'p->se.cfs_rq' doesn't match.
> > However, I can't see how the lack of #1 would lead to that. Never-the-less,
> > patch #2 adds assertions to warn us of this case.
> > 
> > Patch #3 is a trivial rename that ought to eradicate some confusion.
> > 
> > The last 3 patches is what I ended up with for cleaning up the whole
> > smp_call_function/irq_work/ttwu thing more.
> 
> Would it be possible to allow a target CPU # on those instances of
> __call_single_data?  This is extremely helpful for debugging lost
> smp_call_function*() calls.

target or source ? Either would be possible, perhaps even both. We have
a spare u32 in __call_single_node.

Something like the below on top of 1-4. If we want to keep this, we
should probably stick it under some CONFIG_DBUG thing or other.

--- a/include/linux/smp_types.h
+++ b/include/linux/smp_types.h
@@ -61,6 +61,7 @@ struct __call_single_node {
 		unsigned int	u_flags;
 		atomic_t	a_flags;
 	};
+	u16 src, dst;
 };
 
 #endif /* __LINUX_SMP_TYPES_H */
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -135,8 +135,14 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(cal
 
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
+	struct __call_single_node *n =
+		container_of(node, struct __call_single_node, llist);
+
 	WARN_ON_ONCE(cpu == smp_processor_id());
 
+	n->src = smp_processor_id();
+	n->dst = cpu;
+
 	/*
 	 * The list addition should be visible before sending the IPI
 	 * handler locks the list to pull the entry off it because of


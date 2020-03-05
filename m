Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE28FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB466208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCEOBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgCEOBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:01:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16457206D5;
        Thu,  5 Mar 2020 14:01:38 +0000 (UTC)
Date:   Thu, 5 Mar 2020 09:01:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Pinning down a blocked task to extract diagnostics
Message-ID: <20200305090136.09f4bebf@gandalf.local.home>
In-Reply-To: <20200305081337.GA2619@hirez.programming.kicks-ass.net>
References: <20200305005049.GA21120@paulmck-ThinkPad-P72>
        <20200305080755.GS2596@hirez.programming.kicks-ass.net>
        <20200305081337.GA2619@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 09:13:37 +0100
Peter Zijlstra <peterz@infradead.org> wrote:


> > Close, the thing pi_lock actually guards is the t->state transition *to*
> > TASK_WAKING/TASK_RUNNING, so something like this:  
> 
> Almost, we must indeed also check ->on_rq, otherwise it might change the
> state back itself.
> 
> > 
> > 	raw_spin_lock_irq(&t->pi_lock);
> > 	switch (t->state) {
> > 	case TASK_RUNNING:
> > 	case TASK_WAKING:
> > 		/* ignore */
> > 		break;
> > 
> > 	default:  

Don't we need a smp_rmb() here, otherwise we could have the same issue as
described in the comment in try_to_wake_up()?

-- Steve


> 		if (t->on_rq)
> 			break;
> 
> > 		/* Extract consistent diagnostic information. */
> > 		break;
> > 	}
> > 	raw_spin_unlock_irq(&t->pi_lock);
> > 
> > ought to work. But if you're going to do this, please add a reference to
> > that code in a comment on top of try_to_wake_up(), such that we can
> > later find all the code that relies on this.  


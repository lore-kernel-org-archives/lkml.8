Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D65BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1482073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgCEO2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:28:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgCEO2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:28:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0173420732;
        Thu,  5 Mar 2020 14:28:46 +0000 (UTC)
Date:   Thu, 5 Mar 2020 09:28:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Pinning down a blocked task to extract diagnostics
Message-ID: <20200305092845.4296c35e@gandalf.local.home>
In-Reply-To: <20200305142245.GB2935@paulmck-ThinkPad-P72>
References: <20200305005049.GA21120@paulmck-ThinkPad-P72>
        <20200305080755.GS2596@hirez.programming.kicks-ass.net>
        <20200305081337.GA2619@hirez.programming.kicks-ass.net>
        <20200305142245.GB2935@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 06:22:45 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, Mar 05, 2020 at 09:13:37AM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 05, 2020 at 09:07:55AM +0100, Peter Zijlstra wrote:  
> > > On Wed, Mar 04, 2020 at 04:50:49PM -0800, Paul E. McKenney wrote:  
> > > > Hello!
> > > > 
> > > > Suppose that I need to extract diagnostics information from a blocked
> > > > task, but that I absolutely cannot tolerate this task awakening in the
> > > > midst of this extraction process.  Is the following code the right way
> > > > to make this work given a task "t"?
> > > > 
> > > > 	raw_spin_lock_irq(&t->pi_lock);
> > > > 	if (t->on_rq) {
> > > > 		/* Task no longer blocked, so ignore it. */
> > > > 	} else {
> > > > 		/* Extract consistent diagnostic information. */
> > > > 	}
> > > > 	raw_spin_unlock_irq(&t->pi_lock);
> > > > 
> > > > It looks like all the wakeup paths acquire ->pi_lock, but I figured I
> > > > should actually ask...  
> > > 
> > > Close, the thing pi_lock actually guards is the t->state transition *to*
> > > TASK_WAKING/TASK_RUNNING, so something like this:  
> > 
> > Almost, we must indeed also check ->on_rq, otherwise it might change the
> > state back itself.
> >   
> > > 
> > > 	raw_spin_lock_irq(&t->pi_lock);
> > > 	switch (t->state) {
> > > 	case TASK_RUNNING:
> > > 	case TASK_WAKING:
> > > 		/* ignore */
> > > 		break;
> > > 
> > > 	default:  
> > 		if (t->on_rq)
> > 			break;
> >   
> > > 		/* Extract consistent diagnostic information. */
> > > 		break;
> > > 	}
> > > 	raw_spin_unlock_irq(&t->pi_lock);
> > > 
> > > ought to work. But if you're going to do this, please add a reference to
> > > that code in a comment on top of try_to_wake_up(), such that we can
> > > later find all the code that relies on this.  
> 
> How about if I add something like this, located right by try_to_wake_up()?
> 
> 	bool try_to_keep_sleeping(struct task_struct *t)
> 	{
> 		raw_spin_lock_irq(&t->pi_lock);
> 		switch (t->state) {
> 		case TASK_RUNNING:
> 		case TASK_WAKING:
> 			raw_spin_unlock_irq(&t->pi_lock);
> 			return false;
> 
> 		default:
> 			if (t->on_rq) {

Somehow I think there still needs to be a read barrier before the test to
on_rq.

> 				raw_spin_unlock_irq(&t->pi_lock);
> 				return false;
> 			}
> 
> 			/* OK to extract consistent diagnostic information. */
> 			return true;
> 		}
> 		/* NOTREACHED */
> 	}
> 
> Then a use might look like this:
> 
> 	if (try_to_keep_sleeping(t))
> 		/* Extract consistent diagnostic information. */
> 		raw_spin_unlock_irq(&t->pi_lock);

Perhaps we should have a allow_awake(t) to match it?

		allow_awake(t);

Where we have:

static inline allow_awake(struct task_struct *t)
{
	raw_spin_unlock_irq(&t->pi_lock);
}

-- Steve?

> 	} else {
> 		/* Woo-hoo!  It started running again!!! */
> 	}
> 
> Is there a better way to approach this?
> 
> 							Thanx, Paul


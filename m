Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95290C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F57206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589495427;
	bh=JfZ06iD6joUXIwH8ooSqgCGK+kgADmqALTGYVV5apCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jq8gYPDNM9Cwuv7InbYT3SokN4T7cg/dKHy0DHqVmJUXyLxpKOuyHfsWil6zOuSGt
	 IBayn27emuOiCeCh12VG+9iNrQOWQKORgb8l8z7nSf5Xb9eOBuJCQZPef7puNgsD89
	 +eKt/B6yaSECP0GBNENNJiZtZgBknIXBwb7gBVGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgENWa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgENWa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:30:26 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561A92065F;
        Thu, 14 May 2020 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589495425;
        bh=JfZ06iD6joUXIwH8ooSqgCGK+kgADmqALTGYVV5apCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2NspCxOGZkToo3+fx8xJC+Qf2ygjE+T7gb19UvYVE1wxrBTPpnfLEZYXpFUrH64p
         ISqhwDBUmhLLT3spWx6FVO+VlFnbN7F6MnAcMmxYWlIqhlLC9fbcxwomU5a/d5ZoTb
         VtekT5VPwn3OZ7WMLvTCrEDaWl+5uhESQh/HKZuw=
Date:   Fri, 15 May 2020 00:30:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200514223021.GA4071@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200513183831.GV2869@paulmck-ThinkPad-P72>
 <20200513224525.GA18303@lenoir>
 <20200514154707.GL2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514154707.GL2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:47:07AM -0700, Paul E. McKenney wrote:
> On Thu, May 14, 2020 at 12:45:26AM +0200, Frederic Weisbecker wrote:
> This last seems best to me.  The transition from CBLIST_NOT_OFFLOADED
> to CBLIST_OFFLOADING of course needs to be on the CPU in question with
> at least bh disabled.  Probably best to be holding rcu_nocb_lock(),
> but that might just be me being overly paranoid.

So that's in the case of offloading, right? Well, I don't think we'd
need to even disable bh nor lock nocb. We just need the current CPU
to see the local update of cblist->offloaded = CBLIST_OFFLOADING
before the kthread is unparked:

    cblist->offloaded = CBLIST_OFFLOADING;
    /* Make sure subsequent softirq lock nocb */
    barrier();
    kthread_unpark(rdp->nocb_cb_thread);

Now, although that guarantees that nocb_cb will see CBLIST_OFFLOADING
upon unparking, it's not guaranteed that the nocb_gp will see it on its
next round. Ok so eventually you're right, I should indeed lock nocb...

> 
> > > > +static long rcu_nocb_rdp_deoffload(void *arg)
> > > > +{
> > > > +	struct rcu_data *rdp = arg;
> > > > +
> > > > +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> > > > +	__rcu_nocb_rdp_deoffload(rdp);
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > For example, is the problem caused by invocations of this
> > > rcu_nocb_rdp_deoffload() function?
> > 
> > How so?
> 
> It looked to me like it wasn't excluding either rcu_barrier() or CPU
> hotplug.  It might also not have been pinning onto the CPU in question,
> but that might just be me misremembering.  Then again, I didn't see a
> call to it, so maybe its callers set things up appropriately.
> 
> OK, I will bite...  What is the purpose of rcu_nocb_rdp_deoffload()?  ;-)

Ah it's called using work_on_cpu() which launch a workqueue on the
target and waits for completion. And that whole thing is protected
inside the barrier mutex and hotplug.

> Agreed!  And I do believe that concurrent callback execution will
> prove better than a possibly indefinite gap in callback execution.

Mutual agreement! :-)

Thanks.

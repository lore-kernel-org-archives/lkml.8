Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E377C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF4520734
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589496457;
	bh=iQBGql9/hs9lhCfJ/JyxvS/wQesl/AufJOUCGqFFWQ8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HM1hsc6bVw1t3zyzqQPIWpHd8bnZrOcydnz4d8n35pY0Iw+b0p5+mZqT9aFk8yVCM
	 VNnhWzqaGBroqCABkOxPF+buu2gE5NuxZxOtYgFzqN6Vs+eBdbtaoJ5qenVvW5rlGc
	 sfBjaAgBXALk8qIMw27bbF7EW72W0l6esYUd6Sh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgENWrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgENWrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:47:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B66320709;
        Thu, 14 May 2020 22:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589496455;
        bh=iQBGql9/hs9lhCfJ/JyxvS/wQesl/AufJOUCGqFFWQ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ibZRUddvhZ1wDWv1IkPJnerw0O6RDh4blVoFd375pCwbmKBVOq5sVFF0dtdkbvxdF
         Ja1jhAHAr/D2x8rdRM/Tx8b1VCYqzIgyZyIP5TSs9UhQfqBTd8wSuPDb9yci3UmV1o
         UJYxVXWhy42JbmNyWHxK6WLj0UuBr7N6qBCLD9PQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6265235229C6; Thu, 14 May 2020 15:47:35 -0700 (PDT)
Date:   Thu, 14 May 2020 15:47:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200514224735.GA2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200513183831.GV2869@paulmck-ThinkPad-P72>
 <20200513224525.GA18303@lenoir>
 <20200514154707.GL2869@paulmck-ThinkPad-P72>
 <20200514223021.GA4071@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514223021.GA4071@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:30:23AM +0200, Frederic Weisbecker wrote:
> On Thu, May 14, 2020 at 08:47:07AM -0700, Paul E. McKenney wrote:
> > On Thu, May 14, 2020 at 12:45:26AM +0200, Frederic Weisbecker wrote:
> > This last seems best to me.  The transition from CBLIST_NOT_OFFLOADED
> > to CBLIST_OFFLOADING of course needs to be on the CPU in question with
> > at least bh disabled.  Probably best to be holding rcu_nocb_lock(),
> > but that might just be me being overly paranoid.
> 
> So that's in the case of offloading, right? Well, I don't think we'd
> need to even disable bh nor lock nocb. We just need the current CPU
> to see the local update of cblist->offloaded = CBLIST_OFFLOADING
> before the kthread is unparked:
> 
>     cblist->offloaded = CBLIST_OFFLOADING;
>     /* Make sure subsequent softirq lock nocb */
>     barrier();
>     kthread_unpark(rdp->nocb_cb_thread);
> 
> Now, although that guarantees that nocb_cb will see CBLIST_OFFLOADING
> upon unparking, it's not guaranteed that the nocb_gp will see it on its
> next round. Ok so eventually you're right, I should indeed lock nocb...

I suspect that our future selves would hate us much less if we held
that lock.  ;-)

> > > > > +static long rcu_nocb_rdp_deoffload(void *arg)
> > > > > +{
> > > > > +	struct rcu_data *rdp = arg;
> > > > > +
> > > > > +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> > > > > +	__rcu_nocb_rdp_deoffload(rdp);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > 
> > > > For example, is the problem caused by invocations of this
> > > > rcu_nocb_rdp_deoffload() function?
> > > 
> > > How so?
> > 
> > It looked to me like it wasn't excluding either rcu_barrier() or CPU
> > hotplug.  It might also not have been pinning onto the CPU in question,
> > but that might just be me misremembering.  Then again, I didn't see a
> > call to it, so maybe its callers set things up appropriately.
> > 
> > OK, I will bite...  What is the purpose of rcu_nocb_rdp_deoffload()?  ;-)
> 
> Ah it's called using work_on_cpu() which launch a workqueue on the
> target and waits for completion. And that whole thing is protected
> inside the barrier mutex and hotplug.

Ah!  Yet again, color me blind.

							Thanx, Paul

> > Agreed!  And I do believe that concurrent callback execution will
> > prove better than a possibly indefinite gap in callback execution.
> 
> Mutual agreement! :-)
> 
> Thanks.

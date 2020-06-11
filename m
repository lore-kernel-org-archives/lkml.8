Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7284FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4710E206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591895018;
	bh=gOzCa3MEA0RowkjMGp7ju28nrUWXIIrMLCNMbc2RwyA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HMYVhMn7+27BU+2so2DkUe30v6rnDcECrSl3svWr4jy04pa8gy5E/QpWjNf4dO3er
	 QCTTbC5TF4+qdXb3vUSJwfwkn9up4zHniHzdRyuCT6StrC76HLWzqssMGZB4dafkUf
	 Zz3IHNVnBerB+HOyLxIrssyo/dujhjVQXAU2jIoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFKRDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgFKRDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:03:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221332053B;
        Thu, 11 Jun 2020 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591895016;
        bh=gOzCa3MEA0RowkjMGp7ju28nrUWXIIrMLCNMbc2RwyA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=enVlRkGL5BPjR6Xk9cNNn1EyMBkJbRuYKv4I8tc8vOQC2vK+18Z3lJn9R4965s+fj
         +KFyeWVuHQmf+nlMOJf4RE7fYyLd2RQfTbj/pU5lnrbPCNgBz+dHNnOMhbGqf3JDKB
         xsrKjq/cCzTL1HoWGceWtHkmfOnuKBDj+97Asv+c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D435B35228C7; Thu, 11 Jun 2020 10:03:35 -0700 (PDT)
Date:   Thu, 11 Jun 2020 10:03:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200611170335.GC4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200526212017.GE76276@google.com>
 <20200526224908.GC16672@google.com>
 <20200604131029.GA27571@lenoir>
 <20200611013203.GA12037@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611013203.GA12037@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 09:32:03PM -0400, Joel Fernandes wrote:
> On Thu, Jun 04, 2020 at 03:10:30PM +0200, Frederic Weisbecker wrote:
> > On Tue, May 26, 2020 at 06:49:08PM -0400, Joel Fernandes wrote:
> > > On Tue, May 26, 2020 at 05:20:17PM -0400, Joel Fernandes wrote:
> > >  
> > > > > The switch happens on the target with IRQs disabled and rdp->nocb_lock
> > > > > held to avoid races between local callbacks handling and kthread
> > > > > offloaded callbacks handling.
> > > > > nocb_cb kthread is first parked to avoid any future race with
> > > > > concurrent rcu_do_batch() executions. Then the cblist is set to offloaded
> > > > > so that the nocb_gp kthread ignores this rdp.
> > > > 
> > > > nit: you mean cblist is set to non-offloaded mode right?
> > > > 
> > > > Also, could you clarify better the rcu_barrier bits in the changelog. I know
> > > > there's some issue if the cblist has both offloaded and non-offloaded
> > > > callbacks, but it would be good to clarify this here better IMHO.
> > > 
> > > And for archival purposes: rcu_barrier needs excluding here because it is
> > > possible that for a brief period of time, the callback kthread has been
> > > parked to do the mode-switch, and it could be executing a bunch of callbacks
> > > when it was asked to park.
> > > 
> > > Meanwhile, more interrupts happen and more callbacks are queued which are now
> > > executing in softirq. This ruins the ordering of callbacks that rcu_barrier
> > > needs.
> > 
> > I think in that case the callbacks would still be executed in order. We wait
> > for the kthread to park before switching to softirq callback execution.
> 
> Ah ok, you are parking the CB kthread after the no-cb CB's are already
> invoked (that's when parkme() is called -- i.e. after rcu_do_batch() in the
> CB kthread runs).
> 
> Yeah, I don't see the purpose of acquiring rcu_barrier mutex either now. Once
> you park, all CBs should have been invoked by the nocb CB thread right?
> kthread_park() waits for the thread to be parked before proceeding. And you
> don't de-offload before it is parked.

We absolutely must execute callbacks out of order in order to avoid
OOM due to RCU callback floods.  This is because if we don't execute
callbacks out of order, there will be a time when we are not executing
callbacks at all.  If execution gets preempted at this point, it is
quite possibly game over due to OOM.

							Thanx, Paul

> > Initially it was to avoid callback ordering issues but I don't recall
> > exactly which. Maybe it wasn't actually needed. But anyway I'll keep it
> > for the next version where, for a brief period of time, nocb kthread will
> > be able to compete with callback execution in softirq.
> 
> Which nocb kthread is competing? Do you mean GP or CB?
> 
> Either way, could you clarify how does softirqs compete? Until the thread is
> parked, you wouldn't de-offload. And once you de-offload, only then the
> softirq would be executing callbacks. So at any point of time, it is
> either the CB kthread executing CBs or the softirq executing CBs, not both.
> Or did I miss something?
> 
> thanks,
> 
>  - Joel
> 
> 
> > I'll clarify that in the changelog.
> > 
> > Thanks.

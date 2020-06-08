Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647B12076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591621043;
	bh=WZSZmJLWNNHt/UtK0JtOy9iXNex5f74V1lG9t3mxLko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WmztvAt4pppMsTzKz5bVnoay9igWZT4/k2VnOYya+XmAVGBlx0AoPeYwoRSbKVIl0
	 ywR1jj16Z/AU/4fGugwQkhsoTc3uTLl9EJNrsSWHHdH04meegQrMO3pwTULt7jM11M
	 OMW/ODluDKzgoyZZkdNz7VYpuxGI8YGaFZcgv0QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgFHM5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgFHM5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:57:20 -0400
Received: from localhost (lfbn-ncy-1-1025-94.w92-138.abo.wanadoo.fr [92.138.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48960206C3;
        Mon,  8 Jun 2020 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591621039;
        bh=WZSZmJLWNNHt/UtK0JtOy9iXNex5f74V1lG9t3mxLko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0pqV7/bFiwamlt2T+uYN4+GGUUQSnBDQ6tIzcbe7da0jfgztL9uN5IWmFhk/ibvui
         Qm59tAzUA/KYrYFY6mTdB7NRYYoUrwZXS3tFoLGEyb3fIbynbEgdE0cZGPh9nNh6ou
         rR28vHCTqCUqXDwd4TbYT3e1OCfVIi3XC5JVut5w=
Date:   Mon, 8 Jun 2020 14:57:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200608125715.GA30920@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200604114121.GA26398@lenoir>
 <20200604163655.GC29598@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604163655.GC29598@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 09:36:55AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 04, 2020 at 01:41:22PM +0200, Frederic Weisbecker wrote:
> > On Fri, May 22, 2020 at 10:57:39AM -0700, Paul E. McKenney wrote:
> > > On Wed, May 20, 2020 at 08:29:49AM -0400, Joel Fernandes wrote:
> > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Thank you for looking this over, Joel!
> > > 
> > > Is it feasible to make rcu_nocb_lock*() and rcu_nocb_unlock*() "do the
> > > right thing", even when things are changing?  If it is feasible, that
> > > would prevent any number of "interesting" copy-pasta and "just now became
> > > common code" bugs down the road.
> > 
> > This won't be pretty:
> > 
> >     locked = rcu_nocb_lock();
> >     rcu_nocb_unlock(locked);
> 
> I was thinking in terms of a bit in the rcu_data structure into
> which rcu_nocb_lock() and friends stored the status, and from which
> rcu_nocb_unlock() and friends retrieved that same status.  Sort of like
> how preemptible RCU uses the ->rcu_read_lock_nesting field in task_struct.
> 
> As noted, this does require reworking the hotplug code to avoid the
> current holding of two such locks concurrently, which I am happy to do
> if that helps.
> 
> Or am I missing a subtle (or not-so-subtle) twist here?

So, during a CPU round, the nocb-gp kthread locks the corresponding rdp-nocb
and then ignores if it is not offloaded. Surely there is a smarter ways to do
that though. Well that's something we'll need to optimize at some point anyway.

Also we must then make sure that the nocb timers won't ever fire while we
switch to offloaded state or they may fiddle with internals without locking
nocb.

> 
> > And anyway we still want to unconditionally lock on many places,
> > regardless of the offloaded state. I don't know how we could have
> > a magic helper do the unconditional lock on some places and the
> > conditional on others.
> 
> I was assuming (perhaps incorrectly) that an intermediate phase between
> not-offloaded and offloaded would take care of all of those cases.

Perhaps partly but I fear that won't be enough.

> 
> > Also the point of turning the lock helpers into primitives is to make
> > it clearer as to where we really need unconditional locking and where
> > we allow it to be conditional. A gift to reviewers :-)
> 
> Unless and until someone does a copy-pasta, thus unconditionally
> doing the wrong thing.  ;-)

Yeah but the cost is more complicated code and synchronization to
maintain the use of those all-in-one locking APIs everywhere. And
current state is already not that simple :-)

Perhaps we should rename rcu_nocb_lock() into rcu_nocb_lock_cond() to
prevent from accidents?

Also I've been thinking that rcu_nocb_lock() should meet any of these
requirements:

* hotplug is locked
* rcu barrier is locked
* rnp is locked

Because checking the offloaded state (when nocb isn't locked yet) of
an rdp without any of the above locks held is racy. And that should
be easy to check and prevent from copy-pasta accidents.

What do you think?

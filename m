Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A871C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5284C20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591288617;
	bh=Ob2NvE97oNdAouC/Qd1yeVKTZ9zDRPlYMVGlTwcn5xk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=GBG/J2AGSngTS5UYTt+VRMC5qyaGZy7rb/mqYVOybyfz/C1uxxMe4jwnjTpMn229H
	 jd6XGghN7QlLfCTZOWjaq2PI3YyBv7BcjXe1Z/9fnJLJkXmW4jBkT8htLnSIUoI5dR
	 u17PGQ1aZSvSNPFAk4z2iLnEmMoM3LUX5msacc3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgFDQg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbgFDQg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:36:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0112072E;
        Thu,  4 Jun 2020 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591288615;
        bh=Ob2NvE97oNdAouC/Qd1yeVKTZ9zDRPlYMVGlTwcn5xk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tJqEQdgBn+WS1LA9fQSW2gKbcql3z+nl1jeyInY0xhtJPU46R4XMimIZQY6aEk/i3
         6+Agu2RiH8XwO1IHcassX1oYTd+Jhwh3Bnh/pLouhDXwh4x0vXIvU9hslxU6QnLCsh
         S/Y+UGh1lOi8CON3Ow+q2irI7pxDYRg17PdZmSAk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8CB7635228BC; Thu,  4 Jun 2020 09:36:55 -0700 (PDT)
Date:   Thu, 4 Jun 2020 09:36:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200604163655.GC29598@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200604114121.GA26398@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604114121.GA26398@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:41:22PM +0200, Frederic Weisbecker wrote:
> On Fri, May 22, 2020 at 10:57:39AM -0700, Paul E. McKenney wrote:
> > On Wed, May 20, 2020 at 08:29:49AM -0400, Joel Fernandes wrote:
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Thank you for looking this over, Joel!
> > 
> > Is it feasible to make rcu_nocb_lock*() and rcu_nocb_unlock*() "do the
> > right thing", even when things are changing?  If it is feasible, that
> > would prevent any number of "interesting" copy-pasta and "just now became
> > common code" bugs down the road.
> 
> This won't be pretty:
> 
>     locked = rcu_nocb_lock();
>     rcu_nocb_unlock(locked);

I was thinking in terms of a bit in the rcu_data structure into
which rcu_nocb_lock() and friends stored the status, and from which
rcu_nocb_unlock() and friends retrieved that same status.  Sort of like
how preemptible RCU uses the ->rcu_read_lock_nesting field in task_struct.

As noted, this does require reworking the hotplug code to avoid the
current holding of two such locks concurrently, which I am happy to do
if that helps.

Or am I missing a subtle (or not-so-subtle) twist here?

> And anyway we still want to unconditionally lock on many places,
> regardless of the offloaded state. I don't know how we could have
> a magic helper do the unconditional lock on some places and the
> conditional on others.

I was assuming (perhaps incorrectly) that an intermediate phase between
not-offloaded and offloaded would take care of all of those cases.

> Also the point of turning the lock helpers into primitives is to make
> it clearer as to where we really need unconditional locking and where
> we allow it to be conditional. A gift to reviewers :-)

Unless and until someone does a copy-pasta, thus unconditionally
doing the wrong thing.  ;-)

If we cannot avoid different spellings of ->cblist in different places,
such is life, but I do want to make sure that we have fully considered
the alternatives.

						Thanx, Paul

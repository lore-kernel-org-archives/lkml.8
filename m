Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17129C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FB6207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591276234;
	bh=KhaotgH0l//otNB03AB1rir98Xd5bkTWiUjmhQOMhDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ncx+YygFXYn4WrGNRI0hcy8z9rc1/7MxYT7ujREsVO7qAerP6KOqwI7lPjrDoHhSh
	 JvzvuKkjiy3R5dBeaQoGv0rrZmXtw4nEJe/kEBpbp/FswwV+HpcStB9VqVTzx8j//N
	 7i1T3R20XKdGbwTCqx4YE0da+StscyZ+5WPI6v30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgFDNKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgFDNKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:10:33 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FD3D206C3;
        Thu,  4 Jun 2020 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591276233;
        bh=KhaotgH0l//otNB03AB1rir98Xd5bkTWiUjmhQOMhDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yEqGvYPW0O+EKKbZKW/d8lT7v1yqRUrXjq3TUgL2yQzJiHyRK2O+haCEROS2rOul+
         mhWcLqwSXGU2roa3QPGkCwirNqKuePmcz3vd4D3Oq3+0bv6hCpIbGzH11vLv5CrHvw
         /wSpvi/1EK177OgJlHaemMBV/STgGQAB3MezK9uA=
Date:   Thu, 4 Jun 2020 15:10:30 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200604131029.GA27571@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200526212017.GE76276@google.com>
 <20200526224908.GC16672@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526224908.GC16672@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:49:08PM -0400, Joel Fernandes wrote:
> On Tue, May 26, 2020 at 05:20:17PM -0400, Joel Fernandes wrote:
>  
> > > The switch happens on the target with IRQs disabled and rdp->nocb_lock
> > > held to avoid races between local callbacks handling and kthread
> > > offloaded callbacks handling.
> > > nocb_cb kthread is first parked to avoid any future race with
> > > concurrent rcu_do_batch() executions. Then the cblist is set to offloaded
> > > so that the nocb_gp kthread ignores this rdp.
> > 
> > nit: you mean cblist is set to non-offloaded mode right?
> > 
> > Also, could you clarify better the rcu_barrier bits in the changelog. I know
> > there's some issue if the cblist has both offloaded and non-offloaded
> > callbacks, but it would be good to clarify this here better IMHO.
> 
> And for archival purposes: rcu_barrier needs excluding here because it is
> possible that for a brief period of time, the callback kthread has been
> parked to do the mode-switch, and it could be executing a bunch of callbacks
> when it was asked to park.
> 
> Meanwhile, more interrupts happen and more callbacks are queued which are now
> executing in softirq. This ruins the ordering of callbacks that rcu_barrier
> needs.

I think in that case the callbacks would still be executed in order. We wait
for the kthread to park before switching to softirq callback execution.

Initially it was to avoid callback ordering issues but I don't recall
exactly which. Maybe it wasn't actually needed. But anyway I'll keep it
for the next version where, for a brief period of time, nocb kthread will
be able to compete with callback execution in softirq.

I'll clarify that in the changelog.

Thanks.

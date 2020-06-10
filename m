Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC7EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A332074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591827171;
	bh=bXURC8eTjwT+ydR04KJKf77k89/eZspbvVP0SRM6Dus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VlD5dsRlXuBkegBFHKgP05JD3Cbsp5CdOIPHuoxJCdO0ZffftARPm7MXGhve+JY3u
	 oxlhSBFyKcyot48pRN/yyUKQcA5z0wLXBf5Cg0+hxTGdfcMKP58em52iGlx9WVyKB/
	 reOYQmYX1ug0TdhH+Y2RRnDPr17BgNN5zeemHFgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgFJWMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgFJWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:12:49 -0400
Received: from localhost (lfbn-ncy-1-1025-94.w92-138.abo.wanadoo.fr [92.138.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B97B2072E;
        Wed, 10 Jun 2020 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591827168;
        bh=bXURC8eTjwT+ydR04KJKf77k89/eZspbvVP0SRM6Dus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCxNT0uzQoIF/6PlgjKI/OXhbhL9EsfG/lkkmPoQOleBevZAHymRQhtfmvZVRwIoJ
         YVQF8v4YHE4bohMwIJgc6fhD0+z/4+7Rv9veZOXdh8s2JBuA0ud+6TqbRJy3hwjWSu
         X5FVSXchmO6+AMfdzifXuK3nzjAfjSP5srxcye2g=
Date:   Thu, 11 Jun 2020 00:12:46 +0200
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
Message-ID: <20200610221245.GA3833@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200604114121.GA26398@lenoir>
 <20200604163655.GC29598@paulmck-ThinkPad-P72>
 <20200608125715.GA30920@lenoir>
 <20200609180227.GR4455@paulmck-ThinkPad-P72>
 <20200610131238.GA26639@lenoir>
 <20200610140210.GT4455@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610140210.GT4455@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 07:02:10AM -0700, Paul E. McKenney wrote:
> And just to argue against myself...
> 
> Another approach is to maintain explicit multiple states for each
> ->cblist, perhaps something like this:
> 
> 1.	In softirq.  Transition code advances to next.
> 2.	To no-CB 1.  Either GP or CB kthread for the transitioning
> 	CPU advances to next.  Note that the fact that the
> 	transition code runs on the transitioning CPU means that
> 	the RCU softirq handler doesn't need to be involved.
> 3.	To no-CB 2.  Either GP or CB kthread for the transitioning
> 	CPU advances to next.

Just to clarify, if GP has set NO_CB2 in (2), we want CB to set NO_CB3
in 3), right? OTOH if CB has set NO_CB2 in (2), we want GP to set NO_CB3
in (3), right?

The point being to make sure that both threads acknowledge the transition?

> 4.	To no-CB 3.  Transitioning code advances to next.
> 	At this point, the no-CBs setup is fully functional.

And softirq can stop processing callbacks from that point on.

> 5.	No-CB.  Transitioning code advances to next.
> 	Again, the fact that the transitioning code is running
> 	on the transitioning CPU with interrupts disabled means
> 	that the RCU softirq handler need not be explicitly
> 	involved.
> 6.	To softirq 1.  The RCU softirq handler for the transitioning
> 	CPU advances to next.
> 	At this point, the RCU softirq handler is processing callbacks.
> 7.	To softirq 2.  Either GP or CB kthread for the transitioning
> 	CPU advances to next.
> 	At this point, the softirq handler is processing callbacks.

SOFTIRQ2 should be part of what happens in SOFTIRQ1. The transitioning
CPU sets SOFTIRQ1, which is immediately visible by local softirqs,
and wakes up CB/GP. CB/GP sets SOFTIRQ2, CB/GP sets SOFTIRQ3 and
we go back to transitioning code that sets IN_SOFTIRQ.

Or did I miss something?


> 8.	To softirq 3.  Either GP or CB kthread for the transitioning
> 	CPU advances to next.
> 	At this point, the no-CBs setup is fully shut down.
> 9.	To softirq 4.  Transitioning code advances to next,
> 	which is the first, "In softirq".
> 	(This one -might- be unnecessary, but...)
> 
> All transitions are of course with the ->nocb_lock held.
> 
> When there is only one CPU during early boot near rcu_init() time,
> the transition from "In softirq" to "No-CB" can remain be instantaneous.
> 
> This has the advantage of not slowing things down just because there
> is an RCU callback flood in progress.  It also uses an explicit
> protocol that should (give or take bugs) maintain full safety both
> in protection of ->cblist and in dealing with RCU callback floods.
> 
> Thoughts?

Agreed. And I really like that it details the whole process in a very
explicit way.

Thanks!

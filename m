Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD1AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE695217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581110691;
	bh=Tl95tnh6DZ9qpgq4khmzZST+oYBu9WxXnBeskzydGIQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jNd2KzFvt3XPqbGGYnO/GXeChdpDc+/RBpO3LVKvmAD1nGIDaUsi8Q0+xfhNWipL9
	 Lpak8rCTdU3G7R2MPKAveCt4afHPveCxyvzj9vgB+4IiCm1BLiVtxg9rlFg1zfen21
	 fGBXWOS7hEwAI8o13UMp/vEJrUVXdmNwTPK/z9ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGVYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgBGVYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:24:50 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7029E222C2;
        Fri,  7 Feb 2020 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581110690;
        bh=Tl95tnh6DZ9qpgq4khmzZST+oYBu9WxXnBeskzydGIQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GyGCTB/BKlsiAnFH+WUtQ9gEDJlA/lFqEGalUSX/M1a+yES4vfuqT/e3oWbaY4kdC
         3TC1GS80iWULPSymd4dCceb0IGPMVEsaMBYUkGa2sUJdSH7VMPikpX95Sk1Esp2FDk
         v4gSF6gccxqvMLH24PTo820uYvg6wu1FTd2V1hZs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 43F4F35219BF; Fri,  7 Feb 2020 13:24:50 -0800 (PST)
Date:   Fri, 7 Feb 2020 13:24:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200207212450.GP2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200207205656.61938-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207205656.61938-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 03:56:53PM -0500, Joel Fernandes (Google) wrote:
> Hi,
> These patches remove SRCU usage from tracepoints. The reason for proposing the
> reverts is because the whole point of SRCU was to avoid having to call
> rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
> Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
> was breaking..
> 
> Further it occurs to me that, by using SRCU for tracepoints, we forgot that RCU
> is not really watching the tracepoint callbacks. This means that anyone doing
> preempt_disable() in their tracepoint callback, and expecting RCU to listen to
> them is in for a big surprise. When RCU is not watching, it does not care about
> preempt-disable sections on CPUs as you can see in the forced-quiescent state loop.
> 
> Since SRCU is not providing any benefit because of 865e63b04e9b2 anyway, let us
> revert SRCU tracepoint code to maintain the sanity of potential
> tracepoint callback registerers.

For whatever it is worth, SRCU is the exception to the "RCU needs to
be watching" rule.  You can have SRCU readers on idle CPUs, offline
CPUs, CPUs executing in userspace, whatever.

							Thanx, Paul

> Joel Fernandes (Google) (3):
> Revert "tracepoint: Use __idx instead of idx in DO_TRACE macro to make
> it unique"
> Revert "tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> tracepoints"
> Revert "tracepoint: Make rcuidle tracepoint callers use SRCU"
> 
> include/linux/tracepoint.h | 40 ++++++--------------------------------
> kernel/tracepoint.c        | 10 +---------
> 2 files changed, 7 insertions(+), 43 deletions(-)
> 
> --
> 2.25.0.341.g760bfbb309-goog
> 

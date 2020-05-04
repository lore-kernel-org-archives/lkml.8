Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1030C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78972073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588612653;
	bh=9pXUHvRwCWJxoSP3RKEJ7NWKpIC6W7C2MfnDvVAMReo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=P5kycdqwrnHAH/BDwaypx4AJwESij3flj1D6xmVc4Jy/9+ynlH41WHS+lI1rouGEd
	 iQKSaXoxCq39snrsXrlqyRy8hUnjRny0YbrFz29gIJz52/qqEt7vt56m0VsVFJUcir
	 e8g58M7zRcb6pO0S1o8dfM4cuYN5EOQCABsK3eaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgEDRRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbgEDRPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:15:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C1324955;
        Mon,  4 May 2020 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588612533;
        bh=9pXUHvRwCWJxoSP3RKEJ7NWKpIC6W7C2MfnDvVAMReo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CJFE86LLo7HrZ/Cb8xgKQLYO4YB6+uxFw3PLO7THErV6hbMP4gn9tINu67rI1fTLl
         VOpoSXaWKyH6e/fHrATcWAs0SmcB/RDoNwuV90mYb/8KXq54gxVpvj8585lqyaE6UP
         R/gPOj1XwCVznv4jF02ZtGd2ToYXyvONG2+nHmPI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B512735226F4; Mon,  4 May 2020 10:15:32 -0700 (PDT)
Date:   Mon, 4 May 2020 10:15:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        vpillai@digitalocean.com
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
Message-ID: <20200504171532.GR2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200504120505.89351-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504120505.89351-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 08:05:00AM -0400, Joel Fernandes (Google) wrote:
> These patches clean up the usage of dynticks nesting counters simplifying the
> code, while preserving the usecases.
> 
> It is a much needed simplification, makes the code less confusing, and prevents
> future bugs such as those that arise from forgetting that the
> dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
> common situations.
> 
> rcutorture testing with all TREE RCU configurations succeed with
> CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.
> 
> v1->v2:
> - Rebase on v5.6-rc6
> 
> v2->v3:
> - Rebase on rcu/dev with adjustments for tasks-RCU.

Thank you!

But this does not apply to any of v5.6-rc6, v5.7-rc1, or v5.7-rc2.

Where should I be trying to apply it?

							Thanx, Paul

> Joel Fernandes (Google) (4):
> Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of
> ->dynticks counter")
> rcu/tree: Add better tracing for dyntick-idle
> rcu/tree: Clean up dynticks counter usage
> rcu/tree: Remove dynticks_nmi_nesting counter
> 
> Madhuparna Bhowmik (1):
> trace: events: rcu: Change description of rcu_dyntick trace event
> 
> .../Data-Structures/Data-Structures.rst       |  31 +--
> Documentation/RCU/stallwarn.rst               |   6 +-
> include/linux/rcutiny.h                       |   3 -
> include/trace/events/rcu.h                    |  29 +--
> kernel/rcu/rcu.h                              |   4 -
> kernel/rcu/tree.c                             | 199 +++++++-----------
> kernel/rcu/tree.h                             |   4 +-
> kernel/rcu/tree_stall.h                       |   4 +-
> 8 files changed, 110 insertions(+), 170 deletions(-)
> 
> --
> 2.26.2.526.g744177e7f7-goog
> 

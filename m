Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DCDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A192078E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592003828;
	bh=egIaeDvlLClgROPOhXowlWDstwIaYaP7fH8KEmN6qKM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lGWmtriCArUrEPy8hRaBxomQA7eO0qBGOiXlNSe7LLxX2e/kryuKjvdBssWdmX1FF
	 W1QEXfdmHlLllgyK5vh1ZzL8++kNcHM+3NwYp67LKUEJ6RnUkgwgnpx+6CWEEMGwXu
	 dkCieBPyAPFzAP1E/DdtofMYwKntxGWrptGhDqFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFLXRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgFLXRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:17:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F2F8206D7;
        Fri, 12 Jun 2020 23:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592003825;
        bh=egIaeDvlLClgROPOhXowlWDstwIaYaP7fH8KEmN6qKM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a1cPM1dd4ZdQempC/TazcQVi2A2B7PfWLLPfxCXhnasKFVq+KwEuAOtinEKa141J8
         Mw7IHEK6LS3cPIRwnclmaA350Oum8Tgyc5uR3BnGkgJrFW0tKuBLSRPEsmez7ibiy2
         VOglXxEXEVXamOkKT2RUHeFMXDrUDFBMGCsKh0Cc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 26BF43522658; Fri, 12 Jun 2020 16:17:05 -0700 (PDT)
Date:   Fri, 12 Jun 2020 16:17:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, trivial@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] rcu: use gp_seq instead of rcu_gp_seq for consistency
Message-ID: <20200612231705.GO4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
 <20200612020755.50526-5-richard.weiyang@linux.alibaba.com>
 <20200612141248.GK4455@paulmck-ThinkPad-P72>
 <20200612221025.7ry7wffycoa7pned@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612221025.7ry7wffycoa7pned@master>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:10:25PM +0000, Wei Yang wrote:
> On Fri, Jun 12, 2020 at 07:12:48AM -0700, Paul E. McKenney wrote:
> >On Fri, Jun 12, 2020 at 10:07:55AM +0800, Wei Yang wrote:
> >> Commit de30ad512a66 ("rcu: Introduce grace-period sequence numbers")
> >> introduce gp_seq in rcu_state/rcu_node/rcu_data. And this field in last
> >> two structure track the one in first.
> >> 
> >> While the comment use rcu_gp_seq which is a little misleading for
> >> audience. Let's use the exact name gp_seq for consistency.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> >
> >I applied and pushed the others -- good eyes, and thank you!
> >
> >This one does not apply.  Could you please forward-port it to
> >the "dev" branch of -rcu?
> 
> The reason is someone has already fixed this :-)

That would explain it!  ;-)

							Thanx, Paul

> >git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> >
> >							Thanx, Paul
> >
> >> ---
> >>  kernel/rcu/tree.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> >> index 512829eed545..3356842bc185 100644
> >> --- a/kernel/rcu/tree.h
> >> +++ b/kernel/rcu/tree.h
> >> @@ -41,7 +41,7 @@ struct rcu_node {
> >>  	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
> >>  					/*  some rcu_state fields as well as */
> >>  					/*  following. */
> >> -	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
> >> +	unsigned long gp_seq;	/* Track rsp->gp_seq. */
> >>  	unsigned long gp_seq_needed; /* Track furthest future GP request. */
> >>  	unsigned long completedqs; /* All QSes done for this node. */
> >>  	unsigned long qsmask;	/* CPUs or groups that need to switch in */
> >> @@ -149,7 +149,7 @@ union rcu_noqs {
> >>  /* Per-CPU data for read-copy update. */
> >>  struct rcu_data {
> >>  	/* 1) quiescent-state and grace-period handling : */
> >> -	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
> >> +	unsigned long	gp_seq;		/* Track rsp->gp_seq. */
> >>  	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
> >>  	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
> >>  	bool		core_needs_qs;	/* Core waits for quiesc state. */
> >> -- 
> >> 2.20.1 (Apple Git-117)
> >> 
> 
> -- 
> Wei Yang
> Help you, Help me

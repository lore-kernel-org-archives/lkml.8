Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B6DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF8F21D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599690846;
	bh=UQbrIMRndWpCO8XQGf0QGRRyTJhPBhqUbyV2/Xk+ZFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WutNpSPujuuRVmkmByGhhw/YgyJgTM4FFffzm86o6uqZ/m1V+Zvq2edFTQtjDloiG
	 BkfKmkVZe4FX4b5+gi6a8471/Bh13D47F6wTJJubRzYDuGLv3mN9p+eWvMprTMCU7F
	 VHVA4GKc8YkhHPvpLfE29YOgEvF+XwcmNoBDXzvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIIWeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgIIWeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 18:34:04 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B4920C09;
        Wed,  9 Sep 2020 22:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599690843;
        bh=UQbrIMRndWpCO8XQGf0QGRRyTJhPBhqUbyV2/Xk+ZFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLrryTb9IizzHDDHwyxBU3y9MV3ayJFgQ/HrRZEwKZe4cGtvxVPAOE7ZJQNOgawQv
         ZVUtjiiqkbPkpxRDlDDcjAhw1XsWia4dYztX12BRCY8Cfkx+maH5NuYfq4gaGIxxIQ
         bBnVO9Wq3Z+sOm2otIwve/XcDJp6yTFqlbWwZtzE=
Date:   Thu, 10 Sep 2020 00:34:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Requirements to control kernel isolation/nohz_full at runtime
Message-ID: <20200909223400.GA20541@lenoir>
References: <20200901104640.GA13814@lenoir>
 <20200903182359.GA1016174@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903182359.GA1016174@fuller.cnet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:23:59PM -0300, Marcelo Tosatti wrote:
> On Tue, Sep 01, 2020 at 12:46:41PM +0200, Frederic Weisbecker wrote:
> > == Unbound affinity ==
> > 
> > Restore kernel threads, workqueue, timers, etc... wide affinity. But take care of cpumasks that have been set through other
> > interfaces: sysfs, procfs, etc...
> 
> We were looking at a userspace interface: what would be a proper
> (unified, similar to isolcpus= interface) and its implementation:
> 
> The simplest idea for interface seemed to be exposing the integer list of
> CPUs and isolation flags to userspace (probably via sysfs).
> 
> The scheme would allow flags to be separately enabled/disabled, 
> with not all flags being necessary toggable (could for example
> disallow nohz_full= toggling until it is implemented, but allow for
> other isolation features to be toggable).
> 
> This would require per flag housekeeping_masks (instead of a single).

Right, I think cpusets provide exactly.

> Back to the userspace interface, you mentioned earlier that cpusets
> was a possibility for it. However:
> 
> "Cpusets provide a Linux kernel mechanism to constrain which CPUs and
> Memory Nodes are used by a process or set of processes.
> 
> The Linux kernel already has a pair of mechanisms to specify on which
> CPUs a task may be scheduled (sched_setaffinity) and on which Memory
> Nodes it may obtain memory (mbind, set_mempolicy).
> 
> Cpusets extends these two mechanisms as follows:"
> 
> The isolation flags do not necessarily have anything to do with
> tasks, but with CPUs: a given feature is disabled or enabled on a
> given CPU. 
> No?

When cpusets are set as exclusive, they become strict CPU properties.
I think we'll need to enforce the exclusive property to set the isolated
flags.

Then you're free to move the tasks you like into any isolated cpusets.

> Regarding locking of the masks, since housekeeping_masks can be called
> from hot paths (eg: get_nohz_timer_target) it seems RCU is a natural
> fit, so userspace would:
> 
> 1) use interface to change cpumask for a given feature:
> 
> 	-> set_rcu_pointer
> 	-> wait for grace period

Yep, could be a solution.

> 2) proceed to trigger actions that rely on housekeeping_cpumask, 
> to validate the cpumask at 1) is being used.

Exactly. I guess we can simply call directly to subsystems (timers,
workqueue, kthreads, ...) from the isolation code upon cpumask update.
This way we avoid ordering surprises that would come with a notifier.

> Regarding nohz_full=, a way to get an immediate implementation 
> (without handling the issues you mention above) would be to boot
> with a set of CPUs as "nohz_full toggable" and others not. For 
> the nohz_full toggable ones, you'd introduce a per-CPU tick
> dependency that is enabled/disabled on runtime. Probably better
> to avoid this one if possible...

Right but you would still have all the overhead that comes with nohz full
(kernel entry/exit tracking, RCU userspace extended grace period, RCU callbacks
offloaded, vtime accounting, ...). It will become really interesting once we
can switch all that overhead off.

Thanks.

Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A34C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AAC82070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595614755;
	bh=srRP6bixLuY+rClSJQxHida3dp9yMGYO+hiBwugOPAk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XrMAChFD8GvzZj0vKu+5V5Hy0ilhK1XVhQzjRCC+3/952FKMBnSkJ3dBgY2exGDQf
	 TzX2X6weN+H5OkoZEH7qBETZ1ZT1XW/jT/2Mu9c+XgqGUebYteTuysBzxFAY+pCtaU
	 Z7nUf5g0mbV0Z1imNa53WSSLiNNe56TX/oYhlJz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGXSTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXSTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:19:13 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C084206D8;
        Fri, 24 Jul 2020 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595614753;
        bh=srRP6bixLuY+rClSJQxHida3dp9yMGYO+hiBwugOPAk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KTSGKJ5LTkldW6rjfTUJ6dTR1KixeiEjg8nB+dp7tkpADE7jpVzfGILuaU+zzchlg
         ztJCeZUlQ5K1UJFbJEUIU5/0w9FGkc43ROZutXpRMrS9gb94hV5R2S3rKMYvn61MXv
         kswE2dZZBtufl0RdBRNl0AjYHKze6ftt4RmVA1m8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4D9213520BD1; Fri, 24 Jul 2020 11:19:13 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:19:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, frederic@kernel.org
Subject: Re: [PATCH smp 2/2] kernel/smp: Provide CSD lock timeout diagnostics
Message-ID: <20200724181913.GA25015@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200709235436.GA20922@paulmck-ThinkPad-P72>
 <20200709235557.21080-2-paulmck@kernel.org>
 <20200710103227.GD4800@hirez.programming.kicks-ass.net>
 <20200710212834.GL9247@paulmck-ThinkPad-P72>
 <20200710225849.GA6004@paulmck-ThinkPad-P72>
 <20200723135556.GQ5523@worktop.programming.kicks-ass.net>
 <20200723225057.GB9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723225057.GB9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:50:57PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 23, 2020 at 03:55:56PM +0200, Peter Zijlstra wrote:

[ . . . ]

> > > +	ts2 = sched_clock();
> > > +	ts_delta = ts2 - *ts1;
> > > +	if (likely(ts_delta <= CSD_LOCK_TIMEOUT)) {
> > > +		cpu_relax();
> > > +		return false;
> > > +	}
> > > +
> > > +	firsttime = !*bug_id;
> > > +	if (firsttime)
> > > +		*bug_id = atomic_inc_return(&csd_bug_count);
> > > +	cpu = csd_lock_wait_getcpu(csd);
> > > +	smp_mb(); // No stale cur_csd values!
> > 
> > > +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> > > +		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, 0));
> > > +	else
> > > +		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, cpu));
> > 
> > This is a potential user-after-free, func() may free the csd when async.
> > Although I don't believe anybody does so.
> 
> Huh.  This will require some thought.  The one that the CPU is currently
> executing is available, so this is a problem only when they stack up.

Bah.  This is exactly why the cur_csd_func and cur_csd_info per-CPU
variables exist, and so I just need to actually use them.  :-/

							Thanx, Paul

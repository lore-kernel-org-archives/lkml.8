Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B72C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D5A207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592236343;
	bh=8aoTAdf8sVDGVXim6ZnGGER2e0T2HZJlWlL5LqzGsMM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=wLy7bjyJL1WdyM1NWefVD5u0YVqxQLeNGj/GfN/coFUOgrypLHYf0AK1QH7YUpQAw
	 CCGDGNw2LnntW3uR+ouPy9Hf6HAPwPdeRaHCHIe/S9cTQ4nrKyKO1UJQs2/OxxkPkc
	 9nG8U9uGUBZ27MAa930AEo4oba6Rpvt4F8g7SDPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgFOPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbgFOPwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:52:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC67206DB;
        Mon, 15 Jun 2020 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592236340;
        bh=8aoTAdf8sVDGVXim6ZnGGER2e0T2HZJlWlL5LqzGsMM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AbWyZrgTOcnBM+QsJ2rCdQ0BQ/HKj81ZvDYn/rYzhsd4BCx5iVbiwgXzrrhBrzpnV
         uDMkpRSXn3YVApNusBPZ3DpjgP3Il2j5tudd2HF2Q0u62PhR7181I0SjbMZ3ZWAiNF
         6yrYdrIjacD3IuMMgVe8vuvh8jPoLUOWMI8evNno=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B3D063522EFD; Mon, 15 Jun 2020 08:52:20 -0700 (PDT)
Date:   Mon, 15 Jun 2020 08:52:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200615155220.GE2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200603164600.GQ29598@paulmck-ThinkPad-P72>
 <20200615153052.GY2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615153052.GY2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 05:30:52PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 03, 2020 at 09:46:00AM -0700, Paul E. McKenney wrote:
> 
> > >  	// RCU is now watching.  Better not be in an extended quiescent state!
> > >  	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
> > >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> > >  		     !(seq & RCU_DYNTICK_CTRL_CTR));
> > >  	if (seq & RCU_DYNTICK_CTRL_MASK) {
> > > -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > > +		arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > 
> > This one is gone in -rcu.
> 
> I'm still seeing that in mainline, was that removal scheduled for next
> round?

Yes.  Unlike the few commits following it, this commit seems to work
fine even with the recent changes in mainline.

> > >  		smp_mb__after_atomic(); /* _exit after clearing mask. */
> > >  	}
> > >  }
> 
> What shall we do with this patch?

I plan to submit it to the v5.9 merge window.  Do you need it to get
to mainline earlier?

							Thanx, Paul

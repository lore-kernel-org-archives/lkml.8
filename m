Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DAAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2CA217D8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594055211;
	bh=8EZi7GgGgPPffu74raLQxqgFlZz10X6qFN6WvUpuQPo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QZ6teheLN6LyLxZ9iOfgrqy4btcwxbQe5Qge2dd5v2U4246EHL+A2I87+9Xe8v+AJ
	 2jXkVDeDa77i4Pk3rJ7R0oMIpJjWRAvrmtRhxaLPsJ2+adCHSaByhMzZ+P5LXe9Qv4
	 QciQcT4jLpa/Z/dFJE2yQi3Nh6IOqIuvjfEqQn0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgGFRGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbgGFRGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:06:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A698F217D8;
        Mon,  6 Jul 2020 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594055209;
        bh=8EZi7GgGgPPffu74raLQxqgFlZz10X6qFN6WvUpuQPo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AtdJrePdNXqZISymueTLPI0FO1PLWT/VBuWVdmUxxusAWhC6ZPqF4QHRI6VP2PG48
         rJ4LF9WmeDTDmgrwN6mR2DLd1cMEPkBRZNtxUq8VJB00o/J5Z1Az+92xKN8gI92g8G
         YZivT1vHl8uf+lMtCBD1JR7llIeplXAx0bHbnzoQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8E5A63521502; Mon,  6 Jul 2020 10:06:49 -0700 (PDT)
Date:   Mon, 6 Jul 2020 10:06:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH tick-sched] Clarify "NOHZ: local_softirq_pending" warning
Message-ID: <20200706170649.GW9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200626210506.GA27189@paulmck-ThinkPad-P72>
 <20200706164816.GA1299@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706164816.GA1299@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 12:48:16PM -0400, Qian Cai wrote:
> On Fri, Jun 26, 2020 at 02:05:06PM -0700, Paul E. McKenney wrote:
> > Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
> > (where "HH" is the hexadecimal softirq vector number) when one or more
> > non-RCU softirq handlers are still enablded when checking to stop the
> > scheduler-tick interrupt.  This message is not as enlightening as one
> > might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
> > local softirq work is pending, handler #HH.
> > 
> > Reported-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> CPU hotplug will sometimes trigger this warning on linux-next from NUMA
> bare-metal which the commit makes it feel more like errors.

One point of the change was to make it clear that this is an error.
So success!  ;-)

> [  267.734981] smpboot: CPU 42 is now offline
> [  267.991940] smpboot: Booting Node 2 Processor 42 APIC 0x29
> [  267.998370] numa_add_cpu cpu 42 node 2: mask now 8-11,40-43
> [  268.092380] ACPI: \_SB_.SCK0.C015: Found 2 idle states
> [  268.181917] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #282
> [  268.190585] numa_remove_cpu cpu 1 node 0: mask now 0,2-3,32-35
> [  268.194075] smpboot: CPU 1 is now offline
> [  268.415320] x86: Booting SMP configuration:
> [  268.420245] smpboot: Booting Node 0 Processor 1 APIC 0x2
> 
> # git clone https://github.com/cailca/linux-mm
> # cd linux-mm; make
> # ./random 4 (it just soft offline and online each CPU)
> 
> The x86.config is also included there. This is only reproducible on x86
> so far.

I must defer to Frederic and Andy on this one.  But now that you mention
it, I do see this on some of my runs, which are x86, but not bare metal.
I clearly need to upgrade my console-log parsing.

							Thanx, Paul

> > ---
> > 
> >  tick-sched.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index f0199a4..349a25a 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -927,7 +927,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
> >  
> >  		if (ratelimit < 10 &&
> >  		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
> > -			pr_warn("NOHZ: local_softirq_pending %02x\n",
> > +			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x\n",
> >  				(unsigned int) local_softirq_pending());
> >  			ratelimit++;
> >  		}

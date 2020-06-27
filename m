Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF267C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 21:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8250206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593294392;
	bh=F3oRDiJxIGtXcCW5CIdMLvfO8YHc58JcaOd1gOgcwtg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hW8/YEzJCvNKF8vpubu0a79iVE+d/h8JlBqrhg5GpS7RVIr8HN7gLNyS1y/LSdd7q
	 2dobkOCm6i8YK+4JNz8GgaeKt7pBZApOfYG3UIHi76G+6d75k0M9xtG/Ak5lg9iH7f
	 6wJqZippQkySaFzrOcsYfrfc5xyEu3EmC/ObAp2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgF0Vqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 17:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgF0Vqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 17:46:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D52206D7;
        Sat, 27 Jun 2020 21:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593294390;
        bh=F3oRDiJxIGtXcCW5CIdMLvfO8YHc58JcaOd1gOgcwtg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wAzt260oInXC/o4Kk6eOxh8LSitHoSdBUCivK35C3smjvRGi5ImCI1v7tjBveJpVI
         e8saLa3UUiQQjUeXnub97h7LM6FYD00SzzY38gJlYlikPJDUK1fP4ZkZVUVaZA4hkV
         S5Mr94ySbi68duZyQ22U6YwUleyUm51VgBt55tVk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0180C3522FF8; Sat, 27 Jun 2020 14:46:29 -0700 (PDT)
Date:   Sat, 27 Jun 2020 14:46:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH tick-sched] Clarify "NOHZ: local_softirq_pending" warning
Message-ID: <20200627214629.GH9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200626210506.GA27189@paulmck-ThinkPad-P72>
 <CALCETrXN5Mm7yvDPsD7Ok=QAVoLH_fnEOgtdU2QCP+-q9u_ALA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXN5Mm7yvDPsD7Ok=QAVoLH_fnEOgtdU2QCP+-q9u_ALA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 02:02:15PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 26, 2020 at 2:05 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
> > (where "HH" is the hexadecimal softirq vector number) when one or more
> > non-RCU softirq handlers are still enablded when checking to stop the
> > scheduler-tick interrupt.  This message is not as enlightening as one
> > might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
> > local softirq work is pending, handler #HH.
> 
> Thank you!  It would be even better if it would explain *why* the
> problem happened, but I suppose this code doesn't actually know.

Glad to help!

To your point, is it possible to bisect the appearance of this message,
or is it as usual non-reproducible?  (Hey, had to ask!)

							Thanx, Paul

> --Andy
> 
> >
> > Reported-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
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
> >                 if (ratelimit < 10 &&
> >                     (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
> > -                       pr_warn("NOHZ: local_softirq_pending %02x\n",
> > +                       pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x\n",
> >                                 (unsigned int) local_softirq_pending());
> >                         ratelimit++;
> >                 }

Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B476C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193AA2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579981729;
	bh=qc/oReZntO+DEJfAdW9I3PzrnYoGP3Q/Si+WAw90qlQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OjqCfrdfafJYbUEHQTbRwId2tS+yxfK6J1yAyk0dSUgYvNh8bXpWMAltK6IUZbx0N
	 HH2PkTRe+nnQeb1LAo/UXPFR7ZpM6kfCB1oQ1NtUKoLWkHor/rcbcQu09ddcA0DnFU
	 +2BLAHOZWkFPOGJPH4MOk9XwNxzG79mPk/P7rAq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgAYTss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 14:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgAYTss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 14:48:48 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134AE20708;
        Sat, 25 Jan 2020 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579981727;
        bh=qc/oReZntO+DEJfAdW9I3PzrnYoGP3Q/Si+WAw90qlQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t06DNwJBZl5AeGt5+/RMncfvDWRW8Bl2zdc3jcSNFvEVMzc64Hbu6Cfws4Hhrskep
         I+uudPMPaZqRQZ8tZ2i2pJDVoDdm1qOLbM0LrZ942YRTdwUcedVief+31WNWAJoDAL
         J2ze1pMlCZChulVrZyu/O15yur3laVsLfSxpNZOI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B69B3352274E; Sat, 25 Jan 2020 11:48:46 -0800 (PST)
Date:   Sat, 25 Jan 2020 11:48:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200125194846.GF2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
 <20200125175442.GA4369@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125175442.GA4369@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 06:54:42PM +0100, Borislav Petkov wrote:
> On Sat, Jan 25, 2020 at 08:10:50AM -0800, Paul E. McKenney wrote:
> > How big?  (Seriously, given that the fix may depend on the number of CPUs.)
> 
> [    7.660017] smp: Brought up 2 nodes, 256 CPUs
> 
> > So the problem appears to be that some of the boot-time processing
> > is looping in the kernel, which is preventing the grace period from
> > completing.  One could argue that such code should be fixed, but on the
> > other hand, boot time is a bit special.  Later in -rcu's dev branch,
> > there are commits that forgive this boot-time misbehavior, but this is
> > a bit late in process to dump all of those commits into -tip.
> 
> Aha.
> 
> > The RT guys might need the warning, and it was them that I was thinking
> > of when adding it. 
> 
> But "boot time is a bit special". Or do they care about deadlines during
> boot too?

Maybe, but not that I know of.  If they do, this would be an excellent
time for them to let me know!

My guess is "no" because the real-time application would not yet be
running during boot.  On the other hand, if this issue is due not so much
to boot, but to (say) expensive filesystem operations on large systems,
that might be a different story.

Except that I would have hard questions to ask of someone doing expensive
filesystem operations while their deep-sub-millisecond real-time
application was running.  So even then, I doubt that they would care.

Again, if I am wrong about this, this would be an excellent time for
them to let me know.

> > But let's see what works for mainline first.  And
> > since your box was booting fine without the warning before, I bet that
> > it boots just fine with that warning removed.
> 
> Yes, it does.

Woo-hoo!!!

> > So could you please try out the (untested) patch below?
> 
> Warning's gone.

Very good.  I will get it property prepared and tested, then send it
along to Ingo.

> > If that works, I will re-introduce the warning with proper protection
> > for the merge window following this coming one.
> 
> My big box is at your service if you need stuff tested later.

Thank you in advance!  I just might take you up on that!

In the meantime, one question...  Are you testing for realtime suitability
on your big box?  If so, to what extent?

> Thx Paul.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Aside from habitually failing to trim emails, which of these was I
violating?  ;-)

							Thanx, Paul

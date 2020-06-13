Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0471207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592060242;
	bh=h0RBf3pmTklFQQUTKZEwrGTsYzYBmF6WgzwNYFx1FiI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vGK4Z4QInpGvXbCjRGf07WdNL6v9uaxSecKuGzrbe2U8DmFkvcxjni38Porr14WzJ
	 PdDNpQr+9CCVxoPXzoM8dBSZfNKcfavjomQYOfd5jzIuJfx6fDH/leMfW+UkltQhKz
	 CrT8KZTk+yyeckIEzkE9jsFpzRIZIseD3vigHToA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFMO5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 10:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgFMO5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 10:57:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699892074D;
        Sat, 13 Jun 2020 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592060239;
        bh=h0RBf3pmTklFQQUTKZEwrGTsYzYBmF6WgzwNYFx1FiI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kUFzvMDXXyqpNTBId8HBUEmIPZmuCJioOhlujecvXXLaFu+xRMaaFIW5NrVg5Pa4w
         CqWelJG2jcorZQwLaXNkMrCrhjMLOA7rQCSEQnPkbLO9eIt7LzEtXEzUGldfbQmtzu
         iM/PpdpRIX1gmlDXFx+XFRW/fm44QW11pIXgkNKk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4DE483522698; Sat, 13 Jun 2020 07:57:19 -0700 (PDT)
Date:   Sat, 13 Jun 2020 07:57:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200613145719.GA2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
 <20200605131451.GE2750@hirez.programming.kicks-ass.net>
 <20200605141607.GB4455@paulmck-ThinkPad-P72>
 <20200605184159.GA4062@paulmck-ThinkPad-P72>
 <20200606005126.GA21507@paulmck-ThinkPad-P72>
 <20200606172942.GA30594@paulmck-ThinkPad-P72>
 <20200607185732.GA18906@paulmck-ThinkPad-P72>
 <20200609154016.GA17196@paulmck-ThinkPad-P72>
 <20200613024829.GA12958@paulmck-ThinkPad-P72>
 <87ftazctov.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftazctov.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 09:26:40AM +0200, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > And an update based on your patch (https://paste.debian.net/1151802/)
> > against 44ebe016df3a ("Merge branch 'proc-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace").
> 
> I'm running this patch since midnight on top of x86/entry. Still no NULL
> pointer deref.
> 
> The cross-check with plain x86/entry has triggered it on all instances
> by now.

That is consistent with my experience.  I have not yet see a NULL pointer
dereference with Peter's patch.  As I said earlier, tests thus far
at my end give 95% confidence that it is a fix for the NULL pointer
problem.

I have seen two other problems, but I haven't yet see them often enough
to have any confidence as to what they are related to.  The RCU CPU
stall warning happened only once, so it might have been introduced in
mainline sometime in the last few days.  The BUG was with Peter's patch
on an intermediate state of x86/entry, so it might be specific to that
intermediate state.  Or to my commit/patch confusion, perhaps.

> So it looks your up to something here.

Let's recap.

I ran 140 hours each of TREE04 and TREE05 with Peter's patch on top of
x86/entry in -tip with no complaints of any kind.  So that is good,
and it means we have a good fix for the too-short grace periods.
I already verified TASKS03 yesterday (not to be confused with TREE03).
So we have a clean bill of health for x86/entry from my end with respect
to too-short grace periods with insanely high confidence.

I have started 28*TREE03 for a few hours with Peter's patch on top
of x86/entry in -tip, which I expect will reproduce your result of
no NULL pointer.  If so (as I fully expect it to), I will join you in
proclaiming Peter's patch to be a fix for the NULL pointer problem.

Then I follow up on https://paste.debian.net/1151842 and also on
https://paste.debian.net/1151809.

First, I run TREE03 longer on 44ebe016df3a ("Merge branch 'proc-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
in mainline without Peter's patch ignoring any occurrences of the NULL
pointer problem to see what happens.  If that reproduces the RCU CPU
stall in https://paste.debian.net/1151842 or the BUG on line 1046 of
kernel/sched/rt.c in https://paste.debian.net/1151809, I will attempt
to bisect those in mainline.

If neither of those two reproduce, on to other things.

Seem reasonable?

							Thanx, Paul

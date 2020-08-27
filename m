Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7CFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5C220786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rxpZxBFK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YtH6D4l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgH0HxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgH0HxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:53:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AFAC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:53:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yzbJxJmvrprBUBklV/gmOhK78hj3XpUYafHb2YG97No=;
        b=rxpZxBFKoKj+7Fh3b/AWNDpwKTthubAQ8q2pSGRnwFsPW0EUuJGtqWrJWf72fARfB/teOJ
        vr+uELb5c0rVzGckI6HPLqtgGGVsUdsDke6+0VhecbLlXz8fT3l7gH3cgD1jSWdiCMAY1f
        pYkSo0btl2WsKAlmEpkSt8AR9JTNzc81cVwrLvz29WTywncaxChQqWZy27ofiLpmonZK5X
        GrYqPUx5II/QkZJbjSSOoYxiRwUZMDRltWBC/3M+sITrPqWV7kthKWT913xMS1ie6VzmL/
        qxv26ydSAOdipxmzNzAFAZ3Rz7IAMuIuFeS6yMPMoHrHrZGk89wD+7rPiND22A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yzbJxJmvrprBUBklV/gmOhK78hj3XpUYafHb2YG97No=;
        b=YtH6D4l/oWSejMNR88grPMD9UqLNZuxPohmv+wCs6HOLo+etceyzggsd+uzgy7M6xl1Xlw
        UpxuecIB3+Fvq9Bg==
To:     peterz@infradead.org, Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        svens@linux.ibm.com
Subject: Re: [PATCH v2 03/11] sched,idle,rcu: Push rcu_idle deeper into the idle path
In-Reply-To: <20200827074748.GY2674@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org> <20200821085348.310943801@infradead.org> <20200827011826.GA1942571@google.com> <20200827012419.GB1942571@google.com> <20200827074748.GY2674@hirez.programming.kicks-ass.net>
Date:   Thu, 27 Aug 2020 09:53:20 +0200
Message-ID: <875z94le33.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27 2020 at 09:47, peterz wrote:
> On Wed, Aug 26, 2020 at 09:24:19PM -0400, Joel Fernandes wrote:
>> On Wed, Aug 26, 2020 at 09:18:26PM -0400, Joel Fernandes wrote:
>> > On Fri, Aug 21, 2020 at 10:47:41AM +0200, Peter Zijlstra wrote:
>> > > Lots of things take locks, due to a wee bug, rcu_lockdep didn't notice
>> > > that the locking tracepoints were using RCU.
>> > > 
>> > > Push rcu_idle_{enter,exit}() as deep as possible into the idle paths,
>> > > this also resolves a lot of _rcuidle()/RCU_NONIDLE() usage.
>> > > 
>> > > Specifically, sched_clock_idle_wakeup_event() will use ktime which
>> > > will use seqlocks which will tickle lockdep, and
>> > > stop_critical_timings() uses lock.
>> > 
>> > I was wondering if those tracepoints should just use _rcuidle variant of the
>> > trace call. But that's a terrible idea considering that would add unwanted
>> > overhead I think.
>> > 
>> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> 
>> BTW, if tracepoint is converted to use RCU-trace flavor, then these kinds of
>> issues go away, no? That RCU flavor is always watching.
>
> All trace_*_rcuidle() and RCU_NONIDLE() usage is a bug IMO.

It's the same problem as low level entry/exit. And that stuff is a hack
which papers over the problem instead of fixing it from ground up. But
we are talking about tracing, right?

Thanks,

        tglx

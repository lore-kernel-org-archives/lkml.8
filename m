Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0034B20855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o6aefiq8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ExvAX/Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgHFS6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:58:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:58:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596740309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eq5i7/DrPIRMT4jncK281CDEQ+oCIA5XaA6tD+TJQss=;
        b=o6aefiq84HrrzcnIFcl9KjHhfvAUfOhORytwU+6oU9pMiAndAiryDPOnotC+4xslC4wlSP
        aNKG5/isaQd941YnZKMCHPbRUBTYjWuqFjxcSYQHQ4Ay8yEMikJj6qCJG9bm9z+yfyfG6+
        aES/ohalCTTz3/L3Vr8ZBB+97ghv8XCa2WikKNiNG0k2qelcix1SovEgPxbu5DA8u5kk8j
        wbN585by6dy7UWCVhEG+CWeWwA87y3pItoYjprWrhs2lEr6UPOY+iGFLG+CaITuQBLY8Q9
        Ws9tJEXcpzlRfR9SxAhwpELzrEy/ZHqOEKDhwmZe+qbJ7+aK2zxLNTkgj15tFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596740309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eq5i7/DrPIRMT4jncK281CDEQ+oCIA5XaA6tD+TJQss=;
        b=ExvAX/UjbAXVzKraaL9FKnQ5AuwydIzTPeXuFvEvrQfRzXRZKO+YBJk1SU6WIHzE843oUW
        Nj/Q+wgZClZhDtAg==
To:     peterz@infradead.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <20200806114545.GA2674@hirez.programming.kicks-ass.net>
References: <873654m9zi.fsf@kurt> <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf> <87d047n4oh.fsf@nanos.tec.linutronix.de> <jhjh7tjivew.mognet@arm.com> <875z9zmt4i.fsf@nanos.tec.linutronix.de> <20200805134002.GQ2674@hirez.programming.kicks-ass.net> <jhja6z9i4bi.mognet@arm.com> <20200805153120.GU2674@hirez.programming.kicks-ass.net> <874kpgi025.fsf@nanos.tec.linutronix.de> <20200806114545.GA2674@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Aug 2020 20:58:26 +0200
Message-ID: <87mu37ha99.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

peterz@infradead.org writes:
> On Thu, Aug 06, 2020 at 11:41:06AM +0200, Thomas Gleixner wrote:
>> And that has nothing to do
>> with a silly test case. Sporadic runaways due to a bug in a once per
>> week code path simply can happen and having the safety net working
>> depending on a config option selected or not is just wrong.
>
> The safety thing is concerned with RT tasks. It doesn't pretend to help
> with runnaway IRQs, never has, never will.

Of course not. But without irq accounting the runtime is accounted on
the runaway task which causes it to throttle.

> The further extreme is an interrupt storm, those have always taken a
> machine down.

If every interrupt is actually handled, then yes.

> Accounting unrelated IRQ time to RT tasks is equally wrong, the task
> execution is unrelated to the IRQs. The config option at least offers
> insight into where time goes -- and it's a config option because doing
> time accounting on interrupts adds overhead :/

Right, but it's not totally out of the world either to make the
throttler do:

          if (rt_runtime + irq_time > threshold)
          	try_to_keep_the_box_alive()

> This really is a no-win all round.

That's not the question here :)

> The only 'sensible' option here is threaded IRQs, where the IRQ line
> gets disabled until the handler thread has ran, that also helps with IRQ
> storms.

I'm not against enforcing threaded IRQs. :)

Thanks,

        tglx

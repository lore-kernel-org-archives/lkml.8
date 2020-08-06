Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34AAC38152
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3FE22D0B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kN9sYWpF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MLXgfR34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgHFJhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgHFJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:34:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 02:34:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596706483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQkbKY9HMHdIDVxo57b/7ooYqvcFkMgq0/3YSoWs1eI=;
        b=kN9sYWpFBqxH8i+Q+XfIJ8K3gXFkwExErJzky6iYhLWWPcVa2Z+p+OkEvD+GisZSXAeaLZ
        /oJ9kuejzW+IncznugGgptjhxw1+7hzVMcsFt7Y1Oq4issSKGHiO8rU7Rs5jqhzql0diX2
        2oG3d8F9RifH6uyXVYIIZqNNKOuJmzgMFr7kSEomrSqabk5OASsk4BB+EN+HwRxo7IqWBZ
        zoRt4BEcLoNSg66M2m8QbTb2dRdkf7tE/7hJ4bjWqnvjmFwRE7dmSMQT6GFb35Fxk9YSpH
        n8j4k/ev4EXmFfg2P1UeeSmzVNT1JD2pVHXwXZN5cCxzYfIGBmWpyeLkIjCxzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596706483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQkbKY9HMHdIDVxo57b/7ooYqvcFkMgq0/3YSoWs1eI=;
        b=MLXgfR34ZN2c7p471X0+h9DeZYNO1M5vJ4NsJRZZh/+fSvjbiWc5sKSQu+R2OqaUwHFJ4S
        b72tNLPsH2m+vSBA==
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
In-Reply-To: <20200805134002.GQ2674@hirez.programming.kicks-ass.net>
References: <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf> <87d047n4oh.fsf@nanos.tec.linutronix.de> <jhjh7tjivew.mognet@arm.com> <875z9zmt4i.fsf@nanos.tec.linutronix.de> <20200805134002.GQ2674@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Aug 2020 11:34:42 +0200
Message-ID: <877duci0ct.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peterz@infradead.org writes:
> On Mon, Aug 03, 2020 at 09:22:53PM +0200, Thomas Gleixner wrote:
>
>>    totaltime = irqtime + tasktime
>> 
>> Ignoring irqtime and pretending that totaltime is what the scheduler
>> can control and deal with is naive at best.
>
> Well no, that's what we call system overhead and is assumed to be
> included in the 'error margin'.
>
> The way things are set up is that we say that, by default, RT tasks can
> consume 95% of cputime and the remaining 5% is sufficient to keep the
> system alive.
>
> Those 5% include all system overhead, IRQs, RCU, !RT workqueues etc..
>
> Obviously IRQ_TIME accounting changes the balance a bit, but that's what
> it is. We can't really do anything better.
>
> Apparently this SoC has significant IRQ time for some reason. Also,
> relying on RT throttling for 'correct' behaviour is also wrong. What
> needs to be done is find who is using all this RT time and why, that
> isn't right.

It's a test case and we know already who is using the time. But that's
not the point.

A runaway RT task resulting in a RCU stall or whatever lockup of the
system is definitely not the right answer.

The throttler, as much as it's a horrible hack, is there to prevent this
and to give the admin a chance to pinpoint and kill that thing instead
of having to press the reset button and scratching head what might have
caused this.

Thanks,

        tglx

Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668C623119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mN0bUej5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgHFRZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbgHFRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:03:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D474CC0617B1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mb6Pcn8GA5zfSJfRuHB/gTx/1/FB8gTP4+5zdNlmjw4=; b=mN0bUej55+bDD24xUR681m+tcG
        ZB+jUoAwwJi6Gl04PymXuUnXRU+GAYQndtdvwKjFt78vP+XYFznahcCJZydD337JRLxZHyYXoy9Jk
        GQzh7jleA1wnTGkCGKk5Ekch+iU0Vxm2YhVSnub0AGBvR70dx0+7r4UN2b+wghZI3LXy8LPvy6oOn
        RG4w9ujsEHcqSiC/iNVhVjJuChPM1kCFrs3k4L7mJQ6u2woPIMyznJ59SW8wMI0RfyBfyoBTslya9
        vLGoz7GUsA3GKoT03uk0SZthK0XrevlLBEcB2RyH9Nv4QTNz/OWuCIslqGHMXa7OIMot3719dAmbr
        3xZ3HOcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3eLC-0006pL-Cf; Thu, 06 Aug 2020 11:45:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AECBF301A66;
        Thu,  6 Aug 2020 13:45:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CCD2220F91B8; Thu,  6 Aug 2020 13:45:45 +0200 (CEST)
Date:   Thu, 6 Aug 2020 13:45:45 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200806114545.GA2674@hirez.programming.kicks-ass.net>
References: <873654m9zi.fsf@kurt>
 <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
 <20200803114112.mrcuupz4ir5uqlp6@skbuf>
 <87d047n4oh.fsf@nanos.tec.linutronix.de>
 <jhjh7tjivew.mognet@arm.com>
 <875z9zmt4i.fsf@nanos.tec.linutronix.de>
 <20200805134002.GQ2674@hirez.programming.kicks-ass.net>
 <jhja6z9i4bi.mognet@arm.com>
 <20200805153120.GU2674@hirez.programming.kicks-ass.net>
 <874kpgi025.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kpgi025.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:41:06AM +0200, Thomas Gleixner wrote:
> peterz@infradead.org writes:
> > On Wed, Aug 05, 2020 at 02:56:49PM +0100, Valentin Schneider wrote:
> >
> >> I've been tempted to say the test case is a bit bogus, but am not familiar
> >> enough with the RT throttling details to stand that ground. That said, from
> >> both looking at the execution and the stress-ng source code, it seems to
> >> unconditionally spawn 32 FIFO-50 tasks (there's even an option to make
> >> these FIFO-99!!!), which is quite a crowd on monoCPU systems.
> >
> > Oh, so it's a case of: we do stupid without tuning and the system falls
> > over. I can live with that.
> 
> It's not a question of whether you can live with that behaviour for a
> particular silly test case.
> 
> The same happens with a single RT runaway task with enough interrupt
> load on a UP machine. Just validated that. 

Of course.

> And that has nothing to do
> with a silly test case. Sporadic runaways due to a bug in a once per
> week code path simply can happen and having the safety net working
> depending on a config option selected or not is just wrong.

The safety thing is concerned with RT tasks. It doesn't pretend to help
with runnaway IRQs, never has, never will.

The further extreme is an interrupt storm, those have always taken a
machine down.

Accounting unrelated IRQ time to RT tasks is equally wrong, the task
execution is unrelated to the IRQs. The config option at least offers
insight into where time goes -- and it's a config option because doing
time accounting on interrupts adds overhead :/

This really is a no-win all round.

The only 'sensible' option here is threaded IRQs, where the IRQ line
gets disabled until the handler thread has ran, that also helps with IRQ
storms.

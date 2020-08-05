Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C593C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0333122D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o4UNyU+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHEQvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgHEQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA28C0A8884
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=llIYIkPywN6VGT1iqwpwmXkEgVsOT9bHfxBPZgYYoF8=; b=o4UNyU+E39IT4QDuCejLtxHLZI
        thdkTL4uS6ye9ug0ZJAGEmJ0+HVj6nrHtSXGzb+yMCXvbi/09nQDQiaqX4t104slsVHrykO/7ISsd
        +6OxjB6CNIi/9ssmDwqJa26GxYwv9V7XJUr+LzsEHFrPXMqJHmPLnVBf5WZeAz4es1lhzJ/9Wj4E8
        TmSoIAKMxdvUUF1HQh7o3iKtENypMXYi7ybnFfBJlZqG810rPcmTz0BcPWNmn9RaKzBOMoptwU1sD
        chpgZFLM2FhVXGe0Pgz8MspmVNYmSqfy48HzxRysKF+6sUYZEHG8zfd7MHG7WVmnC2s56MQ/m6Rxp
        FOFRijbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3JeK-0005Gc-Uv; Wed, 05 Aug 2020 13:40:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CA653012DC;
        Wed,  5 Aug 2020 15:40:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6BBF22B957C1; Wed,  5 Aug 2020 15:40:02 +0200 (CEST)
Date:   Wed, 5 Aug 2020 15:40:02 +0200
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
Message-ID: <20200805134002.GQ2674@hirez.programming.kicks-ass.net>
References: <877dumbtoi.fsf@kurt>
 <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
 <87mu3ho48v.fsf@kurt>
 <20200730082228.r24zgdeiofvwxijm@skbuf>
 <873654m9zi.fsf@kurt>
 <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
 <20200803114112.mrcuupz4ir5uqlp6@skbuf>
 <87d047n4oh.fsf@nanos.tec.linutronix.de>
 <jhjh7tjivew.mognet@arm.com>
 <875z9zmt4i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z9zmt4i.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 09:22:53PM +0200, Thomas Gleixner wrote:

>    totaltime = irqtime + tasktime
> 
> Ignoring irqtime and pretending that totaltime is what the scheduler
> can control and deal with is naive at best.

Well no, that's what we call system overhead and is assumed to be
included in the 'error margin'.

The way things are set up is that we say that, by default, RT tasks can
consume 95% of cputime and the remaining 5% is sufficient to keep the
system alive.

Those 5% include all system overhead, IRQs, RCU, !RT workqueues etc..

Obviously IRQ_TIME accounting changes the balance a bit, but that's what
it is. We can't really do anything better.

Apparently this SoC has significant IRQ time for some reason. Also,
relying on RT throttling for 'correct' behaviour is also wrong. What
needs to be done is find who is using all this RT time and why, that
isn't right.

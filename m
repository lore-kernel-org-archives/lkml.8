Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8175CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5349A20716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597049985;
	bh=+h0jVAw0Ac+kzUhkllfCSb8arpMRjvaU4CdD1FZmMuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uc0RoJWtHZbm22YixGOf4irt0cE9lENskut9gvCrbKjeQclabOGsxH1qNe6YoHCYz
	 ZeoMdvtLN//e2sGH1Hfn9k/QUILmA25k2+xi7OND2KJnvx+78ESP4Wqm3Wh8ZL+ghL
	 mLBwvnMCgpK5c2uol5G+yLmnYKlmg/MZDKVGJ9FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgHJI7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgHJI7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:59:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 642C52070B;
        Mon, 10 Aug 2020 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597049983;
        bh=+h0jVAw0Ac+kzUhkllfCSb8arpMRjvaU4CdD1FZmMuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwpDo6U3D7lCpRP/91k5IAXWSj8UkojpuoxzsA5uoq91JjzIa4ZUiFz7PAF+monFu
         O11YG+ZmJLp90zKRiLfmBH851UR8jurtARX8NMQgSfN2Fn6d1Ei61TvTvO+qEt7DaC
         Fk/z0BVV2IWvJ62dVodercapAvjBPQ97p4puEdeY=
Date:   Mon, 10 Aug 2020 10:59:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/24] seqlock: lockdep assert non-preemptibility on
 seqcount_t write
Message-ID: <20200810085954.GA1591892@kroah.com>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-9-a.darwish@linutronix.de>
 <20200808232122.GA176509@roeck-us.net>
 <20200809184251.GA94072@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809184251.GA94072@lx-t490>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 08:42:51PM +0200, Ahmed S. Darwish wrote:
> On Sat, Aug 08, 2020 at 04:21:22PM -0700, Guenter Roeck wrote:
> > On Mon, Jul 20, 2020 at 05:55:14PM +0200, Ahmed S. Darwish wrote:
> > > Preemption must be disabled before entering a sequence count write side
> > > critical section.  Failing to do so, the seqcount read side can preempt
> > > the write side section and spin for the entire scheduler tick.  If that
> > > reader belongs to a real-time scheduling class, it can spin forever and
> > > the kernel will livelock.
> > >
> > > Assert through lockdep that preemption is disabled for seqcount writers.
> > >
> >
> > This patch is causing compile failures for various images (eg arm:allmodconfig,
> > arm:imx_v6_v7_defconfig, mips:allmodconfig).
> >
> > In file included from arch/arm/include/asm/bug.h:60,
> >                  from include/linux/bug.h:5,
> >                  from include/linux/thread_info.h:12,
> >                  from include/asm-generic/current.h:5,
> >                  from ./arch/arm/include/generated/asm/current.h:1,
> >                  from include/linux/sched.h:12,
> >                  from arch/arm/kernel/asm-offsets.c:11:
> > include/linux/seqlock.h: In function 'write_seqcount_begin_nested':
> > include/asm-generic/percpu.h:31:40: error: implicit declaration of function 'raw_smp_processor_id'
> >
> > Reverting it fixes the problem. Is this being addressed ?
> >
> 
> @Peter, I think let's revert this one for now?

Please do, it's blowing up my local builds as well :(

thanks,

greg k-h

Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B68C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4766B206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgELKB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:01:29 -0400
Received: from foss.arm.com ([217.140.110.172]:51426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELKB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:01:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BF391FB;
        Tue, 12 May 2020 03:01:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.28.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E94313F71E;
        Tue, 12 May 2020 03:01:23 -0700 (PDT)
Date:   Tue, 12 May 2020 11:01:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: perf_event: Fix time offset prior to epoch
Message-ID: <20200512100114.GA60359@C02TD0UTHF1T.local>
References: <20200505135544.6003-1-leo.yan@linaro.org>
 <20200511092200.GF2957@hirez.programming.kicks-ass.net>
 <20200511092519.GA3001@hirez.programming.kicks-ass.net>
 <20200512063812.GA20352@leoy-ThinkPad-X240s>
 <20200512091918.GH2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512091918.GH2978@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:19:18AM +0200, Peter Zijlstra wrote:
> On Tue, May 12, 2020 at 02:38:12PM +0800, Leo Yan wrote:
> > @@ -1165,28 +1166,26 @@ device_initcall(armv8_pmu_driver_init)
> >  void arch_perf_update_userpage(struct perf_event *event,
> >  			       struct perf_event_mmap_page *userpg, u64 now)
> >  {
> > +	struct clock_read_data *rd;
> > +	unsigned int seq;
> >  
> >  	/*
> >  	 * Internal timekeeping for enabled/running/stopped times
> >  	 * is always computed with the sched_clock.
> >  	 */
> >  	userpg->cap_user_time = 1;
> > +	userpg->cap_user_time_zero = 1;
> >  
> > +	do {
> > +		rd = sched_clock_read_begin(&seq);
> > +
> > +		userpg->time_mult = rd->mult;
> > +		userpg->time_shift = rd->shift;
> > +		userpg->time_zero = rd->epoch_ns;
> > +
> > +		userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;
> 
> Damn, I think this is broken vs the counter wrapping.
> 
> So what the sched_clock code does is:
> 
> 	cyc_to_ns((cyc - rd->epoch_cyc) & rd->sched_clock_mask, rd->mult, rd->shift)
> 
> But because the perf interface assumes a simple linear relation, we
> can't express that properly.
> 
> Now, your arm64 counter is 56 bits, so wrapping is rare, but still, we
> should probably fix that. And that probably needs an ABI extention
> *sigh*.

FWIW, its's /at least/ 56 bits wide, and the ARM ARM says that it
shouldn't wrap in fewer than 40 years, so no correct implementation
should wrap before the 2050s.

If it's wider than 56 bits, the 56-bit portion could wrap more quickly
than that, so we should probably always treat it as 64-bits.

From ARMv8.6 it's always 64 bits wide @ a nominal 1GHz, and a 64-bit
wrap will take ~584.9 years (with a 56-bit wrap taking ~834 days).

See D11.1.2 "The system counter" in the latest ARM ARM (0487F.b):

https://static.docs.arm.com/ddi0487/fb/DDI0487F_b_armv8_arm.pdf?_ga=2.83012310.1749782910.1589218924-1447552059.1588172444

https://developer.arm.com/docs/ddi0487/latest

Thanks,
Mark.

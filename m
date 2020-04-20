Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D93C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5039E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KxVEIELJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDTRC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTRC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:02:28 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B27C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k28rFF1aTcCuYw7F0NCXVX98o1FH/69yQlo98AqotUQ=; b=KxVEIELJ8vx2GpPVRy5cRF/cML
        1Y8FiqyLj/fdjcmLhcxaURlyKbedo1blRlxGjZR5Pz0uizNuNQCQ4uwPPMrx0AckbbZ8rWGxqxmWo
        KGnqk95lXpknK2scAn+1U3igIFZnudEZJwocgUWTIgawTWikkXCw3Q3zAEFZoBAOwd1Jb+1/L++Io
        qR5rlRnt2ZkbUovfp7aN9nUQ789TpEqsD5bT2qExSKgwg5PjKLYNpIZtNCaf1PZXqK+Ku4jtbmKhH
        P7xek5I6JrEAg5ngmpVjygngziFRM6uA1T+Jmkx7ER0glor8/U3ZewnzbFBhq9aCG9335VjGb7gmi
        9x7pUjTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQZo6-0003nB-0S; Mon, 20 Apr 2020 17:02:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 940D93010C4;
        Mon, 20 Apr 2020 19:02:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 794FC2B9DD27F; Mon, 20 Apr 2020 19:02:03 +0200 (CEST)
Date:   Mon, 20 Apr 2020 19:02:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V5 RESEND 00/14] TopDown metrics support for Icelake
Message-ID: <20200420170203.GL20730@hirez.programming.kicks-ass.net>
References: <20200106202919.2943-1-kan.liang@linux.intel.com>
 <20200110131749.GD2827@hirez.programming.kicks-ass.net>
 <CABPqkBTSwoCOt_pOQvX4qSTy6D5DKYvZVXJd66Vf=2mGVsOpvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTSwoCOt_pOQvX4qSTy6D5DKYvZVXJd66Vf=2mGVsOpvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:00:56AM -0700, Stephane Eranian wrote:
> Hi,
> 
> On Fri, Jan 10, 2020 at 5:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jan 06, 2020 at 12:29:05PM -0800, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > >
> > > Icelake has support for measuring the level 1 TopDown metrics
> > > directly in hardware. This is implemented by an additional METRICS
> > > register, and a new Fixed Counter 3 that measures pipeline SLOTS.
> > >
> > > New in Icelake
> > > - Do not require generic counters. This allows to collect TopDown always
> > >   in addition to other events.
> > > - Measuring TopDown per thread/process instead of only per core
> > >
> > > For the Ice Lake implementation of performance metrics, the values in
> > > PERF_METRICS MSR are derived from fixed counter 3. Software should start
> > > both registers, PERF_METRICS and fixed counter 3, from zero.
> > > Additionally, software is recommended to periodically clear both
> > > registers in order to maintain accurate measurements. The latter is
> > > required for certain scenarios that involve sampling metrics at high
> > > rates. Software should always write fixed counter 3 before write to
> > > PERF_METRICS.
> >
> > Do we really have to support this trainwreck? This is such ill designed
> > hardware, I'm loath to support it, it might encourage more such
> > 'creative' things and we really don't need that.
> >
> Yes, we do because it provides important information per hyper-thread.
> 
> I understand that the hardware is convoluted to support because it
> introduces a new concept: a single counter computing multiple high
> level metrics. It is difficult to abstract cleanly especially when you
> add on top that it is connected with a new fixed counter (SLOTS).

It's not a new concept, it's just completely idiotic. It didn't need to
be this crazy. There is absolutely no sane reason for it to be this
crazy.

The 4 counters in a single msr thing is insane because it uses a
division.

Very much worse, it explicitly uses the exact value of another counter
(SLOTS) to drive that division, creating a tight coupling between the
registers and completely and utterly destroying the SLOTS counter.

Since it keeps internal 'shadow' counters for the 4 events anyway, it
might as well have kept a shadow counter for the SLOTS event and driven
it off of that, that would have kept the SLOTS counter sane, but nooo,
gotta wreck that.

> That also helps the kernel with a single WRMSR/RDMSR for all 4 metrics.

I also really don't buy that as a driver for all this insanity.
Optimizing MSRs to not be utterly stupid expensive would've been so much
saner and would've helped everyone.

This is just creating more wreckage.

What I really want to know is if future hardware is going to be as
stupid; or if there's going to be change. I really don't want to commit
to ABI here and then have to find out they fixed the hardware and we
can't do sane things anymore.

Obviously, future hardware is not something that is to be discussed, so
we're at a stand-still here.

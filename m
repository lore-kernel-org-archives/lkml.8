Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734FFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5155020760
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iRcqbhoo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XvgIcEpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgGOJXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:23:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49896 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgGOJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:23:49 -0400
Date:   Wed, 15 Jul 2020 11:23:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594805027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nVewUEkE+vEgqvpSZaR+rHv9rvICaRBJ6Hc/Y4Gfv04=;
        b=iRcqbhooQLbNQYs0t6EgUxItIJxhtP3b8s8woTQvVERuHgCybkfAetFUIzEPA2qoDta3XB
        hFGfqNFUsu3hRGjuhAphrutMLv6knCYWsKZM43Mb3AYZHtaVSpWCf9rN/cvu+IehElTs6w
        w7jkCecMreibSzUAgIGJ2NVV3RoeZlRT8WDBS9NXru7YSKwOWLV7KNvaQtm77bvWFv6rIw
        Tmf674X1SQV4U6ysvZST8Y6X5/9VyE6jietFR2lRK9R/Fnv4Xy0+oqlSKZzC+OAamfCMpL
        S6AUQbGmozxbFDdI/qPyin9SrTMah7JNfk2r2V4MAlBnzEXS+gnSSHhpJVaY6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594805027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nVewUEkE+vEgqvpSZaR+rHv9rvICaRBJ6Hc/Y4Gfv04=;
        b=XvgIcEpx3pM+hW2dYCP5H7sBCeEboYeXT2fgmDCQ3cwOqyeGO6r/T+NNo/0VBxbVQMqjLC
        G1W0Dhzx1t3IK1CQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, jogness@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sched_clock: Expose struct clock_read_data
Message-ID: <20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-2-leo.yan@linaro.org>
 <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
 <20200715081222.GB10769@hirez.programming.kicks-ass.net>
 <20200715081443.GB43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715081443.GB43129@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:14:43AM +0200, peterz@infradead.org wrote:
> On Wed, Jul 15, 2020 at 10:12:22AM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 15, 2020 at 07:56:50AM +0200, Ahmed S. Darwish wrote:
> > > On Wed, Jul 15, 2020 at 10:05:07AM +0800, Leo Yan wrote:
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > ...
> > > >
> > > > Provide struct clock_read_data and two (seqcount) helpers so that
> > > > architectures (arm64 in specific) can expose the numbers to userspace.
> > > >
> > > ...
> > > >
> > > > +struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > > > +{
> > > > +	*seq = raw_read_seqcount(&cd.seq);
> > > > +	return cd.read_data + (*seq & 1);
> > > > +}
> > > > +
> > > ...
> > >
> > > Hmm, this seqcount_t is actually a latch seqcount. I know the original
> > > code also used raw_read_seqcount(), but while at it, let's use the
> > > proper read API for seqcount_t latchers: raw_read_seqcount_latch().
> > >
> > > raw_read_seqcount_latch() has no read memory barrier though, and a
> > > suspicious claim that READ_ONCE() pairs with an smp_wmb() (??). But if
> > > its implementation is wrong, let's fix it there instead.
> >
> > It's supposed to be a dependent load, so READ_ONCE() is sufficient.
> > Except, of course, the C standard has other ideas, so a compiler is
> > allowed to wreck that, but they mostly don't :-)
>
> Also see:
>
>   https://lkml.kernel.org/r/20200625085745.GD117543@hirez.programming.kicks-ass.net

Oh, spot on.

Can we then please replace the raw_read_seqcount(), in the original
patch which started this discussion, with raw_read_seqcount_latch()?

I see that you already did something similar for timekeeping.c:
7fc26327b756 ("seqlock: Introduce raw_read_seqcount_latch()").

Confession time: I have an internal patch series which introduces
seqcount_latch_t. Having a standardized set of accessors for the
seqcount latch read and write paths will make everything much more
streamlined :-)

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450AAC433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B14206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WDM6G+e3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgGOIMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGOIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:12:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA1C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uIbsP/4TYly3s1yM2udDpP8+Cyz0hKhcZJeKlcvBJuk=; b=WDM6G+e3sdPiUF/AmrUJIJV3nB
        Em9bl3v37rjrGJg6zrkIMhypVtr/gPqFDB6lk22NQPCqkmDUfVR6BgEJfc356XMSC+8DbuS6CdqCF
        N+hElOSoEl15nGYKOwUS4zvDmIqh4C2GhmPn2lu/7lGAfQJEO0aiHG2MqoiwwSDYacHj/Gh6Y4Eer
        smqFoQg6EuzilNj07sEc0hMMM4TXl4me9K07bqcBCzUAxcBKzlh5mSGDs7BuzBfdBYUTNHHwbZSIb
        cD8dej86nVQZntgoOYwE1aJXbSw5VvMp9fXGdzk/Gu1as0TSpGUcOL30/gRZQCGSxWHZRnBfikAEs
        S6d9pUYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvcWg-0000g6-IQ; Wed, 15 Jul 2020 08:12:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D120D300446;
        Wed, 15 Jul 2020 10:12:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B73D423648704; Wed, 15 Jul 2020 10:12:22 +0200 (CEST)
Date:   Wed, 15 Jul 2020 10:12:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
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
Message-ID: <20200715081222.GB10769@hirez.programming.kicks-ass.net>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-2-leo.yan@linaro.org>
 <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:56:50AM +0200, Ahmed S. Darwish wrote:
> On Wed, Jul 15, 2020 at 10:05:07AM +0800, Leo Yan wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> ...
> >
> > Provide struct clock_read_data and two (seqcount) helpers so that
> > architectures (arm64 in specific) can expose the numbers to userspace.
> >
> ...
> >
> > +struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > +{
> > +	*seq = raw_read_seqcount(&cd.seq);
> > +	return cd.read_data + (*seq & 1);
> > +}
> > +
> ...
> 
> Hmm, this seqcount_t is actually a latch seqcount. I know the original
> code also used raw_read_seqcount(), but while at it, let's use the
> proper read API for seqcount_t latchers: raw_read_seqcount_latch().
> 
> raw_read_seqcount_latch() has no read memory barrier though, and a
> suspicious claim that READ_ONCE() pairs with an smp_wmb() (??). But if
> its implementation is wrong, let's fix it there instead.

It's supposed to be a dependent load, so READ_ONCE() is sufficient.
Except, of course, the C standard has other ideas, so a compiler is
allowed to wreck that, but they mostly don't :-)

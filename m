Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7702C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C244B20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588688351;
	bh=P3dVZ6HHUBjc/qORlz0QU3njyZSqdafXLPZfhjOru0M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=anKgD4AI3jFAziCxCp8SEVQ085PgevEWAEDyGJFfTyFi5+euShtGTalhb/U2WWtv+
	 rG+nUOyqCxOpqORcJYeQjoncaIivUnGVQ2mH1ZzfU4rIHHgOpTbOtv2eClQyQvZ83I
	 acgGYLk6TXUhIO2lcoCb9jtG/mat+OzVDVE7Gz8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgEEOQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgEEOQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ADCE2084D;
        Tue,  5 May 2020 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588688177;
        bh=P3dVZ6HHUBjc/qORlz0QU3njyZSqdafXLPZfhjOru0M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TrSglO9HXHB70ltVjy4tDjvxtMsSqJ5r1RT8TygcRq/Ym7C8yePe5HIhWZtuj9n2b
         H/dpJMqzQFEi2iEIZiCmxJZdau9WM6mDFwgOR/QwtJQtPL1uxg4edyH+QBC3S4LxxR
         lflL8REbfBusTNZbaxoVHb8oPbkeChrE9S4BN1Ug=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 38A4F3521001; Tue,  5 May 2020 07:16:17 -0700 (PDT)
Date:   Tue, 5 May 2020 07:16:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Add test suite
Message-ID: <20200505141617.GY2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200427143507.49654-1-elver@google.com>
 <CANpmjNOv7VXv9LtWHWBx1-an+1+WxjtzDNBF+rKsOm+ybmvwog@mail.gmail.com>
 <CABVgOSnr8CX5tN9u_wafxSiyyVcM9nL_nX2ufrSdRi=jdWjerg@mail.gmail.com>
 <CANpmjNMhVcR6TiLv29HqSvVVurUMwtHiokodPyzvwFSeE6UpZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMhVcR6TiLv29HqSvVVurUMwtHiokodPyzvwFSeE6UpZw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:01:45PM +0200, Marco Elver wrote:
> On Tue, 5 May 2020 at 07:00, David Gow <davidgow@google.com> wrote:
> >
> > On Mon, Apr 27, 2020 at 11:23 PM 'Marco Elver' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > >
> > > On Mon, 27 Apr 2020 at 16:35, Marco Elver <elver@google.com> wrote:
> > > >
> > > > This adds KCSAN test focusing on behaviour of the integrated runtime.
> > > > Tests various race scenarios, and verifies the reports generated to
> > > > console. Makes use of KUnit for test organization, and the Torture
> > > > framework for test thread control.
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > >
> > > +KUnit devs
> > > We had some discussions on how to best test sanitizer runtimes, and we
> > > believe that this test is what testing sanitizer runtimes should
> > > roughly look like. Note that, for KCSAN there are various additional
> > > complexities like multiple threads, and report generation isn't
> > > entirely deterministic (need to run some number of iterations to get
> > > reports, may get multiple reports, etc.).
> >
> > Thanks very much for writing the test. I do think that it goes a
> > little outside what we'd normally expect of a unit test (notably with
> > the issues around determinism and threading), but it's good to see
> > KUnit being pushed in new directions a bit.
> >
> > The biggest issue in my mind is the possibility that the
> > non-determinism of the tests could cause false positives. If we're
> > trying to run as many KUnit tests as possible as part of continuous
> > integration systems or as a condition for accepting patches, having
> > flaky tests could be annoying. The KCSAN tests seem to break/fail
> > as-is when run on single-core machines (at least, under qemu), so some
> > way of documenting this as a requirement would probably be necessary,
> > too.
> 
> True. Although note that we require CONFIG_KCSAN=y for this test to be
> enabled, so I don't think it's a big problem for a regular CI setups.
> For a KCSAN setup, I'd expect that we know that running on a
> single-core system doesn't yield much interesting results regardless
> of tests being run.
> 
> The non-deterministic nature of concurrent tests will never entirely
> go away, but I think with the right preconditions met (at least N
> CPUs, where N depends on PREEMPT_NONE, PREEMPT_VOLUNTARY or PREEMPT)
> the tests here should not normally fail.
> 
> > One possibility would be to add support for "skipped" tests to KUnit
> > (the TAP specification allows for it), so that the KCSAN test could
> > detect cases where it's not reliable, and skip itself (leaving a note
> > as to why). In the short term, though, we'd absolutely need some
> > documentation around the dependencies for the test.
> 
> That would be nice. For the time being, I will add a precondition
> check to test_init(), and print a warning if the test needs to be
> skipped.
> 
> > (For the record, the failures I saw were all due to running under qemu
> > emulating as a uniprocessor/single-core machine: with
> > CONFIG_PREEMPT_VOLUNTARY, it would just hang after creating the first
> > couple of threads. With CONFIG_PREEMPT, the tests completed, but the
> > majority of them failed.)
> 
> Right, let me try to fix those at least. I'll send v2.
> 
> (Paul: If you prefer a separate patch rather than v2, let me know.)

A v2 would work well, thank you!

							Thanx, Paul

> > > The main thing, however, is that we want to verify the actual output
> > > (or absence of it) to console. This is what the KCSAN test does using
> > > the 'console' tracepoint. Could KUnit provide some generic
> > > infrastructure to check console output, like is done in the test here?
> > > Right now I couldn't say what the most useful generalization of this
> > > would be (without it just being a wrapper around the console
> > > tracepoint), because the way I've decided to capture and then match
> > > console output is quite test-specific. For now we can replicate this
> > > logic on a per-test basis, but it would be extremely useful if there
> > > was a generic interface that KUnit could provide in future.
> >
> > This is something we've discussed here a couple of times as well.
> > While I'll confess to being a little bit wary of having tests rely too
> > heavily on console output: it risks being a bit fragile if the exact
> > contents or formatting of messages change, or ends up having a lot of
> > string formatting and/or parsing code in the tests. I do agree,
> > though, that it probably needs to be at least a part of testing things
> > like sanitizers where the ultimate goal is to produce console output.
> > I'm not exactly sure how we'd implement it yet, so it's probably not
> > going to happen extremely soon, but what you have here looks to me
> > like a good example we can generalise as needed.
> 
> The fragility due to formatting etc. for the sanitizers is exactly
> what we want, since any change in console output could be a bug. But
> as you say, for other tests, it might not make much sense.
> 
> Thanks,
> -- Marco

Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967DC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A3B2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588006173;
	bh=cGK5USlSVI+WhkX1qfyNm4MqOaOFLQJLMbJ62b/4oxw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gSdqgzol1EJVRiqQ9I8wWBiGYtxCxkdNvzulj0nz2V55uFdZ5VyroccW5K5aHYECu
	 zpnn3uOF+SYhHwfZxPOcX0kamIObT8ocNX+OTxaNlSA7RGRbk93XzJiTK2vTj0fij3
	 hmeovIgVTAXsxAnK8W4f4SYQWYMUKx2ZDYF8k4ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgD0Qtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgD0Qtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:49:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BEEA2080C;
        Mon, 27 Apr 2020 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588006171;
        bh=cGK5USlSVI+WhkX1qfyNm4MqOaOFLQJLMbJ62b/4oxw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c+phBkdhzVE7i8QZOqE9Lpni6t77kp2t6FsLoNiBQeUaJzZNOaZlVsbW5JgxNKZCH
         ZRDgkXaMBYAL1pfVLpuQcrPgnvzEyj6cE0m3k0Lp+m8TMOOIU7d2wZePBbeb7t+Kfp
         F4at1xkQo/c3W1K96x7BMBDuzYyyd3CTsCPzEgz8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 753AE35226DB; Mon, 27 Apr 2020 09:49:31 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:49:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Add test suite
Message-ID: <20200427164931.GF7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200427143507.49654-1-elver@google.com>
 <CANpmjNOv7VXv9LtWHWBx1-an+1+WxjtzDNBF+rKsOm+ybmvwog@mail.gmail.com>
 <20200427153744.GA7560@paulmck-ThinkPad-P72>
 <CANpmjNM7Aw7asb80OqZ0vmgQYY1SwM_Pnvf7ZHHvyFfsc6ZjmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM7Aw7asb80OqZ0vmgQYY1SwM_Pnvf7ZHHvyFfsc6ZjmQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 06:43:21PM +0200, Marco Elver wrote:
> On Mon, 27 Apr 2020 at 17:37, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Apr 27, 2020 at 05:23:23PM +0200, Marco Elver wrote:
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
> > >
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
> > >
> > > Thoughts?
> >
> > What I do in rcutorture is to run in a VM, dump the console output
> > to a file, then parse that output after the run completes.  For example,
> > the admittedly crude script here:
> >
> >         tools/testing/selftests/rcutorture/bin/parse-console.sh
> 
> That was on the table at one point, but discarded. We debated when I
> started this if I should do module + script, or all as one module.
> Here is some of the reasoning we went through, just for the record:
> 
> We wanted to use KUnit, to be able to benefit from all the
> infrastructure it provides. Wanting to use KUnit meant that we cannot
> have a 2-step test (module + script), because KUnit immediately prints
> success/fail after each test-case and doesn't run any external scripts
> (AFAIK). There are several benefits to relying on KUnit, such as:
> 1. Common way to set up and run test cases. No need to roll our own.
> 2. KUnit has a standardized way to assert, report test status,
> success, etc., which can be parsed by CI systems
> (https://testanything.org).
> 3. There are plans to set up KUnit CI systems, that just load and run
> all existing KUnit tests on boot. The sanitizer tests can become part
> of these automated test runs.
> 4. If KUnit eventually has a way to check output to console, our
> sanitizer tests will be simplified even further.
> 
> The other argument is that doing module + script is probably more complex:
> 1. The test would have to explicitly delimit test cases in a custom
> way, which a script could then extract.
> 2. We need to print the function names, and sizes + addresses of the
> variables used in the races, to then be parsed by the script, and
> finally match the access information.
> 3. Re-running the test without shutting down the system would require
> clearing the kernel log or some other way to delimit tests.
> 
> We'd still need the same logic, one way or another, to check what was
> printed to console. In the end, I came to the conclusion that it's
> significantly simpler to just have everything integrated in the
> module:
> 1. No need to delimit test cases, and parse based on delimiters. Just
> check what the console tracepoint last captured.
> 2. Can just refer to the functions, and variables directly and no need
> to parse this.
> 3. Re-running the test works out of the box.
> 
> Therefore, the conclusion is that for the sanitizers this is hopefully
> the best approach.

Fair enough!

Perhaps I should look into KUnit.  I don't recommend holding your breath
waiting, though, inertia being what it is.  ;-)

							Thanx, Paul

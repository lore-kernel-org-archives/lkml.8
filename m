Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3493C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A32206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1VfS4vL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgEENCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgEENCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:02:00 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF62C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:01:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k110so1543219otc.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTDmSdSSqcf0820VG99rQzpJRdzBGuHIvjHK4wifur4=;
        b=W1VfS4vLbNo4hkOmcN/TOW7+G6+F0HGJcgxZajW8aLnr7a4W8pMdMnAsrxO6bmkYaN
         RiSvDziF0EPJWi8s2CnNQCPLDYvXub5vlS0iyyqVg46YViUTd8xQv/HczUMcsLTi6n53
         zMuQIUnq7r9Hvui9mxKT8BC/7sUQbAACiFkdP3oBFOmm3/cHj+J9gAkp+D+Hin+aet8t
         13E08qHlgrlm4cbxg60L/PXRAtPbfz34i1b/68wVrJMH78ccNXu4vO30aRvZNwuIXSs0
         NpIlfUR0dYdYRA4GxdTq6Lkio6egrWAavavJulvPQUvBX4mEuSCpRrz4hJC19S+azglH
         7NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTDmSdSSqcf0820VG99rQzpJRdzBGuHIvjHK4wifur4=;
        b=Bhrw0lPyeZTbd8HHC/sE4qrfsYPFhgDpVkbk8a0Xu18f1PePP88oQwazi5CAisaEMl
         zOQu78m2ytGBOj+7fTMNdHr8YeZ59xI5NG8dlJTJH2Tv1jyocGqY1+d/d6s8mob9cAXx
         98Vl66Ky9Bw47c+hXUVcI6Xo54JMdxCID5KIXp/GIkscvku9DBxQ7MR/GXPO631HFuRG
         xwzz9+jXItJkeClBYplRQE/WYjFdIsLpq+MQd2f/hWPOLPrN8Za/7eETaEr0FqgcTWx7
         uOd07xHqiUYZGgnjHRwSbvswibaxrrBdvvP24f3n4ftJuBICHY58DUhWm+Z1jxc7jtQv
         kI2w==
X-Gm-Message-State: AGi0PubyO0lhyLGx5kWYN1y6b5Y9tBTCVwEtHumZs9DATHlWWBRQsIdP
        9FWaHL0q6GjOrO+Uc9Zb2Z19KDjooSwSonooD5USeg==
X-Google-Smtp-Source: APiQypLEX0FlPBpkpEeP7mu5mpBE41IHZlexbq9kwBDRRZyx8lXzqXNpuugfWUmNPoh6HHvOQsGH68OCoQ+u7GTeMkk=
X-Received: by 2002:a9d:412:: with SMTP id 18mr2181834otc.233.1588683716950;
 Tue, 05 May 2020 06:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200427143507.49654-1-elver@google.com> <CANpmjNOv7VXv9LtWHWBx1-an+1+WxjtzDNBF+rKsOm+ybmvwog@mail.gmail.com>
 <CABVgOSnr8CX5tN9u_wafxSiyyVcM9nL_nX2ufrSdRi=jdWjerg@mail.gmail.com>
In-Reply-To: <CABVgOSnr8CX5tN9u_wafxSiyyVcM9nL_nX2ufrSdRi=jdWjerg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 May 2020 15:01:45 +0200
Message-ID: <CANpmjNMhVcR6TiLv29HqSvVVurUMwtHiokodPyzvwFSeE6UpZw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Add test suite
To:     David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 07:00, David Gow <davidgow@google.com> wrote:
>
> On Mon, Apr 27, 2020 at 11:23 PM 'Marco Elver' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > On Mon, 27 Apr 2020 at 16:35, Marco Elver <elver@google.com> wrote:
> > >
> > > This adds KCSAN test focusing on behaviour of the integrated runtime.
> > > Tests various race scenarios, and verifies the reports generated to
> > > console. Makes use of KUnit for test organization, and the Torture
> > > framework for test thread control.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> >
> > +KUnit devs
> > We had some discussions on how to best test sanitizer runtimes, and we
> > believe that this test is what testing sanitizer runtimes should
> > roughly look like. Note that, for KCSAN there are various additional
> > complexities like multiple threads, and report generation isn't
> > entirely deterministic (need to run some number of iterations to get
> > reports, may get multiple reports, etc.).
>
> Thanks very much for writing the test. I do think that it goes a
> little outside what we'd normally expect of a unit test (notably with
> the issues around determinism and threading), but it's good to see
> KUnit being pushed in new directions a bit.
>
> The biggest issue in my mind is the possibility that the
> non-determinism of the tests could cause false positives. If we're
> trying to run as many KUnit tests as possible as part of continuous
> integration systems or as a condition for accepting patches, having
> flaky tests could be annoying. The KCSAN tests seem to break/fail
> as-is when run on single-core machines (at least, under qemu), so some
> way of documenting this as a requirement would probably be necessary,
> too.

True. Although note that we require CONFIG_KCSAN=y for this test to be
enabled, so I don't think it's a big problem for a regular CI setups.
For a KCSAN setup, I'd expect that we know that running on a
single-core system doesn't yield much interesting results regardless
of tests being run.

The non-deterministic nature of concurrent tests will never entirely
go away, but I think with the right preconditions met (at least N
CPUs, where N depends on PREEMPT_NONE, PREEMPT_VOLUNTARY or PREEMPT)
the tests here should not normally fail.

> One possibility would be to add support for "skipped" tests to KUnit
> (the TAP specification allows for it), so that the KCSAN test could
> detect cases where it's not reliable, and skip itself (leaving a note
> as to why). In the short term, though, we'd absolutely need some
> documentation around the dependencies for the test.

That would be nice. For the time being, I will add a precondition
check to test_init(), and print a warning if the test needs to be
skipped.

> (For the record, the failures I saw were all due to running under qemu
> emulating as a uniprocessor/single-core machine: with
> CONFIG_PREEMPT_VOLUNTARY, it would just hang after creating the first
> couple of threads. With CONFIG_PREEMPT, the tests completed, but the
> majority of them failed.)

Right, let me try to fix those at least. I'll send v2.

(Paul: If you prefer a separate patch rather than v2, let me know.)

> > The main thing, however, is that we want to verify the actual output
> > (or absence of it) to console. This is what the KCSAN test does using
> > the 'console' tracepoint. Could KUnit provide some generic
> > infrastructure to check console output, like is done in the test here?
> > Right now I couldn't say what the most useful generalization of this
> > would be (without it just being a wrapper around the console
> > tracepoint), because the way I've decided to capture and then match
> > console output is quite test-specific. For now we can replicate this
> > logic on a per-test basis, but it would be extremely useful if there
> > was a generic interface that KUnit could provide in future.
>
> This is something we've discussed here a couple of times as well.
> While I'll confess to being a little bit wary of having tests rely too
> heavily on console output: it risks being a bit fragile if the exact
> contents or formatting of messages change, or ends up having a lot of
> string formatting and/or parsing code in the tests. I do agree,
> though, that it probably needs to be at least a part of testing things
> like sanitizers where the ultimate goal is to produce console output.
> I'm not exactly sure how we'd implement it yet, so it's probably not
> going to happen extremely soon, but what you have here looks to me
> like a good example we can generalise as needed.

The fragility due to formatting etc. for the sanitizers is exactly
what we want, since any change in console output could be a bug. But
as you say, for other tests, it might not make much sense.

Thanks,
-- Marco

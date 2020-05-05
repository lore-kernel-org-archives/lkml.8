Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460BC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB39215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGKXoYze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEEFAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 01:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgEEFAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 01:00:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69703C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 22:00:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v4so1529682wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/sAhNPIx0HscGRab45ItFmjRECKgd522Fp745ex8GE=;
        b=XGKXoYze359c+5XOdEk6WT7XX+w6wPEz3HG905HvhGfXN0bQ6H5x54I8PEfo9/QHfU
         0bzZJ/JRBGEMB88okYT5RsNLSYRFb+b5I2dduD0uSvJ0dOOkocBhSbi4f2ng049X8bie
         WKl8G0Yzl8N/Lmnk4oNuV5D5UlNHpzhRtNzIPudeNjUZHyBMHTsRAEUP5cUd6hig03bg
         2zLlA2KbiKheH8YNLpYcjNZYUEhebaGA7mUslsTMPaaa5TZmD3aM7CJC275hcRcTRZWb
         +IFzi1ArOyRKlnUEVsifTAhF27LOymvn4JsWtkKrUIT3yQLakbEy+YxIB66ViiAUOmVp
         9gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/sAhNPIx0HscGRab45ItFmjRECKgd522Fp745ex8GE=;
        b=V22LwsFPmDprHfARRfcNF0LZxjg3FiKUYxD5zRUW5kUctTdxL3emTEr/DmtRdrjNay
         VFrXy3BM2S4rMlWBjI0d7zgyCPA6JKaGjbGMM4DOleo6kzk+p18KncSBz1Lq77C3cVRN
         2Ysk29VK8dg+Rdo0/bEV2aaQPxJqlXOSnWcZaC5ftCL66cQ42Eo1mqxHF3/m0ONDiDbV
         jm+1578P+S5lsWtJBBn221aZjI6tWsltnTL8HK+Lfousi82uUihKoJquGtXDkarfqYDI
         HTfepQZtRI8DdfBFgWHMDkzlQyOYWLzqBDP/WyD0VU+E15Dt0Qqke+jUV/H5sycyPmQh
         8zQA==
X-Gm-Message-State: AGi0PubmM7Fvm/GmWCeUVAsuJTyAGegOl3G78APrpdelN924wcL5ojG1
        pvFTp2hoLPTFlQCHakJWrIsJPvlgK8sVcVkw62FSBQ==
X-Google-Smtp-Source: APiQypLWMKznagpEwXMxR2+OqoyM73azT8xsaRANFBmuTUMpM45MOcl5f3e4AeiOqYQZHQlQ6R2lzN6tDac3V+xI+V4=
X-Received: by 2002:a05:600c:4096:: with SMTP id k22mr987224wmh.99.1588654799821;
 Mon, 04 May 2020 21:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200427143507.49654-1-elver@google.com> <CANpmjNOv7VXv9LtWHWBx1-an+1+WxjtzDNBF+rKsOm+ybmvwog@mail.gmail.com>
In-Reply-To: <CANpmjNOv7VXv9LtWHWBx1-an+1+WxjtzDNBF+rKsOm+ybmvwog@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 5 May 2020 12:59:47 +0800
Message-ID: <CABVgOSnr8CX5tN9u_wafxSiyyVcM9nL_nX2ufrSdRi=jdWjerg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Add test suite
To:     Marco Elver <elver@google.com>
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

On Mon, Apr 27, 2020 at 11:23 PM 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Mon, 27 Apr 2020 at 16:35, Marco Elver <elver@google.com> wrote:
> >
> > This adds KCSAN test focusing on behaviour of the integrated runtime.
> > Tests various race scenarios, and verifies the reports generated to
> > console. Makes use of KUnit for test organization, and the Torture
> > framework for test thread control.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
>
> +KUnit devs
> We had some discussions on how to best test sanitizer runtimes, and we
> believe that this test is what testing sanitizer runtimes should
> roughly look like. Note that, for KCSAN there are various additional
> complexities like multiple threads, and report generation isn't
> entirely deterministic (need to run some number of iterations to get
> reports, may get multiple reports, etc.).

Thanks very much for writing the test. I do think that it goes a
little outside what we'd normally expect of a unit test (notably with
the issues around determinism and threading), but it's good to see
KUnit being pushed in new directions a bit.

The biggest issue in my mind is the possibility that the
non-determinism of the tests could cause false positives. If we're
trying to run as many KUnit tests as possible as part of continuous
integration systems or as a condition for accepting patches, having
flaky tests could be annoying. The KCSAN tests seem to break/fail
as-is when run on single-core machines (at least, under qemu), so some
way of documenting this as a requirement would probably be necessary,
too.

One possibility would be to add support for "skipped" tests to KUnit
(the TAP specification allows for it), so that the KCSAN test could
detect cases where it's not reliable, and skip itself (leaving a note
as to why). In the short term, though, we'd absolutely need some
documentation around the dependencies for the test.

(For the record, the failures I saw were all due to running under qemu
emulating as a uniprocessor/single-core machine: with
CONFIG_PREEMPT_VOLUNTARY, it would just hang after creating the first
couple of threads. With CONFIG_PREEMPT, the tests completed, but the
majority of them failed.)

> The main thing, however, is that we want to verify the actual output
> (or absence of it) to console. This is what the KCSAN test does using
> the 'console' tracepoint. Could KUnit provide some generic
> infrastructure to check console output, like is done in the test here?
> Right now I couldn't say what the most useful generalization of this
> would be (without it just being a wrapper around the console
> tracepoint), because the way I've decided to capture and then match
> console output is quite test-specific. For now we can replicate this
> logic on a per-test basis, but it would be extremely useful if there
> was a generic interface that KUnit could provide in future.

This is something we've discussed here a couple of times as well.
While I'll confess to being a little bit wary of having tests rely too
heavily on console output: it risks being a bit fragile if the exact
contents or formatting of messages change, or ends up having a lot of
string formatting and/or parsing code in the tests. I do agree,
though, that it probably needs to be at least a part of testing things
like sanitizers where the ultimate goal is to produce console output.
I'm not exactly sure how we'd implement it yet, so it's probably not
going to happen extremely soon, but what you have here looks to me
like a good example we can generalise as needed.

Cheers,
-- David

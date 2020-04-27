Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED6C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CFE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAmwxbLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgD0Qne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgD0Qne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:43:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B5C03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:43:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e20so27298357otk.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0l3NqzV2IWIFuQGrqE3G+AwPymiYlsU4oik6jzyoVmg=;
        b=SAmwxbLqJrUSfkoYtAZbktbvGuOarWFsxprteKsTaNdB7N5O0sVe44TIRN075S+kSY
         /x89deYTxfAmtpXoUINDcZpYtRLg+V6DNKS4+wR+GNzBOzTsL4Dk8Ah8M7UR0KSvRiIq
         HGRHAcYI9jQM2NoKxTor9AIRxIN+WKcZsK1tyy78Y5LdrWckhM/jyXhaC5Ta44Dl31K+
         bclhVkSOCyYyY1PGpG2VCXMG6LWNAV+xT4kmizEzbWeXAusvI1cIEZzyXl4KyQu6u6+Q
         6M7F7qzRoeiyfLxXO7QkX9RBm0WNLOfn4nqFevDiKxLAIJS/YVVdTHRaYg+EPZKrWn1/
         apRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0l3NqzV2IWIFuQGrqE3G+AwPymiYlsU4oik6jzyoVmg=;
        b=HSnqbQev0m7kbyh3YX8f2kCyp+9YLg9b6KQfRoEIp5vsH/mrhY4TQ/eXkK4y55l4Su
         0B/ibMKJlovZGiGdEuk6yyPcXOY0eH+kDzSaZNJTkN6nUTyym3Lz6fcCIVpUiP2WE+2G
         i+1Dw6x5/gehTzlx4cM+vrD5jtxETXUBhNkXisEeZ6mPtO6kp54ksBqE27yPek5i5eOt
         t6H6vcPvWLjv6aiXIL2ZMw4g8VomprG4mN8vWA25OuezG88e4u3s4BzpsNaViuFIG3G2
         9g0kdzSfPemXNN0aD1C8FFrYtrB7IKgtQXDRIh/BrDkNsmC72BS3a023wgwUy0URhLXw
         c8oQ==
X-Gm-Message-State: AGi0PuZ9Iq4ai4ilbAQJEYZj9MR9/QGhpad3NCTUFYzOzh37YYuaeUl7
        txO8/1bwexeUz5rQ0G68UZqrspJNwphzOMzhJtEVoA==
X-Google-Smtp-Source: APiQypI65a4rL5YlTwEc9U9snwVQ5wW/oFCww5CXcclu7avjVRIi8rj01jsJ65ymAJyuvVTlYjX4GNUHDZ3Qy2HcTco=
X-Received: by 2002:aca:1c08:: with SMTP id c8mr16511350oic.172.1588005813011;
 Mon, 27 Apr 2020 09:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200427143507.49654-1-elver@google.com> <CANpmjNOv7VXv9LtWHWBx1-an+1+WxjtzDNBF+rKsOm+ybmvwog@mail.gmail.com>
 <20200427153744.GA7560@paulmck-ThinkPad-P72>
In-Reply-To: <20200427153744.GA7560@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 27 Apr 2020 18:43:21 +0200
Message-ID: <CANpmjNM7Aw7asb80OqZ0vmgQYY1SwM_Pnvf7ZHHvyFfsc6ZjmQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Add test suite
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
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

On Mon, 27 Apr 2020 at 17:37, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Apr 27, 2020 at 05:23:23PM +0200, Marco Elver wrote:
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
> >
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
> >
> > Thoughts?
>
> What I do in rcutorture is to run in a VM, dump the console output
> to a file, then parse that output after the run completes.  For example,
> the admittedly crude script here:
>
>         tools/testing/selftests/rcutorture/bin/parse-console.sh

That was on the table at one point, but discarded. We debated when I
started this if I should do module + script, or all as one module.
Here is some of the reasoning we went through, just for the record:

We wanted to use KUnit, to be able to benefit from all the
infrastructure it provides. Wanting to use KUnit meant that we cannot
have a 2-step test (module + script), because KUnit immediately prints
success/fail after each test-case and doesn't run any external scripts
(AFAIK). There are several benefits to relying on KUnit, such as:
1. Common way to set up and run test cases. No need to roll our own.
2. KUnit has a standardized way to assert, report test status,
success, etc., which can be parsed by CI systems
(https://testanything.org).
3. There are plans to set up KUnit CI systems, that just load and run
all existing KUnit tests on boot. The sanitizer tests can become part
of these automated test runs.
4. If KUnit eventually has a way to check output to console, our
sanitizer tests will be simplified even further.

The other argument is that doing module + script is probably more complex:
1. The test would have to explicitly delimit test cases in a custom
way, which a script could then extract.
2. We need to print the function names, and sizes + addresses of the
variables used in the races, to then be parsed by the script, and
finally match the access information.
3. Re-running the test without shutting down the system would require
clearing the kernel log or some other way to delimit tests.

We'd still need the same logic, one way or another, to check what was
printed to console. In the end, I came to the conclusion that it's
significantly simpler to just have everything integrated in the
module:
1. No need to delimit test cases, and parse based on delimiters. Just
check what the console tracepoint last captured.
2. Can just refer to the functions, and variables directly and no need
to parse this.
3. Re-running the test works out of the box.

Therefore, the conclusion is that for the sanitizers this is hopefully
the best approach.

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> > Thanks,
> > -- Marco
[...]

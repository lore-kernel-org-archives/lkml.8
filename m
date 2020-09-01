Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4D2C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98722208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y25qQIhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIAFbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAFbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:31:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDBFC0612A1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:31:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so148325wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oG8wUoUVIVk+LGdmP2qZI7KPEISzjBeDYZ7JKwjL4jU=;
        b=Y25qQIhhNzUalFAxcfQyik2WwcnQdkYBVxcZ6iQA6YyfLwTONMqSIoVJw9CcbSNm/y
         Ltl7l9B/2pNH821JyN055WWcLNa7xZrKYW/O6fs9wTWSyXXom68rWwBGx3weXhjfHSPH
         72oOveenh9ItOOL+4nlslT9xxdoPiysyMM5FkOTpB68pmk4SDxV4jFf9jteYnrTP5/ez
         mCruMdo09Fb5euymJiKvPZTRVhcJ11KIoiaXCqj5x7Xki4U0KI+Q2nvObPJfEYGUbjA3
         xq/ek3kTAcqx+w4QY6hD5NvyoQPZhwjoP2EOmANg/dVmInE61TT3ekqGr5iOoWZLLDap
         NkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oG8wUoUVIVk+LGdmP2qZI7KPEISzjBeDYZ7JKwjL4jU=;
        b=J8Py+NiZ4Xy6mN+/31pibWiCErofs9DLjighQWLZm5qik4nGTO3BTXGPU0ArspMHBL
         h8I2YEBgObbpUmGRHI59ZN0xbl4a7rws63gFUgS2MfDpNidQkjVJrYfzRt9/hmZK+Ly+
         u46Uc/cBZG9pKjXohvvAQKT7Me5cxFVPnTmIWM81+b81SZBpD7ktDkBIeUi/ldLbBwaW
         qoMH5QDWeCruDNlR6XTQPHTuyIPqm/vy8pEvss4l7lX9kHFibNOhm2CAmSd5xNusYX9A
         TX0/IQtW4q3Bn9SZGfl7s0k9a6NvKsZ2+MhRd/RrtSSou+h2DI2XBL+iUaUD+Z5eV2Fz
         KvXA==
X-Gm-Message-State: AOAM532vnOT9r0czljVIXzTE0CN+3UW2U8MeZMEfs2ZVWC4Y0PKxjZ5F
        ofn0doFzY87Dxrn8Y1qV1/gVoECzaax1WKxc6B2iXQ==
X-Google-Smtp-Source: ABdhPJwto0tDgywLNWrStFqpEpMy7cQ6H9JT8Vkurj60nKSfueMynnt2gI8S2T4VXLkDX8CGsls19uqpPJpn13woGm0=
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr335745wmi.99.1598938289172;
 Mon, 31 Aug 2020 22:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200702071416.1780522-1-davidgow@google.com> <20200827131438.GA3597431@elver.google.com>
 <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com> <202008311641.D10607D43@keescook>
In-Reply-To: <202008311641.D10607D43@keescook>
From:   David Gow <davidgow@google.com>
Date:   Tue, 1 Sep 2020 13:31:16 +0800
Message-ID: <CABVgOSmF93YVD=scGL5p0tjnm0XUwC2n8LPT9xFqGje9zXQ96Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     Kees Cook <keescook@chromium.org>
Cc:     Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 7:47 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Aug 28, 2020 at 12:17:05AM +0800, David Gow wrote:
> > On Thu, Aug 27, 2020 at 9:14 PM Marco Elver <elver@google.com> wrote:
> > > Just an idea: Maybe the names are also an opportunity to distinguish
> > > real _unit_ style tests and then the rarer integration-style tests. I
> > > personally prefer using the more generic *-test.c, at least for the
> > > integration-style tests I've been working on (KUnit is still incredibly
> > > valuable for integration-style tests, because otherwise I'd have to roll
> > > my own poor-man's version of KUnit, so thank you!). Using *_kunit.c for
> > > such tests is unintuitive, because the word "unit" hints at "unit tests"
> > > -- and having descriptive (and not misleading) filenames is still
> > > important. So I hope you won't mind if *-test.c are still used where
> > > appropriate.
>
> This is a good point, and I guess not one that has really been examined.
> I'm not sure what to think of some of the lib/ tests. test_user_copy
> seems to be a "unit" test -- it's validating the function family vs
> all kinds of arguments and conditions. But test_overflow is less unit
> and more integration, which includes "do all of these allocators end up
> acting the same way?" etc
>
> I'm not really sure what to make of that -- I don't really have a formal
> testing background.
>

I'm not sure we need a super-precise definition here (maybe just
because I don't have one), and really just need to work out what
distinctions are actually useful. For example, I'm not sure there's
any real advantage to treating test_user_copy and test_overflow
differently. The KCSAN tests which spawn lots of threads and are both
slower and less deterministic seem more obviously different, though.

I guess there are two audiences to cater for:
1. Test authors, who may wish to have both unit-style and
integration-style tests, and want to distinguish them. They probably
have the best idea of where the line should be drawn for their
subsystems, and may have some existing style/nomenclature.
2. People running "all tests", who want to broadly understand how the
whole suite of tests will behave (e.g., how long they'll take to run,
are they possibly nondeterministic, are there weird hardware/software
dependencies). This is where some more standardisation probably makes
sense.

I'm not 100% the file/module name is the best place to make these
distinctions (given that it's the Kconfig entries that are at least
our current way of finding and running tests). An off-the-wall idea
would be to have a flags field in the test suite structure to note
things like "large/long-running test" or "nondeterministic", and have
either a KUnit option to bypass them, note them in the output, or even
something terrifying like parsing it out of a compiled module.

> > As Brendan alluded to in the talk, the popularity of KUnit for these
> > integration-style tests came as something of a surprise (more due to
> > our lack of imagination than anything else, I suspect). It's great
> > that it's working, though: I don't think anyone wants the world filled
> > with more single-use test "frameworks" than is necessary!
> >
> > I guess the interesting thing to note is that we've to date not really
> > made a distinction between KUnit the framework and the suite of all
> > KUnit tests. Maybe having a separate file/module naming scheme could
> > be a way of making that distinction, though it'd really only appear
> > when loading tests as modules -- there'd be no indication in e.g.,
> > suite names or test results. The more obvious solution to me (at
> > least, based on the current proposal) would be to have "integration"
> > or similar be part of the suite name (and hence the filename, so
> > _integration_kunit.c or similar), though even I admit that that's much
> > uglier. Maybe the idea of having the subsystem/suite distinction be
> > represented in the code could pave the way to having different suites
> > support different suffixes like that.
>
> Heh, yeah, let's not call them "_integration_kunit.c" ;) _behavior.c?
> _integration.c?
>

I think we'd really like something that says more strongly that this
is a test (which is I suspect one of the reasons why _kunit.c has its
detractors: it doesn't have the word "test" in it). The other thing to
consider is that if there are multiple tests for the same thing (e.g.,
a unit test suite and an integration test suite), they'd still need
separate, non-conflicting suite names if we wanted them to be able to
be present in the same kernel.

Maybe the right thing to do is to say that, for now, the _kunit.c
naming guideline only applies to "unit-style" tests.

> > Do you know of any cases where something has/would have both
> > unit-style tests and integration-style tests built with KUnit where
> > the distinction needs to be clear?
>
> This is probably the right question. :)
>
I had a quick look, and we don't appear to have anything quite like
this yet, at least with KUnit.


So, putting together the various bits of feedback, how about something
like this:
Test filenames/modules should end in _kunit.c, unless they are either
a) not unit-style tests -- i.e, test something other than correctness
(e.g., performance), are non-deterministic, take a long time to run (>
~1--2 seconds), or are testing across multiple subsystems -- OR
b) are ports of existing tests, which may keep their existing filename
(at least for now), so as not to break existing workflows.

This is a bit weaker than the existing guidelines, and will probably
need tightening up once we have a better idea of what non-unit tests
should be and/or the existing, inconsistently named tests are
sufficiently outnumbered by the _kunit ones that people are used to it
and the perceived ugliness fades away. What (if any) tooling we need
around enumerating tests may end up influencing/being influenced by
this a bit, too.

Thoughts?
-- David

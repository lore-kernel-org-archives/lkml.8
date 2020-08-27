Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B35BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D446B2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9yZaO9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgH0QRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgH0QRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCF7C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:17:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so5935598wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1R0Eitpm/wfF2mpTHMtEGL35ys7GJDbdS2QGVwDMQI=;
        b=S9yZaO9q3OFbVJleiK2Lh0XJ3wXSbGHd69Y/+rl97Fa0Z20UtiJhzev7aCitAAbWlh
         qh1SqYNN1tMyiXZZpkw2Va+DOgeq0gwkIk9h3M8w8QP0Cmd6TeogGYUzAgNZ9DlPHvsd
         WMSxAIZw/Jaz3vnLCwUzuO2OviaJdPNAUl1sJ7bAsorY5S6p4j7wkf7oj5qcVeudCAJU
         2jGIpAQ7dJ7h3XMGOcYdaDp5gXrWltzsnVid+8kzrLqDQ6deoG9CHVEZJpkN5hGwYJqJ
         dwAzH2WK23C4V4Ctd2lTTfTIq4nnt69tsE1+Dy5ZzJljKbE/8PwSx6hJfiZSZDjO82fG
         ir0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1R0Eitpm/wfF2mpTHMtEGL35ys7GJDbdS2QGVwDMQI=;
        b=QL9HCrDvJ8CyJrBQ5+mbuMb2EwEDVK3QpkRbEkryzWc9IcqyPgjrTQtM3DAlb0H69c
         zgWLo5+OQrvk4XU95SC6BWU2t+9gS0+z3yvI0vgGpcnLw5ZP0jTz4kt1mAwv9E6FOxa1
         nQhIS6rALv7nvfJaKC0hDumC/z+HkqsNHyiqU388yOBeiqCVn0BUQAcKUcFgEYC58EF3
         lGgN+VGI3v1Z0MVc00ueusrYMffXKDPrtpXtO4dTHfl9AkcHrhIQTlkCpXsP33d+Nep3
         LCXde2EMNVD2dhebbJv+wRToGTvh1eGhvQ6cOwwJEUG5rhWg8oDBbQ37JqxAcnsMVIhQ
         M0TA==
X-Gm-Message-State: AOAM5308D8nq/dzujl1pQJPNUG0v6gz8guEmuQJ+tVMxxAAQ3m4Doa1b
        gt89D1zJaBFpws94TUK/Zv8Ak3YFMKS1sv7Opc2i2w==
X-Google-Smtp-Source: ABdhPJz+qS2IlmoSQerSgtkhmdhPyC7fKeZC2vUG4R/ZcSpRjX9T1O4Frk+oWtBfj/bPoeFDP68P9DgICyjYHlGo/Yo=
X-Received: by 2002:adf:ba05:: with SMTP id o5mr20964356wrg.7.1598545040079;
 Thu, 27 Aug 2020 09:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200702071416.1780522-1-davidgow@google.com> <20200827131438.GA3597431@elver.google.com>
In-Reply-To: <20200827131438.GA3597431@elver.google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 28 Aug 2020 00:17:05 +0800
Message-ID: <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
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

On Thu, Aug 27, 2020 at 9:14 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, Jul 02, 2020 at 12:14AM -0700, David Gow wrote:
> > As discussed in [1], KUnit tests have hitherto not had a particularly
> > consistent naming scheme. This adds documentation outlining how tests
> > and test suites should be named, including how those names should be
> > used in Kconfig entries and filenames.
> >
> > [1]:
> > https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> ...
> > +An example Kconfig entry:
> > +
> > +.. code-block:: none
> > +
> > +        config FOO_KUNIT_TEST
> > +                tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
> > +                depends on KUNIT
> > +                default KUNIT_ALL_TESTS
> > +                help
> > +                    This builds unit tests for foo.
> > +
> > +                    For more information on KUnit and unit tests in general, please refer
> > +                    to the KUnit documentation in Documentation/dev-tools/kunit
> > +
> > +                    If unsure, say N
> > +
> > +
> > +Test Filenames
> > +==============
> > +
> > +Where possible, test suites should be placed in a separate source file in the
> > +same directory as the code being tested.
> > +
> > +This file should be named ``<suite>_kunit.c``. It may make sense to strip
> > +excessive namespacing from the source filename (e.g., ``firmware_kunit.c`` instead of
> > +``<drivername>_firmware.c``), but please ensure the module name does contain the
> > +full suite name.
>
> First of all, thanks for the talk yesterday! I only looked at this
> because somebody pasted the LKML link. :-)

No worries! Clearly this document needed linking -- even I was
starting to suspect the reason no-one was complaining about this was
that no-one had read it. :-)

> The example about excessive namespacing seems confusing. Was it supposed
> to be
>
>         [...] firmware_kunit.c`` instead of ``<drivername>_firmware_kunit.c [...]
>
> ?

Whoops, yes. I'll fix that.

>
> While I guess this ship has sailed, and *_kunit.c is the naming
> convention now, I hope this is still just a recommendation and names of
> the form *-test.c are not banned!

The ship hasn't technically sailed until this patch is actually
accepted. Thus far, we hadn't had any real complaints about the
_kunit.c idea, though that may have been due to this email not
reaching enough people. If you haven't read the discussion in
https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u
it's worthwhile: the _kunit.c name is discussed, and Kees lays out
some more detailed rationale for it as well.

> $> git grep 'KUNIT.*-test.o'
>         drivers/base/power/Makefile:obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
>         drivers/base/test/Makefile:obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
>         fs/ext4/Makefile:obj-$(CONFIG_EXT4_KUNIT_TESTS)         += ext4-inode-test.o
>         kernel/Makefile:obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
>         lib/Makefile:obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_TEST) +=          kunit-test.o
>         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_TEST) +=          string-stream-test.o
>         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=  kunit-example-test.o
>
> $> git grep 'KUNIT.*_kunit.o'
> # Returns nothing
>

This was definitely something we noted. Part of the goal of having
_kunit.c as a filename suffix (and, perhaps more importantly, the
_kunit module name suffix) was to have a way of both distinguishing
KUnit tests from non-KUnit ones (of which there are quite a few
already with -test names), and to have a way of quickly determining
what modules contain KUnit tests. That really only works if everyone
is using it, so the plan was to push this as much as possible. This'd
probably include renaming most of the existing test files to match,
which is a bit of a pain (particularly when converting non-KUnit tests
to KUnit and similar), but is a one-time thing.

>
> Just an idea: Maybe the names are also an opportunity to distinguish
> real _unit_ style tests and then the rarer integration-style tests. I
> personally prefer using the more generic *-test.c, at least for the
> integration-style tests I've been working on (KUnit is still incredibly
> valuable for integration-style tests, because otherwise I'd have to roll
> my own poor-man's version of KUnit, so thank you!). Using *_kunit.c for
> such tests is unintuitive, because the word "unit" hints at "unit tests"
> -- and having descriptive (and not misleading) filenames is still
> important. So I hope you won't mind if *-test.c are still used where
> appropriate.

As Brendan alluded to in the talk, the popularity of KUnit for these
integration-style tests came as something of a surprise (more due to
our lack of imagination than anything else, I suspect). It's great
that it's working, though: I don't think anyone wants the world filled
with more single-use test "frameworks" than is necessary!

I guess the interesting thing to note is that we've to date not really
made a distinction between KUnit the framework and the suite of all
KUnit tests. Maybe having a separate file/module naming scheme could
be a way of making that distinction, though it'd really only appear
when loading tests as modules -- there'd be no indication in e.g.,
suite names or test results. The more obvious solution to me (at
least, based on the current proposal) would be to have "integration"
or similar be part of the suite name (and hence the filename, so
_integration_kunit.c or similar), though even I admit that that's much
uglier. Maybe the idea of having the subsystem/suite distinction be
represented in the code could pave the way to having different suites
support different suffixes like that.

Do you know of any cases where something has/would have both
unit-style tests and integration-style tests built with KUnit where
the distinction needs to be clear?

Brendan, Kees: do you have any thoughts?


> Thanks,
> -- Marco


Cheers,
-- David

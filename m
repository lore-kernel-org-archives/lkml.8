Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5392BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEFC2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MAvymusA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbgFYBrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 21:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbgFYBrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 21:47:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B9C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:47:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so4002891wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GiKIX/vStI7SGvasVqVJsOyHpxs3Ttg4NMGSmUAEW0=;
        b=MAvymusAsOY95wvaDryEZpMdHEe5FdDHdKHQ5raIzb2e6+9FbnKYcuCCjrf7BvNJ2n
         5AOvVH0ZOPGhy6H0yawAJVwZasPeYzdEFcTpbTEnoDsHD32DilL1c5O4Cb3sndxeHkFt
         voPoH9kY09KsNjxAflA41VjCtIEU6zSBS3lwRzk9ktVl43LC8fTV9Tkl0KkheIcKEBbT
         1pT5thNszSg7g1M9X/u6RSPaFEmmr4G5C6sejp1pf3Cbv+gt66qshb13i6eYr/BBBKSa
         PzvB3l6ZYjRf6NP4gYAJvyLvc5FCOn+GKFXEu2WTvwq2kL0lMvXqLdKv+TribW4YaeHj
         XT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GiKIX/vStI7SGvasVqVJsOyHpxs3Ttg4NMGSmUAEW0=;
        b=hbiB2jg++MWTjyzae/NoxS+AZRmwHr3XbfJMt36bKyQg3oqfMjCceLnZlSCjZna7AB
         rgG8XGUjLceIUJs9iixY7ZU+GM1Jr/6nrWu0pqG9NygIbxnbPENbjgmO2J6tTZdP4OoQ
         u/JVzsoVhCgpHtI3cWIWoJE6OviS4eNS7kSxR4Xbw9kdqRQ85aFtjtE8JYQsAthilCT5
         iqDAlHgOPMBORCYgdS3bvBSP54gyVbATj2eeWXcPHnPcUjnzdL0piOoAE00qSzo+FXQ0
         naH1Zmbc+OI7kVnI3sFAKje587/HfsJpwiSgjYNBZ9bAyhujjcfBA+70pO+tmPC/ms4u
         VRlw==
X-Gm-Message-State: AOAM532h8UT5wPtpOJpnzaPChxy/IMPagE9O3ymjCHXG7D/FHGJ/IFh8
        Ah1pZ9xrXLZpG7NbQKZLiW8TZBKuhVYe+FbGF3/AvA==
X-Google-Smtp-Source: ABdhPJw2DZIdWwUIMDdao2bLZhuUP65zl22/umR4onGlZwaR9GVdVFEuput6SazbqmKipdF5zt6jw51yyuhYLPbCGbo=
X-Received: by 2002:a1c:750e:: with SMTP id o14mr646775wmc.86.1593049632255;
 Wed, 24 Jun 2020 18:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 25 Jun 2020 09:47:00 +0800
Message-ID: <CABVgOSnkYfXZ1YELsXAjA0GzCQT9YWO8x+Tssw_+avkDdBB4aw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, monstr@monstr.eu, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net,
        jcmvbkbc@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glad this is back out there: a couple of minor nitpicks below:

On Thu, Jun 25, 2020 at 4:58 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> ## TL;DR
>
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.
>
> Also, sorry for the extreme delay in getting this out. Part of the delay
> came from finding that there were actually several architectures that
> the previous revision of this patchset didn't work on, so I went through
> and attempted to test this patchset on every architecture - more on that
> later.
>
> ## What am I trying to do?
>
> Conceptually, I am trying to provide a mechanism by which test suites
> can be grouped together so that they can be reasoned about collectively.
> The last two of three patches in this series add features which depend
> on this:
>
> PATCH 8/11 Prints out a test plan[1] right before KUnit tests are run;
>            this is valuable because it makes it possible for a test
>            harness to detect whether the number of tests run matches the
>            number of tests expected to be run, ensuring that no tests
>            silently failed. The test plan includes a count of tests that
>            will run. With the centralized executor, the tests are
>            located in a single data structure and thus can be counted.
>

This appears to actually be patch 9/11.

> PATCH 9/11 Add a new kernel command-line option which allows the user to
>            specify that the kernel poweroff, halt, or reboot after
>            completing all KUnit tests; this is very handy for running
>            KUnit tests on UML or a VM so that the UML/VM process exits
>            cleanly immediately after running all tests without needing a
>            special initramfs. The centralized executor provides a
>            definitive point when all tests have completed and the
>            poweroff, halt, or reboot could occur.

This seems to have been merged into the above patch (9/11).

> In addition, by dispatching tests from a single location, we can
> guarantee that all KUnit tests run after late_init is complete, which
> was a concern during the initial KUnit patchset review (this has not
> been a problem in practice, but resolving with certainty is nevertheless
> desirable).
>
> Other use cases for this exist, but the above features should provide an
> idea of the value that this could provide.
>
> ## Changes since last revision:
>  - On the last revision I got some messages from 0day that showed that
>    this patchset didn't work on several architectures, one issue that
>    this patchset addresses is that we were aligning both memory segments
>    as well as structures in the segments to specific byte boundaries
>    which was incorrect.
>  - The issue mentioned above also caused me to test on additional
>    architectures which revealed that some architectures other than UML
>    do not use the default init linker section macro that most
>    architectures use. There are now several new patches (2, 3, 4, and
>    6).
>  - Fixed a formatting consistency issue in the kernel params
>    documentation patch (9/9).
>  - Add a brief blurb on how and when the kunit_test_suite macro works.
>
> ## Remaining work to be done:
>
> The only architecture for which I was able to get a compiler, but was
> apparently unable to get KUnit into a section that the executor to see
> was m68k - not sure why.
>
> Alan Maguire (1):
>   kunit: test: create a single centralized executor for all tests
>
> Brendan Higgins (10):
>   vmlinux.lds.h: add linker section for KUnit test suites
>   arch: arm64: add linker section for KUnit test suites
>   arch: microblaze: add linker section for KUnit test suites
>   arch: powerpc: add linker section for KUnit test suites
>   arch: um: add linker section for KUnit test suites
>   arch: xtensa: add linker section for KUnit test suites
>   init: main: add KUnit to kernel init
>   kunit: test: add test plan to KUnit TAP format
>   Documentation: Add kunit_shutdown to kernel-parameters.txt
>   Documentation: kunit: add a brief blurb about kunit_test_suite
>
>  .../admin-guide/kernel-parameters.txt         |   8 ++
>  Documentation/dev-tools/kunit/usage.rst       |   5 ++
>  arch/arm64/kernel/vmlinux.lds.S               |   3 +
>  arch/microblaze/kernel/vmlinux.lds.S          |   4 +
>  arch/powerpc/kernel/vmlinux.lds.S             |   4 +
>  arch/um/include/asm/common.lds.S              |   4 +
>  arch/xtensa/kernel/vmlinux.lds.S              |   4 +
>  include/asm-generic/vmlinux.lds.h             |   8 ++
>  include/kunit/test.h                          |  73 ++++++++++++-----
>  init/main.c                                   |   4 +
>  lib/kunit/Makefile                            |   3 +-
>  lib/kunit/executor.c                          |  63 +++++++++++++++
>  lib/kunit/test.c                              |  13 +--
>  tools/testing/kunit/kunit_kernel.py           |   2 +-
>  tools/testing/kunit/kunit_parser.py           |  74 +++++++++++++++---
>  .../test_is_test_passed-all_passed.log        | Bin 1562 -> 1567 bytes
>  .../test_data/test_is_test_passed-crash.log   | Bin 3016 -> 3021 bytes
>  .../test_data/test_is_test_passed-failure.log | Bin 1700 -> 1705 bytes
>  18 files changed, 226 insertions(+), 46 deletions(-)
>  create mode 100644 lib/kunit/executor.c
>
>
> base-commit: 4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
> prerequisite-patch-id: 2d4b5aa9fa8ada9ae04c8584b47c299a822b9455
> prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
>
> These patches are available for download with dependencies here:
>
> https://kunit-review.googlesource.com/c/linux/+/3829
>
> [1] https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
> [2] https://patchwork.kernel.org/patch/11383635/
>
> --
> 2.27.0.212.ge8ba1cc988-goog
>

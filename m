Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E48DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE72208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnctVzA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgFZVJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:24 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0329BC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:24 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j9so3935899pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yoOABEWG1/6h2iOQDoaXra3teAZCdH+g3IIeVI61zqU=;
        b=lnctVzA6Jf/UU0td8ovSYbI8I4nDkekzGOb/PJTTsaZY6zqu5N5ZjWDd4YDayRX+Ov
         mjTvKPepzFqMBoF606g4y4X/150dujV+9wnwuvpZVFCMfwiXOdJp/tK7t1PRsv8gCr8y
         5SZtgb3I8tPyj2j3PXdYTUEHH9wNAX77svB/vS8vPnb5mMH0Z0CXiK81tdR4FdLoHv0f
         pJg1ZG9FQkUneT3PgQmDKjNHeIr2cIfameUdzQz90+lZLEl3KLRlZ8kh8zlnmst756zz
         LisdpllMi++KsnD4cFidh3dMP2W5bJ9jjhgS7+HvlBEP/fUGoTFg/tSAaGY8WT0mUfwL
         btUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yoOABEWG1/6h2iOQDoaXra3teAZCdH+g3IIeVI61zqU=;
        b=BlzCBybjgCI3QQLX6HUSL+08DFF8rLhC5H47Ywnk7FmLDn9aQYIVpvx+OXBhExQKou
         73kCR7LojT3AQXYN0bU3WxXez0031seq6fBYvVZl1kbr2aCwiCMX8Vl/ORrP/DCeuJPV
         +oekXwMBqHEyBG2BCgVohKR9HVJU2ZzsvpK/HBzYR27HUUmzdeveGsUXnPRrZpLdgqU2
         ADHubN4HwCf3iGEhvd1CYFSgZolQrMdufXAQ0f2Nx7gBYNSWQNO+URcw4qfq3JRkNY05
         CXOKxQCb5V9YfIBjgLVHbpH71tMEBIqshrmPPvXBwMU8tlrhKDYZDKygld9FypF/tVaC
         qAoA==
X-Gm-Message-State: AOAM5315CXh9R2fEvKYW9Jcg1L+AKWbLABvnRdghpwK7iEyXtoKVQcsM
        u3qAdSSxVKT23x/IAy9UaZ2t0Mdd+NKTmpGH9ZLBrQ==
X-Google-Smtp-Source: ABdhPJzOkuCMJcWBTIQFtPbukWtzW86GMVGbL6qXJmvDDdcWRcAfYZDZf3JuQ+iDFThI6ZaHADTtDBKoYShd/uVlWE2ElA==
X-Received: by 2002:a62:196:: with SMTP id 144mr4487477pfb.316.1593205763212;
 Fri, 26 Jun 2020 14:09:23 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:05 -0700
Message-Id: <20200626210917.358969-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 00/12] kunit: create a centralized executor to dispatch all
 KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

## TL;DR

This patchset adds a centralized executor to dispatch tests rather than
relying on late_initcall to schedule each test suite separately along
with a couple of new features that depend on it.

## What am I trying to do?

Conceptually, I am trying to provide a mechanism by which test suites
can be grouped together so that they can be reasoned about collectively.
The last two of three patches in this series add features which depend
on this:

PATCH 09/12 Prints out a test plan[1] right before KUnit tests are run;
            this is valuable because it makes it possible for a test
            harness to detect whether the number of tests run matches
            the number of tests expected to be run, ensuring that no
            tests silently failed. The test plan includes a count of
            tests that will run. With the centralized executor, the
            tests are located in a single data structure and thus can be
            counted.

PATCH 10/12 Add a new kernel command-line option which allows the user
            to specify that the kernel poweroff, halt, or reboot after
            completing all KUnit tests; this is very handy for running
            KUnit tests on UML or a VM so that the UML/VM process exits
            cleanly immediately after running all tests without needing
            a special initramfs. The centralized executor provides a
            definitive point when all tests have completed and the
            poweroff, halt, or reboot could occur.

In addition, by dispatching tests from a single location, we can
guarantee that all KUnit tests run after late_init is complete, which
was a concern during the initial KUnit patchset review (this has not
been a problem in practice, but resolving with certainty is nevertheless
desirable).

Other use cases for this exist, but the above features should provide an
idea of the value that this could provide.

## Changes since last revision:
 - Fixed a compilation error in the centralized executor patch (07/12).
   I had forgotten to test the patches when building as modules. I
   verified that works now.
 - I accidentally merged patches 09/12 and 10/12 in the previous
   revision (v4), and made them separate patches again.

## Changes since v3:
 - On the last revision I got some messages from 0day that showed that
   this patchset didn't work on several architectures, one issue that
   this patchset addresses is that we were aligning both memory segments
   as well as structures in the segments to specific byte boundaries
   which was incorrect.
 - The issue mentioned above also caused me to test on additional
   architectures which revealed that some architectures other than UML
   do not use the default init linker section macro that most
   architectures use. There are now several new patches (2, 3, 4, and
   6).
 - Fixed a formatting consistency issue in the kernel params
   documentation patch (11/12).
 - Add a brief blurb on how and when the kunit_test_suite macro works.

## Remaining work to be done:

The only architecture for which I was able to get a compiler, but was
apparently unable to get KUnit into a section that the executor to see
was m68k - not sure why.

Alan Maguire (1):
  kunit: test: create a single centralized executor for all tests

Brendan Higgins (10):
  vmlinux.lds.h: add linker section for KUnit test suites
  arch: arm64: add linker section for KUnit test suites
  arch: microblaze: add linker section for KUnit test suites
  arch: powerpc: add linker section for KUnit test suites
  arch: um: add linker section for KUnit test suites
  arch: xtensa: add linker section for KUnit test suites
  init: main: add KUnit to kernel init
  kunit: test: add test plan to KUnit TAP format
  Documentation: Add kunit_shutdown to kernel-parameters.txt
  Documentation: kunit: add a brief blurb about kunit_test_suite

David Gow (1):
  kunit: Add 'kunit_shutdown' option

 .../admin-guide/kernel-parameters.txt         |   8 ++
 Documentation/dev-tools/kunit/usage.rst       |   5 ++
 arch/arm64/kernel/vmlinux.lds.S               |   3 +
 arch/microblaze/kernel/vmlinux.lds.S          |   4 +
 arch/powerpc/kernel/vmlinux.lds.S             |   4 +
 arch/um/include/asm/common.lds.S              |   4 +
 arch/xtensa/kernel/vmlinux.lds.S              |   4 +
 include/asm-generic/vmlinux.lds.h             |   8 ++
 include/kunit/test.h                          |  76 +++++++++++++-----
 init/main.c                                   |   4 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/executor.c                          |  63 +++++++++++++++
 lib/kunit/test.c                              |  13 +--
 tools/testing/kunit/kunit_kernel.py           |   2 +-
 tools/testing/kunit/kunit_parser.py           |  74 ++++++++++++++---
 .../test_is_test_passed-all_passed.log        | Bin 1562 -> 1567 bytes
 .../test_data/test_is_test_passed-crash.log   | Bin 3016 -> 3021 bytes
 .../test_data/test_is_test_passed-failure.log | Bin 1700 -> 1705 bytes
 18 files changed, 227 insertions(+), 48 deletions(-)
 create mode 100644 lib/kunit/executor.c

These patches are available for download with dependencies here:

https://kunit-review.googlesource.com/c/linux/+/3829

[1] https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
[2] https://patchwork.kernel.org/patch/11383635/

base-commit: 4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
prerequisite-patch-id: 2d4b5aa9fa8ada9ae04c8584b47c299a822b9455
prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
-- 
2.27.0.212.ge8ba1cc988-goog


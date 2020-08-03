Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9534C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A283B20719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJtI6scH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHCQZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgHCQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:25:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9FCC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:25:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l2so12046430pff.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IN89B/Ojkw/pvP1l4s5A6ia3yKGl9XfJ2ORu0fQjOxU=;
        b=WJtI6scHtL9Fd/g9hvc18gOkLTmjcI5aIJLBj3JhMsGJOXQEPWDt737O/BJcLnMznR
         5x2xmIojdm95xZUAvp7s2aeWkdFtq77qCkCZnE+PGLIHUsS6YhddTVci2lOPG1osOVlL
         qc6ilanHTTr+Alw5GceCilNFG9gLiZt3Jr1OI3iXVj7iaXp2HDNekc3pYkZOCO6N3cla
         arg1wiE02nsZKgO2T4ZDkzhtTQzk9G1+fvOzk2WwVQ1Vj23u1Yyf7Os4OexAUJoeAMEA
         5WDqNZPQZgWUBkvqOL5wJD/5qD1ukL0rGjMpWWncB2fxviBSKhi2BH0SbWmDKDwo06je
         n3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IN89B/Ojkw/pvP1l4s5A6ia3yKGl9XfJ2ORu0fQjOxU=;
        b=rkIIuXDA1EG1K5H+aU4CjHm5HccczctI/ISltPawmSyspDKew7ppXF5VO07AEJh0Qi
         QiBah5Eg1bGBD40m12jLLio6GTt+0IvFXTvu5u4R/pSARwAoHPG9BRz89nOP6cViXgLW
         d/gpqk9kHcQnoXI8cRTTVBWA3MmvQ8NHPOTW1vOvKcH1vciiAfQzK8MndUXhWDbp5mbu
         Ks2cf6g0KU7KqSxOxgmiYC7F+Gkt3IH/LSP1f08dgDRIRuH1wJG4rP79Cc74qgdJcwvE
         eI9/B9Lg6K8pmm2XlRUi99Blp8iclwpjWGh/CrEaAtbJGX6EbCMLSw50TgLXFtkEQH2S
         el0g==
X-Gm-Message-State: AOAM530huDk/crD4QpYZevi+8Gv0pMU6lMDax9VuqrF7+VwworpUpCkd
        OX9I6ElgDseJ4cdYe9D7QI3uW9mynue2/Sx5qSw1xg==
X-Google-Smtp-Source: ABdhPJxUJAy4D50Cy9xQo/Fi9+ReHMOENbRttTBG/G/wElIiKNs9tcOJvPAM6AbWc6LpnzHb88iaSpoq9TTPQk8RAKA=
X-Received: by 2002:aa7:97a3:: with SMTP id d3mr16432430pfq.178.1596471949983;
 Mon, 03 Aug 2020 09:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200801070924.1786166-1-davidgow@google.com>
In-Reply-To: <20200801070924.1786166-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 3 Aug 2020 18:25:38 +0200
Message-ID: <CAAeHK+wpt+Pko3pCBwO3Q=6Su7chVj+xhAGgHiVabbzC58rgDw@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] KASAN-KUnit Integration
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 9:09 AM David Gow <davidgow@google.com> wrote:
>
> This patchset contains everything needed to integrate KASAN and KUnit.
>
> KUnit will be able to:
> (1) Fail tests when an unexpected KASAN error occurs
> (2) Pass tests when an expected KASAN error occurs
>
> Convert KASAN tests to KUnit with the exception of copy_user_test
> because KUnit is unable to test those.
>
> Add documentation on how to run the KASAN tests with KUnit and what to
> expect when running these tests.
>
> This patchset depends on:
> - "kunit: extend kunit resources API" [1]
>  - This is already present in the kselftest/kunit branch
>
> I'd _really_ like to get this into 5.9 if possible: we also have some
> other changes which depend on some things here.

+Andew, could you PTAL at this patchset?

> Changes from v9:
>  - Rebased on top of linux-next (20200731) + kselftest/kunit and [7]
>  - Note that the kasan_rcu_uaf test has not been ported to KUnit, and
>    remains in test_kasan_module. This is because:
>    (a) KUnit's expect failure will not check if the RCU stacktraces
>        show.
>    (b) KUnit is unable to link the failure to the test, as it occurs in
>        an RCU callback.
>
> Changes from v8:
>  - Rebased on top of kselftest/kunit
>  - (Which, with this patchset, should rebase cleanly on 5.8-rc7)
>  - Renamed the KUnit test suite, config name to patch the proposed
>    naming guidelines for KUnit tests[6]
>
> Changes from v7:
>  - Rebased on top of kselftest/kunit
>  - Rebased on top of v4 of the kunit resources API[1]
>  - Rebased on top of v4 of the FORTIFY_SOURCE fix[2,3,4]
>  - Updated the Kconfig entry to support KUNIT_ALL_TESTS
>
> Changes from v6:
>  - Rebased on top of kselftest/kunit
>  - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
>    incompatibilites [2]
>  - Removed a redundant report_enabled() check.
>  - Fixed some places with out of date Kconfig names in the
>    documentation.
>
> Changes from v5:
>  - Split out the panic_on_warn changes to a separate patch.
>  - Fix documentation to fewer to the new Kconfig names.
>  - Fix some changes which were in the wrong patch.
>  - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)
>
> Changes from v4:
>  - KASAN no longer will panic on errors if both panic_on_warn and
>    kasan_multishot are enabled.
>  - As a result, the KASAN tests will no-longer disable panic_on_warn.
>  - This also means panic_on_warn no-longer needs to be exported.
>  - The use of temporary "kasan_data" variables has been cleaned up
>    somewhat.
>  - A potential refcount/resource leak should multiple KASAN errors
>    appear during an assertion was fixed.
>  - Some wording changes to the KASAN test Kconfig entries.
>
> Changes from v3:
>  - KUNIT_SET_KASAN_DATA and KUNIT_DO_EXPECT_KASAN_FAIL have been
>  combined and included in KUNIT_DO_EXPECT_KASAN_FAIL() instead.
>  - Reordered logic in kasan_update_kunit_status() in report.c to be
>  easier to read.
>  - Added comment to not use the name "kasan_data" for any kunit tests
>  outside of KUNIT_EXPECT_KASAN_FAIL().
>
> Changes since v2:
>  - Due to Alan's changes in [1], KUnit can be built as a module.
>  - The name of the tests that could not be run with KUnit has been
>  changed to be more generic: test_kasan_module.
>  - Documentation on how to run the new KASAN tests and what to expect
>  when running them has been added.
>  - Some variables and functions are now static.
>  - Now save/restore panic_on_warn in a similar way to kasan_multi_shot
>  and renamed the init/exit functions to be more generic to accommodate.
>  - Due to [4] in kasan_strings, kasan_memchr, and
>  kasan_memcmp will fail if CONFIG_AMD_MEM_ENCRYPT is enabled so return
>  early and print message explaining this circumstance.
>  - Changed preprocessor checks to C checks where applicable.
>
> Changes since v1:
>  - Make use of Alan Maguire's suggestion to use his patch that allows
>    static resources for integration instead of adding a new attribute to
>    the kunit struct
>  - All KUNIT_EXPECT_KASAN_FAIL statements are local to each test
>  - The definition of KUNIT_EXPECT_KASAN_FAIL is local to the
>    test_kasan.c file since it seems this is the only place this will
>    be used.
>  - Integration relies on KUnit being builtin
>  - copy_user_test has been separated into its own file since KUnit
>    is unable to test these. This can be run as a module just as before,
>    using CONFIG_TEST_KASAN_USER
>  - The addition to the current task has been separated into its own
>    patch as this is a significant enough change to be on its own.
>
>
> [1] https://lore.kernel.org/linux-kselftest/CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com/T/#t
> [2] https://lore.kernel.org/linux-mm/20200424145521.8203-1-dja@axtens.net/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb72ae1915db28f934e9e02c18bfcea2f3ed3b7
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47227d27e2fcb01a9e8f5958d8997cf47a820afc
> [5] https://bugzilla.kernel.org/show_bug.cgi?id=206337
> [6] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/
> [7] https://lkml.org/lkml/2020/7/31/571
>
>
> David Gow (1):
>   mm: kasan: Do not panic if both panic_on_warn and kasan_multishot set
>
> Patricia Alfonso (4):
>   Add KUnit Struct to Current Task
>   KUnit: KASAN Integration
>   KASAN: Port KASAN Tests to KUnit
>   KASAN: Testing Documentation
>
>  Documentation/dev-tools/kasan.rst |  70 +++
>  include/kunit/test.h              |   5 +
>  include/linux/kasan.h             |   6 +
>  include/linux/sched.h             |   4 +
>  lib/Kconfig.kasan                 |  22 +-
>  lib/Makefile                      |   7 +-
>  lib/kasan_kunit.c                 | 770 +++++++++++++++++++++++++
>  lib/kunit/test.c                  |  13 +-
>  lib/test_kasan.c                  | 903 ------------------------------
>  lib/test_kasan_module.c           | 111 ++++
>  mm/kasan/report.c                 |  34 +-
>  11 files changed, 1028 insertions(+), 917 deletions(-)
>  create mode 100644 lib/kasan_kunit.c
>  delete mode 100644 lib/test_kasan.c
>  create mode 100644 lib/test_kasan_module.c
>
> --
> 2.28.0.163.g6104cc2f0b6-goog
>

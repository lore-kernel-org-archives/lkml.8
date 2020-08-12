Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B229C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAAB207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbJ+Kqwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHLMMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgHLMMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:12:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A1C061787
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:12:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so1041180plk.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBv5/z2Ow9pFbDPFGGYjiRaQjvVika1ng+xJ7HOOxEU=;
        b=fbJ+Kqwr6RFoV33CJAsRqLndzqgfmDNAQ6MY31Nyx2JxxKNJOnw+KxY8Bge8FtI5MH
         FDpgeRBmcJe0Nk/OM/G5Jsm54+AJtgnaNvDaIEuRsN33/43PsSYAXkmdsWEUyv6plv3f
         zznxoyy2dHzJQu7EPleyD1K0kb5dl/XBiULLz+x/xna0IQnP5Oia0NNJnIzMSD4ZciL4
         Mt/XFcj76M0o6SuLICsZoCeQHJo0/Ay2Bj6wswH9Al45g91j+G3SrbaBhS/dqovLXVVU
         u7ptS4gS+j9vMQYueSN1JlFJ14V1GyxuPIfAV7vf8Wx8DCi9j7bh4Iwt5ZN5dztrhUIM
         J9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBv5/z2Ow9pFbDPFGGYjiRaQjvVika1ng+xJ7HOOxEU=;
        b=GFoocqvasSLlAZ4k6q/zrWKPU4qJ+4kyHNcFFxLAbyo8PjOZ8TwpXWIWdGOD0PFsFr
         AjPeVk2B9jBWQHQuhGwelFODukZBt8EvBGXxil+NNueX3GQYmzenuYRhaHb87CX2iSg2
         s9Dgq9yDORRr6rdKJ1aeMD2O7KrDsLTsnTFfubv6dW3Om/2GevJxsRCY1joHFXfAB3Qr
         T8JbS6c6OdM38Rz0ev6SXuvtTbikvRv0fOAzJNlrOaXiNbEAv7b4x76gNzPAneoI9bkm
         8v9mJP9LcnUVrNqguJXSn4FrUKcjW3MlNp/eJMgEbLYFNgZAuhjWiCLE75m7YTy5GP7p
         +ctg==
X-Gm-Message-State: AOAM532b1GhM08f+6DgbaeUAO9+f6yrXhDHYz+G9Dg79rTPFW5SrQ2vz
        3FTkug98xeGcdGuC6diYFG/Kzfza2pSKGQM16zz92w==
X-Google-Smtp-Source: ABdhPJzcJwuSt6EllmiXRFnMS7uC9Qb0YrjCkzcDrvdUZZ4BNEJJMjtnMSHX+TFgYh5WHnP8iK2ll8yxapo1nv34xLY=
X-Received: by 2002:a17:902:9009:: with SMTP id a9mr4663327plp.252.1597234327266;
 Wed, 12 Aug 2020 05:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200811053914.652710-1-davidgow@google.com>
In-Reply-To: <20200811053914.652710-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 12 Aug 2020 14:11:56 +0200
Message-ID: <CAAeHK+zhA+ifqdOMc9AJ3Y_70CAsKbBX=wX0mnvBscz=Ts0uHQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] KASAN-KUnit Integration
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
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 7:39 AM David Gow <davidgow@google.com> wrote:
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
>  - This is included in the KUnit 5.9-rci pull request[8]
>
> Sorry for spamming you all with all these revisions.
> I'd _really_ like to get this into 5.9 if possible: we also have some
> other changes which depend on some things here.

Hi Andrew,

Could you PTAL, and consider sending this upstream for 5.9?

Thanks!

>
> Changes from v11:
>  - Rebased on top of latest -next (20200810)
>  - Fixed a redundant memchr() call in kasan_memchr()
>  - Added Andrey's "Tested-by" to everything.
>
> Changes from v10:
>  - Fixed some whitespace issues in patch 2.
>  - Split out the renaming of the KUnit test suite into a separate patch.
>
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
> [8] https://lore.kernel.org/linux-kselftest/8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org/T/#u
>
>
> David Gow (2):
>   kasan: test: Make KASAN KUnit test comply with naming guidelines
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
>  lib/kasan_kunit.c                 | 769 +++++++++++++++++++++++++
>  lib/kunit/test.c                  |  13 +-
>  lib/test_kasan.c                  | 903 ------------------------------
>  lib/test_kasan_module.c           | 111 ++++
>  mm/kasan/report.c                 |  34 +-
>  11 files changed, 1027 insertions(+), 917 deletions(-)
>  create mode 100644 lib/kasan_kunit.c
>  delete mode 100644 lib/test_kasan.c
>  create mode 100644 lib/test_kasan_module.c
>
> --
> 2.28.0.236.gb10cc79966-goog
>

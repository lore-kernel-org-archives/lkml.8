Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8396C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A1B2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKJZJB4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgHDXPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgHDXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:15:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 16:15:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so38866738wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 16:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9gpV2EukdQDh4ZPc/03X4i9rg/1FfiYZWy/TtTUyw8=;
        b=vKJZJB4t0jSDcSkqtMkclvkoltustEMpfBLwXU8BrykAMNEVDNLtHeqArD1xoF+pmL
         zaF0CRqkShgYuuro7xHtWxKH2yb5cBT6zxtSTqSiaIzbSJAVy+gE42naRGMSjbVcR9eB
         ctXZcbHll/mIlqktiIqmKmTVCDCcvj4Iya97fiL0xBiS9FeQvCKqh919HAd4AdOgB8Y6
         0CosIPoenyb16IUbqWHJaHj8SsxoTzqYMurGLB357gRe23Z2O5FBsA32+wjKfZvfmWRr
         KcL6TGmgM3X3oAETPebL+wDfiWTMeh2FOFjfMtelbY4KbbG7oamjlwacW8vGs/3m/z0v
         dDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9gpV2EukdQDh4ZPc/03X4i9rg/1FfiYZWy/TtTUyw8=;
        b=ttcOqwK83DMUCv0I5m3AJu8oQsTBrIkNuc0rSgdzQc8Zr7KxNJfUsRZ3FOw5L0UyVO
         jC2shEtm/Kr5T9rHnPxXq7q2bTY1kKFGIX2U2SY/D6xc420HGicX/rVmL27oSKCMSMhi
         VENUKt+0R6WqX0fm8itQOTWPbIl2YAtUraqhfNyeEuF0b6DCGqCtvzCKtN9MO/uu5xNp
         uv7V6KMjWSt2O50dsXispHokFthjuHpUBQnlFAUJ8gbwbrM5e8iyru9NZ4nKBkkqR0GI
         +O3wTI5KV5n8OwtsstS1EpYlRUG2723Nv2Yj3mh6+ZjgZNzY7w64KCpZVEFnaMdfoZeY
         3ZbA==
X-Gm-Message-State: AOAM532P0ZRBE9dilvRdst4KYwcUDOMKiLEFXvcvmyJ3VHHevihR/Ffq
        y+QnfmDGxrYi4lukF6uhkeXzHLsx5ZZNrjZmr9+AXA==
X-Google-Smtp-Source: ABdhPJy4RdIlWhdyRLD6kiD0K/NkH2q77aUp4lqTCqpftNSh7mSJgiGdKaBGJxxzuqDVOJbrUK3SlC2QFHtvY/yN8i0=
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr191888wru.19.1596582914310;
 Tue, 04 Aug 2020 16:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200801070924.1786166-1-davidgow@google.com> <20200801070924.1786166-4-davidgow@google.com>
 <CABVgOSnpsnYw=0mAks4Xr2rGe07ER1041TKCCY1izeCfT8TcBQ@mail.gmail.com> <CAAeHK+y5KBuAfpeO90X0rxyZmPj4OQGUF=L-q3GAgQUTFNxdsQ@mail.gmail.com>
In-Reply-To: <CAAeHK+y5KBuAfpeO90X0rxyZmPj4OQGUF=L-q3GAgQUTFNxdsQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 5 Aug 2020 07:15:02 +0800
Message-ID: <CABVgOS=fOj++o2sBbOAwnKJSC+2s4dE6pDuuZNHYq+u_ayPiAw@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KASAN: Port KASAN Tests to KUnit
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 6:15 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Tue, Aug 4, 2020 at 12:59 AM David Gow <davidgow@google.com> wrote:
> >
> > On Sat, Aug 1, 2020 at 3:10 PM David Gow <davidgow@google.com> wrote:
> > >
> > > From: Patricia Alfonso <trishalfonso@google.com>
> > >
> > > Transfer all previous tests for KASAN to KUnit so they can be run
> > > more easily. Using kunit_tool, developers can run these tests with their
> > > other KUnit tests and see "pass" or "fail" with the appropriate KASAN
> > > report instead of needing to parse each KASAN report to test KASAN
> > > functionalities. All KASAN reports are still printed to dmesg.
> > >
> > > Stack tests do not work properly when KASAN_STACK is enabled so
> > > those tests use a check for "if IS_ENABLED(CONFIG_KASAN_STACK)" so they
> > > only run if stack instrumentation is enabled. If KASAN_STACK is not
> > > enabled, KUnit will print a statement to let the user know this test
> > > was not run with KASAN_STACK enabled.
> > >
> > > copy_user_test and kasan_rcu_uaf cannot be run in KUnit so there is a
> > > separate test file for those tests, which can be run as before as a
> > > module.
> > >
> > > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > > ---
> > >  lib/Kconfig.kasan       |  22 +-
> > >  lib/Makefile            |   7 +-
> > >  lib/kasan_kunit.c       | 770 ++++++++++++++++++++++++++++++++
> > >  lib/test_kasan.c        | 946 ----------------------------------------
> > >  lib/test_kasan_module.c | 111 +++++
> > >  5 files changed, 902 insertions(+), 954 deletions(-)
> > >  create mode 100644 lib/kasan_kunit.c
> > >  delete mode 100644 lib/test_kasan.c
> > >  create mode 100644 lib/test_kasan_module.c
> >
> > Whoops -- this patch had a few nasty whitespace issues make it
> > through. I'll send out a new version with those fixed.
> >
> > I'm pondering splitting it up to do the file rename
> > (test_kasan.c->kasan_kunit.c) separately as well, as git's rename
> > detection is not particularly happy with it.
>
> Maybe also name it kunit_kasan.c? Probably in the future we'll have
> kunit_kmsan.c, etc.

The name here uses _kunit as a suffix as part of a plan to standardise
that for all KUnit tests.
There's some draft documentation for the proposed naming guidelines here:
https://lore.kernel.org/linux-kselftest/20200702071416.1780522-1-davidgow@google.com/

(The idea here was for kunit tests for modules to nicely sort next to
the corresponding modules, which is why _kunit is a suffix, but that
doesn't really apply for something built-in like KASAN.)

-- David

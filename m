Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA04C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6CC2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7y3ZvBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgHCW7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgHCW7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:59:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EABAC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:59:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so32076693wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVMTuQZIH47WM1WuikLBTLZ1LTQtr65n2lbis/GQnro=;
        b=Q7y3ZvBVs+uNYo2Mb/GjVhFW370VN3GdBcKmK5mr/28yZ6LjoWyp7Mv8xLknRLnc2p
         BNrv0CINGmdsSeO3zTZ7FuvLbsFzdcCbYN9AH81W0h8/Ob7GEjdafkSXLP6PcWEQiEeZ
         gVF4CtKz6ADDdBTrluK5XeHu+zCJSsLHvwwgIV4WFipgSAJPdW+OcDGwEWJ9+Da4pWJo
         PU7uzG5Hl6lgY+Hfhf2LZO5LusUkYOHCRzel2VYM0x17UQSy8lcpdB8pwytWV4f4AHXf
         g3ASsKZsCq3cVMnawJRsyHM22bzRYMmwrqfN9UropwJg1eDQiIvAwDxzIQzMBPOr58Zx
         oxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVMTuQZIH47WM1WuikLBTLZ1LTQtr65n2lbis/GQnro=;
        b=OXmeNX9XaoX2GA/Lj1GJHiEX7fzUiLiJQhS/XwxWx1Nydkk237K9BQ7vCk4ndHrM8i
         vwMLgyL3VfjFlt6Dy5S52DW48CRW2uH6mMDz2n4/Mc1bYof42qborDm+X3rbTfO5t9Xc
         DdcUhq5NPWcNjXfq68a5TrM713mjCLwbdlOJ3fUzZjmIODMvaP3Gy1jAqjTCVUGUeF5S
         iXNez6uKfi1L0RMmdLJhnUbcgOC1iiQTJHt67DyScZoNoqoeBq8nF57G3fIRo+RtE1zK
         icVJD18H1A3XCJB4+nVmBsoOZnLfa/qJG1E5fV6ywlCeEgm+x07fzymNKFHJvT9mRc3i
         CE/g==
X-Gm-Message-State: AOAM532pJingGT9zDFhHdlY6ZHWoCYGhU+ZJTl5B2kgDCwIA+J1J4NiK
        f6xOLQnSsSzWg609hhPsj3vEuo2yQ4ppbMy7pOvqig==
X-Google-Smtp-Source: ABdhPJwd+kAe35CZLHtw169OJYbx0Gkc+euSQp8Y4f8jmkoFFLXtjrglf4FogQewYcDbj62rm0/pOPYEOMajh2OZ5FQ=
X-Received: by 2002:adf:f289:: with SMTP id k9mr17129637wro.203.1596495550006;
 Mon, 03 Aug 2020 15:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200801070924.1786166-1-davidgow@google.com> <20200801070924.1786166-4-davidgow@google.com>
In-Reply-To: <20200801070924.1786166-4-davidgow@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 4 Aug 2020 06:58:58 +0800
Message-ID: <CABVgOSnpsnYw=0mAks4Xr2rGe07ER1041TKCCY1izeCfT8TcBQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KASAN: Port KASAN Tests to KUnit
To:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 3:10 PM David Gow <davidgow@google.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Transfer all previous tests for KASAN to KUnit so they can be run
> more easily. Using kunit_tool, developers can run these tests with their
> other KUnit tests and see "pass" or "fail" with the appropriate KASAN
> report instead of needing to parse each KASAN report to test KASAN
> functionalities. All KASAN reports are still printed to dmesg.
>
> Stack tests do not work properly when KASAN_STACK is enabled so
> those tests use a check for "if IS_ENABLED(CONFIG_KASAN_STACK)" so they
> only run if stack instrumentation is enabled. If KASAN_STACK is not
> enabled, KUnit will print a statement to let the user know this test
> was not run with KASAN_STACK enabled.
>
> copy_user_test and kasan_rcu_uaf cannot be run in KUnit so there is a
> separate test file for those tests, which can be run as before as a
> module.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/Kconfig.kasan       |  22 +-
>  lib/Makefile            |   7 +-
>  lib/kasan_kunit.c       | 770 ++++++++++++++++++++++++++++++++
>  lib/test_kasan.c        | 946 ----------------------------------------
>  lib/test_kasan_module.c | 111 +++++
>  5 files changed, 902 insertions(+), 954 deletions(-)
>  create mode 100644 lib/kasan_kunit.c
>  delete mode 100644 lib/test_kasan.c
>  create mode 100644 lib/test_kasan_module.c

Whoops -- this patch had a few nasty whitespace issues make it
through. I'll send out a new version with those fixed.

I'm pondering splitting it up to do the file rename
(test_kasan.c->kasan_kunit.c) separately as well, as git's rename
detection is not particularly happy with it.

Sorry,
-- David

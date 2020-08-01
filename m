Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE967C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 07:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE792071E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 07:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VO0K6rya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHAHRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 03:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgHAHRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 03:17:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B074C061756
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 00:17:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so24705119wrs.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TWNF9js53PcdlvlEQGLSj775mBS94SUQ30AaksVxoQ=;
        b=VO0K6ryau/F3M3Dq1GKbT+Ju+3xjYUSKkECGfWdRqLobEciqL0RcUz4/iC4W8lVZ1q
         QA65GiZKQRJr/myRRsw4n89yDhKQQOONOJwQnTjs+pu3xamfaa5Ztrhg1KJ7WQ6hqxwT
         HpvI5KkYtiS+X3q/w9LUpob+E8OmwtQpPwY41OJOatDMZ4FJ2ajQnBJeHFXQEI2IBXM7
         MDUn65w+5blACPpkaQSuWTxoz6eBj+Z525rXmhOva11Ma9iXX49xrtd/jnFAqRdGvaJV
         bwnx1R+Q4aZqlB/MlC6CMAFZqmfYn0i6aTCn07ZkMzdpUVfq9VE49aHj6u4s5Br5Zexc
         mwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TWNF9js53PcdlvlEQGLSj775mBS94SUQ30AaksVxoQ=;
        b=HyZUOsyA3vK7UxX66gSh3MC8EmW2y6zP1huLQbngj+9Yn9tq2b5kM2fLHfXOE+41Ja
         EJ5Se7eIDx+kCBDgKtG/GWB5iZqIvahN+/Zvo56xzSmkpoLtmUGIJdK1cUX9PVxALE6t
         V9jZnjR1tVDOxwUtPJWBOqkC9xfEJFUOKIcMukxmjTWIsFluZAwz/9CEk4Mp3ATuH0SI
         JetwKL/zOgAGrtp772R7wb+vBjpWRdCIKrw5gwzItAk4Ql/kXfe+BBb6lu+xz3UE1KyY
         +Yh4oo1GwrQulFByxW9si5NysVpCueZL5LiNlXw5LmHvaTts3GQ8uP9ZO8jtDOq/wXzc
         FAiQ==
X-Gm-Message-State: AOAM53185dwMivGNqsoGjYSRzePdcPSMtpkp83IeCTOQKeOWgPIPNHan
        LKizW2TPoSF7NX+Qni5d0N2DzcQtBa0JYR3hDKbzJg==
X-Google-Smtp-Source: ABdhPJzq/rzZHdZ2pAKBHdqSrbybtRNlexfh0RgiZS1svnsLG/Wioiod4eAFn6JHc7/uJob0VxLcIqfDs+pDzu5POMw=
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr6436942wru.19.1596266267633;
 Sat, 01 Aug 2020 00:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200731044242.1323143-1-davidgow@google.com> <CAAeHK+z0wJ-3+dXey9o3zysy9fPOqk-YdFFtVOB5==WcG3B8+Q@mail.gmail.com>
In-Reply-To: <CAAeHK+z0wJ-3+dXey9o3zysy9fPOqk-YdFFtVOB5==WcG3B8+Q@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 1 Aug 2020 15:17:36 +0800
Message-ID: <CABVgOSnFanyCtBFaFAdrArr+hkXCdNu5vCNmciLP0ftQRgAsXQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] KASAN-KUnit Integration
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

On Fri, Jul 31, 2020 at 9:25 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Fri, Jul 31, 2020 at 6:43 AM David Gow <davidgow@google.com> wrote:
> >
> > This patchset contains everything needed to integrate KASAN and KUnit.
> >
> > KUnit will be able to:
> > (1) Fail tests when an unexpected KASAN error occurs
> > (2) Pass tests when an expected KASAN error occurs
> >
> > Convert KASAN tests to KUnit with the exception of copy_user_test
> > because KUnit is unable to test those.
> >
> > Add documentation on how to run the KASAN tests with KUnit and what to
> > expect when running these tests.
> >
> > This patchset depends on:
> > - "kunit: extend kunit resources API" [1]
> >  - This is already present in the kselftest/kunit branch
> >
> > I'd _really_ like to get this into 5.9 if possible: we also have some
> > other changes which depend on some things here.
>
> Hi David,
>
> You'll need to rebase this on top of the mm tree, which currently
> contains Walter's patch titled "kasan: fix KASAN unit tests for
> tag-based KASAN".
>
> There's also another patch that touches KASAN tests in the series I've
> just mailed titled "kasan: support stack instrumentation for tag-based
> mode".
>
> Thanks!
>

I've rebased this on top of a linux-next (with the pending KUnit
patches from kselftest/kunit and the "kasan: support stack
instrumentation for tag-based mode" patchset applied):
https://lore.kernel.org/linux-kselftest/20200801070924.1786166-1-davidgow@google.com/T/#u

Note that the RCU test doesn't seem to be compatible with KUnit's
KASAN integration at present: I'm no expert on RCU, but it looks like
the current test context might not be propagated to the callback, so
expecting the failure doesn't work. Given that KUnit also doesn't look
for the aux stacks (just that a failure occurred), it seemed best to
avoid trying to port that one to KUnit, so I've left it in the
test_kasan_module.c file. It may be possible to port it at a later
date.

Note that I don't have an arm64 setup here, so I haven't actually
tested the tag-based KASAN stuff yet.

Cheers,
-- David

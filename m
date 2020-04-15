Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DECC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97900206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuGQ7vDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415733AbgDOQXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415722AbgDOQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:23:09 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10125C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:23:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c63so17880526qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WQaPoGilX7952642s2SnzjPSgMErOwadAM6nQWjRtR0=;
        b=DuGQ7vDXBz8YxMCX25XBEHl2LofiQdO6ZSS3GdmVPmqehd+JroQ1QBiv9KCFL9idac
         wmEkU8QVlT3C1a9SxwOgJ5jx55r+Vl8GO7AGHGtxGbodmYC7BSHFuTa7KHRD4brYI34j
         fB5uHVJo1l1YlmW/lO9O+5wQd8Qpqxs+1a4ulPyN4S6U4gfI583wJthIdKHpQj7vfiLt
         Q+Ww2JLeBoegWJAQwYVm4PcHsqfi1bi7H6B8EmsGEAW/IZSXkA6tt1ACDaN/UvJa3nKj
         hUtoKEn3GaPTfyl2LHpwlSefTwTm16UfqGtYgrZ7vjBSC7tCVPdAT3wo0oLVsVUzlpmW
         XRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQaPoGilX7952642s2SnzjPSgMErOwadAM6nQWjRtR0=;
        b=kQRfsek8Pw3QAVRZ+lJo0AQvrPr8psY4vqBT2k7NNvM5n7DaJF2Gr2yzSOEpjo2+OX
         azXb57Cr0x8vCNWn/A8ZFbY3iklrYP1BcdiUHYKRLbfVmQXa87w5Zt6MgA0nCCDYPg1u
         zhwmhlR9umAb4G1Za2Pc9CkzMazEt+pE++YviP4agKhneRs9rrd/p1zRH6ouQhWIeK3B
         RJyeH1yISfu6YbB9Er9MenLPbueCReYfB0AMf4dgTl5UbHlR8mE0Z8++Y7NjZTApmvzC
         mLMfu+lozXPpA+IYYuXMnXA+0UwNJa2ESOiDm6z1RxUZCBK2QKxGRAkp9A3A/YD8KxG7
         y7mA==
X-Gm-Message-State: AGi0PuZf/xDFxbDzKg2b8kATzYjiLBGS+02LNJna3t45ARZbLxD2aE6q
        J1HTAcVWKJexTa+2rbrLCbJ1sQ==
X-Google-Smtp-Source: APiQypLIVriiHZEAR0HgXSTVqL/zrwrsuqiHVOfzprCl3K0x075uZ9BLMPVSz8HxiYygz5EVOLrPRg==
X-Received: by 2002:a05:620a:88f:: with SMTP id b15mr25715100qka.118.1586967788051;
        Wed, 15 Apr 2020 09:23:08 -0700 (PDT)
Received: from localhost ([2601:441:27f:8f73:faf4:f79d:8a53:5ca2])
        by smtp.gmail.com with ESMTPSA id a22sm10051300qko.81.2020.04.15.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:23:07 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:23:06 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200415162306.bu6ncolr4wcjetwu@xps.therub.org>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
 <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
 <20200410092951.6db32bfe@canb.auug.org.au>
 <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
 <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
 <20200414192840.4yp3zqbe2tgtesve@xps.therub.org>
 <CACT4Y+bi9jFKR5vHY37-RoojUiVkX6Pu69X-2F+ibo6pSCA==Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bi9jFKR5vHY37-RoojUiVkX6Pu69X-2F+ibo6pSCA==Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 01:09:32PM +0200, Dmitry Vyukov wrote:
> On Tue, Apr 14, 2020 at 9:28 PM Dan Rue <dan.rue@linaro.org> wrote:
> >
> > On Tue, Apr 14, 2020 at 01:12:50PM +0200, Dmitry Vyukov wrote:
> > > On Tue, Apr 14, 2020 at 12:06 AM Qian Cai <cai@lca.pw> wrote:
> > > > Well, there are other CI's beyond syzbot.
> > > > On the other hand, this makes me worry who is testing on linux-next every day.
> > >
> > > How do these use-after-free's and locking bugs get past the
> > > unit-testing systems (which syzbot is not) and remain unnoticed for so
> > > long?...
> > > syzbot uses the dumbest VMs (GCE), so everything it triggers during
> > > boot should be triggerable pretty much everywhere.
> > > It seems to be an action point for the testing systems. "Boot to ssh"
> > > is not the best criteria. Again if there is a LOCKDEP error, we are
> > > not catching any more LOCKDEP errors during subsequent testing. If
> > > there is a use-after-free, that's a serious error on its own and KASAN
> > > produces only 1 error by default as well. And as far as I understand,
> > > lots of kernel testing systems don't even enable KASAN, which is very
> > > wrong.
> > > I've talked to +Dan Rue re this few days ago. Hopefully LKFT will
> > > start catching these as part of unit testing. Which should help with
> > > syzbot testing as well.
> >
> > LKFT has recently added testing with KASAN enabled and improved the
> > kernel log parsing to catch more of this class of errors while
> > performing our regular functional testing.
> >
> > Incidentally, -next was also broken for us from March 25 through April 5
> > due to a perf build failure[0], which eventually made itself all the way
> > down into v5.6 release and I believe the first two 5.6.x stable
> > releases.
> >
> > For -next, LKFT's gap is primarily reporting. We do build and run over
> > 30k tests on every -next daily release, but we send out issues manually
> > when we see them because triaging is still a manual effort. We're
> > working to build better automated reporting. If anyone is interested in
> > watching LKFT's -next results more closely (warning, it's a bit noisy),
> > please let me know. Watching the results at https://lkft.linaro.org
> > provides some overall health indications, but again, it gets pretty
> > difficult to figure out signal from noise once you start drilling down
> > without sufficient context of the system.
> 
> What kind of failures and noise do you get? Is it flaky tests?
> I would assume build failures are ~0% flaky/noisy. And boot failures
> are maybe ~1% flaky/noisy due to some infra issues.

Right - infrastructure problems aside (which are the easy part), tests
are quite flaky/noisy.

I guess we're getting quite off topic now, but in LKFT's case we run
tests that are available from the likes of LTP, kselftest, and a variety
of other test suites. Every test was written by a developer with certain
assumptions in place - many of which we violate when we run them on a
small arm board, for example. And many may just be low quality to begin
with, but they often work well enough for the original author's
use-case.

In such cases, we mark them (manually at this point) as a known issue.
For example, here are our kselftest known issues:
https://github.com/Linaro/qa-reports-known-issues/blob/master/kselftests-production.yaml

These lists are quite a chore to keep up to date, and so they tend to
lag reality. What's needed (and what we're working toward) is more
sophisticated analytics on top of our results to determine actual
regressions.

I'll give just one example, randomly selected but typical. Here's a
timer test that sometimes passes and sometimes fails, which compares how
much time something takes with a hard coded value of what the author
expects. Running on small arm hosts or under qemu, the following check
sometimes fails:
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/timers/rtcpie.c#L104-L111

There are _many_ such tests - hundreds or thousands, which rely on hard
coded expectations and are quite hard to "fix". But we run them all
because most of them haven't failed yet, and if they do we'll find out
why.

We ignore the tests which either always fail, or which sometimes fail,
in general. I'm sure there are some legitimate bugs in that set of
failures, but they're probably not "regressions" so just as syzkaller
lets old bugs close automatically, we ignore tests that have a history
of failing.

> 
> I can't find any actual test failure logs in the UI. I've got to this page:
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-rc1-24-g8632e9b5645b/testrun/1363280/suite/kselftest/tests/
> which seem to contain failed tests on mainline. But I still can't find
> the actual test failure logs.

From the link you gave, if you go up one level to
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-rc1-24-g8632e9b5645b/testrun/1363280/,
you will see links to the "Log File" which takes you to
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-rc1-24-g8632e9b5645b/testrun/1363280/log.

In some test suite cases (perhaps just LTP), we have logs per test. In
most, we just have one large log of the entire run. Even when we have a
log-per-test, it may miss some asynchronous dmesg output I expect,
causing an investigator to look at the whole log anyway.

Dan

> 
> 
> > Dan
> >
> > [0] https://lore.kernel.org/stable/CA+G9fYsZjmf34pQT1DeLN_DDwvxCWEkbzBfF0q2VERHb25dfZQ@mail.gmail.com/
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org

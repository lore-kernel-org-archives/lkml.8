Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A99C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A9020775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koZzPW8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCXPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:05:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42405 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCXPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:05:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so9666321wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z37whwAEqv2UhQ238liZabu95DixugSK+aNM/HESChs=;
        b=koZzPW8Onon8s5EyCubFp/bBT+4QR2ekY8m1b/Ql5hFd2LxT5rbMicbghIQlwGiuoL
         6rWV6xUHlKEw6RXlfd3ONn61FJ8XrH9auITAHSbhRLOXQmQ3tOHbp7PliOed5widCviT
         /aU9XENZq1ULLHxVXOuA8YT0nDuPbmyDozB49Vip/gkmXNam5Npqu3+saE1TRSglsNCk
         IPwKjPoLX2PcRSbFDMP2O33SLKyILoXPIPZ+Q5TkFKEybEC4sft0RnNNvOqOSM9onIxp
         ko6XL6k39lR+0IAmhVGd6f4BHCcsTtyCvP/t0dmZmr8wOfPu7CGt74vjP+6RIl7QmIKp
         0BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z37whwAEqv2UhQ238liZabu95DixugSK+aNM/HESChs=;
        b=sVD8rGZbUWrqe2GHycEVcztGXPe/V7pIZHRv0TLEG8Ghy9l66paw8DiRTEJiAUB9zS
         sGyWNzPHXtug1zhorn3u6bkyVp6ZS7DfdzrtfOEGfNsXxClxIMn5PABKRzpt/4v775ux
         U7R/rnFmErl3UXEl41S9oqZu1QDnpOOclBsZAgc1+wQEjHHGfPp2FV9a4H5OzMRrvDmG
         vyk/hz+UaTcLd+UqH3Qlfd0hNiQKLbaBim3H+hgW7Ff/QbbmSwC/O2M2PRKZWuPp0Hv7
         nSp170pi2etimIPlOT0uLg1ICfKWEjMrS157F46hsipDWzQ9pVgHKodtWdRTXfGHd7Ld
         HckA==
X-Gm-Message-State: ANhLgQ18O1k/x4dsNh+SEpJfJBLruxtyw2lOlOA+1e339opqi6981aXN
        m0KgY096fIF9iEgpBL/7LqWJ7hYBj+IeOFt2ioGSuw==
X-Google-Smtp-Source: ADFU+vv5uwUvgJQDSn/3Zx+Rn4R0s1EmrXHv+2/PHWkMDb0cor0QQriDfYgKM2IRY62TlO7H+78iIm49lYZ8Lu3YLT8=
X-Received: by 2002:adf:efc9:: with SMTP id i9mr16611416wrp.23.1585062314941;
 Tue, 24 Mar 2020 08:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-4-trishalfonso@google.com> <CACT4Y+YHPfP3LP04=Zc4NgyhH8FMJ9m-eU_VPjmk5SmGWo_fTg@mail.gmail.com>
In-Reply-To: <CACT4Y+YHPfP3LP04=Zc4NgyhH8FMJ9m-eU_VPjmk5SmGWo_fTg@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Tue, 24 Mar 2020 08:05:03 -0700
Message-ID: <CAKFsvU+N=8=VmKVdNdf6os26z+vVD=vR=TL5GJtLQhR9FxOJUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] KASAN: Port KASAN Tests to KUnit
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

On Tue, Mar 24, 2020 at 4:25 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Mar 19, 2020 at 5:42 PM 'Patricia Alfonso' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Transfer all previous tests for KASAN to KUnit so they can be run
> > more easily. Using kunit_tool, developers can run these tests with their
> > other KUnit tests and see "pass" or "fail" with the appropriate KASAN
> > report instead of needing to parse each KASAN report to test KASAN
> > functionalities. All KASAN reports are still printed to dmesg.
> >
> > Stack tests do not work in UML so those tests are protected inside an
> > "#if IS_ENABLED(CONFIG_KASAN_STACK)" so this only runs if stack
> > instrumentation is enabled.
> >
> > copy_user_test cannot be run in KUnit so there is a separate test file
> > for those tests, which can be run as before as a module.
>
> Hi Patricia,
>
> FWIW I've got some conflicts applying this patch on latest linux-next
> next-20200324. There are some changes to the tests in mm tree I think.
>
> Which tree will this go through? I would be nice to resolve these
> conflicts somehow, but I am not sure how. Maybe the kasan tests
> changes are merged upstream next windows, and then rebase this?
>
> Also, how can I apply this for testing? I assume this is based on some
> kunit branch? which one?
>
Hmm... okay, that sounds like a problem. I will have to look into the
conflicts. I'm not sure which tree this will go through upstream; I
expect someone will tell me which is best when the time comes. This is
based on the kunit branch in the kunit documentation here:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

> Why the copy_from_user tests can't be converted?
> It would be very nice to get rid of the modules entirely, rather than
> having 2 different test procedures because of 2 tests.
> Or, alternatively can there be other tests in future that can't be
> converted? Naming it "KASAN_USER" looks somewhat overspecialized. Say
> tomorrow we have another test that can't run under Kunit, but is not
> related to copt_from_user, should we create yet another module for it?
> I think the crux of that is that's a module, so a better name may be
> "KASAN_TEST_MODULE". Currently all tests that need to run as module
> are related to copy_from_user, but that's just an implementation
> detail.
>
When I converted the copy_user_tests into KUnit, I was getting a
kernel panic with a "Segfault with no mm." According to Brendan, since
KUnit starts a new kthread and is not invoked via a syscall, things
like copy_to_user won't work in the KUnit framework.

I agree that the naming is too specific, but is KASAN_TEST_MODULE too
generic since the current KASAN_TEST can be built as a module? Maybe
TEST_KASAN can be KUNIT_TEST_KASAN and TEST_KASAN_USER can be
TEST_KASAN_MODULE...

-- 
Best,
Patricia

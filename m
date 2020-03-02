Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB89C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A3B20848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzCkLslX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCBWhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:37:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42948 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBWhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:37:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id u3so374806plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 14:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4Md8j8zd2YWszLJ5ilbEdqON4mnmjdfj7ZdSWk0uFA=;
        b=gzCkLslXcjE5DvGXTBYEg8m27pTpEadwL3rR2WycF7BhdT0ydKD+o2TQip8TbNMkVI
         /E60kejzEW91h8D3B8uxc3eJ/etME05K7T4nykaplWOLVz7dXkeogT97J97jUVvP77jD
         W8/glAXkpDq327B/D/MGty6SkacKs0Op008RYQXPQ7Ru+qBVAjMUUksd+tqP5h4trgyI
         eJYQsgbr1U/WpriL9Ha25BPRdJoKjMrkyOjY7jwefb+Rzc6UPdJLPZlpTIuGtcPQJTP2
         VvvRlW2J+S0c9G4n3DCJmcYYP2npItu3nqsStYlzOvy70dZBJbyM9zWiucVyF9gWoZjE
         N4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4Md8j8zd2YWszLJ5ilbEdqON4mnmjdfj7ZdSWk0uFA=;
        b=dQxfCkZlXlVJpBPtMp0VL4dAyP8OtTKh2CFXAKY+5k9OR9kvucU6f/V6COKM5EF6bC
         HsJalHshGKvOMSrtXHckmbrDDRjiTXbqZQnqQftZjxiFERyDvc9/3pxX7Z/2Lo1m/PsW
         /jJlfJxpfXDPhyUAndlYSYWzvrnhw2B2E+kIvv7A1YlXyCG7o3LnZ4mSMxwrSgwW+0zY
         NOnEosrdSN2ydQsCMlbFUhlHFcuRa9KGwRlwyyvzFOGOMvEjtkwafwWjxN48PS0aytFb
         DPGIjUrK83iY3OkrxtcNi7JpZK3bjLPBj+csjG9W7HyfuzafmAv1GZge50ZP1Gmk0hvb
         zTtw==
X-Gm-Message-State: ANhLgQ0mXC+8QA6NRQ8RzYrwQm2ldqdcQaB+vqZjvuy7JhWv6HH3WHbM
        uOry30jXu8LpumK1rm9eo6dvLQQ3t83wkznW+8mLYg==
X-Google-Smtp-Source: ADFU+vvJg9TYunWwa9/vruRUJOOVxEikj7kVufuLKB2uZ8jHE55qbADssJYwm3IvxvrfibPxkmMW/caUQ/LpvYCCFKg=
X-Received: by 2002:a17:90a:3a90:: with SMTP id b16mr184340pjc.29.1583188619857;
 Mon, 02 Mar 2020 14:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <CACT4Y+Z_fGz2zVpco4kuGOVeCK=jv4zH0q9Uj5Hv5TAFxY3yRg@mail.gmail.com>
 <CAKFsvULZqJT3-NxYLsCaHpxemBCdyZN7nFTuQM40096UGqVzgQ@mail.gmail.com>
 <CACT4Y+YTNZRfKLH1=FibrtGj34MY=naDJY6GWVnpMvgShSLFhg@mail.gmail.com> <CAGXu5jKbpbH4sm4sv-74iHa+VzWuvF5v3ci7R-KVt+StRpMESg@mail.gmail.com>
In-Reply-To: <CAGXu5jKbpbH4sm4sv-74iHa+VzWuvF5v3ci7R-KVt+StRpMESg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Mar 2020 14:36:48 -0800
Message-ID: <CAFd5g47OHZ-6Fao+JOMES+aPd2vyWXSS0zKCkSwL6XczN4R7aQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Port KASAN Tests to KUnit
To:     Kees Cook <keescook@chromium.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 9:52 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Feb 29, 2020 at 10:39 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Sat, Feb 29, 2020 at 2:56 AM Patricia Alfonso
> > <trishalfonso@google.com> wrote:
> > > On Thu, Feb 27, 2020 at 6:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > .On Thu, Feb 27, 2020 at 3:44 AM Patricia Alfonso
> > > > > -       pr_info("out-of-bounds in copy_from_user()\n");
> > > > > -       unused = copy_from_user(kmem, usermem, size + 1);
> > > >
> > > > Why is all of this removed?
> > > > Most of these tests are hard earned and test some special corner cases.
> > > >
> > > I just moved it inside IS_MODULE(CONFIG_TEST_KASAN) instead because I
> > > don't think there is a way to rewrite this without it being a module.
> >
> > You mean these are unconditionally crashing the machine? If yes,
> > please add a comment about this.
> >
> > Theoretically we could have a notion of "death tests" similar to gunit:
> > https://stackoverflow.com/questions/3698718/what-are-google-test-death-tests
> > KUnit test runner wrapper would need to spawn a separete process per
> > each such test. Under non-KUnit test runner these should probably be
> > disabled by default and only run if specifically requested (a-la
> > --gunit_filter/--gunit_also_run_disabled_tests).
> > Could also be used to test other things that unconditionally panic,
> > e.g. +Kees may be happy for unit tests for some of the
> > hardening/fortification features.
> > I am not asking to bundle this with this change of course.
>
> A bunch of LKDTM tests can kill the system too. I collected the list
> when building the selftest script for LKDTM:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/lkdtm/tests.txt
>
> I'm all for unittests (I have earlier kind-of-unit-tests in
> lib/test_user_copy.c lib/test_overflow.c etc), but most of LKDTM is

<Minor tangent (sorry)>

I took a brief look at lib/test_user_copy.c, it looks like it doesn't
use TAP formatted output. How do you feel about someone converting
them over to use KUnit? If nothing else, it would be good getting all
the unit-ish tests to output in the same format.

I proposed converting over some of the runtime tests over to KUnit as
a LKMP project (Linux Kernel Mentorship Program) here:

https://wiki.linuxfoundation.org/lkmp/lkmp_project_list#convert_runtime_tests_to_kunit_tests

I am curious what you think about this.

</Minor tangent>

> designed to be full system-behavior testing ("does the system correct
> BUG the current thread, when some deeper system state is violated?")

Makes sense.

Thanks!

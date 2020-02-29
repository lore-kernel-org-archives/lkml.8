Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F26C3F2D2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 01:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B6E2468D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 01:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Irm3kkRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgB2BXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 20:23:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52936 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgB2BXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 20:23:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so5404769wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/7YNCxPMBaPfRc0r6hwDsD4AYhHuz/+hoGyVq9vhR0=;
        b=Irm3kkRLYMDUDnNN3uPknJSw6y6RPEolglih7qe1Xv0+i5lIJVxspusNEcB/2ZQGds
         NvZ4AoOZQcDlOnv+9Ibvb2DNpNICXcYiY40+86thILBIrsXTg9ulcNAtvJbW9ZLi+CMn
         LKJ/FMnlD2cIEdwDlogDNQBxPO+INsL5AXGgiN5Mb92+XhtrHQLefbhLqNrj/GRBF/pD
         1GeCTfYEvaf3JUN4fX9kg2xaAycWqEMPwYr41eugmvLVgwWmb9YSGDFWrKFMuP+LuEw2
         bHNg4RDSSakp3qzEmmkTU2F4MaSWAhG718xG6TdXIDLPyKv8koZnwLqrb1kXEPAqyA2m
         8OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/7YNCxPMBaPfRc0r6hwDsD4AYhHuz/+hoGyVq9vhR0=;
        b=kvgf31obIxa0JM4WrL4ngnp2Myy5SIuORLXqzZl/ZjTBNc1g5/fS/tFTlMVQXoYYnC
         y7FY+h4iP95RzQHQ6Qizv4UCjvqLHa4OEmllzzjCOVFB20Cgbx04k1YIGU4zg4392ce2
         iE3q2DfxSZTbauZicAvAfjdwFyZVxWKR08/N2fLGl8XKopjOiZR/JY6nDG1s+hLHXifz
         nVPWmkfsictFC3ldyI0BA1Y8rnX0fdxOUZTAOl86x3tIfEZyKx3DCXIhNl22y7H1FKmW
         5thTk8QXXNyoDrLb8MgQayxM49EF2NwyamQPIcUdEAKrBnLsGGm6XG6M1M0ZfxQjfsBf
         Z0/Q==
X-Gm-Message-State: APjAAAXgTmKGn8JdVjjfQ7+NFa57dfMWMr1/7KQXsFvia+pSfvshLjD6
        7QKrW5uQCSoqMTwkEBzKwYtmY12aPyAZNYyHZBODrQ==
X-Google-Smtp-Source: APXvYqzQhxXCwL795xtkqGSlBVQ1HoOyROAl6OSEGKhT6D00L+2+s+oVhuOu/ADLRgmKmQtZKuqq+BDvu+dhn85KPro=
X-Received: by 2002:a1c:3204:: with SMTP id y4mr7078376wmy.166.1582939398894;
 Fri, 28 Feb 2020 17:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
In-Reply-To: <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Fri, 28 Feb 2020 17:23:07 -0800
Message-ID: <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 6:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Integrate KASAN into KUnit testing framework.
> >  - Fail tests when KASAN reports an error that is not expected
> >  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> >  - KUnit struct added to current task to keep track of the current test
> > from KASAN code
> >  - Booleans representing if a KASAN report is expected and if a KASAN
> >  report is found added to kunit struct
> >  - This prints "line# has passed" or "line# has failed"
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > ---
> > If anyone has any suggestions on how best to print the failure
> > messages, please share!
> >
> > One issue I have found while testing this is the allocation fails in
> > kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> > does cause the test to fail on the KUnit side, as expected, but it
> > seems to skip all the tests before this one because the output starts
> > with this failure instead of with the first test, kmalloc_oob_right().
>
> I don't follow this... we don't check output in any way, so how does
> output affect execution?...
>
I'm sorry. I think I was just reading the results wrong before - no
wonder I was confused!

I just recreated the error and it does work as expected.

>
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
> >                 return True
> >
> >         def run_kernel(self, args=[], timeout=None, build_dir=''):
> > -               args.extend(['mem=256M'])
> > +               args.extend(['mem=256M', 'kasan_multi_shot'])
>
> This is better done somewhere else (different default value if
> KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
> Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
> to be a mandatory part now. This means people will always hit this, be
> confused, figure out they need to flip the value, and only then be
> able to run kunit+kasan.
>
I agree. Is the best way to do this with "bool multishot =
kasan_save_enable_multi_shot();"  and
"kasan_restore_multi_shot(multishot);" inside test_kasan.c like what
was done in the tests before?

-- 
Thank you,
Patricia Alfonso

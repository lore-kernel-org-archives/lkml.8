Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754BBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 06:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441AF24680
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 06:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCSbN2e3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgCAG3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 01:29:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41560 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgCAG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 01:29:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id b5so7112687qkh.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 22:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfUac2pOIQmqTpyyGG2W9XwtOZbpDu9LEjx7cpEyrZg=;
        b=pCSbN2e3Mm4pNp7g6N5hKQxc7G5FqfEZ/6N/FbYgI+NaTqvSPxcjxJSpYV6rCVsvQy
         ZNQ1Z7p6mfHx90tkNorEfvC4v+SwcA0G+UYoRwOcxm/JdVR3qAvz8qrpQUExX9UAqRZS
         PezoKqcMSgEgByqeJbPE8nKoFIcstlzB2x+w2kf90u2PUCiDK5LFvjPBxkLM40GvR/mb
         oSHod7cYUtAePjsOXYZluoKGmPex0euZTbIr7vag8eSWjjmJ7tgABSbkse5rizqi6+tw
         cYfr+JJwVofhn4kAcPVqXNGs+PN11yua58WEvn8Sor7NjDgNHCoEC+1YvH9Z8Q542m5H
         ySAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfUac2pOIQmqTpyyGG2W9XwtOZbpDu9LEjx7cpEyrZg=;
        b=F5Cn8yTf1R4dUFejcHZnyBW26zFel/M1XBkiQUU3LBZxoQrbeSExad2cySLOm6Zf0f
         hhJl/5FMd5l0l1jGCzs6OYfguYbuapZ3lGbZgU5s+UAj0n+YdkeU6nSCuDbEW8WlVf+Z
         ARan4ArCw6S5r0JCzGTNtvpztQPkQkovs6Kn5s+k6gZWvsV+6It9HEP6YpEslVjIIhCw
         UnbWxYf2YytlHEn34rvYm6NTM3tHpfzW55aTUbYC7Gm4M/qk9jj15GcF1bhMZ3VUtXfP
         4dyZK20SZvU8jVtvjwIHIJfj6ATrFAKtUwHIj5vxj5Y/WRWUvXwuexmMax2Cgv/cbxvF
         2F0Q==
X-Gm-Message-State: APjAAAVQIeFwb+N5hqKrCokkTJuuTooapE5BbE34BpK1AXEKU9xK5CeX
        8owo1z8+vdOFJPkXgB0sVJHJJTdLJhcJL+4Ae8hl9QyRzx5a/N5I
X-Google-Smtp-Source: APXvYqwa6S/h+fq5wA1PB0+OZP5ZIF+wJeuXjDfZV6l/ek9M1Hs4KxnOgp3vVhuRpnXIScGUa+0ARGzfOo2O/VflhAk=
X-Received: by 2002:a37:88b:: with SMTP id 133mr10838393qki.256.1583044158382;
 Sat, 29 Feb 2020 22:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
 <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
In-Reply-To: <CAKFsvUJFovti=enpOefqMbtQpeorihQhugH3-1nv0BBwevCwQg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 1 Mar 2020 07:29:07 +0100
Message-ID: <CACT4Y+Y-zoiRfDWw6KJr1BJO_=yTpFsVaHMng5iaRn9HeJMNaw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 2:23 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > >
> > > Integrate KASAN into KUnit testing framework.
> > >  - Fail tests when KASAN reports an error that is not expected
> > >  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> > >  - KUnit struct added to current task to keep track of the current test
> > > from KASAN code
> > >  - Booleans representing if a KASAN report is expected and if a KASAN
> > >  report is found added to kunit struct
> > >  - This prints "line# has passed" or "line# has failed"
> > >
> > > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > > ---
> > > If anyone has any suggestions on how best to print the failure
> > > messages, please share!
> > >
> > > One issue I have found while testing this is the allocation fails in
> > > kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> > > does cause the test to fail on the KUnit side, as expected, but it
> > > seems to skip all the tests before this one because the output starts
> > > with this failure instead of with the first test, kmalloc_oob_right().
> >
> > I don't follow this... we don't check output in any way, so how does
> > output affect execution?...
> >
> I'm sorry. I think I was just reading the results wrong before - no
> wonder I was confused!
>
> I just recreated the error and it does work as expected.
>
> >
> > > --- a/tools/testing/kunit/kunit_kernel.py
> > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
> > >                 return True
> > >
> > >         def run_kernel(self, args=[], timeout=None, build_dir=''):
> > > -               args.extend(['mem=256M'])
> > > +               args.extend(['mem=256M', 'kasan_multi_shot'])
> >
> > This is better done somewhere else (different default value if
> > KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
> > Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
> > to be a mandatory part now. This means people will always hit this, be
> > confused, figure out they need to flip the value, and only then be
> > able to run kunit+kasan.
> >
> I agree. Is the best way to do this with "bool multishot =
> kasan_save_enable_multi_shot();"  and
> "kasan_restore_multi_shot(multishot);" inside test_kasan.c like what
> was done in the tests before?

This will fix KASAN tests, but not non-KASAN tests running under KUNIT
and triggering KASAN reports.
You set kasan_multi_shot for all KUNIT tests. I am reading this as
that we don't want to abort on the first test that triggered a KASAN
report. Or not?

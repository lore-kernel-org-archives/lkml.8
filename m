Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D5C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DFF2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mw7wWn7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgAQKFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:05:30 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43760 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAQKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:05:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so22104824qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 02:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/2c5M/UzJFnbWr1rvLc1suSEZvfABkxh5yg/ucrfTY=;
        b=Mw7wWn7P4s/MDlKKDeO2hCa7cduHamni/cV2VqAPosAt6si42jbxLnx+IUNOF7B/Xx
         if4jxxq3BIl5hm8W0DWkksygQWmW3YxDC6CK8ibhrPC2tvqh7HoEKYcJgYAH/Ummi20h
         I9H8RoUJoqUR44gfg1N3dIdTZix4xCDKE/ZjyVYpHXsSBHEr0I552pxJMKvvItl8Yht8
         avKxub0Bu33Sx6p6daRqXSJ5DCOb/u+WPYBvJotCUdVId7Yfj0nw8N5IIYnkMAOEC9DN
         3qXBAQQ/PE+8wLsmLUcvDbH1Mm+8dS7ScL2hkkB4b7S4ofHHpoQafskioxmHEqnka/Vf
         KcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/2c5M/UzJFnbWr1rvLc1suSEZvfABkxh5yg/ucrfTY=;
        b=VhFLZes3Kal+3p/aBFGzMOEL+FRwGsDnXTom8LVmEQh/HjPeKGrGKcxQEKHzD1OUx7
         LYYlWDCMYqixCN8qAxvRwvQZGbNjnqu93xnvMQ4vXo8+pN5hLHhrm/XXXSBPHWAvPU2i
         73h79AU0eDvaiASWmwhi8XemYVp43VPcmb4NiEkgwWaaQiO7X8DDG+q1XjIcn9ESuWiY
         X/fu8RK3L7AjTusV9J9/LNxh1ItOmBMNxUFGc1W8Lpja92W2vUivJ1W8EjX7d/ptjCJd
         WEkuYDzisnvICANrEro0jv0vhTsd3t75UOddByI1wqaZMpuAvkHMof68R1XuumiTc04Q
         eZ0w==
X-Gm-Message-State: APjAAAVMfSShlE+j7KRmaXzZuyggnujep993zxibWrisWqWj7aJw5Ifa
        nZ3CEDnnwIgVi7RYo8ZDqRVTyAyDOjrvNqbRrOnprg==
X-Google-Smtp-Source: APXvYqzAcVzOjTPbD6iv5XUDBRr1aI5aw0yrjPVM25XzN7IeyHsXe9f0JkYTbzdSlJzJmkpY7VaHrU9F9pCJQUXtoMU=
X-Received: by 2002:a37:5841:: with SMTP id m62mr36462569qkb.256.1579255527934;
 Fri, 17 Jan 2020 02:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
 <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
 <CACT4Y+brqD-o-u3Vt=C-PBiS2Wz+wXN3Q3RqBhf3XyRYaRoZJw@mail.gmail.com>
 <2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel@sipsolutions.net>
 <CACT4Y+b6C+y9sDfMYPDy-nh=WTt5+u2kLcWx2LQmHc1A5L7y0A@mail.gmail.com>
 <CACT4Y+atPME1RYvusmr2EQpv_mNkKJ2_LjMeANv0HxF=+Uu5hw@mail.gmail.com> <CACT4Y+bsaZoPC1Q7_rV-e_aO=LVPA-cE3btT_VARStWYk6dcPA@mail.gmail.com>
In-Reply-To: <CACT4Y+bsaZoPC1Q7_rV-e_aO=LVPA-cE3btT_VARStWYk6dcPA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Jan 2020 11:05:15 +0100
Message-ID: <CACT4Y+Z6_CwVyJhr3SdDejFsrXcM11LVY+gh4oKP6k03Pn95AA@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        anton.ivanov@cambridgegreys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Jan 17, 2020 at 10:59 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Jan 16, 2020 at 10:39 PM Patricia Alfonso
> > <trishalfonso@google.com> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 1:23 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > On Thu, Jan 16, 2020 at 10:20 AM Johannes Berg
> > > > <johannes@sipsolutions.net> wrote:
> > > > >
> > > > > On Thu, 2020-01-16 at 10:18 +0100, Dmitry Vyukov wrote:
> > > > > >
> > > > > > Looking at this problem and at the number of KASAN_SANITIZE := n in
> > > > > > Makefiles (some of which are pretty sad, e.g. ignoring string.c,
> > > > > > kstrtox.c, vsprintf.c -- that's where the bugs are!), I think we
> > > > > > initialize KASAN too late. I think we need to do roughly what we do in
> > > > > > user-space asan (because it is user-space asan!). Constructors run
> > > > > > before main and it's really good, we need to initialize KASAN from
> > > > > > these constructors. Or if that's not enough in all cases, also add own
> > > > > > constructor/.preinit array entry to initialize as early as possible.
> > > > >
> > >
> > > I am not too happy with the number of KASAN_SANITIZE := n's either.
> > > This sounds like a good idea. Let me look into it; I am not familiar
> > > with constructors or .preint array.
> > >
> > > > > We even control the linker in this case, so we can put something into
> > > > > the .preinit array *first*.
> > > >
> > > > Even better! If we can reliably put something before constructors, we
> > > > don't even need lazy init in constructors.
> > > >
> > > > > > All we need to do is to call mmap syscall, there is really no
> > > > > > dependencies on anything kernel-related.
> > > > >
> > > > > OK. I wasn't really familiar with those details.
> > > > >
> > > > > > This should resolve the problem with constructors (after they
> > > > > > initialize KASAN, they can proceed to do anything they need) and it
> > > > > > should get rid of most KASAN_SANITIZE (in particular, all of
> > > > > > lib/Makefile and kernel/Makefile) and should fix stack instrumentation
> > > > > > (in case it does not work now). The only tiny bit we should not
> > > > > > instrument is the path from constructor up to mmap call.
> > >
> > > This sounds like a great solution. I am getting this KASAN report:
> > > "BUG: KASAN: stack-out-of-bounds in syscall_stub_data+0x2a5/0x2c7",
> > > which is probably because of this stack instrumentation problem you
> > > point out.
> >
> > [reposting to the list]
> >
> > If that part of the code I mentioned is instrumented, manifestation
> > would be different -- stack instrumentation will try to access shadow,
> > shadow is not mapped yet, so it would crash on the shadow access.
> >
> > What you are seeing looks like, well, a kernel bug where it does a bad
> > stack access. Maybe it's KASAN actually _working_? :)
>
> Though, stack instrumentation may have issues with longjmp-like things.
> I would suggest first turning off stack instrumentation and getting
> that work. Solving problems one-by-one is always easier.
> If you need help debugging this, please post more info: patch, what
> you are doing, full kernel output (preferably from start, if it's not
> too lengthy).

I see syscall_stub_data does some weird things with stack (stack
copy?). Maybe we just need to ignore accesses there: individual
accesses, or whole function/file.

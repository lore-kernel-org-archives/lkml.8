Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C104C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020C321741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HR7uoCJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgBFSdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:33:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:33:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so8455077wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/o0TABmh3sA91z50JGeWR2QdDzZnMyxEswlhRW37yD8=;
        b=HR7uoCJJz73XXlC0tOxO2Tberzt+iuXFO7P4ixPw59zFnM5LttKSdf1tK9bRyAf3ka
         Cez5zxvwnBT7fJBnQ67tpaiouvNPQkKlpM62Rege6LCx2tSl2klKpsGsNk1zSshJSFRu
         FuGRvMh/ZCCsriTwBwTmSYNjePD9OPMT33VMFZSVk0gM5mYVnvt+OEMeWjL6dkKTVCgF
         sM0DFsahxxbvFSeltgIWn/b6lzvQQmDgav9bM2cUnKE9gHSBknhyx1jhX4s6EETMLgBX
         +EjI/i9GazD9vusTFNnsYDo9J3GXYXUZTO47N9ILD/BLLdwQYAt85BoFNwitlYdzsY/d
         /nsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/o0TABmh3sA91z50JGeWR2QdDzZnMyxEswlhRW37yD8=;
        b=fUPqSqZi35cBi3EXH92+YRPQXz+konL0xz4Zo0KCZBrhvYZ8RxTPP3eveqT6bWCrGX
         QEAX9i6MvdYbajp0j1KAXrtkRG3G3zpH64KIVhKbfjvuPS/wGy+RNTviiRdPhtkvOxXa
         /10tyTSgmuSRegv6ZnvRk6DqGJNKTEEE/U+nBWjevoy71ilF1SPRX86ALbp++j/6ReuC
         nUONvJudAYeJ2WKbSFuH9mgGGRj6jrhPG9xHe6a2H+DYWxn2EbYZ1BCURWEMp8f0dqdp
         TlJ0NBsZB1ka/HtNYYsfl8uK5SGX2EWPWy5BQTibnMyyFylo8TjCaa40lV+8ESCmZw3o
         /PVQ==
X-Gm-Message-State: APjAAAX34H4wZWVMRUfi3IsL9rSJdttY08tPXPXVFgIINK6BDGngkFJH
        JYebu/dB7sLn/PB3loXnsjUdc+VORW9TgVNdLMq0Rw==
X-Google-Smtp-Source: APXvYqyO7B6UBrWxHoZXCXiOleCEOatPxvuRTAcGxPS9KZaihVadCBanUHVq7vvpyCENHPfeoHcATMP4/PrwGyfLELQ=
X-Received: by 2002:a05:6000:108e:: with SMTP id y14mr5254368wrw.338.1581013999924;
 Thu, 06 Feb 2020 10:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
 <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
 <CACT4Y+brqD-o-u3Vt=C-PBiS2Wz+wXN3Q3RqBhf3XyRYaRoZJw@mail.gmail.com>
 <2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel@sipsolutions.net>
 <CACT4Y+b6C+y9sDfMYPDy-nh=WTt5+u2kLcWx2LQmHc1A5L7y0A@mail.gmail.com>
 <CACT4Y+atPME1RYvusmr2EQpv_mNkKJ2_LjMeANv0HxF=+Uu5hw@mail.gmail.com>
 <CACT4Y+bsaZoPC1Q7_rV-e_aO=LVPA-cE3btT_VARStWYk6dcPA@mail.gmail.com> <CACT4Y+Z6_CwVyJhr3SdDejFsrXcM11LVY+gh4oKP6k03Pn95AA@mail.gmail.com>
In-Reply-To: <CACT4Y+Z6_CwVyJhr3SdDejFsrXcM11LVY+gh4oKP6k03Pn95AA@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Thu, 6 Feb 2020 10:33:08 -0800
Message-ID: <CAKFsvULhg7i=tuw1LMS9avy4-NgDDfK2k-_kCa3CH3sNRXa0Qw@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
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

On Fri, Jan 17, 2020 at 2:05 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Jan 17, 2020 at 11:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, Jan 17, 2020 at 10:59 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 10:39 PM Patricia Alfonso
> > > <trishalfonso@google.com> wrote:
> > > >
> > > > On Thu, Jan 16, 2020 at 1:23 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > >
> > > > > On Thu, Jan 16, 2020 at 10:20 AM Johannes Berg
> > > > > <johannes@sipsolutions.net> wrote:
> > > > > >
> > > > > > On Thu, 2020-01-16 at 10:18 +0100, Dmitry Vyukov wrote:
> > > > > > >
> > > > > > > This should resolve the problem with constructors (after they
> > > > > > > initialize KASAN, they can proceed to do anything they need) and it
> > > > > > > should get rid of most KASAN_SANITIZE (in particular, all of
> > > > > > > lib/Makefile and kernel/Makefile) and should fix stack instrumentation
> > > > > > > (in case it does not work now). The only tiny bit we should not
> > > > > > > instrument is the path from constructor up to mmap call.
> > > >

By initializing KASAN as the first thing that executes, I have been
able to get rid of most of the "KASAN_SANITIZE := n" lines and I am
very happy about that. Thanks for the suggestions!

> > > If that part of the code I mentioned is instrumented, manifestation
> > > would be different -- stack instrumentation will try to access shadow,
> > > shadow is not mapped yet, so it would crash on the shadow access.
> > >
> > > What you are seeing looks like, well, a kernel bug where it does a bad
> > > stack access. Maybe it's KASAN actually _working_? :)
> >
> > Though, stack instrumentation may have issues with longjmp-like things.
> > I would suggest first turning off stack instrumentation and getting
> > that work. Solving problems one-by-one is always easier.
> > If you need help debugging this, please post more info: patch, what
> > you are doing, full kernel output (preferably from start, if it's not
> > too lengthy).
>
> I see syscall_stub_data does some weird things with stack (stack
> copy?). Maybe we just need to ignore accesses there: individual
> accesses, or whole function/file.

It is still not clear whether the syscall_stub_data errors are false
positives, but while moving the kasan_init() to be as early as
possible in main(), I ran into a few more stack-related errors like
this(show_stack, dump_trace, and get_wchan). I will be taking your
advice to focus on one thing at a time and temporarily disable stack
instrumentation wherever possible.

--
Patricia Alfonso

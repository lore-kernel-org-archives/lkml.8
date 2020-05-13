Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E44CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C192064E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bh9kVRB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbgEMN6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbgEMN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:58:43 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173CEC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:58:43 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k110so13461017otc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKVsm8+o6TWBeM8ddWuZqPxPRMMfRRMfxWfMoYOLd8o=;
        b=Bh9kVRB6kF/GhfSyWtETid4E9wHv43XaApaVooXoGG3KtCGBncXa2KTeXQxRzEMFUk
         ptqPaMh1EpA/UWNxL1LyDqrrJ+BXO13jqKYg9Jp0nU14JMEa1A1NiPDLnrZnWrrxKEnI
         hGnJaFnOtgz6c6nKKiGTNUwxgDRr8pcvOtCOkFDQEy4R0QE/ED6dsnF7QRdDyFUEj9aR
         S6iTcIVlwdRj6/0VyStHMyGb3IVfh89mKgjYS3h0l0zc+se7SR6rXjAzEWBmrp1fNCOi
         vcdNsW1S01fV8KhME4yRPw6Vh3U2rTAViLFjDsa/HjopVg1lFmZ4gQ+vk/npuPG+q2Bx
         qtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKVsm8+o6TWBeM8ddWuZqPxPRMMfRRMfxWfMoYOLd8o=;
        b=Pi5epyqQpfgZOjoV7ZHBFMdjLavu3IaPVy3HbUvQGuwFFCILDV7hzIDjUoTgroMWd1
         uDdiQp+6ZXGbJLdo21tjL6/3oI6aYRMhNuy7bNsUA8p5hyEzeDfgQOjzaIJfCX1EsZGV
         dnE8qpayNgvtw2yCM29C5fBeqRHYouSSStYpsETb/jcpdWjdYxx851UQfP3J4+aVKe0t
         v4lOzuyvkZsYnOrMoy0CmTNB+Lb8c1tcbDDW7Yqh8oTmkrGQUi3Izg6XxyWycp4QJP+1
         kVamDpmID2p1FClJOSL+ewTVzBMr4HM7uId2/8QhCBtlEfi4A9PinTkj1gyjnpEoDtMr
         u2YQ==
X-Gm-Message-State: AGi0PubTwa58f6e7o2B6suZlejExOj98Ejoun70RUib5oO0E+gpotsxk
        I2RkvhIZoJ9l/GciJogIZSfQax6EU9uxxVXfCgn8kA==
X-Google-Smtp-Source: APiQypJAvYzkcjz+e408MEhqolljbG/GLTKVI77GJ4T6SVKnGE64i5TZXzLt6xTpoB/TB68drudQ4zRKJi6Q8Uv57FY=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr19281082oto.251.1589378322170;
 Wed, 13 May 2020 06:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-1-will@kernel.org> <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net> <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net> <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com> <20200513132440.GN2978@hirez.programming.kicks-ass.net>
In-Reply-To: <20200513132440.GN2978@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 May 2020 15:58:30 +0200
Message-ID: <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 15:24, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> > So far so good, except: both __no_sanitize_or_inline and
> > __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> > just doesn't avoid explicit kcsan_check calls, like those in
> > READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> > just because macros won't be redefined just for __no_sanitize
> > functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> > access is unchecked.
> >
> > This will have the expected result:
> > __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> >
> > This will not work as expected:
> > __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> > races are reported
> >
> > All this could be fixed if GCC devs would finally take my patch to
> > make -fsanitize=thread distinguish volatile [1], but then we have to
> > wait ~years for the new compilers to reach us. So please don't hold
> > your breath for this one any time soon.
> > [1] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html
>
> Right, but that does not address the much larger issue of the attribute
> vs inline tranwreck :/

Could you check if Clang is equally broken for you? I think GCC and
Clang have differing behaviour on this. No idea what it takes to fix
GCC though.

> Also, could not this compiler instrumentation live as a kernel specific
> GCC-plugin instead of being part of GCC proper? Because in that case,
> we'd have much better control over it.

I'd like it if we could make it a GCC-plugin for GCC, but how? I don't
see a way to affect TSAN instrumentation. FWIW Clang already has
distinguish-volatile support (unreleased Clang 11).

Thanks,
-- Marco

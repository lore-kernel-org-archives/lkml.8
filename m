Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD41DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3362088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijypAQ4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406872AbgE1Twe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406777AbgE1Twa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:52:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3619C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:52:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z26so14090037pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYeCBR8WcHvQvd56ESdKiIjSS5Wn/icLWSDDTkY8XKE=;
        b=ijypAQ4/yyd1YirR5cHvOXLAjtgHARrUwzdEYMBVk/zH9yyhDrXNxt/299kmAjJvgy
         SJ07l+qlPgfprRo2yjMg4EpIOKlrVaXPIce4XXSXuCYrSTJxudxY7HalbqjLWvJOzthb
         XQbf2Nd3AtptJKIwZnyE+Xjl5ujg3RfXFNGfWh3n577xAWG4fD2HjUxzUCEnDQy6BBya
         yyY8vJjW5rpVoCfCDunVQxFmwiuKQ5dtZIAjCU4rFhMPFAR0gJU+sFWO3YM1hjk4u89B
         VOREz8CxXA/efyohLyhBHxuUEJ6zYdcxW3Gjv1StwI0TyrA4QlqklUP7F6L4HDtLfFMH
         wFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYeCBR8WcHvQvd56ESdKiIjSS5Wn/icLWSDDTkY8XKE=;
        b=eTulfLKhhrgR+UndbX7GfRNnWJ1273GwoRzX1Pd3TH73ZkYfO4V+grZ220OtMcPjO0
         T8EnUpBafoKtf3h8ZfRSoV22OHlqIP65ZRX2Vq7yWQs7Z4o0rxZmdFbKg0/8f45ubVzc
         MFkkWvgCkrEcL4NSINpyq/gGrJyjNPmsyt0r6vMLtNk4H+5gcCoFhv5Ur4PQwvXynVWM
         BdaVn8CyBNviVn/ef+1gVWzz/fie808HO08lkkuazOJGBT2b1WGtriob6Ed0JD+D40bX
         9uYdy9a2Q/denob6NSXtzLmSoY62gy3iKZ7XmWUtjF58XNBr25EZ7qtFpwyyCDbYrK8i
         rwuQ==
X-Gm-Message-State: AOAM532u45cMhz7Lt/yL4M9TdhSoLsk49wAleAtpSktOFr+uBqI/E/VK
        pmJ3CmilHXjd21ckeBNYY0vZh1cdxV8GuUSsv5lIUg==
X-Google-Smtp-Source: ABdhPJy8JDke2PPzDQ1TIDC58xlt6v3VOvLf4PuWPFKjuGyFqhahFziQQmnxrZSFyzABewvh4hWv1JHQfCJif5Sje8I=
X-Received: by 2002:a63:d04b:: with SMTP id s11mr4435032pgi.384.1590695548943;
 Thu, 28 May 2020 12:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com> <alpine.LRH.2.21.2005031101130.20090@localhost>
 <26d96fb9-392b-3b20-b689-7bc2c6819e7b@kernel.org> <CABVgOS=MueiJ6AHH6QUSWjipSezi1AvggxBCrh0Q9P_wa55XZQ@mail.gmail.com>
In-Reply-To: <CABVgOS=MueiJ6AHH6QUSWjipSezi1AvggxBCrh0Q9P_wa55XZQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 12:52:17 -0700
Message-ID: <CAFd5g46Y-9vSSSke05hNyOoj3=OXcJh8bHGFciDVnwkSrpcjZw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] KUnit-KASAN Integration
To:     David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 7:51 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, May 23, 2020 at 6:30 AM shuah <shuah@kernel.org> wrote:
> >
> > On 5/3/20 4:09 AM, Alan Maguire wrote:
> > > On Thu, 23 Apr 2020, David Gow wrote:
> > >
> > >> This patchset contains everything needed to integrate KASAN and KUnit.
> > >>
> > >> KUnit will be able to:
> > >> (1) Fail tests when an unexpected KASAN error occurs
> > >> (2) Pass tests when an expected KASAN error occurs
> > >>
> > >> Convert KASAN tests to KUnit with the exception of copy_user_test
> > >> because KUnit is unable to test those.
> > >>
> > >> Add documentation on how to run the KASAN tests with KUnit and what to
> > >> expect when running these tests.
> > >>
> > >> This patchset depends on:
> > >> - "[PATCH v3 kunit-next 0/2] kunit: extend kunit resources API" [1]
> > >> - "[PATCH v3 0/3] Fix some incompatibilites between KASAN and
> > >>    FORTIFY_SOURCE" [2]
> > >>
> > >> Changes from v6:
> > >>   - Rebased on top of kselftest/kunit
> > >>   - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
> > >>     incompatibilites [2]
> > >>   - Removed a redundant report_enabled() check.
> > >>   - Fixed some places with out of date Kconfig names in the
> > >>     documentation.
> > >>
> > >
> > > Sorry for the delay in getting to this; I retested the
> > > series with the above patchsets pre-applied; all looks
> > > good now, thanks!  Looks like Daniel's patchset has a v4
> > > so I'm not sure if that will have implications for applying
> > > your changes on top of it (haven't tested it yet myself).
> > >
> > > For the series feel free to add
> > >
> > > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > >
> > > I'll try and take some time to review v7 shortly, but I wanted
> > > to confirm the issues I saw went away first in case you're
> > > blocked.  The only remaining issue I see is that we'd need the
> > > named resource patchset to land first; it would be good
> > > to ensure the API it provides is solid so you won't need to
> > > respin.
> > >
> > > Thanks!
> > >
> > > Alan
> > >
> > >> Changes from v5:
> > >>   - Split out the panic_on_warn changes to a separate patch.
> > >>   - Fix documentation to fewer to the new Kconfig names.
> > >>   - Fix some changes which were in the wrong patch.
> > >>   - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)
> > >>
> > >
> >
> > Hi Brendan,
> >
> > Is this series ready to go inot Linux 5.8-rc1? Let me know.
> > Probably needs rebase on top of kselftest/kunit. I applied
> > patches from David and Vitor
> >
> > thanks,
> > -- Shuah
> >
>
> Hi Shuah,
>
> I think the only things holding this up are the missing dependencies:
> the "extend kunit resources API" patches[1] for KUnit (which look
> ready to me), and the "Fix some incompatibilities between KASAN and
> FORTIFY_SOURCE" changes[2] on the KASAN side (which also seem ready).
>
> This patchset may need a (likely rather trivial) rebase on top of
> whatever versions of those end up merged: I'm happy to do that if
> necessary.
>
> Cheers,
> -- David
>
> [1]: https://lore.kernel.org/linux-kselftest/1585313122-26441-1-git-send-email-alan.maguire@oracle.com/T/#t
> [2]: http://lkml.iu.edu/hypermail/linux/kernel/2004.3/00735.html

As David pointed out, this series is waiting on its dependencies.
Sorry, I thought the "extend KUnit resources API" patchset was ready
to go, but I realized I only gave a reviewed-by to one of the patches.
Both have been reviewed now, but one patch needs a minor fix.

As for other patches, the patches from David, Vitor, and Anders should
cover everything. Thanks!

Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B86C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A4207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sew6Y1J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHSQ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgHSQ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:56:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E8C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:56:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x6so11669869pgx.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fw18yt5oodIRRiawAuh3iFJI1I/EC1h04v5SNRebUsg=;
        b=Sew6Y1J2+dlN3Uy+W3XUFS6PgjkaKPbXMVxa7xBZ+gCv4djz6NyGAIbaXCwueFoTYe
         iyIbA4f1MeJTnuO0RwXLrXDPus/ZPDbPZXDHXtMKSMpAUGVNWilkA0q4h1eIvPjo4odh
         p6rpR7pBpdtWyCiQG1pVi+2EuCslEn/Udct8hfSa5tixiLe8SEDiE18ryRA7sWYR0Fdr
         V/S2FWeeU1PwzxAEVGFDIvGK+v1o+lPEvoPeJfodr9WOqy0Vks2G83dG6esuDiYeMRC+
         lL05EcmyMvEnWLTlZqU9oRYLn0ySCUDnqtMGYOMWgvR6uvNpSg6cDwRLeuA4GPlFvHpe
         xjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fw18yt5oodIRRiawAuh3iFJI1I/EC1h04v5SNRebUsg=;
        b=aQkwXDpnqGq1kO2yHLeGAchyMcgDCTuMzi5LNQpD+MX9x3KhrPJHiwvqJKsoWEkWEp
         a+SR2WLuMWrEcvw3czAzCYCh1MYALWIJVtCflnfiXXttzm74GIDYK5HJpb28RqrDxEIc
         dspk9ClkKyav5MuxMeOXe3yzLdpBriHD+gncw8+oePH2mnYqnfPDUMVKXJ2w0QKSqx0u
         DnUlMefcbsQv8r94uBfdjkMbYAi4MQQa29gS7Bwvf/hcJT3bN/DLg418IsOpZg431bui
         94zm822rivamxDw57amlC1tqgIgjMqyMoGeN7vxZV7SEJbG5rsQ01g/L+GzY48afKOGj
         8YFw==
X-Gm-Message-State: AOAM531b3TYC/1oxx3Cc4KzUJj34X8W/CeSJQYaNK7QgvQlpmk3EC6HO
        1bQOg//p8lkR3xSwdq8uYhjBerFlZJoB/8h1lgWE9A==
X-Google-Smtp-Source: ABdhPJzOWbQWvNJq8r8P1UhTJyhu2WyFpFjSVInsNFgdbZK2Da66wr9Md6WMUOHmlaNm9oKe0eLSigHu+DmV7vDjPMw=
X-Received: by 2002:aa7:96e5:: with SMTP id i5mr16953870pfq.108.1597856160632;
 Wed, 19 Aug 2020 09:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200819094437.GE1891694@smile.fi.intel.com> <CAK7LNATQ1oAQm19-mzCKdMQsiQsYT9BRH5H7zukpFSzJw5WZZQ@mail.gmail.com>
 <CAHp75VcKpkZQ78xygzWTQhNsy8aLBzKzqVJTtzygzTYnWeqmyQ@mail.gmail.com>
In-Reply-To: <CAHp75VcKpkZQ78xygzWTQhNsy8aLBzKzqVJTtzygzTYnWeqmyQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Aug 2020 09:55:49 -0700
Message-ID: <CAKwvOdnuSyExtcddmcnS-08Mj6oNyZfqax4JQJSLBVFkD8S+JA@mail.gmail.com>
Subject: Re: -Werror for `make W=0`
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, X86 ML <x86@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 4:50 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 19, 2020 at 1:48 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > On Wed, Aug 19, 2020 at 6:44 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Hi!
> > >
> > > Maybe silly idea, but would it make sense to enable -Werror for default warning
> > > level, let's say W=0, at some point?
> > >
> >
> > Every GCC release adds new warning options.
> >
> > Enabling -Werror by default means
> > the kernel build is suddenly broken
> > with new compilers, correct?
>
> Probably, and at the same time we keep our hand on the pulse of the
> changes, right?
> Adding those warnings to W=1, 2, ... block might be not the bad idea after all.
>
> Maybe some flag CONFIG_DEBUG_WERROR ? Then CIs or other early stage
> users can enable by default and be informed.

Google's pixel kernel team carries an out of tree patch creating
exactly such a config.  It helps them keep their kernels building
warning free.

Flip side is that if a build isn't warning free, it can be difficult
to get there; you need to at least disable the config to see how many
warnings you have, and identify which are lower hanging fruit.  It
also makes compiler upgrades excessively difficult.  In my experience
on Android, if folks are too busy to address compiler warnings, then
new warnings added by a new compiler version just get turned off and
never addressed.  My experience with the kernel has been that fixes
for different warnings also take varying amounts of time to get
accepted and work their way through mainline, meanwhile builds are
broken.

I agree that it's ideal to have no warnings, but from my perspective
-Werror is a major impediment to upgrading the tools. Wouldn't
recommend.
-- 
Thanks,
~Nick Desaulniers

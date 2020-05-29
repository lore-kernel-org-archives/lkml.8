Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE86C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9F5207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgE2UoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:44:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2UoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:44:06 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mgvan-1j4KAz3Twr-00hJWp for <linux-kernel@vger.kernel.org>; Fri, 29 May
 2020 22:44:05 +0200
Received: by mail-qk1-f169.google.com with SMTP id n11so3512058qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:44:04 -0700 (PDT)
X-Gm-Message-State: AOAM5329byS8JK+eQ6gJyzzhRQLCLY3LDzvS3RXUTb9zKJet0DjPL/Tg
        edVgmRKi7gxzpnSO0vyIYg5c+wCwDiW7dQbeuaY=
X-Google-Smtp-Source: ABdhPJy4XjbWlTPZywTBf4Zz+9suY2E0IsBRaLVguOG3M7o7RdiKyno+D+pnl29iBPte8PkOa4Og3isluOwrykMCmrg=
X-Received: by 2002:ae9:de85:: with SMTP id s127mr8835256qkf.352.1590785043709;
 Fri, 29 May 2020 13:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200529201534.474853-1-arnd@arndb.de> <159078398171.4326.11332427648947797488@build.alporthouse.com>
In-Reply-To: <159078398171.4326.11332427648947797488@build.alporthouse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 May 2020 22:43:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3hrOTvTP6fOBLM8RF4fH4XRTPV54enk1Gd4uTSQvW2wQ@mail.gmail.com>
Message-ID: <CAK8P3a3hrOTvTP6fOBLM8RF4fH4XRTPV54enk1Gd4uTSQvW2wQ@mail.gmail.com>
Subject: Re: [PATCH] drm/selftests/mm: reduce per-function stack usage
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Nirmoy Das <nirmoy.das@amd.com>,
        kbuild test robot <lkp@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mP7zinjV+QhTD7ZvXzKM51hquuD6zd/KUUjc7E870IoyFVFCjmx
 RheEUdfeNraRVJEt2qtRZL7OtAtMJKRZm3fzJu8CUxURhZ1jfnHRjSbzUTIy28Z1IfIr62w
 dtt0mA47yFF9S/G95pclQiYAT7PxQmnOH41aYjaIPzTKzKLQMjMtzrbvEYZjj5whLRcpSEL
 dE2G/iU9pVc6f5oTyDkQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PD4lWU1hPoU=:14zRKxs6wBaF76yXA+weQ0
 7SqOBGNuAeCAGUyTwUMUG49nng5Bx26NeUlD+B2ZSpUe0owba5w4u67lsbxT4ptz0PcZLPaW/
 4K3m0vgsVpfkrrMkNceF+h2eFr5Mg3H5t93AcsKu+GXweY3boecWomC7H7G+agmnjDtFWani4
 ahm/eSWCAi6PNWDgjHqvTkRvhLQc/R/Zwuzes2Zeh+iSCv9nryicVrJ7yRNTopKEqs+ffZwZC
 OhTT8C71oHnLwJUS0AgrVnRIJBS1M77c1mRw0Y7Mqs0pC+glZI3uG8F61Vxew/mb/S9RI3Ac8
 Vu552eI4x9in8dkNqohLjPDfzCmxUrUH5iz/avUl/fcnucaUXiPrF5upFVnsTTaPmPa78JT4K
 7xzX4vurE2wczOmquH6rWmIuEA5PqanHSHZqDbwjZbtIuM0LCmMp3lHkjRwc76etUCmi6Mfa1
 AePWuD0BzED+0gnUCY7+XtxcTJbFK1voKXaMD1cMe5Yd7yITV/aUcOJD7RVV6YxIPcIcT1MwM
 WPlENJsxXm8skI3J8vQIvhmBbnk0zXOGT5/921PQQJieYtjPI/uaT3kzbPmKUReLiy+HbyL5G
 v+taOzCddulmEZJInzbCDwtT3IdJ0DRL4ZsdiGxGhgB7e3cSgfsPhcL7b2qew5KThpAL6c0AL
 CYhKkcoMLh1eLbP4QfwstsMp81GQzbXnwqyHbcntGvYPgLEFKpD8ebHXwvIKpfL8lqLdVAsnn
 r+OYodmsTyuO8C2CeMsaNbrM3ZYRH/U956An/ApJBJHPiPozpEmu+4wIrPfsk8cl2grH321yX
 yYlx2oREUMP533kHzt0VTR1ecI3ts7QOmq1ELAsl1uoBTpGszk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:26 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Quoting Arnd Bergmann (2020-05-29 21:15:26)

> >
> > diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
> > index 9aabe82dcd3a..30108c330db8 100644
> > --- a/drivers/gpu/drm/selftests/test-drm_mm.c
> > +++ b/drivers/gpu/drm/selftests/test-drm_mm.c
> > @@ -323,9 +323,8 @@ static bool expect_reserve_fail(struct drm_mm *mm, struct drm_mm_node *node)
> >         return false;
> >  }
> >
> > -static bool check_reserve_boundaries(struct drm_mm *mm,
> > -                                    unsigned int count,
> > -                                    u64 size)
> > +static noinline_for_stack bool
> > +check_reserve_boundaries(struct drm_mm *mm, unsigned int count, u64 size)
> >  {
> >         const struct boundary {
>
> It's this const [] right? Hmm, if we felt adventurous that could be a
> small set of multiplication factors (0, -1, 1, count, count+1, ...) and
> made static.

That was my first thought, but I couldn't figure out whether 'count'
could be replaced by any compile-time constant.

      Arnd

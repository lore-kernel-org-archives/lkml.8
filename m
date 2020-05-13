Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A864AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B5C205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXoZaFZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbgEMRLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgEMRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:11:44 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C276C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:11:44 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x7so21166524oic.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zx5r0dg+9gENiu3i1Xh7rfCawplygnstBg3FPTyi3Sk=;
        b=UXoZaFZdX2TT3nLrLhYDdmaNN8vjLgCHo8JHLOwrjkbc1GTCrMo6A7rbcUaPPONgln
         x0dvuAzxvxY8D6FNJEfHjF+D3ciBT/0FhqsA0y4NVBeNHhVM2P86Zwg99VkSivLzUZ7/
         vnUSMx6M473Qfr/eNFk0M6qVMqfwWfhIMK7kmIjKeI/MJyrcIPsJbU3NZM4ngZM6OnYF
         vg5Iw7vcbIPwM1xcv7A7lgANqAwzStIdQ2iV0B2yIqJp2y0NqvdZDnbuWZ1izLGHpmyY
         evWFxaW/g20nnV3j+vgPw9rsgu5J1kEBHAQ+3cGV2D5lqElCZ6fE+WII2flwgkzpL46R
         UNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zx5r0dg+9gENiu3i1Xh7rfCawplygnstBg3FPTyi3Sk=;
        b=brQvxEtTkQYZ4LtJiTw6s3r9YiQMxdJiwouk6zgGMUyQPpHTg8k80t9MstPUYeOuxb
         igSoe1TTjZY/DFoBBIdCW/nKU4rPZklrQelbC95/xl9wTMeut5QwItmCriWNl/abwacw
         cdkLhufCWd60aS8iV0SelD2dQpiYKxsVrb2JgwU4UQuMVfj5JCPD9NyUN2Rhy7XQqyx4
         z6vro/kULnSzJzEdzi2vuUFHv0OwSUGZ3OdP7u+JgcAcsB6sjQQmX4HIyOUWsBefeYRK
         QYVGlEmCdPlABdPRA1IETF4Rkoq5TZ4kQw7jVStytWyq3XrAEbh3h+/qjMNErxv2406w
         pZJA==
X-Gm-Message-State: AGi0PubErcARcDLHkbA+AQj+aetFPVVmiezzRdFeK4/WshDl/hmopaah
        00fO9KttwdPy4nURbLom41Xh1YuLoHlbUz95gqEAxw==
X-Google-Smtp-Source: APiQypIsEUlbBa2C4gshx4JKVoP5BcPSZgJHh8a2H2MHWh44738uBJEq5ushyYE1n3ceM2YTugst3ULETLaGkws09Rg=
X-Received: by 2002:aca:48d7:: with SMTP id v206mr12374568oia.97.1589389903668;
 Wed, 13 May 2020 10:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190923130531.GA27774@asgard.redhat.com> <87y2pxvsbr.fsf@osv.gnss.ru>
 <20200512223103.GC1016@asgard.redhat.com> <CALAqxLUGr=+UjYhQSN34fUMCqj1Ya85tbFKu685cN+XTWYfgXg@mail.gmail.com>
 <8736845ha6.fsf@osv.gnss.ru>
In-Reply-To: <8736845ha6.fsf@osv.gnss.ru>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 13 May 2020 10:11:32 -0700
Message-ID: <CALAqxLWkQmiFOCY=YhQLCJHwGHCO9kfZzysCEDLzJFTvgapUwA@mail.gmail.com>
Subject: Re: [PATCH v2] uapi, posix-timers: provide clockid-related macros and
 functions to UAPI
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 2:13 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> John Stultz <john.stultz@linaro.org> writes:
>
> > On Tue, May 12, 2020 at 3:31 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> >> On Tue, May 12, 2020 at 10:58:16PM +0300, Sergey Organov wrote:
> >> > Eugene Syromiatnikov <esyr@redhat.com> writes:
> >> >
> >> > > As of now, there is no interface exposed for converting pid/fd into
> >> > > clockid and vice versa; linuxptp, for example, has been carrying these
> >> > > definitions in missing.h header for quite some time[1].
> >> > >
> >> > > [1] https://sourceforge.net/p/linuxptp/code/ci/af380e86/tree/missing.h
> >> > >
> >> > > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> >> > > ---
> >> > > Changes since v1[1]:
> >> > >  * Actually tried to build with the patch and fixed the build error
> >> > >    reported by kbuild test robot[2].
> >> > >
> >> > > [1] https://lkml.org/lkml/2019/9/20/698
> >> > > [2] https://lkml.org/lkml/2019/9/22/13
> >> > > ---
> >> > >  include/linux/posix-timers.h | 47 +------------------------------------------
> >> > >  include/uapi/linux/time.h    | 48 ++++++++++++++++++++++++++++++++++++++++++++
> >> > >  2 files changed, 49 insertions(+), 46 deletions(-)
> >> >
> >> > Was this patch applied, rejected, lost?
> >> >
> >> > I can't find it in the current master.
> >>
> >> IIRC, it was ignored.
> >
> > Overlooked. :)  Not intentionally ignored.
> >
> > I don't have any major objection with adding helpers, though I feel
> > like you're exporting a lot more to the uapi then applications likely
> > need.
> >
> > Would it be better to add just the bits from the missing.h header you
> > pointed to:
> > #define CLOCKFD 3
> > #define FD_TO_CLOCKID(fd) ((~(clockid_t) (fd) << 3) | CLOCKFD)
> > #define CLOCKID_TO_FD(clk) ((unsigned int) ~((clk) >> 3))
> >
> >  to the uapi header?
>
> Please, no:
>
> 1. These macros were copied almost verbatim from the kernel code long
> ago, and since then kernel has changed them to inline functions, so
> getting back to these obsolete macros is pointless.
>
> 2. If we do need to export macroses, then kernel inline functions are
> better to be re-implemented in terms of these macros, not to have 2
> different points of implementation.
>
> Overall, I'd vote for the current approach of the patch, provided
> exporting inline functions to user-space is allowed.

Sure, I just want to make sure we're only exporting the minimal
necessary amount of details to userland. The current patch is
exporting a bit more than that.

thanks
-john

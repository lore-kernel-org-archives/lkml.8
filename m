Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19FA206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PvzRheIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgFVSVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbgFVSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:21:41 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859BEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:21:40 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id t132so10210163vst.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNEuunKSnf+k5sXDwy9YwYqOa5emBCm0yZU/1RF41v4=;
        b=PvzRheIUDsGlby6WQ1IGMEhVnTbxl4IQzfCt9VmZIdSchdnXRPr3WwPzEBaf0ygh20
         FtAz4MpJz1yFT0wNGGTMA7vHJz2v5OIVGiSzRJCdgDEWkb5Ae00shoQ814AUbhwtafkG
         HJKaZhqNbDIlfCAKDkL1RARC5nLz2I5aVBY0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNEuunKSnf+k5sXDwy9YwYqOa5emBCm0yZU/1RF41v4=;
        b=rX/BCrqCRoZSX5eZ12jmDXJUYlHWW4RwAwlDM1kf5xFXICiCBuBDlq6hiNLBc0kqgk
         PfHdI6F2+QOQ9jYfNighxfWoU15WyIXg1oSEjX1P0tc8qbmTFO+zNQBajPsFpGHrta8R
         iW/g0AD5ubBNSA3vTpoDHc5CZS72mipCiobTe2XI+dlhy/lm+hHzjtgVdUIgjwTWyY43
         Uiu0DNZysShrI8C2gO3Aodw3dYKRvXaPFS2Pg8v/6S+SVcte1hQgAy5BRXyfA1Km2+HY
         n0M1QfztcIuw0JhuZiPiThFkVErNZdxRDrZq75x3NWXtkO1h0Zuyjm8pjQXPS+6vdJx3
         iEcQ==
X-Gm-Message-State: AOAM531bPVxeRXwdMm/RRRHZM/woZMVdmbgyrKkn1P6ukx4TScNZ3Ugl
        RPPBepmH1DOlh30KD/7KtFds6O/S42o=
X-Google-Smtp-Source: ABdhPJwPUwklRt4FxBo/j8Rs7/JyCkPKEz2niP6fNdcemPoObsTwFX+mg8UnniOwrYjyb/c6PxC7Kw==
X-Received: by 2002:a67:b149:: with SMTP id z9mr16712728vsl.85.1592850099411;
        Mon, 22 Jun 2020 11:21:39 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id d200sm864206vkd.16.2020.06.22.11.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 11:21:38 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id m62so2308404vsd.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:21:37 -0700 (PDT)
X-Received: by 2002:a67:62c4:: with SMTP id w187mr15080884vsb.109.1592850096698;
 Mon, 22 Jun 2020 11:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com> <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jun 2020 11:21:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
Message-ID: <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Quentin Perret <qperret@google.com>, ctheegal@codeaurora.org,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 19, 2020 at 8:38 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/18/20 14:18, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 12, 2020 at 5:52 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 06/10/20 15:18, Douglas Anderson wrote:
> > > > The cros_ec_spi driver is realtime priority so that it doesn't get
> > > > preempted by other taks while it's talking to the EC but overall it
> > > > really doesn't need lots of compute power.  Unfortunately, by default,
> > > > the kernel assumes that all realtime tasks should cause the cpufreq to
> > > > jump to max and burn through power to get things done as quickly as
> > > > possible.  That's just not the correct behavior for cros_ec_spi.
> > > >
> > > > Switch to manually overriding the default.
> > > >
> > > > This won't help us if our work moves over to the SPI pump thread but
> > > > that's not the common code path.
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > > NOTE: This would cause a conflict if the patch
> > > > https://lore.kernel.org/r/20200422112831.870192415@infradead.org lands
> > > > first
> > > >
> > > >  drivers/platform/chrome/cros_ec_spi.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> > > > index debea5c4c829..76d59d5e7efd 100644
> > > > --- a/drivers/platform/chrome/cros_ec_spi.c
> > > > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > > > @@ -709,8 +709,11 @@ static void cros_ec_spi_high_pri_release(void *worker)
> > > >  static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
> > > >                                          struct cros_ec_spi *ec_spi)
> > > >  {
> > > > -     struct sched_param sched_priority = {
> > > > -             .sched_priority = MAX_RT_PRIO / 2,
> > > > +     struct sched_attr sched_attr = {
> > > > +             .sched_policy   = SCHED_FIFO,
> > > > +             .sched_priority = MAX_RT_PRIO / 2,
> > > > +             .sched_flags    = SCHED_FLAG_UTIL_CLAMP_MIN,
> > > > +             .sched_util_min = 0,
> > >
> > > Hmm I thought Peter already removed all users that change RT priority directly.
> > >
> > > https://lore.kernel.org/lkml/20200422112719.826676174@infradead.org/
> >
> > Yeah, I mentioned that patch series "after the cut" in my patch and
> > also made sure to CC Peter on my patch.  I'm not sure what happened to
> > that series since I don't see it in linuxnext...
>
> Apologies I missed that.
>
> >
> >
> > > >       };
> > > >       int err;
> > > >
> > > > @@ -728,8 +731,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
> > > >       if (err)
> > > >               return err;
> > > >
> > > > -     err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
> > > > -                                      SCHED_FIFO, &sched_priority);
> > > > +     err = sched_setattr_nocheck(ec_spi->high_pri_worker->task, &sched_attr);
> > > >       if (err)
> > > >               dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
> > > >       return err;
> > >
> > > If I read the code correctly, if you fail here cros_ec_spi_probe() will fail
> > > too and the whole thing will not be loaded. If you compile without uclamp then
> > > sched_setattr_nocheck() will always fail with -EOPNOTSUPP.
> >
> > Oops, definitely need to send out a v2 for that if nothing else.  Is
> > there any good way for me to code this up or do I need a big #ifdef
> > somewhere in my code?
>
> A big #ifdef. But this kind of use I don't think was anticipated. And generally
> if we want to allow that, it has to be done via a proper API. Drivers picking
> random uclamp values is as bad as them picking random RT priority.
>
> >
> >
> > > Why can't you manage the priority and boost value of such tasks via your init
> > > scripts instead?
> >
> > I guess I feel like it's weird in this case.  Userspace isn't creating
> > this task and isn't the one marking it as realtime.  ...and, if we
> > ever manage to upgrade the protocol which we use to talk to the EC we
> > might fully get rid of this task the need to have something boosted up
> > to realtime.
> >
> > Said another way: the fact that we even have this task at all and the
> > fact that it's realtime is an implementation detail of the kernel.  It
> > seems really weird to add initscripts for it.
>
> Yes this is the problem of RT for a general purpose systems. It's hard to
> reason about their priorities/importance since it's not a special purpose
> system with well defined spec of what hardware/software will be running on it
> and their precise requirements is not known before hand.
>
> >
> >
> > > I have to admit I need to think about whether it makes sense to have a generic
> > > API that allows drivers to opt-out of the default boosting behavior for their
> > > RT tasks.
> >
> > Seems like it would be useful.
>
> If you propose something that will help the discussion. I think based on the
> same approach Peter has taken to prevent random RT priorities. In uclamp case
> I think we just want to allow driver to opt RT tasks out of the default
> boosting behavior.
>
> I'm a bit wary that this extra layer of tuning might create a confusion, but
> I can't reason about why is it bad for a driver to say I don't want my RT task
> to be boosted too.

Right.  I was basically just trying to say "turn my boosting off".

...so I guess you're saying that doing a v2 of my patch with the
proper #ifdef protection wouldn't be a good way to go and I'd need to
propose some sort of API for this?

-Doug

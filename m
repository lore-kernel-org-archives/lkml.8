Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED428206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PpoEAonn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgFRVSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFRVSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:18:39 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A34C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:18:39 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o2so4427571vsr.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQEeRFx60IswzJRvFAoxOWsQup+koH/QTgmv5jgsGbM=;
        b=PpoEAonnGJ7mXYvMQg/Jlo7Be9y71VSwHLqCWGfv9iU/PZlToBKeT8joOW5WjJrPN0
         046R9USAk28DraDmv99PnQ9cs+Oyijgm8cxSOxmJ0U+hb3TZG2e42GFJhKAzG06zmyrL
         I1LZZFuvveh4bRMNkTSSFef/D+iVOqjnxZWyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQEeRFx60IswzJRvFAoxOWsQup+koH/QTgmv5jgsGbM=;
        b=Y/TPr93/kXFkOM2adTBgIcu3J1Hf/oj9JvvSE6D9iY8HRIn8oND4/GPPQwmn56mqVb
         nsdv71qEvgzl7WcScUiGCLrs+WBjFNdGW2PTULlUywOHlfcpf8huXb+SW2UHue54obwr
         SHm72yPMlDfsUVLVJV0q44EFK2oRaux3BDI/lYbePBssmcpCQPEJZUEYq5zZ8tDiq8gv
         mCGXDRhP3JpWJnQA1ifUfFbdwgG+4X/DZirpTkUWEFletmdRh0lev0jeOBQAlh9kyB4G
         w10tO+CCH7qlq1tPRpuUUZV4aqUi6o1R47OfMVPmORzGzmnOC0Ovg68c86VEDu7pzssV
         u8ig==
X-Gm-Message-State: AOAM530dgB6xCYUBLKGvFNlgJCEbhe+jF5nay1Hs0q9+fSqhcw4Ck6Kh
        uKjyst3V8J/CD/dC1+2HXnBZE3GZ+pg=
X-Google-Smtp-Source: ABdhPJxQa8oghQ5jbfnWASiR4gzKhka6k9Om6y35bw5aoz2B0S93jZtIi2+LOfFmFvPouXMGiAlngg==
X-Received: by 2002:a67:db88:: with SMTP id f8mr5198615vsk.165.1592515118187;
        Thu, 18 Jun 2020 14:18:38 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 4sm331589uae.4.2020.06.18.14.18.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 14:18:36 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id u17so4409717vsu.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:18:35 -0700 (PDT)
X-Received: by 2002:a67:e445:: with SMTP id n5mr5244712vsm.73.1592515114671;
 Thu, 18 Jun 2020 14:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 14:18:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
Message-ID: <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
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

On Fri, Jun 12, 2020 at 5:52 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/10/20 15:18, Douglas Anderson wrote:
> > The cros_ec_spi driver is realtime priority so that it doesn't get
> > preempted by other taks while it's talking to the EC but overall it
> > really doesn't need lots of compute power.  Unfortunately, by default,
> > the kernel assumes that all realtime tasks should cause the cpufreq to
> > jump to max and burn through power to get things done as quickly as
> > possible.  That's just not the correct behavior for cros_ec_spi.
> >
> > Switch to manually overriding the default.
> >
> > This won't help us if our work moves over to the SPI pump thread but
> > that's not the common code path.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > NOTE: This would cause a conflict if the patch
> > https://lore.kernel.org/r/20200422112831.870192415@infradead.org lands
> > first
> >
> >  drivers/platform/chrome/cros_ec_spi.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> > index debea5c4c829..76d59d5e7efd 100644
> > --- a/drivers/platform/chrome/cros_ec_spi.c
> > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > @@ -709,8 +709,11 @@ static void cros_ec_spi_high_pri_release(void *worker)
> >  static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
> >                                          struct cros_ec_spi *ec_spi)
> >  {
> > -     struct sched_param sched_priority = {
> > -             .sched_priority = MAX_RT_PRIO / 2,
> > +     struct sched_attr sched_attr = {
> > +             .sched_policy   = SCHED_FIFO,
> > +             .sched_priority = MAX_RT_PRIO / 2,
> > +             .sched_flags    = SCHED_FLAG_UTIL_CLAMP_MIN,
> > +             .sched_util_min = 0,
>
> Hmm I thought Peter already removed all users that change RT priority directly.
>
> https://lore.kernel.org/lkml/20200422112719.826676174@infradead.org/

Yeah, I mentioned that patch series "after the cut" in my patch and
also made sure to CC Peter on my patch.  I'm not sure what happened to
that series since I don't see it in linuxnext...


> >       };
> >       int err;
> >
> > @@ -728,8 +731,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
> >       if (err)
> >               return err;
> >
> > -     err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
> > -                                      SCHED_FIFO, &sched_priority);
> > +     err = sched_setattr_nocheck(ec_spi->high_pri_worker->task, &sched_attr);
> >       if (err)
> >               dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
> >       return err;
>
> If I read the code correctly, if you fail here cros_ec_spi_probe() will fail
> too and the whole thing will not be loaded. If you compile without uclamp then
> sched_setattr_nocheck() will always fail with -EOPNOTSUPP.

Oops, definitely need to send out a v2 for that if nothing else.  Is
there any good way for me to code this up or do I need a big #ifdef
somewhere in my code?


> Why can't you manage the priority and boost value of such tasks via your init
> scripts instead?

I guess I feel like it's weird in this case.  Userspace isn't creating
this task and isn't the one marking it as realtime.  ...and, if we
ever manage to upgrade the protocol which we use to talk to the EC we
might fully get rid of this task the need to have something boosted up
to realtime.

Said another way: the fact that we even have this task at all and the
fact that it's realtime is an implementation detail of the kernel.  It
seems really weird to add initscripts for it.


> I have to admit I need to think about whether it makes sense to have a generic
> API that allows drivers to opt-out of the default boosting behavior for their
> RT tasks.

Seems like it would be useful.

-Doug

Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E7AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FCF20767
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QG1IoYl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406100AbgFXSaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405919AbgFXSaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:30:03 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912DCC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:30:03 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id m23so765892vko.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dObdCDUTrGFI/rx0m6U4tkE0B1+Fpf7lvaFecAoxjc=;
        b=QG1IoYl2UihR1f8keD2I0PqA1hErW8jHJyqbAJ1iZ0wAfRmNkrxmOnhtgxgb0BNFeo
         YEhwZ3GV5ICNGD42hQwAQrFo1uOiwP++NJ8FiYE12YlQvuOyzb8+zi9BAVMzydWF41Kq
         hAYLIPpRLQfNzmkqDC5tK9B+jr8owYrnPrGwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dObdCDUTrGFI/rx0m6U4tkE0B1+Fpf7lvaFecAoxjc=;
        b=ThWCS/aSIT19OX0jbI3yj0msTV9nherXTMheuWnwzzSKVOEn8Uh+phYWPrXveHlJFl
         ytAnq23FG/Y8VK0OGdMsyLLe15R620veqhfyPgYQYu4cRC0/nJQWPcfqdAgSzZ0+oNo/
         pGrnlpm/EbfTMF6DosRG5hyDBR9b/nE+z6/oIwpJq+1tzQBi5u4EWM07ayWc1GJuPHvs
         bJ+ubJ3gZpNhypeo+RjHccL9mm6sdPaCkulyhLGzb8LgeihMszn6RvCQa+wd70Ep2UmL
         t5WdrS8flfYLWJVQz3VKVX3+Ev5xaKRuF5Clxbrk+VYCD0Igs0f5iXKw0Z0vGvQy2q/U
         Ddmw==
X-Gm-Message-State: AOAM530c+VErVb4DDBjs9XWCaPe2MK0K+WQyzQHLc548irOb64E4KxN1
        IGxEKmA03B8XsKoaYO6tLRdpv8tnmnA=
X-Google-Smtp-Source: ABdhPJwwbq7m1vd+Z79qFjuQy95xbGnI9/siXLxHJUMY4ysLS9yROZUhlm6RKhay5S3rtqKwFp73PQ==
X-Received: by 2002:a1f:9958:: with SMTP id b85mr11878891vke.48.1593023401706;
        Wed, 24 Jun 2020 11:30:01 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id b193sm1039861vke.41.2020.06.24.11.29.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:30:00 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id e15so1969232vsc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:29:59 -0700 (PDT)
X-Received: by 2002:a67:62c4:: with SMTP id w187mr23023350vsb.109.1593023398932;
 Wed, 24 Jun 2020 11:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
 <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
 <CAJWu+ooXdgqSGisZXnHBtYLo9oQBiaNR=HhKseBN+YFGz-L6Xg@mail.gmail.com>
 <20200624165500.idrugfgplqgi654v@e107158-lin.cambridge.arm.com>
 <CAJWu+oqHUq6fvkfRgAx4qx8x1dm-J-h6moeVskCU3gkRybCPqQ@mail.gmail.com>
 <20200624175236.nblndmg6dfq2vr2u@e107158-lin.cambridge.arm.com> <CAJWu+oreQRCAkBhNQ-n6BPjYsdOL074ff8551sF3r7OxsseEVQ@mail.gmail.com>
In-Reply-To: <CAJWu+oreQRCAkBhNQ-n6BPjYsdOL074ff8551sF3r7OxsseEVQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Jun 2020 11:29:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xf29qsiBSUit7xoVpxzLnoBT9vZ+0JBGN2bFefDBKG4w@mail.gmail.com>
Message-ID: <CAD=FV=Xf29qsiBSUit7xoVpxzLnoBT9vZ+0JBGN2bFefDBKG4w@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
To:     Joel Fernandes <joelaf@google.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
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

On Wed, Jun 24, 2020 at 10:55 AM Joel Fernandes <joelaf@google.com> wrote:
>
> On Wed, Jun 24, 2020 at 1:52 PM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 06/24/20 13:35, Joel Fernandes wrote:
> >
> > [...]
> >
> > > > Doing the in-kernel opt-out via API should be fine, I think. But this will
> > > > need to be discussed in the wider circle. It will already clash with this for
> > > > example
> > > >
> > > > https://lore.kernel.org/lkml/20200619172011.5810-1-qais.yousef@arm.com/
> > >
> > > Have not yet looked closer at that patch, but are you saying this
> > > patch clashes with that work? Sorry I am operating on 2 hours of sleep
> > > here.
> >
> > The series is an optimization to remove the uclamp overhead from the scheduler
> > fastpath until the userspace uses it. It introduces a static key that is
> > disabled by default and will cause uclamp logic not to execute in the fast
> > path. Once the userspace starts using util clamp, which we detect by either
> >
> >         1. Changing uclamp value of a task with sched_setattr()
> >         2. Modifying the default sysctl_sched_util_clamp_{min, max}
> >         3. Modifying the default cpu.uclamp.{min, max} value in cgroup
> >
> > If we start having in-kernel users changing uclamp value this means drivers
> > will cause the system to opt-in into uclamp automatically even if the
> > userspace doesn't actually use it.
> >
> > I think we can solve this by providing a special API to opt-out safely. Which
> > is the right thing to do anyway even if we didn't have this clash.
>
> Makes sense, thanks.

OK, so I think the summary is:

1. There are enough external dependencies that are currently in the
works that it makes sense for those to land first without trying to
cram my patch to cros_ec in.

2. Maybe, as part of the work that's already going on, someone will
add an API that I can use.  If so then I can write my patch once that
lands.

3. If nobody adds an API then I could look at adding the API myself
once everything else is settled.

4. It looks as if the patch you mentioned originally [1] that allows
userspace to just fully disable uclamp for RT tasks will land
eventually (if we're stuck for a short term solution we can pick the
existing patch).  I believe Chrome OS will use that to just fully
disable the default boosting for RT tasks across our system and (if
needed) add boosts on a case-by-case basis.  Once we do that, the
incentive to land a patch for cros_ec will be mostly gone and probably
we could consider my patch abandoned.  While it would technically
still be sane to land it won't have any real-world benefit.


[1] https://lore.kernel.org/r/20200511154053.7822-1-qais.yousef@arm.com

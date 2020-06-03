Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751DE2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWEC1jxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgFCTZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:25:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512F5C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 12:25:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so4253582ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoZ95HcH7BjHDOWUdMqlDLSFVCikU3SwfVIEJuTPDf0=;
        b=WWEC1jxWNpJpAejhnUE2mvgpUkvyhAOl4+lQSMH1zlIOjsbqDJbiNKF7V/EPVHRcrc
         SBR2iZXswhh9euDXazMcNAFZAVXz9BkZ8hyWCZ9BULZdx/7V+es6QNR7XSxHgtrnkudW
         yu0yZBZ14zoftRC1wLl7+QVUlH5X5AqsYGWaaRIF3U67l4NwzrQOBxfgcCJqcKJ9ivI8
         jKfeGaXHEV6n0ynof3ELjbWZLkWZJGd9iBqc2q3W2z5l11K1tGiBTsQfNm/yE3N+oYv3
         3HNtpSWRJ9+LZ0pqjSAY9KkRgFbKqpMzu60gBeuKwRiE/YdzwfeKxP0460Xgujgj1Or/
         46yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoZ95HcH7BjHDOWUdMqlDLSFVCikU3SwfVIEJuTPDf0=;
        b=fRRROcWizBO03tJ7jBFRsYsCicQ854sMGPimMzHGolnyu/A0maV/3rWZrP6SPS+rUs
         IsrCtA8MqdDqko62F22yFJqgx+2suzbr8t4qNmc/GkWdRhW5QmZqddBhzhMHpJETwRxA
         VpsDaXpLNpCeSAurq7Gu1ZbOO/XiIgccRsa62Kyk2h1V43FPhNb5fzW56u1yskovDstf
         gMPvBBt4KCLZBEKbD3fO1sdCXSfxU/SIhSFdvyafqezVc7o2R7qPhVuqVPWGS5dHilY7
         rlJhRZLRRBVPlLiRdG0j+SA43g5GMOy4U4a1Zf7aVuVBlBb5m3ILKMIGO/ijk4FV0A3g
         7iNw==
X-Gm-Message-State: AOAM5324FPGBCrTv8mIpm8t1R8vpEL9vCaxo4qhbuF5L6bjaxoMwbDKC
        LTaMoNk4StDqabHvOyu/Upm1TTRefGgYoJYz0MuGmw==
X-Google-Smtp-Source: ABdhPJyjY9bI6wp93Q+GZLTCJltJ7vuNMf3HKAZ499wjKUG7VYCT5Z5DqEFkxPros8eq8FLUCsH8Gx9omgFLqXQeLMs=
X-Received: by 2002:a2e:541e:: with SMTP id i30mr341995ljb.156.1591212307735;
 Wed, 03 Jun 2020 12:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200603173150.GB1551@shell.armlinux.org.uk> <jhjh7vshvwl.mognet@arm.com>
 <20200603184500.GC1551@shell.armlinux.org.uk>
In-Reply-To: <20200603184500.GC1551@shell.armlinux.org.uk>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Jun 2020 21:24:56 +0200
Message-ID: <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
Subject: Re: v5.7: new core kernel option missing help text
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 20:45, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jun 03, 2020 at 07:00:26PM +0100, Valentin Schneider wrote:
> >
> > On 03/06/20 18:31, Russell King - ARM Linux admin wrote:
> > > Hi,
> > >
> > > A new kernel configuration option ("SCHED_THERMAL_PRESSURE") was
> > > recently added, but has no help text. This is most unhelpful when
> > > trying to configure the kernel, since one does not know what the
> > > effect of answering yes or no to this option would be.
> > >
> > > Please supply a proper help text when adding core kernel options
> > > so that people can make an informed decision when answering the
> > > prompt, rather than just guessing.
> > >
> >
> > Right; does the below look good enough?
>
> It's a start.  I'm still wondering whether I should answer yes or no
> for the platforms I'm building for.
>
> So far, all I've found is:
>
> arch/arm/include/asm/topology.h:#define arch_scale_thermal_pressure topology_get_thermal_pressure
>
> which really doesn't tell me anything about this.  So I'm still in
> the dark.
>
> I guess topology_get_thermal_pressure is provided by something in
> drivers/ which will be conditional on some driver or something.

You need cpufreq_cooling device to make it useful and only for SMP
I don't think that this should not be user configurable because even
with the description above, it is not easy to choose.
This should be set by the driver that implement the feature which is
only cpufreq cooling device for now it

>
> >
> > ---
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 74a5ac65644f..f40cf852d00a 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -441,6 +441,10 @@ config HAVE_SCHED_AVG_IRQ
> >  config SCHED_THERMAL_PRESSURE
> >         bool "Enable periodic averaging of thermal pressure"
> >         depends on SMP
> > +     help
> > +       This option allows the scheduler to be aware of CPU thermal throttling
> > +       (i.e. thermal pressure), providing arch_scale_thermal_pressure() is
> > +       implemented.
> >
> >  config BSD_PROCESS_ACCT
> >         bool "BSD Process Accounting"
> > ---
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up

Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E15C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3152220734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQeFHF/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgFCUWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgFCUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:22:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA228C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 13:22:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m18so4432289ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdJhFCab8uJbiEhFxUjAlbMPrdQ9UFlBb1YuICowIK0=;
        b=WQeFHF/ZgKrYrtKK3ugO8ESs1dBYe1gXckTRhAQoY9XDa1svQ74qxvkpvxwr2n4f39
         oVKaNGdm1Z7ac8KvCz/iWXEDfpEB4gAqXDxX7moTQmXBqLsW4Q28VXasJ3QHr+x+9k6w
         0J5sOAEfQ7MB+Tlp4pQGvGRrXW0QxvZrwtPzgXES/1f7jhgQ000EOTu9aNBi85s7rPv9
         CUmB0o9cF+t5FcGZNqiHLphRWI0bxXTIC21pvn6uPEchxXIopZGQ6RbAUL4kHDiyz8Kl
         Px88Hy9Scudt/wo3hnds48/MvCfUt/6hv39R1rbfSFs+ijsozDXe2hX6t+BlFd3bBmCK
         Kr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdJhFCab8uJbiEhFxUjAlbMPrdQ9UFlBb1YuICowIK0=;
        b=hLVbZNWtuAdxcW4u+U0mb5OIIQ8VCdWee58DqQuubebiQ9lKWgMgkcyMynOG1G2ZdN
         UH3DL1BdCExnCyef1djhWNYCBegO5RagBIP2ylHswW2z4x/Mj18SXvdW4/E/wBrWRM8+
         e+wfdOiYm/pXB60wbt66R1WLg5LiSgBN98CXp37iPZjDYc8pkO53DUKglB8zUiCpaR3m
         nZ3w1/R508MTctCnmOkxE+CWPPk2b23y6mVV2zNS/PEQFdQCa3cOKh+NYDuIr0GordpH
         EKw1nEQl7KEzQNqMdwWZbg7KzP4IUXADf20t5QrmOP1r9/ZRwRJIojIia/mQx1kpBWIE
         vUFA==
X-Gm-Message-State: AOAM5337Xa/xS4V2V6RYIKgNvIstK+whLHHVBRERFTEyhYllHKLVYUeW
        ns4ZYXRQy7mo3nxp/xOR/T7BMJXGBNUxf9GJoqAdhg==
X-Google-Smtp-Source: ABdhPJzutiDgyldEVmudvzNme5c1g+PhEmOWmXPCnvCNWJ3N1arSFbjXm30FGIP8+eQu/XZ62XHKL/G7FmwhdefqyC0=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr457085ljp.177.1591215770110;
 Wed, 03 Jun 2020 13:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200603173150.GB1551@shell.armlinux.org.uk> <jhjh7vshvwl.mognet@arm.com>
 <20200603184500.GC1551@shell.armlinux.org.uk> <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
 <20200603195853.GD1551@shell.armlinux.org.uk>
In-Reply-To: <20200603195853.GD1551@shell.armlinux.org.uk>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Jun 2020 22:22:38 +0200
Message-ID: <CAKfTPtAweyV44Dqv1vXm83aLy2PhaWBUnxro-ct=KVhr4XWGwA@mail.gmail.com>
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

On Wed, 3 Jun 2020 at 21:59, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jun 03, 2020 at 09:24:56PM +0200, Vincent Guittot wrote:
> > On Wed, 3 Jun 2020 at 20:45, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > It's a start.  I'm still wondering whether I should answer yes or no
> > > for the platforms I'm building for.
> > >
> > > So far, all I've found is:
> > >
> > > arch/arm/include/asm/topology.h:#define arch_scale_thermal_pressure topology_get_thermal_pressure
> > >
> > > which really doesn't tell me anything about this.  So I'm still in
> > > the dark.
> > >
> > > I guess topology_get_thermal_pressure is provided by something in
> > > drivers/ which will be conditional on some driver or something.
> >
> > You need cpufreq_cooling device to make it useful and only for SMP
> > I don't think that this should not be user configurable because even
> > with the description above, it is not easy to choose.
> > This should be set by the driver that implement the feature which is
> > only cpufreq cooling device for now it
>
> As I have CONFIG_CPU_FREQ_THERMAL=y in my config, I'm guessing (and it's
> only a guess) that I should say y to SCHED_THERMAL_PRESSURE ?

yes, you're right

>
> > > > +     help
> > > > +       This option allows the scheduler to be aware of CPU thermal throttling
> > > > +       (i.e. thermal pressure), providing arch_scale_thermal_pressure() is
> > > > +       implemented.
>
> Is this feature documented in terms of what it does?  Do I assume that
> as the thermal trip points start tripping, that has an influence on
> the scheduler?  Or is it the case that the scheduler is wanting to
> know when the cpu frequency changes?

When the thermal trip points start tripping, we take into account the
decrease of the compute capacity of the CU. This reduced capacity is
used instead of max capacity when we balance the tasks between CPUs.

A similar mechanism is used to account the time "stolen" by IRQ or
RT/DL tasks to CFS tasks

>
> Grepping for "thermal" in Documentation/scheduler brings up nothing.

John Mathew sent a patch to add documentation:
https://lkml.org/lkml/2020/5/14/290

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up

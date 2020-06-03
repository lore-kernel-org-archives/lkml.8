Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AAFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AC52074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wh/2nlbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFCT7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:59:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDABC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tg8mNhsE0qlps5ciALLkNONY+9bvqdzo03558zZho/4=; b=Wh/2nlbRDwoeC9J0ac3xyk/Jk
        zQty8vNNDayaTgr5QL1Xvauoyc93BcKurh2nK51uQqfprOqyUVUfoXXIOgnlFizlapzncHwENxKAp
        48NUwyvSWDRNdpi/K/7btTTyXaEmO/CVluzeLa1uYicu0Qg/S7tJqOevW0d+S3jky8khAgqAhAARe
        It3hNKj7C5OahkvOvhB1SXbhV6dqZZyM4KeKmXAbIbIh0Bb4S0gNeY27dUSvqw8TNp6WmhMtXPEKD
        2u7VQX77SBjmniwTjflfdwgnLUhW5/aw+JmNV4kp6QNUC3RtgrK73RAM/lOSnJ+DceYynFWPNj1zB
        dOiWsf49A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:48984)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jgZXM-0006E7-IL; Wed, 03 Jun 2020 20:58:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jgZXJ-0005fr-Uq; Wed, 03 Jun 2020 20:58:53 +0100
Date:   Wed, 3 Jun 2020 20:58:53 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: v5.7: new core kernel option missing help text
Message-ID: <20200603195853.GD1551@shell.armlinux.org.uk>
References: <20200603173150.GB1551@shell.armlinux.org.uk>
 <jhjh7vshvwl.mognet@arm.com>
 <20200603184500.GC1551@shell.armlinux.org.uk>
 <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 09:24:56PM +0200, Vincent Guittot wrote:
> On Wed, 3 Jun 2020 at 20:45, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > It's a start.  I'm still wondering whether I should answer yes or no
> > for the platforms I'm building for.
> >
> > So far, all I've found is:
> >
> > arch/arm/include/asm/topology.h:#define arch_scale_thermal_pressure topology_get_thermal_pressure
> >
> > which really doesn't tell me anything about this.  So I'm still in
> > the dark.
> >
> > I guess topology_get_thermal_pressure is provided by something in
> > drivers/ which will be conditional on some driver or something.
> 
> You need cpufreq_cooling device to make it useful and only for SMP
> I don't think that this should not be user configurable because even
> with the description above, it is not easy to choose.
> This should be set by the driver that implement the feature which is
> only cpufreq cooling device for now it

As I have CONFIG_CPU_FREQ_THERMAL=y in my config, I'm guessing (and it's
only a guess) that I should say y to SCHED_THERMAL_PRESSURE ?

> > > +     help
> > > +       This option allows the scheduler to be aware of CPU thermal throttling
> > > +       (i.e. thermal pressure), providing arch_scale_thermal_pressure() is
> > > +       implemented.

Is this feature documented in terms of what it does?  Do I assume that
as the thermal trip points start tripping, that has an influence on
the scheduler?  Or is it the case that the scheduler is wanting to
know when the cpu frequency changes?

Grepping for "thermal" in Documentation/scheduler brings up nothing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up

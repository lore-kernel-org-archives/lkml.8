Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40C3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 07:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAF02070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 07:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596957559;
	bh=+ruQjlWTGmDbs65Am8feT92CSnkiwYDIjdHTulHBHVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nSuoXK19n4Eu/yc4alsSKktYh+IzTTUl0G6pxPZnq9udowlTNhVqnXeAUIVSvsS9m
	 DRa0LMsQym3u94kGIxVg0klswMMdhe3gyLhsDBi93tgf+8af4vH5dhnu1ji/PPGvt5
	 J0Nqps/sgIOmxb6zAK0Pfew6KVoGlK3WMQ4EE4Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHIHOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 03:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgHIHOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 03:14:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA737206C3;
        Sun,  9 Aug 2020 07:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596957290;
        bh=+ruQjlWTGmDbs65Am8feT92CSnkiwYDIjdHTulHBHVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZe+1eLD1bZSgTdfpMjuRmiIOf7QGGWg/+xzEbeK/BR17h9gnrwOpMpugY8RzrkAW
         jjCe6ftHOjsw8S7hKCPf0GsCTYheK3wrS06ZbNhkLQILR2rIp+o3BjiFJpRc7MI5z0
         rR5gt/1DfH1N9/DylbpR8UBZjZcPQVTjmcKuqXJQ=
Date:   Sun, 9 Aug 2020 09:14:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Sumit Gupta <sumitg@nvidia.com>
Subject: Re: [PATCH] fix arm64 build with lack of __cpu_logical_map exported
Message-ID: <20200809071447.GB1098830@kroah.com>
References: <20200808124242.GA352821@kroah.com>
 <20200808150443.GA492@DESKTOP-O1885NU.localdomain>
 <20200808152958.GB369184@kroah.com>
 <20200808182907.GA2073@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808182907.GA2073@gaia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 07:29:08PM +0100, Catalin Marinas wrote:
> On Sat, Aug 08, 2020 at 05:29:58PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Aug 08, 2020 at 04:05:00PM +0100, Catalin Marinas wrote:
> > > On Sat, Aug 08, 2020 at 02:42:42PM +0200, Greg Kroah-Hartman wrote:
> > > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > > index 87e81d29e6fb..b421a4756793 100644
> > > > --- a/arch/arm64/kernel/setup.c
> > > > +++ b/arch/arm64/kernel/setup.c
> > > > @@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
> > > >  arch_initcall(reserve_memblock_reserved_regions);
> > > >  
> > > >  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
> > > > +EXPORT_SYMBOL_GPL(__cpu_logical_map);
> > > 
> > > This was still under discussion, Sudeep preferring an alternative in the
> > > driver:
> > > 
> > > http://lkml.kernel.org/r/20200727172744.GD8003@bogus
> > > http://lkml.kernel.org/r/20200724131059.GB6521@bogus
> > > 
> > > Sumit came with a new diff inline that fixes the driver instead of
> > > exporting the __cpu_logical_map.
> > > 
> > > https://lore.kernel.org/linux-arm-kernel/e3a4bc21-c334-4d48-90b5-aab8d187939e@nvidia.com/
> > 
> > Ok, but having a broken tree is not nice, how did this survive
> > linux-next testing?
> 
> I guess defconfig worked ok since tegra194-cpufreq is not a module so we
> didn't bother much. The fault was reported for allmodconfig but the
> discussion didn't conclude.
> 
> > > Sumit, Sudeep, is the above diff sufficient and can it go upstream?
> > 
> > Note that MIPS already export this symbol, so perhaps the drivers that
> > need it on that platform should also be fixed the same way?
> 
> I push Kefeng's patch to the arm64 for-next/core branch which exports
> cpu_logical_map() as a function. We can revert it later is the Tegra
> driver is fixed.
> 
> I'll send Linus a pull request in a bit, once I finish testing the
> branch.

Thanks, I see it's now in Linus's tree so all should be good.

Now to figure out the arm32 build mess...

greg k-h

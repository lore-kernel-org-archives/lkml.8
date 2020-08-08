Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271CDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F129920747
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596900588;
	bh=zF/xJR2FOJwu4V30N6nLpSiw1LpaGSCuquAHMuvzg7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=awAujvLW4XjjUr42cenn2mT1/HOeIkcc6avE8rIODOx2JdxPgA8ATjL50Ky6t0AiX
	 dulU/wZ/2oY5M7uewz6KCMO/FVK1UnqrluDEuJodHa3LxBVIyRdbAZ8qvv92Dacivr
	 6eUGzRarBMDebRnb+Kr91H4zGgQmoLImbOHy0IQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHHP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 11:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgHHP3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 11:29:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3EB2070A;
        Sat,  8 Aug 2020 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596900585;
        bh=zF/xJR2FOJwu4V30N6nLpSiw1LpaGSCuquAHMuvzg7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYMDmSt0iFDI3O+5p6pz8AChEXtEZUpYqjz0keW07x5+UckLp0Prc44ANBEgBGaGq
         vJq1VZQOTib+9FCXbU590eCvBSKTSkynP00ZWGtDncP3x5rBdy0/KKom+5vW7sLs8k
         O1CWMljrh4wd5CH4qUyd/SFC3dhkyY0CMeAaxOOM=
Date:   Sat, 8 Aug 2020 17:29:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Sumit Gupta <sumitg@nvidia.com>
Subject: Re: [PATCH] fix arm64 build with lack of __cpu_logical_map exported
Message-ID: <20200808152958.GB369184@kroah.com>
References: <20200808124242.GA352821@kroah.com>
 <20200808150443.GA492@DESKTOP-O1885NU.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808150443.GA492@DESKTOP-O1885NU.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 04:05:00PM +0100, Catalin Marinas wrote:
> Hi Greg,
> 
> On Sat, Aug 08, 2020 at 02:42:42PM +0200, Greg Kroah-Hartman wrote:
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 87e81d29e6fb..b421a4756793 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
> >  arch_initcall(reserve_memblock_reserved_regions);
> >  
> >  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
> > +EXPORT_SYMBOL_GPL(__cpu_logical_map);
> 
> This was still under discussion, Sudeep preferring an alternative in the
> driver:
> 
> http://lkml.kernel.org/r/20200727172744.GD8003@bogus
> http://lkml.kernel.org/r/20200724131059.GB6521@bogus
> 
> Sumit came with a new diff inline that fixes the driver instead of
> exporting the __cpu_logical_map.
> 
> https://lore.kernel.org/linux-arm-kernel/e3a4bc21-c334-4d48-90b5-aab8d187939e@nvidia.com/

Ok, but having a broken tree is not nice, how did this survive
linux-next testing?

> Sumit, Sudeep, is the above diff sufficient and can it go upstream?

Note that MIPS already export this symbol, so perhaps the drivers that
need it on that platform should also be fixed the same way?

thanks,

greg k-h

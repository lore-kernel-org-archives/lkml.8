Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFE1C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5862821734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581585400;
	bh=GiebtmJpNzAk9Qikj9svaXnffKSNLaoVx4iZEJ1f9R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N7CbmNE/YMFCmh/+m0B8Tk9htxyg6vr2Vft2x59cZ51pv33Zm3UKUWgOaUyBpXgaT
	 tjGTplZaR91hGU5O3C7a+f1o7/Q1Yd3uunYpDRcgYjAitVEWWn9GDymoRtv8X/wNN3
	 8cqwEo2MewJTgFmFjZu5bNmWDZNLmRHNZYVeW6NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgBMJQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgBMJQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:16:39 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4556620848;
        Thu, 13 Feb 2020 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581585398;
        bh=GiebtmJpNzAk9Qikj9svaXnffKSNLaoVx4iZEJ1f9R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tl6c66Z/muXXGGsR8OFmt//7oEMoFMLpSOdMqTmIZMcSapkUUhJ5KhzDiPIeGnuRs
         s6L05Zr2yBZTqQxPgrTxwf/vJZuS09jUreCa650odBkGyci7sfrn50FK2D+S/FgaEJ
         hzkiirULO+oY9fiFM996uGnX90vfzqRz2rcR9e4g=
Date:   Thu, 13 Feb 2020 09:16:33 +0000
From:   Will Deacon <will@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iommu/arm-smmu: fix the module name to be consistent
 with older kernel
Message-ID: <20200213091633.GA849@willie-the-truck>
References: <1581467841-25397-1-git-send-email-leoyang.li@nxp.com>
 <20200212104902.GA3664@willie-the-truck>
 <CADRPPNQ-FcA-xdjp02ybsYeU9UFxCZU5dpf0wHThTmLHcjovCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNQ-FcA-xdjp02ybsYeU9UFxCZU5dpf0wHThTmLHcjovCQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 01:59:46PM -0600, Li Yang wrote:
> On Wed, Feb 12, 2020 at 4:50 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Feb 11, 2020 at 06:37:20PM -0600, Li Yang wrote:
> > > Commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
> > > introduced a side effect that changed the module name from arm-smmu to
> > > arm-smmu-mod.  This breaks the users of kernel parameters for the driver
> > > (e.g. arm-smmu.disable_bypass).  This patch changes the module name back
> > > to be consistent.
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > ---
> > >  drivers/iommu/Makefile                          | 4 ++--
> > >  drivers/iommu/{arm-smmu.c => arm-smmu-common.c} | 0
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >  rename drivers/iommu/{arm-smmu.c => arm-smmu-common.c} (100%)
> >
> > Can't we just override MODULE_PARAM_PREFIX instead of renaming the file?
> 
> I can do that.  But on the other hand, the "mod" in the module name
> arm-smmu-mod.ko seems to be redundant and looks a little bit weird.
> Wouldn't it be cleaner to make it just arm-smmu.ko?

I just didn't fancy renaming the file because it's a pain for backports
and why does the name of the module matter?

Will

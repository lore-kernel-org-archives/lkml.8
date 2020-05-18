Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F18C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC77F20809
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589815126;
	bh=7pn0POB44tC2n5gNnVjv3NxibG0KtevFb7C2erURwxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ts0tWuWKUdUekzwFiQrK5VRhH9k/ypp1l1QmEO5v6wZ04FuRXXd5N/qqPzwV3XTIO
	 4LEAXLXhGrZd0svWvFNMC8pVBarOlUEjyLK102NI4A8GAPQtKBgo1QftmyROLiSCG7
	 52l8Re3SM71cXjNkwGQYwlwR2cKJeAVjQmQ2z1DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgERPSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgERPSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:18:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF82C207D3;
        Mon, 18 May 2020 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589815124;
        bh=7pn0POB44tC2n5gNnVjv3NxibG0KtevFb7C2erURwxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQlgb2ic/mmOg59kHAC86otewooCNikOj5trO7coH/eQB25WXcK7PtMEKDq5pBxcu
         amwAXY1BjRUtiKaElfjc3FaaluZEN7s5g9mKh0QqG7l+Vkz2HAHOAi3YVT7/tW4P9I
         fA1MHiWy8zQdn70CubreIQvELhUeLbBN/VvOkpcM=
Date:   Mon, 18 May 2020 16:18:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/6] arm/smmu: Add auxiliary domain support for
 arm-smmuv2
Message-ID: <20200518151838.GL32394@willie-the-truck>
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
 <1580249770-1088-3-git-send-email-jcrouse@codeaurora.org>
 <20200318224840.GA10796@willie-the-truck>
 <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 04:43:07PM -0700, Rob Clark wrote:
> On Wed, Mar 18, 2020 at 3:48 PM Will Deacon <will@kernel.org> wrote:
> > On Tue, Jan 28, 2020 at 03:16:06PM -0700, Jordan Crouse wrote:
> > > Support auxiliary domains for arm-smmu-v2 to initialize and support
> > > multiple pagetables for a single SMMU context bank. Since the smmu-v2
> > > hardware doesn't have any built in support for switching the pagetable
> > > base it is left as an exercise to the caller to actually use the pagetable.
> > >
> > > Aux domains are supported if split pagetable (TTBR1) support has been
> > > enabled on the master domain.  Each auxiliary domain will reuse the
> > > configuration of the master domain. By default the a domain with TTBR1
> > > support will have the TTBR0 region disabled so the first attached aux
> > > domain will enable the TTBR0 region in the hardware and conversely the
> > > last domain to be detached will disable TTBR0 translations.  All subsequent
> > > auxiliary domains create a pagetable but not touch the hardware.
> > >
> > > The leaf driver will be able to query the physical address of the
> > > pagetable with the DOMAIN_ATTR_PTBASE attribute so that it can use the
> > > address with whatever means it has to switch the pagetable base.
> > >
> > > Following is a pseudo code example of how a domain can be created
> > >
> > >  /* Check to see if aux domains are supported */
> > >  if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
> > >        iommu = iommu_domain_alloc(...);
> > >
> > >        if (iommu_aux_attach_device(domain, dev))
> > >                return FAIL;
> > >
> > >       /* Save the base address of the pagetable for use by the driver
> > >       iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
> > >  }
> >
> > I'm not really understanding what the pagetable base gets used for here and,
> > to be honest with you, the whole thing feels like a huge layering violation
> > with the way things are structured today. Why doesn't the caller just
> > interface with io-pgtable directly?
> >
> > Finally, if we need to support context-switching TTBR0 for a live domain
> > then that code really needs to live inside the SMMU driver because the
> > ASID and TLB management necessary to do that safely doesn't belong anywhere
> > else.
> 
> We do in fact need live domain switching, that is really the whole
> point.  The GPU CP (command processor/parser) is directly updating
> TTBR0 and triggering TLB flush, asynchronously from the CPU.
> 
> And I think the answer about ASID is easy (on current hw).. it must be zero[*].

Using ASID zero is really bad, because it means that you will end up sharing
TLB entries with whichever device is using context bank 0.

Is the SMMU only used by the GPU in your SoC?

Will

Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B39C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AFD24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582110908;
	bh=VrtmvhAEzN6b003vnaoKuVG14IEQHmRL14jqXjioLEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GWF9hgg9pTc9Pqv0OSRljD1R0McbJcTjysZLrOheXQmkJt7ls54Q0iVnfN31M1mv4
	 tQVDb8C2XOqvsud7TrpVPdFBX9DigMjXGYunR0oFK2dSeDS0He0pIPjCLjkwXVgejH
	 dLIrVSlZfWgFnFInV25AZGjsIiwciy4AcQ9iQMsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBSLPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgBSLPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:15:07 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1531F2067D;
        Wed, 19 Feb 2020 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582110906;
        bh=VrtmvhAEzN6b003vnaoKuVG14IEQHmRL14jqXjioLEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ywq963r6rr3QXJ8K+Kdq9md8IGCU6LJ8X9byT2d/5qrp03Uj2pFHy1S7HV4Hu9d3b
         /jmBpIsLqYVEgqlvU2A2YuhjKMkx76TqlQc8qFC4ylaTX5+R22i2kN0Py3eC8SdHh1
         BehTpWPebhqUIWr7+Tf9Jekp1FQFeCUBruxXK1FY=
Date:   Wed, 19 Feb 2020 11:15:01 +0000
From:   Will Deacon <will@kernel.org>
To:     isaacm@codeaurora.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>, pratikp@codeaurora.org,
        linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200219111501.GA19400@willie-the-truck>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
> On 2020-02-17 07:50, Robin Murphy wrote:
> > On 17/02/2020 8:01 am, Christoph Hellwig wrote:
> > > On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
> > > > From: Liam Mark <lmark@codeaurora.org>
> > > > 
> > > > Some devices have a memory map which contains gaps or holes.
> > > > In order for the device to have as much IOVA space as possible,
> > > > allow its driver to inform the DMA-IOMMU layer that it should
> > > > not allocate addresses from these holes.
> > > 
> > > Layering violation.  dma-iommu is the translation layer between the
> > > DMA API and the IOMMU API.  And calls into it from drivers performing
> > > DMA mappings need to go through the DMA API (and be documented there).
> > 
> > +1
> > 
> > More than that, though, we already have "holes in the address space"
> > support for the sake of PCI host bridge windows - assuming this is the
> > same kind of thing (i.e. the holes are between memory regions and
> > other resources in PA space, so are only relevant once address
> > translation comes into the picture), then this is IOMMU API level
> To make sure that we're on the same page, this support alludes to the
> handling in
> dma-iommu.c that reserves portions of the IOVA space for the PCI host bridge
> windows,
> correct? If so, then yes, this is similar.
> > stuff, so even a DMA API level interface would be inappropriate.
> Does this mean that the driver should be managing the IOVA space and
> mappings for this device using the IOMMU API? If so, is the rationale for
> this because the device driver can have the information of what IOVA ranges
> can and cannot be used? Shouldn't there be a generic way of informing an
> IOMMU driver about these reserved ranges? Perhaps through a device tree
> property, instead of deferring this type of management to the driver?

Before we dive into designing that, can you please clarify whether the
reserved IOVA range applies to all DMA masters mastering through a
particular SMMU, or whether it's just about one specific master? I was
assuming the former, but wanted to be sure.

Thanks,

Will

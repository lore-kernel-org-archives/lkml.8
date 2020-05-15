Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895B720671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEOOUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:20:51 -0400
Received: from 8bytes.org ([81.169.241.247]:43486 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEOOUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:20:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 792053C3; Fri, 15 May 2020 16:20:49 +0200 (CEST)
Date:   Fri, 15 May 2020 16:20:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200515142047.GX18353@8bytes.org>
References: <20200515094519.20338-1-joro@8bytes.org>
 <8ce93a10-2ce0-e5a0-88a0-5d21d7003c0f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce93a10-2ce0-e5a0-88a0-5d21d7003c0f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:51:03PM +0800, Lu Baolu wrote:
> On 2020/5/15 17:45, Joerg Roedel wrote:
> >   struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> >   {
> > -	return dev->iommu_group->default_domain;
> > +	struct iommu_domain *domain = dev->iommu_group->default_domain;
> > +
> > +	if (__iommu_is_attach_deferred(domain, dev))
> > +		__iommu_attach_device_no_defer(domain, dev);
> 
> It seems that the return value needs to be checked. The default domain
> is invalid if attach() failed.

True, I looked at that, the callers can't handle returning NULL here, so
I kept it this way for now. The outcome is that DMA will fail, but
otherwise we'd see a NULL-ptr dereference really quickly after returning
from that function.

Bottom line: This needs to be cleaned up separatly.

Regards,

	Joerg

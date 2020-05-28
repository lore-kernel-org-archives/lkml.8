Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A14C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E31207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgE1GmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:42:20 -0400
Received: from 8bytes.org ([81.169.241.247]:45136 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE1GmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:42:20 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2194526B; Thu, 28 May 2020 08:42:18 +0200 (CEST)
Date:   Thu, 28 May 2020 08:42:16 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] iommu/amd: Unexport get_dev_data()
Message-ID: <20200528064216.GN5221@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
 <20200527115313.7426-3-joro@8bytes.org>
 <20200528061353.GA17035@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528061353.GA17035@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:13:53PM -0700, Christoph Hellwig wrote:
> On Wed, May 27, 2020 at 01:53:05PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > This function is internal to the AMD IOMMU driver and only exported
> > because the amd_iommu_v2 modules calls it. But the reason it is called
> > from there could better be handled by amd_iommu_is_attach_deferred().
> > So unexport get_dev_data() and use amd_iommu_is_attach_deferred()
> > instead.
> 
> Btw, what is the reason amd_iommu_v2 is a separate module?  It is
> very little code, and other drivers seem to just integrate such
> functionality.

The module contains optional functionality that is only needed by the
amd_kfd driver, which itself only does something useful on (newer) AMD
GPUs. So I made it a separate module back in the days to save the memory
when it is not needed. But this caused other problems with the amd_kfd
module, when they got loaded in the wrong order. And the module is often
loaded by distros anyway, as it successfully loads even when no AMD
IOMMU is in the system. The reason for that was to have the symbols
available for drivers which can optionally use AMD IOMMUv2
functionality.

In fact I have already thought about making it built-in, just havn't
done so yet.


Regards,

	Joerg

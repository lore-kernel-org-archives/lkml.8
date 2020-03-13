Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF620C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F30206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCMNgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:36:47 -0400
Received: from 8bytes.org ([81.169.241.247]:51122 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgCMNgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:36:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1700A269; Fri, 13 Mar 2020 14:36:46 +0100 (CET)
Date:   Fri, 13 Mar 2020 14:36:44 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/6] Replace private domain with per-group default
Message-ID: <20200313133644.GO3794@8bytes.org>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
 <20200310111503.GF3794@8bytes.org>
 <cd0f526c-da68-ef59-580f-665ad08a395f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd0f526c-da68-ef59-580f-665ad08a395f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:50:39PM +0800, Lu Baolu wrote:
> On 2020/3/10 19:15, Joerg Roedel wrote:
> > Hi Baolu,
> > 
> > On Sat, Mar 07, 2020 at 02:20:08PM +0800, Lu Baolu wrote:
> > > Lu Baolu (5):
> > >    iommu: Configure default domain with dev_def_domain_type
> > >    iommu/vt-d: Don't force 32bit devices to uses DMA domain
> > >    iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
> > >    iommu/vt-d: Add dev_def_domain_type callback
> > >    iommu/vt-d: Apply per-device dma_ops
> > > 
> > > Sai Praneeth Prakhya (1):
> > >    iommu: Add dev_def_domain_type() callback in iommu_ops
> > 
> > I like this patch-set, but I fear some regressions from patch
> > "iommu/vt-d: Don't force 32bit devices to uses DMA domain". Have you
> > tested this series on a couple of machines, ideally even older ones from
> > the first generation of VT-d hardware?
> 
> The oldest hardware I have is Ivy Bridge. :-) Actually, The effect of
> using identity domain for 32-bit devices is the same as that of adding
> intel_iommu=off in the kernel parameter. Hence, if there is any
> regression, people should also find it with intel_iommu=off.
> intel_iommu=off support is added at the very beginning of VT-d driver.

Okay, I will also do some testing on it, one of my VT-d machines is a
Haswell. Please send a new version with the recent comments addressed.

Regards,

	Joerg

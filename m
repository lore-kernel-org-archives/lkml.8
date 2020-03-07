Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19737C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD80206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCGOVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 09:21:47 -0500
Received: from verein.lst.de ([213.95.11.211]:41220 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgCGOVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:21:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB26E68BE1; Sat,  7 Mar 2020 15:21:44 +0100 (CET)
Date:   Sat, 7 Mar 2020 15:21:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] iommu/vt-d: Don't force 32bit devices to uses DMA
 domain
Message-ID: <20200307142144.GB26190@lst.de>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com> <20200307062014.3288-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307062014.3288-4-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 02:20:11PM +0800, Lu Baolu wrote:
> Currently, if a 32bit device initially uses an identity domain,
> Intel IOMMU driver will convert it forcibly to a DMA one if its
> address capability is not enough for the whole system memory.
> The motivation was to overcome the overhead caused by possible
> bounced buffer.
> 
> Unfortunately, this improvement has led to many problems. For
> example, some 32bit devices are required to use an identity
> domain, forcing them to use DMA domain will cause the device
> not to work anymore. On the other hand, the VMD sub-devices
> share a domain but each sub-device might have different address
> capability. Forcing a VMD sub-device to use DMA domain blindly
> will impact the operation of other sub-devices without any
> notification. Further more, PCI aliased devices (PCI bridge
> and all devices beneath it, VMD devices and various devices
> quirked with pci_add_dma_alias()) must use the same domain.
> Forcing one device to switch to DMA domain during runtime
> will cause in-fligh DMAs for other devices to abort or target
> to other memory which might cause undefind system behavior.

I still don't like the idea to enforce either a strict dynamic
IOMMU mapping or an identify mapping mode.

Can we add a new AUTO domain which will allow using the identity
mapping when available?  That somewhat matches the existing x86
default, and also what powerpc does.  I have a series to lift
that bypass mode into the core dma-mapping code that I need
to repost, which I think would be suitable for intel-iommu as well.

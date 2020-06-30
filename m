Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A52FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7776E206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgF3R20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:28:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:57664 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgF3R2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:28:25 -0400
IronPort-SDR: Nmkk3N//AC0X3k+hiW2X4zMPymTWirWOy6Jf4s2zOEs7g2P665Rk9Zjqk7e7tgKT1LnTB0Vqnq
 cgwKMelKULag==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="145389860"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="145389860"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:28:25 -0700
IronPort-SDR: iic3PxhGJrZzMZYF5AwBTrPWKPYtdK4G0iPGGe2A6J+qfv6LgmwGkl419RUyX7A2ZrQIO75+Ds
 5vmxmwbb6IwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="277496676"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 30 Jun 2020 10:28:24 -0700
Date:   Tue, 30 Jun 2020 10:34:59 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 6/7] iommu/vt-d: Warn on out-of-range invalidation
 address
Message-ID: <20200630103459.6c99c961@jacob-builder>
In-Reply-To: <d87d15fd-71d5-6735-74df-583024826ab0@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1592926996-47914-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <d87d15fd-71d5-6735-74df-583024826ab0@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 18:10:43 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 2020/6/23 23:43, Jacob Pan wrote:
> > For guest requested IOTLB invalidation, address and mask are
> > provided as part of the invalidation data. VT-d HW silently ignores
> > any address bits below the mask. SW shall also allow such case but
> > give warning if address does not align with the mask. This patch
> > relax the fault handling from error to warning and proceed with
> > invalidation request with the given mask.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c
> > b/drivers/iommu/intel/iommu.c index 5ea5732d5ec4..50fc62413a35
> > 100644 --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, 
> >   		switch (BIT(cache_type)) {
> >   		case IOMMU_CACHE_INV_TYPE_IOTLB:
> > +			/* HW will ignore LSB bits based on
> > address mask */ if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> >   			    size &&
> >   			    (inv_info->addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> > -				pr_err_ratelimited("Address out of
> > range, 0x%llx, size order %llu\n",
> > -
> > inv_info->addr_info.addr, size);
> > -				ret = -ERANGE;
> > -				goto out_unlock;
> > +				WARN_ONCE(1, "Address out of
> > range, 0x%llx, size order %llu\n",
> > +
> > inv_info->addr_info.addr, size);  
> 
> I don't think WARN_ONCE() is suitable here. It makes users think it's
> a kernel bug. How about pr_warn_ratelimited()?
> 
I think pr_warn_ratelimited might still be too chatty. There is no
functional issues, we just don't to silently ignore it. Perhaps just
say:
WARN_ONCE(1, "User provided address not page aligned, alignment forced")
?

> Best regards,
> baolu
> 
> >   			}
> >   
> >   			/*
> >   

[Jacob Pan]

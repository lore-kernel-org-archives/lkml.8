Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1DFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CDC2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGFXWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:22:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:15388 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgGFXWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:22:03 -0400
IronPort-SDR: C6hRlSX5UVStA2z9DTUkUSq9hGS1qbflMQDXBfSxOBuLbvMlBI8HUEGnimoSI5ogPfidg0j8XK
 3wP1gha85MwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212489286"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212489286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 16:22:02 -0700
IronPort-SDR: DUQiRH/yb0VAUuvv9WoeSXxG4RudMD/sUQFfTbuKABUl98CIFpVtuwyg6SuWbeYDPIXm7Dbd5/
 pCSP2MOIRGrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="456902687"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 16:22:02 -0700
Date:   Mon, 6 Jul 2020 16:28:40 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Handle non-page aligned address
Message-ID: <20200706162840.24b3230e@jacob-builder>
In-Reply-To: <40a83912-f8ad-9887-38d0-39a70ecc062c@redhat.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1593617636-79385-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <40a83912-f8ad-9887-38d0-39a70ecc062c@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 09:50:19 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 7/1/20 5:33 PM, Jacob Pan wrote:
> > From: Liu Yi L <yi.l.liu@intel.com>
> > 
> > Address information for device TLB invalidation comes from userspace
> > when device is directly assigned to a guest with vIOMMU support.
> > VT-d requires page aligned address. This patch checks and enforce
> > address to be page aligned, otherwise reserved bits can be set in
> > the invalidation descriptor. Unrecoverable fault will be reported
> > due to non-zero value in the reserved bits.  
> on the other hand if user space sends unaligned invalidations,
> shouldn't it be reported in some way?
> > 
> > Fixes: 61a06a16e36d8 ("iommu/vt-d: Support flushing more translation
> > cache types")
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/dmar.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> > index d9f973fa1190..3899f3161071 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -1455,9 +1455,25 @@ void qi_flush_dev_iotlb_pasid(struct
> > intel_iommu *iommu, u16 sid, u16 pfsid,
> >  	 * Max Invs Pending (MIP) is set to 0 for now until we
> > have DIT in
> >  	 * ECAP.
> >  	 */
> > -	desc.qw1 |= addr & ~mask;
> > -	if (size_order)
> > +	if (addr & ~VTD_PAGE_MASK)
> > +		pr_warn_ratelimited("Invalidate non-page aligned
> > address %llx\n", addr); +
> > +	/* Take page address */
> > +	desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr);
> > +
> > +	if (size_order) {
> > +		/*
> > +		 * Existing 0s in address below size_order may be
> > the least
> > +		 * significant bit, we must set them to 1s to
> > avoid having
> > +		 * smaller size than desired.  
> Shouldn't you test the input addr against the size_order. Aren't they
> supposed to be consistent? Otherwise one should emit a warning at
> least?
Will check size_order and addr match to emit warning. Combine with
VTD_PAGE_MASK check above.

> > +		 */
> > +		desc.qw1 |= GENMASK_ULL(size_order +
> > VTD_PAGE_SHIFT,
> > +					VTD_PAGE_SHIFT);  
> nit: instead of working directly on .qw1, couldn't you perform all
> those manipulations directly on addr? and eventually override qw1 at
> the end?
That is good too, I just felt it is more readable, which fields are
being manipulated in qw1.

> > +		/* Clear size_order bit to indicate size */
> > +		desc.qw1 &= ~mask;
> > +		/* Set the S bit to indicate flushing more than 1
> > page */ desc.qw1 |= QI_DEV_EIOTLB_SIZE;
> > +	}
> >  
> >  	qi_submit_sync(iommu, &desc, 1, 0);
> >  }
> >   
> Thanks
> 
> Eric
> 

[Jacob Pan]

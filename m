Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1BA2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbgF3RNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:13:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:27572 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390030AbgF3RNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:13:15 -0400
IronPort-SDR: 16OMpXsvA6yv64Vtzj4TtXQreaAHkMTbxogX0dsD6KMsURyQ0/f6TmIfuk22ctUzXBaXKDJu1a
 BmY2HgtDqxEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9667"; a="211373811"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="211373811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:13:13 -0700
IronPort-SDR: 02/sNAp9zxcbNDgk0wY96H4wgE8bWPD+nyuqc3fkfHghfvTs9QAEy0jZmbyhLaA5SUeQKekZ9B
 ALY3a5bgxuTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="355837194"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2020 10:13:12 -0700
Date:   Tue, 30 Jun 2020 10:19:47 -0700
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
Subject: Re: [PATCH 4/7] iommu/vt-d: Handle non-page aligned address
Message-ID: <20200630101947.1d45ac94@jacob-builder>
In-Reply-To: <037cb7cf-1336-f546-7f45-c35caf19930f@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1592926996-47914-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <037cb7cf-1336-f546-7f45-c35caf19930f@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 18:05:52 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 2020/6/23 23:43, Jacob Pan wrote:
> > From: Liu Yi L <yi.l.liu@intel.com>
> > 
> > Address information for device TLB invalidation comes from userspace
> > when device is directly assigned to a guest with vIOMMU support.
> > VT-d requires page aligned address. This patch checks and enforce
> > address to be page aligned, otherwise reserved bits can be set in
> > the invalidation descriptor. Unrecoverable fault will be reported
> > due to non-zero value in the reserved bits.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/dmar.c | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> > index d9f973fa1190..53f4e5003620 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -1455,9 +1455,24 @@ void qi_flush_dev_iotlb_pasid(struct
> > intel_iommu *iommu, u16 sid, u16 pfsid,
> >   	 * Max Invs Pending (MIP) is set to 0 for now until we
> > have DIT in
> >   	 * ECAP.
> >   	 */
> > -	desc.qw1 |= addr & ~mask;
> > -	if (size_order)
> > +	if (addr & ~VTD_PAGE_MASK)
> > +		pr_warn_ratelimited("Invalidate non-page aligned
> > address %llx\n", addr); +
> > +	if (size_order) {
> > +		/* Take page address */
> > +		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr);  
> 
> If size_order == 0 (that means only a single page is about to be
> invalidated), do you still need to set ADDR field of the descriptor?
> 
Good catch! we should always set addr. I will move addr assignment out
of the if condition.
 .
> Best regards,
> baolu
> 
> > +		/*
> > +		 * Existing 0s in address below size_order may be
> > the least
> > +		 * significant bit, we must set them to 1s to
> > avoid having
> > +		 * smaller size than desired.
> > +		 */
> > +		desc.qw1 |= GENMASK_ULL(size_order +
> > VTD_PAGE_SHIFT,
> > +					VTD_PAGE_SHIFT);
> > +		/* Clear size_order bit to indicate size */
> > +		desc.qw1 &= ~mask;
> > +		/* Set the S bit to indicate flushing more than 1
> > page */ desc.qw1 |= QI_DEV_EIOTLB_SIZE;
> > +	}
> >   
> >   	qi_submit_sync(iommu, &desc, 1, 0);
> >   }
> >   

[Jacob Pan]

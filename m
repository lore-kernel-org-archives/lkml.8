Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829C5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6850D20702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgGAONq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:13:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:45254 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731193AbgGAONp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:13:45 -0400
IronPort-SDR: +BrQfN0D80iopihZzCsWDdoHgEioToIPXEe7DLr6UGXSjPu+2HPsB+OkjUM1jszGalH7OcoQDj
 V81Hpy5n/UTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134037960"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="134037960"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 07:13:44 -0700
IronPort-SDR: fOtmYyZxrhlY1AuGr4Ozlj3jy5/x1r25cQc7P/xlxTkCSKcd57uDPdKFRMtlNudqyvfVmKSJal
 ZDVgJGQvmhbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="387016908"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2020 07:13:44 -0700
Date:   Wed, 1 Jul 2020 07:20:19 -0700
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
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Message-ID: <20200701072019.2afd1cc1@jacob-builder>
In-Reply-To: <6f970f1f-621e-f66e-79d4-f2871c121baa@linux.intel.com>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1593551258-39854-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <6f970f1f-621e-f66e-79d4-f2871c121baa@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 08:49:54 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 7/1/20 5:07 AM, Jacob Pan wrote:
> > DevTLB flush can be used for both DMA request with and without
> > PASIDs. The former uses PASID#0 (RID2PASID), latter uses non-zero
> > PASID for SVA usage.
> > 
> > This patch adds a check for PASID value such that devTLB flush with
> > PASID is used for SVA case. This is more efficient in that multiple
> > PASIDs can be used by a single device, when tearing down a PASID
> > entry we shall flush only the devTLB specific to a PASID.
> > 
> > Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table")
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel/pasid.c
> > b/drivers/iommu/intel/pasid.c index c81f0f17c6ba..70d21209dd04
> > 100644 --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -486,7 +486,16 @@ devtlb_invalidation_with_pasid(struct
> > intel_iommu *iommu, qdep = info->ats_qdep;
> >   	pfsid = info->pfsid;
> >   
> > -	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
> > VTD_PAGE_SHIFT);
> > +	/*
> > +	 * When PASID 0 is used, it indicates RID2PASID(DMA
> > request w/o PASID),
> > +	 * devTLB flush w/o PASID should be used. For non-zero
> > PASID under
> > +	 * SVA usage, device could do DMA with multiple PASIDs. It
> > is more
> > +	 * efficient to flush devTLB specific to the PASID.
> > +	 */
> > +	if (pasid == PASID_RID2PASID)
> > +		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid,
> > qdep, 0, 64 - VTD_PAGE_SHIFT);
> > +	else
> > +		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64
> > - VTD_PAGE_SHIFT);  
> 
> The if/else logic is reversed.
> 
> 	if (pasid == PASID_RID2PASID)
> 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
> VTD_PAGE_SHIFT); else
> 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid,
> qdep, 0, 64 - VTD_PAGE_SHIFT);
> 
indeed, will fix. thanks

> Best regards,
> baolu
> 
> >   }
> >   
> >   void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> > struct device *dev, 

[Jacob Pan]

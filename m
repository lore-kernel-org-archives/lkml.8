Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EED4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FBB206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgF3Eub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:50:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:40274 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgF3Eua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:50:30 -0400
IronPort-SDR: ZqaF6jYvOZBVcYViMez1UQkcq3L1iaiu69bVe0T+tAsEqY0W5YloNkailibrgo/MQbONpQz1zG
 ZM42McaMn/TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="230995301"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="230995301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 21:50:29 -0700
IronPort-SDR: YDVA/aYnL+AdORxJOcaUrm4P4FFEuhV5QspBKdyUg1K4nteR2qMdYjvlk2FSnc5Jyy7DWQ8nB+
 fnfawDMxGVjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="313280347"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2020 21:50:28 -0700
Date:   Mon, 29 Jun 2020 21:57:03 -0700
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
Subject: Re: [PATCH 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Message-ID: <20200629215703.4858896d@jacob-builder>
In-Reply-To: <57091f4a-fb53-40a4-6a28-a498f548f8b8@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1592926996-47914-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <57091f4a-fb53-40a4-6a28-a498f548f8b8@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 15:25:57 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> On 2020/6/23 23:43, Jacob Pan wrote:
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
> > b/drivers/iommu/intel/pasid.c index c81f0f17c6ba..3991a24539a1
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
> > +	if (pasid)  
> 
> How about
> 
> 	if (pasid == PASID_RID2PASID)
> 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
> VTD_PAGE_SHIFT); else
> 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid,
> qdep, 0, 64 - VTD_PAGE_SHIFT);
> 
> ?
> 
> It makes the code more readable and still works even we reassign
> another pasid for RID2PASID.
> 
agreed, thanks.

> Best regards,
> baolu
> 
> > +		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid,
> > qdep, 0, 64 - VTD_PAGE_SHIFT);
> > +	else
> > +		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64
> > - VTD_PAGE_SHIFT); }
> >   
> >   void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> > struct device *dev, 

[Jacob Pan]

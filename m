Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608ADC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AADB206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgDHQGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:06:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:62264 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbgDHQGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:06:02 -0400
IronPort-SDR: EQuy1YXZU1ZUHsEIbiMPSGfPewYu0IulUvXyeM0EYiMXUenlvL3FLMXt5Ha7WFKRrKnQGrBQp0
 ukMPLP0AUZrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:06:01 -0700
IronPort-SDR: FWGMRCIDKc+4rShY/k2btbmNpB2Vde5BU/A9n1poyY3PXe4Ws5w3Xl/N5BgmtT1pk2Wkr9ZZko
 cDdb4dYAUqXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="330578827"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2020 09:06:01 -0700
Date:   Wed, 8 Apr 2020 09:11:52 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v11 02/10] iommu/uapi: Define a mask for bind data
Message-ID: <20200408091152.7e2a2fef@jacob-builder>
In-Reply-To: <20200408130722.GA27140@8bytes.org>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585939334-21396-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200408130722.GA27140@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 15:07:22 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Fri, Apr 03, 2020 at 11:42:06AM -0700, Jacob Pan wrote:
> > Memory type related flags can be grouped together for one simple
> > check.
> > 
> > ---
> > v9 renamed from EMT to MTS since these are memory type support
> > flags. ---
> > 
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 4ad3496e5c43..d7bcbc5f79b0 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
> >  	__u32 pat;
> >  	__u32 emt;
> >  };
> > -
> > +#define IOMMU_SVA_VTD_GPASID_MTS_MASK
> > (IOMMU_SVA_VTD_GPASID_CD | \
> > +					 IOMMU_SVA_VTD_GPASID_EMTE
> > | \
> > +					 IOMMU_SVA_VTD_GPASID_PCD
> > |  \
> > +
> > IOMMU_SVA_VTD_GPASID_PWT)  
> 
> Where and how will this be used? Can you add this in the patch that
> actually makes use of it?
> 
They are used in later patch when setting up PASID entry for guest SVA.
[PATCH v11 04/10] iommu/vt-d: Add nested translation helper function

> Also please add newlines before and after that define.
> 
Will do, thanks.

> 
> Regards,
> 
> 	Joerg

[Jacob Pan]

Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCB8C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729D920784
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgCTVaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:30:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:22684 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgCTVaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:30:14 -0400
IronPort-SDR: kSePeINvczItTPF6khRq1602Cpx4z9Go+JxpCJY2bLF1LJfwdlb8zRzWVf4+PF6wBPflE8pVUB
 C5DfOov/twDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 14:30:14 -0700
IronPort-SDR: 7wo3zcGm4hq6KANZAFHmC5DfE/INzc2Gh0T2bUeWgeTIJgm2mVdDyWIAeS/a6nuBHhqT5wGvv4
 +8bC7NPHAOAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="324984109"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2020 14:30:13 -0700
Date:   Fri, 20 Mar 2020 14:35:55 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V9 02/10] iommu/uapi: Define a mask for bind data
Message-ID: <20200320143555.15bf7c7a@jacob-builder>
In-Reply-To: <c51ba1a1-343d-c458-1529-5f9fb11d13b9@redhat.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1580277713-66934-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <c51ba1a1-343d-c458-1529-5f9fb11d13b9@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 13:43:43 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 1/29/20 7:01 AM, Jacob Pan wrote:
> > Memory type related guest PASID bind data can be grouped together
> > for one simple check.  
> Those are flags related to memory type.
right, will rephrase.
> > Link:
> > https://lore.kernel.org/linux-iommu/20200109095123.17ed5e6b@jacob-builder/  
> not sure the link is really helpful.
> > 
will delete. the patch is very simple.

> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 4ad3496e5c43..fcafb6401430 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
> >  	__u32 pat;
> >  	__u32 emt;
> >  };
> > -
> > +#define IOMMU_SVA_VTD_GPASID_EMT_MASK
> > (IOMMU_SVA_VTD_GPASID_CD | \
> > +					 IOMMU_SVA_VTD_GPASID_EMTE
> > | \
> > +					 IOMMU_SVA_VTD_GPASID_PCD
> > |  \
> > +
> > IOMMU_SVA_VTD_GPASID_PWT)  
> Why EMT rather than MT or MTS?
> the spec says:
> Those fields are treated as Reserved(0) for implementations not
> supporting Memory Type (MTS=0 in Extended Capability Register).
> 
MTS makes more sense, will change.
It was from hygiene p.o.v. checking the flag to avoid touching these
fields.

Thanks,

Jacob
> >  /**
> >   * struct iommu_gpasid_bind_data - Information about device and
> > guest PASID binding
> >   * @version:	Version of this data structure
> >   
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]

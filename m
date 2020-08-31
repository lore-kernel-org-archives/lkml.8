Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004FDC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B9C20658
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHaRpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:45:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:37338 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgHaRpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:45:19 -0400
IronPort-SDR: 4+pOY6XgtJz5GIYqWemHHJG51ckVZTx8t55r7HcHahSnMeJlCPUMSgSnB8p0BbqbCr4XCcpe22
 ytNZ8pEMs2BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175075718"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="175075718"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 10:45:18 -0700
IronPort-SDR: 4V0HKjPMEFKjJ0dIOMZTyD7eACTRqRvtsa0jzkyZrLLFrCUNsnqyHPIMd+XP7P1heylDfFA6Ly
 bRfswT/CRLSw==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="340728810"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 10:45:17 -0700
Date:   Mon, 31 Aug 2020 10:52:24 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 7/7] iommu/vt-d: Check UAPI data processed by IOMMU
 core
Message-ID: <20200831105224.7a90ba34@jacob-builder>
In-Reply-To: <1b131401-a9a3-3641-99cc-430d9b51efa5@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1596068467-49322-8-git-send-email-jacob.jun.pan@linux.intel.com>
        <1b131401-a9a3-3641-99cc-430d9b51efa5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 11:19:46 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 7/30/20 2:21 AM, Jacob Pan wrote:
> > IOMMU generic layer already does sanity checks UAPI data for version
> > match and argsz range under generic information.
> > Remove the redundant version check from VT-d driver and check for
> > vendor specific data size.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> > ---
> >  drivers/iommu/intel/iommu.c | 3 +--
> >  drivers/iommu/intel/svm.c   | 7 +++++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c
> > b/drivers/iommu/intel/iommu.c index 021f62078f52..7e03cca31a0e
> > 100644 --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5391,8 +5391,7 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, int ret = 0;
> >  	u64 size = 0;
> >  
> > -	if (!inv_info || !dmar_domain ||
> > -	    inv_info->version !=
> > IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> > +	if (!inv_info || !dmar_domain)
> >  		return -EINVAL;
> >  
> >  	if (!dev || !dev_is_pci(dev))
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index 713b3a218483..55ea11e9c0f5 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -240,8 +240,11 @@ int intel_svm_bind_gpasid(struct iommu_domain
> > *domain, struct device *dev, if (WARN_ON(!iommu) || !data)
> >  		return -EINVAL;
> >  
> > -	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> > -	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +		return -EINVAL;
> > +
> > +	/* IOMMU core ensures argsz is more than the start of the
> > union */
> > +	if (data->argsz < offsetofend(struct
> > iommu_gpasid_bind_data, vendor.vtd)) return -EINVAL;  
> Shouldn't you test the vendor flags here?
> intel_pasid_setup_bind_data() only checks valid ones but not ~mask.
> 
Yes, vendor flags should be tested to make sure there is no undefined
flags being used.

Thanks!

> Thanks
> 
> Eric
> >  
> >  	if (!dev_is_pci(dev))
> >   
> 

[Jacob Pan]

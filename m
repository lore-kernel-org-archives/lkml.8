Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A39220639
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHQXJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:09:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:27833 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHQXJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:09:18 -0400
IronPort-SDR: d7DqqNsWu3Hll1Iwjdh6OWW9Y/Zg7HPNzipVy2hnZk7KFS2R8LWzI7m8IkkgjJV37awnUP/2k+
 6rfWGFWnYexQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="239629314"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="239629314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 16:09:15 -0700
IronPort-SDR: KMpVnkvl+UhEi/okXHw8bi5AJiqlz6P9Yyoa9lS+QCz9vQJPiIUsxA0v3Anu2ON4wtYgUePGQN
 dBpBZuXqaaFQ==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="310244195"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 16:09:16 -0700
Date:   Mon, 17 Aug 2020 16:16:15 -0700
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
Subject: Re: [PATCH v7 5/7] iommu/uapi: Rename uapi functions
Message-ID: <20200817161615.35dac072@jacob-builder>
In-Reply-To: <310ebf1c-02d6-b31f-e92e-619d46fa94aa@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1596068467-49322-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <310ebf1c-02d6-b31f-e92e-619d46fa94aa@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 10:58:53 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 7/30/20 2:21 AM, Jacob Pan wrote:
> > User APIs such as iommu_sva_unbind_gpasid() may also be used by the
> > kernel. Since we introduced user pointer to the UAPI functions,  
> Practically this is done in the next patch. What about something like:
> 
> We plan to have two flavors of the same API functions, one called
> through ioctls, carrying a user pointer and one called directly with
> valid IOMMU UAPI structs. To differentiate both, let's rename existing
> functions with an iommu_uapi_ prefix.
> 
will do. Thanks!

> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> 
> Thanks
> 
> Eric
> > in-kernel callers cannot share the same APIs. In-kernel callers are
> > also trusted, there is no need to validate the data.
> > 
> > This patch renames all UAPI functions with iommu_uapi_ prefix such
> > that is clear to the intended callers.
> > 
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 18 +++++++++---------
> >  include/linux/iommu.h | 31 ++++++++++++++++---------------
> >  2 files changed, 25 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index b6858adc4f17..3a913ce94a3d 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1950,35 +1950,35 @@ int iommu_attach_device(struct iommu_domain
> > *domain, struct device *dev) }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > -int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > device *dev,
> > -			   struct iommu_cache_invalidate_info
> > *inv_info) +int iommu_uapi_cache_invalidate(struct iommu_domain
> > *domain, struct device *dev,
> > +				struct iommu_cache_invalidate_info
> > *inv_info) {
> >  	if (unlikely(!domain->ops->cache_invalidate))
> >  		return -ENODEV;
> >  
> >  	return domain->ops->cache_invalidate(domain, dev,
> > inv_info); }
> > -EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> > +EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
> >  
> > -int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > -			   struct device *dev, struct
> > iommu_gpasid_bind_data *data) +int
> > iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> > +			       struct device *dev, struct
> > iommu_gpasid_bind_data *data) {
> >  	if (unlikely(!domain->ops->sva_bind_gpasid))
> >  		return -ENODEV;
> >  
> >  	return domain->ops->sva_bind_gpasid(domain, dev, data);
> >  }
> > -EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
> > +EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
> >  
> > -int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > -			     ioasid_t pasid)
> > +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > struct device *dev,
> > +				 ioasid_t pasid)
> >  {
> >  	if (unlikely(!domain->ops->sva_unbind_gpasid))
> >  		return -ENODEV;
> >  
> >  	return domain->ops->sva_unbind_gpasid(dev, pasid);
> >  }
> > -EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> > +EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
> >  
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 5f0b7859d2eb..2dcc1a33f6dc 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -430,13 +430,13 @@ extern int iommu_attach_device(struct
> > iommu_domain *domain, struct device *dev);
> >  extern void iommu_detach_device(struct iommu_domain *domain,
> >  				struct device *dev);
> > -extern int iommu_cache_invalidate(struct iommu_domain *domain,
> > -				  struct device *dev,
> > -				  struct
> > iommu_cache_invalidate_info *inv_info); -extern int
> > iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > -		struct device *dev, struct iommu_gpasid_bind_data
> > *data); -extern int iommu_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > -				struct device *dev, ioasid_t
> > pasid); +extern int iommu_uapi_cache_invalidate(struct iommu_domain
> > *domain,
> > +				       struct device *dev,
> > +				       struct
> > iommu_cache_invalidate_info *inv_info); +extern int
> > iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> > +				      struct device *dev, struct
> > iommu_gpasid_bind_data *data); +extern int
> > iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > +					struct device *dev,
> > ioasid_t pasid); extern struct iommu_domain
> > *iommu_get_domain_for_dev(struct device *dev); extern struct
> > iommu_domain *iommu_get_dma_domain(struct device *dev); extern int
> > iommu_map(struct iommu_domain *domain, unsigned long iova, @@
> > -1054,21 +1054,22 @@ static inline int iommu_sva_get_pasid(struct
> > iommu_sva *handle) return IOMMU_PASID_INVALID; }
> >  
> > -static inline int
> > -iommu_cache_invalidate(struct iommu_domain *domain,
> > -		       struct device *dev,
> > -		       struct iommu_cache_invalidate_info
> > *inv_info) +static inline int iommu_uapi_cache_invalidate(struct
> > iommu_domain *domain,
> > +					      struct device *dev,
> > +					      struct
> > iommu_cache_invalidate_info *inv_info) {
> >  	return -ENODEV;
> >  }
> > -static inline int iommu_sva_bind_gpasid(struct iommu_domain
> > *domain,
> > -				struct device *dev, struct
> > iommu_gpasid_bind_data *data) +
> > +static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain
> > *domain,
> > +					     struct device *dev,
> > +					     struct
> > iommu_gpasid_bind_data *data) {
> >  	return -ENODEV;
> >  }
> >  
> > -static inline int iommu_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > -					   struct device *dev, int
> > pasid) +static inline int iommu_uapi_sva_unbind_gpasid(struct
> > iommu_domain *domain,
> > +					       struct device *dev,
> > int pasid) {
> >  	return -ENODEV;
> >  }
> >   
> 

[Jacob Pan]

Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1678BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B4720719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbgDAWo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:44:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:48593 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388386AbgDAWo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:44:27 -0400
IronPort-SDR: NNSNTHSGI0Dl6w8YPN4s5KEiu5/Lyd3PTMV5+3Wd/aKAJFUmmoufShgGfz3kkH1JqJtQ+kHmhc
 fExyRv1bV1zQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 15:44:26 -0700
IronPort-SDR: zkdHSM9lj9RG+TCgrQGNl9DJiOh5LdoXcru112HuXNimShCk6VYW+Fmyawdg5b+53sAe07ES/A
 wXa/65VULsgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="284569522"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga002.fm.intel.com with ESMTP; 01 Apr 2020 15:44:25 -0700
Date:   Wed, 1 Apr 2020 15:50:13 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 01/10] iommu/ioasid: Introduce system-wide capacity
Message-ID: <20200401155013.7386b2ad@jacob-builder>
In-Reply-To: <20200401134552.GD882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200401134552.GD882512@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Wed, 1 Apr 2020 15:45:52 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Mar 25, 2020 at 10:55:22AM -0700, Jacob Pan wrote:
> > IOASID is a limited system-wide resource that can be allocated at
> > runtime. This limitation can be enumerated during boot. For
> > example, on x86 platforms, PCI Process Address Space ID (PASID)
> > allocation uses IOASID service. The number of supported PASID bits
> > are enumerated by extended capability register as defined in the
> > VT-d spec.
> > 
> > This patch adds a helper to set the system capacity, it expected to
> > be set during boot prior to any allocation request.  
> 
> This one-time setting is a bit awkward. Since multiple IOMMU drivers
> may be loaded, this can't be a module_init() thing. And we generally
> have multiple SMMU instances in the system. So we'd need to call
> install_capacity() only for the first SMMU loaded with an arbitrary
> 1<<20, even though each SMMU can support different numbers of PASID
> bits. Furthermore, modules such as iommu-sva will want to initialize
> their IOASID set at module_init(), which will happen before the SMMU
> can set up the capacity, so ioasid_alloc_set() will return an error.
> 
> How about hardcoding ioasid_capacity to 20 bits for now?  It's the
> PCIe limit and probably won't have to increase for a while.
> 
Sound good. Default to 20 bits but can be adjusted if needed.
 

> Thanks,
> Jean
> 
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 15 +++++++++++++++
> >  include/linux/ioasid.h |  5 ++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 0f8dd377aada..4026e52855b9 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -17,6 +17,21 @@ struct ioasid_data {
> >  	struct rcu_head rcu;
> >  };
> >  
> > +static ioasid_t ioasid_capacity;
> > +static ioasid_t ioasid_capacity_avail;
> > +
> > +/* System capacity can only be set once */
> > +void ioasid_install_capacity(ioasid_t total)
> > +{
> > +	if (ioasid_capacity) {
> > +		pr_warn("IOASID capacity already set at %d\n",
> > ioasid_capacity);
> > +		return;
> > +	}
> > +
> > +	ioasid_capacity = ioasid_capacity_avail = total;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> > +
> >  /*
> >   * struct ioasid_allocator_data - Internal data structure to hold
> > information
> >   * about an allocator. There are two types of allocators:
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 6f000d7a0ddc..9711fa0dc357 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set,
> > ioasid_t ioasid, int ioasid_register_allocator(struct
> > ioasid_allocator_ops *allocator); void
> > ioasid_unregister_allocator(struct ioasid_allocator_ops
> > *allocator); int ioasid_set_data(ioasid_t ioasid, void *data); -
> > +void ioasid_install_capacity(ioasid_t total);
> >  #else /* !CONFIG_IOASID */
> >  static inline ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, void *private)
> > @@ -72,5 +72,8 @@ static inline int ioasid_set_data(ioasid_t
> > ioasid, void *data) return -ENOTSUPP;
> >  }
> >  
> > +static inline void ioasid_install_capacity(ioasid_t total)
> > +{
> > +}
> >  #endif /* CONFIG_IOASID */
> >  #endif /* __LINUX_IOASID_H */
> > -- 
> > 2.7.4
> >   

[Jacob Pan]

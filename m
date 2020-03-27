Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D2CC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A784920737
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgC0QCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:02:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:31389 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgC0QCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:02:16 -0400
IronPort-SDR: hKCHUVvVwrKIlBFV4QH7qB2q7IYJbTKVtua7rSbnB92WFJcExbBTiO7E57dvFO8jpMLGrtSNgB
 ibm9L/bcSp9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:02:15 -0700
IronPort-SDR: xB2dVmSGKpWZumoZA4tldw1y68F80iVE6l1Sl7XNuAGzMoP4bmWRqTu/z4QoAm8CunjOIQYfNK
 rajAc6vD70+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="247925019"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2020 09:02:15 -0700
Date:   Fri, 27 Mar 2020 09:08:00 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 01/10] iommu/ioasid: Introduce system-wide capacity
Message-ID: <20200327090800.64949170@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED264@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED264@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 08:07:20 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 26, 2020 1:55 AM
> > 
> > IOASID is a limited system-wide resource that can be allocated at
> > runtime. This limitation can be enumerated during boot. For
> > example, on x86 platforms, PCI Process Address Space ID (PASID)
> > allocation uses IOASID service. The number of supported PASID bits
> > are enumerated by extended capability register as defined in the
> > VT-d spec.
> > 
> > This patch adds a helper to set the system capacity, it expected to
> > be set during boot prior to any allocation request.
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
> 
> From all the texts in this patch, looks ioasid_set_capacity might be
> a better name?
> 
That was my initial choice as well :), but it may get confused with
ioasid_set.

I will rephrase the text to avoid 'set'.

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
> > ioasid, void *data)
> >  	return -ENOTSUPP;
> >  }
> > 
> > +static inline void ioasid_install_capacity(ioasid_t total)
> > +{
> > +}
> >  #endif /* CONFIG_IOASID */
> >  #endif /* __LINUX_IOASID_H */
> > --
> > 2.7.4  
> 

[Jacob Pan]

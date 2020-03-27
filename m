Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D37C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCDA2076B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgC0X2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:28:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:6383 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgC0X2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:28:15 -0400
IronPort-SDR: 20NqEPHO2xi1IVnDkVWeQh9U4qYAzHyOd5fWOxy3W8lrgg+tduhVcsSKf6OQvs3KPmygR0XTOP
 PaRu07RvbKdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 16:25:12 -0700
IronPort-SDR: q5U/8cOHnQLIs+eR3NNw74xmIUCV5cB6hNSTBtRZzvQWm6/JqNeOkA885f2wXsikKW9vvrws6f
 39DoKFsTdsSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="394528485"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2020 16:25:12 -0700
Date:   Fri, 27 Mar 2020 16:30:57 -0700
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
Subject: Re: [PATCH 09/10] iommu/ioasid: Support ioasid_set quota adjustment
Message-ID: <20200327163057.75a0e154@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED605@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED605@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 10:09:04 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 26, 2020 1:56 AM
> > 
> > IOASID set is allocated with an initial quota, at runtime there may
> > be needs to balance IOASID resources among different VMs/sets.
> >   
> 
> I may overlook previous patches but I didn't see any place setting the
> initial quota...
> 
Initial quota is in place when the ioasid_set is allocated.

> > This patch adds a new API to adjust per set quota.  
> 
> since this is purely an internal kernel API, implies that the
> publisher (e.g. VFIO) is responsible for exposing its own uAPI to set
> the quota?
> 
yes, VFIO will do the adjustment. I think Alex suggested module
parameters.

> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 44
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/ioasid.h |  6 ++++++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 27dce2cb5af2..5ac28862a1db 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -578,6 +578,50 @@ void ioasid_free_set(int sid, bool destroy_set)
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_free_set);
> > 
> > +/**
> > + * ioasid_adjust_set - Adjust the quota of an IOASID set
> > + * @quota:	Quota allowed in this set
> > + * @sid:	IOASID set ID to be assigned
> > + *
> > + * Return 0 on success. If the new quota is smaller than the
> > number of
> > + * IOASIDs already allocated, -EINVAL will be returned. No change
> > will be
> > + * made to the existing quota.
> > + */
> > +int ioasid_adjust_set(int sid, int quota)
> > +{
> > +	struct ioasid_set_data *sdata;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&ioasid_allocator_lock);
> > +	sdata = xa_load(&ioasid_sets, sid);
> > +	if (!sdata || sdata->nr_ioasids > quota) {
> > +		pr_err("Failed to adjust IOASID set %d quota %d\n",
> > +			sid, quota);
> > +		ret = -EINVAL;
> > +		goto done_unlock;
> > +	}
> > +
> > +	if (quota >= ioasid_capacity_avail) {
> > +		ret = -ENOSPC;
> > +		goto done_unlock;
> > +	}
> > +
> > +	/* Return the delta back to system pool */
> > +	ioasid_capacity_avail += sdata->size - quota;
> > +
> > +	/*
> > +	 * May have a policy to prevent giving all available
> > IOASIDs
> > +	 * to one set. But we don't enforce here, it should be in
> > the
> > +	 * upper layers.
> > +	 */
> > +	sdata->size = quota;
> > +
> > +done_unlock:
> > +	mutex_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_adjust_set);
> > 
> >  /**
> >   * ioasid_find - Find IOASID data
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 32d032913828..6e7de6fb91bf 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -73,6 +73,7 @@ int ioasid_alloc_set(struct ioasid_set *token,
> > ioasid_t quota, int *sid);
> >  void ioasid_free_set(int sid, bool destroy_set);
> >  int ioasid_find_sid(ioasid_t ioasid);
> >  int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
> > +int ioasid_adjust_set(int sid, int quota);
> > 
> >  #else /* !CONFIG_IOASID */
> >  static inline ioasid_t ioasid_alloc(int sid, ioasid_t min,
> > @@ -136,5 +137,10 @@ static inline int ioasid_alloc_system_set(int
> > quota) return -ENOTSUPP;
> >  }
> > 
> > +static inline int ioasid_adjust_set(int sid, int quota)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> >  #endif /* CONFIG_IOASID */
> >  #endif /* __LINUX_IOASID_H */
> > --
> > 2.7.4  
> 

[Jacob Pan]

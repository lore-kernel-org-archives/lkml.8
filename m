Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F8C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C952073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgC0Rfx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:35:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:23144 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0Rfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:35:52 -0400
IronPort-SDR: nUhUAZUaKA9ZuW5cQrCfJvSausyHyGOHKzXd2/Wy9Czply00qmXjks55YCyG4+i1NppafCTvXC
 lFjtaOrCVVXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 10:35:50 -0700
IronPort-SDR: G1+E2MM7bSXS1L6Wid1qI0Neuj5RPe+LUAXEdkl+9jGxORKdCwJqE6WCO8CEo3Ye+d4zzZ7XWL
 5H9THaXnDyKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="239161309"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2020 10:35:49 -0700
Date:   Fri, 27 Mar 2020 10:41:34 -0700
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
Subject: Re: [PATCH 06/10] iommu/ioasid: Convert to set aware allocations
Message-ID: <20200327104134.5cf18a5d@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED552@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED552@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 09:54:11 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 26, 2020 1:55 AM
> > 
> > The current ioasid_alloc function takes a token/ioasid_set then
> > record it on the IOASID being allocated. There is no alloc/free on
> > the ioasid_set.
> > 
> > With the IOASID set APIs, callers must allocate an ioasid_set before
> > allocate IOASIDs within the set. Quota and other ioasid_set level
> > activities can then be enforced.
> > 
> > This patch converts existing API to the new ioasid_set model.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 10 +++---
> >  drivers/iommu/intel-svm.c   | 10 +++---
> >  drivers/iommu/ioasid.c      | 78
> > +++++++++++++++++++++++++++++++++------- -----
> >  include/linux/ioasid.h      | 11 +++----
> >  4 files changed, 72 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index af7a1ef7b31e..c571cc8d9e57
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -3323,11 +3323,11 @@ static void intel_ioasid_free(ioasid_t
> > ioasid, void *data)
> >  	if (!iommu)
> >  		return;
> >  	/*
> > -	 * Sanity check the ioasid owner is done at upper layer,
> > e.g. VFIO
> > -	 * We can only free the PASID when all the devices are
> > unbound.
> > +	 * In the guest, all IOASIDs belong to the system_ioasid
> > set.
> > +	 * Sanity check against the system set.  
> 
> below code has nothing to deal with guest, then why putting the
> comment specifically for guest?
> 
intel_ioasid_alloc/free() is the custom IOASID allocator only
registered when running in the guest.

The custom allocator calls virtual command. Since we don't support
nested guest, all IOASIDs belong to the system ioasid_set.

> >  	 */
> > -	if (ioasid_find(NULL, ioasid, NULL)) {
> > -		pr_alert("Cannot free active IOASID %d\n", ioasid);
> > +	if (IS_ERR(ioasid_find(system_ioasid_sid, ioasid, NULL))) {
> > +		pr_err("Cannot free IOASID %d, not in system
> > set\n", ioasid); return;
> >  	}
> >  	vcmd_free_pasid(iommu, ioasid);
> > @@ -5541,7 +5541,7 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain,
> >  		int pasid;
> > 
> >  		/* No private data needed for the default pasid */
> > -		pasid = ioasid_alloc(NULL, PASID_MIN,
> > +		pasid = ioasid_alloc(system_ioasid_sid, PASID_MIN,
> >  				     pci_max_pasids(to_pci_dev(dev))
> > - 1, NULL);
> >  		if (pasid == INVALID_IOASID) {
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 1991587fd3fd..f511855d187b 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -268,7 +268,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> > *domain,
> >  	}
> > 
> >  	mutex_lock(&pasid_mutex);
> > -	svm = ioasid_find(NULL, data->hpasid, NULL);
> > +	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
> >  	if (IS_ERR(svm)) {
> >  		ret = PTR_ERR(svm);
> >  		goto out;
> > @@ -401,7 +401,7 @@ int intel_svm_unbind_gpasid(struct device *dev,
> > int pasid)
> >  		return -EINVAL;
> > 
> >  	mutex_lock(&pasid_mutex);
> > -	svm = ioasid_find(NULL, pasid, NULL);
> > +	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
> >  	if (!svm) {
> >  		ret = -EINVAL;
> >  		goto out;
> > @@ -559,7 +559,7 @@ static int intel_svm_bind_mm(struct device
> > *dev, int flags, struct svm_dev_ops *
> >  			pasid_max = intel_pasid_max_id;
> > 
> >  		/* Do not use PASID 0, reserved for RID to PASID */
> > -		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> > +		svm->pasid = ioasid_alloc(system_ioasid_sid,
> > PASID_MIN, pasid_max - 1, svm);
> >  		if (svm->pasid == INVALID_IOASID) {
> >  			kfree(svm);
> > @@ -642,7 +642,7 @@ int intel_svm_unbind_mm(struct device *dev, int
> > pasid)
> >  	if (!iommu)
> >  		goto out;
> > 
> > -	svm = ioasid_find(NULL, pasid, NULL);
> > +	svm = ioasid_find(system_ioasid_sid, pasid, NULL);
> >  	if (!svm)
> >  		goto out;
> > 
> > @@ -778,7 +778,7 @@ static irqreturn_t prq_event_thread(int irq,
> > void *d)
> > 
> >  		if (!svm || svm->pasid != req->pasid) {
> >  			rcu_read_lock();
> > -			svm = ioasid_find(NULL, req->pasid, NULL);
> > +			svm = ioasid_find(INVALID_IOASID_SET,
> > req->pasid, NULL);  
> 
> is there a criteria when INVALID_IOASID_SET should be used?
> 
Two use cases for INVALID_IOASID_SET:
1. a hint to ioasid_find to do global search, ignore set ownership check
2. cannot find a set ID for a given ioasid_find_sid()

You brought up a good point, I missed the second use case.


> >  			/* It *can't* go away, because the driver
> > is not permitted
> >  			 * to unbind the mm while any page faults
> > are outstanding.
> >  			 * So we only need RCU to protect the
> > internal idr code. */
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 9135af171a7c..f89a595f6978 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -31,7 +31,7 @@ struct ioasid_set_data {
> > 
> >  struct ioasid_data {
> >  	ioasid_t id;
> > -	struct ioasid_set *set;
> > +	struct ioasid_set_data *sdata;
> >  	void *private;
> >  	struct rcu_head rcu;
> >  };
> > @@ -334,7 +334,7 @@ EXPORT_SYMBOL_GPL(ioasid_attach_data);
> > 
> >  /**
> >   * ioasid_alloc - Allocate an IOASID
> > - * @set: the IOASID set
> > + * @sid: the IOASID set ID
> >   * @min: the minimum ID (inclusive)
> >   * @max: the maximum ID (inclusive)
> >   * @private: data private to the caller
> > @@ -344,18 +344,30 @@ EXPORT_SYMBOL_GPL(ioasid_attach_data);
> >   *
> >   * Return: the allocated ID on success, or %INVALID_IOASID on
> > failure. */
> > -ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> > ioasid_t max,
> > -		      void *private)
> > +ioasid_t ioasid_alloc(int sid, ioasid_t min, ioasid_t max, void
> > *private) {
> > +	struct ioasid_set_data *sdata;
> >  	struct ioasid_data *data;
> >  	void *adata;
> >  	ioasid_t id;
> > 
> > -	data = kzalloc(sizeof(*data), GFP_ATOMIC);
> > +	/* Check if the IOASID set has been allocated and
> > initialized */
> > +	sdata = xa_load(&ioasid_sets, sid);  
> 
> ok, this change answers my previous question in last patch. 😊
> 
I guess you meant the NULL set question?

> > +	if (!sdata) {
> > +		pr_err("Invalid IOASID set %d to allocate from\n",
> > sid);
> > +		return INVALID_IOASID;
> > +	}
> > +
> > +	if (sdata->size <= sdata->nr_ioasids) {
> > +		pr_err("IOASID set %d out of quota\n", sid);
> > +		return INVALID_IOASID;
> > +	}
> > +
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> >  		return INVALID_IOASID;
> > 
> > -	data->set = set;
> > +	data->sdata = sdata;
> >  	data->private = private;
> > 
> >  	/*
> > @@ -379,6 +391,9 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max,
> >  	}
> >  	data->id = id;
> > 
> > +	/* Store IOASID in the per set data */
> > +	xa_store(&sdata->xa, id, data, GFP_KERNEL);
> > +	sdata->nr_ioasids++;
> >  	spin_unlock(&ioasid_allocator_lock);
> >  	return id;
> >  exit_free:
> > @@ -388,19 +403,15 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max,
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_alloc);
> > 
> > -/**
> > - * ioasid_free - Free an IOASID
> > - * @ioasid: the ID to remove
> > - */
> > -void ioasid_free(ioasid_t ioasid)
> > +static void ioasid_free_locked(ioasid_t ioasid)
> >  {
> >  	struct ioasid_data *ioasid_data;
> > +	struct ioasid_set_data *sdata;
> > 
> > -	spin_lock(&ioasid_allocator_lock);
> >  	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> >  	if (!ioasid_data) {
> >  		pr_err("Trying to free unknown IOASID %u\n",
> > ioasid);
> > -		goto exit_unlock;
> > +		return;
> >  	}
> > 
> >  	active_allocator->ops->free(ioasid,
> > active_allocator->ops->pdata); @@ -410,7 +421,27 @@ void
> > ioasid_free(ioasid_t ioasid) kfree_rcu(ioasid_data, rcu);
> >  	}
> > 
> > -exit_unlock:
> > +	sdata = xa_load(&ioasid_sets, ioasid_data->sdata->sid);
> > +	if (!sdata) {
> > +		pr_err("No set %d for IOASID %d\n",
> > ioasid_data->sdata->sid,
> > +		       ioasid);
> > +		return;
> > +	}
> > +	xa_erase(&sdata->xa, ioasid);
> > +	sdata->nr_ioasids--;
> > +}
> > +
> > +/**
> > + * ioasid_free - Free an IOASID and notify users who registered a
> > notifier
> > + *               on the IOASID set.
> > + *               IOASID can be re-allocated upon return
> > + *
> > + * @ioasid: the ID to remove
> > + */
> > +void ioasid_free(ioasid_t ioasid)
> > +{
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_free_locked(ioasid);
> >  	spin_unlock(&ioasid_allocator_lock);
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_free);
> > @@ -499,8 +530,12 @@ void ioasid_free_set(int sid, bool destroy_set)
> >  		goto done_destroy;
> >  	}
> > 
> > -	/* Just a place holder for now */
> >  	xa_for_each(&sdata->xa, index, entry) {
> > +		/*
> > +		 * Free from system-wide IOASID pool, all
> > subscribers gets
> > +		 * notified and do cleanup.
> > +		 */  
> 
> this comment might be added too early...
Yes, I should move it to notifier patch.

> 
> > +		ioasid_free_locked(index);
> >  		/* Free from per sub-set pool */
> >  		xa_erase(&sdata->xa, index);
> >  	}
> > @@ -508,7 +543,6 @@ void ioasid_free_set(int sid, bool destroy_set)
> >  done_destroy:
> >  	if (destroy_set) {
> >  		xa_erase(&ioasid_sets, sid);
> > -
> >  		/* Return the quota back to system pool */
> >  		ioasid_capacity_avail += sdata->size;
> >  		kfree_rcu(sdata, rcu);
> > @@ -522,7 +556,7 @@ EXPORT_SYMBOL_GPL(ioasid_free_set);
> > 
> >  /**
> >   * ioasid_find - Find IOASID data
> > - * @set: the IOASID set
> > + * @sid: the IOASID set ID
> >   * @ioasid: the IOASID to find
> >   * @getter: function to call on the found object
> >   *
> > @@ -532,10 +566,12 @@ EXPORT_SYMBOL_GPL(ioasid_free_set);
> >   *
> >   * If the IOASID exists, return the private pointer passed to
> > ioasid_alloc.
> >   * Private data can be NULL if not set. Return an error if the
> > IOASID is not
> > - * found, or if @set is not NULL and the IOASID does not belong to
> > the set.
> > + * found.
> > + *
> > + * If sid is INVALID_IOASID_SET, it will skip set ownership
> > checking. Otherwise,
> > + * error is returned even if the IOASID is found but does not
> > belong the set. */
> > -void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> > -		  bool (*getter)(void *))
> > +void *ioasid_find(int sid, ioasid_t ioasid, bool (*getter)(void *))
> >  {
> >  	void *priv;
> >  	struct ioasid_data *ioasid_data;
> > @@ -548,7 +584,7 @@ void *ioasid_find(struct ioasid_set *set,
> > ioasid_t ioasid,
> >  		priv = ERR_PTR(-ENOENT);
> >  		goto unlock;
> >  	}
> > -	if (set && ioasid_data->set != set) {
> > +	if (sid != INVALID_IOASID_SET &&
> > ioasid_data->sdata->sid != sid) { /* data found but does not belong
> > to the set */ priv = ERR_PTR(-EACCES);
> >  		goto unlock;
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 097b1cc043a3..e19c0ad93bd7 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/errno.h>
> > 
> >  #define INVALID_IOASID ((ioasid_t)-1)
> > +#define INVALID_IOASID_SET (-1)
> >  typedef unsigned int ioasid_t;
> >  typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max,
> > void *data); typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void
> > *data); @@ -35,11 +36,10 @@ extern int system_ioasid_sid;
> >  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> > 
> >  #if IS_ENABLED(CONFIG_IOASID)
> > -ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> > ioasid_t max, +ioasid_t ioasid_alloc(int sid, ioasid_t min,
> > ioasid_t max, void *private);
> >  void ioasid_free(ioasid_t ioasid);
> > -void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> > -		  bool (*getter)(void *));
> > +void *ioasid_find(int sid, ioasid_t ioasid, bool (*getter)(void
> > *)); int ioasid_register_allocator(struct ioasid_allocator_ops
> > *allocator); void ioasid_unregister_allocator(struct
> > ioasid_allocator_ops *allocator); int ioasid_attach_data(ioasid_t
> > ioasid, void *data); @@ -49,7 +49,7 @@ int ioasid_alloc_set(struct
> > ioasid_set *token, ioasid_t quota, int *sid);
> >  void ioasid_free_set(int sid, bool destroy_set);
> >  int ioasid_find_sid(ioasid_t ioasid);
> >  #else /* !CONFIG_IOASID */
> > -static inline ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, +static inline ioasid_t ioasid_alloc(int sid,
> > ioasid_t min, ioasid_t max, void *private)
> >  {
> >  	return INVALID_IOASID;
> > @@ -68,8 +68,7 @@ static inline void ioasid_free_set(int sid, bool
> > destroy_set)
> >  {
> >  }
> > 
> > -static inline void *ioasid_find(struct ioasid_set *set, ioasid_t
> > ioasid,
> > -				bool (*getter)(void *))
> > +static inline void *ioasid_find(int sid, ioasid_t ioasid, bool
> > (*getter)(void *)) {
> >  	return NULL;
> >  }
> > --
> > 2.7.4  
> 

[Jacob Pan]

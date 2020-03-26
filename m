Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A15AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031402073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCZVYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:24:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:2419 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCZVYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:24:32 -0400
IronPort-SDR: 9WZn5CttkvMo9YOD0hEOwEtE2S+9aW1IEIz8m2cWs/Yf/0aqiC73lNZvKBw1kZI9x0R/dCtx2K
 GdBU5CySH3qw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 14:24:31 -0700
IronPort-SDR: wc9UwXoSnG/BzyZPRf+0x0UiJg8aTVejRNYf6g+wrvQT73cXaqG5EVMCESiY7glOFvlmDYXFa+
 DG/h+3fmW6rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="266003097"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2020 14:24:31 -0700
Date:   Thu, 26 Mar 2020 14:30:15 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH 03/10] iommu/ioasid: Introduce per set allocation APIs
Message-ID: <20200326143015.5d5f8652@jacob-builder>
In-Reply-To: <8abd6586-e110-1487-034b-c59e4275cae9@linux.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <8abd6586-e110-1487-034b-c59e4275cae9@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thu, 26 Mar 2020 10:12:36 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> On 2020/3/26 1:55, Jacob Pan wrote:
> > IOASID set defines a group of IDs that share the same token. The
> > ioasid_set concept helps to do permission checking among users as
> > in the current code.
> > 
> > With guest SVA usage, each VM has its own IOASID set. More
> > functionalities are needed:
> > 1. Enforce quota, each guest may be assigned limited quota such
> > that one guest cannot abuse all the system resource.
> > 2. Stores IOASID mapping between guest and host IOASIDs
> > 3. Per set operations, e.g. free the entire set
> > 
> > For each ioasid_set token, a unique set ID is assigned. This makes
> > reference of the set and data lookup much easier to implement.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/ioasid.c | 147
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/ioasid.h |  13 +++++ 2 files changed, 160
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 4026e52855b9..27ee57f7079b 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -10,6 +10,25 @@
> >   #include <linux/spinlock.h>
> >   #include <linux/xarray.h>
> >   
> > +static DEFINE_XARRAY_ALLOC(ioasid_sets);
> > +/**
> > + * struct ioasid_set_data - Meta data about ioasid_set
> > + *
> > + * @token:	Unique to identify an IOASID set
> > + * @xa:		XArray to store subset ID and IOASID mapping
> > + * @size:	Max number of IOASIDs can be allocated within the
> > set
> > + * @nr_ioasids	Number of IOASIDs allocated in the set
> > + * @sid		ID of the set
> > + */
> > +struct ioasid_set_data {
> > +	struct ioasid_set *token;
> > +	struct xarray xa;
> > +	int size;
> > +	int nr_ioasids;
> > +	int sid;
> > +	struct rcu_head rcu;
> > +};
> > +
> >   struct ioasid_data {
> >   	ioasid_t id;
> >   	struct ioasid_set *set;
> > @@ -388,6 +407,111 @@ void ioasid_free(ioasid_t ioasid)
> >   EXPORT_SYMBOL_GPL(ioasid_free);
> >   
> >   /**
> > + * ioasid_alloc_set - Allocate a set of IOASIDs
> > + * @token:	Unique token of the IOASID set
> > + * @quota:	Quota allowed in this set
> > + * @sid:	IOASID set ID to be assigned
> > + *
> > + * Return 0 upon success. Token will be stored internally for
> > lookup,
> > + * IOASID allocation within the set and other per set operations
> > will use
> > + * the @sid assigned.
> > + *
> > + */
> > +int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> > *sid) +{
> > +	struct ioasid_set_data *sdata;
> > +	ioasid_t id;
> > +	int ret = 0;
> > +
> > +	if (quota > ioasid_capacity_avail) {
> > +		pr_warn("Out of IOASID capacity! ask %d, avail
> > %d\n",
> > +			quota, ioasid_capacity_avail);
> > +		return -ENOSPC;
> > +	}
> > +
> > +	sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
> > +	if (!sdata)
> > +		return -ENOMEM;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +
> > +	ret = xa_alloc(&ioasid_sets, &id, sdata,
> > +		       XA_LIMIT(0, ioasid_capacity_avail - quota),
> > +		       GFP_KERNEL);
> > +	if (ret) {
> > +		kfree(sdata);
> > +		goto error;
> > +	}
> > +
> > +	sdata->token = token;
> > +	sdata->size = quota;
> > +	sdata->sid = id;
> > +
> > +	/*
> > +	 * Set Xarray is used to store IDs within the set, get
> > ready for
> > +	 * sub-set ID and system-wide IOASID allocation results.
> > +	 */
> > +	xa_init_flags(&sdata->xa, XA_FLAGS_ALLOC);
> > +
> > +	ioasid_capacity_avail -= quota;
> > +	*sid = id;
> > +
> > +error:
> > +	spin_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_alloc_set);
> > +
> > +/**
> > + * ioasid_free_set - Free all IOASIDs within the set
> > + *
> > + * @sid:		The IOASID set ID to be freed
> > + * @destroy_set:	Whether to keep the set for further
> > allocation.
> > + *			If true, the set will be destroyed.
> > + *
> > + * All IOASIDs allocated within the set will be freed upon return.
> > + */
> > +void ioasid_free_set(int sid, bool destroy_set)
> > +{
> > +	struct ioasid_set_data *sdata;
> > +	struct ioasid_data *entry;
> > +	unsigned long index;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	sdata = xa_load(&ioasid_sets, sid);
> > +	if (!sdata) {
> > +		pr_err("No IOASID set found to free %d\n", sid);
> > +		goto done_unlock;
> > +	}
> > +
> > +	if (xa_empty(&sdata->xa)) {
> > +		pr_warn("No IOASIDs in the set %d\n", sdata->sid);
> > +		goto done_destroy;
> > +	}
> > +
> > +	/* Just a place holder for now */
> > +	xa_for_each(&sdata->xa, index, entry) {
> > +		/* Free from per sub-set pool */
> > +		xa_erase(&sdata->xa, index);
> > +	}
> > +
> > +done_destroy:
> > +	if (destroy_set) {
> > +		xa_erase(&ioasid_sets, sid);
> > +
> > +		/* Return the quota back to system pool */
> > +		ioasid_capacity_avail += sdata->size;
> > +		kfree_rcu(sdata, rcu);
> > +	}
> > +
> > +done_unlock:
> > +	spin_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_free_set);
> > +
> > +
> > +/**
> >    * ioasid_find - Find IOASID data
> >    * @set: the IOASID set
> >    * @ioasid: the IOASID to find
> > @@ -431,6 +555,29 @@ void *ioasid_find(struct ioasid_set *set,
> > ioasid_t ioasid, }
> >   EXPORT_SYMBOL_GPL(ioasid_find);
> >   
> > +/**
> > + * ioasid_find_sid - Retrieve IOASID set ID from an ioasid
> > + *                   Caller must hold a reference to the set.
> > + *
> > + * @ioasid: IOASID associated with the set
> > + *
> > + * Return IOASID set ID or error
> > + */
> > +int ioasid_find_sid(ioasid_t ioasid)
> > +{
> > +	struct ioasid_data *ioasid_data;
> > +	int ret = 0;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > +	ret = (ioasid_data) ? ioasid_data->sdata->sid : -ENOENT;
> > +
> > +	spin_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_find_sid);
> > +
> >   MODULE_AUTHOR("Jean-Philippe Brucker
> > <jean-philippe.brucker@arm.com>"); MODULE_AUTHOR("Jacob Pan
> > <jacob.jun.pan@linux.intel.com>"); MODULE_DESCRIPTION("IO Address
> > Space ID (IOASID) allocator"); diff --git a/include/linux/ioasid.h
> > b/include/linux/ioasid.h index 9711fa0dc357..be158e03c034 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -41,6 +41,9 @@ int ioasid_register_allocator(struct
> > ioasid_allocator_ops *allocator); void
> > ioasid_unregister_allocator(struct ioasid_allocator_ops
> > *allocator); int ioasid_set_data(ioasid_t ioasid, void *data); void
> > ioasid_install_capacity(ioasid_t total); +int
> > ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> > *sid); +void ioasid_free_set(int sid, bool destroy_set); +int
> > ioasid_find_sid(ioasid_t ioasid); #else /* !CONFIG_IOASID */
> >   static inline ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, void *private)
> > @@ -52,6 +55,15 @@ static inline void ioasid_free(ioasid_t ioasid)
> >   {
> >   }
> >   
> > +static inline int ioasid_alloc_set(struct ioasid_set *token,
> > ioasid_t quota, int *sid) +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static inline void ioasid_free_set(int sid, bool destroy_set)
> > +{
> > +}
> > +  
> 
> static inline int ioasid_find_sid(ioasid_t ioasid)
> {
> 	return INVALID_IOASID;
> }
> 
Good catch, will add to the next version.

> Best regards,
> baolu
> 
> >   static inline void *ioasid_find(struct ioasid_set *set, ioasid_t
> > ioasid, bool (*getter)(void *))
> >   {
> > @@ -75,5 +87,6 @@ static inline int ioasid_set_data(ioasid_t
> > ioasid, void *data) static inline void
> > ioasid_install_capacity(ioasid_t total) {
> >   }
> > +
> >   #endif /* CONFIG_IOASID */
> >   #endif /* __LINUX_IOASID_H */
> >   

[Jacob Pan]

Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C26AC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162B020737
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgC0SbD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:31:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:14268 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0SbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:31:02 -0400
IronPort-SDR: NcOK4AoRI+9KLqU5N9tYTOH5vq3Pf6pqg+DmeRLwDkY512yTq67/9HXYgX1vavH8wOJd5AbGlP
 gfhEkyd5uwvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 11:31:01 -0700
IronPort-SDR: WFnSUQR4gQVK9TH+1Rlvn8U3eWAGraqcWgAyVnCL5Ln7bacVW33WmMlEfMZKMk2BO5uppqNNGT
 yUF8Cy7TrUwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="247970408"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2020 11:31:01 -0700
Date:   Fri, 27 Mar 2020 11:36:46 -0700
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
Subject: Re: [PATCH 08/10] iommu/ioasid: Introduce notifier APIs
Message-ID: <20200327113646.3d87f17f@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED5D6@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED5D6@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 10:03:26 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 26, 2020 1:55 AM
> > 
> > IOASID users fit into the publisher-subscriber pattern, a system
> > wide blocking notifier chain can be used to inform subscribers of
> > state changes. Notifier mechanism also abstracts publisher from
> > knowing the private context each subcriber may have.
> > 
> > This patch adds APIs and a global notifier chain, a further
> > optimization might be per set notifier for ioasid_set aware users.
> > 
> > Usage example:
> > KVM register notifier block such that it can keep its guest-host
> > PASID translation table in sync with any IOASID updates.
> > 
> > VFIO publish IOASID change by performing alloc/free, bind/unbind
> > operations.
> > 
> > IOMMU driver gets notified when IOASID is freed by VFIO or core mm
> > code such that PASID context can be cleaned up.  
> 
> above example looks mixed. You have KVM registers the notifier but
> finally having IOMMU driver to get notified... 😊
> 
Right, felt like a tale of two subscribers got mixed. I meant to list a
few use cases with publisher and subscriber roles separate.
I will change that to "Usage examples", and explicit state each role.

> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 61
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/ioasid.h | 40 +++++++++++++++++++++++++++++++++
> >  2 files changed, 101 insertions(+)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 8612fe6477dc..27dce2cb5af2 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -11,6 +11,22 @@
> >  #include <linux/xarray.h>
> > 
> >  static DEFINE_XARRAY_ALLOC(ioasid_sets);
> > +/*
> > + * An IOASID could have multiple consumers. When a status change
> > occurs,
> > + * this notifier chain is used to keep them in sync. Each consumer
> > of the
> > + * IOASID service must register notifier block early to ensure no
> > events
> > + * are missed.
> > + *
> > + * This is a publisher-subscriber pattern where publisher can
> > change the
> > + * state of each IOASID, e.g. alloc/free, bind IOASID to a device
> > and mm.
> > + * On the other hand, subscribers gets notified for the state
> > change and
> > + * keep local states in sync.
> > + *
> > + * Currently, the notifier is global. A further optimization could
> > be per
> > + * IOASID set notifier chain.
> > + */
> > +static BLOCKING_NOTIFIER_HEAD(ioasid_chain);
> > +
> >  /**
> >   * struct ioasid_set_data - Meta data about ioasid_set
> >   *
> > @@ -408,6 +424,7 @@ static void ioasid_free_locked(ioasid_t ioasid)
> >  {
> >  	struct ioasid_data *ioasid_data;
> >  	struct ioasid_set_data *sdata;
> > +	struct ioasid_nb_args args;
> > 
> >  	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> >  	if (!ioasid_data) {
> > @@ -415,6 +432,13 @@ static void ioasid_free_locked(ioasid_t ioasid)
> >  		return;
> >  	}
> > 
> > +	args.id = ioasid;
> > +	args.sid = ioasid_data->sdata->sid;
> > +	args.pdata = ioasid_data->private;
> > +	args.set_token = ioasid_data->sdata->token;
> > +
> > +	/* Notify all users that this IOASID is being freed */
> > +	blocking_notifier_call_chain(&ioasid_chain, IOASID_FREE,
> > &args); active_allocator->ops->free(ioasid,
> > active_allocator->ops->pdata); /* Custom allocator needs additional
> > steps to free the xa element */ if (active_allocator->flags &
> > IOASID_ALLOCATOR_CUSTOM) { @@ -624,6 +648,43 @@ int
> > ioasid_find_sid(ioasid_t ioasid) }
> >  EXPORT_SYMBOL_GPL(ioasid_find_sid);
> > 
> > +int ioasid_add_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&ioasid_chain, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_add_notifier);
> > +
> > +void ioasid_remove_notifier(struct notifier_block *nb)
> > +{
> > +	blocking_notifier_chain_unregister(&ioasid_chain, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_remove_notifier);  
> 
> register/unregister
> 
Sounds good.

> > +
> > +int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd)  
> 
> add a comment on when this function should be used?
> 
Sure, how about:
/**
 * ioasid_notify - Send notification on a given IOASID for status change.
 *                 Used by publishers when the status change may affect
 *                 subscriber's internal state.
 *
 * @ioasid:	The IOASID to which the notification will send
 * @cmd:	The notification event
 *
 */

> > +{
> > +	struct ioasid_data *ioasid_data;
> > +	struct ioasid_nb_args args;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&ioasid_allocator_lock);
> > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > +	if (!ioasid_data) {
> > +		pr_err("Trying to free unknown IOASID %u\n",
> > ioasid);  
> 
> why is it fixed to 'free'?
> 
Good catch, it shouldn;t be just free. It was a relic of early test
case.

> > +		mutex_unlock(&ioasid_allocator_lock);
> > +		return -EINVAL;
> > +	}
> > +
> > +	args.id = ioasid;
> > +	args.sid = ioasid_data->sdata->sid;
> > +	args.pdata = ioasid_data->private;  
> 
> why no token info as did in ioasid_free?
> 
Good catch, should include token as well. It is better to include all
the data such that subscribers don't have to do any lookup which may
cause race.

> > +
> > +	ret = blocking_notifier_call_chain(&ioasid_chain, cmd,
> > &args);
> > +	mutex_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_notify);
> > +
> >  MODULE_AUTHOR("Jean-Philippe Brucker <jean-  
> > philippe.brucker@arm.com>");  
> >  MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
> >  MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index e19c0ad93bd7..32d032913828 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -4,6 +4,7 @@
> > 
> >  #include <linux/types.h>
> >  #include <linux/errno.h>
> > +#include <linux/notifier.h>
> > 
> >  #define INVALID_IOASID ((ioasid_t)-1)
> >  #define INVALID_IOASID_SET (-1)
> > @@ -30,6 +31,27 @@ struct ioasid_allocator_ops {
> >  	void *pdata;
> >  };
> > 
> > +/* Notification data when IOASID status changed */
> > +enum ioasid_notify_val {
> > +	IOASID_ALLOC = 1,
> > +	IOASID_FREE,
> > +	IOASID_BIND,
> > +	IOASID_UNBIND,
> > +};  
> 
> Curious why IOASID_ALLOC is not notified aumatically within
> ioasid_alloc similar to ioasid_free, while leaving to the publisher?
> BIND/UNBIND is a publisher thing but a bit strange to see ALLOC/FREE
> with different policy here.
> 
I don't see a use case for ALLOC notification yet. Any user does the
allocation would the be the first and only one know about this IOASID.

Unless we have set level notifier, which may be interested in a new
IOASID being allocated within the set.

> > +
> > +/**
> > + * struct ioasid_nb_args - Argument provided by IOASID core when
> > notifier
> > + * is called.
> > + * @id:		the IOASID being notified
> > + * @sid:	the IOASID set @id belongs to
> > + * @pdata:	the private data attached to the IOASID
> > + */
> > +struct ioasid_nb_args {
> > +	ioasid_t id;
> > +	int sid;
> > +	struct ioasid_set *set_token;
> > +	void *pdata;
> > +};
> >  /* Shared IOASID set for reserved for host system use */
> >  extern int system_ioasid_sid;
> > 
> > @@ -43,11 +65,15 @@ void *ioasid_find(int sid, ioasid_t ioasid, bool
> > (*getter)(void *));
> >  int ioasid_register_allocator(struct ioasid_allocator_ops
> > *allocator); void ioasid_unregister_allocator(struct
> > ioasid_allocator_ops *allocator); int ioasid_attach_data(ioasid_t
> > ioasid, void *data); +int ioasid_add_notifier(struct notifier_block
> > *nb); +void ioasid_remove_notifier(struct notifier_block *nb);
> >  void ioasid_install_capacity(ioasid_t total);
> >  int ioasid_alloc_system_set(int quota);
> >  int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> > *sid); void ioasid_free_set(int sid, bool destroy_set);
> >  int ioasid_find_sid(ioasid_t ioasid);
> > +int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
> > +
> >  #else /* !CONFIG_IOASID */
> >  static inline ioasid_t ioasid_alloc(int sid, ioasid_t min,
> >  				    ioasid_t max, void *private)
> > @@ -73,6 +99,20 @@ static inline void *ioasid_find(int sid,
> > ioasid_t ioasid, bool (*getter)(void *)
> >  	return NULL;
> >  }
> > 
> > +static inline int ioasid_add_notifier(struct notifier_block *nb)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static inline void ioasid_remove_notifier(struct notifier_block
> > *nb) +{
> > +}
> > +
> > +int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> >  static inline int ioasid_register_allocator(struct
> > ioasid_allocator_ops *allocator)
> >  {
> >  	return -ENOTSUPP;
> > --
> > 2.7.4  
> 

[Jacob Pan]

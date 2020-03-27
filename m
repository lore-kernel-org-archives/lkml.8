Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC21AC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D26120717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgC0XlR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:41:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:3082 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgC0XlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:41:17 -0400
IronPort-SDR: pyk7PQTRAfD7snv26tplXpu+1mEK5kivfDWNhceigNtVnNsh7GG+zrDWjSwC2PaADTGuUC1xB+
 JB91B/utX4rw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 16:41:16 -0700
IronPort-SDR: ngS9OYOSHXIg2UyGp+aPeAjjJ6RVJ0VCTVig+06C2N9UpvTsLgX7gKcvmibvN+FFsWBSDHlhhj
 0073ApSfWqEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="251299291"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2020 16:41:14 -0700
Date:   Fri, 27 Mar 2020 16:47:01 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 10/10] iommu/vt-d: Register PASID notifier for status
 change
Message-ID: <20200327164701.5cfee1c3@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED65A@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED65A@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 10:22:57 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan
> > Sent: Thursday, March 26, 2020 1:56 AM
> > 
> > In bare metal SVA, IOMMU driver ensures that IOASID free call
> > always comes after IOASID unbind operation.
> > 
> > However, for guest SVA the unbind and free call come from user space
> > via VFIO, which could be out of order. This patch registers a
> > notifier block in case IOASID free() comes before unbind such that
> > VT-d driver can take action to clean up PASID context and data.  
> 
> clearly the patch includes more than above usage. It also handles the
> bind usage to notify KVM for setting PASID translation table.
> 
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-svm.c   | 68
> > ++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/intel-iommu.h |  1 +
> >  2 files changed, 68 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index f511855d187b..779dd2c6f9e1 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -23,6 +23,7 @@
> >  #include "intel-pasid.h"
> > 
> >  static irqreturn_t prq_event_thread(int irq, void *d);
> > +static DEFINE_MUTEX(pasid_mutex);
> > 
> >  #define PRQ_ORDER 0
> > 
> > @@ -92,6 +93,65 @@ static inline bool intel_svm_capable(struct
> > intel_iommu *iommu)
> >  	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
> >  }
> > 
> > +#define pasid_lock_held() lock_is_held(&pasid_mutex.dep_map)
> > +
> > +static int pasid_status_change(struct notifier_block *nb,
> > +				unsigned long code, void *data)
> > +{
> > +	struct ioasid_nb_args *args = (struct ioasid_nb_args
> > *)data;
> > +	struct intel_svm_dev *sdev;
> > +	struct intel_svm *svm;
> > +	int ret = NOTIFY_DONE;
> > +
> > +	if (code == IOASID_FREE) {
> > +		/*
> > +		 * Unbind all devices associated with this PASID
> > which is
> > +		 * being freed by other users such as VFIO.
> > +		 */
> > +		mutex_lock(&pasid_mutex);
> > +		svm = ioasid_find(INVALID_IOASID_SET, args->id,
> > NULL);
> > +		if (!svm || !svm->iommu)
> > +			goto done_unlock;  
> 
> should we treat !svm->iommu as an error condition? if not, do you have
> an example when it may occur in normal situation?
> 
Right, should be an error. Initially, unbind could retrieve iommu from
struct device, but with notifier we have to set svm->iommu all the time.

> > +
> > +		if (IS_ERR(svm)) {
> > +			ret = NOTIFY_BAD;
> > +			goto done_unlock;
> > +		}  
> 
> svm->iommu should be referenced after IS_ERR check
> 
Good point, will move up.
> > +
> > +		list_for_each_entry_rcu(sdev, &svm->devs, list,
> > pasid_lock_held()) {
> > +			/* Does not poison forward pointer */
> > +			list_del_rcu(&sdev->list);
> > +			intel_pasid_tear_down_entry(svm->iommu,
> > sdev-  
> > >dev,  
> > +						    svm->pasid);
> > +			kfree_rcu(sdev, rcu);
> > +
> > +			/*
> > +			 * Free before unbind only happens with
> > guest usaged
> > +			 * host PASIDs. IOASID free will detach
> > private data
> > +			 * and free the IOASID entry.  
> 
> "guest usaged host PASIDs"?
> 
I mean VM used PASID, will change to
/*
 * Free before unbind only happens with PASIDs used
 * by VM. IOASID free will detach private data
 * and free the IOASID entry.
 */

> > +			 */
> > +			if (list_empty(&svm->devs))
> > +				kfree(svm);
> > +		}
> > +		mutex_unlock(&pasid_mutex);
> > +
> > +		return NOTIFY_OK;
> > +	}
> > +
> > +done_unlock:
> > +	mutex_unlock(&pasid_mutex);
> > +	return ret;
> > +}
> > +
> > +static struct notifier_block pasid_nb = {
> > +		.notifier_call = pasid_status_change,
> > +};
> > +
> > +void intel_svm_add_pasid_notifier(void)
> > +{
> > +	ioasid_add_notifier(&pasid_nb);
> > +}
> > +
> >  void intel_svm_check(struct intel_iommu *iommu)
> >  {
> >  	if (!pasid_supported(iommu))
> > @@ -219,7 +279,6 @@ static const struct mmu_notifier_ops
> > intel_mmuops = {
> >  	.invalidate_range = intel_invalidate_range,
> >  };
> > 
> > -static DEFINE_MUTEX(pasid_mutex);
> >  static LIST_HEAD(global_svm_list);
> > 
> >  #define for_each_svm_dev(sdev, svm, d)			\
> > @@ -319,6 +378,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> > *domain,
> >  			svm->gpasid = data->gpasid;
> >  			svm->flags |= SVM_FLAG_GUEST_PASID;
> >  		}
> > +		svm->iommu = iommu;  
> 
> ah, it's interesting to see we have a field defined before but never
> used. 😊
> 
The unbind call can retrieve iommu from struct device.

> > 
> >  		ioasid_attach_data(data->hpasid, svm);
> >  		INIT_LIST_HEAD_RCU(&svm->devs);
> > @@ -383,6 +443,11 @@ int intel_svm_bind_gpasid(struct iommu_domain
> > *domain,
> >  	}
> >  	svm->flags |= SVM_FLAG_GUEST_MODE;
> > 
> > +	/*
> > +	 * Notify KVM new host-guest PASID bind is ready. KVM will
> > set up
> > +	 * PASID translation table to support guest ENQCMD.
> > +	 */  
> 
> should take it as an example instead of the only possible usage.
> 
True, we don;t know who is getting notified.

> > +	ioasid_notify(data->hpasid, IOASID_BIND);
> >  	init_rcu_head(&sdev->rcu);
> >  	list_add_rcu(&sdev->list, &svm->devs);
> >   out:
> > @@ -440,6 +505,7 @@ int intel_svm_unbind_gpasid(struct device *dev,
> > int pasid)
> >  				 * used by another.
> >  				 */
> >  				ioasid_attach_data(pasid, NULL);
> > +				ioasid_notify(pasid,
> > IOASID_UNBIND); kfree(svm);
> >  			}
> >  		}
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index f8504a980981..64799067ea58
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -708,6 +708,7 @@ extern struct iommu_sva *
> >  intel_svm_bind(struct device *dev, struct mm_struct *mm, void
> > *drvdata); extern void intel_svm_unbind(struct iommu_sva *handle);
> >  extern int intel_svm_get_pasid(struct iommu_sva *handle);
> > +extern void intel_svm_add_pasid_notifier(void);
> > 
> >  struct svm_dev_ops;
> > 
> > --
> > 2.7.4
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu  

[Jacob Pan]

Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BCAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDC720757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgC3Upx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:45:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:61027 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgC3Upx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:45:53 -0400
IronPort-SDR: bwhpq1A39tpo6VpSziwdqka55j5bc2oPsnGWLD2Dv2JzUU/z5rteb1EJlGXn5krDO2AUP1YHY/
 bsZOXMFdEMDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 13:45:52 -0700
IronPort-SDR: h8FwM6J04xs0Pbn8vAKXfGWjw5gX4unHWJuDraH/4XAAIGQbaVSec9qmi+KMuypjSNC3CJz1dI
 vA0DKgJNn96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="252006079"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 30 Mar 2020 13:45:51 -0700
Date:   Mon, 30 Mar 2020 13:51:38 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Yi L <yi.l.liu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 06/11] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200330135138.556ea8a4@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7F77B4@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7F77B4@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Mar 2020 08:02:01 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, March 21, 2020 7:28 AM
> > 
> > When supporting guest SVA with emulated IOMMU, the guest PASID
> > table is shadowed in VMM. Updates to guest vIOMMU PASID table
> > will result in PASID cache flush which will be passed down to
> > the host as bind guest PASID calls.
> > 
> > For the SL page tables, it will be harvested from device's
> > default domain (request w/o PASID), or aux domain in case of
> > mediated device.
> > 
> >     .-------------.  .---------------------------.
> >     |   vIOMMU    |  | Guest process CR3, FL only|
> >     |             |  '---------------------------'
> >     .----------------/
> >     | PASID Entry |--- PASID cache flush -
> >     '-------------'                       |
> >     |             |                       V
> >     |             |                CR3 in GPA
> >     '-------------'
> > Guest
> > ------| Shadow |--------------------------|--------
> >       v        v                          v
> > Host
> >     .-------------.  .----------------------.
> >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> >     |             |  '----------------------'
> >     .----------------/  |
> >     | PASID Entry |     V (Nested xlate)
> >     '----------------\.------------------------------.
> >     |             |   |SL for GPA-HPA, default domain|
> >     |             |   '------------------------------'
> >     '-------------'
> > Where:
> >  - FL = First level/stage one page tables
> >  - SL = Second level/stage two page tables
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c |   4 +
> >  drivers/iommu/intel-svm.c   | 224
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/intel-iommu.h |   8 +-
> >  include/linux/intel-svm.h   |  17 ++++
> >  4 files changed, 252 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index e599b2537b1c..b1477cd423dd
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -6203,6 +6203,10 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
> >  	.is_attach_deferred	=
> > intel_iommu_is_attach_deferred, .pgsize_bitmap		=
> > INTEL_IOMMU_PGSIZES, +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> > +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> > +#endif
> >  };
> > 
> >  static void quirk_iommu_igfx(struct pci_dev *dev)
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index d7f2a5358900..47c0deb5ae56 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -226,6 +226,230 @@ static LIST_HEAD(global_svm_list);
> >  	list_for_each_entry((sdev), &(svm)->devs, list)	\
> >  		if ((d) != (sdev)->dev) {} else
> > 
> > +int intel_svm_bind_gpasid(struct iommu_domain *domain,
> > +			struct device *dev,
> > +			struct iommu_gpasid_bind_data *data)
> > +{
> > +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct dmar_domain *ddomain;  
> 
> what about the full name e.g. dmar_domain? though a bit longer
> but clearer than ddomain.
> 
Sure, I don't have preference.

> > +	struct intel_svm_dev *sdev;
> > +	struct intel_svm *svm;
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(!iommu) || !data)
> > +		return -EINVAL;
> > +
> > +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> > +	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +		return -EINVAL;
> > +
> > +	if (dev_is_pci(dev)) {
> > +		/* VT-d supports devices with full 20 bit PASIDs
> > only */
> > +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> > +			return -EINVAL;
> > +	} else {
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	/*
> > +	 * We only check host PASID range, we have no knowledge to
> > check
> > +	 * guest PASID range nor do we use the guest PASID.
> > +	 */
> > +	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
> > +		return -EINVAL;
> > +
> > +	ddomain = to_dmar_domain(domain);
> > +
> > +	/* Sanity check paging mode support match between host and
> > guest */
> > +	if (data->addr_width == ADDR_WIDTH_5LEVEL &&
> > +	    !cap_5lp_support(iommu->cap)) {
> > +		pr_err("Cannot support 5 level paging requested by
> > guest!\n");
> > +		return -EINVAL;
> > +	}  
> 
> -ENOTSUPP?
I was thinking from this API p.o.v, the input is invalid. Since both
cap and addr_width are derived from input arguments.

> 
> > +
> > +	mutex_lock(&pasid_mutex);
> > +	svm = ioasid_find(NULL, data->hpasid, NULL);
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> > +		goto out;
> > +	}
> > +
> > +	if (svm) {
> > +		/*
> > +		 * If we found svm for the PASID, there must be at
> > +		 * least one device bond, otherwise svm should be
> > freed.
> > +		 */
> > +		if (WARN_ON(list_empty(&svm->devs))) {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		if (svm->mm == get_task_mm(current) &&
> > +		    data->hpasid == svm->pasid &&
> > +		    data->gpasid == svm->gpasid) {
> > +			pr_warn("Cannot bind the same guest-host
> > PASID for the same process\n");  
> 
> Sorry I didn’t get the rationale here. Isn't this branch is for
> binding the same PASID to multiple devices? In that case definitely
> it is binding the same guest-host PASID for the same process.
> otherwise if hpasid is different then you'll hit a different
> intel_svm, while if gpasid is different how you can use one intel_svm
> to hold multiple gpasids?
> 
> I feel the error condition should be the opposite. and suppose
> SVM_FLAG_ GUEST_PASID should be verified before checking gpasid.
> 
You are right, actually we don't need the check here. The
scenario for multiple devices bind to the same PASID is checked in
for_each_svm_dev()
I will remove this code.

> > +			mmput(svm->mm);
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +		mmput(current->mm);
> > +
> > +		for_each_svm_dev(sdev, svm, dev) {
> > +			/* In case of multiple sub-devices of the
> > same pdev
> > +			 * assigned, we should allow multiple bind
> > calls with
> > +			 * the same PASID and pdev.  
> 
> Does sub-device mean mdev? I didn't find such notation in current
> iommu directory.
> 
yes it is intended for mdev.
> and to make it clearer, "In case of multiple mdevs of the same pdev
> assigned to the same guest process".
> 
I am avoiding mdev on purpose since it is not a concept in iommu
driver. sub-device is more generic.

> > +			 */
> > +			sdev->users++;
> > +			goto out;
> > +		}
> > +	} else {
> > +		/* We come here when PASID has never been bond to a
> > device. */
> > +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> > +		if (!svm) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +		/* REVISIT: upper layer/VFIO can track host
> > process that bind the PASID.
> > +		 * ioasid_set = mm might be sufficient for vfio to
> > check pasid VMM
> > +		 * ownership.
> > +		 */  
> 
> Above message is unclear about what should be revisited. Does it
> describe the current implementation or the expected revision in the
> future? 
> 
What I meant was if VFIO can check PASID-mm ownership by itself, then
we don;t have to store svm->mm here. Will drop the line below.
I will add this comment to clarify.

> > +		svm->mm = get_task_mm(current);
> > +		svm->pasid = data->hpasid;
> > +		if (data->flags & IOMMU_SVA_GPASID_VAL) {
> > +			svm->gpasid = data->gpasid;
> > +			svm->flags |= SVM_FLAG_GUEST_PASID;
> > +		}
> > +		ioasid_set_data(data->hpasid, svm);
> > +		INIT_LIST_HEAD_RCU(&svm->devs);
> > +		mmput(svm->mm);
> > +	}
> > +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> > +	if (!sdev) {
> > +		if (list_empty(&svm->devs)) {
> > +			ioasid_set_data(data->hpasid, NULL);
> > +			kfree(svm);
> > +		}
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	sdev->dev = dev;
> > +	sdev->users = 1;
> > +
> > +	/* Set up device context entry for PASID if not enabled
> > already */
> > +	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable PASID
> > capability\n");
> > +		kfree(sdev);
> > +		/*
> > +		 * If this this a new PASID that never bond to a
> > device, then
> > +		 * the device list must be empty which indicates
> > struct svm
> > +		 * was allocated in this function.
> > +		 */  
> 
> the comment better move to the 1st occurrence when sdev allocation
> fails. or even better put it in out label...
> 
Sounds good.

> > +		if (list_empty(&svm->devs)) {
> > +			ioasid_set_data(data->hpasid, NULL);
> > +			kfree(svm);
> > +		}
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * For guest bind, we need to set up PASID table entry as
> > follows:
> > +	 * - FLPM matches guest paging mode
> > +	 * - turn on nested mode
> > +	 * - SL guest address width matching
> > +	 */  
> 
> looks above just explains the internal detail of
> intel_pasid_setup_nested, which is not necessary to be here.
> 
Right, will remove the comments.

> > +	ret = intel_pasid_setup_nested(iommu,
> > +				       dev,
> > +				       (pgd_t *)data->gpgd,
> > +				       data->hpasid,
> > +				       &data->vtd,
> > +				       ddomain,
> > +				       data->addr_width);  
> 
> It's worthy of an explanation here that setup_nested is required for
> every device (even when they are sharing same intel_svm) because
> we allocate pasid table per device. Otherwise I made a mistake to
> think that only the 1st device bound to a new hpasid requires this
> step. 😊
> 
Good suggestion, I will add the comments as:
/*
 * PASID table is per device for better security. Therefore, for
 * each bind of a new device even with an existing PASID, we need to
 * call the nested mode setup function here.
 */

> > +	if (ret) {
> > +		dev_err(dev, "Failed to set up PASID %llu in
> > nested mode, Err %d\n",
> > +			data->hpasid, ret);
> > +		/*
> > +		 * PASID entry should be in cleared state if
> > nested mode
> > +		 * set up failed. So we only need to clear IOASID
> > tracking
> > +		 * data such that free call will succeed.
> > +		 */
> > +		kfree(sdev);
> > +		if (list_empty(&svm->devs)) {
> > +			ioasid_set_data(data->hpasid, NULL);
> > +			kfree(svm);
> > +		}
> > +		goto out;
> > +	}
> > +	svm->flags |= SVM_FLAG_GUEST_MODE;
> > +
> > +	init_rcu_head(&sdev->rcu);
> > +	list_add_rcu(&sdev->list, &svm->devs);
> > + out:
> > +	mutex_unlock(&pasid_mutex);
> > +	return ret;
> > +}
> > +
> > +int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> > +{
> > +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct intel_svm_dev *sdev;
> > +	struct intel_svm *svm;
> > +	int ret = -EINVAL;
> > +
> > +	if (WARN_ON(!iommu))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&pasid_mutex);
> > +	svm = ioasid_find(NULL, pasid, NULL);
> > +	if (!svm) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> > +		goto out;
> > +	}
> > +
> > +	for_each_svm_dev(sdev, svm, dev) {
> > +		ret = 0;
> > +		sdev->users--;
> > +		if (!sdev->users) {
> > +			list_del_rcu(&sdev->list);
> > +			intel_pasid_tear_down_entry(iommu, dev,
> > svm-  
> > >pasid);  
> > +			/* TODO: Drain in flight PRQ for the PASID
> > since it
> > +			 * may get reused soon, we don't want to
> > +			 * confuse with its previous life.
> > +			 * intel_svm_drain_prq(dev, pasid);
> > +			 */
> > +			kfree_rcu(sdev, rcu);
> > +
> > +			if (list_empty(&svm->devs)) {
> > +				/*
> > +				 * We do not free PASID here until
> > explicit call
> > +				 * from VFIO to free. The PASID
> > life cycle
> > +				 * management is largely tied to
> > VFIO management
> > +				 * of assigned device life cycles.
> > In case of
> > +				 * guest exit without a explicit
> > free PASID call,
> > +				 * the responsibility lies in VFIO
> > layer to free
> > +				 * the PASIDs allocated for the
> > guest.
> > +				 * For security reasons, VFIO has
> > to track the
> > +				 * PASID ownership per guest
> > anyway to ensure
> > +				 * that PASID allocated by one
> > guest cannot be
> > +				 * used by another.  
> 
> As commented in other patches, VFIO is only one example user of this
> API... 
> 
Right, how about this:
	/*
	 * We do not free the IOASID here in that
	 * IOMMU driver did not allocate it.
	 * Unlike native SVM, IOASID for guest use was
	 * allocated prior to the bind call.
	 * In any case, if the free call comes before
	 * the unbind, IOMMU driver will get notified
	 * and perform cleanup.
	 */

> > +				 */
> > +				ioasid_set_data(pasid, NULL);
> > +				kfree(svm);
> > +			}
> > +		}
> > +		break;
> > +	}  
> 
> what about no dev match? an -EINVAL is also required then.
> 
Yes, ret is initialized as -EINVAL

> > +out:
> > +	mutex_unlock(&pasid_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> > struct svm_dev_ops *ops)
> >  {
> >  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index eda1d6687144..85b05120940e
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -681,7 +681,9 @@ struct dmar_domain *find_domain(struct device
> > *dev);
> >  extern void intel_svm_check(struct intel_iommu *iommu);
> >  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
> >  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> > -
> > +extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
> > +		struct device *dev, struct iommu_gpasid_bind_data
> > *data); +extern int intel_svm_unbind_gpasid(struct device *dev, int
> > pasid); struct svm_dev_ops;
> > 
> >  struct intel_svm_dev {
> > @@ -698,9 +700,13 @@ struct intel_svm_dev {
> >  struct intel_svm {
> >  	struct mmu_notifier notifier;
> >  	struct mm_struct *mm;
> > +
> >  	struct intel_iommu *iommu;
> >  	int flags;
> >  	int pasid;
> > +	int gpasid; /* Guest PASID in case of vSVA bind with
> > non-identity host
> > +		     * to guest PASID mapping.
> > +		     */  
> 
> we don't need to highlight identity or non-identity thing, since
> either way shares the same infrastructure here and it is not the
> knowledge that the kernel driver should assume
> 
Sorry, I don't get your point.

What I meant was that this field "gpasid" is only used for non-identity
case. For identity case, we don't have SVM_FLAG_GUEST_PASID.

> >  	struct list_head devs;
> >  	struct list_head list;
> >  };
> > diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> > index d7c403d0dd27..c19690937540 100644
> > --- a/include/linux/intel-svm.h
> > +++ b/include/linux/intel-svm.h
> > @@ -44,6 +44,23 @@ struct svm_dev_ops {
> >   * do such IOTLB flushes automatically.
> >   */
> >  #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
> > +/*
> > + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind
> > to a device.
> > + * In this case the mm_struct is in the guest kernel or userspace,
> > its life
> > + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this
> > API provides
> > + * means to bind/unbind guest CR3 with PASIDs allocated for a
> > device.
> > + */
> > +#define SVM_FLAG_GUEST_MODE	(1<<2)
> > +/*
> > + * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own
> > PASID space,
> > + * which requires guest and host PASID translation at both
> > directions. We keep
> > + * track of guest PASID in order to provide lookup service to
> > device drivers.
> > + * One such example is a physical function (PF) driver that
> > supports mediated
> > + * device (mdev) assignment. Guest programming of mdev
> > configuration space can
> > + * only be done with guest PASID, therefore PF driver needs to
> > find the matching
> > + * host PASID to program the real hardware.
> > + */
> > +#define SVM_FLAG_GUEST_PASID	(1<<3)
> > 
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> > 
> > --
> > 2.7.4  
> 

[Jacob Pan]

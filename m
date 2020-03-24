Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A22076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgCXPsP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:48:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:32877 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgCXPsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:48:14 -0400
IronPort-SDR: 5glEzXVEhApY7SvY6mam7u2pdjppm58XCXGPw67gO1KC9HIQtXVC+bf0yiYHl4U3EgfTDGdihx
 aXjdO4mHxAgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:48:13 -0700
IronPort-SDR: /3TviJPiPGIiX5u5mtsR+VfG5tYCSytp+4NuPBMOSeO8k3LBM5E9P6El05mhD1Ec6Ap3qorrZv
 Mnn6EgS1k81A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="393322380"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2020 08:48:13 -0700
Date:   Tue, 24 Mar 2020 08:53:56 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
Message-ID: <20200324085356.64f6a904@jacob-builder>
In-Reply-To: <20200320092955.GA1702630@myrica>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200320092955.GA1702630@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 10:29:55 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Hi Jacob,
> 
> I think this step is really useful and the patch looks good overall,
> thanks for doing this. Some commments inline
> 
> On Mon, Feb 24, 2020 at 03:26:37PM -0800, Jacob Pan wrote:
> > This patch is an initial step to replace Intel SVM code with the
> > following IOMMU SVA ops:
> > intel_svm_bind_mm() => iommu_sva_bind_device()
> > intel_svm_unbind_mm() => iommu_sva_unbind_device()
> > intel_svm_is_pasid_valid() => iommu_sva_get_pasid()
> > 
> > The features below will continue to work but are not included in
> > this patch in that they are handled mostly within the IOMMU
> > subsystem.
> > - IO page fault
> > - mmu notifier
> > 
> > Consolidation of the above will come after merging generic IOMMU sva
> > code[1]. There should not be any changes needed for SVA users such
> > as accelerator device drivers during this time.
> > 
> > [1] http://jpbrucker.net/sva/
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c |   3 ++
> >  drivers/iommu/intel-svm.c   | 123
> > ++++++++++++++++++++++++--------------------
> > include/linux/intel-iommu.h |   7 +++ include/linux/intel-svm.h
> > |  85 ------------------------------ 4 files changed, 78
> > insertions(+), 140 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 5eca6e10d2a4..ccfa5adfd06d
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -6475,6 +6475,9 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.cache_invalidate	= intel_iommu_sva_invalidate,
> >  	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> >  	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> > +	.sva_bind		= intel_svm_bind,
> > +	.sva_unbind		= intel_svm_unbind,
> > +	.sva_get_pasid		= intel_svm_get_pasid,
> >  #endif
> >  };
> >  
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 1d7a95372f8c..35d949513728 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -516,13 +516,14 @@ int intel_svm_unbind_gpasid(struct device
> > *dev, int pasid) return ret;
> >  }
> >  
> > -int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> > struct svm_dev_ops *ops) +/* Caller must hold pasid_mutex, mm
> > reference */ +static int intel_svm_bind_mm(struct device *dev, int
> > flags, struct svm_dev_ops *ops,
> > +		      struct mm_struct *mm, struct intel_svm_dev
> > **sd) {
> >  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> >  	struct device_domain_info *info;
> >  	struct intel_svm_dev *sdev;
> >  	struct intel_svm *svm = NULL;
> > -	struct mm_struct *mm = NULL;
> >  	int pasid_max;
> >  	int ret;
> >  
> > @@ -539,16 +540,15 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ } else
> >  		pasid_max = 1 << 20;
> >  
> > +	/* Bind supervisor PASID shuld have mm = NULL */  
> 
> should
> 
> >  	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
> > -		if (!ecap_srs(iommu->ecap))
> > +		if (!ecap_srs(iommu->ecap) || mm) {
> > +			pr_err("Supervisor PASID with user
> > provided mm.\n"); return -EINVAL;
> > -	} else if (pasid) {
> > -		mm = get_task_mm(current);
> > -		BUG_ON(!mm);
> > +		}
> >  	}
> >  
> > -	mutex_lock(&pasid_mutex);
> > -	if (pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
> > +	if (!(flags & SVM_FLAG_PRIVATE_PASID)) {
> >  		struct intel_svm *t;
> >  
> >  		list_for_each_entry(t, &global_svm_list, list) {
> > @@ -586,9 +586,7 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ sdev->dev = dev;
> >  
> >  	ret = intel_iommu_enable_pasid(iommu, dev);
> > -	if (ret || !pasid) {
> > -		/* If they don't actually want to assign a PASID,
> > this is
> > -		 * just an enabling check/preparation. */
> > +	if (ret) {
> >  		kfree(sdev);
> >  		goto out;
> >  	}
> > @@ -688,18 +686,17 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ }
> >  	}
> >  	list_add_rcu(&sdev->list, &svm->devs);
> > -
> > - success:
> > -	*pasid = svm->pasid;
> > +success:
> > +	sdev->pasid = svm->pasid;
> > +	sdev->sva.dev = dev;
> > +	if (sd)
> > +		*sd = sdev;  
> 
> One thing that might be missing: calling bind() multiple times with
> the same (dev, mm) pair should take references to the svm struct, so
> device drivers can call unbind() on it that many times.
> 
> >  	ret = 0;
> >   out:
> > -	mutex_unlock(&pasid_mutex);
> > -	if (mm)
> > -		mmput(mm);
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(intel_svm_bind_mm);
> >  
> > +/* Caller must hold pasid_mutex */
> >  int intel_svm_unbind_mm(struct device *dev, int pasid)
> >  {
> >  	struct intel_svm_dev *sdev;
> > @@ -707,7 +704,6 @@ int intel_svm_unbind_mm(struct device *dev, int
> > pasid) struct intel_svm *svm;
> >  	int ret = -EINVAL;
> >  
> > -	mutex_lock(&pasid_mutex);
> >  	iommu = intel_svm_device_to_iommu(dev);
> >  	if (!iommu)
> >  		goto out;
> > @@ -753,45 +749,9 @@ int intel_svm_unbind_mm(struct device *dev,
> > int pasid) break;
> >  	}
> >   out:
> > -	mutex_unlock(&pasid_mutex);
> >  
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(intel_svm_unbind_mm);
> > -
> > -int intel_svm_is_pasid_valid(struct device *dev, int pasid)
> > -{
> > -	struct intel_iommu *iommu;
> > -	struct intel_svm *svm;
> > -	int ret = -EINVAL;
> > -
> > -	mutex_lock(&pasid_mutex);
> > -	iommu = intel_svm_device_to_iommu(dev);
> > -	if (!iommu)
> > -		goto out;
> > -
> > -	svm = ioasid_find(NULL, pasid, NULL);
> > -	if (!svm)
> > -		goto out;
> > -
> > -	if (IS_ERR(svm)) {
> > -		ret = PTR_ERR(svm);
> > -		goto out;
> > -	}
> > -	/* init_mm is used in this case */
> > -	if (!svm->mm)
> > -		ret = 1;
> > -	else if (atomic_read(&svm->mm->mm_users) > 0)
> > -		ret = 1;
> > -	else
> > -		ret = 0;
> > -
> > - out:
> > -	mutex_unlock(&pasid_mutex);
> > -
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(intel_svm_is_pasid_valid);
> >  
> >  /* Page request queue descriptor */
> >  struct page_req_dsc {
> > @@ -984,3 +944,56 @@ static irqreturn_t prq_event_thread(int irq,
> > void *d) 
> >  	return IRQ_RETVAL(handled);
> >  }
> > +
> > +#define to_intel_svm_dev(handle) container_of(handle, struct
> > intel_svm_dev, sva) +struct iommu_sva *
> > +intel_svm_bind(struct device *dev, struct mm_struct *mm, void
> > *drvdata) +{
> > +	struct iommu_sva *sva = ERR_PTR(-EINVAL);
> > +	struct intel_svm_dev *sdev = NULL;
> > +	int flags = 0;
> > +	int ret;
> > +
> > +	/*
> > +	 * TODO: Consolidate with generic iommu-sva bind after it
> > is merged.
> > +	 * It will require shared SVM data structures, i.e.
> > combine io_mm
> > +	 * and intel_svm etc.
> > +	 */
> > +	if (drvdata)
> > +		flags = *(int *)drvdata;  
> 
> drvdata is more for storing device driver contexts that can be passed
> to iommu_sva_ops, but I get that this is temporary.
> 
> As usual I'm dreading supervisor mode making it into the common API.
> What are your plans regarding SUPERVISOR_MODE and PRIVATE_PASID
> flags?  The previous discussion on the subject [1] had me hoping that
> you could replace supervisor mode with normal mappings (auxiliary
> domains?) I'm less worried about PRIVATE_PASID, it would just add
> complexity into the API and iommu-sva implementation, but doesn't
> really have security implications.
> 
> [1]
> https://lore.kernel.org/linux-iommu/20190228220449.GA12682@araj-mobl1.jf.intel.com/
> 
> > +	mutex_lock(&pasid_mutex);
> > +	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
> > +	if (ret)
> > +		sva = ERR_PTR(ret);
> > +	else if (sdev)
> > +		sva = &sdev->sva;
> > +	else
> > +		WARN(!sdev, "SVM bind succeeded with no sdev!\n");
> > +
> > +	mutex_unlock(&pasid_mutex);
> > +
> > +	return sva;
> > +}
> > +
> > +void intel_svm_unbind(struct iommu_sva *sva)
> > +{
> > +	struct intel_svm_dev *sdev;
> > +
> > +	mutex_lock(&pasid_mutex);
> > +	sdev = to_intel_svm_dev(sva);
> > +	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
> > +	mutex_unlock(&pasid_mutex);
> > +}
> > +
> > +int intel_svm_get_pasid(struct iommu_sva *sva)
> > +{
> > +	struct intel_svm_dev *sdev;
> > +	int pasid;
> > +
> > +	mutex_lock(&pasid_mutex);
> > +	sdev = to_intel_svm_dev(sva);
> > +	pasid = sdev->pasid;
> > +	mutex_unlock(&pasid_mutex);
> > +
> > +	return pasid;
> > +}
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 37cfd35b7ccf..044493a11dce
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -702,6 +702,11 @@ extern int intel_svm_finish_prq(struct
> > intel_iommu *iommu); extern int intel_svm_bind_gpasid(struct
> > iommu_domain *domain, struct device *dev, struct
> > iommu_gpasid_bind_data *data); extern int
> > intel_svm_unbind_gpasid(struct device *dev, int pasid); +extern
> > struct iommu_sva * +intel_svm_bind(struct device *dev, struct
> > mm_struct *mm, void *drvdata); +extern void intel_svm_unbind(struct
> > iommu_sva *handle); +extern int intel_svm_get_pasid(struct
> > iommu_sva *handle); +
> >  struct svm_dev_ops;
> >  
> >  struct intel_svm_dev {
> > @@ -709,6 +714,8 @@ struct intel_svm_dev {
> >  	struct rcu_head rcu;
> >  	struct device *dev;
> >  	struct svm_dev_ops *ops;
> > +	struct iommu_sva sva;
> > +	int pasid;
> >  	int users;
> >  	u16 did;
> >  	u16 dev_iotlb:1;
> > diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> > index a2c189ad0b01..fb7e786d8877 100644
> > --- a/include/linux/intel-svm.h
> > +++ b/include/linux/intel-svm.h
> > @@ -62,89 +62,4 @@ struct svm_dev_ops {
> >   */
> >  #define SVM_FLAG_GUEST_PASID	(1<<3)
> >  
> > -#ifdef CONFIG_INTEL_IOMMU_SVM
> > -
> > -/**
> > - * intel_svm_bind_mm() - Bind the current process to a PASID
> > - * @dev:	Device to be granted access
> > - * @pasid:	Address for allocated PASID
> > - * @flags:	Flags. Later for requesting supervisor mode, etc.
> > - * @ops:	Callbacks to device driver
> > - *
> > - * This function attempts to enable PASID support for the given
> > device.
> > - * If the @pasid argument is non-%NULL, a PASID is allocated for
> > access
> > - * to the MM of the current process.
> > - *
> > - * By using a %NULL value for the @pasid argument, this function
> > can
> > - * be used to simply validate that PASID support is available for
> > the
> > - * given device — i.e. that it is behind an IOMMU which has the
> > - * requisite support, and is enabled.
> > - *
> > - * Page faults are handled transparently by the IOMMU code, and
> > there
> > - * should be no need for the device driver to be involved. If a
> > page
> > - * fault cannot be handled (i.e. is an invalid address rather than
> > - * just needs paging in), then the page request will be completed
> > by
> > - * the core IOMMU code with appropriate status, and the device
> > itself
> > - * can then report the resulting fault to its driver via whatever
> > - * mechanism is appropriate.
> > - *
> > - * Multiple calls from the same process may result in the same
> > PASID
> > - * being re-used. A reference count is kept.
> > - */
> > -extern int intel_svm_bind_mm(struct device *dev, int *pasid, int
> > flags,
> > -			     struct svm_dev_ops *ops);  
> 
> I notice svm_dev_ops isn't used anymore. Will you remove it entirely,
> or do you think we should move svm_dev_ops::fault_cb() to
> iommu_sva_ops?
> 
I don;t think fault_cb() is useful anymore since we have per device
fault reporting APIs. I will remove it. Thanks for the reminder.

> iommu_sva_ops::mm_exit() is also missing, but I plan to send a RFC to
> remove it shortly, so don't bother :)
Remove iommu_sva_ops? I will wait for the patch.

Thanks,

Jacob

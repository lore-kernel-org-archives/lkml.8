Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E4C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E4320409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVUyvy+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCTJaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:30:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34912 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:30:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so6574655wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JxG/QcU8BYh1je+IYf0dPYt0Kp0NCxYkM9Y1GUc0Yms=;
        b=IVUyvy+oaqFLf4CCcBfJFMeIWdhxwLR+dZsE5P+rqxX7FAzlc7MxJA9Ah7WGFnFmrr
         yQr8QWvg0MD/H36uIvZ2M4Jp7pllDWR6Rf8suagSZbg7l2DqB9F/KxO9/DccdCh6U1dR
         MrGItRw2DYbNXBN4OdeXb96fnYbyBvWM6D+2prc/vUA1LJ7SywW1vHQbE3fZlYl8TKIk
         iXOXMe79a96lnX1nIE1MYi/PGG3zR2+BIRLg8bDn9J6rWaVwm9CRfE6rH/FozeFyrjGu
         LmxAfxdaJvZ7bHnZSk1lJIUHlJvwtLa3VGAkhy49Vw/lmDCyL9bOPBZUxFOGcfq9MiAT
         yysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JxG/QcU8BYh1je+IYf0dPYt0Kp0NCxYkM9Y1GUc0Yms=;
        b=lJoCG4W9LYc6k/F69zlMCOsyx+xyDvnLd2CxgJUkTdD0oO0vCT8BcTloojmcXYJSGZ
         9b2LCyAfp3np1jQz+P1mk7iElEebA9+IZ1a01wJUjyv4cppTXLPdg36I/iCxUClKRC5/
         hQCbOC3SaeOHpHEG2zM7/B70U3oTjgLDA1Z8h3S6dP4cfFHSHIIgQrpjBbOeKE68cZYs
         W62KXTM/yUOMivIhOFO7gJCt3eHwVsZ1AlbQYrqaiclOKk4Hrc14CdKM56qblDML2iqp
         EvPP1iMTt9VbO4NJftNYyIRKKgs2+rHM9ogjQyISuMJqF2ImCxdAnt2q9l/YfJgxLEQy
         iV9Q==
X-Gm-Message-State: ANhLgQ0bVk9GU4E3SfBcwUiZSw7kKNmRe5nOxg8+2r/MxXv0F2oJk9/a
        qUORQg7+BrdnhmaHNViE2Nw2ig==
X-Google-Smtp-Source: ADFU+vtUPOB3bsVCa3WQtvlKdHBBkMWRTBUSeQ+dTyUQ18lahqWszXP6AOpoDapERGXA0/Fchav/5Q==
X-Received: by 2002:a5d:440a:: with SMTP id z10mr9905611wrq.177.1584696603428;
        Fri, 20 Mar 2020 02:30:03 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id k126sm7117254wme.4.2020.03.20.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 02:30:02 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:29:55 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
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
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
Message-ID: <20200320092955.GA1702630@myrica>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

I think this step is really useful and the patch looks good overall,
thanks for doing this. Some commments inline

On Mon, Feb 24, 2020 at 03:26:37PM -0800, Jacob Pan wrote:
> This patch is an initial step to replace Intel SVM code with the
> following IOMMU SVA ops:
> intel_svm_bind_mm() => iommu_sva_bind_device()
> intel_svm_unbind_mm() => iommu_sva_unbind_device()
> intel_svm_is_pasid_valid() => iommu_sva_get_pasid()
> 
> The features below will continue to work but are not included in this patch
> in that they are handled mostly within the IOMMU subsystem.
> - IO page fault
> - mmu notifier
> 
> Consolidation of the above will come after merging generic IOMMU sva
> code[1]. There should not be any changes needed for SVA users such as
> accelerator device drivers during this time.
> 
> [1] http://jpbrucker.net/sva/
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c |   3 ++
>  drivers/iommu/intel-svm.c   | 123 ++++++++++++++++++++++++--------------------
>  include/linux/intel-iommu.h |   7 +++
>  include/linux/intel-svm.h   |  85 ------------------------------
>  4 files changed, 78 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 5eca6e10d2a4..ccfa5adfd06d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6475,6 +6475,9 @@ const struct iommu_ops intel_iommu_ops = {
>  	.cache_invalidate	= intel_iommu_sva_invalidate,
>  	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>  	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> +	.sva_bind		= intel_svm_bind,
> +	.sva_unbind		= intel_svm_unbind,
> +	.sva_get_pasid		= intel_svm_get_pasid,
>  #endif
>  };
>  
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 1d7a95372f8c..35d949513728 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -516,13 +516,14 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>  	return ret;
>  }
>  
> -int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
> +/* Caller must hold pasid_mutex, mm reference */
> +static int intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
> +		      struct mm_struct *mm, struct intel_svm_dev **sd)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>  	struct device_domain_info *info;
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm = NULL;
> -	struct mm_struct *mm = NULL;
>  	int pasid_max;
>  	int ret;
>  
> @@ -539,16 +540,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  	} else
>  		pasid_max = 1 << 20;
>  
> +	/* Bind supervisor PASID shuld have mm = NULL */

should

>  	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
> -		if (!ecap_srs(iommu->ecap))
> +		if (!ecap_srs(iommu->ecap) || mm) {
> +			pr_err("Supervisor PASID with user provided mm.\n");
>  			return -EINVAL;
> -	} else if (pasid) {
> -		mm = get_task_mm(current);
> -		BUG_ON(!mm);
> +		}
>  	}
>  
> -	mutex_lock(&pasid_mutex);
> -	if (pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
> +	if (!(flags & SVM_FLAG_PRIVATE_PASID)) {
>  		struct intel_svm *t;
>  
>  		list_for_each_entry(t, &global_svm_list, list) {
> @@ -586,9 +586,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  	sdev->dev = dev;
>  
>  	ret = intel_iommu_enable_pasid(iommu, dev);
> -	if (ret || !pasid) {
> -		/* If they don't actually want to assign a PASID, this is
> -		 * just an enabling check/preparation. */
> +	if (ret) {
>  		kfree(sdev);
>  		goto out;
>  	}
> @@ -688,18 +686,17 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		}
>  	}
>  	list_add_rcu(&sdev->list, &svm->devs);
> -
> - success:
> -	*pasid = svm->pasid;
> +success:
> +	sdev->pasid = svm->pasid;
> +	sdev->sva.dev = dev;
> +	if (sd)
> +		*sd = sdev;

One thing that might be missing: calling bind() multiple times with the
same (dev, mm) pair should take references to the svm struct, so device
drivers can call unbind() on it that many times.

>  	ret = 0;
>   out:
> -	mutex_unlock(&pasid_mutex);
> -	if (mm)
> -		mmput(mm);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(intel_svm_bind_mm);
>  
> +/* Caller must hold pasid_mutex */
>  int intel_svm_unbind_mm(struct device *dev, int pasid)
>  {
>  	struct intel_svm_dev *sdev;
> @@ -707,7 +704,6 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  	struct intel_svm *svm;
>  	int ret = -EINVAL;
>  
> -	mutex_lock(&pasid_mutex);
>  	iommu = intel_svm_device_to_iommu(dev);
>  	if (!iommu)
>  		goto out;
> @@ -753,45 +749,9 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  		break;
>  	}
>   out:
> -	mutex_unlock(&pasid_mutex);
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(intel_svm_unbind_mm);
> -
> -int intel_svm_is_pasid_valid(struct device *dev, int pasid)
> -{
> -	struct intel_iommu *iommu;
> -	struct intel_svm *svm;
> -	int ret = -EINVAL;
> -
> -	mutex_lock(&pasid_mutex);
> -	iommu = intel_svm_device_to_iommu(dev);
> -	if (!iommu)
> -		goto out;
> -
> -	svm = ioasid_find(NULL, pasid, NULL);
> -	if (!svm)
> -		goto out;
> -
> -	if (IS_ERR(svm)) {
> -		ret = PTR_ERR(svm);
> -		goto out;
> -	}
> -	/* init_mm is used in this case */
> -	if (!svm->mm)
> -		ret = 1;
> -	else if (atomic_read(&svm->mm->mm_users) > 0)
> -		ret = 1;
> -	else
> -		ret = 0;
> -
> - out:
> -	mutex_unlock(&pasid_mutex);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(intel_svm_is_pasid_valid);
>  
>  /* Page request queue descriptor */
>  struct page_req_dsc {
> @@ -984,3 +944,56 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  
>  	return IRQ_RETVAL(handled);
>  }
> +
> +#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
> +struct iommu_sva *
> +intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> +{
> +	struct iommu_sva *sva = ERR_PTR(-EINVAL);
> +	struct intel_svm_dev *sdev = NULL;
> +	int flags = 0;
> +	int ret;
> +
> +	/*
> +	 * TODO: Consolidate with generic iommu-sva bind after it is merged.
> +	 * It will require shared SVM data structures, i.e. combine io_mm
> +	 * and intel_svm etc.
> +	 */
> +	if (drvdata)
> +		flags = *(int *)drvdata;

drvdata is more for storing device driver contexts that can be passed to
iommu_sva_ops, but I get that this is temporary.

As usual I'm dreading supervisor mode making it into the common API. What
are your plans regarding SUPERVISOR_MODE and PRIVATE_PASID flags?  The
previous discussion on the subject [1] had me hoping that you could
replace supervisor mode with normal mappings (auxiliary domains?)
I'm less worried about PRIVATE_PASID, it would just add complexity into
the API and iommu-sva implementation, but doesn't really have security
implications.

[1] https://lore.kernel.org/linux-iommu/20190228220449.GA12682@araj-mobl1.jf.intel.com/

> +	mutex_lock(&pasid_mutex);
> +	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
> +	if (ret)
> +		sva = ERR_PTR(ret);
> +	else if (sdev)
> +		sva = &sdev->sva;
> +	else
> +		WARN(!sdev, "SVM bind succeeded with no sdev!\n");
> +
> +	mutex_unlock(&pasid_mutex);
> +
> +	return sva;
> +}
> +
> +void intel_svm_unbind(struct iommu_sva *sva)
> +{
> +	struct intel_svm_dev *sdev;
> +
> +	mutex_lock(&pasid_mutex);
> +	sdev = to_intel_svm_dev(sva);
> +	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
> +	mutex_unlock(&pasid_mutex);
> +}
> +
> +int intel_svm_get_pasid(struct iommu_sva *sva)
> +{
> +	struct intel_svm_dev *sdev;
> +	int pasid;
> +
> +	mutex_lock(&pasid_mutex);
> +	sdev = to_intel_svm_dev(sva);
> +	pasid = sdev->pasid;
> +	mutex_unlock(&pasid_mutex);
> +
> +	return pasid;
> +}
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 37cfd35b7ccf..044493a11dce 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -702,6 +702,11 @@ extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>  extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
>  		struct device *dev, struct iommu_gpasid_bind_data *data);
>  extern int intel_svm_unbind_gpasid(struct device *dev, int pasid);
> +extern struct iommu_sva *
> +intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata);
> +extern void intel_svm_unbind(struct iommu_sva *handle);
> +extern int intel_svm_get_pasid(struct iommu_sva *handle);
> +
>  struct svm_dev_ops;
>  
>  struct intel_svm_dev {
> @@ -709,6 +714,8 @@ struct intel_svm_dev {
>  	struct rcu_head rcu;
>  	struct device *dev;
>  	struct svm_dev_ops *ops;
> +	struct iommu_sva sva;
> +	int pasid;
>  	int users;
>  	u16 did;
>  	u16 dev_iotlb:1;
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index a2c189ad0b01..fb7e786d8877 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -62,89 +62,4 @@ struct svm_dev_ops {
>   */
>  #define SVM_FLAG_GUEST_PASID	(1<<3)
>  
> -#ifdef CONFIG_INTEL_IOMMU_SVM
> -
> -/**
> - * intel_svm_bind_mm() - Bind the current process to a PASID
> - * @dev:	Device to be granted access
> - * @pasid:	Address for allocated PASID
> - * @flags:	Flags. Later for requesting supervisor mode, etc.
> - * @ops:	Callbacks to device driver
> - *
> - * This function attempts to enable PASID support for the given device.
> - * If the @pasid argument is non-%NULL, a PASID is allocated for access
> - * to the MM of the current process.
> - *
> - * By using a %NULL value for the @pasid argument, this function can
> - * be used to simply validate that PASID support is available for the
> - * given device — i.e. that it is behind an IOMMU which has the
> - * requisite support, and is enabled.
> - *
> - * Page faults are handled transparently by the IOMMU code, and there
> - * should be no need for the device driver to be involved. If a page
> - * fault cannot be handled (i.e. is an invalid address rather than
> - * just needs paging in), then the page request will be completed by
> - * the core IOMMU code with appropriate status, and the device itself
> - * can then report the resulting fault to its driver via whatever
> - * mechanism is appropriate.
> - *
> - * Multiple calls from the same process may result in the same PASID
> - * being re-used. A reference count is kept.
> - */
> -extern int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> -			     struct svm_dev_ops *ops);

I notice svm_dev_ops isn't used anymore. Will you remove it entirely, or
do you think we should move svm_dev_ops::fault_cb() to iommu_sva_ops?

iommu_sva_ops::mm_exit() is also missing, but I plan to send a RFC to
remove it shortly, so don't bother :)

Thanks,
Jean

> -
> -/**
> - * intel_svm_unbind_mm() - Unbind a specified PASID
> - * @dev:	Device for which PASID was allocated
> - * @pasid:	PASID value to be unbound
> - *
> - * This function allows a PASID to be retired when the device no
> - * longer requires access to the address space of a given process.
> - *
> - * If the use count for the PASID in question reaches zero, the
> - * PASID is revoked and may no longer be used by hardware.
> - *
> - * Device drivers are required to ensure that no access (including
> - * page requests) is currently outstanding for the PASID in question,
> - * before calling this function.
> - */
> -extern int intel_svm_unbind_mm(struct device *dev, int pasid);
> -
> -/**
> - * intel_svm_is_pasid_valid() - check if pasid is valid
> - * @dev:	Device for which PASID was allocated
> - * @pasid:	PASID value to be checked
> - *
> - * This function checks if the specified pasid is still valid. A
> - * valid pasid means the backing mm is still having a valid user.
> - * For kernel callers init_mm is always valid. for other mm, if mm->mm_users
> - * is non-zero, it is valid.
> - *
> - * returns -EINVAL if invalid pasid, 0 if pasid ref count is invalid
> - * 1 if pasid is valid.
> - */
> -extern int intel_svm_is_pasid_valid(struct device *dev, int pasid);
> -
> -#else /* CONFIG_INTEL_IOMMU_SVM */
> -
> -static inline int intel_svm_bind_mm(struct device *dev, int *pasid,
> -				    int flags, struct svm_dev_ops *ops)
> -{
> -	return -ENOSYS;
> -}
> -
> -static inline int intel_svm_unbind_mm(struct device *dev, int pasid)
> -{
> -	BUG();
> -}
> -
> -static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
> -{
> -	return -EINVAL;
> -}
> -#endif /* CONFIG_INTEL_IOMMU_SVM */
> -
> -#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0, NULL))
> -
>  #endif /* __INTEL_SVM_H__ */
> -- 
> 2.7.4
> 

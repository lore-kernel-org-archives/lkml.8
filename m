Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C82CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082F120738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiRUisSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHXS3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:29:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:29:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m20so8981568eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KU4zqL83rIya+dDobk/RnK3hyM/osaOo/rErdYHKbRI=;
        b=SiRUisSjAktTKtcthtgr7dvGj8q5J831Nlf9lV8tc2OcwR/PHxo9YY/46lqekd1GxV
         X50UhVjg2rE6paV/EFkTiKtx+Ol/FxpFEy/v0INMuWUXuESqVJ1sca7NTP+DlBjGR8uL
         CWbngNmyDMtIMc6QHp+VjUgRokMMn2gb1T0BM9VybnsjDLu/T7Tt/OihAdL9yI3CI7VJ
         mGrdGZJ8y/s+EVDc2iq64JQ3UDfGl7UGkvejbj2b8YGPmrIdyFophillcvZe6Cvmi4xd
         M41JG2QUOTWxdLkvi8IH97OQT3/7QfObEqfcWHOfaAMPiCACf2YwdO2N7el0B8w1MN3j
         EiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KU4zqL83rIya+dDobk/RnK3hyM/osaOo/rErdYHKbRI=;
        b=do+/nOYTAlFgskKKjLuj9dUO+Fwk5oOCj9Ce6CAN99oWj/tWMxCYFi9n2tTn2W30QP
         42jgf3ess6oahutMHpT2RPKzDPfhChiIpFIkV7iTyBdseZ+13Co1ENVabI1Ur405OlHO
         dufDk0+is0USuVcgwybmC7OcISAhk1+E/RMmeIXkaPH6E2nKM5s4+ZKyrxv0Bo4GF47T
         mkQyq/9QyFTNkQxqjq9HY12ZxGYnEzidWq3EB0P87yUaAMKjkg756K1jhQwzobDFFpw+
         9AWTUxcEnctmoUmazX68LlfyFBw+vV3hTZCz4i1sefL6zshMAFnUFXdY7cZRINi948mc
         DLjg==
X-Gm-Message-State: AOAM533A/5CQ9JdiKmXHS3iMvxzEV/uZ/LJ55/YwRWJyFZZoowk4icxD
        Di0nYVo3OMqCsJ1IrHY/ROE4CQ==
X-Google-Smtp-Source: ABdhPJygYLealOvR28rVwZzTVa7qk5jJtMf4NND7+WXxpgF46I21oTc1IedTOaFRLVXWu5IRerM9VQ==
X-Received: by 2002:a05:6402:17d8:: with SMTP id s24mr6272779edy.61.1598293788731;
        Mon, 24 Aug 2020 11:29:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id df22sm10447332edb.93.2020.08.24.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:29:48 -0700 (PDT)
Date:   Mon, 24 Aug 2020 20:29:31 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.pan.linux@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v2 2/9] iommu/ioasid: Rename ioasid_set_data()
Message-ID: <20200824182931.GC3210689@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598070918-21321-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:35:11PM -0700, Jacob Pan wrote:
> Rename ioasid_set_data() to ioasid_attach_data() to avoid confusion with
> struct ioasid_set. ioasid_set is a group of IOASIDs that share a common
> token.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/intel/svm.c | 6 +++---
>  drivers/iommu/ioasid.c    | 6 +++---
>  include/linux/ioasid.h    | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index b6972dca2ae0..37a9beabc0ca 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -342,7 +342,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  			svm->gpasid = data->gpasid;
>  			svm->flags |= SVM_FLAG_GUEST_PASID;
>  		}
> -		ioasid_set_data(data->hpasid, svm);
> +		ioasid_attach_data(data->hpasid, svm);
>  		INIT_LIST_HEAD_RCU(&svm->devs);
>  		mmput(svm->mm);
>  	}
> @@ -394,7 +394,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	list_add_rcu(&sdev->list, &svm->devs);
>   out:
>  	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
> -		ioasid_set_data(data->hpasid, NULL);
> +		ioasid_attach_data(data->hpasid, NULL);
>  		kfree(svm);
>  	}
>  
> @@ -437,7 +437,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>  				 * the unbind, IOMMU driver will get notified
>  				 * and perform cleanup.
>  				 */
> -				ioasid_set_data(pasid, NULL);
> +				ioasid_attach_data(pasid, NULL);
>  				kfree(svm);
>  			}
>  		}
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 0f8dd377aada..5f63af07acd5 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -258,14 +258,14 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
>  EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
>  
>  /**
> - * ioasid_set_data - Set private data for an allocated ioasid
> + * ioasid_attach_data - Set private data for an allocated ioasid
>   * @ioasid: the ID to set data
>   * @data:   the private data
>   *
>   * For IOASID that is already allocated, private data can be set
>   * via this API. Future lookup can be done via ioasid_find.
>   */
> -int ioasid_set_data(ioasid_t ioasid, void *data)
> +int ioasid_attach_data(ioasid_t ioasid, void *data)
>  {
>  	struct ioasid_data *ioasid_data;
>  	int ret = 0;
> @@ -287,7 +287,7 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(ioasid_set_data);
> +EXPORT_SYMBOL_GPL(ioasid_attach_data);
>  
>  /**
>   * ioasid_alloc - Allocate an IOASID
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 6f000d7a0ddc..9c44947a68c8 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -39,7 +39,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  		  bool (*getter)(void *));
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
> -int ioasid_set_data(ioasid_t ioasid, void *data);
> +int ioasid_attach_data(ioasid_t ioasid, void *data);
>  
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> @@ -67,7 +67,7 @@ static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allo
>  {
>  }
>  
> -static inline int ioasid_set_data(ioasid_t ioasid, void *data)
> +static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  {
>  	return -ENOTSUPP;
>  }
> -- 
> 2.7.4
> 

Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8028320409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqvMEJNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCTJaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:30:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34995 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:30:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so5503935wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t95jhtMcmGffLMbEseHS3007BbwA1KPmU4Pb5j0U3FY=;
        b=VqvMEJNKWZ+GMMBwIEtcSmmQKWKa8aEWa+iSg7K5ytuOLsVlLmG0bxMkn3PU/07/GG
         6Q2HUOGfO5iPvqGcO35qgA4IixhmG8QwLjWYOw5KbUtFDawlvpNZaptJe1SF0+t+TdwY
         UtVSFJ+0AL/hWuO+Z3Iubq09qsH358JYUPFD8YAPeFuEeQ8v9zcywnWIhuz/cje9jg5W
         IBx1bbdVWZEZ7sETn+vGQz57/J5yfr3U3GK6WHlYPmD+kApK8u+i/paveQbmAE2HSqE8
         1AoHygKuu9yQQKRZXHd26ReC8qzFOV56S8fIDSduJWHoBdRwddg+s47yKqdRUhwuioFU
         knag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t95jhtMcmGffLMbEseHS3007BbwA1KPmU4Pb5j0U3FY=;
        b=rlpuK8UDPECMi9smcuzktHGorQ7m4oifpDg4IoSUgp7JZOP7yMgmASIwQjP3XRlLs3
         9dVoQI91MG6Aob7OQ7bNxRIhgyGH29ndOQux+PUgzs9aR/ZP7S342qvmTih0zwEf/FDE
         7QimNE9/RGHKgYmcPgvCMb3fi0SqH3ewRJDGAr4bs434kAB9xz6ihRdH59h6oKy6kUEc
         kHkBZAJqFLCCzL/8/Ct9BRJ6g4nuwaMaO3T+fyWVrGiO9ceOCjD6tAwI1378fXQkFa4H
         hz3TrrMiIkUYzOV1vsFhCGqkZESgaJUOxpl3utAm1nddIHZNYveiLSXtpxWJ4V+H2hN1
         k74w==
X-Gm-Message-State: ANhLgQ0aHyORRM3qpkgtgBiW9Nh7J4dW3KbYdFfqK4co3RDVb0JGI2g4
        oKlM3SWtsRo2/LnKWNtfcifMFQ==
X-Google-Smtp-Source: ADFU+vvKndZNZl8YtUgYmokxoyclO36pHTSz5y/ZbuS1pLvWCL0Auic4wn0jWR1CcWyuTi2+/gPLrQ==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr8809378wmj.29.1584696633296;
        Fri, 20 Mar 2020 02:30:33 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p10sm3252738wrm.6.2020.03.20.02.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 02:30:32 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:30:25 +0100
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
Subject: Re: [PATCH 1/2] iommu/vt-d: Report SVA feature with generic flag
Message-ID: <20200320093025.GB1702630@myrica>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582586797-61697-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 03:26:36PM -0800, Jacob Pan wrote:
> Query Shared Virtual Address/Memory capability is a generic feature.
> SVA feature check is the required first step before calling
> iommu_sva_bind_device().
> 
> VT-d checks SVA feature enabling at per IOMMU level during this step,
> SVA bind device will check and enable PCI ATS, PRS, and PASID capabilities
> at device level.
> 
> This patch reports Intel SVM as SVA feature such that generic code
> (e.g. Uacce [1]) can use it.
> 
> [1] https://lkml.org/lkml/2020/1/15/604
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Don't you also need to have has_feat(), feat_enabled() and disable_feat()
return positive values?

Thanks,
Jean

> ---
>  drivers/iommu/intel-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 92c2f2e4197b..5eca6e10d2a4 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6346,9 +6346,14 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
>  static int
>  intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
>  {
> +	struct intel_iommu *intel_iommu = dev_to_intel_iommu(dev);
> +
>  	if (feat == IOMMU_DEV_FEAT_AUX)
>  		return intel_iommu_enable_auxd(dev);
>  
> +	if (feat == IOMMU_DEV_FEAT_SVA)
> +		return intel_iommu->flags & VTD_FLAG_SVM_CAPABLE;
> +
>  	return -ENODEV;
>  }
>  
> -- 
> 2.7.4
> 

Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744ABC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CECA206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ce+oo9Nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbgDANx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:53:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44817 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732442AbgDANx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:53:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so85655wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N3VZNqRqFxDjiGDS6MHyTsfY3s8TOjT37n/Z1e8mgiU=;
        b=Ce+oo9NvsmwcUsd3osdUjFez8gIP5koyw/r4j/tFrHU5HPJj9pkz8MY2ohZkvJTtaf
         kNM+MjsvpJrfQjvNejXZHFMqsa0GfS1JNTdTENS1zXqZ/FYRCnyV1NKfn4r/cPyPcSWp
         6WAw+L2nBV46G4lBaOCqeS/FgUy7c3+t+KpVBjQJnReppMBYqpFVKrIF0sns5+q0o+rA
         s6+9EuwffMSHQIds85z5uxNFfweguEfw89WnyKW2Eh3XO5PSJCXjDn+h+cCUCkY0dQWA
         WXwDJn/yyF/vUvoHPQaVpzlwi28GFUmRJUFJcQAIYiKVdyOQRh/JI+60+LNUAI/av/lH
         trew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N3VZNqRqFxDjiGDS6MHyTsfY3s8TOjT37n/Z1e8mgiU=;
        b=G5m4p8DKf1pBbtBlkbZ9gDmZPuL7BaYa1Mgk3v39jWxk2tDR3BBcMWVQ5VK6JWHHRF
         1ljuONUhHCsdjlCUrrGlVgx77G/Bpf2CVZDrRdZ0e/T1QRa3i9/ue5RcjPyiLfDD97pt
         89u6Oi+E7eJUFbKIddX2iyTIgwXDBf9nRQ/5+qGDYf0kBkalB/V/Kf9QDapdf5zqJvBU
         hWq+RcdVxdnxHI5cSpdxxnXZaOHuJpkde99wYjz4o0dRmXL+LNUZ1obop0SYXWZkIpUr
         Lf4diGrl7FW5N6gE/hMN9kvyzhaceZxQo2T56ZpPcKwE55meYhEJBlTFPBJFSQ6cHtQq
         m8ZA==
X-Gm-Message-State: ANhLgQ2b5Xd9awfliDANWFclOv1OUtFtmy0MduCXaOo/non4PG1HgKwE
        rr9EUUKrY5bMBDwuB49tEtAnkA==
X-Google-Smtp-Source: ADFU+vuYgJ+1ZTqAp8KuvhZlz9S/Oxuge5ptpfnYD11EEFffsjQffMmg+At3JrOekagzuea5W0Z/Wg==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr25665802wrt.346.1585749204818;
        Wed, 01 Apr 2020 06:53:24 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id t10sm2764667wrx.38.2020.04.01.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:53:24 -0700 (PDT)
Date:   Wed, 1 Apr 2020 15:53:16 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA use
Message-ID: <20200401135316.GF882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:55:26AM -0700, Jacob Pan wrote:
> Bare metal SVA allocates IOASIDs for native process addresses. This
> should be separated from VM allocated IOASIDs thus under its own set.
> 
> This patch creates a system IOASID set with its quota set to PID_MAX.
> This is a reasonable default in that SVM capable devices can only bind
> to limited user processes.

Yes realistically there won't be more than PID_MAX_DEFAULT=0x8000 bound
address spaces. My machine uses a PID_MAX of 4 million though, so in
theory more than 0x8000 processes may want a bond. On Arm the limit of
shared contexts per VM is currently a little less than 0x10000 (which is
the number of CPU ASIDs).

But quotas are only necessary for VMs, when the host shares the PASID
space with them (which isn't a use-case for Arm systems as far as I know,
each VM gets its own PASID space). Could we have quota-free IOASID sets
for the host?

For the SMMU I'd like to allocate two sets, one SVA and one private for
auxiliary domains, and I don't think giving either a quota makes much
sense at the moment. There can be systems using only SVA and systems using
only private PASIDs. I think it should be first-come-first-served until
admins want a knob to define a policy themselves, based on cgroups for
example.

> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 8 +++++++-
>  drivers/iommu/ioasid.c      | 9 +++++++++
>  include/linux/ioasid.h      | 9 +++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ec3fc121744a..af7a1ef7b31e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3511,8 +3511,14 @@ static int __init init_dmars(void)
>  		goto free_iommu;
>  
>  	/* PASID is needed for scalable mode irrespective to SVM */
> -	if (intel_iommu_sm)
> +	if (intel_iommu_sm) {
>  		ioasid_install_capacity(intel_pasid_max_id);
> +		/* We should not run out of IOASIDs at boot */
> +		if (ioasid_alloc_system_set(PID_MAX_DEFAULT)) {
> +			pr_err("Failed to enable host PASID allocator\n");
> +			intel_iommu_sm = 0;
> +		}
> +	}
>  
>  	/*
>  	 * for each drhd
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 6265d2dbbced..9135af171a7c 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -39,6 +39,9 @@ struct ioasid_data {
>  static ioasid_t ioasid_capacity;
>  static ioasid_t ioasid_capacity_avail;
>  
> +int system_ioasid_sid;
> +static DECLARE_IOASID_SET(system_ioasid);
> +
>  /* System capacity can only be set once */
>  void ioasid_install_capacity(ioasid_t total)
>  {
> @@ -51,6 +54,12 @@ void ioasid_install_capacity(ioasid_t total)
>  }
>  EXPORT_SYMBOL_GPL(ioasid_install_capacity);
>  
> +int ioasid_alloc_system_set(int quota)
> +{
> +	return ioasid_alloc_set(&system_ioasid, quota, &system_ioasid_sid);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc_system_set);

I think this helper could stay in the VT-d driver for the moment. If the
SMMU driver ever implements auxiliary domains it will use a private IOASID
set, separate from the shared IOASID set managed by iommu-sva. Both could
qualify as "system set".

Thanks,
Jean

> +
>  /*
>   * struct ioasid_allocator_data - Internal data structure to hold information
>   * about an allocator. There are two types of allocators:
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 8c82d2625671..097b1cc043a3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -29,6 +29,9 @@ struct ioasid_allocator_ops {
>  	void *pdata;
>  };
>  
> +/* Shared IOASID set for reserved for host system use */
> +extern int system_ioasid_sid;
> +
>  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
>  
>  #if IS_ENABLED(CONFIG_IOASID)
> @@ -41,6 +44,7 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_install_capacity(ioasid_t total);
> +int ioasid_alloc_system_set(int quota);
>  int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
>  void ioasid_free_set(int sid, bool destroy_set);
>  int ioasid_find_sid(ioasid_t ioasid);
> @@ -88,5 +92,10 @@ static inline void ioasid_install_capacity(ioasid_t total)
>  {
>  }
>  
> +static inline int ioasid_alloc_system_set(int quota)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 

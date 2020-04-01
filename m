Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D688C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430C206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VteHLmzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbgDANqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:46:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42128 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbgDANqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:46:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so71800wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4cNryWwLgfk02MQJubNgjaSZbCDMoiiIMtKoOX7YXDI=;
        b=VteHLmzKgoEfzpQT1w/jhX76LESCf+gm4mvr2xXIqiwhTv2TpXWBbt4Y4ZcRFrHXM5
         ZH8rUAOdHTvMKVc5NIBAxe5OIiGKoWZlamak03YGSPe1b2LkoLoEDDMyza5RZ+63zO7H
         MGuKbHbEs5BDD2VJYEB67W0WZgbY4ktCqGKHt70vKyVRIsvcoOefEpLENOV4IQI784b7
         h01SahB8bQKpM8MCXHS0DVklDLvM98lHC+3svnbLpIUBQf9ktvVmCfuQx5Le8RNFrWlB
         1WZNbK4SIJGcUVYehFgqpdLV3myf8yVjxpuqWFtD6OFnmj0TJKliqsoo4rFebvSMz6dg
         umEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4cNryWwLgfk02MQJubNgjaSZbCDMoiiIMtKoOX7YXDI=;
        b=WDJsjcC8G4ZqozXreye66XbNnELQyMlXGIv3TMnYovQyKwS/3ssCFK1UxkW2fJZ9jz
         pDBpihJZLKQ907YC3wfoA+l6MXxaEoeWAGc+n3dzx1pXnxg0FX36wEQqWw/u3Eo+1I8o
         5hlHiwLEVtEP7J+VpSaP9Jzv0Y8//+STRZgh1fteJNyrkdfU9o5k586KozR83ASFq1lo
         3f1l4W4Rj6JIrq8lLNb/D1R3+7Y8RpHgZM6VlaD9PxAewIgVNB/fue6q/T+9n7QiLhBI
         Ui9iMi7JGKeoupfbfuKBUx/CLUjT8pdoQ4WNxBQz80yw7BiTF2CbjPeihG6A3Ur9kX0l
         I6Cg==
X-Gm-Message-State: ANhLgQ2vzOrgIPINamYGwMwfy+Za3Ee6Y2QQSn73iYqwvFRzyZAoIk3g
        h3Fi/WYUaZ/BHWhjcy91ideQiA==
X-Google-Smtp-Source: ADFU+vvhdDZCD6jV8ng3HnZclBV2DQ0pInm0Lq5Hk0o80mIiqRvOGy1tJbuXvkh/iSOegt0kXOB/Dg==
X-Received: by 2002:adf:e44a:: with SMTP id t10mr25806844wrm.322.1585748761807;
        Wed, 01 Apr 2020 06:46:01 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id z1sm3172281wrp.90.2020.04.01.06.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:46:01 -0700 (PDT)
Date:   Wed, 1 Apr 2020 15:45:52 +0200
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
Subject: Re: [PATCH 01/10] iommu/ioasid: Introduce system-wide capacity
Message-ID: <20200401134552.GD882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:55:22AM -0700, Jacob Pan wrote:
> IOASID is a limited system-wide resource that can be allocated at
> runtime. This limitation can be enumerated during boot. For example, on
> x86 platforms, PCI Process Address Space ID (PASID) allocation uses
> IOASID service. The number of supported PASID bits are enumerated by
> extended capability register as defined in the VT-d spec.
> 
> This patch adds a helper to set the system capacity, it expected to be
> set during boot prior to any allocation request.

This one-time setting is a bit awkward. Since multiple IOMMU drivers may
be loaded, this can't be a module_init() thing. And we generally have
multiple SMMU instances in the system. So we'd need to call
install_capacity() only for the first SMMU loaded with an arbitrary 1<<20,
even though each SMMU can support different numbers of PASID bits.
Furthermore, modules such as iommu-sva will want to initialize their
IOASID set at module_init(), which will happen before the SMMU can set up
the capacity, so ioasid_alloc_set() will return an error.

How about hardcoding ioasid_capacity to 20 bits for now?  It's the PCIe
limit and probably won't have to increase for a while.

Thanks,
Jean

> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 15 +++++++++++++++
>  include/linux/ioasid.h |  5 ++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 0f8dd377aada..4026e52855b9 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -17,6 +17,21 @@ struct ioasid_data {
>  	struct rcu_head rcu;
>  };
>  
> +static ioasid_t ioasid_capacity;
> +static ioasid_t ioasid_capacity_avail;
> +
> +/* System capacity can only be set once */
> +void ioasid_install_capacity(ioasid_t total)
> +{
> +	if (ioasid_capacity) {
> +		pr_warn("IOASID capacity already set at %d\n", ioasid_capacity);
> +		return;
> +	}
> +
> +	ioasid_capacity = ioasid_capacity_avail = total;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> +
>  /*
>   * struct ioasid_allocator_data - Internal data structure to hold information
>   * about an allocator. There are two types of allocators:
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 6f000d7a0ddc..9711fa0dc357 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_set_data(ioasid_t ioasid, void *data);
> -
> +void ioasid_install_capacity(ioasid_t total);
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  				    ioasid_t max, void *private)
> @@ -72,5 +72,8 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
>  	return -ENOTSUPP;
>  }
>  
> +static inline void ioasid_install_capacity(ioasid_t total)
> +{
> +}
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 

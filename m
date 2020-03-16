Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E741C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336BA20724
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGOY+0zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbgCPP6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:58:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36606 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbgCPP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:58:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id s5so21948903wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H8gu7DkqIY6Hs0O9tBbPEC3uwEKTTAu/TiMJwJ6IfWo=;
        b=XGOY+0zNdZhJAwbt7nG45/bQQxernSkoWJlhxo09FLN2GjiT7TZsLFWAicn5ItdGvm
         M2f0bxD904jzYwBR3rGju26xdAss05Tnrad5a3+eTITy4PaGbbo8kVJpU/QkMvi8bKHx
         M4gGOaDYgSyiZ3mJ9iPwBTsfWTTTSNUYdtcHHTf5c45HYQCEw05zhk2zHiiIlgXrLl50
         dxZ2vtj0a93wasRTiOYVhgOTGADvh9/WAPglVYHNBNVBcnbgiZ5GUkbXkDqOwRRwnZoI
         /icjBVyzPGEJHv+lmMhuIcgeVZ3ifW3bA1YXra3qBcD2x7XmMiVgn/6LpHTLIoSPUCDG
         QnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8gu7DkqIY6Hs0O9tBbPEC3uwEKTTAu/TiMJwJ6IfWo=;
        b=g+eEpVbLLBZOLdl80/02VF19mfHu4P8PxT9FaWYHuxNEZCmxwBSS2oxAfGXhW3lqYq
         cN+tManJTvTrYhbER400R7/u0VuGuTi+5rT2CEyqUgYcWiApSzOXrP7T/Fpk6Lv2bO3j
         /y/FZ7aPUFOeyvyhCqW4LfUyrHgNI3GC8I9MyWEe/fk16dGEmdTAHpk4Ax3aP6QB+l5v
         cwh+TW6/aRzj4qfmWs8C31K+ZG7EO1VUn8mCQcNSTrYBJi4dZdd9n5UZzZIByQNosqek
         6YZJZnqFLXnXcw+W8QjWbCJf/eh5P/r6uLcD8rXjy9VagoIB8sOgEzSiUSwvLMfv4b0K
         jrmw==
X-Gm-Message-State: ANhLgQ0zThf9Y893VhzLmUpgLh/GApCNY1K5WCEJuP00KeozWHWhk4V8
        uK5KqoSNE0zGRMEZfBItxw5gGA==
X-Google-Smtp-Source: ADFU+vsSrPRyJcA3YQxERetVdYcC8+kKaCnqT9yz2q1GFbJB+t1gIFoFuZk5ByOWaxPUf9x/6kt4+g==
X-Received: by 2002:a5d:66c4:: with SMTP id k4mr23072wrw.133.1584374284591;
        Mon, 16 Mar 2020 08:58:04 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y189sm180467wmb.26.2020.03.16.08.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:58:04 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:57:56 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 15/15] iommu: Move fwspec->iommu_priv to struct dev_iommu
Message-ID: <20200316155756.GO304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-16-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-16-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:12:29AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Move the pointer for iommu private data from struct iommu_fwspec to
> struct dev_iommu.
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  include/linux/iommu.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 056900e75758..8c4d45fce042 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -369,6 +369,7 @@ struct iommu_fault_param {
>   *
>   * @fault_param: IOMMU detected device fault reporting data
>   * @fwspec:	 IOMMU fwspec data
> + * @priv:	 IOMMU Driver private data
>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>   *	struct iommu_group	*iommu_group;
> @@ -377,6 +378,7 @@ struct dev_iommu {
>  	struct mutex lock;
>  	struct iommu_fault_param	*fault_param;
>  	struct iommu_fwspec		*fwspec;
> +	void				*priv;
>  };
>  
>  int  iommu_device_register(struct iommu_device *iommu);
> @@ -589,7 +591,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
>  struct iommu_fwspec {
>  	const struct iommu_ops	*ops;
>  	struct fwnode_handle	*iommu_fwnode;
> -	void			*iommu_priv;
>  	u32			flags;
>  	u32			num_pasid_bits;
>  	unsigned int		num_ids;
> @@ -629,12 +630,12 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
>  
>  static inline void *dev_iommu_priv_get(struct device *dev)
>  {
> -	return dev->iommu->fwspec->iommu_priv;
> +	return dev->iommu->priv;
>  }
>  
>  static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>  {
> -	dev->iommu->fwspec->iommu_priv = priv;
> +	dev->iommu->priv = priv;
>  }
>  
>  int iommu_probe_device(struct device *dev);
> -- 
> 2.17.1
> 

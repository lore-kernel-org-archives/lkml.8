Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5C1C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AFB2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqEM+8T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgCPPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:48:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46296 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbgCPPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:48:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id w16so5431835wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J+yCX5u1YDN6eK0N92vhv3vwdN0qX/QOnRznwSw/NEU=;
        b=wqEM+8T/4h/xHj/JCPK+rRTCXxcVR4eDf7FRmVy6tL77x3zHH/AiX26KSVcpaAUPYM
         H2E3TxgVcsUZps0ZwbKrOGHGA1w+q7Tk9JZyHOG4r0miXlsNK9DAr6ASz77gWGMYoThi
         aqIcdck8zrW9cmOsVNIVfmvriv2jyBKV2gCHKWxDzNBhDSaeuNibLyNo1rN/KPESbvGx
         bYFXAMI7K3kXwTe2xy6IA/A4hJbQRhpt2ZZKRbDn2/H/Lo/rmmzCexG9w/kcno6ZiI77
         ppej5XGet0RlmPFvfqjzVDbUXtrDAc80RMkysk6JhzvWsm3/Qn/rhmBAkBM9JFQCl/h+
         nSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J+yCX5u1YDN6eK0N92vhv3vwdN0qX/QOnRznwSw/NEU=;
        b=aZxtNJ+tCw/3WUnUlEjumfjaTb4pDu1jWVkI65WLvNH3fBV9auCYjbOUa726dFKA0/
         MNcLZj7m56BX4tFx01iRoVV79yiob9nMw6k0KCJbhMBjg3VEUndM77VFLduM9v0UyE2T
         am9KZBXM/GwOmFrK9+9CCyvwn3TH7JHO6wadGbZJlVzPNOTOobMKriF5IhJF8EeKyJTh
         TQsEIElD6Mo+UbpTuRXtTnBdlmPuxiVJLvLWXE074QBbepiAUiZT2QJ5hmookGBoV96N
         tA/xWXb+rFZhWaGfisneZEGR8c644Jv2q3zN+RzmtwSlY/SNKWAYTxvEIPfQLoHxCXNR
         qbFA==
X-Gm-Message-State: ANhLgQ2vEzWjuoK2Ufy1oYWOJZaJsUdNdMYyHBr5wbiFiVGY68hd/bm0
        KK7Y/3rvF2Qkj0iC7wBjtrYTQQ==
X-Google-Smtp-Source: ADFU+vu7BwV9+IRhzha1mvLv+qxjTZOswhDVu8mc2cK8kbLXKQAY/jWE86j0EqeFBPhJwYU3dCMzFg==
X-Received: by 2002:adf:f510:: with SMTP id q16mr6841064wro.43.1584373677809;
        Mon, 16 Mar 2020 08:47:57 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id l7sm488506wrw.33.2020.03.16.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:47:57 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:47:49 +0100
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
Subject: Re: [PATCH 08/15] iommu: Introduce accessors for iommu private data
Message-ID: <20200316154749.GI304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-9-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-9-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:12:22AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add dev_iommu_priv_get/set() functions to access per-device iommu
> private data. This makes it easier to move the pointer to a different
> location.
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  include/linux/iommu.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f5edc21a644d..056900e75758 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -627,6 +627,16 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
>  	dev->iommu->fwspec = fwspec;
>  }
>  
> +static inline void *dev_iommu_priv_get(struct device *dev)
> +{
> +	return dev->iommu->fwspec->iommu_priv;
> +}
> +
> +static inline void dev_iommu_priv_set(struct device *dev, void *priv)
> +{
> +	dev->iommu->fwspec->iommu_priv = priv;
> +}
> +
>  int iommu_probe_device(struct device *dev);
>  void iommu_release_device(struct device *dev);
>  
> -- 
> 2.17.1
> 

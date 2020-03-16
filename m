Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C313C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445B020674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/R6qyTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgCPRz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:55:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38605 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbgCPRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:55:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so665610wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZCpP6b3rcDrFb5nL77Llc1TqP6zJQRoyalcv/Uk/U4=;
        b=Y/R6qyTPo9TH/wBiHH7KTVuPGU3xiYNdjGryws2oZjJT4EdE1Ukovm/qw0EUnU24gU
         S55BE2BmG4HOCtOwEOXGyy7AXs7ku0tleXQgOw9PFvVcXjBuY7X76ik6J67WXOAkluwY
         N8AUX6GldQgLMC2mjOJDUYeeFD61OI8upFJvU0u4LMkkLTWuKAqoRyeRXtYobTQC3CM1
         DhcjEhjnIN+SU8WqnWGyVuamv6HlAzsykRt5ewg6nLfQTUffQQtYpl8UmUJbnXxtaH9t
         SxVsykhhy/G0nCc53h3pcXuufWOU2IhPvnEjecW1aIFH4e1Rdj9IpsbjZMLyQjBC3MnB
         v6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZCpP6b3rcDrFb5nL77Llc1TqP6zJQRoyalcv/Uk/U4=;
        b=CTuXDSNnBzYoqoN8TFHxPZr8lMThyDyj8M8qRg2jcvtR2uLYM1iFgase4bYkpK1jRd
         QDe0RlbS0HwSY7LqQI0+VWbdhk5VjPAS4WmeJrdk6itzWtQSk7/FVXjoot5zVCGp3XEg
         2lFWynJT4GiG4giwkE3GSAxO/m4Per8AUpKH+BSxYBpElxap8tAFczPOFIjeZBQT5FrT
         Q1CSqsJ7EbZLsJTGH2sHu/QScc6xnAx2NueU047cEmNqXOFUUHyTChvJ8bLpgOxaifbO
         ycejs32hyiTNDIDg/cwwV5CelfszCnWVB7Vjgw3iIaGxblHtQTXNTtcguSBqP8JZdz1T
         6Fxg==
X-Gm-Message-State: ANhLgQ25TOyi8Ixt50qyj19b4U/y3txtVdJllpAmLJfOlGSpP5EPFsCx
        q44B2f9axwUwwFyv3TId+6vytQ==
X-Google-Smtp-Source: ADFU+vuHWkRqgMn4prXCXTnSNDBAjWBUzoa8syi0tqbAh8eRnR4X3rD/HVE1PtCHryXLNIoYPL6aMQ==
X-Received: by 2002:adf:f14a:: with SMTP id y10mr485041wro.325.1584381324158;
        Mon, 16 Mar 2020 10:55:24 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n10sm964333wro.14.2020.03.16.10.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 10:55:23 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:55:15 +0100
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
Subject: Re: [PATCH 10/15] iommu/arm-smmu: Use accessor functions for iommu
 private data
Message-ID: <20200316175515.GP304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-11-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-11-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:12:24AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions and simplify the code
> where possible with this change.
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
[...]
> @@ -1467,7 +1470,7 @@ static void arm_smmu_remove_device(struct device *dev)
>  	if (!fwspec || fwspec->ops != &arm_smmu_ops)
>  		return;
>  
> -	cfg  = fwspec->iommu_priv;
> +	cfg  = dev_iommu_priv_get(dev);
>  	smmu = cfg->smmu;
>  
>  	ret = arm_smmu_rpm_get(smmu);
> @@ -1475,23 +1478,22 @@ static void arm_smmu_remove_device(struct device *dev)
>  		return;
>  
>  	iommu_device_unlink(&smmu->iommu, dev);
> -	arm_smmu_master_free_smes(fwspec);
> +	arm_smmu_master_free_smes(dev);
>  
>  	arm_smmu_rpm_put(smmu);
>  
>  	iommu_group_remove_device(dev);
> -	kfree(fwspec->iommu_priv);
>  	iommu_fwspec_free(dev);
> +	kfree(cfg);

nit: cfg is allocated after fwspec so it might be cleaner to free cfg
before fwspec.

But more importantly, should we clear the private data here and in the
other drivers, by calling dev_iommu_priv_set(dev, NULL) from
remove_device()?  We are leaving stale pointers in dev->iommu and I think
some of the drivers could end up reusing them.

Thanks,
Jean


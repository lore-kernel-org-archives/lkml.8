Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4252C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B0620663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjUfHswC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgCPPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:39:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36987 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgCPPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:39:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id 6so21809941wre.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0yzkSCm1Xcsm6hOYYsbTqS4amhDbi797Ag8RmkjurU=;
        b=VjUfHswCT1UKNAujAPhK8VCtliVrWtYIYyppBsAtlnbFCrxaad4Uc2A5soRvyi8Lz/
         SqPfxSFRDIQCzDyvLFNz52fC+JJkBauYJCclNDsvmtzidrUQROIsVQV6zcwzj00LmPWd
         He65rfdf7A/Oc+IFkmPIIFP2thDMmrP7w+MUVZbhd7yiRPnRF5U7lNWsW24hYJVoJYeR
         8wHBvHBpk9d8ZmoBo1s6yLkrnEqIRgPQmKuMyjkvlD33ynh0mEfoeYi9XfpNu36ky7nN
         jntyaqHoGFn/okVfozaKqLoYwnG4+U3ZIqhxZ9ETSHCiCMC6Iw7WS6sjUwRs0+vfP+X7
         +bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0yzkSCm1Xcsm6hOYYsbTqS4amhDbi797Ag8RmkjurU=;
        b=Y/D8M+vniKgXm8J3+K+RdbqcUq6ahXY12l6hKkRI38PMR0J8UNHw74nG1gKX/AikDX
         naLlzK3hQUqAUtGSNlLg+VTa8w2ugJJ77JdOw+Rms1UufAsFspegmSG9UV4aLCHCM0HM
         khNLULCR5aBP5CnHq1UzLXChJcr/oRolbN1Fv2viQcHuBVbvqwAfQY+DfYLdCqj9/1je
         aIp3YzZA6C013BYUTh/HNL1iWmlU9PMIa8gVUK+Z64pOS5iSXZz6LmxezXKA+pm9dZ1A
         KWFUhtVSYSGmxznmSFp0/e/mrWZHQ5ufaB3FtQAUtpTLAVYNVLwCGzAOEHU6mB2NeJC4
         lIBA==
X-Gm-Message-State: ANhLgQ0AuqVtFoL41AI5yRsyT389Cu0wDe+ciU1ET0bwXLiE/G0pI0oE
        uwQVk/zPORSj2okAZZj88G2BJw==
X-Google-Smtp-Source: ADFU+vs0mvRenL1g+U69U0qbNtFq1SVNLFNkkOGefFPc2C+th0hGKZ/JyHhYDuRn/eeS5wXEeUsB/Q==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr26159791wrk.101.1584373164974;
        Mon, 16 Mar 2020 08:39:24 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id 19sm143446wma.3.2020.03.16.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:39:24 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:39:16 +0100
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
Subject: Re: [PATCH 01/15] iommu: Define dev_iommu_fwspec_get() for
 !CONFIG_IOMMU_API
Message-ID: <20200316153916.GB304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-2-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:12:15AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> There are users outside of the IOMMU code that need to call that
> function. Define it for !CONFIG_IOMMU_API too so that compilation does
> not break.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

As a result drivers/gpu/host1x/hw/channel_hw.c and
drivers/gpu/drm/tegra/vic.c can lose their #ifdef CONFIG_IOMMU_API

> ---
>  include/linux/iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d1b5f4d98569..3c4ca041d7a2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1073,6 +1073,10 @@ static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
>  	return -ENODEV;
>  }
>  
> +static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  #ifdef CONFIG_IOMMU_DEBUGFS
> -- 
> 2.17.1
> 

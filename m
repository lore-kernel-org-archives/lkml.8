Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8B8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA520705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ln975L+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgAaWAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:00:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37665 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgAaWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:00:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so3284346plz.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b82MM5TsQ8A9XNdp0Y7iZIjPTfIvG0TXd9OXwa8Voa4=;
        b=ln975L+nUDW8vHW1M3ExHfHLl4zJ6xQ7xAqDPH8kgpaC2M25g/M0mpJXtoR9nZ8+zX
         fCKziGOUYvBuahWMFfMcvJFOCeQJEiH1U3THEAK/GpEkWuPqWgoraNYhdLCyxaDPJZk7
         8hf9/Az5nYC2xFao/C79k4QgNJRVjrt4tf2rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b82MM5TsQ8A9XNdp0Y7iZIjPTfIvG0TXd9OXwa8Voa4=;
        b=WT/c8pQEugwQ7oeJ90YoNkg8OpWZKL/OfzcjPxb0cv6RTumPH3YpvP5tEB2eCtf4by
         JiyqAZavASUJjXovVk5FmYHZ0KDAJ4gZQrzQSN1Spcr55ZaKEIZ4c9ngwyrGS+umVGT6
         WO5ySz4hYaKvtOU3dxAgxBuLwSpkpi5pkMnRZyJ9TOWWUoXl+t1PJABmMUXoZYGaP1Ld
         usDa/gst00lL5qdzBkv0qcD9Z64gOi+PD/CQ7qbG1xqyhe0WKxceAdEP1PsUDRSmREe4
         6IXGHYA6US89oeqAS5d9TSKVRxAhFHPYOZwH9ofSNUzlAuarOv8DyBdc6Cs3YY+FYnNl
         kxhQ==
X-Gm-Message-State: APjAAAV3HUlVSjJTjpVAUGKNosL40XQRdFQtSrshdkTPrhBmt/zJMif/
        nUTUtDb0UHEfOs1bjI5gU023YLZF70c=
X-Google-Smtp-Source: APXvYqxJ4dABMrxvg8Mkn8WWBjXAgyn0FUDu4pBM/f8rqnl3BFmy/f1OIqxj6WnyNvD4RpAWCJnROA==
X-Received: by 2002:a17:90a:36af:: with SMTP id t44mr14554287pjb.25.1580508045310;
        Fri, 31 Jan 2020 14:00:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id g2sm11436046pgn.59.2020.01.31.14.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 14:00:44 -0800 (PST)
Date:   Fri, 31 Jan 2020 14:00:43 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, jcrouse@codeaurora.org,
        saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 1/7] iommu/arm-smmu: Pass io_pgtable_cfg to impl
 specific init_context
Message-ID: <20200131220043.GN71044@google.com>
References: <1577962933-13577-1-git-send-email-smasetty@codeaurora.org>
 <1577962933-13577-2-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1577962933-13577-2-git-send-email-smasetty@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 02, 2020 at 04:32:07PM +0530, Sharat Masetty wrote:
> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Pass the propposed io_pgtable_cfg to the implementation specific
> init_context() function to give the implementation an opportunity to
> to modify it before it gets passed to io-pgtable.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-impl.c |  3 ++-
>  drivers/iommu/arm-smmu.c      | 11 ++++++-----
>  drivers/iommu/arm-smmu.h      |  3 ++-
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index b2fe72a..33ed682 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -68,7 +68,8 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
> 
> -static int cavium_init_context(struct arm_smmu_domain *smmu_domain)
> +static int cavium_init_context(struct arm_smmu_domain *smmu_domain,
> +		struct io_pgtable_cfg *pgtbl_cfg)
>  {
>  	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
>  					      struct cavium_smmu, smmu);
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index eee48f9..4f7e0c0 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -758,11 +758,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		cfg->asid = cfg->cbndx;
> 
>  	smmu_domain->smmu = smmu;
> -	if (smmu->impl && smmu->impl->init_context) {
> -		ret = smmu->impl->init_context(smmu_domain);
> -		if (ret)
> -			goto out_unlock;
> -	}
> 
>  	smmu_domain->pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= smmu->pgsize_bitmap,
> @@ -773,6 +768,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		.iommu_dev	= smmu->dev,
>  	};
> 
> +	if (smmu->impl && smmu->impl->init_context) {
> +		ret = smmu->impl->init_context(smmu_domain, &smmu_domain->pgtbl_cfg);

Which patch adds 'pgtbl_cfg' to struct arm_smmu_domain? The field does
not exist in iommu/next.

Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4161C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A275206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khSkOa1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbgF2VwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404581AbgF2Vv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:51:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09482C061755;
        Mon, 29 Jun 2020 14:51:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j12so8457123pfn.10;
        Mon, 29 Jun 2020 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RvMj5yET6zod7vEbQyQ+dyCF/KGdDXqpRazv7Nh0/qE=;
        b=khSkOa1iOR9sKq/l2Lwg2R+70F1qzc3rAWzT1DL81iYJKmfl0OXAKmLaQcEHYh75HD
         Dim7FCtnFG0m3Y7kmHUxgsykRsUHZT5JQ3g87aZYI4UDZCCTRHwPIe67iXeMWm5sEQfb
         S3DB34IC0Dv9F409Wj8gM0iG9PKhXAsgikpd3QtZ0pNSzZcG6ZPjeTArTudFcF1akU6m
         eYGILAK+dTr82RFhdBeh3NutZ5dWsG+VNNMJoyuEh2Ok8m/Rse1bW+zrHLKD0opEhiNz
         FdieyEh5ErWKSTF9nDD3gmex2heXZGcC2WmHB7o+O5FROMQJFQSgrf+aYMzwv6arrIWW
         yfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvMj5yET6zod7vEbQyQ+dyCF/KGdDXqpRazv7Nh0/qE=;
        b=HSsi7Fq8hp9gkuwklbw1hKl22Tt/NzIJr2bwDAzPYWU+LDW/9Nr/8Su7a8UWdqgF4X
         mHh9YqMsIWMtTO83LkVn2dYmhkIWKrhWapHQ4z71kS7eqH62QgTo8R2Ao5WsEDp8dwjZ
         UfPI4gBqoUZeHOy9ykLa8cMX5P3kFNSnYa1P4spKBrIdR6sZkHyMA9JTMqK28/dDeJ+X
         qMRukOgzSy5MEng0wRZfVZm0WuPoJ+29TmkBoxYsZPGGcgMe5N8WINZg2K93c3oyXuKF
         T5Onr/L1rcUCN1Tk6F5mup284eEnS7cEHovRt0/NNAzKyN6nIjRVloDWr2BZ9Z6PXpOC
         nupw==
X-Gm-Message-State: AOAM5317Gpx/3R5rDrwoE61vAqlLp5KTssLYOifpC1QAUTozxUDod+JM
        fSwbXFnTi2nqY4nVNL7MfLQ=
X-Google-Smtp-Source: ABdhPJxC8Fgjn8RTlD0SKk0xsVZpbiGlo9R3VT7A5mIZwpCLggeB5EdfCEKblPcw3+omhGtZUjddyQ==
X-Received: by 2002:a63:f903:: with SMTP id h3mr12511677pgi.437.1593467517533;
        Mon, 29 Jun 2020 14:51:57 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id p189sm542487pfb.217.2020.06.29.14.51.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 14:51:57 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:51:24 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        bbiswas@nvidia.com, mperttunen@nvidia.com, nicolinc@nvidia.com,
        bhuntsman@nvidia.com
Subject: Re: [PATCH v7 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Message-ID: <20200629215124.GD27967@Asurada-Nvidia>
References: <20200629022838.29628-1-vdumpa@nvidia.com>
 <20200629022838.29628-2-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629022838.29628-2-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 07:28:36PM -0700, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC uses two ARM MMU-500s together to interleave
> IOVA accesses across them.
> Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
> string for Tegra194 SoC SMMU topology.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

> +static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
> +			       unsigned int inst, int page)
> +{
> +	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
> +
> +	if (!nvidia_smmu->bases[0])
> +		nvidia_smmu->bases[0] = smmu->base;
> +
> +	return nvidia_smmu->bases[inst] + (page << smmu->pgshift);
> +}

Not critical -- just a nit: why not put the bases[0] in init()?

Everything else looks good to me:

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA524C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9921B206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTjvUlyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgF2WjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgF2WjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:39:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B13C061755;
        Mon, 29 Jun 2020 15:39:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so2987594pfo.9;
        Mon, 29 Jun 2020 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Iu1xPBy5WXwkFFBJOQd76GqrMB06IUJO2waW3mfV8U=;
        b=gTjvUlyTbHz0oJ+ZTJLVjld7MNptvaKU+FuhJs4PHp3VJe7iD78Wnm9qRxP8sGXjkT
         E9n88VrbVyaaM7G/LYjUvQiLO7DTUFz4TNpthv+odbNS6JzQ/4X/5soG013CP6gGIKqC
         fDdzcbxURl4O6Mo+D1YcpoaPilqUwVZhIgGTvtcfp1+Fl9ZZ8INKmvFWWz/i4fBpobtz
         wLsJ1LxWtrcbCgu/x541ND/jRxqGlS0WqWGorP031pC+XmEF6FatSkgYj2F7HGJe3ZMT
         I4Rs4uU+0dsDsK76hJhLW7C0n8dCf/+d1/TbpKay5dGxgUCKgURjQ9aol0DVoL+7UBhS
         3fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Iu1xPBy5WXwkFFBJOQd76GqrMB06IUJO2waW3mfV8U=;
        b=FK2A3kGk3jakgvhx7m9/LS8UjYdkGNW7ULqh8ki9D1q9RDsW1XxYUXax6hFvFT87qb
         5SvSB0G9iNLy44drV3btYSLhKVci3mhS7DD4h3tZStJTPj5x/kpZwedzjVpsvZ8/2ccq
         djwepAeVFqkZGURohcrz0dJb4TKnSQVimFmTYZp/Zhc/dJZ6s9m50XoegRqenQp/w662
         3NpIwVj2gt5h4Jpm8rh8WnwsBosSYWEIQWAUDQfl2hupzT3a++knVPV5ZstUiMGx0yUZ
         ICW4t+EJwy21ydkyQJho+O9ofeMjgusI+bj5bJY7BDIqMBdMZFSvYIqYKgZSqtXBLl+G
         eRsA==
X-Gm-Message-State: AOAM530UPm7UVYJiCac/N/ehiJlVGzjrgoWUDDudLP+v4QyJ3D2/tknC
        WlQFfVZCvlv6IBlKL/YKQ9s=
X-Google-Smtp-Source: ABdhPJxyJjEs525bJOi/owsnsyMW+4K2ovHEsNcudSFqdc/+fbfQqaH+B0HBZxSn54knZLvM1RiQYQ==
X-Received: by 2002:a63:531e:: with SMTP id h30mr11821163pgb.165.1593470347620;
        Mon, 29 Jun 2020 15:39:07 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z1sm458786pjz.10.2020.06.29.15.39.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 15:39:07 -0700 (PDT)
Date:   Mon, 29 Jun 2020 15:38:34 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        bbiswas@nvidia.com, mperttunen@nvidia.com, nicolinc@nvidia.com,
        bhuntsman@nvidia.com
Subject: Re: [PATCH v7 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Message-ID: <20200629223833.GE27967@Asurada-Nvidia>
References: <20200629022838.29628-1-vdumpa@nvidia.com>
 <20200629022838.29628-4-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629022838.29628-4-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 07:28:38PM -0700, Krishna Reddy wrote:
> Add global/context fault hooks to allow NVIDIA SMMU implementation
> handle faults across multiple SMMUs.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

> +static irqreturn_t nvidia_smmu_global_fault_inst(int irq,
> +					       struct arm_smmu_device *smmu,
> +					       int inst)
> +{
> +	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
> +	void __iomem *gr0_base = nvidia_smmu_page(smmu, inst, 0);
> +
> +	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
> +	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
> +	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
> +	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
> +
> +	if (!gfsr)
> +		return IRQ_NONE;

Could move this before gfsynr readings to save some readl() for
!gfsr cases?

> +static irqreturn_t nvidia_smmu_context_fault_bank(int irq,

> +	void __iomem *cb_base = nvidia_smmu_page(smmu, inst, smmu->numpage + idx);
[...]
> +	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
[...]
> +	writel_relaxed(fsr, cb_base + ARM_SMMU_CB_FSR);

It reads FSR of the default inst (1st), but clears the FSR of
corresponding inst -- just want to make sure that this is okay
and intended.

> @@ -185,7 +283,8 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
>  	}
>  
>  	nvidia_smmu->smmu.impl = &nvidia_smmu_impl;
> -	/* Free the arm_smmu_device struct allocated in arm-smmu.c.
> +	/*
> +	 * Free the arm_smmu_device struct allocated in arm-smmu.c.
>  	 * Once this function returns, arm-smmu.c would use arm_smmu_device
>  	 * allocated as part of nvidia_smmu struct.
>  	 */

Hmm, this coding style fix should be probably squashed into PATCH-1?

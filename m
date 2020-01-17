Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6430C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B73206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgAQKIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:08:32 -0500
Received: from 8bytes.org ([81.169.241.247]:60132 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgAQKIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:32 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 59032327; Fri, 17 Jan 2020 11:08:31 +0100 (CET)
Date:   Fri, 17 Jan 2020 11:08:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
Message-ID: <20200117100829.GE15760@8bytes.org>
References: <20200114151220.29578-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114151220.29578-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Suravee, who wrote the IOMMU Perf Counter code.

On Tue, Jan 14, 2020 at 08:12:20AM -0700, Shuah Khan wrote:
> init_iommu_perf_ctr() clobbers the register when it checks write access
> to IOMMU perf counters and fails to restore when they are writable.
> 
> Add save and restore to fix it.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/iommu/amd_iommu_init.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Suravee, can you please review this patch?

> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 568c52317757..c0ad4f293522 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1655,27 +1655,37 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
>  static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>  {
>  	struct pci_dev *pdev = iommu->dev;
> -	u64 val = 0xabcd, val2 = 0;
> +	u64 val = 0xabcd, val2 = 0, save_reg = 0;
>  
>  	if (!iommu_feature(iommu, FEATURE_PC))
>  		return;
>  
>  	amd_iommu_pc_present = true;
>  
> +	/* save the value to restore, if writable */
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
> +		goto pc_false;
> +
>  	/* Check if the performance counters can be written to */
>  	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
>  	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
> -	    (val != val2)) {
> -		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
> -		amd_iommu_pc_present = false;
> -		return;
> -	}
> +	    (val != val2))
> +		goto pc_false;
> +
> +	/* restore */
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
> +		goto pc_false;
>  
>  	pci_info(pdev, "IOMMU performance counters supported\n");
>  
>  	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
>  	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
>  	iommu->max_counters = (u8) ((val >> 7) & 0xf);
> +
> +pc_false:
> +	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
> +	amd_iommu_pc_present = false;
> +	return;
>  }
>  
>  static ssize_t amd_iommu_show_cap(struct device *dev,
> -- 
> 2.20.1

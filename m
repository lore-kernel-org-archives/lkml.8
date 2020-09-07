Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349BBC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0177E20738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgIGKoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:44:54 -0400
Received: from 8bytes.org ([81.169.241.247]:41444 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgIGKog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:44:36 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BF8CA34A; Mon,  7 Sep 2020 12:44:33 +0200 (CEST)
Date:   Mon, 7 Sep 2020 12:44:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "jroedel@suse.de" <jroedel@suse.de>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Message-ID: <20200907104431.GH16609@8bytes.org>
References: <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
 <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828152943.GY3354@suse.de>
 <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200904100556.GU6714@8bytes.org>
 <MN2PR12MB448843EC6D3D5B71613BEAAFF72B0@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB448843EC6D3D5B71613BEAAFF72B0@MN2PR12MB4488.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 04:08:58PM +0000, Deucher, Alexander wrote:
> From f479b9da353c2547c26ebac8930a5dcd9a134eb7 Mon Sep 17 00:00:00 2001
> From: Alex Deucher <alexander.deucher@amd.com>
> Date: Sun, 6 Sep 2020 12:05:12 -0400
> Subject: [PATCH] drm/amdgpu: Fail to load on RAVEN if SME is active
> 
> Due to hardware bugs, scatter/gather display on raven requires
> a 1:1 IOMMU mapping, however, SME (System Memory Encryption)
> requires an indirect IOMMU mapping because the encryption bit
> is beyond the DMA mask of the chip.  As such, the two are
> incompatible.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 12e16445df7c..d87d37c25329 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1102,6 +1102,16 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  		return -ENODEV;
>  	}
>  
> +	/* Due to hardware bugs, S/G Display on raven requires a 1:1 IOMMU mapping,
> +	 * however, SME requires an indirect IOMMU mapping because the encryption
> +	 * bit is beyond the DMA mask of the chip.
> +	 */
> +	if (mem_encrypt_active() && ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
> +		dev_info(&pdev->dev,
> +			 "SME is not compatible with RAVEN\n");
> +		return -ENOTSUPP;
> +	}
> +
>  #ifdef CONFIG_DRM_AMDGPU_SI
>  	if (!amdgpu_si_support) {
>  		switch (flags & AMD_ASIC_MASK) {
> -- 
> 2.25.4
>

Looks good to me, thanks.

Acked-by: Joerg Roedel <jroedel@suse.de>

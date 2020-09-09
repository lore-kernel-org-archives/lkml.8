Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D35BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051B221D92
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgIIMds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:33:48 -0400
Received: from foss.arm.com ([217.140.110.172]:42352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgIIMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:24:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A431045;
        Wed,  9 Sep 2020 05:23:39 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CE083F68F;
        Wed,  9 Sep 2020 05:23:38 -0700 (PDT)
Subject: Re: [PATCH 2/5] drm/panfrost: add support specifying pgtbl quirks
To:     Neil Armstrong <narmstrong@baylibre.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200908151853.4837-1-narmstrong@baylibre.com>
 <20200908151853.4837-3-narmstrong@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2c9bc126-d191-c24a-c745-d69ea1d16d1e@arm.com>
Date:   Wed, 9 Sep 2020 13:23:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908151853.4837-3-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2020 16:18, Neil Armstrong wrote:
> Add a pgtbl_quirks entry in the compatible specific table to permit specyfying IOMMU
> quirks for platforms.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_device.h | 3 +++
>   drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 953f7536a773..2cf1a6a13af8 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -70,6 +70,9 @@ struct panfrost_compatible {
>   	int num_pm_domains;
>   	/* Only required if num_pm_domains > 1. */
>   	const char * const *pm_domain_names;
> +
> +	/* IOMMU quirks flags */
> +	unsigned long pgtbl_quirks;
>   };
>   
>   struct panfrost_device {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index e8f7b11352d2..55a846c70e46 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -368,6 +368,7 @@ int panfrost_mmu_pgtable_alloc(struct panfrost_file_priv *priv)
>   	mmu->as = -1;
>   
>   	mmu->pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.quirks = pfdev->comp ? pfdev->comp->pgtbl_quirks : 0,
>   		.pgsize_bitmap	= SZ_4K | SZ_2M,
>   		.ias		= FIELD_GET(0xff, pfdev->features.mmu_features),
>   		.oas		= FIELD_GET(0xff00, pfdev->features.mmu_features),
> 


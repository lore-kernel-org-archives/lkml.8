Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D801C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369DE2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID/e03+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgG0Nml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgG0Nmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:42:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4DC061794;
        Mon, 27 Jul 2020 06:42:40 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a8so12172581edy.1;
        Mon, 27 Jul 2020 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r5UgUYmGIu8dXLKxxEsnpe0wyvxQ3PiGThgV1hXOvFQ=;
        b=ID/e03+HVhMp8vhvRxAWcrJqeQDn0B0elBX4JgzNp19TqdRPpj0JAdi/gB71qgMKDg
         4zs/nX407YlE6kFur9vBNlLxC7jkSwZtXgiCd8aDcz8Yr+qF09IxcCzXzaxapbhlv3gb
         3t+nSiqVhTjec8RzhU3Z7PXqxtq1dOGRSkTtaLAjXxNMM/YpEXrG5AXcedxIPgvhHDdZ
         tQbfJSYoS9+SHbUQ9t2/jdCRXO+H1AuOUMxtgUQ401FmFWdgdoLWulNpKhKFUc2rkVwa
         w9M6e2dLQEHB2l/6aIqg5U9jaFgiQ58s7ukCDxCIlQGT/k213KvKlieMi2URT44kJ/m2
         /K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=r5UgUYmGIu8dXLKxxEsnpe0wyvxQ3PiGThgV1hXOvFQ=;
        b=qu5i2qOgQiKU3cuOWZqPxJkMN7Zyt8GwDTIFdoSniBbWdtjjGVRW/jxppEwibSoQjr
         wuS8eSyFnTPm/d0GwE6vJhnDGXbvL2YPMxbGos0aX7Tb5VBSf5/AW5ivjD58kO7jG6xx
         zEXGgWOMB0kMKTVymolPAIypUB1ljoucm8HAeH5FAlgsr3uQaa2CekNFNXMdHsgvcCh1
         ejVZ0vQWVmrabxm5tZXA8WeFMbH0n5MdrL0tp8MrhV431jhl3hJ4/k6ptL+BBbD5IW79
         tcrD3wx7rvJrZhXatK3HZLdbuoBdyAFX7lt7pyw59A1zuKD9fu+fl3nN/qWTRnwOJrhE
         vivw==
X-Gm-Message-State: AOAM531q4JxozX4akgjX9r1WoCWxWo3Fg5/4YO5XssERVzWBkP65yp4+
        4ypsbzzxn1zKaZOZ8WNF9ozkIn7l
X-Google-Smtp-Source: ABdhPJwZznYnW4z4lkEFxOLCLYaX5bd+Wte9m7+t5rV8Uu8lPzz5m3GiJZ1jVnXU0ape3kDfG59Mng==
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr20990077edb.260.1595857358906;
        Mon, 27 Jul 2020 06:42:38 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id n5sm6989547eja.70.2020.07.27.06.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 06:42:38 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/2] drm/radeon: switch from 'pci_' to 'dma_' API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200727103421.50739-1-christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <224fc7f6-f56b-1dc8-87f2-33ff85d5720d@gmail.com>
Date:   Mon, 27 Jul 2020 15:42:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727103421.50739-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.07.20 um 12:34 schrieb Christophe JAILLET:
> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> The patch has been generated with the coccinelle script below and has been
> hand modified to replace GFP_ with a correct flag.
> It has been compile tested.
>
> When memory is allocated in 'radeon_gart_table_ram_alloc()' GFP_KERNEL
> can be used because its callers already use this flag.
>
> Both 'r100_pci_gart_init()' (r100.c) and 'rs400_gart_init()' (rs400.c)
> call 'radeon_gart_init()'.
> This function uses 'vmalloc'.
>
>
> @@
> @@
> -    PCI_DMA_BIDIRECTIONAL
> +    DMA_BIDIRECTIONAL
>
> @@
> @@
> -    PCI_DMA_TODEVICE
> +    DMA_TO_DEVICE
>
> @@
> @@
> -    PCI_DMA_FROMDEVICE
> +    DMA_FROM_DEVICE
>
> @@
> @@
> -    PCI_DMA_NONE
> +    DMA_NONE
>
> @@
> expression e1, e2, e3;
> @@
> -    pci_alloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>
> @@
> expression e1, e2, e3;
> @@
> -    pci_zalloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_free_consistent(e1, e2, e3, e4)
> +    dma_free_coherent(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_single(e1, e2, e3, e4)
> +    dma_map_single(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_single(e1, e2, e3, e4)
> +    dma_unmap_single(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4, e5;
> @@
> -    pci_map_page(e1, e2, e3, e4, e5)
> +    dma_map_page(&e1->dev, e2, e3, e4, e5)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_page(e1, e2, e3, e4)
> +    dma_unmap_page(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_sg(e1, e2, e3, e4)
> +    dma_map_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_sg(e1, e2, e3, e4)
> +    dma_unmap_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
> +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
> +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
> +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
> +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2;
> @@
> -    pci_dma_mapping_error(e1, e2)
> +    dma_mapping_error(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>     https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>   drivers/gpu/drm/radeon/radeon_gart.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
> index f178ba321715..b7ce254e5663 100644
> --- a/drivers/gpu/drm/radeon/radeon_gart.c
> +++ b/drivers/gpu/drm/radeon/radeon_gart.c
> @@ -72,8 +72,8 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
>   {
>   	void *ptr;
>   
> -	ptr = pci_alloc_consistent(rdev->pdev, rdev->gart.table_size,
> -				   &rdev->gart.table_addr);
> +	ptr = dma_alloc_coherent(&rdev->pdev->dev, rdev->gart.table_size,
> +				 &rdev->gart.table_addr, GFP_KERNEL);
>   	if (ptr == NULL) {
>   		return -ENOMEM;
>   	}
> @@ -110,9 +110,8 @@ void radeon_gart_table_ram_free(struct radeon_device *rdev)
>   			      rdev->gart.table_size >> PAGE_SHIFT);
>   	}
>   #endif
> -	pci_free_consistent(rdev->pdev, rdev->gart.table_size,
> -			    (void *)rdev->gart.ptr,
> -			    rdev->gart.table_addr);
> +	dma_free_coherent(&rdev->pdev->dev, rdev->gart.table_size,
> +			  (void *)rdev->gart.ptr, rdev->gart.table_addr);
>   	rdev->gart.ptr = NULL;
>   	rdev->gart.table_addr = 0;
>   }


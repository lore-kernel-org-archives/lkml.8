Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C988C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6DA2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KnQ0XXlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGTH1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGTH1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:27:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0036C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:27:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so24112250wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bhwo7XtedxgO680QCApPkufZDGLDVkIrfASA3vSME98=;
        b=KnQ0XXlGMXIms2qzb4Z98253tPDTM28PDEhkizmnH+dcRJ7NkxEM8fEAY4mnorwZI6
         ta9yoa2xdBzD8Nqaehbz9uuv2nFZTnnYvLjV+6/DQKjsPrhE5iPGCI/n2+GCl5V5xBRA
         U+ONURY/664cWghXmUxsVSTWtmdshPqnZIhsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Bhwo7XtedxgO680QCApPkufZDGLDVkIrfASA3vSME98=;
        b=kfi6U5ReYhVONOMd+FAjJEzck0NLp/6enNS1vLUC6jCgSwnItPiwWcwSI8DFU/L0qo
         UF5raEhYe9MOoWuWKiZ+ABSMTYGBeKcagXzyBsiB8ffGWaQUcILxTJqCvC1/eL+0woMh
         cIe2UuEIxf7k+Ra40px6SHpfxtzyt62gnvR0IZA0KvI9UCOTF5l/dq9zuzhd6CvMmU/8
         GyV5FaOiZs1f+Se+JQUu/VMru3Lxd0zUt3bDCvPtpwc6vmGL4wkLM9ML4ifSFnF/DUgL
         JvhgvmU7e4gmrRsvFWbAkXe3TlT+AuRiIR65RyhHZfoZgF8hBdvD1SSzH0kYg4eBi9fr
         538g==
X-Gm-Message-State: AOAM533WkSiY1Rr1OvLfxlZphWIT6+yx5Q1KkywGx4MYHuqa9Kk6mqKt
        uW5SJOoff+fcgoQOHqkfNAWEIw==
X-Google-Smtp-Source: ABdhPJyI4WGGxHQ56OUuIoYvCXVBVwOM6TFIJ1ZhwGAeZ7exEvdOrnkxabsQBl2LMjC/IykBS+3RWQ==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr21445339wmi.83.1595230026550;
        Mon, 20 Jul 2020 00:27:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w128sm34493308wmb.19.2020.07.20.00.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:27:05 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:27:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/i810: switch from 'pci_' to 'dma_' API
Message-ID: <20200720072704.GT3278063@phenom.ffwll.local>
Mail-Followup-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200718072822.339064-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718072822.339064-1-christophe.jaillet@wanadoo.fr>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 09:28:22AM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below and has been
> hand modified to replace GFP_ with a correct flag.
> It has been compile tested.
> 
> When memory is allocated in 'i810_dma_initialize()' GFP_KERNEL can be used
> because its only caller, 'i810_dma_init()', already use it and no lock is
> taken in the between.
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

Applied to drm-misc-next. Since we're already past -rc6 I think it'll go
into 5.10.

Thanks, Daniel

> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/gpu/drm/i810/i810_dma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i810/i810_dma.c b/drivers/gpu/drm/i810/i810_dma.c
> index b88c3d5f92b4..303c2d483c6e 100644
> --- a/drivers/gpu/drm/i810/i810_dma.c
> +++ b/drivers/gpu/drm/i810/i810_dma.c
> @@ -220,9 +220,9 @@ static int i810_dma_cleanup(struct drm_device *dev)
>  		if (dev_priv->ring.virtual_start)
>  			drm_legacy_ioremapfree(&dev_priv->ring.map, dev);
>  		if (dev_priv->hw_status_page) {
> -			pci_free_consistent(dev->pdev, PAGE_SIZE,
> -					    dev_priv->hw_status_page,
> -					    dev_priv->dma_status_page);
> +			dma_free_coherent(&dev->pdev->dev, PAGE_SIZE,
> +					  dev_priv->hw_status_page,
> +					  dev_priv->dma_status_page);
>  		}
>  		kfree(dev->dev_private);
>  		dev->dev_private = NULL;
> @@ -398,8 +398,8 @@ static int i810_dma_initialize(struct drm_device *dev,
>  
>  	/* Program Hardware Status Page */
>  	dev_priv->hw_status_page =
> -		pci_zalloc_consistent(dev->pdev, PAGE_SIZE,
> -				      &dev_priv->dma_status_page);
> +		dma_alloc_coherent(&dev->pdev->dev, PAGE_SIZE,
> +				   &dev_priv->dma_status_page, GFP_KERNEL);
>  	if (!dev_priv->hw_status_page) {
>  		dev->dev_private = (void *)dev_priv;
>  		i810_dma_cleanup(dev);
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF3C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6382122CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595489671;
	bh=fq/y8fy9KB21ZIcl+5aIC24YNyJaRTHktG/pXRSusgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QIkqIXWOPSl1ONoctDxCkeTiX2vQv/aEQgAG68bS1WVM0RpQSGWiSNyOFc1slzGse
	 VMCiOtKroHWKdPifafKrwCcYi7jMZnovU59CZwY56DKflU9kKPYNXNhZa97Z3DC0nM
	 TeHLVWbhp0F4m/ewe5gXw/ZsAGhFCxzfor2obvug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGWHea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGWHe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:34:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA7E22CAF;
        Thu, 23 Jul 2020 07:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595489668;
        bh=fq/y8fy9KB21ZIcl+5aIC24YNyJaRTHktG/pXRSusgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMqz+F8rOIRpScwesuNN6yMvHEEeE2OUjg6CvplhyPNQDtg5xvrxdn9DVtaiEIpuf
         dftfY8Cfd0H2NJBUnm5u3XdlkqFzKsNkKOcV9LfowTUlCuCy8agEqnbL9wF27B3qfc
         F6zEj9agxPcpHxQv/CGm7EAWr/3bMrk/WlLVR9ww=
Date:   Thu, 23 Jul 2020 09:34:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: hpilo: switch from 'pci_' to 'dma_' API
Message-ID: <20200723073433.GA1273491@kroah.com>
References: <20200718070224.337964-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718070224.337964-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 09:02:24AM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below and has been
> hand modified to replace GFP_ with a correct flag.
> It has been compile tested.
> 
> When memory is allocated in 'ilo_ccb_setup()' GFP_ATOMIC must be used
> because a spin_lock is hold in 'ilo_open()' before calling
> 'ilo_ccb_setup()'
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
> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/misc/hpilo.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> index 10c975662f8b..c9539c89a925 100644
> --- a/drivers/misc/hpilo.c
> +++ b/drivers/misc/hpilo.c
> @@ -256,7 +256,8 @@ static void ilo_ccb_close(struct pci_dev *pdev, struct ccb_data *data)
>  	memset_io(device_ccb, 0, sizeof(struct ccb));
>  
>  	/* free resources used to back send/recv queues */
> -	pci_free_consistent(pdev, data->dma_size, data->dma_va, data->dma_pa);
> +	dma_free_coherent(&pdev->dev, data->dma_size, data->dma_va,
> +			  data->dma_pa);
>  }
>  
>  static int ilo_ccb_setup(struct ilo_hwinfo *hw, struct ccb_data *data, int slot)
> @@ -272,8 +273,8 @@ static int ilo_ccb_setup(struct ilo_hwinfo *hw, struct ccb_data *data, int slot)
>  			 2 * desc_mem_sz(NR_QENTRY) +
>  			 ILO_START_ALIGN + ILO_CACHE_SZ;
>  
> -	data->dma_va = pci_alloc_consistent(hw->ilo_dev, data->dma_size,
> -					    &data->dma_pa);
> +	data->dma_va = dma_alloc_coherent(&hw->ilo_dev->dev, data->dma_size,
> +					  &data->dma_pa, GFP_ATOMIC);

This is being called from open() so it can be GFP_KERNEL.  Can you fix
that up and resend a new version?

thanks,

greg k-h

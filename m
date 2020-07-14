Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22539C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B6D217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="dauVLxOA";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="DVOIyhso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGNKGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:06:46 -0400
Received: from smtp104.ord1d.emailsrvr.com ([184.106.54.104]:52047 "EHLO
        smtp104.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgGNKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:06:46 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2020 06:06:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1594720615;
        bh=/+UlnFraBXeWBpY49tUc6AX489lG5XkgFdMfCiG/X6c=;
        h=Subject:To:From:Date:From;
        b=dauVLxOAZG1A+phbdkYOg78f4/RR5/nEjvVm2wlRgjz3G6kg7G045kmqE2owdHj0D
         slckOfRMPTz56nwilnPFWlQCUh6ew4CQn5sykceGtxUmMDXgfUc2Cl+ZfkEovFVHtK
         pH0pOT/+WdqN/hUvCamGKaaP3g+hwL7uFMqgPHsE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1594720615;
        bh=/+UlnFraBXeWBpY49tUc6AX489lG5XkgFdMfCiG/X6c=;
        h=Subject:To:From:Date:From;
        b=DVOIyhsoXyiUxlrZ0ClClowuYtkQZjI4sZjyWS1elFPaK+44iN2rrz1hzRV9iCv6H
         jrLicK3ihpVx1I/9JcS5X46bFa3JlxK6SKUTR+j6k6ynk7VqOVTqk1FfL8x53BNBJV
         N4y0erHghKrz5+AtYXh2mvl2ace+jLIfgb4Pw0QQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BCC59E00B0;
        Tue, 14 Jul 2020 05:56:54 -0400 (EDT)
Subject: Re: [PATCH v2] staging: comedi: s626: Remove pci-dma-compat wrapper
 APIs.
To:     Suraj Upadhyay <usuraj35@gmail.com>, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
References: <20200713143253.GA14953@blackclown>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <5c137548-9c64-1aa5-bd31-e84e42fcc5a2@mev.co.uk>
Date:   Tue, 14 Jul 2020 10:56:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713143253.GA14953@blackclown>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 8a350055-a3ab-4065-96a7-ca23740e4d13-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2020 15:32, Suraj Upadhyay wrote:
> The legacy API wrappers in include/linux/pci-dma-compat.h
> should go away as it creates unnecessary midlayering
> for include/linux/dma-mapping.h APIs, instead use dma-mapping.h
> APIs directly.
> 
> The patch has been generated with the coccinelle script below
> and compile-tested.
> 
> @@@@
> - PCI_DMA_BIDIRECTIONAL
> + DMA_BIDIRECTIONAL
> 
> @@@@
> - PCI_DMA_TODEVICE
> + DMA_TO_DEVICE
> 
> @@@@
> - PCI_DMA_FROMDEVICE
> + DMA_FROM_DEVICE
> 
> @@@@
> - PCI_DMA_NONE
> + DMA_NONE
> 
> @@ expression E1, E2, E3; @@
> - pci_alloc_consistent(E1, E2, E3)
> + dma_alloc_coherent(&E1->dev, E2, E3, GFP_ATOMIC)
> 
> @@ expression E1, E2, E3; @@
> - pci_zalloc_consistent(E1, E2, E3)
> + dma_alloc_coherent(&E1->dev, E2, E3, GFP_ATOMIC)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_free_consistent(E1, E2, E3, E4)
> + dma_free_coherent(&E1->dev, E2, E3, E4)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_map_single(E1, E2, E3, E4)
> + dma_map_single(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_unmap_single(E1, E2, E3, E4)
> + dma_unmap_single(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2, E3, E4, E5; @@
> - pci_map_page(E1, E2, E3, E4, E5)
> + dma_map_page(&E1->dev, E2, E3, E4, (enum dma_data_direction)E5)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_unmap_page(E1, E2, E3, E4)
> + dma_unmap_page(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_map_sg(E1, E2, E3, E4)
> + dma_map_sg(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_unmap_sg(E1, E2, E3, E4)
> + dma_unmap_sg(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_dma_sync_single_for_cpu(E1, E2, E3, E4)
> + dma_sync_single_for_cpu(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_dma_sync_single_for_device(E1, E2, E3, E4)
> + dma_sync_single_for_device(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_dma_sync_sg_for_cpu(E1, E2, E3, E4)
> + dma_sync_sg_for_cpu(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2, E3, E4; @@
> - pci_dma_sync_sg_for_device(E1, E2, E3, E4)
> + dma_sync_sg_for_device(&E1->dev, E2, E3, (enum dma_data_direction)E4)
> 
> @@ expression E1, E2; @@
> - pci_dma_mapping_error(E1, E2)
> + dma_mapping_error(&E1->dev, E2)
> 
> @@ expression E1, E2; @@
> - pci_set_consistent_dma_mask(E1, E2)
> + dma_set_coherent_mask(&E1->dev, E2)
> 
> @@ expression E1, E2; @@
> - pci_set_dma_mask(E1, E2)
> + dma_set_mask(&E1->dev, E2)
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
> Changes:
> 	v2: Converted the GFP_ATOMIC flag to GFP_KERNEL to suit for the
> 	context. On reviewer's advise.
> 
>   drivers/staging/comedi/drivers/s626.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/s626.c b/drivers/staging/comedi/drivers/s626.c
> index 084a8e7b9fc2..e7aba937d896 100644
> --- a/drivers/staging/comedi/drivers/s626.c
> +++ b/drivers/staging/comedi/drivers/s626.c
> @@ -2130,13 +2130,15 @@ static int s626_allocate_dma_buffers(struct comedi_device *dev)
>   	void *addr;
>   	dma_addr_t appdma;
>   
> -	addr = pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
> +	addr = dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
> +				  GFP_KERNEL);
>   	if (!addr)
>   		return -ENOMEM;
>   	devpriv->ana_buf.logical_base = addr;
>   	devpriv->ana_buf.physical_base = appdma;
>   
> -	addr = pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
> +	addr = dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
> +				  GFP_KERNEL);
>   	if (!addr)
>   		return -ENOMEM;
>   	devpriv->rps_buf.logical_base = addr;
> @@ -2154,13 +2156,13 @@ static void s626_free_dma_buffers(struct comedi_device *dev)
>   		return;
>   
>   	if (devpriv->rps_buf.logical_base)
> -		pci_free_consistent(pcidev, S626_DMABUF_SIZE,
> -				    devpriv->rps_buf.logical_base,
> -				    devpriv->rps_buf.physical_base);
> +		dma_free_coherent(&pcidev->dev, S626_DMABUF_SIZE,
> +				  devpriv->rps_buf.logical_base,
> +				  devpriv->rps_buf.physical_base);
>   	if (devpriv->ana_buf.logical_base)
> -		pci_free_consistent(pcidev, S626_DMABUF_SIZE,
> -				    devpriv->ana_buf.logical_base,
> -				    devpriv->ana_buf.physical_base);
> +		dma_free_coherent(&pcidev->dev, S626_DMABUF_SIZE,
> +				  devpriv->ana_buf.logical_base,
> +				  devpriv->ana_buf.physical_base);
>   }
>   
>   static int s626_initialize(struct comedi_device *dev)
> 

Looks good to me.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-

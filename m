Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CEFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2AA20725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgGKNim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:38:42 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:42743 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgGKNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:38:42 -0400
Received: from [192.168.42.210] ([93.22.151.150])
        by mwinf5d84 with ME
        id 1ped2300E3Ewh7h03pedBR; Sat, 11 Jul 2020 15:38:39 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Jul 2020 15:38:39 +0200
X-ME-IP: 93.22.151.150
Subject: Re: [PATCH] staging: comedi: s626: Remove pci-dma-compat wrapper
 APIs.
To:     Suraj Upadhyay <usuraj35@gmail.com>, gregkh@linuxfoundation.org,
        abbotti@mev.co.uk, hsweeten@visionengravers.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
References: <20200711123533.GA15038@blackclown>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <6f701731-d0af-1bd5-5854-42f0ba39ed35@wanadoo.fr>
Date:   Sat, 11 Jul 2020 15:38:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200711123533.GA15038@blackclown>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/07/2020 à 14:35, Suraj Upadhyay a écrit :
> The legacy API wrappers in include/linux/pci-dma-compat.h
> should go away as it creates unnecessary midlayering
> for include/linux/dma-mapping.h APIs, instead use dma-mapping.h
> APIs directly.
>
> The patch has been generated with the coccinelle script below
> and compile-tested.
>
> [...]
> @@ expression E1, E2, E3; @@
> - pci_alloc_consistent(E1, E2, E3)
> + dma_alloc_coherent(&E1->dev, E2, E3, GFP_ATOMIC)
>
> @@ expression E1, E2, E3; @@
> - pci_zalloc_consistent(E1, E2, E3)
> + dma_alloc_coherent(&E1->dev, E2, E3, GFP_ATOMIC)

This is the tricky part of this kind of cleanup, see below.

GFP_ATOMIC can't be wrong because it is was exactly what was done with 
the pci_ function.
However, most of the time, it can safely be replaced by GFP_KERNEL which 
gives more opportunities to the memory allocator.

> [...]
> diff --git a/drivers/staging/comedi/drivers/s626.c b/drivers/staging/comedi/drivers/s626.c
> index 084a8e7b9fc2..c159416662fd 100644
> --- a/drivers/staging/comedi/drivers/s626.c
> +++ b/drivers/staging/comedi/drivers/s626.c
> @@ -2130,13 +2130,15 @@ static int s626_allocate_dma_buffers(struct comedi_device *dev)
>   	void *addr;
>   	dma_addr_t appdma;
>   
> -	addr = pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
> +	addr = dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
> +				  GFP_ATOMIC);
>   	if (!addr)
>   		return -ENOMEM;
>   	devpriv->ana_buf.logical_base = addr;
>   	devpriv->ana_buf.physical_base = appdma;
>   
> -	addr = pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
> +	addr = dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
> +				  GFP_ATOMIC);
>   	if (!addr)
>   		return -ENOMEM;
>   	devpriv->rps_buf.logical_base = addr;
's626_allocate_dma_buffers()' is only called from 's626_auto_attach()'.
In this function, around the call to 's626_allocate_dma_buffers()', you 
can see:
   - a few lines before, a call to 'comedi_alloc_devpriv()'

   - a few lines after, a call to 'comedi_alloc_subdevices()'

These 2 functions make some memory allocation using GFP_KERNEL.

So it is likely that using GFP_KERNEL in your proposal is also valid.


Just my 2c.

CJ


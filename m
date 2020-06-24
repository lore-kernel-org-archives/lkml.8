Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D459BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF68120823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRKzCEB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404851AbgFXQU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404748AbgFXQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:20:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F9C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:20:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so1254381ply.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wYBvUfi2A+ioRIdIU5MH+/mg58TfJOgAJmMFcgk5hp0=;
        b=eRKzCEB2rU6Cuma3uKKecAKmdD5CrUoDIMByA1ykI0K2Rb3+ZdEtXH+WxbLSK08db2
         OWGIDVKzncS4rqKyhOtVUldl7SuNjy5CBuRtLqdiQznaKrshDS5AiPcGugPUadvCKxNc
         HtyAVydJb0LMV4Vz2ZYJEfwRH+RDSsZVyq6bTpEvjvObH+8BAKLY9ATh6bChhOyycYue
         cRSiVbfRmJR1Qw0DsqHvV2P7Yl0wJMb31epmZexrqXLOAmBj63DpCYfvR9TjRXyjucHl
         DKztLwYjlBgixAvo3YB0t0Yq9Vs+o8H0u58ypN1R02dUM+B3XiEWA/JXjmER8ltPceBm
         uJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wYBvUfi2A+ioRIdIU5MH+/mg58TfJOgAJmMFcgk5hp0=;
        b=UI37lmSnf134bUhBkbxtsUZPxxXI8gx9ptg/c/EkiNHUhWmlWnF5iPpI7ryI2Hv5Ry
         B0YOye7NkkgLuoABxYUvFA5oPFMkWxp4Y9E40nGXC4ozFHtIVQa0OkxyvLFdPDhog6zT
         dfpwyuZ6uubP+KU5y+/q8+VEcIrk6No52rZYPERaZhTz8OiPMs+gTnkLUMcHSRW8LMdY
         t2P3Toi8DjaajeVNWhllzsUqdq2EDCQ4TL8gfVbqitbnBXBHO6G4vZ39a//DO/QNvhwc
         3Tzos0aE7kuODFB94ML4Ea0TDBlSEFZvEc88jJ33pBk830ERm8Tz1DPUi9EOPxmDuHS3
         Xphg==
X-Gm-Message-State: AOAM530y9Wf1ngIeF4zbQYzePFBySoIGr7b33GVdgrtTct5Fgm/iMocL
        vq1u9txKFrk9PkCPIVDvftU=
X-Google-Smtp-Source: ABdhPJwtWbxHDZMZnThJDNH2knyPkYVioW+IORCS4FHACy4BZg7jbFn82M7itshG5xTU7om/ViF2Pg==
X-Received: by 2002:a17:90a:e08f:: with SMTP id q15mr31074376pjy.178.1593015652518;
        Wed, 24 Jun 2020 09:20:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7sm7283263pgh.80.2020.06.24.09.20.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 09:20:51 -0700 (PDT)
Date:   Wed, 24 Jun 2020 09:20:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Message-ID: <20200624162050.GA214193@roeck-us.net>
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net>
 <20200624073815.GE18609@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624073815.GE18609@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:38:15AM +0200, Christoph Hellwig wrote:
> Hi Guenter,
> 
> can you try the patch below?  This just converts the huge allocations
> in mptbase to use GFP_KERNEL.  Christophe (added to Cc) actually has
> a scripted conversion for the rest that he hasn't posted yet, so I'll
> aim for the minimal version here.
> 

The previously failing test passes with this patch applied on top of the
mainline kernel.

Guenter

> 
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> index 68aea22f2b8978..5216487db4fbea 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -1324,13 +1324,13 @@ mpt_host_page_alloc(MPT_ADAPTER *ioc, pIOCInit_t ioc_init)
>  			return 0; /* fw doesn't need any host buffers */
>  
>  		/* spin till we get enough memory */
> -		while(host_page_buffer_sz > 0) {
> -
> -			if((ioc->HostPageBuffer = pci_alloc_consistent(
> -			    ioc->pcidev,
> -			    host_page_buffer_sz,
> -			    &ioc->HostPageBuffer_dma)) != NULL) {
> -
> +		while (host_page_buffer_sz > 0) {
> +			ioc->HostPageBuffer =
> +				dma_alloc_coherent(&ioc->pcidev->dev,
> +						host_page_buffer_sz,
> +						&ioc->HostPageBuffer_dma,
> +						GFP_KERNEL);
> +			if (ioc->HostPageBuffer) {
>  				dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT
>  				    "host_page_buffer @ %p, dma @ %x, sz=%d bytes\n",
>  				    ioc->name, ioc->HostPageBuffer,
> @@ -2741,8 +2741,8 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
>  		sz = ioc->alloc_sz;
>  		dexitprintk(ioc, printk(MYIOC_s_INFO_FMT "free  @ %p, sz=%d bytes\n",
>  		    ioc->name, ioc->alloc, ioc->alloc_sz));
> -		pci_free_consistent(ioc->pcidev, sz,
> -				ioc->alloc, ioc->alloc_dma);
> +		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->alloc,
> +				ioc->alloc_dma);
>  		ioc->reply_frames = NULL;
>  		ioc->req_frames = NULL;
>  		ioc->alloc = NULL;
> @@ -2751,8 +2751,8 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
>  
>  	if (ioc->sense_buf_pool != NULL) {
>  		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
> -		pci_free_consistent(ioc->pcidev, sz,
> -				ioc->sense_buf_pool, ioc->sense_buf_pool_dma);
> +		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->sense_buf_pool,
> +				ioc->sense_buf_pool_dma);
>  		ioc->sense_buf_pool = NULL;
>  		ioc->alloc_total -= sz;
>  	}
> @@ -2802,7 +2802,7 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
>  			"HostPageBuffer free  @ %p, sz=%d bytes\n",
>  			ioc->name, ioc->HostPageBuffer,
>  			ioc->HostPageBuffer_sz));
> -		pci_free_consistent(ioc->pcidev, ioc->HostPageBuffer_sz,
> +		dma_free_coherent(&ioc->pcidev->dev, ioc->HostPageBuffer_sz,
>  		    ioc->HostPageBuffer, ioc->HostPageBuffer_dma);
>  		ioc->HostPageBuffer = NULL;
>  		ioc->HostPageBuffer_sz = 0;
> @@ -4497,7 +4497,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
>  			 	ioc->name, sz, sz, num_chain));
>  
>  		total_size += sz;
> -		mem = pci_alloc_consistent(ioc->pcidev, total_size, &alloc_dma);
> +		mem = dma_alloc_coherent(&ioc->pcidev->dev, total_size,
> +				&alloc_dma, GFP_KERNEL);
>  		if (mem == NULL) {
>  			printk(MYIOC_s_ERR_FMT "Unable to allocate Reply, Request, Chain Buffers!\n",
>  				ioc->name);
> @@ -4574,8 +4575,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
>  		spin_unlock_irqrestore(&ioc->FreeQlock, flags);
>  
>  		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
> -		ioc->sense_buf_pool =
> -			pci_alloc_consistent(ioc->pcidev, sz, &ioc->sense_buf_pool_dma);
> +		ioc->sense_buf_pool = dma_alloc_coherent(&ioc->pcidev->dev, sz,
> +				&ioc->sense_buf_pool_dma, GFP_KERNEL);
>  		if (ioc->sense_buf_pool == NULL) {
>  			printk(MYIOC_s_ERR_FMT "Unable to allocate Sense Buffers!\n",
>  				ioc->name);
> @@ -4613,18 +4614,16 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
>  
>  	if (ioc->alloc != NULL) {
>  		sz = ioc->alloc_sz;
> -		pci_free_consistent(ioc->pcidev,
> -				sz,
> -				ioc->alloc, ioc->alloc_dma);
> +		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->alloc,
> +				ioc->alloc_dma);
>  		ioc->reply_frames = NULL;
>  		ioc->req_frames = NULL;
>  		ioc->alloc_total -= sz;
>  	}
>  	if (ioc->sense_buf_pool != NULL) {
>  		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
> -		pci_free_consistent(ioc->pcidev,
> -				sz,
> -				ioc->sense_buf_pool, ioc->sense_buf_pool_dma);
> +		dma_free_coherent(&ioc->pcidev->dev, sz, ioc->sense_buf_pool,
> +				ioc->sense_buf_pool_dma);
>  		ioc->sense_buf_pool = NULL;
>  	}
>  

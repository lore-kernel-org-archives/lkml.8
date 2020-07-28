Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA4C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB8E20759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595916344;
	bh=wUcRh1alC1nmJdjxU/quIxyAxC+5YyHs0Sj2210Arn0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=UTH2/SeRO1tnraclz9EzTQIaT+jTe0pcVaiXuy/2Svp6pr8LHydFwqvfo8Y6T7lfq
	 pgVP1hmuDQpUENCRdUBabDMNP0qAMM3UzG//yWLL8xnq0a6p+UxSIOx8O/MZk/H5fl
	 cm1HTAXannnYPvttMPzfGzOcRnsYI7xLdv8wRyks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgG1GFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:05:42 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40778 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG1GFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:05:42 -0400
Received: by mail-ej1-f68.google.com with SMTP id o18so19401099eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b4IbY9WUyckchLHsneUtoMbWbn+o5rLWzdBmrGROULY=;
        b=BG+33hyFYo2mqZ4Drt4rk2LpoZpmv2mBmYb7QSE0iBNJ6skG7P1rTIRoLOEFlHcFZb
         Th2r40hyZkN3fBUOwieYrvTdiq/aRP8gR0MQ5MUzP4K8TAIY7WcswAXNJmGzpK34Datv
         qAB4vlLUg0m7mJ1U/cWKedo3+usYq/AkaUZJ18/zVdNctjfoBKP5z64/UxphvQGlC0Cw
         z08EzxD5g5FhXc8I+A2Q1NLgxVTbanWlQzcDm5TY1CJD6GUewTAqMz5QW//ibV4iktA2
         psCfs70GY20SDJTj9ZuHopXZTQIIUs4kks41yi180RkE36u+ptysSMrO5s99OZIiSWX3
         m0Cw==
X-Gm-Message-State: AOAM530ooaMcieC/HRW4uecmb2j9IcJePvqWxxSo7sd8B2HES0yAD2O/
        hbgilHnNjHo6Tl4ZYXfZvqzv390i
X-Google-Smtp-Source: ABdhPJxEzM2UngoUfb1xAA3sdiwe32+/omIzoWBV376Jycyk4uTR7yNdWtrf0TeqLh1C/J3xoHSG/g==
X-Received: by 2002:a17:906:8417:: with SMTP id n23mr23554813ejx.192.1595916337919;
        Mon, 27 Jul 2020 23:05:37 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id i8sm9018291edt.19.2020.07.27.23.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 23:05:37 -0700 (PDT)
Subject: Re: [PATCH] tty/synclink: remove leftover bits of non-PCI card
 support
To:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20200727130501.31005-1-hch@lst.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8a015ca4-e837-8fa5-684c-46fca8104ea5@kernel.org>
Date:   Tue, 28 Jul 2020 08:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727130501.31005-1-hch@lst.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 07. 20, 15:05, Christoph Hellwig wrote:
> Since commit 1355cba9c3ba ("tty/synclink: remove ISA support"), the
> synlink driver only supports PCI card.  Remove any leftover dead code
> to support other cards.

So now you can remove also the defines and bus_type completely:
$ git grep -E 'MGSL_BUS_TYPE_(E?ISA|PCI)'
drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;
include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_ISA 1
include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_EISA        2
include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_PCI 5

$ git grep -w bus_type drivers/tty/synclink*
drivers/tty/synclink_gt.c:      unsigned int bus_type;
drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
drivers/tty/synclinkmp.c:       unsigned int bus_type;
/* expansion bus type (ISA,EISA,PCI) */
drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;

> --- a/drivers/tty/synclink.c
> +++ b/drivers/tty/synclink.c
...
> @@ -4040,58 +3977,40 @@ static int mgsl_claim_resources(struct mgsl_struct *info)
...
> -	} else {
> -		/* claim DMA channel */
> +	if ( !mgsl_memory_test(info) ) {
> +		printk( "%s(%d):Failed shared memory test %s MemAddr=%08X\n",
> +			__FILE__,__LINE__,info->device_name, info->phys_memory_base );
> +		goto errout;
> +	}
>  		
> -		if (request_dma(info->dma_level,info->device_name) < 0){
> -			printk( "%s(%d):Can't request DMA channel on device %s DMA=%d\n",
> -				__FILE__,__LINE__,info->device_name, info->dma_level );
> -			goto errout;
> -		}
> -		info->dma_requested = true;
> -
> -		/* ISA adapter uses bus master DMA */		
> -		set_dma_mode(info->dma_level,DMA_MODE_CASCADE);
> -		enable_dma(info->dma_level);
> +	info->lcr_base = ioremap(info->phys_lcr_base, PAGE_SIZE);
> +	if (!info->lcr_base) {
> +		printk( "%s(%d):Can't map LCR memory on device %s MemAddr=%08X\n",
> +			__FILE__,__LINE__,info->device_name, info->phys_lcr_base );
> +		goto errout;
>  	}
> -	
> +	info->lcr_base += info->lcr_offset;
> +		

Could you fix up the whitespace git show warns about (git show outputs
red background, if you use colors). Like this one? It looks like you
added one more \t on an empty line here.

>  	if ( mgsl_allocate_dma_buffers(info) < 0 ) {
>  		printk( "%s(%d):Can't allocate DMA buffers on device %s DMA=%d\n",
>  			__FILE__,__LINE__,info->device_name, info->dma_level );
> @@ -4200,16 +4119,10 @@ static void mgsl_add_device( struct mgsl_struct *info )
>  	else if ( info->max_frame_size > 65535 )
>  		info->max_frame_size = 65535;
>  	
> -	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
> -		printk( "SyncLink PCI v%d %s: IO=%04X IRQ=%d Mem=%08X,%08X MaxFrameSize=%u\n",
> -			info->hw_version + 1, info->device_name, info->io_base, info->irq_level,
> -			info->phys_memory_base, info->phys_lcr_base,
> -		     	info->max_frame_size );
> -	} else {
> -		printk( "SyncLink ISA %s: IO=%04X IRQ=%d DMA=%d MaxFrameSize=%u\n",
> -			info->device_name, info->io_base, info->irq_level, info->dma_level,
> -		     	info->max_frame_size );
> -	}
> +	printk( "SyncLink PCI v%d %s: IO=%04X IRQ=%d Mem=%08X,%08X MaxFrameSize=%u\n",
> +		info->hw_version + 1, info->device_name, info->io_base, info->irq_level,
> +		info->phys_memory_base, info->phys_lcr_base,
> +	     	info->max_frame_size );

Or here, there is \t, 4 spaces and \t again.

thanks,
-- 
js

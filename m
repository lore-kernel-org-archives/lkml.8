Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AE5C47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8BA20752
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seY8O0PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgEFCib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgEFCib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:38:31 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 19:38:30 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c124so200880oib.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j7wFQAej6fSwbScLFcHGQ/mYv2AH2O4tGHNnw9sXpTw=;
        b=seY8O0POHGfuH4/v0E+MvvBGOlBNe3TSs+pon6lutFfFTJyH7NM7SGGAHRo3CNqEYM
         DT+oKAAQE447xpE4KJqfqKJkxcrh/EOf5wOV6/1ZQ6UEo7EvRQ31W3kSOtrjjrlZEL49
         TPC4IKEg4p8N6gGtNM5mSle6xWvPSe1VNs8TKbzvVT1+31a5Rt1ec5fcP67q4CTYswGW
         c1oi/ZvdUAcCPzN1j+9zEDbLohRx7huSWGToqfzeaIIVL8fQAocwxipKjcO/u+6nu129
         2UedapB8pyftgR07ghml+KAAtFL7KdBwOQOebhezkmdxxE8xr3FWYVZSQzp72NPDPEUy
         ReIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j7wFQAej6fSwbScLFcHGQ/mYv2AH2O4tGHNnw9sXpTw=;
        b=rNpjmkAmgqDtBd0orD6gfq4Anxn1llB06GuKeq5/csJw+kxd/R0iyaHsU2s9hrBglR
         W4Tyf6kLveG1/W2QRVqxTaDCKCKj9CHlJMLVmlJYX2HRcIFiV3SCoA1o8e0vyUPqlAbF
         HgyieCNttSzJO8O1WnRFrIl071bJSdnKcvl3ygKHw9JgDrXn2ZRTwrDueE+lWcw+IVpm
         /kK9V3shOhuZ7myvPLHnrMXx3G6Fp/JKvxvvDBE1UgVlozqPDLLhfLegyF3J7hvuJlnC
         QCBESYmHx4ix7J7FFZsb9yD5C9cT69TH7wgAUtDYFbV2PUeL2IbXyjMbpgVWGdrkWSdf
         YI+A==
X-Gm-Message-State: AGi0PualtkJlCNlhuYBa4wVlbCvZNnK0pFx485TiZtkdx9yYzcMAI445
        pfj76zI2nmM5F5hv/s1XAVY=
X-Google-Smtp-Source: APiQypJp6sM5iMmhiBeRcyJVDAiCKIul5pMj/MADX52YdCUZiyUcj98ydKDZM6L9vV663CnjHO1XVQ==
X-Received: by 2002:a05:6808:a93:: with SMTP id q19mr1284179oij.6.1588732710003;
        Tue, 05 May 2020 19:38:30 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id i10sm263302oos.28.2020.05.05.19.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 19:38:29 -0700 (PDT)
Date:   Tue, 5 May 2020 19:38:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vincenzo Aliberti <vincenzo.aliberti@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Fontana <rfontana@redhat.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mtd: lpddr: fix excessive stack usage with clang
Message-ID: <20200506023828.GA415100@ubuntu-s3-xlarge-x86>
References: <20200505140136.263461-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505140136.263461-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:01:16PM +0200, Arnd Bergmann wrote:
> Building lpddr2_nvm with clang can result in a giant stack usage
> in one function:
> 
> drivers/mtd/lpddr/lpddr2_nvm.c:399:12: error: stack frame size of 1144 bytes in function 'lpddr2_nvm_probe' [-Werror,-Wframe-larger-than=]
> 
> The problem is that clang decides to build a copy of the mtd_info
> structure on the stack and then do a memcpy() into the actual version. It
> shouldn't really do it that way, but it's not strictly a bug either.
> 
> As a workaround, use a static const version of the structure to assign
> most of the members upfront and then only set the few members that
> require runtime knowledge at probe time.
> 
> Fixes: 96ba9dd65788 ("mtd: lpddr: add driver for LPDDR2-NVM PCM memories")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/mtd/lpddr/lpddr2_nvm.c | 35 ++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/lpddr/lpddr2_nvm.c b/drivers/mtd/lpddr/lpddr2_nvm.c
> index 0f1547f09d08..72f5c7b30079 100644
> --- a/drivers/mtd/lpddr/lpddr2_nvm.c
> +++ b/drivers/mtd/lpddr/lpddr2_nvm.c
> @@ -393,6 +393,17 @@ static int lpddr2_nvm_lock(struct mtd_info *mtd, loff_t start_add,
>  	return lpddr2_nvm_do_block_op(mtd, start_add, len, LPDDR2_NVM_LOCK);
>  }
>  
> +static const struct mtd_info lpddr2_nvm_mtd_info = {
> +	.type		= MTD_RAM,
> +	.writesize	= 1,
> +	.flags		= (MTD_CAP_NVRAM | MTD_POWERUP_LOCK),
> +	._read		= lpddr2_nvm_read,
> +	._write		= lpddr2_nvm_write,
> +	._erase		= lpddr2_nvm_erase,
> +	._unlock	= lpddr2_nvm_unlock,
> +	._lock		= lpddr2_nvm_lock,
> +};
> +
>  /*
>   * lpddr2_nvm driver probe method
>   */
> @@ -433,6 +444,7 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
>  		.pfow_base	= OW_BASE_ADDRESS,
>  		.fldrv_priv	= pcm_data,
>  	};
> +
>  	if (IS_ERR(map->virt))
>  		return PTR_ERR(map->virt);
>  
> @@ -444,22 +456,13 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcm_data->ctl_regs);
>  
>  	/* Populate mtd_info data structure */
> -	*mtd = (struct mtd_info) {
> -		.dev		= { .parent = &pdev->dev },
> -		.name		= pdev->dev.init_name,
> -		.type		= MTD_RAM,
> -		.priv		= map,
> -		.size		= resource_size(add_range),
> -		.erasesize	= ERASE_BLOCKSIZE * pcm_data->bus_width,
> -		.writesize	= 1,
> -		.writebufsize	= WRITE_BUFFSIZE * pcm_data->bus_width,
> -		.flags		= (MTD_CAP_NVRAM | MTD_POWERUP_LOCK),
> -		._read		= lpddr2_nvm_read,
> -		._write		= lpddr2_nvm_write,
> -		._erase		= lpddr2_nvm_erase,
> -		._unlock	= lpddr2_nvm_unlock,
> -		._lock		= lpddr2_nvm_lock,
> -	};
> +	*mtd = lpddr2_nvm_mtd_info;
> +	mtd->dev.parent		= &pdev->dev;
> +	mtd->name		= pdev->dev.init_name;
> +	mtd->priv		= map;
> +	mtd->size		= resource_size(add_range);
> +	mtd->erasesize		= ERASE_BLOCKSIZE * pcm_data->bus_width;
> +	mtd->writebufsize	= WRITE_BUFFSIZE * pcm_data->bus_width;
>  
>  	/* Verify the presence of the device looking for PFOW string */
>  	if (!lpddr2_nvm_pfow_present(map)) {
> -- 
> 2.26.0
> 

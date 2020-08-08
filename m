Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFE6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 07:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275B720866
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596870247;
	bh=rk/q3PF4pBZ6YtIaGTAELuGj2N6xeDpwsjeEeHHoqlg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OkI0BfFGJkWKOeKsCPPh3DEKbYiy5Z8LIMl53M3WaYixiCaYOagsV3mz7qO99UmvL
	 yaKWH3hmI8yyL99y4YQ1tV1hq7j48XT2TAxtnEkMyl14d2mU+Kwhf9I7OgM9Mcp3Tt
	 xJA8CaVaYiCKENRPFk3wGYS1Dwl6T29NoQldU7KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHHHEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 03:04:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44261 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgHHHEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 03:04:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id l23so2779518edv.11;
        Sat, 08 Aug 2020 00:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cMk/40+I7B5Ro75P2Mo3QJC4dlLCJvnTo1HAcZ4gke4=;
        b=N3HX55+HpkEfL9PYRnOY05Lc6K+ZM1ZI957MhsgQ57Ff4tqPtHwPIhGq7sMafYCCrA
         YTRtaKF5ofwouox5gQYkHvnL98sfcVTZf8uKNn4Twvwztsfo4czUfqCQ3q6pXEW8dNHp
         6OGihnZ+mrBbJeRMca4e//a5egFLa3vDkC7TYNYV9ID+wFV3Do9S8vk36/Ot6oDYKh5y
         n+Ejah+qPSQyKUdt23az4MXxe0DjzLb6R3CA+2MGiV/RqItS/SKgJQKU1ArkTLkz0PA8
         5x5jW22ToF3j63hFk5QNA4J8zbjvDvx464qVCE3A/CPsL3Q6JVBVXctcvVuemm61bSRV
         UfPA==
X-Gm-Message-State: AOAM530sy9Pfbzs5+mgp//Cx5iRFB0D5Cd61AOMP61t4HvJKUZSLAlFj
        dlr9JSP6rCA/WiziRKgCnGRVQzf5
X-Google-Smtp-Source: ABdhPJzIybjM3Jicdsc7Pg082oaQbVqnOkm5+SwcTVx7Qd1LRNBTCnRtWTO3nSngso2Uw1t2OELqcA==
X-Received: by 2002:a05:6402:1504:: with SMTP id f4mr12517466edw.163.1596870241966;
        Sat, 08 Aug 2020 00:04:01 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id q2sm7059145edb.82.2020.08.08.00.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2020 00:04:01 -0700 (PDT)
Subject: Re: [PATCH] tty: synclink_gt: switch from 'pci_' to 'dma_' API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200806054404.728854-1-christophe.jaillet@wanadoo.fr>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <56a97781-7312-605a-02a0-37bc03366c94@kernel.org>
Date:   Sat, 8 Aug 2020 09:03:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806054404.728854-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 08. 20, 7:44, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below and has been
> hand modified to replace GFP_ with a correct flag.
> It has been compile tested.
> 
> When memory is allocated in 'alloc_desc()' and 'alloc_bufs()', GFP_KERNEL
> can be used because it is only called from a probe function and no lock is
> acquired.
> The call chain is:
>    init_one                    (the probe function)
>       --> device_init
>          --> alloc_dma_bufs
>             --> alloc_desc
>             --> alloc_bufs

Right.

...
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/tty/synclink_gt.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index b794177ccfb9..1edf06653148 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -3341,8 +3341,8 @@ static int alloc_desc(struct slgt_info *info)
>  	unsigned int pbufs;
>  
>  	/* allocate memory to hold descriptor lists */
> -	info->bufs = pci_zalloc_consistent(info->pdev, DESC_LIST_SIZE,
> -					   &info->bufs_dma_addr);
> +	info->bufs = dma_alloc_coherent(&info->pdev->dev, DESC_LIST_SIZE,
> +					&info->bufs_dma_addr, GFP_KERNEL);
>  	if (info->bufs == NULL)
>  		return -ENOMEM;
>  
> @@ -3384,7 +3384,8 @@ static int alloc_desc(struct slgt_info *info)
>  static void free_desc(struct slgt_info *info)
>  {
>  	if (info->bufs != NULL) {
> -		pci_free_consistent(info->pdev, DESC_LIST_SIZE, info->bufs, info->bufs_dma_addr);
> +		dma_free_coherent(&info->pdev->dev, DESC_LIST_SIZE,
> +				  info->bufs, info->bufs_dma_addr);
>  		info->bufs  = NULL;
>  		info->rbufs = NULL;
>  		info->tbufs = NULL;
> @@ -3395,7 +3396,9 @@ static int alloc_bufs(struct slgt_info *info, struct slgt_desc *bufs, int count)
>  {
>  	int i;
>  	for (i=0; i < count; i++) {
> -		if ((bufs[i].buf = pci_alloc_consistent(info->pdev, DMABUFSIZE, &bufs[i].buf_dma_addr)) == NULL)
> +		bufs[i].buf = dma_alloc_coherent(&info->pdev->dev, DMABUFSIZE,
> +						 &bufs[i].buf_dma_addr, GFP_KERNEL);
> +		if (!bufs[i].buf)
>  			return -ENOMEM;
>  		bufs[i].pbuf  = cpu_to_le32((unsigned int)bufs[i].buf_dma_addr);
>  	}
> @@ -3408,7 +3411,8 @@ static void free_bufs(struct slgt_info *info, struct slgt_desc *bufs, int count)
>  	for (i=0; i < count; i++) {
>  		if (bufs[i].buf == NULL)
>  			continue;
> -		pci_free_consistent(info->pdev, DMABUFSIZE, bufs[i].buf, bufs[i].buf_dma_addr);
> +		dma_free_coherent(&info->pdev->dev, DMABUFSIZE, bufs[i].buf,
> +				  bufs[i].buf_dma_addr);
>  		bufs[i].buf = NULL;
>  	}
>  }
> 

thanks,
-- 
js

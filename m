Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFFBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DA525298
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 21:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6RKGL4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgFUVMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 17:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbgFUVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 17:12:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA8C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 14:12:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so7396060pfp.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5Qe/ojxL/WbEUbkj+sYdL2ReXOMy86ieWc6LpdIrkow=;
        b=r6RKGL4qGHvw7XsVSMWYtIIZ2Jp2YisDw0HZnipUsXGl0y/Rj8cWweNo2/PsE5pyn5
         ZyFZvk/p4wBbXEOTSg8t2P1RHCJpLdKZNWEly1F8+ibMzPzRLU1MYTd5XElxlo32TIL2
         cgzZDpr4j1yM+5CxUlkg0V5nOCaFDLwjYIZxTA6VC6GbTnMT09qVV8vHpXDv797VAhD3
         9fjs7rFKH8TM9m676G5ecoa+rqee7gxIxHxgyrYCigqZs03ZMXHXsaWMtDhDIXChsZJT
         ZR6q0wmSLK98aQpyfZqYAxGnVAGtpq//7ua3ra7XZ7T3ufJO7PzUeJIggVhmpYq8ParQ
         PB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=5Qe/ojxL/WbEUbkj+sYdL2ReXOMy86ieWc6LpdIrkow=;
        b=D8avgMqHFOsfhhjVkMiNI9762Q6P6Rs8PdYaXcLfELnd+l5dobAsCMnYk87pcdS7GD
         BpRBkOk376JQtCjy5IqRdFOwBXv/6OYFA99YYBbmL6HnLy5TS0z0Qm0BlDKc+VE74Fw4
         eMaiHmifhMKPz2uCLTqbJR6Nw+eNi0maGCuEMirtPuKKuKVAcGMpmj0THvykXxtB7q2H
         03w93fKQm8SKSZLea8euw49WeVA56SqYg8GAFY/UzY1AOstyJxSVNWAk3T2f561Z+kxq
         rnbiKLHT+iylhLwSWo2gcbNazPf6ISSMSgF8ClFb7EN5A2hvTYmoIHX5ys7ObXbcaxT5
         ATqw==
X-Gm-Message-State: AOAM531dg0394xX+eAJbsrLxDfJUjxfftBtzB4Kh14DYPiPOhLD4uZFV
        BmmtPzq8ZNAHhswOXe7+571yX7L1
X-Google-Smtp-Source: ABdhPJzL27D7dHCiiuzQzs6kuoS3kOVvNpzTQk7p3tE9/mdd1lD6BVzy7x5Tf30nggWdEwnRFqM8yQ==
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr10527112pgn.12.1592773922412;
        Sun, 21 Jun 2020 14:12:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i125sm9184113pgd.21.2020.06.21.14.12.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jun 2020 14:12:01 -0700 (PDT)
Date:   Sun, 21 Jun 2020 14:12:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] dma-pool: warn when coherent pool is depleted
Message-ID: <20200621211200.GA158319@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 01:43:02PM -0700, David Rientjes wrote:
> When a DMA coherent pool is depleted, allocation failures may or may not
> get reported in the kernel log depending on the allocator.
> 
> The admin does have a workaround, however, by using coherent_pool= on the
> kernel command line.
> 
> Provide some guidance on the failure and a recommended minimum size for
> the pools (double the size).
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Also confirmed that coherent_pool=256k works around the crash
I had observed.

Guenter

> ---
>  kernel/dma/pool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -239,12 +239,16 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
>  	}
>  
>  	val = gen_pool_alloc(pool, size);
> -	if (val) {
> +	if (likely(val)) {
>  		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
>  
>  		*ret_page = pfn_to_page(__phys_to_pfn(phys));
>  		ptr = (void *)val;
>  		memset(ptr, 0, size);
> +	} else {
> +		WARN_ONCE(1, "DMA coherent pool depleted, increase size "
> +			     "(recommended min coherent_pool=%zuK)\n",
> +			  gen_pool_size(pool) >> 9);
>  	}
>  	if (gen_pool_avail(pool) < atomic_pool_size)
>  		schedule_work(&atomic_pool_work);

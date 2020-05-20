Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8488DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49856206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aufPXHaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgETAU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgETAU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:20:57 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:20:57 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ee19so535382qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBB46rtW2d9K5WUtTRAG4fGkmmxRO4txDBDNhv1nb3I=;
        b=aufPXHafyAKGS85jzWFQOmgEWdqs2c3vqfnjP5CTdSPYXzcd9jfZDjoFw7/fNhSpkq
         IEZvwy3nKg/7g5wAsBDxBkWyxPLi0cj4q3usRy4fSHicFZVt61hbduN29GYLULTU3gPr
         Q7V7t+NzRRNytV7oV32b0dXWPTuzrqLtQT5r6hIF73tiiSOpCL7QS877pdVlaLjAS6N7
         UBfvfG4X9vrVciR1zgfzlhvxP9ALidemtfWxUeq9f3OWI2jyqIvHIHbU5TEQLYHeFsSS
         MMrEe9j7jF8ybu7VVS564vbdG9pPvCrzDHDqF1D3h/arpm778fP207M1EnuLnsBaOaqN
         NlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBB46rtW2d9K5WUtTRAG4fGkmmxRO4txDBDNhv1nb3I=;
        b=bUtG2I1DBEzcnTPWRjmc0OecCqp5khsjbAxjj6J6QiIDuf9pWRF6fndHTLPb5i34RK
         iO7Kif2fB1g8Jyp5uljpAL6OmfH5m7YoqRUB/ImwuYL9ADWU+mIcHHAsc6wj4fteTj7m
         5v+AP+veD/VvAN3iMeH+7bTDK8018xv5erQM87WFygF5r3oRP8qJb0SxfETrqjRUb/43
         UYvJmwBVhDtV6+Q/6QXccDTHU0rWnrCdF46CymJJzDOB5/mEbeCHJW4NxqyJEnZA+SLp
         4EOMEyWlIyNHi+795HY0C0xs+5/Z7/gUnYNdZFEPsanhdVWgZkM7hKsp4iSc8AIGhe8h
         FC5A==
X-Gm-Message-State: AOAM5333GXfRqKc5OgZND2K39uAoVo9eTM9KzGIiPP+obVdv2mnTr/N1
        Ly6+Vtil3GEMGCS8s5vGk87IAg==
X-Google-Smtp-Source: ABdhPJzUB+q2wwwWl7HLqKjiszG5tdFF+m444eib+1trXjL6fLEd1NOT5DuZ5jvnviZDurr8gfCNzw==
X-Received: by 2002:ad4:4a8b:: with SMTP id h11mr2482355qvx.232.1589934056694;
        Tue, 19 May 2020 17:20:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y66sm769077qka.24.2020.05.19.17.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 17:20:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbCTf-0003SK-R4; Tue, 19 May 2020 21:20:55 -0300
Date:   Tue, 19 May 2020 21:20:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, peterx@redhat.com
Subject: Re: [PATCH 2/2] vfio: Introduce strict PFNMAP mappings
Message-ID: <20200520002055.GC31189@ziepe.ca>
References: <158947414729.12590.4345248265094886807.stgit@gimli.home>
 <158947512947.12590.4756232870747830161.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158947512947.12590.4756232870747830161.stgit@gimli.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:52:09AM -0600, Alex Williamson wrote:
>  	vfio_unregister_iommu_driver(&vfio_noiommu_ops);
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 62ba6bd8a486..8d6286d89230 100644
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -61,6 +61,11 @@ module_param_named(dma_entry_limit, dma_entry_limit, uint, 0644);
>  MODULE_PARM_DESC(dma_entry_limit,
>  		 "Maximum number of user DMA mappings per container (65535).");
>  
> +static bool strict_mmio_maps = true;
> +module_param_named(strict_mmio_maps, strict_mmio_maps, bool, 0644);
> +MODULE_PARM_DESC(strict_mmio_maps,
> +		 "Restrict DMA mappings of MMIO to those provided by vfio bus drivers supporting invalidation (true).");
> +

This should probably explain that 'false' allows some kind of security
issue and maybe taint the kernel?

Do you think there is a reason to have this anyhow?

Jason

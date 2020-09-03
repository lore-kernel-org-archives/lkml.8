Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45447C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCB720773
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="sLw7B6tB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgICDr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:47:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgICDr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:47:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bhmwh08jXz9sR4;
        Thu,  3 Sep 2020 13:47:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1599104874;
        bh=4yAcDTxLmVtFlFmBwViPiQqBxkMUq1/v+ltMjACdmTw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sLw7B6tBL0tYeiS7UbUp4SBXAdWw1BiuX1rzRD7UWBO4tYjHsDcRVzXhtw9LnwBSb
         TVkfoqm3UH9AlqDYsgMpWDtdLM9KmPlrSHeDnjaQHBRgQyRaye8SGf9zquJweA35N7
         ilN3da+kZMlwnOIFaqVvO5w2y0IGDyDnVFG1VcyDqd8GjM2NTURgLs8goa8r9z4rAX
         bS7CaEKouymf+JkB9pMsYKQDB1pDC1x6WHKsbhAVF7YeLmzAfKXrfbmEv+zmCeShnW
         T7ZxEkdC9W8WnKJu7u5s2wHJv1TU45hmfsmEVHLbTCR7rbxTHbwfqjSrB0uc+2ymCK
         IggJReIsXvpLw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de
Cc:     sfr@canb.auug.org.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: introduce dma_get_seg_boundary_nr_pages()
In-Reply-To: <20200901221646.26491-2-nicoleotsuka@gmail.com>
References: <20200901221646.26491-1-nicoleotsuka@gmail.com> <20200901221646.26491-2-nicoleotsuka@gmail.com>
Date:   Thu, 03 Sep 2020 13:47:43 +1000
Message-ID: <87363z1py8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolin Chen <nicoleotsuka@gmail.com> writes:
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 9704f3f76e63..cbc2e62db597 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -236,15 +236,10 @@ static unsigned long iommu_range_alloc(struct device *dev,
>  		}
>  	}
>  
> -	if (dev)
> -		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
> -				      1 << tbl->it_page_shift);
> -	else
> -		boundary_size = ALIGN(1UL << 32, 1 << tbl->it_page_shift);
> -	/* 4GB boundary for iseries_hv_alloc and iseries_hv_map */
> +	boundary_size = dma_get_seg_boundary_nr_pages(dev, tbl->it_page_shift);
>  
>  	n = iommu_area_alloc(tbl->it_map, limit, start, npages, tbl->it_offset,
> -			     boundary_size >> tbl->it_page_shift, align_mask);
> +			     boundary_size, align_mask);

This has changed the units of boundary_size, but it's unused elsewhere
in the function so that's OK.

If you need to do a v2 for any other reason, then I'd just drop
boundary_size and call dma_get_seg_boundary_nr_pages() directly in the
function call.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

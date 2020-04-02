Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF47C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5F42072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DgiJiXSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbgDBWHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:07:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbgDBWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c7P1sjhcLrqTERzpZ2hp0UyJvWxyjDALLe/X2lyoUd4=; b=DgiJiXSGdO6QvpCrNzwR24b0b9
        gBxqGSm0Gh4iWk2wIHsAtrzp3lbdavPaRXVtGmqYTo60KAyDAviiedxdgBTleLW4nRhIfKW7YVtak
        a4MtXweCyv0KgRmM1d2rPjddV0CIfaz3f0A2bXSiHdI44DjaW72L7a6BAgSKA3yzNC4UOKDZ7CqXe
        QCvDXAyrxuvrgllT3HIeZbeJ3UtwG+KK+w1WIAsJ+4VBOOu0h+nvRfX0RKj+vJmHZIFIHbjW2A5Tv
        wcVDIij1hD/7A3uO4yRYaU30whbPnBLrLW08l6wRPoCaZipDaE/cU9fGEZ2O3hOAul2vCUfq40M7T
        7raP7/rg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK7zV-0007vq-2y; Thu, 02 Apr 2020 22:07:13 +0000
Date:   Thu, 2 Apr 2020 15:07:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Aslan Bakirov <aslan@fb.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, riel@surriel.com,
        guro@fb.com, mhocko@kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2] mm: cma: NUMA node interface
Message-ID: <20200402220713.GO21484@bombadil.infradead.org>
References: <20200402215810.1898270-1-aslan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402215810.1898270-1-aslan@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:58:10PM -0700, Aslan Bakirov wrote:
> I've noticed that there is no interfaces exposed by CMA which would let me
> to declare contigous memory on particular NUMA node.

Do you have a user for this functionality?

> +++ b/include/linux/cma.h
> @@ -24,10 +24,20 @@ extern phys_addr_t cma_get_base(const struct cma *cma);
>  extern unsigned long cma_get_size(const struct cma *cma);
>  extern const char *cma_get_name(const struct cma *cma);
>  
> -extern int __init cma_declare_contiguous(phys_addr_t base,
> +extern int __init cma_declare_contiguous_nid(phys_addr_t base,
>  			phys_addr_t size, phys_addr_t limit,
>  			phys_addr_t alignment, unsigned int order_per_bit,
> -			bool fixed, const char *name, struct cma **res_cma);
> +			bool fixed, const char *name, struct cma **res_cma,
> +			int nid);
> +static inline int __init cma_declare_contiguous(phys_addr_t base,
> +			phys_addr_t size, phys_addr_t limit,
> +			phys_addr_t alignment, unsigned int order_per_bit,
> +			bool fixed, const char *name, struct cma **res_cma)
> +			{
> +				return cma_declare_contiguous_nid(base, size,
> +						limit, alignment, order_per_bit,
> +						fixed, name, res_cma, NUMA_NO_NODE);
> +			}

... what even is this indentation?

> +phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
> +					  phys_addr_t align, phys_addr_t start,
> +					  phys_addr_t end, int nid, bool exact_nid);

>80 columns.  checkpatch should warn you of nits like this.

>  		if (base < highmem_start && limit > highmem_start) {
> -			addr = memblock_phys_alloc_range(size, alignment,
> -							 highmem_start, limit);
> +			addr = memblock_alloc_range_nid(size, alignment,
> +							 highmem_start, limit, nid, false);

The deep indentation makes it hard to add new parameters.  I'd do it as:
			addr = memblock_alloc_range_nid(size, alignment,
					highmem_start, limit, nid, false);


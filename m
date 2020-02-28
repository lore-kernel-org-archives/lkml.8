Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F41C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AEA246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fq75hbSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgB1Noj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:44:39 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41456 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgB1Noj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:44:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id b5so2928098qkh.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Gusxub8rDloI9E9z1JdAxqVCBhNu/BE0SIv5yZJtB0=;
        b=fq75hbStQcdTP6/tpdFP2fPlQ1qJYu9pJij48Gkh10U/d+jCPx5yNMCGpWpRHbMfEp
         VC1gKfhHRr2X+tv2bh4h1utt2lMNKdwgKlYaFqfdqaLdt0jJzdojLIZD0EaA9KqFhZIl
         TvtuDke1oA6IkQKF3+Qp56lzggCgiTOGVuBmuj7XS9dLLhJyXVpzyUZBeULU3blyT7Ot
         ww128tDwZHdEGYWAmRHBeyWPQK3urK+K295l0DCM+e1uLOZPNL16s2A+Ten6EdGa081g
         hivGoZrqUx+/m12kqFMmzd8CbAOGn+T41murnDE++VhtXnGcsVJ/RYY7+GH80lOy/vyt
         biWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Gusxub8rDloI9E9z1JdAxqVCBhNu/BE0SIv5yZJtB0=;
        b=VJP0ZAsHBQ0Tchhi6cOyq2GEhBWl7riy6/8hO9CG/f9QbZBnCcWkWTpoDhr/DfQ/tT
         fG+cIASY656kaICQUfGGS7hRTsbHqFJAIE6EIrPQDyKrDGLQ6AveWlBUv7L0UPP33IpS
         Jzpj7t3whSfduebc6omYPJXnasM2iSMkLVXXr1dsRM7Id3FuN3c9uAXkTaNObB+egaG2
         ExpS0emvKdUryzbjf2NJObr2qoFMfpi+Zk/JlHUFyiCOp925/Byfpc+5KotZovLoCcdg
         ruplr/+RvHvcAYT/ADt36REJqkASJRZLQre+IzRukYkXTzl0gbnlv12pZEpzyS4EUSut
         7DGQ==
X-Gm-Message-State: APjAAAVRONLmYB1rn2xcJPiov8A8A6t75fjcFHjQcp9BYlHPKjNjmhRf
        ALQhzo+89XucxPArbetgB7MwyQ==
X-Google-Smtp-Source: APXvYqyTKBYDgEEsD/JReg4oMAoT8TFz5vLvH33yj4Tz9TuOddT6xLH1eCSa+3TbalxgD6egRTt7Lg==
X-Received: by 2002:a37:dd7:: with SMTP id 206mr4628111qkn.12.1582897478426;
        Fri, 28 Feb 2020 05:44:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d35sm3365322qtc.21.2020.02.28.05.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 05:44:37 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7fwS-0007x1-Br; Fri, 28 Feb 2020 09:44:36 -0400
Date:   Fri, 28 Feb 2020 09:44:36 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
Message-ID: <20200228134436.GP31668@ziepe.ca>
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
 <1582889550-9101-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582889550-9101-3-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 07:32:29PM +0800, Pingfan Liu wrote:
> FOLL_LONGTERM suggests a pin which is going to be given to hardware and
> can't move. It would truncate CMA permanently and should be excluded.
> 
> FOLL_LONGTERM has already been checked in the slow path, but not checked in
> the fast path, which means a possible leak of CMA page to longterm pinned
> requirement through this crack.
> 
> Place a check in try_get_compound_head() in the fast path.
> 
> Some note about the check:
> Huge page's subpages have the same migrate type due to either
> allocation from a free_list[] or alloc_contig_range() with param
> MIGRATE_MOVABLE. So it is enough to check on a single subpage
> by is_migrate_cma_page(subpage)
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
>  mm/gup.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index cd8075e..f0d6804 100644
> +++ b/mm/gup.c
> @@ -33,9 +33,21 @@ struct follow_page_context {
>   * Return the compound head page with ref appropriately incremented,
>   * or NULL if that failed.
>   */
> -static inline struct page *try_get_compound_head(struct page *page, int refs)
> +static inline struct page *try_get_compound_head(struct page *page, int refs,
> +	unsigned int flags)
>  {
> -	struct page *head = compound_head(page);
> +	struct page *head;
> +
> +	/*
> +	 * Huge page's subpages have the same migrate type due to either
> +	 * allocation from a free_list[] or alloc_contig_range() with param
> +	 * MIGRATE_MOVABLE. So it is enough to check on a single subpage.
> +	 */
> +	if (unlikely(flags & FOLL_LONGTERM) &&
> +		is_migrate_cma_page(page))
> +		return NULL;

This doesn't seem very good actually.

If I understand properly, if the system has randomly decided to place,
say, an anonymous page in a CMA region when an application did mmap(),
then when the application tries to use this page with a LONGTERM pin
it gets an immediate failure because of the above.

This not OK - the application should not be subject to random failures
related to long term pins beyond its direct control.

Essentially, failures should only originate from the application using
specific mmap scenarios, not randomly based on something the MM did,
and certainly never for anonymous memory.

I think the correct action here is to trigger migration of the page so
it is not in CMA.

Jason

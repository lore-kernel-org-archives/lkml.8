Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C86C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728FB20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583830885;
	bh=NtHlvpL+gXzhNiO+jGYd3MpzpmxBiU9iY+UuS+E1sz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hA5X3jrKAcesOSk8y54x8rRx6OyFUCQddc0v9/Mv2RmegUMHMvhkPMPVSVwIVkCCR
	 apj1YQxNEbanRJXolze8vhDevDKJvU8u6NE/sxi7HFFTepDrMaOh7iXS5tjNKOdTPE
	 Pj8UDGobq8nvs3U/bvFxJmY2rID55EokzQoFe9E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCJJBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:01:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:01:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so10935061wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 02:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0lnjLD08KOelgi1ONZY2JM84krgFboyE61707ReGdiQ=;
        b=fTrV/uZ4dE9kCguru+fhcv92ubA9wnD6Uk5dZbCHgDdcwICVuf9gSw+NeDzVj12abY
         OyYr0BOHIQtg03lRhWTpaMvkpGNUHoaqDpuKJfilbQPklOCWMKcqvoicRAFP6gDyxVFM
         86Ozsji2HqV7l59W+MCc/rF1TPD5bEJ2nOZrNIMxYM5zDJkle/JhcfVmZyfJPfNwpyxZ
         DlbvA8CEXnhvtHwH8ej/z0UKzImTteSD5LqvRogqdndLIb6ceWs6NQajdoSt8YrQb6/O
         gh8LPYxHLnkKpDH5ssCq36xwYCPT8VArzBK+IVj5RbjtSpvJ6L2ww18dAiFQYoA40z3W
         ov4Q==
X-Gm-Message-State: ANhLgQ14ISRkP3Yl4p0DyiM2vTx3rHQCU5arB3lTV/vZ44wWywHFtt4n
        3ycQ/CecdAzGnq1svLPlTxs=
X-Google-Smtp-Source: ADFU+vsYBdqlkAUoiNtp3XJDMUr1vNLpjSmnhE13RS0l5B22lgyK7xH7ipsSacbulrWQJ36OS94saw==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr25308450wrq.119.1583830882554;
        Tue, 10 Mar 2020 02:01:22 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a5sm3074004wmb.37.2020.03.10.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 02:01:21 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:01:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310090121.GB8447@dhcp22.suse.cz>
References: <20200310002524.2291595-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310002524.2291595-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-03-20 17:25:24, Roman Gushchin wrote:
[...]
> 2) Run-time allocations of gigantic hugepages are performed using the
>    cma allocator and the dedicated cma area

[...]
> @@ -1237,6 +1246,23 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>  {
>  	unsigned long nr_pages = 1UL << huge_page_order(h);
>  
> +	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> +		struct page *page;
> +		int nid;
> +
> +		for_each_node_mask(nid, *nodemask) {
> +			if (!hugetlb_cma[nid])
> +				break;
> +
> +			page = cma_alloc(hugetlb_cma[nid], nr_pages,
> +					 huge_page_order(h), true);
> +			if (page)
> +				return page;
> +		}
> +
> +		return NULL;

Is there any strong reason why the alloaction annot fallback to non-CMA
allocator when the cma is depleted?

> +	}
> +
>  	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
>  }

-- 
Michal Hocko
SUSE Labs

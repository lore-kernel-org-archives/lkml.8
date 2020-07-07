Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA33C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A74206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594109900;
	bh=+PF6hJTZmNi14SpZ7fetiogdxipMfdQWwB9JQZMG5fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QQch1zUXUNOdzZNqDKIAz/F/eXN/zAn85JIYAP9vVqSDsI/aupXsZbdbTp1mO81IS
	 PAXBDoojG+tt1RFHiQt82lEWUI17eYcDA29kbaD8wobSUc6pW0vQpyntluqtRMUX8I
	 RQN/dd1iy0z/gMRRjDOxjBVbOrwtO8PoIw7ReB0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGGIST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGIST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:18:19 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7FAA206C3;
        Tue,  7 Jul 2020 08:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594109898;
        bh=+PF6hJTZmNi14SpZ7fetiogdxipMfdQWwB9JQZMG5fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBW7R8NI69CCof8isf8K7twVpVD+N7D5tEzJVDKsOa3fvtZegYQbCN7j8nuCiQgm0
         PJQ9FUMdnkWcpgfpqu6Ufw+rVahoD0au1RDqJEf844gVWN9ImvL45hxvpeASckkxZC
         dKU+xpzNLtPUNCfL09P9X4A2gF9JfbEyHmbbKHEQ=
Date:   Tue, 7 Jul 2020 11:18:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma is
 enable
Message-ID: <20200707081811.GD9449@kernel.org>
References: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:02:04PM +1200, Barry Song wrote:
> hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
> no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> enabled. gigantic pages might have been reserved on other nodes.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  -v3: add acked-by; make code more canonical 
> 
>  mm/hugetlb.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 57ece74e3aae..d293c823121e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2546,6 +2546,20 @@ static void __init gather_bootmem_prealloc(void)
>  	}
>  }
>  
> +bool __init hugetlb_cma_enabled(void)
> +{
> +#ifdef CONFIG_CMA
> +	int node;
> +
> +	for_each_online_node(node) {
> +		if (hugetlb_cma[node])
> +			return true;
> +	}
> +#endif
> +
> +	return false;
> +}
> +
>  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  {
>  	unsigned long i;
> @@ -2571,7 +2585,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  
>  	for (i = 0; i < h->max_huge_pages; ++i) {
>  		if (hstate_is_gigantic(h)) {
> -			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> +			if (hugetlb_cma_enabled()) {
>  				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
>  				break;
>  			}
> -- 
> 2.27.0
> 
> 
> 

-- 
Sincerely yours,
Mike.

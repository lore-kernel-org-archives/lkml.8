Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB453C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A36D206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gI0o6wTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDFTxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:53:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15699 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:53:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b886b0001>; Mon, 06 Apr 2020 12:52:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 12:53:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 12:53:03 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 19:53:03 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 19:53:02 +0000
Subject: Re: [PATCHv2 2/8] khugepaged: Do not stop collapse if less than half
 PTEs are referenced
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>
CC:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-3-kirill.shutemov@linux.intel.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7d3af6a4-b0ee-9497-da0b-b93e050c5a4c@nvidia.com>
Date:   Mon, 6 Apr 2020 12:53:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200403112928.19742-3-kirill.shutemov@linux.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586202731; bh=DvhlY5W4PXWEH3pnbcXqK6BlG8sFGpdOhRkDNLGqOvE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gI0o6wTcoa+UOczpur1kIXv5XkhV9G7xCU4Y2pZE/NwHUQe+OG5TshRXXSPlK19qU
         xGL3dN442ie8JWkfGF9auMunUF3YhXLOkpSqaZ8gCW75EJyT0Z6xAew+IbwRe+YoeI
         Req9FDjVjBv531GfC7iSt2Z69lmxnFHC1PSTfjs5T6OHYK3jNzIZ6wzxLb1waWXenx
         Ey7S3+J4yzJzJ5rQE5l/hkOEvGrNKPdpqOya/iF0ToyROpxQcgqAO2owjD9N6Nor/0
         7kOUyPSzkCqP6BDgSOxSAfgS2TlUM/tGlOf73NArd5EQlGVYZfjy8dzHhdu/75V5cU
         rulG/KpxVYKuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> __collapse_huge_page_swapin() check number of referenced PTE to decide
> if the memory range is hot enough to justify swapin.
> 
> The problem is that it stops collapse altogether if there's not enough
> referenced pages, not only swappingin.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 0db501f7a34c ("mm, thp: convert from optimistic swapin collapsing to conservative")
> Reviewed-by: Zi Yan <ziy@nvidia.com> ---
>   mm/khugepaged.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 99bab7e4d05b..14d7afc90786 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -905,7 +905,8 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>   	/* we only decide to swapin, if there is enough young ptes */
>   	if (referenced < HPAGE_PMD_NR/2) {
>   		trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);

The trace point is recording the return value. Shouldn't you s/0/1 to match?

> -		return false;
> +		/* Do not block collapse, only skip swapping in */
> +		return true;
>   	}
>   	vmf.pte = pte_offset_map(pmd, address);
>   	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
> 

So "referenced < HPAGE_PMD_NR/2" means swapped out pages aren't faulted back in
but there could still be no swapped out pages, just "old" pages so collapse could
succeed. Seems like this check could have been made in khugepaged_scan_pmd() when
"referenced" is being computed and "unmapped" is available. Just skip setting
"ret = 1" if unmapped > 0 && referenced < HPAGE_PMD_NR/2.

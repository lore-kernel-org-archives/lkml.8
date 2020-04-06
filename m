Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE233C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CB120731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDFSNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:13:42 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34057 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbgDFSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:13:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TuqA70k_1586196816;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TuqA70k_1586196816)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Apr 2020 02:13:38 +0800
Subject: Re: [PATCHv2 2/8] khugepaged: Do not stop collapse if less than half
 PTEs are referenced
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-3-kirill.shutemov@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <238a9a53-cf9b-7729-46f1-9b2a5e37571a@linux.alibaba.com>
Date:   Mon, 6 Apr 2020 11:13:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200403112928.19742-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/khugepaged.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 99bab7e4d05b..14d7afc90786 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -905,7 +905,8 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>   	/* we only decide to swapin, if there is enough young ptes */
>   	if (referenced < HPAGE_PMD_NR/2) {
>   		trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -		return false;
> +		/* Do not block collapse, only skip swapping in */
> +		return true;
>   	}
>   	vmf.pte = pte_offset_map(pmd, address);
>   	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;


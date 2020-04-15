Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3335C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB5820774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371274AbgDOUdS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:33:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54640 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S371258AbgDOUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:33:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvdsLqm_1586982783;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TvdsLqm_1586982783)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Apr 2020 04:33:05 +0800
Subject: Re: [PATCHv3, RESEND 4/8] khugepaged: Drain LRU add pagevec after
 swapin
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-5-kirill.shutemov@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <602d9624-1a41-611f-bba9-f38806be9c33@linux.alibaba.com>
Date:   Wed, 15 Apr 2020 13:32:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200413125220.663-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/20 5:52 AM, Kirill A. Shutemov wrote:
> __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> pagevec. It's pretty common for swapin case: we swap in pages just to
> fail due to the extra pin.
>
> Drain LRU add pagevec on successful swapin.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/khugepaged.c | 5 +++++
>   1 file changed, 5 insertions(+)

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ee66c140c2d6..e3e41c2768d8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -934,6 +934,11 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>   	}
>   	vmf.pte--;
>   	pte_unmap(vmf.pte);
> +
> +	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
> +	if (swapped_in)
> +		lru_add_drain();
> +
>   	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 1);
>   	return true;
>   }


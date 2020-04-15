Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89D8C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B3420787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371250AbgDOUcj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:32:39 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46249 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2636948AbgDOUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:32:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvdyiWI_1586982722;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TvdyiWI_1586982722)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Apr 2020 04:32:04 +0800
Subject: Re: [PATCHv3, RESEND 3/8] khugepaged: Drain all LRU caches before
 scanning pages
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-4-kirill.shutemov@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <63b9ce4d-0e1d-8e40-5ec3-154fe6e95557@linux.alibaba.com>
Date:   Wed, 15 Apr 2020 13:31:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200413125220.663-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/20 5:52 AM, Kirill A. Shutemov wrote:
> Having a page in LRU add cache offsets page refcount and gives
> false-negative on PageLRU(). It reduces collapse success rate.
>
> Drain all LRU add caches before scanning. It happens relatively
> rare and should not disturb the system too much.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/khugepaged.c | 2 ++
>   1 file changed, 2 insertions(+)

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5968ec5ddd6b..ee66c140c2d6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2059,6 +2059,8 @@ static void khugepaged_do_scan(void)
>   
>   	barrier(); /* write khugepaged_pages_to_scan to local stack */
>   
> +	lru_add_drain_all();
> +
>   	while (progress < pages) {
>   		if (!khugepaged_prealloc_page(&hpage, &wait))
>   			break;


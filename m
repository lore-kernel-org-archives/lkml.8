Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E43C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D711B2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDFSQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:16:05 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39416 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgDFSQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:16:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tuq9-ti_1586196959;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tuq9-ti_1586196959)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Apr 2020 02:16:01 +0800
Subject: Re: [PATCHv2 3/8] khugepaged: Drain all LRU caches before scanning
 pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-4-kirill.shutemov@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3f0514c3-7f1e-0ba0-b458-683600bd5905@linux.alibaba.com>
Date:   Mon, 6 Apr 2020 11:15:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200403112928.19742-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> Having a page in LRU add cache offsets page refcount and gives
> false-negative on PageLRU(). It reduces collapse success rate.
>
> Drain all LRU add caches before scanning. It happens relatively
> rare and should not disturb the system too much.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

> ---
>   mm/khugepaged.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 14d7afc90786..fdc10ffde1ca 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2065,6 +2065,8 @@ static void khugepaged_do_scan(void)
>   
>   	barrier(); /* write khugepaged_pages_to_scan to local stack */
>   
> +	lru_add_drain_all();
> +
>   	while (progress < pages) {
>   		if (!khugepaged_prealloc_page(&hpage, &wait))
>   			break;


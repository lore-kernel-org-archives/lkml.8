Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B19C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAD52068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgEEUTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:19:10 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56431 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727785AbgEEUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:19:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Txb6obD_1588709945;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Txb6obD_1588709945)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 May 2020 04:19:07 +0800
Subject: Re: [RFC][PATCH 1/2] mm/migrate: remove extra page_count() check
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     npiggin@gmail.com, akpm@linux-foundation.org, willy@infradead.org,
        linux-mm@kvack.org
References: <20200501210516.DFAFF456@viggo.jf.intel.com>
 <20200501210518.DA161B7E@viggo.jf.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2aa6a7b8-fc9b-e903-a665-c4cd516392b8@linux.alibaba.com>
Date:   Tue, 5 May 2020 13:18:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200501210518.DA161B7E@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/20 2:05 PM, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> This is not a bug fix.  It was found by inspection, but I believe
> that it is confusing as it stands.
>
> First, page_ref_freeze() is implemented internally with:
>
> 	atomic_cmpxchg(&page->_refcount, expected, 0) == expected
>
> The "cmp" part of cmpxchg is making sure that _refcount==expected
> which means that there's an implicit check here, equivalent to:
>
> 	page_count(page) == expected_count
>
> This appears to have originated in "e286781: mm: speculative page
> references", which is pretty ancient.  This check is also somewhat
> dangerous to have here because it might lead someone to think that
> page_ref_freeze() *doesn't* do its own page_count() checking.
>
> Remove the unnecessary check.

Make sense to me. Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>
>   b/mm/migrate.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff -puN mm/migrate.c~remove_extra_page_count_check mm/migrate.c
> --- a/mm/migrate.c~remove_extra_page_count_check	2020-05-01 14:00:42.331525924 -0700
> +++ b/mm/migrate.c	2020-05-01 14:00:42.336525924 -0700
> @@ -425,11 +425,12 @@ int migrate_page_move_mapping(struct add
>   	newzone = page_zone(newpage);
>   
>   	xas_lock_irq(&xas);
> -	if (page_count(page) != expected_count || xas_load(&xas) != page) {
> +	if (xas_load(&xas) != page) {
>   		xas_unlock_irq(&xas);
>   		return -EAGAIN;
>   	}
>   
> +	/* Freezing will fail if page_count()!=expected_count */
>   	if (!page_ref_freeze(page, expected_count)) {
>   		xas_unlock_irq(&xas);
>   		return -EAGAIN;
> _


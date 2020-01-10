Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7567C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A392A2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="FBubMR+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgAJIkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:40:04 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:38736 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgAJIkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:40:04 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 456EC2E1456;
        Fri, 10 Jan 2020 11:40:00 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id bcsZZM9Jlb-dwdWQuXg;
        Fri, 10 Jan 2020 11:40:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578645600; bh=jaVi2DcVyfdfNZXIP6KM4l6zW3qadoPbhC7P1cnSXTA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=FBubMR+KQ0knT40UhvGjljtxUHp7ps+MArKaHtJ7QFqU2Hei2rVLpmHXKq5mOL+Hh
         uKDsUvMmjRXUwumg5BYr12IRS/Owqfyldw7i7LuiDic6SgPxTg9PVunNh6WOcwtce1
         CTTYlXplk9tD/r3lZFQBzqFTakkAtGzYYCDRrzlo=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id lK8osUUebC-dwVudoac;
        Fri, 10 Jan 2020 11:39:58 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v7 01/10] mm/vmscan: remove unnecessary lruvec adding
To:     Alex Shi <alex.shi@linux.alibaba.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     yun.wang@linux.alibaba.com
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-2-git-send-email-alex.shi@linux.alibaba.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <6c91fb0a-d4e0-d960-1cfd-62bef5cd15a5@yandex-team.ru>
Date:   Fri, 10 Jan 2020 11:39:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577264666-246071-2-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/2019 12.04, Alex Shi wrote:
> We don't have to add a freeable page into lru and then remove from it.
> This change saves a couple of actions and makes the moving more clear.
> 
> The SetPageLRU needs to be kept here for list intergrity. Otherwise:
> 
>      #0 mave_pages_to_lru                #1 release_pages
>                                          if (put_page_testzero())
>      if (put_page_testzero())
> 	                                    !PageLRU //skip lru_lock
>                                                  list_add(&page->lru,);
>      else
>          list_add(&page->lru,) //corrupt
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: yun.wang@linux.alibaba.com
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   mm/vmscan.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 572fb17c6273..8719361b47a0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1852,26 +1852,18 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,

Here is another cleanup: pass only pgdat as argument.

This function reavaluates lruvec for each page under lru lock.
Probably this is redundant for now but could be used in the future (or your patchset already use that).

>   	while (!list_empty(list)) {
>   		page = lru_to_page(list);
>   		VM_BUG_ON_PAGE(PageLRU(page), page);
> +		list_del(&page->lru);
>   		if (unlikely(!page_evictable(page))) {
> -			list_del(&page->lru);
>   			spin_unlock_irq(&pgdat->lru_lock);
>   			putback_lru_page(page);
>   			spin_lock_irq(&pgdat->lru_lock);
>   			continue;
>   		}
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -

Please leave a comment that we must set PageLRU before dropping our page reference.

>   		SetPageLRU(page);
> -		lru = page_lru(page);
> -
> -		nr_pages = hpage_nr_pages(page);
> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> -		list_move(&page->lru, &lruvec->lists[lru]);
>   
>   		if (put_page_testzero(page)) {
>   			__ClearPageLRU(page);
>   			__ClearPageActive(page);
> -			del_page_from_lru_list(page, lruvec, lru);
>   
>   			if (unlikely(PageCompound(page))) {
>   				spin_unlock_irq(&pgdat->lru_lock);
> @@ -1880,6 +1872,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>   			} else
>   				list_add(&page->lru, &pages_to_free);
>   		} else {
> +			lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +			lru = page_lru(page);
> +			nr_pages = hpage_nr_pages(page);
> +
> +			update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> +			list_add(&page->lru, &lruvec->lists[lru]);
>   			nr_moved += nr_pages;
>   		}

IMHO It looks better to in this way:

SetPageLRU()

if (unlikely(put_page_testzero())) {
  <free>
  continue;
}

<add>

>   	}
> 

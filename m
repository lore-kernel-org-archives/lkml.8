Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A9FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F308B207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgGBNhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:37:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgGBNhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:37:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D555ADE4;
        Thu,  2 Jul 2020 13:37:34 +0000 (UTC)
Subject: Re: [PATCH v6 5/6] mm/swap: implement workingset detection for
 anonymous LRU
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-6-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <47989e98-ecd2-3ea8-871c-88583e55a4dc@suse.cz>
Date:   Thu, 2 Jul 2020 15:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592371583-30672-6-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 7:26 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> This patch implements workingset detection for anonymous LRU.
> All the infrastructure is implemented by the previous patches so this patch
> just activates the workingset detection by installing/retrieving
> the shadow entry.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> diff --git a/mm/workingset.c b/mm/workingset.c
> index 8395e60..3769ae6 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -353,8 +353,9 @@ void workingset_refault(struct page *page, void *shadow)
>  	/*
>  	 * Compare the distance to the existing workingset size. We
>  	 * don't activate pages that couldn't stay resident even if
> -	 * all the memory was available to the page cache. Whether
> -	 * cache can compete with anon or not depends on having swap.
> +	 * all the memory was available to the workingset. Whether
> +	 * workingset competetion need to consider anon or not depends

                      competition needs

> +	 * on having swap.
>  	 */
>  	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
>  	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
> 


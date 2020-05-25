Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94386C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705E5207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbgEYRDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 13:03:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgEYRDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 13:03:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C713FAA7C;
        Mon, 25 May 2020 17:03:15 +0000 (UTC)
Subject: Re: [PATCH v3 11/19] mm: memcg/slab: move memcg_kmem_bypass() to
 memcontrol.h
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-12-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b85f8b6a-86d2-cce2-630f-4023ae3632c3@suse.cz>
Date:   Mon, 25 May 2020 19:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-12-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:47 PM, Roman Gushchin wrote:
> To make the memcg_kmem_bypass() function available outside of
> the memcontrol.c, let's move it to memcontrol.h. The function
> is small and nicely fits into static inline sort of functions.
> 
> It will be used from the slab code.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/memcontrol.h | 7 +++++++
>  mm/memcontrol.c            | 7 -------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 44b7d1244620..840eb8d486a8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1462,6 +1462,13 @@ static inline bool memcg_kmem_enabled(void)
>  	return static_branch_unlikely(&memcg_kmem_enabled_key);
>  }
>  
> +static inline bool memcg_kmem_bypass(void)
> +{
> +	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> +		return true;
> +	return false;
> +}
> +
>  static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
>  					 int order)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f957b029a62f..06a5929f4872 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2941,13 +2941,6 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  	queue_work(memcg_kmem_cache_wq, &cw->work);
>  }
>  
> -static inline bool memcg_kmem_bypass(void)
> -{
> -	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> -		return true;
> -	return false;
> -}
> -
>  /**
>   * memcg_kmem_get_cache: select the correct per-memcg cache for allocation
>   * @cachep: the original global kmem cache
> 


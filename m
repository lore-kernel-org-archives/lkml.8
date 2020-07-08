Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A386C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7007320786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgGHLRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:17:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:40640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgGHLRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:17:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 513BBAD5C;
        Wed,  8 Jul 2020 11:17:10 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm: kmem: switch to static_branch_likely() in
 memcg_kmem_enabled()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200707173612.124425-1-guro@fb.com>
 <20200707173612.124425-3-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <302e96c9-01ba-cdf3-1f50-8d33572d6ba4@suse.cz>
Date:   Wed, 8 Jul 2020 13:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707173612.124425-3-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 7:36 PM, Roman Gushchin wrote:
> Currently memcg_kmem_enabled() is optimized for the kernel memory
> accounting being off. It was so for a long time, and arguably the
> reason behind was that the kernel memory accounting was initially an
> opt-in feature. However, now it's on by default on both cgroup v1
> and cgroup v2, and it's on for all cgroups. So let's switch over
> to static_branch_likely() to reflect this fact.
> 
> Unlikely there is a significant performance difference, as the cost
> of a memory allocation and its accounting significantly exceeds the
> cost of a jump. However, the conversion makes the code look more
> logically.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b8f52a3fed90..ab9322215b2e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1456,7 +1456,7 @@ void memcg_put_cache_ids(void);
>  
>  static inline bool memcg_kmem_enabled(void)
>  {
> -	return static_branch_unlikely(&memcg_kmem_enabled_key);
> +	return static_branch_likely(&memcg_kmem_enabled_key);
>  }
>  
>  static inline bool memcg_kmem_bypass(void)
> 


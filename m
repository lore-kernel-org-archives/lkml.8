Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC5BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88A12084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbgEZKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388486AbgEZKw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:52:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3477EAC4A;
        Tue, 26 May 2020 10:52:28 +0000 (UTC)
Subject: Re: [PATCH v3 15/19] mm: memcg/slab: deprecate slab_root_caches
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-16-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <613dda66-4fa6-1820-50c4-c7b28235e687@suse.cz>
Date:   Tue, 26 May 2020 12:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-16-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:47 PM, Roman Gushchin wrote:
> Currently there are two lists of kmem_caches:
> 1) slab_caches, which contains all kmem_caches,
> 2) slab_root_caches, which contains only root kmem_caches.
> 
> And there is some preprocessor magic to have a single list
> if CONFIG_MEMCG_KMEM isn't enabled.
> 
> It was required earlier because the number of non-root kmem_caches
> was proportional to the number of memory cgroups and could reach
> really big values. Now, when it cannot exceed the number of root
> kmem_caches, there is really no reason to maintain two lists.
> 
> We never iterate over the slab_root_caches list on any hot paths,
> so it's perfectly fine to iterate over slab_caches and filter out
> non-root kmem_caches.
> 
> It allows to remove a lot of config-dependent code and two pointers
> from the kmem_cache structure.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> @@ -1148,11 +1126,12 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
>  
>  static int slab_show(struct seq_file *m, void *p)
>  {
> -	struct kmem_cache *s = list_entry(p, struct kmem_cache, root_caches_node);
> +	struct kmem_cache *s = list_entry(p, struct kmem_cache, list);
>  
> -	if (p == slab_root_caches.next)
> +	if (p == slab_caches.next)
>  		print_slabinfo_header(m);
> -	cache_show(s, m);
> +	if (is_root_cache(s))
> +		cache_show(s, m);

If there wasn't patch 17/19 we could just remove this condition and have
/proc/slabinfo contain the -memcg variants?


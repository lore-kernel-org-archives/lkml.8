Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8379C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB87B20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390648AbgE0PzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:55:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:40590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390625AbgE0Pyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:54:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 21872AFD1;
        Wed, 27 May 2020 15:54:54 +0000 (UTC)
Subject: Re: [PATCH v4 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-11-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2dc94375-2ac6-9dd7-64e8-6e66aeb3a662@suse.cz>
Date:   Wed, 27 May 2020 17:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526214227.989341-11-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 11:42 PM, Roman Gushchin wrote:
> Deprecate memory.kmem.slabinfo.
> 
> An empty file will be presented if corresponding config options are
> enabled.
> 
> The interface is implementation dependent, isn't present in cgroup v2,
> and is generally useful only for core mm debugging purposes. In other
> words, it doesn't provide any value for the absolute majority of users.
> 
> A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
> It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output
> and also allows to get any additional information without a need
> to recompile the kernel.
> 
> If a drgn-based solution is too slow for a task, a bpf-based tracing
> tool can be used, which can easily keep track of all slab allocations
> belonging to a memory cgroup.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Also there was a
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
for this patch.
And here's mine:
Acked-by: Vlastimil Babka <vbabka@suse.cz>

Of course this depends on whether we break somebody's workflow and they complain.

> ---
>  mm/memcontrol.c  |  3 ---
>  mm/slab_common.c | 31 ++++---------------------------
>  2 files changed, 4 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ed12bff81ea5..eca03e13c7ec 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5052,9 +5052,6 @@ static struct cftype mem_cgroup_legacy_files[] = {
>  	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
>  	{
>  		.name = "kmem.slabinfo",
> -		.seq_start = memcg_slab_start,
> -		.seq_next = memcg_slab_next,
> -		.seq_stop = memcg_slab_stop,
>  		.seq_show = memcg_slab_show,
>  	},
>  #endif
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b578ae29c743..3c89c2adc930 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1523,35 +1523,12 @@ void dump_unreclaimable_slab(void)
>  }
>  
>  #if defined(CONFIG_MEMCG_KMEM)
> -void *memcg_slab_start(struct seq_file *m, loff_t *pos)
> -{
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -
> -	mutex_lock(&slab_mutex);
> -	return seq_list_start(&memcg->kmem_caches, *pos);
> -}
> -
> -void *memcg_slab_next(struct seq_file *m, void *p, loff_t *pos)
> -{
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -
> -	return seq_list_next(p, &memcg->kmem_caches, pos);
> -}
> -
> -void memcg_slab_stop(struct seq_file *m, void *p)
> -{
> -	mutex_unlock(&slab_mutex);
> -}
> -
>  int memcg_slab_show(struct seq_file *m, void *p)
>  {
> -	struct kmem_cache *s = list_entry(p, struct kmem_cache,
> -					  memcg_params.kmem_caches_node);
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -
> -	if (p == memcg->kmem_caches.next)
> -		print_slabinfo_header(m);
> -	cache_show(s, m);
> +	/*
> +	 * Deprecated.
> +	 * Please, take a look at tools/cgroup/slabinfo.py .
> +	 */
>  	return 0;
>  }
>  #endif
> 


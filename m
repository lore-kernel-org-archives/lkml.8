Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB37C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B43F20835
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591386792;
	bh=pj/rmOWc43aEhpJHPHGBw5QDatUkRcMOfzViFQxp4ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bH0aWfOQo9LPpUidmwRMh68sNMZgoC4dff2HPG84obpye2XUIKHVgr85xCKjw0XWN
	 1G7BrQUIi8FTaHXDcrOn79qXCjjPOYeuJvPr1JqSwzYmK87IbtfKYIGRZLwcGr2i/m
	 vSIrHm86+lDbNvGUWz+zM/lqaPrEGm2qMPfHWlUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFETxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:53:11 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42961 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgFETxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:53:11 -0400
Received: by mail-vk1-f196.google.com with SMTP id m18so2509976vkk.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dG+tyl0Efw+V2xYi/E+lY+R4XFXPtJNWblGO5xy6LPI=;
        b=nGK+ZT+mcSPBPXLHS6viKfajxFCm+OPAXzqaVPvSJbNvLhQsqmAfPSselgFgM4PGai
         5ntpJz/OkKvTmt/prJ2w32iH4BOAOyog8Z6rEMA17uf3j4Ik/tQesSYSqRoyMkDPRunE
         tdfNaewb0HSdVS2pBK2gu92KY8w2zbQ2GgoUMOODz53KFpEa4rSCSJjOrCaDWXpmxRhW
         GdIJZMxbjncyqlFoNrbwtboiBlW/yyrqEFWjW1rj0xvhTU9tcN6mNXaCjhTdH6B+NXwO
         ug3yW1ROQUpiO/bXqJxyb33iLYY1f+Xm2kNP76YZY+i3NZhwbER6h0zSBziPUqSbtjzJ
         O79w==
X-Gm-Message-State: AOAM5330AV54Ux99Rc5JIPWZqjaUplruaL9NwwN07QMAhuEP8eObRsQl
        lA4vGSeZ5k0S0p4YafnNRPY=
X-Google-Smtp-Source: ABdhPJzvjBL+h4Rv3ZNeOwZlX2Qb1zirQLvvU0rjQfAfnnCbJnzh6RgC0/KStz3t1+A6TMZpdazAqQ==
X-Received: by 2002:a05:6122:34:: with SMTP id q20mr8815965vkd.66.1591386789948;
        Fri, 05 Jun 2020 12:53:09 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id k48sm208138uae.11.2020.06.05.12.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 12:53:09 -0700 (PDT)
Date:   Fri, 5 Jun 2020 19:53:08 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] mm: memcg/percpu: per-memcg percpu memory
 statistics
Message-ID: <20200605195308.GC224745@google.com>
References: <20200528232508.1132382-1-guro@fb.com>
 <20200528232508.1132382-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528232508.1132382-4-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:25:06PM -0700, Roman Gushchin wrote:
> Percpu memory can represent a noticeable chunk of the total
> memory consumption, especially on big machines with many CPUs.
> Let's track percpu memory usage for each memcg and display
> it in memory.stat.
> 
> A percpu allocation is usually scattered over multiple pages
> (and nodes), and can be significantly smaller than a page.
> So let's add a byte-sized counter on the memcg level:
> MEMCG_PERCPU_B. Byte-sized vmstat infra created for slabs
> can be perfectly reused for percpu case.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  4 ++++
>  include/linux/memcontrol.h              |  8 ++++++++
>  mm/memcontrol.c                         |  4 +++-
>  mm/percpu.c                             | 10 ++++++++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index fed4e1d2a343..aa8cb6dadadc 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1276,6 +1276,10 @@ PAGE_SIZE multiple when read back.
>  		Amount of memory used for storing in-kernel data
>  		structures.
>  
> +	  percpu
> +		Amount of memory used for storing per-cpu kernel
> +		data structures.
> +
>  	  sock
>  		Amount of memory used in network transmission buffers
>  
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7a84d9164449..f62a95d472f7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -32,11 +32,19 @@ struct kmem_cache;
>  enum memcg_stat_item {
>  	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
>  	MEMCG_SOCK,
> +	MEMCG_PERCPU_B,
>  	/* XXX: why are these zone and not node counters? */
>  	MEMCG_KERNEL_STACK_KB,
>  	MEMCG_NR_STAT,
>  };
>  
> +static __always_inline bool memcg_stat_item_in_bytes(enum memcg_stat_item item)
> +{
> +	if (item == MEMCG_PERCPU_B)
> +		return true;
> +	return vmstat_item_in_bytes(item);
> +}
> +
>  enum memcg_memory_event {
>  	MEMCG_LOW,
>  	MEMCG_HIGH,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7bc3fd196210..5007d1585a4a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -783,7 +783,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	if (vmstat_item_in_bytes(idx))
> +	if (memcg_stat_item_in_bytes(idx))
>  		threshold <<= PAGE_SHIFT;
>  
>  	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
> @@ -1490,6 +1490,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	seq_buf_printf(&s, "slab %llu\n",
>  		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
>  			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B)));
> +	seq_buf_printf(&s, "percpu %llu\n",
> +		       (u64)memcg_page_state(memcg, MEMCG_PERCPU_B));
>  	seq_buf_printf(&s, "sock %llu\n",
>  		       (u64)memcg_page_state(memcg, MEMCG_SOCK) *
>  		       PAGE_SIZE);
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 85f5755c9114..b4b3e9c8a6d1 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1608,6 +1608,11 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
>  
>  	if (chunk) {
>  		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = objcg;
> +
> +		rcu_read_lock();
> +		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
> +				size * num_possible_cpus());
> +		rcu_read_unlock();
>  	} else {
>  		obj_cgroup_uncharge(objcg, size * num_possible_cpus());
>  		obj_cgroup_put(objcg);
> @@ -1626,6 +1631,11 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
>  
>  	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
>  
> +	rcu_read_lock();
> +	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
> +			-(size * num_possible_cpus()));
> +	rcu_read_unlock();
> +
>  	obj_cgroup_put(objcg);
>  }
>  
> -- 
> 2.25.4
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

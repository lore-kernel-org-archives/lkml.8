Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16D020772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591191522;
	bh=niH3EBG4nIikXOI52cce+Q9m8q8i7LIxZi+Uw4ZF7s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oQNYm5JYdV4TVrBQJKcKRheuWnxHxUloJQs2AqYIXNT9FlYBWCCMTeoOTpHDF4B7/
	 q/45YfFHUNbU7QK01zMRR+beAW9bVl8U7bBZFQhvxajMBkZUQGbXL9QqImuWvR4MlO
	 0yF6kDGQuubW0HOLoVP/fUmhbU2pIFSjiIYAXbc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFCNim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:38:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37310 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:38:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so1786427edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xAdxD9hW1kmd8sauccdCWluhQotrneTI9OgJKilTmaE=;
        b=ZKkzRo+7MO/0wd1Pi49prtWqfLqFUK0tU562suyRWv5iAqOl1voaUHg2VMVnKm0+cY
         BIV8VbQymSvITHC1J8mqree/7WNgq4sz5ceUGJLflW2aQ5Whq0CcuCFVEW66OT6ksxSd
         u7OCQJoXSwerJ/NPR9g1Tyka/Qu4P6FgP1tvk3nMNyLP39dH12xnu9iJ0rG418tsLGYi
         np0wU73z6BanLUijBombfcHSRu7VxyrWPqXIlD7q2ATLGL0CLpMEZgTJnDMA5SprXk/y
         Vtglk8p5qyLl6yq0rNv+8u/Tlj1EACVLxpYPhW6wLg+rIJG/nhUJFLewz10SGt9WlY4G
         G4Aw==
X-Gm-Message-State: AOAM531ryCpsgXEmwCWs5ZlTZvd49rw2JlFCmV0bfBKcQ6wVikDvQEzu
        Dmg7Se8HgPEz12/XCyNFQgA=
X-Google-Smtp-Source: ABdhPJyn8NAPERbh0gZvLTzVYGqGoErmTy10wV6pKp4ZCl17JJCfz12EUbwikIQdUvr23Z9Nvp4Lqw==
X-Received: by 2002:aa7:d9d3:: with SMTP id v19mr30012498eds.364.1591191518790;
        Wed, 03 Jun 2020 06:38:38 -0700 (PDT)
Received: from localhost (ip-37-188-178-109.eurotel.cz. [37.188.178.109])
        by smtp.gmail.com with ESMTPSA id z20sm1108435ejb.68.2020.06.03.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 06:38:37 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:38:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        andi.kleen@intel.com, tim.c.chen@intel.com, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] mm: adjust vm_committed_as_batch according to vm
 overcommit policy
Message-ID: <20200603133837.GL7533@dhcp22.suse.cz>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
 <1590714370-67182-5-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590714370-67182-5-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-05-20 09:06:10, Feng Tang wrote:
> When checking a performance change for will-it-scale scalability mmap test
> [1], we found very high lock contention for spinlock of percpu counter
> 'vm_committed_as':
> 
>     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
>     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
>     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> 
> Actually this heavy lock contention is not always necessary.  The
> 'vm_committed_as' needs to be very precise when the strict
> OVERCOMMIT_NEVER policy is set, which requires a rather small batch number
> for the percpu counter.
> 
> So keep 'batch' number unchanged for strict OVERCOMMIT_NEVER policy, and
> lift it to 64X for OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS policies.  Also
> add a sysctl handler to adjust it when the policy is reconfigured.
> 
> Benchmark with the same testcase in [1] shows 53% improvement on a 8C/16T
> desktop, and 2097%(20X) on a 4S/72C/144T server.  We tested with test
> platforms in 0day (server, desktop and laptop), and 80%+ platforms shows
> improvements with that test.  And whether it shows improvements depends on
> if the test mmap size is bigger than the batch number computed.
> 
> And if the lift is 16X, 1/3 of the platforms will show improvements,
> though it should help the mmap/unmap usage generally, as Michal Hocko
> mentioned:
> 
> : I believe that there are non-synthetic worklaods which would benefit from
> : a larger batch.  E.g.  large in memory databases which do large mmaps
> : during startups from multiple threads.
> 
> [1] https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
> 
> Link: http://lkml.kernel.org/r/1589611660-89854-4-git-send-email-feng.tang@intel.com
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andi Kleen <andi.kleen@intel.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mm.h   |  2 ++
>  include/linux/mman.h |  4 ++++
>  kernel/sysctl.c      |  2 +-
>  mm/mm_init.c         | 18 ++++++++++++++----
>  mm/util.c            | 12 ++++++++++++
>  5 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 573947c..c2efea6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -206,6 +206,8 @@ int overcommit_ratio_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
>  int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> +int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
> +		loff_t *);
>  
>  #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>  
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 4b08e9c..91c93c1 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -57,8 +57,12 @@ extern struct percpu_counter vm_committed_as;
>  
>  #ifdef CONFIG_SMP
>  extern s32 vm_committed_as_batch;
> +extern void mm_compute_batch(void);
>  #else
>  #define vm_committed_as_batch 0
> +static inline void mm_compute_batch(void)
> +{
> +}
>  #endif
>  
>  unsigned long vm_memory_committed(void);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index db1ce7a..9456c86 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2650,7 +2650,7 @@ static struct ctl_table vm_table[] = {
>  		.data		= &sysctl_overcommit_memory,
>  		.maxlen		= sizeof(sysctl_overcommit_memory),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= overcommit_policy_handler,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= &two,
>  	},
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 435e5f7..c5a6fb1 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -13,6 +13,7 @@
>  #include <linux/memory.h>
>  #include <linux/notifier.h>
>  #include <linux/sched.h>
> +#include <linux/mman.h>
>  #include "internal.h"
>  
>  #ifdef CONFIG_DEBUG_MEMORY_INIT
> @@ -144,14 +145,23 @@ EXPORT_SYMBOL_GPL(mm_kobj);
>  #ifdef CONFIG_SMP
>  s32 vm_committed_as_batch = 32;
>  
> -static void __meminit mm_compute_batch(void)
> +void mm_compute_batch(void)
>  {
>  	u64 memsized_batch;
>  	s32 nr = num_present_cpus();
>  	s32 batch = max_t(s32, nr*2, 32);
> -
> -	/* batch size set to 0.4% of (total memory/#cpus), or max int32 */
> -	memsized_batch = min_t(u64, (totalram_pages()/nr)/256, 0x7fffffff);
> +	unsigned long ram_pages = totalram_pages();
> +
> +	/*
> +	 * For policy of OVERCOMMIT_NEVER, set batch size to 0.4%
> +	 * of (total memory/#cpus), and lift it to 25% for other
> +	 * policies to easy the possible lock contention for percpu_counter
> +	 * vm_committed_as, while the max limit is INT_MAX
> +	 */
> +	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> +		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
> +	else
> +		memsized_batch = min_t(u64, ram_pages/nr/4, INT_MAX);
>  
>  	vm_committed_as_batch = max_t(s32, memsized_batch, batch);
>  }
> diff --git a/mm/util.c b/mm/util.c
> index fe63271..580d268 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -746,6 +746,18 @@ int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
>  	return ret;
>  }
>  
> +int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
> +		size_t *lenp, loff_t *ppos)
> +{
> +	int ret;
> +
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	if (ret == 0 && write)
> +		mm_compute_batch();
> +
> +	return ret;
> +}
> +
>  int overcommit_kbytes_handler(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos)
>  {
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs

Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B55FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640662065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589528495;
	bh=2hj9COhXxsNvy56RptVnR/klSCKzzb/kwexjWG1g73s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E9SaN1dIjxYuShlTHYsBOnf67Ik9Sc+ALzuKRrajc7qljlPFLhENeVqr0htWKYnSt
	 /kAElvzbeLmLmmkduU26qVfuY7LzynnlTy8X4bF1/2UGZ5awetmYLyBocu6OHxr8Yc
	 TwMVR+7P2XJlBA5+R94hQvp+TIfnnptGrXDBoqOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgEOHle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:41:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40184 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgEOHlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:41:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so2312633wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kns14HbaP0c1lE2MwJ7v5s2pJzjyzLnxLUIpMzdDsM4=;
        b=fC6wVFvEsxOJS+LJE8U57D9zk5rh/IoaIX8cIe39i7R4J9E1OdiNpIHbHm282qwFzX
         cmnIu/0S1Gogmsova4eUP71ABqXgxpt+Vi+lRp6lIY5/LUtJt7n9Mhfoi1bGxVDsbk9y
         fKTC2qJ0BOWKWIZJNMgLdb6bfl/aDtAA28iLUQdvfI7vJkX82J6Xnand1oyb3sXXP+Ec
         eb2Hzvxmr6o7DBmlyxXJPtt9pkKHDMWYZ4W3UBtI1EccdHa+R3Ger7MZz3bDAnfiu9YZ
         hzNzCVeUtJVBdOdwgULe4Y49bsDeKYdkexsyFfC/KRQPHyQrn014hSME3hiZL03hRovS
         ozdg==
X-Gm-Message-State: AOAM530Ke6ijUqs+3iBtn8B2ACL1RqYfKDJvl1ZlwjVt/UHdWQYZEyO3
        TR3Lcq8agY7MIxtqdnA/LMc=
X-Google-Smtp-Source: ABdhPJxkQm4wcb2otWahvuSXI6T8PGegoI+XGijl8LbVKi7oXi9T6Mpv1K0OLZpEZXlo126o5SxfeA==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr2800656wrr.260.1589528487966;
        Fri, 15 May 2020 00:41:27 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id t22sm2216596wmj.37.2020.05.15.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:41:27 -0700 (PDT)
Date:   Fri, 15 May 2020 09:41:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: adjust vm_committed_as_batch according to vm
 overcommit policy
Message-ID: <20200515074125.GH29153@dhcp22.suse.cz>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-4-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588922717-63697-4-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-05-20 15:25:17, Feng Tang wrote:
> When checking a performance change for will-it-scale scalability
> mmap test [1], we found very high lock contention for spinlock of
> percpu counter 'vm_committed_as':
> 
>     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
>     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
>     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> 
> Actually this heavy lock contention is not always necessary. The
> 'vm_committed_as' needs to be very precise when the strict
> OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> number for the percpu counter.
> 
> So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
> OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
> when the policy is reconfigured.

Increasing the batch size for weaker overcommit modes makes sense. But
your patch is also tuning OVERCOMMIT_NEVER without any explanation why
that is still "small enough to be precise".

> Benchmark with the same testcase in [1] shows 53% improvement on a
> 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
> for some platforms, due to the test mmap size of the case is bigger
> than the batch number computed, though the patch will help mmap/munmap
> generally.
> 
> [1] https://lkml.org/lkml/2020/3/5/57

Please do not use lkml.org links in the changelog. Use
http://lkml.kernel.org/r/$msg instead.

> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  include/linux/mm.h   |  2 ++
>  include/linux/mman.h |  4 ++++
>  kernel/sysctl.c      |  2 +-
>  mm/mm_init.c         | 19 +++++++++++++++----
>  mm/util.c            | 13 +++++++++++++
>  5 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5a32342..bc3722f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -205,6 +205,8 @@ extern int overcommit_ratio_handler(struct ctl_table *, int, void __user *,
>  				    size_t *, loff_t *);
>  extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
>  				    size_t *, loff_t *);
> +extern int overcommit_policy_handler(struct ctl_table *, int, void __user *,
> +				    size_t *, loff_t *);
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
> index 8a176d8..6fa552d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1278,7 +1278,7 @@ static struct ctl_table vm_table[] = {
>  		.data		= &sysctl_overcommit_memory,
>  		.maxlen		= sizeof(sysctl_overcommit_memory),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= overcommit_policy_handler,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= &two,
>  	},
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 7da6991..1654358 100644
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
> @@ -140,16 +141,26 @@ EXPORT_SYMBOL_GPL(mm_kobj);
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
> +	 * of (total memory/#cpus), and lift it to 6.25% for other
> +	 * policies to easy the possible lock contention for percpu_counter
> +	 * vm_committed_as, while the max limit is INT_MAX
> +	 */
> +	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> +		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
> +	else
> +		memsized_batch = min_t(u64, ram_pages/nr/16, INT_MAX);
>  
>  	vm_committed_as_batch = max_t(s32, memsized_batch, batch);
> +	printk("vm_committed_as_batch = %d\n", vm_committed_as_batch);
>  }
>  
>  static int __meminit mm_compute_batch_notifier(struct notifier_block *self,
> diff --git a/mm/util.c b/mm/util.c
> index 3de78e9..99936d3 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -729,6 +729,19 @@ int overcommit_ratio_handler(struct ctl_table *table, int write,
>  	return ret;
>  }
>  
> +int overcommit_policy_handler(struct ctl_table *table, int write,
> +			     void __user *buffer, size_t *lenp,
> +			     loff_t *ppos)
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
>  int overcommit_kbytes_handler(struct ctl_table *table, int write,
>  			     void __user *buffer, size_t *lenp,
>  			     loff_t *ppos)
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs

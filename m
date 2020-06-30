Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88786C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C0A20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgF3HX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:23:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:54572 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbgF3HX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:23:57 -0400
IronPort-SDR: nD8nU9PpePdJU10+I3ie3f73Xq44tuqACJgNSjAGNDcmffV+h5srK0sYMGND0uzOONNTUKeZ9I
 4eQ4TxG7PmbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="146156727"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="146156727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:23:56 -0700
IronPort-SDR: Z6DVSBBxWsVOci4JsTvqEKZXhdZXf5Uajw2oR9kiGKT0GW/O0dJ9ZVWvcxtMUc5qdfBUd/n45p
 6TvlR8tQXI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="480837296"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2020 00:23:54 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yang.shi@linux.alibaba.com>, <rientjes@google.com>,
        <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 8/8] mm/numa: new reclaim mode to enable reclaim-based migration
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234517.A7EC4BD3@viggo.jf.intel.com>
Date:   Tue, 30 Jun 2020 15:23:53 +0800
In-Reply-To: <20200629234517.A7EC4BD3@viggo.jf.intel.com> (Dave Hansen's
        message of "Mon, 29 Jun 2020 16:45:17 -0700")
Message-ID: <87v9j9ow3a.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

Dave Hansen <dave.hansen@linux.intel.com> writes:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Some method is obviously needed to enable reclaim-based migration.
>
> Just like traditional autonuma, there will be some workloads that
> will benefit like workloads with more "static" configurations where
> hot pages stay hot and cold pages stay cold.  If pages come and go
> from the hot and cold sets, the benefits of this approach will be
> more limited.
>
> The benefits are truly workload-based and *not* hardware-based.
> We do not believe that there is a viable threshold where certain
> hardware configurations should have this mechanism enabled while
> others do not.
>
> To be conservative, earlier work defaulted to disable reclaim-
> based migration and did not include a mechanism to enable it.
> This propses extending the existing "zone_reclaim_mode" (now
> now really node_reclaim_mode) as a method to enable it.
>
> We are open to any alternative that allows end users to enable
> this mechanism or disable it it workload harm is detected (just
> like traditional autonuma).
>
> The implementation here is pretty simple and entirely unoptimized.
> On any memory hotplug events, assume that a node was added or
> removed and recalculate all migration targets.  This ensures that
> the node_demotion[] array is always ready to be used in case the
> new reclaim mode is enabled.  This recalculation is far from
> optimal, most glaringly that it does not even attempt to figure
> out if nodes are actually coming or going.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>
>  b/Documentation/admin-guide/sysctl/vm.rst |    9 ++++
>  b/mm/migrate.c                            |   61 +++++++++++++++++++++++++++++-
>  b/mm/vmscan.c                             |    7 +--
>  3 files changed, 73 insertions(+), 4 deletions(-)
>
> diff -puN Documentation/admin-guide/sysctl/vm.rst~enable-numa-demotion Documentation/admin-guide/sysctl/vm.rst
> --- a/Documentation/admin-guide/sysctl/vm.rst~enable-numa-demotion	2020-06-29 16:35:01.012312549 -0700
> +++ b/Documentation/admin-guide/sysctl/vm.rst	2020-06-29 16:35:01.021312549 -0700
> @@ -941,6 +941,7 @@ This is value OR'ed together of
>  1	(bit currently ignored)
>  2	Zone reclaim writes dirty pages out
>  4	Zone reclaim swaps pages
> +8	Zone reclaim migrates pages
>  =	===================================
>  
>  zone_reclaim_mode is disabled by default.  For file servers or workloads
> @@ -965,3 +966,11 @@ of other processes running on other node
>  Allowing regular swap effectively restricts allocations to the local
>  node unless explicitly overridden by memory policies or cpuset
>  configurations.
> +
> +Page migration during reclaim is intended for systems with tiered memory
> +configurations.  These systems have multiple types of memory with varied
> +performance characteristics instead of plain NUMA systems where the same
> +kind of memory is found at varied distances.  Allowing page migration
> +during reclaim enables these systems to migrate pages from fast tiers to
> +slow tiers when the fast tier is under pressure.  This migration is
> +performed before swap.
> diff -puN mm/migrate.c~enable-numa-demotion mm/migrate.c
> --- a/mm/migrate.c~enable-numa-demotion	2020-06-29 16:35:01.015312549 -0700
> +++ b/mm/migrate.c	2020-06-29 16:35:01.022312549 -0700
> @@ -49,6 +49,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/ptrace.h>
>  #include <linux/oom.h>
> +#include <linux/memory.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -3165,6 +3166,10 @@ void set_migration_target_nodes(void)
>  	 * Avoid any oddities like cycles that could occur
>  	 * from changes in the topology.  This will leave
>  	 * a momentary gap when migration is disabled.
> +	 *
> +	 * This is superfluous for memory offlining since
> +	 * MEM_GOING_OFFLINE does it independently, but it
> +	 * does not hurt to do it a second time.
>  	 */
>  	disable_all_migrate_targets();
>  
> @@ -3211,6 +3216,60 @@ again:
>  	/* Is another pass necessary? */
>  	if (!nodes_empty(next_pass))
>  		goto again;
> +}
>  
> -	put_online_mems();
> +/*
> + * React to hotplug events that might online or offline
> + * NUMA nodes.
> + *
> + * This leaves migrate-on-reclaim transiently disabled
> + * between the MEM_GOING_OFFLINE and MEM_OFFLINE events.
> + * This runs whether RECLAIM_MIGRATE is enabled or not.
> + * That ensures that the user can turn RECLAIM_MIGRATE
> + * without needing to recalcuate migration targets.
> + */
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +						 unsigned long action, void *arg)
> +{
> +	switch (action) {
> +	case MEM_GOING_OFFLINE:
> +		/*
> +		 * Make sure there are not transient states where
> +		 * an offline node is a migration target.  This
> +		 * will leave migration disabled until the offline
> +		 * completes and the MEM_OFFLINE case below runs.
> +		 */
> +		disable_all_migrate_targets();
> +		break;
> +	case MEM_OFFLINE:
> +	case MEM_ONLINE:
> +		/*
> +		 * Recalculate the target nodes once the node
> +		 * reaches its final state (online or offline).
> +		 */
> +		set_migration_target_nodes();
> +		break;
> +	case MEM_CANCEL_OFFLINE:
> +		/*
> +		 * MEM_GOING_OFFLINE disabled all the migration
> +		 * targets.  Reenable them.
> +		 */
> +		set_migration_target_nodes();
> +		break;
> +	case MEM_GOING_ONLINE:
> +	case MEM_CANCEL_ONLINE:
> +		break;
> +	}
> +
> +	return notifier_from_errno(0);
>  }
> +
> +static int __init migrate_on_reclaim_init(void)
> +{
> +	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> +	return 0;
> +}
> +late_initcall(migrate_on_reclaim_init);
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> +
> diff -puN mm/vmscan.c~enable-numa-demotion mm/vmscan.c
> --- a/mm/vmscan.c~enable-numa-demotion	2020-06-29 16:35:01.017312549 -0700
> +++ b/mm/vmscan.c	2020-06-29 16:35:01.023312549 -0700
> @@ -4165,9 +4165,10 @@ int node_reclaim_mode __read_mostly;
>   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>   * ABI.  New bits are OK, but existing bits can never change.
>   */
> -#define RECLAIM_RSVD  (1<<0)	/* (currently ignored/unused) */
> -#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
> -#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
> +#define RECLAIM_RSVD	(1<<0)	/* (currently ignored/unused) */
> +#define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
> +#define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
> +#define RECLAIM_MIGRATE	(1<<3)	/* Migrate pages during reclaim */
>  
>  /*
>   * Priority for NODE_RECLAIM. This determines the fraction of pages

I found that RECLAIM_MIGRATE is defined but never referenced in the
patch.

If my understanding of the code were correct, shrink_do_demote_mapping()
is called by shrink_page_list(), which is used by kswapd and direct
reclaim.  So as long as the persistent memory node is onlined,
reclaim-based migration will be enabled regardless of node reclaim mode.

Best Regards,
Huang, Ying

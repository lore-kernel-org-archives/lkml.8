Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A1C81C46
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B48D2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgD0VSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:18:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:36116 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD0VSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:18:18 -0400
IronPort-SDR: PAMXKWFxGyJESsbIYdnl+s052pXtMm6SkA42CdRbEU5bnc9GMFfaLB07DSvRdb8k4lJnpcQZFJ
 YVnwxRQmpgsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 14:18:17 -0700
IronPort-SDR: oyLJkRsVpue4bj9uOaaHkO/AVLVkNIQkC2gqWstJzoa0BXMpUAta0QkJwbMQ07KrLzI3hHBrqA
 FDkQ9VHEQxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="275611998"
Received: from schen9-mobl.amr.corp.intel.com ([10.255.71.72])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2020 14:18:16 -0700
Subject: Re: [PATCH] swap: Try to scan more free slots even when fragmented
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <20200427030023.264780-1-ying.huang@intel.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <9be88e63-9fc3-108a-4b2e-5185b1938d36@linux.intel.com>
Date:   Mon, 27 Apr 2020 14:18:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200427030023.264780-1-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/20 8:00 PM, Huang Ying wrote:
> Now, the scalability of swap code will drop much when the swap device
> becomes fragmented, because the swap slots allocation batching stops
> working.  To solve the problem, in this patch, we will try to scan a
> little more swap slots with restricted effort to batch the swap slots
> allocation even if the swap device is fragmented.  Test shows that the
> benchmark score can increase up to 37.1% with the patch.  Details are
> as follows.
> 
> The swap code has a per-cpu cache of swap slots.  These batch swap
> space allocations to improve swap subsystem scaling.  In the following
> code path,
> 
>   add_to_swap()
>     get_swap_page()
>       refill_swap_slots_cache()
>         get_swap_pages()
> 	  scan_swap_map_slots()
> 
> scan_swap_map_slots() and get_swap_pages() can return multiple swap
> slots for each call.  These slots will be cached in the per-CPU swap
> slots cache, so that several following swap slot requests will be
> fulfilled there to avoid the lock contention in the lower level swap
> space allocation/freeing code path.
> 
> But this only works when there are free swap clusters.  If a swap
> device becomes so fragmented that there's no free swap clusters,
> scan_swap_map_slots() and get_swap_pages() will return only one swap
> slot for each call in the above code path.  Effectively, this falls
> back to the situation before the swap slots cache was introduced, the
> heavy lock contention on the swap related locks kills the scalability.
> 
> Why does it work in this way?  Because the swap device could be large,
> and the free swap slot scanning could be quite time consuming, to
> avoid taking too much time to scanning free swap slots, the
> conservative method was used.
> 
> In fact, this can be improved via scanning a little more free slots
> with strictly restricted effort.  Which is implemented in this patch.
> In scan_swap_map_slots(), after the first free swap slot is gotten, we
> will try to scan a little more, but only if we haven't scanned too
> many slots (< LATENCY_LIMIT).  That is, the added scanning latency is
> strictly restricted.
> 
> To test the patch, we have run 16-process pmbench memory benchmark on
> a 2-socket server machine with 48 cores.  Multiple ram disks are
> configured as the swap devices.  The pmbench working-set size is much
> larger than the available memory so that swapping is triggered.  The
> memory read/write ratio is 80/20 and the accessing pattern is random,
> so the swap space becomes highly fragmented during the test.  In the
> original implementation, the lock contention on swap related locks is
> very heavy.  The perf profiling data of the lock contention code path
> is as following,
> 
> _raw_spin_lock.get_swap_pages.get_swap_page.add_to_swap:             21.03
> _raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:    1.92
> _raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:      1.72
> _raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:       0.69
> 
> While after applying this patch, it becomes,
> 
> _raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:    4.89
> _raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:      3.85
> _raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:       1.1
> _raw_spin_lock_irqsave.pagevec_lru_move_fn.__lru_cache_add.do_swap_page: 0.88
> 
> That is, the lock contention on the swap locks is eliminated.
> 
> And the pmbench score increases 37.1%.  The swapin throughput
> increases 45.7% from 2.02 GB/s to 2.94 GB/s.  While the swapout
> throughput increases 45.3% from 2.04 GB/s to 2.97 GB/s.
> 

Thanks.  Acked-by: Tim Chen <tim.c.chen@linux.intel.com>

Tim

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>

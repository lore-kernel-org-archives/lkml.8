Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD93C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF1D206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590029466;
	bh=pgJQa1w4GgFyUgPZ73SymaRcnYjxRBW/AIT2HJe0HLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vz6XIXp8SjPt1GjOzQ8dRezCsXhgdlbkDKKqdPQU7+2yzmNU1Wb3kN0M0zZl6WRaY
	 qCOxMW0/5cKRvWbwmRJmds9albu5DrdXnkteAwWNBNDxrzWz5TpHG36EOL9JjAEoZn
	 RBnyIufGo6jjIifZHw8eLH9XuMB+8cQr5QgSig/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgEUCvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 22:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgEUCvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 22:51:04 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD6420756;
        Thu, 21 May 2020 02:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590029463;
        bh=pgJQa1w4GgFyUgPZ73SymaRcnYjxRBW/AIT2HJe0HLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zek0SPJjepnZk3PsEnSKqdkox4ZCbwicJqdnqrTtKclqcasDKhsovb68KfaFRaBRI
         02Svn1GgX1piNuLo5ArMVEPB+A+GMPkyUJDrdGlGDpi5gxTHghZ15jleLPB+J+WJX3
         zwCkeYtP8fyNgWa20Yxz4A1G8niA6f1MSFD1m3QI=
Date:   Wed, 20 May 2020 19:51:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V2] swap: Reduce lock contention on swap cache from
 swap slots allocation
Message-Id: <20200520195102.2343f746e88a2bec5c29ef5b@linux-foundation.org>
In-Reply-To: <20200520031502.175659-1-ying.huang@intel.com>
References: <20200520031502.175659-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 11:15:02 +0800 Huang Ying <ying.huang@intel.com> wrote:

> In some swap scalability test, it is found that there are heavy lock
> contention on swap cache even if we have split one swap cache radix
> tree per swap device to one swap cache radix tree every 64 MB trunk in
> commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
> 
> The reason is as follow.  After the swap device becomes fragmented so
> that there's no free swap cluster, the swap device will be scanned
> linearly to find the free swap slots.  swap_info_struct->cluster_next
> is the next scanning base that is shared by all CPUs.  So nearby free
> swap slots will be allocated for different CPUs.  The probability for
> multiple CPUs to operate on the same 64 MB trunk is high.  This causes
> the lock contention on the swap cache.
> 
> To solve the issue, in this patch, for SSD swap device, a percpu
> version next scanning base (cluster_next_cpu) is added.  Every CPU
> will use its own per-cpu next scanning base.  And after finishing
> scanning a 64MB trunk, the per-cpu scanning base will be changed to
> the beginning of another randomly selected 64MB trunk.  In this way,
> the probability for multiple CPUs to operate on the same 64 MB trunk
> is reduced greatly.  Thus the lock contention is reduced too.  For
> HDD, because sequential access is more important for IO performance,
> the original shared next scanning base is used.
> 
> To test the patch, we have run 16-process pmbench memory benchmark on
> a 2-socket server machine with 48 cores.  One ram disk is configured

What does "ram disk" mean here?  Which drivers(s) are in use and backed
by what sort of memory?

> as the swap device per socket.  The pmbench working-set size is much
> larger than the available memory so that swapping is triggered.  The
> memory read/write ratio is 80/20 and the accessing pattern is random.
> In the original implementation, the lock contention on the swap cache
> is heavy.  The perf profiling data of the lock contention code path is
> as following,
> 
> _raw_spin_lock_irq.add_to_swap_cache.add_to_swap.shrink_page_list:      7.91
> _raw_spin_lock_irqsave.__remove_mapping.shrink_page_list:               7.11
> _raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 2.51
> _raw_spin_lock_irqsave.swap_cgroup_record.mem_cgroup_uncharge_swap:     1.66
> _raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:      1.29
> _raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:         1.03
> _raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:        0.93
> 
> After applying this patch, it becomes,
> 
> _raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 3.58
> _raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:      2.3
> _raw_spin_lock_irqsave.swap_cgroup_record.mem_cgroup_uncharge_swap:     2.26
> _raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:        1.8
> _raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:         1.19
> 
> The lock contention on the swap cache is almost eliminated.
> 
> And the pmbench score increases 18.5%.  The swapin throughput
> increases 18.7% from 2.96 GB/s to 3.51 GB/s.  While the swapout
> throughput increases 18.5% from 2.99 GB/s to 3.54 GB/s.

If this was backed by plain old RAM, can we assume that the performance
improvement on SSD swap is still good?

Does the ram disk actually set SWP_SOLIDSTATE?

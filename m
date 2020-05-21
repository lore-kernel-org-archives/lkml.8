Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4451DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F62078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgEUDYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:24:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:20293 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgEUDYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:24:44 -0400
IronPort-SDR: wMUU3qa+VcsrBcxCSvK9tC9C41uJzIiwY3a+5SIW2gyJ+aJH7mDWFRnPJwxhZQk/UBhTSlWiOY
 bGNqpotPODuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 20:24:43 -0700
IronPort-SDR: EHV0Uh3GxnH+P10cZSaitMKhSTP5RJwQ8lctWSxz4qBGMkuqL0M/i34s3HMOmgiyoHYdVFecWb
 za7uF3x2u3dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="268484539"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2020 20:24:41 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V2] swap: Reduce lock contention on swap cache from swap slots allocation
References: <20200520031502.175659-1-ying.huang@intel.com>
        <20200520195102.2343f746e88a2bec5c29ef5b@linux-foundation.org>
Date:   Thu, 21 May 2020 11:24:40 +0800
In-Reply-To: <20200520195102.2343f746e88a2bec5c29ef5b@linux-foundation.org>
        (Andrew Morton's message of "Wed, 20 May 2020 19:51:02 -0700")
Message-ID: <87o8qihsw7.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 20 May 2020 11:15:02 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
>> In some swap scalability test, it is found that there are heavy lock
>> contention on swap cache even if we have split one swap cache radix
>> tree per swap device to one swap cache radix tree every 64 MB trunk in
>> commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
>> 
>> The reason is as follow.  After the swap device becomes fragmented so
>> that there's no free swap cluster, the swap device will be scanned
>> linearly to find the free swap slots.  swap_info_struct->cluster_next
>> is the next scanning base that is shared by all CPUs.  So nearby free
>> swap slots will be allocated for different CPUs.  The probability for
>> multiple CPUs to operate on the same 64 MB trunk is high.  This causes
>> the lock contention on the swap cache.
>> 
>> To solve the issue, in this patch, for SSD swap device, a percpu
>> version next scanning base (cluster_next_cpu) is added.  Every CPU
>> will use its own per-cpu next scanning base.  And after finishing
>> scanning a 64MB trunk, the per-cpu scanning base will be changed to
>> the beginning of another randomly selected 64MB trunk.  In this way,
>> the probability for multiple CPUs to operate on the same 64 MB trunk
>> is reduced greatly.  Thus the lock contention is reduced too.  For
>> HDD, because sequential access is more important for IO performance,
>> the original shared next scanning base is used.
>> 
>> To test the patch, we have run 16-process pmbench memory benchmark on
>> a 2-socket server machine with 48 cores.  One ram disk is configured
>
> What does "ram disk" mean here?  Which drivers(s) are in use and backed
> by what sort of memory?

We use the following kernel command line

memmap=48G!6G memmap=48G!68G

to create 2 DRAM based /dev/pmem disks (48GB each).  Then we use these
ram disks as swap devices.

>> as the swap device per socket.  The pmbench working-set size is much
>> larger than the available memory so that swapping is triggered.  The
>> memory read/write ratio is 80/20 and the accessing pattern is random.
>> In the original implementation, the lock contention on the swap cache
>> is heavy.  The perf profiling data of the lock contention code path is
>> as following,
>> 
>> _raw_spin_lock_irq.add_to_swap_cache.add_to_swap.shrink_page_list:      7.91
>> _raw_spin_lock_irqsave.__remove_mapping.shrink_page_list:               7.11
>> _raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 2.51
>> _raw_spin_lock_irqsave.swap_cgroup_record.mem_cgroup_uncharge_swap:     1.66
>> _raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:      1.29
>> _raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:         1.03
>> _raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:        0.93
>> 
>> After applying this patch, it becomes,
>> 
>> _raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 3.58
>> _raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:      2.3
>> _raw_spin_lock_irqsave.swap_cgroup_record.mem_cgroup_uncharge_swap:     2.26
>> _raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:        1.8
>> _raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:         1.19
>> 
>> The lock contention on the swap cache is almost eliminated.
>> 
>> And the pmbench score increases 18.5%.  The swapin throughput
>> increases 18.7% from 2.96 GB/s to 3.51 GB/s.  While the swapout
>> throughput increases 18.5% from 2.99 GB/s to 3.54 GB/s.
>
> If this was backed by plain old RAM, can we assume that the performance
> improvement on SSD swap is still good?

We need really fast disk to show the benefit.  I have tried this on 2
Intel P3600 NVMe disks.  The performance improvement is only about 1%.
The improvement should be better on the faster disks, such as Intel
Optane disk.  I will try to find some to test.

> Does the ram disk actually set SWP_SOLIDSTATE?

Yes.  "blk_queue_flag_set(QUEUE_FLAG_NONROT, q)" is called in
drivers/nvdimm/pmem.c.

Best Regards,
Huang, Ying

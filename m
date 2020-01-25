Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8E4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1A12072C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgAYBX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:23:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:57666 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAYBX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:23:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 17:23:25 -0800
X-IronPort-AV: E=Sophos;i="5.70,359,1574150400"; 
   d="scan'208";a="260436197"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 17:23:25 -0800
Subject: [PATCH v5] mm/memory_hotplug: Fix remove_memory() lockdep splat
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Jan 2020 17:07:21 -0800
Message-ID: <157991441887.2763922.4770790047389427325.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The daxctl unit test for the dax_kmem driver currently triggers the
(false positive) lockdep splat below. It results from the fact that
remove_memory_block_devices() is invoked under the mem_hotplug_lock()
causing lockdep entanglements with cpu_hotplug_lock() and sysfs (kernfs
active state tracking). It is a false positive because the sysfs
attribute path triggering the memory remove is not the same attribute
path associated with memory-block device.

sysfs_break_active_protection() is not applicable since there is no real
deadlock conflict, instead move memory-block device removal outside the
lock. The mem_hotplug_lock() is not needed to synchronize the
memory-block device removal vs the page online state, that is already
handled by lock_device_hotplug(). Specifically, lock_device_hotplug() is
sufficient to allow try_remove_memory() to check the offline state of
the memblocks and be assured that any in progress online attempts are
flushed / blocked by kernfs_drain() / attribute removal.

The add_memory() path safely creates memblock devices under the
mem_hotplug_lock(). There is no kernfs active state synchronization in
the memblock device_register() path, so nothing to fix there.

This change is only possible thanks to the recent change that refactored
memory block device removal out of arch_remove_memory() (commit
4c4b7f9ba948 mm/memory_hotplug: remove memory block devices before
arch_remove_memory()), and David's due diligence tracking down the
guarantees afforded by kernfs_drain(). Not flagged for -stable since
this only impacts ongoing development and lockdep validation, not a
runtime issue.

    ======================================================
    WARNING: possible circular locking dependency detected
    5.5.0-rc3+ #230 Tainted: G           OE
    ------------------------------------------------------
    lt-daxctl/6459 is trying to acquire lock:
    ffff99c7f0003510 (kn->count#241){++++}, at: kernfs_remove_by_name_ns+0x41/0x80

    but task is already holding lock:
    ffffffffa76a5450 (mem_hotplug_lock.rw_sem){++++}, at: percpu_down_write+0x20/0xe0

    which lock already depends on the new lock.


    the existing dependency chain (in reverse order) is:

    -> #2 (mem_hotplug_lock.rw_sem){++++}:
           __lock_acquire+0x39c/0x790
           lock_acquire+0xa2/0x1b0
           get_online_mems+0x3e/0xb0
           kmem_cache_create_usercopy+0x2e/0x260
           kmem_cache_create+0x12/0x20
           ptlock_cache_init+0x20/0x28
           start_kernel+0x243/0x547
           secondary_startup_64+0xb6/0xc0

    -> #1 (cpu_hotplug_lock.rw_sem){++++}:
           __lock_acquire+0x39c/0x790
           lock_acquire+0xa2/0x1b0
           cpus_read_lock+0x3e/0xb0
           online_pages+0x37/0x300
           memory_subsys_online+0x17d/0x1c0
           device_online+0x60/0x80
           state_store+0x65/0xd0
           kernfs_fop_write+0xcf/0x1c0
           vfs_write+0xdb/0x1d0
           ksys_write+0x65/0xe0
           do_syscall_64+0x5c/0xa0
           entry_SYSCALL_64_after_hwframe+0x49/0xbe

    -> #0 (kn->count#241){++++}:
           check_prev_add+0x98/0xa40
           validate_chain+0x576/0x860
           __lock_acquire+0x39c/0x790
           lock_acquire+0xa2/0x1b0
           __kernfs_remove+0x25f/0x2e0
           kernfs_remove_by_name_ns+0x41/0x80
           remove_files.isra.0+0x30/0x70
           sysfs_remove_group+0x3d/0x80
           sysfs_remove_groups+0x29/0x40
           device_remove_attrs+0x39/0x70
           device_del+0x16a/0x3f0
           device_unregister+0x16/0x60
           remove_memory_block_devices+0x82/0xb0
           try_remove_memory+0xb5/0x130
           remove_memory+0x26/0x40
           dev_dax_kmem_remove+0x44/0x6a [kmem]
           device_release_driver_internal+0xe4/0x1c0
           unbind_store+0xef/0x120
           kernfs_fop_write+0xcf/0x1c0
           vfs_write+0xdb/0x1d0
           ksys_write+0x65/0xe0
           do_syscall_64+0x5c/0xa0
           entry_SYSCALL_64_after_hwframe+0x49/0xbe

    other info that might help us debug this:

    Chain exists of:
      kn->count#241 --> cpu_hotplug_lock.rw_sem --> mem_hotplug_lock.rw_sem

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(mem_hotplug_lock.rw_sem);
                                   lock(cpu_hotplug_lock.rw_sem);
                                   lock(mem_hotplug_lock.rw_sem);
      lock(kn->count#241);

     *** DEADLOCK ***

No fixes tag as this has been a long standing issue that predated the
addition of kernfs lockdep annotations.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v4 [1]:
- Drop the unnecessary consideration of mem->section_count.
  kernfs_drain() + lock_device_hotplug() is sufficient protection
  (David)

[1]: http://lore.kernel.org/r/157869128062.2451572.4093315441083744888.stgit@dwillia2-desk3.amr.corp.intel.com

 mm/memory_hotplug.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 55ac23ef11c1..65ddaf3a2a12 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1763,8 +1763,6 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
-	mem_hotplug_begin();
-
 	/*
 	 * All memory blocks must be offlined before removing memory.  Check
 	 * whether all memory blocks in question are offline and return error
@@ -1777,9 +1775,14 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size, "System RAM");
 
-	/* remove memory block devices before removing memory */
+	/*
+	 * Memory block device removal under the device_hotplug_lock is
+	 * a barrier against racing online attempts.
+	 */
 	remove_memory_block_devices(start, size);
 
+	mem_hotplug_begin();
+
 	arch_remove_memory(nid, start, size, NULL);
 	memblock_free(start, size);
 	memblock_remove(start, size);


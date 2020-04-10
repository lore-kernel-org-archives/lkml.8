Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C0C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91132074F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgDJAZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:25:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:22377 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgDJAZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:25:47 -0400
IronPort-SDR: nTvSJ317aJEv2mbE1gkbGgRazxrqZNU4/Z0cDC1t2Z5Bt1IZLK0G7vJc2PCqgwAC3M1ns0zP/6
 TfOGs0NPdZ6A==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 17:25:44 -0700
IronPort-SDR: ADZrr5nwyluEcAmuZbbvxo5DLZ9HdWsRMgkrDz34Ra1xb0K9SN5awMyJs+YoUHf2MixS3rPL7r
 3pNd6VUhLV3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; 
   d="xz'?gz'50?scan'50,208,50";a="276021443"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2020 17:25:42 -0700
Date:   Fri, 10 Apr 2020 08:25:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
Subject: f45ec5ff16 ("userfaultfd: wp: support swap and page migration"): [
  140.777858] BUG: Bad rss-counter state mm:b278fc66 type:MM_ANONPAGES val:1
Message-ID: <20200410002518.GG8179@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cxfMsoqvp1jUizWj"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit f45ec5ff16a75f96dac8c89862d75f1d8739efd4
Author:     Peter Xu <peterx@redhat.com>
AuthorDate: Mon Apr 6 20:06:01 2020 -0700
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Tue Apr 7 10:43:39 2020 -0700

    userfaultfd: wp: support swap and page migration
    
    For either swap and page migration, we all use the bit 2 of the entry to
    identify whether this entry is uffd write-protected.  It plays a similar
    role as the existing soft dirty bit in swap entries but only for keeping
    the uffd-wp tracking for a specific PTE/PMD.
    
    Something special here is that when we want to recover the uffd-wp bit
    from a swap/migration entry to the PTE bit we'll also need to take care of
    the _PAGE_RW bit and make sure it's cleared, otherwise even with the
    _PAGE_UFFD_WP bit we can't trap it at all.
    
    In change_pte_range() we do nothing for uffd if the PTE is a swap entry.
    That can lead to data mismatch if the page that we are going to write
    protect is swapped out when sending the UFFDIO_WRITEPROTECT.  This patch
    also applies/removes the uffd-wp bit even for the swap entries.
    
    Signed-off-by: Peter Xu <peterx@redhat.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Cc: Andrea Arcangeli <aarcange@redhat.com>
    Cc: Bobby Powers <bobbypowers@gmail.com>
    Cc: Brian Geffon <bgeffon@google.com>
    Cc: David Hildenbrand <david@redhat.com>
    Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
    Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
    Cc: Hugh Dickins <hughd@google.com>
    Cc: Jerome Glisse <jglisse@redhat.com>
    Cc: Johannes Weiner <hannes@cmpxchg.org>
    Cc: "Kirill A . Shutemov" <kirill@shutemov.name>
    Cc: Martin Cracauer <cracauer@cons.org>
    Cc: Marty McFadden <mcfadden8@llnl.gov>
    Cc: Maya Gokhale <gokhale2@llnl.gov>
    Cc: Mel Gorman <mgorman@suse.de>
    Cc: Mike Kravetz <mike.kravetz@oracle.com>
    Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
    Cc: Pavel Emelyanov <xemul@openvz.org>
    Cc: Rik van Riel <riel@redhat.com>
    Cc: Shaohua Li <shli@fb.com>
    Link: http://lkml.kernel.org/r/20200220163112.11409-11-peterx@redhat.com
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

2e3d5dc508  userfaultfd: wp: add pmd_swp_*uffd_wp() helpers
f45ec5ff16  userfaultfd: wp: support swap and page migration
5d30bcacd9  Merge tag '9p-for-5.7-2' of git://github.com/martinetd/linux
+-------------------------------------------------------------------------------------------------+------------+------------+------------+
|                                                                                                 | 2e3d5dc508 | f45ec5ff16 | 5d30bcacd9 |
+-------------------------------------------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                                                  | 651        | 193        | 197        |
| boot_failures                                                                                   | 25         | 36         | 32         |
| BUG_pde_opener(Not_tainted):Freepointer_corrupt                                                 | 1          |            |            |
| INFO:Slab#objects=#used=#fp=#flags=                                                             | 1          |            |            |
| INFO:Object#@offset=#fp=                                                                        | 1          |            |            |
| BUG:soft_lockup-CPU##stuck_for#s![swapper:#]                                                    | 1          | 2          |            |
| EIP:new_slab                                                                                    | 2          | 1          |            |
| Kernel_panic-not_syncing:softlockup:hung_tasks                                                  | 2          | 2          | 1          |
| BUG:workqueue_lockup-pool                                                                       | 11         | 8          | 10         |
| INFO:rcu_preempt_self-detected_stall_on_CPU                                                     | 4          | 1          |            |
| EIP:kernel_init_free_pages                                                                      | 1          |            |            |
| INFO:rcu_preempt_detected_stalls_on_CPUs/tasks                                                  | 1          |            |            |
| EIP:iov_iter_copy_from_user_atomic                                                              | 1          | 1          |            |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c3:#]                                                 | 1          |            |            |
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/percpu-rwsem.h               | 1          |            |            |
| EIP:inode_init_once                                                                             | 2          |            |            |
| BUG:kernel_hang_in_early-boot_stage                                                             | 1          |            |            |
| BUG:kernel_hang_in_boot_stage                                                                   | 3          |            |            |
| Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:__schedule                | 1          |            |            |
| WARNING:bad_unlock_balance_detected                                                             | 1          |            |            |
| is_trying_to_release_lock(&port->lock)at                                                        | 1          |            |            |
| Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:native_flush_tlb_one_user | 1          |            |            |
| EIP:clear_user                                                                                  | 1          |            |            |
| BUG:Bad_page_map_in_process                                                                     | 0          | 11         | 10         |
| BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val                                             | 0          | 21         | 16         |
| BUG:Bad_rss-counter_state_mm:#type:MM_SWAPENTS_val                                              | 0          | 10         | 10         |
| BUG:Bad_rss-counter_state_mm:#type:MM_SHMEMPAGES_val                                            | 0          | 20         | 12         |
| BUG:kernel_NULL_pointer_dereference,address                                                     | 0          | 1          | 5          |
| Oops:#[##]                                                                                      | 0          | 1          | 5          |
| EIP:do_swap_page                                                                                | 0          | 1          | 5          |
| Kernel_panic-not_syncing:Fatal_exception                                                        | 0          | 1          | 5          |
| EIP:__slab_alloc                                                                                | 0          | 1          |            |
| Mem-Info                                                                                        | 0          | 0          | 1          |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c1:#]                                                 | 0          | 0          | 1          |
| EIP:copy_user_highpage                                                                          | 0          | 0          | 1          |
+-------------------------------------------------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[child3:925] eventfd (323) returned ENOSYS, marking as inactive.
[  132.014801] can: request_module (can-proto-2) failed.
[  132.063717] can: request_module (can-proto-2) failed.
[  137.186037] trinity-c2 (943) used greatest stack depth: 5804 bytes left
[  140.771486] MCE: Killing trinity-c2:956 due to hardware memory corruption fault at 8bd2060
[  140.777858] BUG: Bad rss-counter state mm:b278fc66 type:MM_ANONPAGES val:1
[  140.778736] BUG: Bad rss-counter state mm:b278fc66 type:MM_SHMEMPAGES val:2
[  141.589424] MCE: Killing trinity-c3:940 due to hardware memory corruption fault at 8a8c860
[  141.590730] swap_info_get: Bad swap file entry 700b8216
[  141.591400] BUG: Bad page map in process trinity-c3  pte:17042c3c pmd:b1809067
[  141.592304] addr:08bcf000 vm_flags:00100073 anon_vma:f1f29528 mapping:00000000 index:8bcf
[  141.593399] file:(null) fault:0x0 mmap:0x0 readpage:0x0
[  141.594065] CPU: 0 PID: 940 Comm: trinity-c3 Not tainted 5.6.0-11490-gf45ec5ff16a75 #1
[  141.595055] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  141.596093] Call Trace:
[  141.596443]  dump_stack+0x16/0x18
[  141.596868]  print_bad_pte+0x13f/0x159
[  141.597367]  unmap_page_range+0x2a7/0x3e7
[  141.597893]  unmap_single_vma+0x53/0x5d
[  141.598383]  unmap_vmas+0x2c/0x3b
[  141.598811]  exit_mmap+0x81/0xfc
[  141.599238]  __mmput+0x25/0x8d
[  141.599633]  mmput+0x28/0x2b
[  141.600007]  do_exit+0x2f0/0x84a
[  141.600449]  ? ___might_sleep+0x3f/0x11f
[  141.600949]  do_group_exit+0x86/0x86
[  141.601421]  __ia32_sys_exit_group+0x15/0x15
[  141.601965]  do_fast_syscall_32+0x86/0xbf
[  141.602481]  entry_SYSENTER_32+0xaf/0x101
[  141.602992] EIP: 0x37f399c9
[  141.603356] Code: 00 00 00 89 d3 eb 02 31 c0 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 1c 24 c3 8b 34 24 c3 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
[  141.605693] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
[  141.606476] ESI: 00000133 EDI: 375c9000 EBP: 375c9030 ESP: 3ffdb5fc
[  141.607245] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000216
[  141.608098] Disabling lock debugging due to kernel taint
[  141.609128] swap_info_get: Bad swap file entry 700b82bf
[  141.610319] BUG: Bad page map in process trinity-c3  pte:17057e3c pmd:b1809067
[  141.611876] addr:08bd0000 vm_flags:00100073 anon_vma:f1f29528 mapping:00000000 index:8bd0
[  141.613716] file:(null) fault:0x0 mmap:0x0 readpage:0x0
[  141.614823] CPU: 0 PID: 940 Comm: trinity-c3 Tainted: G    B             5.6.0-11490-gf45ec5ff16a75 #1
[  141.616853] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  141.618583] Call Trace:
[  141.619121]  dump_stack+0x16/0x18
[  141.619860]  print_bad_pte+0x13f/0x159
[  141.620708]  unmap_page_range+0x2a7/0x3e7
[  141.621645]  unmap_single_vma+0x53/0x5d
[  141.622526]  unmap_vmas+0x2c/0x3b
[  141.623271]  exit_mmap+0x81/0xfc
[  141.624026]  __mmput+0x25/0x8d
[  141.624779]  mmput+0x28/0x2b
[  141.625472]  do_exit+0x2f0/0x84a
[  141.626247]  ? ___might_sleep+0x3f/0x11f
[  141.627189]  do_group_exit+0x86/0x86
[  141.628008]  __ia32_sys_exit_group+0x15/0x15
[  141.629042]  do_fast_syscall_32+0x86/0xbf
[  141.629989]  entry_SYSENTER_32+0xaf/0x101
[  141.630877] EIP: 0x37f399c9
[  141.631521] Code: 8c 13 68 21 00 00 0f 95 c1 0f b6 c9 01 ca eb e1 01 f0 83 ec 0c c6 84 13 68 21 00 00 00 50 67 e8 e1 fd ff ff 8b 75 b4 40 8b 7d <e4> 65 33 3d 14 00 00 00 89 06 8d 83 68 21 00 00 74 05 e8 23 33 fd
[  141.635758] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
[  141.637124] ESI: 00000133 EDI: 375c9000 EBP: 375c9030 ESP: 3ffdb5fc
[  141.638510] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000216
[  141.640039] get_swap_device: Bad swap file entry 700b81c7
[  141.641347] BUG: kernel NULL pointer dereference, address: 00000000
[  141.642639] #PF: supervisor read access in kernel mode
[  141.643765] #PF: error_code(0x0000) - not-present page
[  141.644922] *pde = b1849067 *pte = 1703aa3e 
[  141.645862] Oops: 0000 [#1] PREEMPT
[  141.646638] CPU: 0 PID: 931 Comm: trinity-c3 Tainted: G    B             5.6.0-11490-gf45ec5ff16a75 #1
[  141.648687] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  141.650523] EIP: do_swap_page+0x9a/0x3ee
[  141.651402] Code: f0 00 00 00 00 e9 69 03 00 00 8b 4b 10 8b 55 ec 8b 45 e8 e8 73 1c 01 00 89 c7 85 c0 0f 85 dd 00 00 00 8b 45 e8 e8 a0 3e 01 00 <8b> 00 0f ba e0 0c 0f 83 a5 00 00 00 8b 45 e8 e8 28 3f 01 00 48 0f
[  141.655403] EAX: 00000000 EBX: f328def4 ECX: 00000000 EDX: 00000001
[  141.656763] ESI: 00000254 EDI: 00000000 EBP: f328dee4 ESP: f328dec4
[  141.658042] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  141.659008] CR0: 80050033 CR2: 00000000 CR3: b1f78000 CR4: 000006d0
[  141.660163] Call Trace:
[  141.660589]  handle_mm_fault+0x72e/0x7a9
[  141.661088]  do_user_addr_fault+0x1ef/0x2fb
[  141.661614]  do_page_fault+0xe7/0xef
[  141.662069]  ? kvm_async_pf_task_wake+0x16d/0x16d
[  141.662663]  do_async_page_fault+0x2d/0x67
[  141.663179]  common_exception_read_cr2+0x12f/0x134
[  141.665266] EIP: 0x806840e
[  141.665731] Code: 00 00 00 89 c3 31 c0 81 ec 24 01 00 00 89 54 24 08 8d 54 24 0c 89 d7 f3 ab 8d 4b ff b8 01 00 00 00 d3 e0 c1 e9 05 09 44 8c 0c <85> 04 8d 60 93 a8 08 0f 94 c0 83 ec 04 0f b6 c0 c1 e0 1c 89 84 24
[  141.668623] EAX: 00002000 EBX: 0000000e ECX: 00000000 EDX: 3fb4246c
[  141.669466] ESI: 000000ff EDI: 3fb424ec EBP: fffffffb ESP: 3fb42460
[  141.670244] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[  141.671086] Modules linked in:
[  141.671478] CR2: 0000000000000000
[  141.672000] swap_info_get: Bad swap file entry 700b81d1
[  141.672708] BUG: Bad page map in process trinity-c3  pte:1703a23c pmd:b1809067
[  141.673620] addr:08bd1000 vm_flags:00100073 anon_vma:f1f29528 mapping:00000000 index:8bd1
[  141.674632] file:(null) fault:0x0 mmap:0x0 readpage:0x0
[  141.675286] CPU: 0 PID: 940 Comm: trinity-c3 Tainted: G    B D           5.6.0-11490-gf45ec5ff16a75 #1
[  141.676492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  141.677595] Call Trace:
[  141.677925]  dump_stack+0x16/0x18
[  141.678357]  print_bad_pte+0x13f/0x159
[  141.678836]  unmap_page_range+0x2a7/0x3e7
[  141.679351]  unmap_single_vma+0x53/0x5d
[  141.679839]  unmap_vmas+0x2c/0x3b
[  141.680263]  exit_mmap+0x81/0xfc
[  141.680699]  __mmput+0x25/0x8d
[  141.681091]  mmput+0x28/0x2b
[  141.681476]  do_exit+0x2f0/0x84a
[  141.681890]  ? ___might_sleep+0x3f/0x11f
[  141.682390]  do_group_exit+0x86/0x86
[  141.682848]  __ia32_sys_exit_group+0x15/0x15
[  141.683408]  do_fast_syscall_32+0x86/0xbf
[  141.683922]  entry_SYSENTER_32+0xaf/0x101
[  141.684475] EIP: 0x37f399c9
[  141.684832] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  141.687105] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
[  141.687883] ESI: 00000133 EDI: 375c9000 EBP: 375c9030 ESP: 3ffdb5fc
[  141.688692] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000216
[  141.689599] ---[ end trace 4f92dcfde7686b01 ]---
[  141.690178] EIP: do_swap_page+0x9a/0x3ee

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 5c7efc30142653ff7af43d7343b466309c78bfce 7111951b8d4973bda27ff663f2cf18b663d15b48 --
git bisect good 322665027513e6f98e25091645ca5f4ba19afb44  # 08:41  G     28     0    2   2  Merge 'internal-eywa/eywa' into devel-hourly-2020040904
git bisect  bad 4adc48efc7243b24e3ec5329f4877200d5b26774  # 09:05  B      4     2    0   0  Merge 'internal-linux-review/Revanth-Rajashekar/block-sed-opal-Implement-RevertSP-IOCTL/20200404-080151' into devel-hourly-2020040904
git bisect  bad 622719e6b8ff2655aaf000febd3614449bf6add5  # 09:25  B      9     1    0   0  Merge 'internal-cldemote/pasid.test' into devel-hourly-2020040904
git bisect good d6cc03a2f5ee665441d517e04bc744a38278fad7  # 09:58  G     36     0    0   0  Merge 'internal-linux-review/Fenghua-Yu/crypto-qat-Fix-alignment-issue-with-resp_handler/20200408-012430' into devel-hourly-2020040904
git bisect good f40f31cadc0ea5dcdd224c8b324add26469c2379  # 10:34  G     33     0    5   5  Merge tag 'f2fs-for-5.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
git bisect  bad 713a09de9ca9ac6277cb43d79967e7852238f998  # 13:02  B      2     1    1   1  checkpatch: add command-line option for TAB size
git bisect  bad ed7f9fec8c8f8227ebd1fb69feda60ce4a7df61f  # 13:25  B      1     1    0   0  powernv/memtrace: always online added memory blocks
git bisect good 1df319e0b4dee11436fe2ab1a0d536d3fad7cfef  # 13:54  G     33     0    1   1  userfaultfd: wp: add helper for writeprotect check
git bisect  bad 14819305e09fe4fda546f0dfa12134c8e5366616  # 14:20  B      5     1    0   0  userfaultfd: wp: declare _UFFDIO_WRITEPROTECT conditionally
git bisect good 2e3d5dc508cf001c4fb2d15515ebe6f30df88f76  # 15:20  G     57     0    0   0  userfaultfd: wp: add pmd_swp_*uffd_wp() helpers
git bisect  bad 63b2d4174c4ad1f40b48d7138e71bcb564c1fe03  # 15:53  B      2     1    1   1  userfaultfd: wp: add the writeprotect API to userfaultfd ioctl
git bisect  bad e1e267c7928fe387e5e1cffeafb0de2d0473663a  # 16:25  B     16     1    3   3  khugepaged: skip collapse if uffd-wp detected
git bisect  bad f45ec5ff16a75f96dac8c89862d75f1d8739efd4  # 17:05  B      4     1    0   0  userfaultfd: wp: support swap and page migration
# first bad commit: [f45ec5ff16a75f96dac8c89862d75f1d8739efd4] userfaultfd: wp: support swap and page migration
git bisect good 2e3d5dc508cf001c4fb2d15515ebe6f30df88f76  # 18:55  G    666     0   24  26  userfaultfd: wp: add pmd_swp_*uffd_wp() helpers
# extra tests with debug options
git bisect  bad f45ec5ff16a75f96dac8c89862d75f1d8739efd4  # 19:30  B      2     1    0   0  userfaultfd: wp: support swap and page migration
# extra tests on head commit of linus/master
git bisect  bad 5d30bcacd91af6874481129797af364a53cd9b46  # 22:45  B     18     1    1   1  Merge tag '9p-for-5.7-2' of git://github.com/martinetd/linux
# bad: [5d30bcacd91af6874481129797af364a53cd9b46] Merge tag '9p-for-5.7-2' of git://github.com/martinetd/linux
# extra tests on revert first bad commit
git bisect good c28205da059708e32e23e4affd20645295078c54  # 01:24  G    224     0    7   7  Revert "userfaultfd: wp: support swap and page migration"
# good: [c28205da059708e32e23e4affd20645295078c54] Revert "userfaultfd: wp: support swap and page migration"
# extra tests on linus/master
# duplicated: [5d30bcacd91af6874481129797af364a53cd9b46] Merge tag '9p-for-5.7-2' of git://github.com/martinetd/linux
# extra tests on linux-next/master
# 119: [873e37a44b1ee8ad4628ca257dc51c0c7c654326] Add linux-next specific files for 20200409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--cxfMsoqvp1jUizWj
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-vm-openwrt-39:20200409172853:i386-randconfig-c002-20200408:5.6.0-11490-gf45ec5ff16a75:1.gz"
Content-Transfer-Encoding: base64

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

--cxfMsoqvp1jUizWj
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-vm-openwrt-21:20200409184259:i386-randconfig-c002-20200408:5.6.0-11489-g2e3d5dc508cf0:1.gz"
Content-Transfer-Encoding: base64

H4sICGlaj14AA2RtZXNnLW9wZW53cnQtdm0tb3BlbndydC0yMToyMDIwMDQwOTE4NDI1OTpp
Mzg2LXJhbmRjb25maWctYzAwMi0yMDIwMDQwODo1LjYuMC0xMTQ4OS1nMmUzZDVkYzUwOGNm
MDoxALRb63PayLL/fO5fMaf2w9q7FsyM3lRx6mJMYsrBZo2TzT0pFyX0AB0LidXDsVP542/3
SAKJh4V9vCRBSOr+TU9Pd0/3zMS14uCZ2FGYRIFL/JAkbpqt4IHj/s83Ah/aouJzTz75YfZE
Ht048aOQqC2tRSXGFMOU5tyVHdWxVWrYHiUnD7PMD5z/pe7M1DhjM9lSTsnJ3LbX3HpLbQHh
51kWpll+J2mZuOOnp+QXRsa3g8FofEfuFhnprWJiEqZ0VK3DZdKf3BFOOd0W8Gpwez34RJJs
tYri1HWIvcqSzjYVIcMwdQPy0Q0zP3TFzS5Nb3RBelm6cMPUt+Fml+LyeQ4dEd8F1C5NH9it
LC6vl1YWJLtUn0f96r9dgh8LK3qCsSFksrDC+cLyCdmmejK0trfKOmSSd98P5+TrpPdlQDzX
SrPYJfSJUtYhvz4ZOvGCyBIkq8gPUxK7cz9JYWx+fRssB9jJZPBf4yiA0/vy9RicpyS1Unca
eR5Y7Dd+3yFE1bWz8nni/3CT/DFXtYMog9CaBWApOVcpSwLC6GfoFan7lBLEIn5CDJmT2XPq
JmckS7ADvwJX6Fix8yvxonhppa3ths6HNxNpFUePvgOtrBbPiW9bAbntjcjSWu3YpiB3DU47
5NvSXQqd1D9S7ZHpzTzvHqTBXrwKzPTsXTAPwaD7bvzoOq+C83Zl894Ox7a7Cr10crjXdhU4
3V2wN8vmuR4qrgqHj94Ml6PV4N4uHSsxNnBcXsPt19wqBv9/6BDHnWXzDvHnYRSjaQfRPHAf
IUyCd6Gz7lj2dQSB0e2Q66/kZPDk2hm4z4Uv2jgF1Ch17RQjvW2FYZSSmUvc3Nc6JIxCadwb
kAc3Dt3gn9vIkxH2kPCWATigg3DXrS5Gww75YzD6TCaFB5Jxn5z4ikI/fCW/k/Fw+PWMMNPU
Ts+EvghrMY7zFaFKm7I2p0zZBr18XoG+/SSKQRsoPsp69WW0TffwuJTsILJBa59FGFgmcUKU
maopDmUE5ClvdmaoCivMTYSeIS9htg1WwM5wMJZW/CzeCbIaP6vx5xEosRcQV/IgCBfCDGYq
TGW6SexnO3Drs41+n8MmURbj2FXgllYC3/TJ2/rAi6dpDoWvme0o3FXAGWdn4pXvBO40hHeG
wVSTqiYkBDIJa+0y7Z6kid0hF4VacWTMlmkaZHT5A43FdhNQ+4aHK4Z6T3Ibz1YOhuYtzylN
vGLapNv91x6n4YrJSqzYXUaPVSxrg3XATbiKAxdYSTpdeSHpAp+IKaL3Vmwv1o9z96tycuOe
jO5ub8GePJj6U5KCiXXI99hPXWlmVceXqzIviD3/CVQUw0QPE1HpNDVKDZOCXA3mB/gcQjRF
JiPozgVdFtqWvdjuoCKLXEXQfajgFV5cI9UKIR+t2BdKf0FOVSQvlMysBKZ32i+GTtga+fBh
fb9fKlVIxYiTBxWn9k5ogO9/J3ot732ncXyn7H+n4jt1/zsD32l73+kM3+l73xk8zzXGvbsO
ga8yN10TQ1y0rQzU07+5/jD8OP1qaFOkg2xjTQKJH+ShRbRsVeHRsNfw/Sj0/HkWWyLsfqOS
DsnPn+eE/HkHKWZfgn9k576GBkqdQLjGXAaC8BgbPuB1MKvcV1g1Zr7EWsk18hyjyqrwl1gr
eYW3xarpBliIF2UQb5FvNJZSYZFWWgVQLaMEgJ9bAMJUlisITfDSpJKnzvTKvKAZqgIhc+Fi
hEQhQ4y5EOJj10qEwEH0nUBbEQbtKI6zFSq/BgCW44d+6kPWVxBC4rfCqWWPbrm300tTByHP
b69gROG9IWtAekaK3yJijT/e9c4/Dao8aBiQY14MJ1frdnTPsmZ5O7q3044Og3pPev0xTKwD
URPmyhSdT7IlVm6+B8mrsK5dWwd+s+S/nVyM6+nhB9VQqYhYTCEnj+Dz5zf9ywk5rQJwVgG4
qwBA7BowtW8KAJkiACsAyPnXcT8nzz9MPFnf1RqQadnAB7hsN6CYF4JNV3YayMmPaGCtgovd
HkB1gypginqx08DFkT1Q1EoPJjsN0FzHCq3yqGu19sbD/o5aGRM8xq5ac/JmoVS9bOByPNgd
NzNvQDZ2GsjJmxvQ1z34FGH1JASzHAfmeqzUPFdk+LVO6yBT7mc5dRqR8uMVSTc5WT8pAGqN
ogsx2Rydk8vhx8vRYESsR8sP0OxbNToYEm7KDAg/3fz5Ap2YQgqZMGzE1hIyKiKRmS6LGqVC
zaiYqBrJcDquxAa9Ehv0/bFBZ2gP/47Ccubu1N4p2OzFqJcrZk8NiklOrc7bjSRMFV29xoo4
2INSlCnVigy65myj5HP1pT9fjIB/p64rtLGvSKyhYMISPYpY9gN7DSU7zL8Yu11IOqAWqS50
AT24cB7/imiNBIWqqnS6kE68hEd7y/UdVVHT3RZP1xpgDpfCNRiQegizDHLnC3gCkh4h1l48
A+zgJixB0ii1gpWFxkJ0Q5MpX9OCHuS1zaB+O0TmRNBCJg2WjooGGcDuqzwKrfPQgmUne0fa
bXysGwT5Gfk0/HAD6WVqLzq0wiMrZsUCczbVOEIwOU86a4y6oimmsqdFTV5zgkoYq5prIapq
MLqHU68wGthkXkeKSOXEPky1ZcWwIWQipuVhcDyS7vwlUA1vyBjSSazMNGpUiTHzfE3MRBac
vYAMavrbaX/8edJeRUnig+dMcSGVBP7Sz4tMGCcLC88WGZe1G2FtqIDy9QN4UcU1lbUoCD+9
Hg3JiWWvfCgev2HFeU8cLxD/Aj9M4RG7P60AMLSw4Q3yfqOQ01or3wZWrJ7L5WSmn9U6JxZV
4P3HyZBQics1tPUkPby+m05u+9ObL7fkZAY9hFIlS6Z+/Bf8mgfRzArEDS/lq0mFVdMwBN1j
UYfCrKIAL2nsz/EqAOE6vP1DXMUIDC/I+uc1TH68hmgcIZlalUwlCzA4IlZqasJhkN8RjhXC
yVvCqQeEU2uI6hHCmVXhzIPCGa8QzjwgnFlF1PgRwrHaoMLdAfFwyjhaPOuAeFYN8RiTg0Ss
Kh47JJ6+z+4OiTc7IN6shrgOLMBD8/A4eyYReFfsO27VmZmxz7AOWT070DqrISqvQJQPINY8
3NhnX4cQlQOIShXRZBUNqS9ryHxNf7QDrWs1xNf0Rz+AWJlzGMf08mhE4wCiUUNUKxoyX9QQ
p0aFlr1scGJe3RCzBmL1Ff2yD/TLriG+RvfOAUSnishfo3v3AKJbQ3xNr70DiF4VESvlIicB
1ZOTUe/i7nS9QmPXVpr8MN/7qi58IIRSqwp9B5MUgxqaxaHYwyVBsdzsOtt5CMcit6iT8lkf
qzdMUWeiaitn92pQ5JiOX30ZFcmvlTyHNhl/EBKLhfYarZkvpCepawUp5FH1xXjTpjOlyiCj
bReJtE3XxQvu+8xEkbUu+ER74/4QsrdH364UDAgChnQeRfmmqxVbj36cZlbg/4Bu5kt7BJRZ
3W4AJk63Vuxj1/ND15H+43uej/n49rr91np9+XhrsV7XFFVlpkYxb1U1o7pgD82qoM0V6ESy
Ami8QxJKYkocmetAmuUX8arLfhN3NWatzgw5G8xyVQod9Hme+UEKmSQmyoGfpJAgL6OZH/jp
M5nHUbZCPUVhi5A7rD7IuvygilxrzsCN/1x/dgTpfOhgFomqAmV32zASbSihYbLPwvk0BW1N
V1bog+T5lpfIJrv5z+Q5if+aWsF36zmZFgvaJLbzDYgW/MA8eAoFZBBM0W6iLO1CNUVCN235
Xmgt3aRLix21FjT8sEzmXRjUvEGJkSTyUhzNbLUWIlz60+9YFDjRvCsekihaJcXPILKcKYjv
+MlDl+NOyXKVrh/AkMQzp7X0Ieee2lEWpl0DO5G6S6cVRPOpSB66ECeLvHy63tUrDnx00/SZ
QiEM9W4uNj6Y0DMwCg4dq1BtHj7OrW6YF0jxd9T1Q7dtu6uFl7Tzcx/tOAulvzI3c9vRyg2/
x6kE3lb8bPuyoUlQTzt5FJHAo7iEpzmoQo02yABjaQWSg2J2xLe0AOMPnksikyqd2nkTymzF
m3EHUlSmujNX82TqeIbh6Vpn5ieunUrnnz92pueoyySRhKbceJofFGhNp2JXZjSa9q5vrse9
j4NJu/W4hI5lP6RjG1oLx3Sqyoqkaryz23mJQ+SDvtuLbr2j7QMdJec3N3fT4QiE6rZXD/M2
SvXUoMO5bUt6+1jJ22VXXzjQgz7gxl4rWWSpE30PwfJKm52mC6i6Fl2tGjFV3PET3tTJLyR3
qnKXqDJnyxz3vS7cMMUldKwqycJKFsXqMz4WYU7lCjcMchLFjht3CBQFnJo6GGR5IAN93opP
q8CmSJQjx5UO43KNM0VZ40Kqw6hiqLp2EFcxcboVsc3CrUyZKaZmFnJgdYyRauo+pTUWmHJw
ArGyNJJwO6CD61D2QyfC0LxwrVWOWLn3YtfF2yqMLOfLPD7OGxggy+UGnHeKxZqTcnGsQ4vT
DxvhQRBN3YIoF8e2IMSnU/5YQ8hU13HHZiQWxzoEpjUwVH7VBjVAdDCuKpPhiQZ12VU5ueGJ
Mhg12VSvIG5ARIXKSdZkIIij/E5XtSuxVwKDwHQGN7MERkBjDH+XS0NnhF4Re2lJmwdQinMF
nmLBBFquCwua7+MeBvbV90i68JPNjjNZRCH4XCI22P4ck5mfEvDEUByEy9bHAZYge6vVunlo
baANTQZVohNGyw6ZuxiW8fcU5kcw5ADnDg/idW7U5cvE/Wtqxy5Yzu/0SZ+1xa4x+e6nC2LH
MEFh97u00oqOVjz59Pkc8qg/YczmYVeDkuUG7bVLJaiHRn54M/sPRDmYfM5If/w56ULddQ0i
w48NkkkZjNvNxQBjIeRJgQf2moK1JslmvQ3JcNPaS2ML043CzFF3MM8bcuk4qB9NzSflNS+k
fLiFuMULaigp837yfH6v8qkU+Gr3MGq/vflTRcJO//Ybrund3A37g1dcCNlCUgukN3y2kAyB
JPQ0zefdk1Myc1HNWN60SG+jd4gksVUsRre2kXDL7H1k4opAukP3WLpWiC5hpbm7wF+LCMMp
nRmzLHAVeLEHSRdIWZhYXh5WwN2cLD8NBN1rHS0TViHv0zsMnIA09MhzlIHxu3nHIGFLwDBF
d/CFFbsEDyuJdHCO2t9F0vKxW2/In0FkElv6uaqWS9fxwepxAzVC0JhAPHGi+J87SOZ79U55
NxtX1PfxO1U1QSZIGzpkDPMYJK24jAwB2o3xyEx+BrL/GdS1CtwlHo5F62jVALQC4B9IiEE5
FR4j4vhuJiFYzCoLxmA8EUOcKANSqQ22J1kQ9WIJ59Yi/d+Do1FexSnonlIYRghmf0xEEHxu
u09+WmcDiQUHxGAiqgTIkmI8MgDOlJcLWJ+iXWDQP9lbUJzWISFS/OMOipZEqGufsKwUtuiz
nQUi6D5aQeZiPiKOiGUBdNsNsdJCdUOnAusZ9chVUtSSG1SZGwzCwfXtdHj7xwSSJBlXycIY
FyYhZ1IMPKnmbuJ7/pit16wUNG62OVtYni7/JuqI+7IbFXKoR+9xowIGy12hnkP7GXvgQ2YQ
xXi2ZfUcw+yekhP7FFI/qpFbaPjSglxhGNot/J5HkMsEoRVvcDUFnQxmbjLqfZ1+uulfXQzG
08nn8/6n3mQygK4Ro0Jt4MBXqadAfnfZ2fidUiHPd8m2wa8G/zdZMxjM5BUGFfeKkUE0f9mb
XE4nw38PqvjUrGhRN7G43W5hcH13OxwUjdSqb6iMZVwd3uboX/aG16VUmgoxrMKh43K3EAqp
9gm11QaUOLgjV2yPlstxwdbg4aoQWA41VPJwXmHWcGeCQGZFsBaXkjSGmaEE86BkF0YDnIwV
OfWaWYEMBlqWDnwqdApGxJ/CoIp9NYLJTpL5qdup0OkaPYz3ls8Gmyma2BBs+PwkyQpyqZ/f
hf5+xvllmaXuE7z7nkBu/5PE4rLB5kwT25R/h9zc0MwDcvekHoyw5YgDox5k+a7zs7gQEj1A
Z+oP65dNE6opq3ua6Enn8Od9mjCZKd/vg+/Dn3dpQuWavq8JgMfvd2lCK04Z7PTgAv68Ty9M
Q6P32z24gO93a0JTqbLdi7yJ/ns1oVPV0PcbbT73QzKan3LOQY+/bJpQ2V6jLc/24f8QWbiB
8980YaoG+5vc2qBaftKk+oldG0pf/9HF7XxHKjRU+WwkrT7c1r7BTaWu/T3A5Bf+JmyVsq2R
XeanoxE4P6W8R+61Db2IrVNzL3YOe0gnx2Gbci53RVrEauNXLjfpnZ/33oKNFXoeoveC4+0+
7KP0bUJqhc5aVcS7ya1wqv9N9m3CnFIGmYUVOxKmpBLUm79jciphJSr12ozvDzIbGF3RyqCO
a/VvhTEpo43ScPYyjEppcdL/RWmaYTitpCLJhpV0/wUVWY7Z2CmV4snjRphmaVTGq5FI6KcA
Ev06UhpNU6sTl9DPG2AMcVigQZrmTpk6a5amEQZSXrWISHVB8rUU6Zz8wqBPchMMN/RiwOuC
vBJGEf8Jp0EauUnFTGNMa5SmGUbXZdYkDWeNnTJlnTZJ0wzDqdmsGy43DTjna596QZpmGIVz
o0kaudEZuGqUmdphaY6A0RXdbJSm0Rm4KY5WN0jTCCPTtWsekoYf4QwyF7vWL0lzFIxsGg0j
xY9wBlnV8lO3L0rTDKNzpVGaZmeQjXURcViaZhiFqpQ3StPoDFAdM6NRmmYYGO+GWMyPcAZF
bYw3R8HolDX4FD/CGRRDkxti8TEwKv6nyHK6KxMcsQIk+WFxJPcIZ1CZoa/XGsoE5w0wuL/a
KE2jM4A4TG2UphlG0+VG3TQ7g2rISqM0R8CY5maV4qA0jc6gcSrLjdI0wyiqrjZJ0+wMmi5O
G74szREwJtvUlgelaXQGnbFm3RwBIxf/ObUmjajtinK6cIYdRsVg2k77xzBq4mR+Q4sy32XU
ZV1vbHEfo6EpWlOLaNQ7jP9P29U4p5Er+X9F97bqYu8ZPJLmk3d5dfgjiSvG4Yw3u1epFDXA
4PDC1wK241f7x1//WjMjwYAhu3neqtgL3T9pNFKru9XdgkW1r8VtjLEJx93TIk3cCqPyk3hv
i9sYdayrK26DEZOzwkjypzqPDmEMfbm/RbWlq1EYV9fRIYxxEvybLPmAXrTRSf4QvyK19/Qp
Ha2M997pQeKFQbCzB5ZMeknF7YWfpyfE/QmsRZR72e61szAqkpu+XsbIC8Qs4S8ZTe8bO9Z2
omM7C/Of4Wg6Wn7B6YTFedF5aNFo/KveznF+1jEZLScIzdr/UKSmbxuby4vL5sX1e5pJ08EY
D/XdHs0X2w0RpbbuScUJCPsIpwhIMa7abLA564gxir0/PessjNZ+9WVWf/7ombMYgcA08Uf+
ipzu6Fwm/cXu+L6/w3dtfoq5sT63KoND/22d6e4PPckGzIaPLvQQGPwyTM911u+CSZT30hgX
b3wPjPRiRCL/qQF2xxi5WsjmDbTAGfxsiLA/lin9dJkthWn3RKRLkX2bc4WSujO2SP+I/lw3
LIbywzL7/Hy2gGv8ccS5axy3qVVoabWHM7i1uO8v82z1Z4O9qftSYaKFkRPnTc0kOG8wGX+d
pxEJDYQmLJ8nk2y1GPXF1ekHjnwzQfWWz/fha+XKWWXWIuhoxb4Zp6u6yFMHJCPga6dRP0H2
Fx4kG4jLbyvkHtAgnLd/+cmzVLT/Ig/3pnl2fXXzVlx9qJlEhdv/daDoCfLiCkTQ3Ubg8wpF
hDcyTEdT+hfhPbSkpvyWHdIIKo2TZNjJVmJBs4VDsDg49QjVg2r/oHHOhviNbAopWnhwTzT7
q9Ej/rigWdWw6euhJDEr9yMrg6y9AtnbjxybxKA9yHqzz/oA5BihNPuQ/U1kfz9yEiT+fuRg
EzkwyHI3Mq0ipLzuQw43kcO9fVakQxwwN6JN5Gg/sgyDA/ocbyLH+5GVDg7oc7KJnOwfZ+1F
B/RZepWl4h2AHUUHzGhZXYZyPzZts8EB2KqCrfaPdiAPGpPKUpT716Ii/f6QMaksRrl/NaqQ
z833YleWowz2Y0cKMsQVvjLcIX0VaR0bglpGO2kTrPM12ngXbayV3qBNdtKGiEFzadWu3UIl
HmL91mjlTlrN+p1Lq3bShvHGmCm9g1Z7ElKpXr+7al3eNsQjfT1bvOYtBPzyNQPI14r/VyH9
iP4fvx2MCM+xpmislv0a5wMdXBJOJ2lMRkk/C5KtJeFoTZP55GoeWoZIbDtPx6PewkQ5m3jE
8Ww2F0fLryMk/x2b6n8rE8lYr6PwA4rGibPZ/ax11e6Io/H8n6+jBD/KzjxklNCbnI8GXepN
o6ik0DBxbGQgTUeThwlSF5yRUHHEhUIepqsXskUQz1fmiuiTHHF7pkiodYBMEcbkKqs/DJig
SSRcp2QtmWyu0d31mQXz358hmVG1+JePXw5vjJhxh3ewj/dEyLdrEJGGh4M0tkZeSZf1WVsJ
4uhdunzKxuNjcTRMJyNMJe9beMI64phnTP9ELFfZfM7mpffNd54t9vBsHWjhBPpRioZojVaj
ew4QRtXDbNGfzZ9Pl0/p/H4peumCOr5Ycgh3t4uvTUlb+r1MEZvzr7XMVGogQvhi2YCiBor/
mTgN5YHuZvFN5jAQTPrCIqO3iVfyd/rSYbGJL/+x1lhgGkNULiJiOisM1tkz8i4a4uPDeJot
3Mp3pLN6mDbX8u5No0hsXOsF55g2L+viZq15fAwmB4gPF1sXHbcdsj7GNJs4Rrn3MBzy2K1W
CNGGCcSP1KdX6ZTFCUmDhdbWzhac6TvtZ+IS8dj0AA9TW215HjIqv2YRQniKduuXvKDJCXuY
nhBhz7HcS9L6x89120YcqSLi+50bJt55IU48JKsGp3t3nTzgjl4Lh1ovNmOMQ5r5OEEZZI+r
yXxIPbeBW5YoVnyQuiYQf0CmLXUyigNTyceVgzH1iV71kKM9t2anBWEpFSTnOeldiWkoVYeN
Zl5kJC0zBObChYaKosj3EVsSfkKSzSiwU7IhMr0kXm5SJ5pFzyK7x3yeLWqDh8nkGRVdOaeZ
DEeaT5YaLnaaN62GuL07FybVWsYNXzaC6EQgq7bB5m/N82u2oEeYRH6MkqFfMmSZdpfPNBS3
eUVoeqj8c3GPEgBTmvavIEy6T6NlVpaLjggVp0I3l3drvChpSZN7LIxkcoLWI7KRES2ePgyQ
njdyc+Sm2Qp5rmL50KPOiKOi/N2xZU7YKZczI6H0tcLb5g+OJJy0Kk5kXPd0RGoSp/+tstfO
JDSkRdox7d4LN38LZZYQmtSfP2BqFeVfyyEYpwOaJZY6Yi3duBuQ/s+VAZCZvijHoiRG6R8a
bvq2wSRcL9e6J+qkuRtdMF1hng9kj+Q3CqIC2SarRVpJmLqMYzwA64UCuA+SBRVXBE372DAM
u6x7gfLhwuovnuer2eR+0eXpeiSTYxNkfs9pc/QRZ04i1nz1hdaXiv0893KcDVcWLYoxr78+
zRYkyk8fFOmoR0q+iBXGW7GkDPmgkns2aJh1P3/o/j7Opk5Ch1fSa82b2Hrbfvhy21GZQ7rW
Nm3XUeU5Qm8PVpG/uoalktiDTr6Olfh7sPS2fiHGPizLeDQHyIzpfuhcHZFd8EAi7IILIBxb
8tApguOQW62hyhEGeguHrnui2zlvw3mUTTFFlw5TJLf2yjbTvKfnvIfsqraYJN62Fvneg9oF
aTS1j6NBNrMc0vNxnr6D4zqbzh5ntZuPtXcXratak9a3yyudwokV3nftq9q7595iNKi9XaRz
2grtUyZKa1tTS5oSHc3Wtdk9liSleGENH8Yk4NL+7w8jSD4ujDBLB8XCV3WPBtgrcaDKLUjj
Xm1uniCkYS0Jj/Idfyk6nuho0QmOLWHC0X2G0MiAvIQHVj2rZaiRWtiYJR/hY3d2RMeXGeQL
Pf99RnoX7U1PS5NOC+y/I5OXDCKk7y2eUY0/E3+b90evp7P+Yvk3ftY8Ky8lIVW2I2XMFYzz
Mqd5hQcl3rYvOaXVuPw9VLwTXq5J6brygzguy9tAQt7OSCE7M537RB+QCnJEu2cKDyOk/idT
caU2HBaFzIBC4oXmJgqfifZN22t6uuF5Dbz184YgkVuO66dmp90iPY06Q7872f2EFaZ37d9q
dyRD9WeLmSjMhAomPNp4CNoVRKtlagu7hVpOUJb91SoXwTa5DQ+3LrSX87SP+PkBMnaQ4Wje
Sb3sQqBCnKdwF2jLYq0pf2Pi6JP3Tfm2ZIqypffzQnEnrNtCbczLt3H9eAue8GkguuVOCHoy
M8Kcol5SkzYI+UYToet8bSqBMEPZv0+jmcjLIqIUYn8Y5V22QxtKzg76DrCBKQsD1bACRgvN
PwxsW2ny3nZQn0vlHA66VrzGvIoqaBD4B46hneSWO+HyesRdcnpeHXUtUfmnIZUmkWeqFHmk
Zqdcrg92ivMWSWs09WccDGkxUON0K4a0GFqRZRBUMKTFkNswpCdji0H2O/IDqhi0fxA1X79g
3nzf8zGm9MsOhdYR146qso9p++k/i6uLSwHR/LUAlBbQk0N+83IYOYAxV6L/DkDfAuph6CAl
HEv7HUix07XIdC1yukZbZ7R1uHcC9p2uRU7X4J6odk2XL45jJKovP3YmkI5MgkQVI+9C0XBo
lleohzD5UrJOOJMRd0f4LOwtoqnNuBcxMoiRtw2x0zorAZM4hDa/Bqh4jqNwVkNKDELlMbW7
TnxP+tHm/GQMZzqZdT8c2HU/yI1X2untZPW9gE+pdmLFFosEhyNDvKGz/EmnCSN/N4z2XJjM
wmRbuuRr6W9Od+2IEs/LtgyRWhsiP0rizf7o7UOU9fq2P25BXIIh0z3ZfP0ujO9IAs9IAu2y
x77aHFy9a1Ri24vellGBp3Vzpfl2VFSQ9raMSuyuDz+OfLUVY9uoDKV92fSn7UqgpAq27RSk
NNz80mrmxWQK8lBJDu+1StRVqQ1ew7b+dH3zvkl6FI5wRSB+JqtTylITCAPJUZ4vsp/tZo8i
vo3iRfZzy07cPzvsJFGU8vewX+xml0EQ7WPvFOw/J5YR5cU3XxUvqMf7NF30GsXtPAhd6GGH
/vi2mRefsxgy9LbKiQLD8kAJQ+TNIOtz+ZjR7L9oIpzMnqbl3+waIz176jRA9u6mvF1rINfa
EMmymI1FUVXYAUiwHxXkrpVC38ZBhBoH8/my2yeVsWHuoWu3O5zX/Zgt6lyQeN2tAT6cnbl8
ncIByTxBnaaFqDmlBRCYVKN/ItLvB7PxcCbejmYTDLD47/v8r//hAlz10eoftp1EQzpcXjTP
RYs0+Y/sw6+T2lOQxF7ke+vmDdtssIlwnLZmDYE81rogx/IyFYTg8ONrzQqfQ+i7CfLgM6fr
xVU3XB6Jrxozjt79N3IQhkQ18f0YzrVapU5fYtAWhvOdfb632DL4EhJpH4OyI6oSDzvyoD/o
0dQ3v3C/0HgsOlwAbyla6TS9Z6exOIO76cIU1j5av8CQNuNyucXamKFr/l8TGQO348z9wt6d
ZLiDeqLDBELi45tOAzdhfSXtYLZC7/C7G6I5SxsnsqTF9y8cDklPFRXK+FDGS3LvznEJ55vz
/jed2jlgUPTbriF878cw0vjLNyP2WG9ShCGfmk3nJKGmbTNB4Z4sKQKPT16JQuSSvj1G/USy
tds4vGMOI0dOSONbskHaQ6GTlA+JbW+DUMGeLpDkQUja01Uk2lXguiyQ1EFIQ7kNiUxHbZGg
cQ4mqVCfLUXIMacOxQFtRdueP9Jx5IykfxCSvw0pVpylUiAFByEFnqwiJdKDd6JACv8kEs3x
wNdKbcykRn5PT7ReGTWsk7iJg80zaK4NP59sHrlsPXDZOG5BwRFYd7RiprYRqWKpthm1hS3r
7/UIAEXHSr+EEux1BQDF55Juu1HCg30AQKMV8OKTRQcb/4SmQg6Y2CuHSwYdcsbqqj/vorRQ
Nu3CgwVXTpcl2dZDLZLc5amWj4KLtPa2H2uhhUjDY3d33hbZEkijJYTxNmBzaF4gB4SMSxO2
V4gEcsKmJpB7NA4HQKI6ZBCpuNh4q5g+7WQ+YzbEuxJvWfrUqOdH7mPk5/xonv90kEIF6+6X
i/b+QaRHVSrRO4pWAszc0kFgtWuk8P91xMDz4Pnee7zmMERJ1bDHJkLGsW7YcNI22Sw4KL/N
xhlt2xZA+v5W19I1rqXgGJLRIuuvoDadQsdeLdLpclieRwJC+eFWzxJHMZlAlKtOk+8awT27
Agcl6QKSywHRVb8Oa7t8NlAo0hwqsPyS0vKiYbn90Fq/lcy59NO1NQFPE6jQ/c6vO7gfwLyB
4grB0Le0pEPQjnS3eEbPST95mM5xdANf3RC16Li23ZK38UU6GS7r9dxvm9S9UAeY/m8WGdcd
ZJpBXoiJJoAfeu8trR/yRWgbgUL/rhAhtBjw7W4pdgE+jyxv+qgrRBnfG4eIOMq1Ovu1DNP+
scUhwzHKcfKK8YNsCqcMtiVnNMIEU2PzqredV7whiIE+CHFYTot7UPYcwUeJtDVWSfE0FZlp
Pj4sV1zs+xk3rDocpHvRWsJkw+cI9MZROYmJybzbG62Wr7W5bZIX52uFKyP6X7NV/v9eARTS
moTLZLpCfEN+j4yqy7pW4hOPGa3V019NJcfP5bOHvmLv1r61XJTdZg5OcnyfPRtfQ2qDxjcN
MVBrrpTWtEQ0BIgXQLDOq2+kV77aykbbAk0BhDBgvs1n1BWYPw0YPk7lUZAmTHrGxzekrRBu
57xzJe6zaYb2jnrL++NiRIqp4tX93NQUR5P0n/SmVeCVMycMcHHoZ0EbellAT0x+r5VhJtUe
x/QkGJbOim/QLUqs5gdy2cCl1AkON/F1dzhaTGCWNsz52BDnLUjCei6pQ6ngQOov+kiqO789
715fds+u7jriNcJC8MHZpSg+cNgi37JVgjpOijK4OAJTZDkWZ98IO0xwowNWZNa3eKFEfQDG
61f64ZAFOCwsyL6rXRnGceIHtl2JqsVaB8VzkCk/6XF5d5S62xGpQkwokRYWTP3DuSIfKwj3
sPA0A2VtvfNeni5S8tB+gIlyPx/NuqNVHHE0jOODAQ3Ztzhavmq3rsqio5xghc22mJCaZIHl
SBQWzWg6fyB50KZtZCHOHlYrBJotxWmuRp9e3/zW+b/OXYu2Ifzd/vX27AZ/M5/51ysxg5iL
WOVuKBfyEzG++VwShpEHA220TFmLXxOHUOn76WJQbiaSI8Q0xGfBcDMz1sN/Gtsh3xPZBChZ
QlI4cGsoLdB0TC+GFt+pJAvLKwPGaJXjONTcW0F76cJs8s7Nk4wT+FAQc/OHK0xir0XqCW08
Q9JpkNX4Gpomok66vfRhgPnKxeyPTW1bbrdZQkaST+tyOwiQ0kIqC6kPh4yRtfdZtD781hSd
SbqgPeT0ajqgHYEETC5gN+QTKRX1oARIdIyYkguuZ3aXjr/iwusan56uj2sSez5fzz2tPc4Q
dEhKXr59FQ3QjlCQkxwPEdvyZjybz3OKo+Ux2WsDj8uD1uO4JZotExVUcgXaR9Lxm4tz4Znn
7cSKTLmzgoLMSR+RAL0FAmZMTIjj15PUBelz/kqreU6LXVxdXl6KmDQp2by0JAFXE36k+Qf9
ii/MEOfNG0dSmmeyHCHXWn/8VmG5e5gilHKTPgphimfwcufhrEe3x6J9++EUH4mbbIV9uXAe
1cq3E9U1iYva17h208xPihgvjpBUleOtly3Fpdc1rl1ahs3SBHciGrWPzVLhZGi3i7q4lwIT
klMfDGtQRxE8jBa3vXbSILLVF+rNEZRKrVvv/tXQqkaKxbEIVCPwQSZVQ/uNILRgSejJF8B2
D9W5iVUvgm4BFiUeztLTGUng5uxSPMZBGWC3LOrZgjCGACY5QnMYvpwbMqPanVMFTLiOsQd/
yp1BjfdnFye5O6fR+vDLZxOeFnon9I8v+A6tE6ksdMgPRDrHaNYwLQiCECZKpMJq+ZIINfPX
+Jq//LaLr2wQpjki9Eeqz+K6LJ3uzECQkTUB53cu6Jt3pM6T3WJq+CIdQ0Fb6s1wxb0r+OdE
gXCOU+7RKXdvTexL2wKtidA4wsckPmlPhvOclRj872i+TZ8BI40yRGs+9yH8Ze2JjCxxkY7H
1Jlp/sYLTbF8jzJKAtSdyDlfkfzJawC/Ek/E+MBzGBZL0aoxmHAVGiuUr+Cxx4HGq/KCbFTc
hosD/JB6Tuhk2a5Cw4dEfXolh475cu88yEbc5skv3J2r9mNoCZMAxyhLxHfiixP867ODrNUm
Qw3WhfloxZKGN6u1V60C2qoOcHPLyHJE7F9hYda3awD3T5ejj6ESRwuaYQqH874KRNobifwU
CSih1NDI9rp1EocjwYEFt1sEv97TlHyi3bxoKqHVSrsdDJMvuLFGWu6Qz0vHWb8xTqdZ18j/
rrn3gj6t96vh18wXeeEBb08HJQfOVWh8kvkUVtPVlEtpY+STNoff5iFVJX3sRdCkUe44vwQr
r2SYO8dw94Udt9hobSX1x8vbztWHmwaoA9zk7FBy9pD3F38sHmlD8kfiaa5H+ePwAolxnz5M
ejQdZ0NaAkZLY+cAziyCukMcQhW3xEU6709euf7hgPIdFpKdnrGP2LVBa//KpBLXt/84nEnI
GaYib2Lz+4i90/jMCp+fsFlXHzJiN33eAmYJWaFfnpej8j5VvtTMYYh1qDcYLkgSsKsAkXsN
4RLHytsgviZTqvxZI04UMiM3ey3RPK15z2oBRBpt4AoOWSY+4yBj70V5tmRlDeqKVhjb9FLL
5AscDXsOfRTKTfpi3HM1qeHoJ7ApA6/6EGrL0CeSHfbr2OmiBz+Wyc9xiZWK8o6Y41TnQdnJ
2XBIIxQEyWNSPecLTc+DwuSjKW7KK6yME5Hh5PqEr5Y5ER+PSL+HPXJ7hN8d/reYEifiwnzd
cmVI4oecgwhgstUL7a0CrHQFeDy756nGwLICHPKFwAysXgDW1R7vAY58nMgwsP6hQxFzei8D
+z8QWHueKoGDHwoM52QOHL708uT3jbH2FEc8MHD0Q3uMEvs5cPxDgYOIL4cHcOIOBWcROkPx
ndON6zMmOXD6Q3uMnJsc+P/Zu9YnN24j/51/BVL3wdxE5A4wb1ZkR5ZWjuPoYa18cUqlYuYp
0VqSG5K7K91ff/1rADPDXRJLLnmxr8ryWDUiGo1Xd6Mx6Ed+VMRpGtupKFxUofacCin92C5e
ecweS9ptbI+royIOdKAXIK6PijjkLEnswnxMeUxqkCfNHEt5VMSJHxqWluqoiNMksoiPKY99
pTPHMuKjymOlAs8u3lHlsaL/7FRER0Uc6DhxQHxUeUwaD1xsoJbQaRce/chsi2ueUQcmgGE3
595GoIWR6hTFgS7SMS9Gsi2KJH9SfvOjDisx8jtFQaAb1VEhRkGniO/VOIs1F4VtUSyVbksH
SRlFnaKAw4m8+VFHORnFnaIUa01FOkzJKGmLEoXPB5wPmovSTlGID8w6/bMemNcpTGH+ptM9
68LOsFMFO1AUKlPYmS7S/XVnTKyNkWxnhdQEqYdugmWM2gMcPPZSU2gmRoadwjhstVHnH1HO
Z9WwrSlZjPEN0rjQ2QReZHzPJ5b6Ar7vh0hWSSvm49Y9hbNRIOOTwddUgtSSIT4QPRIDCW9a
0u7bgz0SNeHmEKZc2t1Su4gPiMx+RlRyUVSL1aSeIE3Tsq3lB4hJ+2laTS+q7FPjZW6+EuM3
UVYrDijRPaeLPu6v+R6u8XXHSS/xgk6XYGr2XifBnN/MSMOfLNc/2jNUqMAWbReeXK3mcE0q
bC+W9s4B+UWzErO1WHUxRBFctZsryOG4XrKD5oYPWb4f8/G3BXbCpjBrbmAN6OByMdcesejU
hnqBp6A2w9lZ0BrTPm9OvCPwixeOaCU7wLG8bZjOxgxsmWEC+DXQYchhDO1V/dWM/TVNhAJ9
y9/HOiH3ZXODj2yaDYbIS6Eh/4MTOOB7Co5HhMrgQIA54zSXlQM45sM5OxsJorboU4sFIbfe
m3yd7J7LWR7NVdoNTUfH97CtpSQ49s3VTJxysC5jkWCvATuAoc6+wB/fssWHK/Z7G3UAksjE
yjttTBO5wJdeW7OaXU8W8xkqd+r6gTIh6f766sXZ49NOSZSYiL1vz968eMwWvp3S1Aa3vpNB
ugUKlE0lcjefcwcqspEHt2VcbmFJKJjYyG2+5U6pb0PX/p5/eb/8y80cxjKyKUP2SsncIlBK
mqiev4kszW3HQrZDLjjN6ki8RCAIJCcXJM51BAOYoyyrln8SL4Vjnv5A+9Rk68O1Hr5dNVAp
bb2RhRrAMYXZeGABkN8FXy1ptxF9GSX3+JUr77ZfOeMgRk0aHG7f/yhc95l/DQdS/lj4rn7P
RiaQaR+pj+/w9WrxHjoYv/EdPucnRbSSbkX5/pF4p/AXsSpN2LtgK6ZldQF7M1TTOSL5KKxH
kgyDOPEQ3WMKah/DJGuk3yF3dVp6+q3HP90pyaYSfjSn7NOh7Q3weZszIjaS8W5dgOs6dyq/
nEM2fxQ17oNpXPoTGe0Utr9EcikMl650JJAB4ocgIBgizqBOc9Ms+qfVqjg1cEPAnTRIaFtn
hecjVi90r96GyA2MQmfSxO5Qgs5YVloqS4fSQ1zHTvkVboU6xVGCOCg2nglKS8Sp6Soypu+8
3Ym+7QX+ddLgCXXanMPx+HwffziegJ3+m2Eb3nvNVpIcKmspzpi24fetDRpNmltz96bV0sAj
TqatVjVLPUZDIxE2GVOXfG+yqBrTGFunk/D6l+XH2b7DIDSkJSl5yPL8YDWWJcIPfQsSf/XD
H3qsHgpsfytov7DAmqy+aJ8owPbeml+u5TAdyMGHJApLvy6UEM+y60r8jdT2pfhzSe+//AXO
T9P5jNh+OF98GF59+rpXfNQcrN3mC1iHVtonumEkzPtXgwFCUC0vq+IrF88tP05H3mc/jlL4
Pg+8z4FfBaqig0nf2LbRjCGewPv2uPBlifXRmcbnNG0rNrmm84NUJ9Cp4BRfNar20NZ/RiNj
Yzt2E7NKVVNs7BTNggjN9aGMESZLJT3bOlo2PVhynNzZrVa42U4/l6TFLhDjNWvVf5hd0hll
yqEocOc8Z1vKZXeoBHXvSMvK0nfbARvMwU/8pgtD0y36WbY/tpOPw7me/LKUGyf/IZOHPOie
j71w59lrOx9s6rzX6fyzJy+/Q7y/Nz+9fInQuE/OxRvSPoa9n2YXEAE2jTXpgDNt1ysycW3s
YKZZ8ZHm/ZEVC1cXpdC362w/QHKUxAs1OV1qwqWu4lobed+A6+mLV+c9KBGTKZ3+FuLm44SA
NJpLOlPMMBkkq6fZJ5tgWzdI/A1O5PMuVHREYc6ENXxkN7PVsPdP6vqUrWVushl7uLE5Lsds
tsNhBX8wKBdzElCT66XoF1eLBbVMzSJ282LCUcIuToa9XrFaXAzoFDa/QVBxOzmcuPiL+ISf
b5Di3M5YOacGfp/HY82jIW0ObkZHYMEfA0ae/V27QZogjbCl00mG3ZXeaH/E8rS7W4QavGrZ
krjlegwuxwWtp42GcXRUomYr6Dj3xOVqMerPJhcn97W5hkwaZF6QeAaZ3AvbQ0agdKN0TI0C
1wjWKvl3K23u6Xewkda+D7xPldWyWEwuaZtq5LKOThSmDICThAnFA131yGjO4War0yLAHOeG
zvEfRHnFpp+zenXTP4UCdDIU/YEc/TenOF/N54K46EPFFkplVROjlPz9gj/gnKw3L0kyJ3d6
QFPX86RgUzc8ode+e1nn/d6ngyTq/h7ug2SvJ93ye7wPkmTz71UoQl/kwf9Z539/PNHbGa5L
XN0V22upu8+xSX7t8f+zE7mluTpBOAZJ0xX9Z/vz//DpbV3L+57gQeS4K+WbZxu13pWt1WYM
mQ9JlxfCy3+NCT7SHlDTdJeiDg/g+9/MsycFHKE91f6ju0EXx5pLtfn33EcmgdjfLi67zzZK
37JN7/7Eefus/U4zsL3zuz5b2K7en/DrXKjq9niLHM9xlsn5gCoL2T5rxVsGk5RClSLKRLDP
5qn4b1ni2brqR9pIt0v3g8nKPHd32G0rvxu3EdOEsfAJSX2kHv7+HPz0tp+UtmlYW8SK/6vs
wrqT21hhdwXoQaqS2vK7/7tyuufj0hzWdvm4U5DUB+9x+tl2Ij4K8l/x2cbZR322bERbGKrq
bH/dtdz64WOfpyhEVByG6vePIwc/61p5RxtRDz2PHrt/nX6sHXXLzRUiifxbGElXAXKrwQfs
PGqberTXd5wtTxHhsKCy24ONYzy/+trc2/myFrISkRJ51NJWWEFVJwUkKES9Sb8GSRYZgEJf
ZJVICcvO6srax7mNqy5FGuC71DYM+RZaWeOURkInuUjiTRR0hzyr/NA9ig5zRSjSO3NRR6Ku
zXM/nm3EvvNJsWnr1qNLt6lZuz/JfY0eiP838qxpUfam5CluImHnUCMw2RLpmFeC41Pi3mQI
39zmtme4XTYeS3YXm38vEhTlxxBxB80gLFvCAJE0OJKhMT0ZcDaIK6QXnuewvllVov/6+fj7
l2dvH52/evrD+PWTpz+cvT05/hcw3aNw6CFvhzRe3Ivq31eINmRicfTpxwE7Vg/kiTESG7YV
kxjx4u6pqDoVNeEUbOhVYl/QVLO8beEgg1PaGGt26r6elNViOeyamI9k0CB7dVnhIq9eLRDn
A38TuY11/BtCEKjmUvW5BrmY41774oLNYK6mlzpmqzaKY4jh6vPK1mm72PQasVxKWM4hUYa+
GLxD+7/B8eg1k3HCvg+L7Ga8rGbldPlh1NBiwVmXPsxX2mxxJZ5oQhyK55PPYrL6Q+9d8XFy
UcpRgpg8yy/Lein60g9PkO7uaoF+n718df7P80ds1mMiTk9mOvZnQzgySTkrEIe1/Ue2mHGC
v6YXvslaNb9ge/5V/4RNziBQjOsCjAgWiIeYLb4Me6ZX/iiB5dmUwyT2VRzs3Ku16v8eX804
kAGhSB6EghPX0VL1feXvh8BM7OWn6suYRjwvCEci98PhUSfkcXDAsmpaTZHHsPiC+dh9oe1w
OEUHulIvKjixJOpBM0IC8mKSi34S7UlqRAZBGh6N1HSnFI0rgMnudTVmQzDYnMX7DczgMM4N
42ttXnlNmILdMdkxJgmCFWwZo9p3jAZr6ikk8JxOs8s1EdGnFTnRW1ZZXS6qgqXioiK4MYSf
nhJqxVijDWEdLJ7Ni6smM+Pp9fT0doXhYrnqMhI1PauXMIMpVhfGyPshEwzimxpfFhCg9yA0
WYHa4Z581BBKOam/jC9KGKvvKxMsjn+P4Z0ALtyT0sxkLm8z8+6s1EVz6HxaEXcQ3XcxHSKw
zdwaga0gsXfHoNnE9+MIARaOxXxrQ6OJQWTQvpJ7Ej8WCzt0VaAVOA/uvhuacYUIuPxe3Ngh
mRUT/2qF51fabh+eDY3ympf1xdXyo41misHeIWTaV4gas9VqQUPbY0ewPSPtAbHoSCfhuUN3
tBXZ8pvO+OPj0Hx8hHWgMSNUa0nCskLQYhr1w9hmbzGkpwwZd6DiX0+TaIwon8+q2QRG17w+
0PZQ0iciPdEKbSvu33G7/SvEsKFzQorksidDwTHHsPDX0yF2iPF0MhsjoDdL/RXj9OANczpf
iKz85Wq5En8/fyHWYc3CsLsNW6uiG0jaZ41ENfNk/PtAK97PXp2Laqrzym4XKrChrViq7CkS
Wqkym69IamOt9p5uFcs42etgZCsmsdyurciDhMnkwwKOdEZhUem+EiEIggQ+3JtUga3OO1Ld
cd5hVMTCCFveBHjTnxBussuBziS4nHyYZdS5qtVIcWw5QCNFy9FQpmmIAJl7t/xwpZ7kHg47
Vgbg1IWe7ylJTDfKClK2ISap9kcDzf7AzhjF/ihizSB6KLdFHKsriff+foGKCYemcmxxcuct
zqJME4QCcu1NZswHKbd23h7O013SfLj+Ew39BMFRd9YTOicGs1F0ZlG7G/Ru8c0hyrPhmgN0
jjV1Sve4L4OHnUUeeIqNhpC8UL53J/GWTqLg4BN4dND5wyJ44GlZzwDyaSAv3BF5NYxDT23X
IwEUDxViaXT8MouFSYLAETxaqEQipu7jY/5pkacc6OTbn74Tl2XFy4AEVS/xnS6DN3p5MuKo
D5dz9k23+QcaBMhxTyw6OOaf28jbfyt2K289/TjaPns+f+Bgp+yL0YSUwADauoHCx5rvXz5/
NRLnF1mO2NxlHhaZV9Ca/kJHzuVjGXu80I99UV8+9j6XYRarvCq0+wr9wJmElSdbtJEHH36N
9hWjIcShjIssLGLxl3ldk2x4LAlKo0zTKKwSE/Swg6H9d+Ih2u+3rNnkgUjztJZplY5EVYua
ulLh7qdKRJTD3LH2YdIZx7jwjdk8IQpFzBdsOlzMp+EQKshltRi2baScAcj01/YWuTBEJkUU
iTpYf/dEWogyEzXfqFALumVqoR7q/+lPNWxbQJQrr20hqDMvCznOYvvs9KcJnclYfXbMfk0a
PtZ7M9ruFZkT7TrqiAPOP339E3ymXiMsKx3QxNP5dLr2Ue+tZouR+I7DLqwh3R4ZQfxXSzJ+
EuJq46/ZomSfOXgBjcSPZy9+EucrkgWIs/z6qehPgsB7/rP4E+eneYTY3dHJI52KRA6lQkvC
C049eapsIFigDzyOEvwUm95bfKMftUVSIh8hf8ofszL9J++zjE6RXrUDxGHeBccGGa8WkPoL
wMkKgCpqIRUn6jPcM64WAPM9gjLxcRkI/tYExA6AYw0KbGkAbFnaAYzxhVtwhAFoHktiUoJM
YwLMW34JQh0RsYWj01pFgCEAqw7CKEJQTvHNHZT5bZRxjFhAAsVj7OMNTpmdIn94C5lIuPbr
+4nxp1ofBjFshWHXLWDqcby7bwwof4ycXy4Binn0WwEfehJ7BYstQM4vG6w1sEo/b2FljKRH
QFstSFivxmVVjPOLT+PgJvuCoUl0OOzQQ6g4rtROPUHCaQbt9GWhsyAReIxpi+MOeMIR8sbj
a4K1fVYlJrdooWh29UyQekbnq9WYo6+Ml1dYCglykZ0Bhnyi3BU60kEsv+HLLNIBTJ35DN3F
2pls2gyMFLS7o04TuQ6NgOiz4gto45IqBCFVCFq+iRBRc2f0kfRDDT0eL/MxBw9oplD6mGkZ
+i24SgIm+s5EZzUBFe3qRT5HgBafaJ3HlwwVBehoQXBRB1cQMduOx5PMV2NA80uniszRftlW
Cb0w2I/sojBG/nPSZcZ1Riql+WI/9hWBJ5A5ecst1HEG3gc/URU4AXGEv4xJyTt7+fbsjUbP
MyM7u3SUcBDzs+9fcy6ouK6ytEg7xSGy5jydl1VnK0lSUfrGXMWXcE4IcxGWgjaBJIfRnQrM
u+y+F+27b39PvbUnlCJUIgzRRMWm5QRZlNhm/xyWX4swg4/qrXpJCW1ArVvpbvqxGVasPEQ7
Pnvy80jopFi0g599+7ONdkytnz3Fv5K88sPcE2fPbFkStGwe+3wVf3b+/UgE0gtII5IE+r1F
kytCShNbe3EURZKaOKd/+XUdZ3HUyoE45HQcz85RL84Jyrw8P9eYxHf84vvivIF5/vcn35li
T8l26yGBDZV9J4IxcRTM9bW++r57if3HP/5RnC0WHG9O/Os0n8xOza7/FQ2NOLp/gpDxOv6N
0YZHnNnaq7JaJYIQ9Ix6Lb6lrZVRj0RH54Y0iqogQq41vMd+WgT2nfbm3LwHWZ1W9r2Ii/D9
+tFcdxO6OofcIc461SrvKavCp+ZiXw8OEbSrxXSy5JwhJX+c/a0OlnbCum7eVWlhwsCrG/i0
JqJuJifym/ckaX4vERfLvCdRVpj3yFdx1bxHLUyqMqprB/RCx//jy8lmQDZA+AB/cbaRxc3g
UtifBTKYwOQy9hOtDJ6uppd2VjmBEzZe1fPQJcaTSD9iPIPP63hI3hCbSd/g6axOD5ViXTvj
lOpNL6pql9q6EtcuN44Bf7cK7buPVXb5vmfBuV6l+7xrvUrXy6t69/b8INNzTS9Kba/Xs+UE
mOuiwcaOESCd1g0gZ40GxuWG1Qs8x+oFPVud8UgHHj914PF7tjrj2TxCgydy9Uf09Ufb8qRn
ETFG39Wz0NWzWxh9izFw9TFwUfwtjIHFGLow+g6M8hbG0GKMnJSiyxkwdjXtIoDb0xNbjIkD
o3IJhNuDSSzG1IXRRRS3+5hajJkLo4sobi9hZjHmLoz7LGFuMRYOwlVqD1YoLMbNYs5g3Get
S4uxcmCULra/PY+VxVg7Ri33oR4r4urNG1TDCrWVPbWWPduEZlEbkVLU/j2AvgUM7gEMLKAV
AOuj9jBqP43NqBGL8H+qxXxtoLouI3HzvC5nwNjVmnK1VtaGzcs6cY5NlzPgZu61gFVtmLKq
MyfGuja8Vtf5PYC5BdzMQmagnmOgoVdrrqEXh3LQs+UMaLWBTa0lkas1WWv6pxeHakCAqtZk
Hfq6aCsgf5wFYGAUtC2zFYaepn96cWoXppwBN2+AFjDyNFnTy+Z9rQUMLWDk7GPsadKll/ge
wNgC2l1o42JI12LouowkdaxoHLiRpBYJk/Vg2yTocgbcvIVYwMTTZE0vhXMSdDkDukk39Qzp
pp5Dke3ZcgasXTPiu2Yk8wzpZtJztpZLQ7q5dJOuLmdAZeZ4U7eixNUtXZeRWLG+EYlLCJu6
jCRwIQldSApp+KaQoXPcupwBI1drTirXdRnJZhWwbS22gC6eipziVNdlJOk9Y0stYOZoLXQu
h67LSHIXEudylNLwWyntNrK5y7qcAUvHcoROeVFJw4uV3KxT2dZ0OQNuVpV0a4GT6HVdIFGe
czlY5wFgrTpq1I6fkTbikxaf77mGqcsZ0L2J6HIGtPrPpvnwnQSj6zISu8FsROLcxHVdRuLU
jUw5Azp1I3xFZ0B6cepGppwBnbpRJJUmanpxEnWklCZqeimdGHU5A7r0H5U6pi7ylSZqeqmd
relyAPpOwjXlDChd3XKRRRT4mlqRBtjZmi5nQOfZwJQzoFWiNnVLurjX1GUkTt4w5Qzo4g3p
ImtTl5G4eEO6xFsU6i91eNn8ecB2WZczYOrqsuuUYuoyks0Hfdta5Bu+iXw338S+4ZvYd/ON
LmdAN9/ocgZ0CnxTzoBu3tDlAGTlf9vUec6F0nUZiVP5MuUMaHljY2vOhdJ1GYlL+fJcmoyp
y0hcypfnUlBMXUbiVL5MOQMyT21WOlXq5Cldl5HEBsm21mIL6NxTTDkDOhUsU86Abt7Q5Qx4
D28EljcCx3lbpS5ty9RlJPfwTWD5JnDsNyq9h2QsTwX1PfNveSr0/re9q+ttY0muz+avIBYL
ZG9yac9nz9CAgCTAIslDsA83WGBhCMJ89MiCJVFLUvb1Bvnv6amuosjR9CEl0/qwyw92m1V1
Zjjs7qmuOl2Nb4vkpAjeNwkMOrAtgchafAykhO9Sb0sgcJ3OclLM8UPIpcvnYL2RlPBd6m0J
BISfEhgnYVsCKdGd4K6Wy1DJsfvl5aSI3a8y56FS5nioeDkpwjU8y0kRruFZTopoOJRwGp7n
PBzmOQw/sbxXNBFUrHr5hhvcE5e/PVG7QzX+znnfXWH/jSuD34deTopw7MIJwNsSCHgfJgWc
AGrD78PawPgzy0kRv/O8nBTRBFDACcDbEgiaAAo4AXhbAsF+ZGN4kDcGvw9bw4O8NXiQezkp
4kHu5aRIgzzgIcCwFNv2IAXud15OisF+x3E5utpvf/vtrxvxzhWLRIDGU6YOKDkMKBWg8Bon
TWLYW7wtgYRzIw4E9hZvSyDh9Y8Dga+LTkC6AiZYWD5LixhfDUVJ2daBpBgEzeds60AyDIJ8
JLZ1IDkGQRMa2876zbsIJEITGtsSSHjmoIMEIEghIOEwZn9ODAYpBSS8OnUgqFeyLYGEQ5wO
BK3T2LYHKcepFwQSZ/jrlLGAgGcSZ2h8sC2BhAOSDgR2e287kyOYgiCwx/LxTX0DPNg4xZ1t
zg+223AoVk9CERu7U/jrdUzi6BmcUfAVsfnz4fPnank6EXWy4xfZkHM1sGtXC2fXdey8dl0B
YiB3dkSqP93dmvXtbtsjn/5RfiVi06Xl49l0x6IHHqVDfhMHM/r98azGB5EbMRFRCYR77VIK
mPQD13VeTCBshUBovShIILSG+TrWwAUjy3vFIhpVJGKPwUzDHQaKByJEwDw1mHM4QIwFcdyD
ZkTIZR0gynMMuNKMWADEeICYCuK4T82IhzMkLTvYrjHuYDMi4jMOn2MuiDCjzHJSHHc7+NLx
3i/zyAl5Z7fxt7+SjsHS3vm8KItNu53Hm7atNp+7r53Ct8rdr1LKwwY0SpM8ZLwIYyvgvzIi
oigOx0sliIBGaRLUIYbjpRbEcV+FER8y7zSCCGiUBpIeh8+xFUQLniMkPQ6fo0zLxfi0zIgP
mXdk/i7R/B0/YN4pZf4OLFwY8XBmti1l/i4Be9zEiIQ7eI6lzN/lOEuBEVEPHzzHUubvEgbl
WU6KgBOawQUz2eoWjhfkgX2PLRzCmG6xB6Z7PXSvhyhuuWW7K8idCiJHyNQENp4d7Kc9dG3J
MyZ+EF3JD6IrsX/q5aRIc9J4AD+D8Ua2JRBMgPdyUoQJeZaTYh2+rXSOXg15VDKrMSoxi9jL
SRGxGmFWn20JBLMavZwUEcN4DjmUEQcR82iOicNeToqY8+7lpIjpivGc6YrxHJPjvZwU0Z4P
mOJnWwLBxPmEI6KugYnz6Zy5i+kc5tVYToqYyOvlpCgE+NEvCnmqKQdjXQMRecutT3Tnmu5c
051rO4o//s61p9rD/w175rdvSnfZD3/l516iifqsd3vAG3xo90RLuwenu3XZ9/qXfccpAwL3
vXi3ivwrvBrI5rwayOZ4T2E+Z48/n+M9hV5Oisjjh1ROtu1BqgiBwGWDtyWQMJXCgcDdjd6W
QAD9L4U8TLYlEESHL6DP7G0JBNHhC/xgq0xA8F5ELydF+BJnOSmi7efFngdUCAjg/6YF3Pno
bQkErsxZTooVuhrc+WgqXsKYCu/vLSoei0WFx6KXkyIeiyTXTf26qR90cd3UvwPy423qfwRN
RxcMD1wwgBFxf8GgbBxl47xsNo7WFtMI7WHdViO0eChohHb3aroM0WXIuKIuQ7ZBnncZ8k/v
p4cVD/ZBCJzZ93JSxN3Py3vFOgKPxsAAkbclEBTLy2F63dsSCIrl5TAMV9bcpcsaTun5vOZ4
3bzGfd/LSVFicqO3BWeDquZxUdU4XlfXPC7qGo8LLydFFJPL4e/mbQkElX3J4eDytgQCp3uW
kyJi0uRwFve2BILrg3k5KSImTQbHvLclEPQqgLvs2JZAYCkZlveKTQR+Di0YCOYpLRioBQPH
b/mHKRj4yPTkY3f76JYWRtQtLfcQdUvL69nS8j3SHOqKqCsydjV1ReAD+mFckZGrjdcuHlXU
osRalFiLEj9VUeIAIft5jyKLUsFJo3DoEBeIUuLEIXZbxAkw3Q7tdBOtsqlH2NQZDCs3jX/e
roHd8bZhF6Bt4KTKclLEYX0vJ0U0qcKKZmxLINit9nJSRG51Clc5tmGHwzY45O/lpIjc6hT+
Nt6WQFAqLIW+ubclELTLMNnzvSsBQS53sufr1AKCmXxdwy5310AnhuWkiN1qLydF7KhEDTsq
tHhGiiQnRVx91MtJETsjXk6K0Mc2ccvOSNzi8tVJm0XRiED9fvX71e9/iX7/9ziMZLxmVpOG
amaFyQyPLbTDoU2tPaG1JwhEa08wneyV1Z7Y1Kk1RzleQE9eglfTk5f05CUB0ZOXhop68pKe
vDTVk5de88lLfXmZHbunrvB3/9K640p3XOmOK6/4JDuu+kBUi6MiXk6KcKEAX6ppyzN82sKl
lslansWzVqILIcVSFFFwHoYh2JZAEB8GlqhhWwLBM7yXkyLamgXP5mFbAsGzv5eTInSGoMOQ
cf7RNUDkIZnvecrsKGWb3GTgljn56BrQUcI/h5UopN0ThbQShbR7opBWopAWRCGTOUrhsC2B
4EVEZmVhbpFHBXcqsi2BwGiertd1va7r9Z93vf44RpOSiA6wuyMRIYbr0K4vgSJ7HrRWitZK
2SA++clF4b1MT1XLti8J9dh621pUUotKalHJXZBXWlTSh22f43j4XlFPVZ/pqeqs+KSnqhv4
ImH5TI9ff/bj11s+/NvYBlVDx0EVK8RXy8TXUAe3Qnztdm459mmoA6/2Ag+CTysIAo/VTqvx
0+TTh4DoafJjIM99mrysGUb5bloabqql4ZjLp6XhsOIrLw3HiQzKaODoaWYlMRjI44tibiWz
YLEHaKxkFiz2AA0n010DZxYM58iNsTizYDj17Ro4s2A4o+0aKFEHQwJs24N0Eb4ayUkRJepg
7IBtCQRkHRK4YmdbAoErJ3gnRSdZhw7TokrOoLsGTpqX/PJxDZA0T+CKnW0JBAb9zJxfPq6B
x0bFLx/XwKujml8+roHHRs0vH9eA63yWk6Ks80dXR4F3+hBOiYVKLFRioZ8dXhqx8HvE7EYT
UVo/Teunaf20DeLLqZ92/J2KBx8NE6r4uJ1xeMjpVF5RK0iPgWgF6cFtaQXpF1tB+i4a6Z9L
YQJTOUUj4wzHRXn2dg0QXI0z5BKyLYGAvEEMvy7b9iBzEHCOYREXtiUQEKGNUxy1ZmZG0Vl0
J7CyBNsSCOjemz8fPn+ulqcTUSc7doaHhLSBXbtaOLuuY9+46wIu18Buta6aT6cTYrCA4fD9
D00LT7VaTVSriWo10cAtH7OaKDMTOB/iGjiGVHM+xDVwKLfmnIdrgBqkiYFBi4bzIcYf5he+
mhz25xrh9+HdDAiy+pHwDKKgRxkdBiQ8gyjIM+jzhTCk620JBHEMMKW9jYRjECGOAaa0t5zM
MR0GgUG6jkGKGIHEcDMP2/a5dgwC88qpgGQYBL7mMwHJMQjMK+cCYjAIdsLuQJDXMlZaJVIa
mSgqjUxpZEojOxKNrMMgr43YlWEQ5WTdB3nhnCwNpRCIL8eVvi/z4hjluLbi6VqLT2vx8dW0
Ft9A8YXU4jv+vrQ9R5KNlxGdx/fKiMKNdXoCypaiVkLWSsj3FX/oSsjbgQ9xaKNwz01jWNSE
bQkEOW+QOs+2BAIc2hiy2Ni2B+GMxTgITByzLYEAJz+G0WG2JZBxhgyD4GfCs3BhEhTbgtlb
tiUQ9GCzPSD8YDu0QI5T+Ew6XiC7BngXb/7cpfWKzcV5HjssrVdzSaYOslLv7Dit5z366H2Z
HaXA7lH2yWvCdueXfWTCdven0BIADPLtJQA+uM/z8m0eFUnsBo0Qyq4q95z/ZErzy/R2Zdvp
+dJWPclsSr+HGyA364/vp27STqb1VyeYXtpurfUEtJ5A6GpHrCewUTwODXDPsQ37VmR3pU4g
xXH77bGpA59nRwk8KY9ReYy7t6U8xhfLYxy5ZR6LdOvhgE3wN93MVg+rAsez1iHc69HQlvOB
v38hKS1Vd4jd1nmXPNFgZ1zsvDrZgTzF0C7NhHPkXpz4nMxWzsm0XhQ8J9Ma2YxjoHvA8p3q
eoPR0rjRUm6qfH+oLhanu/sUtOweQHxhZfe24+fwUN89Dhh5XPH70hzF4+K7crPD3cFfcTb6
7V9piUDdrhfpdr2Dn6Nu1+sRD97KNnCn7h8U+Ch/7imrevZ2P9LuROVuKHfj/tWUuzFQ3OVu
6NLsALutpRmgMwztvs8SS1wJA0eZLpBe0wLp+RYd37yjfzSqJN7IXhrVYPFF7b5MAJhVXxuj
TNOcR0tzambyJ8lMaihEQyGHP0cNhXyfUMjzxQb2Ea6bu8+FcL1NAKAgyPFiMnLLs/4v4PoW
2FGdcCnsHicF27zx1iNdsD1wwQYW80O7lA7oop5Y7VmwVbJgq70ouGCrWzk2tcULtrqVs0s3
5zOOzBEFXrBNxJxwwFxT4GXaRMwJB8wwxQMWPrWVZ2bB4qxID58Faz4T0jXGZxhGREup4Zm0
mSBuVvq8PPqR6FLKNlK20eC2lG20h22kCQtNWGjC4tkTFs8WGjzeggLmZ8f8F7SKiwf+C084
tcUTTs1bRlxjfMLhSyN3c+iMFYI4/jN5xAQtkoZfphREEMYpEuSCDu9xLojj8xkjIhd06DBW
ggjCOEXykJ+wFsTxovqMiBbiQ8e7EUQQxilgYGj4HGVVEzgRwyPCwNDwOVpBHKcEMuJDeo8s
qDq4q5nlpAj3iWYNH3PhGtBnZDkpwupNLJ/JOUmhGVfPWPJOhp6xpGcs/ehnLJ1OfqRtDf3V
moY7YtPgjtg23BHbBk7ELCdFvHj3clJEG/ZhYWa2JRCcpfNyUkRlZlP429iGe7ptcE/3clJE
PT2Fv423JRDU01M4U3pbAkHudLLne1cCgjLtyZ6vUwsIXkF2DU/uXQMLZLCcFPEq0ctJERfB
iOSQ0YgPGR0qKgdBOQjKQXhuDsIzhvs1xXeA3V2KD1UbH9rt7D1TBqUyKHXblnKVlKukXKUX
tI+pJ0CHnQc91ea+op5qg66mp9q8ulNttELslqJWiNUKsfcVf+gKsX4PlP/pW/6iUYvPBvFy
UsRfxstJEY5RE7f8ZeIWnyeetHx+R9LCwcxyUkSDGZ5HYdKWz+hIWxghN1nLB81krXClQoql
KKIoOCRVsS2BoFcWPFeCbQkED3QvJ0WU4oQHULAtgeCzxjNmMbsGOmsc0rvYlkCA+5jAk6/Y
tgfZ0KQDt8w8aNcAE0QCU+tsSyB7JggrE4TdM0FYmSAsmCCSebodLlTSr5J+lfT7HKTf58zF
KzlYycHDqyk5eKD4QsjBmrPXnL3m7H/inP3RvXUu0sYL697xAWAsJ0W4sMbLwdQICIqS4cMv
85QX3XmKT3f1clJE7iU84JJtCQT6IMakvLA2KV5YFykvrIsUR9C8nBRxBM3LSRGfOe7lpIij
ZF7eKxLJN7j4hz+UtyUQHFjyclKURfDo1eAP5W0JBE2eEYz8eFsCQZNnBM9n9rYEgk9M9nJS
pDEVOAMYno/NtgRSMEjoaoUowugyy0kRn4rs5aSIx4aXk+KesZHJ2MhA0CmBrjXbEsiecZPJ
uMlg0GlPl5ExlXV7nr+MqTzCt0VyUoSBJdwJcxlTOTxpHAbUvC2B4Pisl5Nijh9CLl0+R4eE
Q7eVbQkEHRIO90OwLYEAXyKBDijbEghOxHg5KeJETJnzUClzPFRKPiLJNaC/wHJSHPMXuB7b
5rQRc5RDsYZ3oUR/Jfor0V8Un4rov1F88hSfpgI0FTC4LU0FvOBUwL1b1re1vq31bf2TvK2P
T8g5vTtvkNcdtABBy2wYGzfznJfZ8xy6ESzvFU0EFSkg3StWBj9mLydFuJSG63FvSyAgPJUU
cD1eG/55agPLPrCcFHEIystJEa3HC7ge97YEgtbjBVyPe1sCwWHdxvCauzE4PNUaXnO3Bq+5
Wz5WzDXwmrvlrV2uQdNMIGAHieBsSyAwRcbyXrHAHbTlTVquEeygPAfTbf32t9/+uhHv3Brv
zXKN8b1ZDig5DCj9/gfNnE6USKhEwntXUyIh/jmOTiTEtyX5RYtfRJmV/KJFL6Ld0kE6WnW0
6mh9LaP1/tWEDRCoEHh3NRlvFmcuMyvjLVDPTxRzK1l9i11DYyWrb/G4MVxUzzVwVt9wrTzX
wNlJwyXwXANn9Q1XtnMN1P8hC4pte5AuwlcjOSmi/g/pUmxLICDjn0CSEtsSCFxSwTspOsn4
d9hzLIUpU3bYcyy5Wp5rgHdRAklKbEsgeGzMuVqea+CxUXG1PNfAy6aaq+W5Bh4bNVfLcw1I
bWI5KUp0ZnTZhBeZXC3PNTbjxh/mtP9c3284aWrfSRHzmNoRL5vCc2+axPD7tVxzwjXC9FcH
Al+8LZeZcI1w33MgcFx5WwfSYRA4n3QMUsQYBA1OtnUgKQZBrxm2dSAZBkHjkW0dSI5BUAyI
bR2IgSBwaz/bEkg42OJAkLfDtgQSjiHjc0LElkDCORsHgnos2xJI2Lt1IKizsW0PEigpQSBx
hr8OV5FwDfBM4gyNHbYlkPCuaQcCu71htn5h5qCfxDB7wbYEAh5snOLOxizzorPoTuDeaLYl
EPBC2fz58PlztTydiDrZse81LFI1sGtXC2fXdcyM6bpA6ZeB3WpdNZ9oFlcPVT1U9VB/Xg81
IGsFBPfymissuwaomJEY6ME1XH3Z+KN9w1eTo39dI/zOu5vlQKw+kuxBFMweRIcBSfYgCmYP
+lc57O3elkCQL4254G0kvnSEfGnMBW+5dLSbTiAITPt1DFLECCSGAS627d1gDAJdvlRAMgwC
X+WZgOQYBLp8uYAYDIIdrTsQ5JnAbZFsSyDAl45h0IxtCQT5jTAWxrYEAnzpGHK+2bYH4cpX
4yCQIMa2BIKeCawyxLYEMl7ZjkHwM+EKRIVJUD+BLC22JRD0YLM9IPxgO7Q2j1P4TDpem7sG
eL3duaUbN7jYXJzfdoe5wTWH/Dv48ruzYzeYIyihoy+PeOqlVqE9wG7roEme5/CvL3ZeneyA
eza0SzNxK9wvjg+obOWASutFwQMqrZFqoQbv4t8qnBvwnxrnP5Wb03g+VBeL060h9sF9mM/f
JrlJzPx0KvUYm3j6p9Jkv0xvV7adni9t1VdonFJ3n7b2Zv3x/TTPy2haf3WC6aXt1hOtzvu6
qvNyePf4EWZdEeiKQFcEAGSzIsgMCjPiFUHGBLzhssKTF3VZgUB0WXEfRJcV2yAvYllxOhl9
62sFfa2gP0TUCvpaQf+FV9DfuprWztPaeXw1rZ03UNypnffduFd7QpW+1HXw0WnZPi3bp2X7
tGzf7tVebtm+bUWtrAEfuVbW0MoaVOZBs5VPkq38PtlDWeHvPU1TFu6SPRz+PLS82iw4r+xV
176nvwcrV038AcQXlvh7sqCir4+Xvi/z4hj18bTWj9b60Vo/ga+jtX7GFF9srR/dhb8Forvw
dRf+AbvwNUcJ7lFzlJqj1Byl5ig1R7l1Nc1RPkGOEt3/UROFu9XxsJOiNXl2FXXH872r6Y5n
3fH8QmryBK6mOyZ+6h0T7RwQtvfsmGiZczLcduFfwweCvOhtF0obUtqQ0oaUNjSqqLQhpQ0p
beg5aENPlqTfZvt8wxZMLcqyBaK7J3X35A+ze1JZPMriURaPsnjuKyqLZ/e2lMWjLJ7Rq3F1
qCzJneuwVR0q6atDlbg6VJ8026kO9ZrP5TjW8VsvpPK+pjQDiprS1JSmpjTvPxFNaf4QKc3f
nzulqUXg7kcgMxz3w0XgJO63CWPyTxxDkCcoVMt/ZpubGSeKFni7nW4hPchuq+AtWPkO7dKs
8r+Ra+zZelrJ1tPai4JbT2teULkG3npa83onqzfrnRGuc4F3jE7EnHAAZ7rA+0QnYk44gCld
PGDnZW3lmVmwO7RID2dz17wuco1xh4gR0V7OZICYCeK458SIiB8eDxBpWgskSnJ06tGeREku
4eN8MxgJxO+UPRSEKcZFHvhRDgLh32GY92ntA0Du533G3s6a9xkB0bzPfRDN+2zyPm4Owls7
ao5uuMb4Co5nPfTuGc7MhSCOE+I9YoKcneE8Wgoi2JtWJOh9NLzHuSCO7xxhRPQ+Gr49KkEE
e9OK5CFvj1oQx6O/jIh2Fw3fwo0ggr1pBdztNnyO4uIEgj8eEe52Gz5HK4jjq11GfEjvEe+q
G3e+N0OhE7eng8mVrOGIjmvA4C3LSTHbo5iJItrbAldRbEsgeMw3HLVxDcSugy+5rOWIjmvA
iA7LSRFv57KdbBjFEZ2s62Q7VwejnSwnRZRAgS/iPOpkO1eHGXRRJ1u2OsToKSGdK+Zoj2tg
dl3CEZ089aKgYkaf9GzcCCfl80hYqRHe25VHwjyNMMHNcMAkv3MOQ4q5KOJtWQU7ea6Bc+YF
O3KugXLmJeQDFOzIuQbKGRaQ6FWwI+cakjMP3XIlipj8WUac+y4jnPv2clLEXXcecdedR5iI
7eWkiIjYMJidVxF33Ypd2yAphd1X18Bd18tJMeFnPEo1hQRPb0sgiFAN479sSyCIUG0gobqJ
edw0MeaheDkpIh6Kgb3c2xIIDOKznBTRmDJwOvW2BIK3QXo5KaJcew5/Dm9LIIhrksOfo415
vLUxJoZ6OSkiYihcbuU25rFoY8xDsbykcg2QGEgz2Om9bQ+SRPDnIJ+nV+wS6EaxnBTxzl8v
J0X8duh42ecaiFECTxFmWwKRN8coCHw7e1sCgU4Py0kRp3gjXo26Bk5jeTkp4hRvnHAaK05w
ijdJOFWVJDhV5eWkiBybBDJD0oTTWGmCWVNe3iumsEeynBRBijdNMPsjFfZHuqeGSyqMjXQP
YyMVxkaKmIgxpsCkwthIcRrXy0kRsq0wRygVikOKxkYMU/N5yinePIUb4VlOimhrQAxzcd6W
QGDtB2NSoUakeNwUKY+bIsXjxstJEY8bLydFnOL1clLEY8PLe0Xy6oOMMPhDeVsCwWxDLydF
QH9IcdLU2xII8qpw0tTbEgjyqiKYNPW2BIJZUF5OijSmxr3JBKYj2ZZACgYJXa0QRUyN8HJS
xNQILydFPDa8nBT3jI1MxkYGFtIJjPKzLYHsGTeZjJsMMhH3dBkZU1m35/nLmMojfFskJ0XI
NsSdMJcxlYOtaAmsYsK2BILZQF5Oijl+CLl0+RwV/4AbhNmWQEBcKYEBELYlELD7LIFbfdmW
QLD75eWkiN2vMuehUuZ4qHg5KcLFOctJERNzvZwU0XCAu4XNPOfhMM9hXInlvaKJoCJt0e0V
K4NfI15OirDLw3HjbQkEsujguKkNv0ZqA+OxLCdF/KrwclJE46bAnDFjBASNmwKOG29LINj9
agyPjcbg10jLB++6Bh4bLR+/6Bp4bLR8Qq9r0NgIvFhhmIZtCQTGqljeKxa4g7aFUNUC1bDd
bXFAi24rTFUrhKoWKILtgJLDgISuFqh97UliMexWbSF0NZToTPDSoC2kAkcBqFlJDKdjb9tz
3jAIdFs7BiliDALz+7GApBgE5rJTAckwCPJP2JZ4IBAE5rJzATHAL3MLV8gDNOyXFWb3Tvz2
nUNBNndSAKZBArfXsC2BAPZFArfXsC2BAJJAAnfNsC2BgGNpE7jQYtseJFDDkukK+Otw2UrX
QIyUDBNsSnkmZThU6EAwN4aLBBZmjliacIsl2xIIOu83xZ2Ny9kUnUV3AgOCbEsg4PW2+XNH
4bCbi/Pb7jAKR8eOYdcFas0O7JjCMfnzZXXT7y1aX1zZ91MTTSafPl+d/Gny5u/26na2+rpa
26vZ76U5M9nkzcxeV/WlnTkV95/m5nb6n9Xqi728/PVfVlf2pv+7unESf9zA9I/+X/dBn0Ff
ttN3i9XFVXVu3/WHE3xZruXf2UVamhkn2t825/9wJlfTMp4nrrG6upn2/7rHfNHYKbEHf722
a/f/E/dP5ET+f/0mqeWvFy19+uvHxWrdfWlP1s3N+/c9gTuZvU96nHqxWE8Xy9YuT66b3ngx
W9r+Q9f+Uq2bj+3ifHrR+3J2VW99NquatT8job49d58v1820rlb25HLRVJf98+tv1i4vqsvp
at1eLPp7vljdXFZfp9eL6156tXBfcLGcXt9eXk5+mUyqG/f92/5pL931T6gnLasr95U+3l6f
n62r1aezm+r6ojmJJ2/4utWN+y+33c+z/PtZdfml+ro6879N67Ca25u2Wtu3rnHmfqQz91tf
Xp71d7i4XZ+45zd54x7R24vuurqyqxP33xv36Nef3rrrf7panZ8srt1HdN2Zu/Bq0a3dd/x0
e3N3M9dXF2fyYE7o08mbxeJmJe3LRdWeua/iHsCnk6S/wOLqZr35xF2yXdbt26uL68XyrFnc
Xq9PSvo+rru1by8X52eX9rO9PLHL5eTNxbnTsmfuU/pw8qZZXK8Wl/Zkvf7qkGy1vPzqv0H/
yW/Rr3HcL2F39LY+/XxenTjAq8ohLb9M3tTL6rr5eEKbzK6ry76j0VkZ7u/Zx8WtA58lfU46
i+aRGwT//pe//M/Zf/33v/3Hn0/e3Xw6f3d5cX37+zvqwQ6oddfsLs5nbhAmYla+O2+aWfEu
sWlLm7vLfutu3GRdnbRxnse5rW2/f6ftytI5Iu8+X/Wg/5jlb83baBbHWTmfne9Y+1/ZLru3
q4+363bx5bp/pvKLnK0/Lu3q44kbzq6X/eGP/+sG7Id/Pf2/P0xnvstN3We+9eGf3ceT/weS
XaHyUdsCAA==

--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-openwrt-vm-openwrt-39:20200409172853:i386-randconfig-c002-20200408:5.6.0-11490-gf45ec5ff16a75:1"

#!/bin/bash

kernel=$1
initrd=openwrt-i386-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/openwrt/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 8192
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	rcuperf.shutdown=0
	watchdog_thresh=60
)

"${kvm[@]}" -append "${append[*]}"

--cxfMsoqvp1jUizWj
Content-Type: application/x-xz
Content-Disposition: attachment; filename="5c7efc30142653ff7af43d7343b466309c78bfce:gcc-7:i386-randconfig-c002-20200408:BUG:Bad_rss-counter_state_mm:_type:MM_ANONPAGES_val.xz"
Content-Transfer-Encoding: base64

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

--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.6.0-11490-gf45ec5ff16a75"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.6.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
CONFIG_MWINCHIPC6=y
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_TOSHIBA=m
CONFIG_I8K=m
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
# CONFIG_GOOGLE_VPD is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
# CONFIG_EFI_TEST is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM_WERROR is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_CYC_COMPLEXITY=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=y
CONFIG_ACORN_PARTITION_POWERTEC=y
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZSWAP is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_TUNNEL=y
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=y
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
CONFIG_CAN_SLCAN=m
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
# CONFIG_CAIF_USB is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_I82365=m
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=m
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
CONFIG_ATA_OVER_ETH=y
CONFIG_VIRTIO_BLK=m
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=y
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
CONFIG_SCSI_AHA1542=m
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=m
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
# CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_FDOMAIN_ISA is not set
CONFIG_SCSI_GDTH=m
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_CEVA=m
CONFIG_AHCI_QORIQ=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_ISAPNP=m
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PCMCIA=m
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_QDI is not set
# CONFIG_PATA_RZ1000 is not set
CONFIG_PATA_WINBOND_VLB=m

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_LEGACY=m
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=m
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_ISCSI_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
# end of WiMAX Wireless Broadband devices

# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_AD7879=m
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
CONFIG_TOUCHSCREEN_INEXIO=m
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_HTCPEN=m
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2007=m
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_STMPE=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_ASPEED_VUART=m
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_TIMBERDALE=m
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
# CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=m
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=m
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_HW_RANDOM is not set
CONFIG_DTLK=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=m
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=y
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_PCA_ISA=m
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_FSI is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=m
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
# CONFIG_GPIO_104_IDIO_16 is not set
# CONFIG_GPIO_104_IDI_48 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_OLPC is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_DA9052=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_CROS_USBPD is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=m
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
CONFIG_SENSORS_IBM_CFFPS=m
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=m
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=m
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set
CONFIG_DA9062_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=y
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=m
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=m
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD70528 is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_HI6421=m
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX77686=m
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=m
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=m
# CONFIG_REGULATOR_SKY81452 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8400=m
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
CONFIG_IR_HIX5HD2=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_GPIO_CIR=m
CONFIG_IR_GPIO_TX=m
CONFIG_IR_PWM_TX=m
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_LVDS=m
# CONFIG_DRM_PANEL_SIMPLE is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_ROCKTECH_JH057N00900 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SONY_ACX424AKP is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=m
# CONFIG_DRM_PARADE_PS8640 is not set
CONFIG_DRM_SIL_SII8620=m
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=m
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_TI_SN65DSI86=m
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_I2C_ADV7511 is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=m
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_PWM=m
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=m
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=m
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
# CONFIG_MMC_SDHCI_OF_ASPEED is not set
CONFIG_MMC_SDHCI_OF_AT91=m
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
CONFIG_MMC_SDHCI_CADENCE=m
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_SDHCI_MILBEAUT is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=m
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MMC_SDHCI_OMAP is not set
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77693=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=y
# CONFIG_EDAC_AMD64 is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_DW_AXI_DMAC is not set
# CONFIG_FSL_EDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=m
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_CHARLCD=m
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_GOLDFISH_AUDIO is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_KS7010 is not set

#
# Gasket devices
#
# end of Gasket devices

# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_DCDBAS=y
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=m
# CONFIG_DELL_SMO8800 is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_XO15_EBOOK is not set
# CONFIG_XO1_RFKILL is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
CONFIG_CROS_EC_SENSORHUB=y
CONFIG_CROS_EC_SYSFS=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_CROS_EC is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_STMPE is not set
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=m
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=m
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=m
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
# CONFIG_FSI_SBEFIFO is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
# CONFIG_OCFS2_FS_STATS is not set
CONFIG_OCFS2_DEBUG_MASKLOG=y
CONFIG_OCFS2_DEBUG_FS=y
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_IO_TRACE=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_HISTOGRAM=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=m
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=m
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_586=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=m
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=m
CONFIG_AUDIT_GENERIC=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=m
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_BTF is not set
CONFIG_GDB_SCRIPTS=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--cxfMsoqvp1jUizWj--

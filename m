Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BFCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B352075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgE2Mcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:32:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2Mce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:32:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE854ACB1;
        Fri, 29 May 2020 12:32:30 +0000 (UTC)
Subject: Re: 28307d938f ("percpu: make pcpu_alloc() aware of current gfp .."):
 BUG: kernel reboot-without-warning in boot stage
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Linus, Torvalds," <torvalds@linux-foundation.org>,
        philip.li@intel.com
References: <5ed0b6ea.QaEVKYBGHpcVDpW8%lkp@intel.com>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <21fb7dbf-1fd2-cfcb-860e-c342ae0c310e@suse.com>
Date:   Fri, 29 May 2020 13:32:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5ed0b6ea.QaEVKYBGHpcVDpW8%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/20 08:16, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 28307d938fb2e4056ed4c982c06d1503d7719813
> Author:     Filipe Manana <fdmanana@suse.com>
> AuthorDate: Thu May 7 18:36:10 2020 -0700
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Thu May 7 19:27:21 2020 -0700
> 
>     percpu: make pcpu_alloc() aware of current gfp context
>     
>     Since 5.7-rc1, on btrfs we have a percpu counter initialization for
>     which we always pass a GFP_KERNEL gfp_t argument (this happens since
>     commit 2992df73268f78 ("btrfs: Implement DREW lock")).
>     
>     That is safe in some contextes but not on others where allowing fs
>     reclaim could lead to a deadlock because we are either holding some
>     btrfs lock needed for a transaction commit or holding a btrfs
>     transaction handle open.  Because of that we surround the call to the
>     function that initializes the percpu counter with a NOFS context using
>     memalloc_nofs_save() (this is done at btrfs_init_fs_root()).
>     
>     However it turns out that this is not enough to prevent a possible
>     deadlock because percpu_alloc() determines if it is in an atomic context
>     by looking exclusively at the gfp flags passed to it (GFP_KERNEL in this
>     case) and it is not aware that a NOFS context is set.
>     
>     Because percpu_alloc() thinks it is in a non atomic context it locks the
>     pcpu_alloc_mutex.  This can result in a btrfs deadlock when
>     pcpu_balance_workfn() is running, has acquired that mutex and is waiting
>     for reclaim, while the btrfs task that called percpu_counter_init() (and
>     therefore percpu_alloc()) is holding either the btrfs commit_root
>     semaphore or a transaction handle (done fs/btrfs/backref.c:
>     iterate_extent_inodes()), which prevents reclaim from finishing as an
>     attempt to commit the current btrfs transaction will deadlock.
>     
>     Lockdep reports this issue with the following trace:
>     
>       ======================================================
>       WARNING: possible circular locking dependency detected
>       5.6.0-rc7-btrfs-next-77 #1 Not tainted
>       ------------------------------------------------------
>       kswapd0/91 is trying to acquire lock:
>       ffff8938a3b3fdc8 (&delayed_node->mutex){+.+.}, at: __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>     
>       but task is already holding lock:
>       ffffffffb4f0dbc0 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x5/0x30
>     
>       which lock already depends on the new lock.
>     
>       the existing dependency chain (in reverse order) is:
>     
>       -> #4 (fs_reclaim){+.+.}:
>              fs_reclaim_acquire.part.0+0x25/0x30
>              __kmalloc+0x5f/0x3a0
>              pcpu_create_chunk+0x19/0x230
>              pcpu_balance_workfn+0x56a/0x680
>              process_one_work+0x235/0x5f0
>              worker_thread+0x50/0x3b0
>              kthread+0x120/0x140
>              ret_from_fork+0x3a/0x50
>     
>       -> #3 (pcpu_alloc_mutex){+.+.}:
>              __mutex_lock+0xa9/0xaf0
>              pcpu_alloc+0x480/0x7c0
>              __percpu_counter_init+0x50/0xd0
>              btrfs_drew_lock_init+0x22/0x70 [btrfs]
>              btrfs_get_fs_root+0x29c/0x5c0 [btrfs]
>              resolve_indirect_refs+0x120/0xa30 [btrfs]
>              find_parent_nodes+0x50b/0xf30 [btrfs]
>              btrfs_find_all_leafs+0x60/0xb0 [btrfs]
>              iterate_extent_inodes+0x139/0x2f0 [btrfs]
>              iterate_inodes_from_logical+0xa1/0xe0 [btrfs]
>              btrfs_ioctl_logical_to_ino+0xb4/0x190 [btrfs]
>              btrfs_ioctl+0x165a/0x3130 [btrfs]
>              ksys_ioctl+0x87/0xc0
>              __x64_sys_ioctl+0x16/0x20
>              do_syscall_64+0x5c/0x260
>              entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     
>       -> #2 (&fs_info->commit_root_sem){++++}:
>              down_write+0x38/0x70
>              btrfs_cache_block_group+0x2ec/0x500 [btrfs]
>              find_free_extent+0xc6a/0x1600 [btrfs]
>              btrfs_reserve_extent+0x9b/0x180 [btrfs]
>              btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
>              alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
>              __btrfs_cow_block+0x122/0x5a0 [btrfs]
>              btrfs_cow_block+0x106/0x240 [btrfs]
>              commit_cowonly_roots+0x55/0x310 [btrfs]
>              btrfs_commit_transaction+0x509/0xb20 [btrfs]
>              sync_filesystem+0x74/0x90
>              generic_shutdown_super+0x22/0x100
>              kill_anon_super+0x14/0x30
>              btrfs_kill_super+0x12/0x20 [btrfs]
>              deactivate_locked_super+0x31/0x70
>              cleanup_mnt+0x100/0x160
>              task_work_run+0x93/0xc0
>              exit_to_usermode_loop+0xf9/0x100
>              do_syscall_64+0x20d/0x260
>              entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     
>       -> #1 (&space_info->groups_sem){++++}:
>              down_read+0x3c/0x140
>              find_free_extent+0xef6/0x1600 [btrfs]
>              btrfs_reserve_extent+0x9b/0x180 [btrfs]
>              btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
>              alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
>              __btrfs_cow_block+0x122/0x5a0 [btrfs]
>              btrfs_cow_block+0x106/0x240 [btrfs]
>              btrfs_search_slot+0x50c/0xd60 [btrfs]
>              btrfs_lookup_inode+0x3a/0xc0 [btrfs]
>              __btrfs_update_delayed_inode+0x90/0x280 [btrfs]
>              __btrfs_commit_inode_delayed_items+0x81f/0x870 [btrfs]
>              __btrfs_run_delayed_items+0x8e/0x180 [btrfs]
>              btrfs_commit_transaction+0x31b/0xb20 [btrfs]
>              iterate_supers+0x87/0xf0
>              ksys_sync+0x60/0xb0
>              __ia32_sys_sync+0xa/0x10
>              do_syscall_64+0x5c/0x260
>              entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     
>       -> #0 (&delayed_node->mutex){+.+.}:
>              __lock_acquire+0xef0/0x1c80
>              lock_acquire+0xa2/0x1d0
>              __mutex_lock+0xa9/0xaf0
>              __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>              btrfs_evict_inode+0x40d/0x560 [btrfs]
>              evict+0xd9/0x1c0
>              dispose_list+0x48/0x70
>              prune_icache_sb+0x54/0x80
>              super_cache_scan+0x124/0x1a0
>              do_shrink_slab+0x176/0x440
>              shrink_slab+0x23a/0x2c0
>              shrink_node+0x188/0x6e0
>              balance_pgdat+0x31d/0x7f0
>              kswapd+0x238/0x550
>              kthread+0x120/0x140
>              ret_from_fork+0x3a/0x50
>     
>       other info that might help us debug this:
>     
>       Chain exists of:
>         &delayed_node->mutex --> pcpu_alloc_mutex --> fs_reclaim
>     
>        Possible unsafe locking scenario:
>     
>              CPU0                    CPU1
>              ----                    ----
>         lock(fs_reclaim);
>                                      lock(pcpu_alloc_mutex);
>                                      lock(fs_reclaim);
>         lock(&delayed_node->mutex);
>     
>        *** DEADLOCK ***
>     
>       3 locks held by kswapd0/91:
>        #0: (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x5/0x30
>        #1: (shrinker_rwsem){++++}, at: shrink_slab+0x12f/0x2c0
>        #2: (&type->s_umount_key#43){++++}, at: trylock_super+0x16/0x50
>     
>       stack backtrace:
>       CPU: 1 PID: 91 Comm: kswapd0 Not tainted 5.6.0-rc7-btrfs-next-77 #1
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>       Call Trace:
>        dump_stack+0x8f/0xd0
>        check_noncircular+0x170/0x190
>        __lock_acquire+0xef0/0x1c80
>        lock_acquire+0xa2/0x1d0
>        __mutex_lock+0xa9/0xaf0
>        __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>        btrfs_evict_inode+0x40d/0x560 [btrfs]
>        evict+0xd9/0x1c0
>        dispose_list+0x48/0x70
>        prune_icache_sb+0x54/0x80
>        super_cache_scan+0x124/0x1a0
>        do_shrink_slab+0x176/0x440
>        shrink_slab+0x23a/0x2c0
>        shrink_node+0x188/0x6e0
>        balance_pgdat+0x31d/0x7f0
>        kswapd+0x238/0x550
>        kthread+0x120/0x140
>        ret_from_fork+0x3a/0x50
>     
>     This could be fixed by making btrfs pass GFP_NOFS instead of GFP_KERNEL
>     to percpu_counter_init() in contextes where it is not reclaim safe,
>     however that type of approach is discouraged since
>     memalloc_[nofs|noio]_save() were introduced.  Therefore this change
>     makes pcpu_alloc() look up into an existing nofs/noio context before
>     deciding whether it is in an atomic context or not.
>     
>     Signed-off-by: Filipe Manana <fdmanana@suse.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
>     Acked-by: Tejun Heo <tj@kernel.org>
>     Acked-by: Dennis Zhou <dennis@kernel.org>
>     Cc: Tejun Heo <tj@kernel.org>
>     Cc: Christoph Lameter <cl@linux.com>
>     Link: http://lkml.kernel.org/r/20200430164356.15543-1-fdmanana@kernel.org
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> cbfc35a486  mm/slub: fix incorrect interpretation of s->offset
> 28307d938f  percpu: make pcpu_alloc() aware of current gfp context
> +----------------------------------------------------------+------------+------------+
> |                                                          | cbfc35a486 | 28307d938f |
> +----------------------------------------------------------+------------+------------+
> | boot_successes                                           | 37         | 0          |
> | boot_failures                                            | 8          | 17         |
> | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog | 2          |            |
> | RIP:rcu_torture_fwd_prog                                 | 2          |            |
> | BUG:kernel_reboot-without-warning_in_test_stage          | 3          |            |
> | BUG:kernel_hang_in_boot_stage                            | 1          |            |
> | BUG:kernel_hang_in_test_stage                            | 2          |            |
> | BUG:kernel_reboot-without-warning_in_boot_stage          | 0          | 17         |
> +----------------------------------------------------------+------------+------------+
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> [    0.144174] RAMDISK: [mem 0x7fa2e000-0x7fffffff]
> [    0.144559] ACPI: Early table checksum verification disabled
> [    0.144985] ACPI: RSDP 0x00000000000F5850 000014 (v00 BOCHS )
> [    0.145424] ACPI: RSDT 0x00000000BFFE15C9 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
> [    0.146051] ACPI: FACP 0x00000000BFFE149D 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> BUG: kernel reboot-without-warning in boot stage
> 
> 
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start cef077e6aa4c7dbe2f23e1201cf705f9540ec467 v5.6 --
> git bisect good d32cedbec0a64e24548986a0159ab86cfe6a4097  # 08:34  G     10     0    0   6  staging: wfx: drop struct wfx_queue_stats
> git bisect good 2760220700ac830837742bad575630cd9bac8eba  # 08:34  G     10     0    0   6  staging: wfx: show counters of all interfaces
> git bisect  bad 832cc98141b4b93acbb9231ca9e36f7fbe347f47  # 08:35  B      0    17   33   0  staging: wfx: fix double free
> git bisect good faeea64fb9748002ed2aecff6e5caa01cc829735  # 08:39  G     10     0    0   9  staging: qlge: Remove goto statements from ql_get_mac_addr_reg
> git bisect good 986da7debb04225221d8876b405c4088614ae5f4  # 08:39  G     11     0    0   4  staging: vt6656: Return on isr0 when zero.
> git bisect good 3be1acffe684b11b9447cc7140ea0e59efa19a20  # 08:39  G     18     0    0   8  staging: vt6655: remove else after return and invert condition
> git bisect good 0729bb9b2a97a279c4b7c7be8565d494aab3d6e9  # 08:39  G     11     0    0   0  staging: vt6655: fix LONG_LINE warning
> git bisect  bad ae73e7784871ebe2c43da619b4a1e2c9ff81508d  # 08:39  B      0    23   39   0  Merge 5.7-rc5 into staging-next
> git bisect good 2e11cc1ab790ccbc7c7f6ed74c0f40b85c561dc7  # 08:39  G     11     0    0   4  staging: vt6656: Use const for read only data
> git bisect good b9388959ba507c7a48ac18e4aa3b63b8a910ed99  # 08:39  G     10     0    0   2  Merge tag 'tag-chrome-platform-fixes-for-v5.7-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
> git bisect good 9ecc4d775f61fb3fd26a1b8cc70a56a98b3b40d3  # 08:39  G     11     0    0   4  Merge tag 'linux-kselftest-5.7-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
> git bisect  bad c61529f6f59c9e136432cde96f9a053a51ad2a1e  # 08:39  B      0    21   37   0  Merge tag 'driver-core-5.7-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect  bad af38553c661207f96464e15f3506bf788daee474  # 08:39  B      0    11   27   0  Merge branch 'akpm' (patches from Andrew)
> git bisect  bad 8d58f222e85f01da0c0e1fc1e77986c86de889e2  # 10:31  B      0    11   37  10  ubsan: disable UBSAN_ALIGNMENT under COMPILE_TEST
> git bisect good 0c54a6a44bf3d41e76ce3f583a6ece267618df2e  # 12:35  G     11     0    1   1  eventpoll: fix missing wakeup for ovflist in ep_poll_callback
> git bisect  bad 28307d938fb2e4056ed4c982c06d1503d7719813  # 12:51  B      0    10   26   0  percpu: make pcpu_alloc() aware of current gfp context
> git bisect good cbfc35a48609ceac978791e3ab9dde0c01f8cb20  # 13:58  G     10     0    2   2  mm/slub: fix incorrect interpretation of s->offset
> # first bad commit: [28307d938fb2e4056ed4c982c06d1503d7719813] percpu: make pcpu_alloc() aware of current gfp context
> git bisect good cbfc35a48609ceac978791e3ab9dde0c01f8cb20  # 14:10  G     30     0    2   6  mm/slub: fix incorrect interpretation of s->offset
> # extra tests with debug options
> # extra tests on head commit of linus/master
> # 119: [75caf310d16cc5e2f851c048cd597f5437013368] Merge branch 'akpm' (patches from Andrew)
> # extra tests on revert first bad commit
> # 119: [9ae36539355c14fa1681e66744db5fc4e4066013] Revert "percpu: make pcpu_alloc() aware of current gfp context"
> # extra tests on linus/master
> # duplicated: [75caf310d16cc5e2f851c048cd597f5437013368] Merge branch 'akpm' (patches from Andrew)
> # extra tests on linux-next/master
> # 119: [ff387fc20c697cdc887b2abf7ef494e853795a2f] Add linux-next specific files for 20200528

Weird, what you are getting is the following warning from lock torture:

[  230.933509] rcu_torture_fwd_prog_nr: Duration 23169 cver 147 gps 517
[  232.781662] wait for background processes: 2359 2446 2428 kmemleak
oom-killer meminfo
[  232.781828]
[  236.852893] /lkp/lkp/src/monitors/kmemleak: line 19:
/sys/kernel/debug/kmemleak: Permission denied
[  236.853034]
[  237.383893] cat: /sys/kernel/debug/kmemleak: No such file or directory
[  237.384049]
[  237.460489] /lkp/lkp/src/monitors/kmemleak: line 21:
/sys/kernel/debug/kmemleak: Permission denied
[  237.460644]
[  242.783491] ------------[ cut here ]------------
[  242.784038] WARNING: CPU: 0 PID: 259 at kernel/rcu/rcutorture.c:1939
rcu_torture_fwd_prog+0xb8b/0xc90
[  242.785139] Modules linked in: intel_rapl_common aesni_intel
input_leds qemu_fw_cfg ata_piix evbug libata scsi_mod ip_tables x_tables
[  242.786347] CPU: 0 PID: 259 Comm: rcu_torture_fwd Not tainted
5.7.0-rc4-00167-gcbfc35a48609c #2
[  242.787190] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  242.788001] RIP: 0010:rcu_torture_fwd_prog+0xb8b/0xc90
[  242.788516] Code: ff 05 89 9c eb 03 e9 87 fe ff ff 48 ff 05 5d 9b eb
03 e9 37 f5 ff ff 48 ff 05 e9 9c eb 03 e9 8d f8 ff ff 48 ff 05 9d 9b eb
03 <0f> 0b 31 c9 31 d2 89 c6 48 c7 c7 e8 af f0 84 e8 61 62 13 00 48 c7
[  242.790275] RSP: 0018:ffff8881a1ca7dd8 EFLAGS: 00010203
[  242.790806] RAX: 0000000000000001 RBX: 00000000ffffbe54 RCX:
ffffffff81390d54
[  242.791503] RDX: dffffc0000000000 RSI: 0000000000000001 RDI:
ffffffff84f0b038
[  242.792197] RBP: ffff8881a1ca7f08 R08: ffffed103e99b901 R09:
ffffed103e99b901
[  242.792887] R10: 0000000000000001 R11: ffff8881f4cdc807 R12:
0000000000000021
[  242.793622] R13: ffff8881a1c38000 R14: ffff8881f2eb2a60 R15:
000000000000039e
[  242.794315] FS:  0000000000000000(0000) GS:ffff8881f6e00000(0000)
knlGS:0000000000000000
[  242.795095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  242.795672] CR2: 00007f7322dbdfd3 CR3: 00000001842ac000 CR4:
00000000000406f0
[  242.796365] Call Trace:
[  242.796685]  ? lock_downgrade+0x3a0/0x3a0
[  242.797253]  ? rcu_torture_barrier_cbs+0x2c0/0x2c0
[  242.797750]  ? preempt_count_sub+0x1b5/0x290
[  242.798225]  ? ftrace_likely_update+0x40/0xb0
[  242.798688]  ? __kthread_parkme+0x197/0x1b0
[  242.799163]  ? rcu_torture_barrier_cbs+0x2c0/0x2c0
[  242.799666]  kthread+0x286/0x2a0
[  242.800029]  ? kzalloc+0x10/0x10
[  242.800535]  ret_from_fork+0x24/0x30
[  242.801100] irq event stamp: 5914
[  242.801459] hardirqs last  enabled at (5913): [<ffffffff829572cc>]
_raw_spin_unlock_irqrestore+0x9c/0xa0
[  242.802368] hardirqs last disabled at (5914): [<ffffffff8100552f>]
trace_hardirqs_off_thunk+0x1a/0x1c
[  242.803256] softirqs last  enabled at (5346): [<ffffffff82c00745>]
__do_softirq+0x745/0x9a3
[  242.804066] softirqs last disabled at (5339): [<ffffffff8114aab6>]
irq_exit+0x166/0x190
[  242.804840] ---[ end trace 1b06f72ec0ecb2c1 ]---
[  247.844430] /lkp/lkp/src/monitors/kmemleak: line 19:
/sys/kernel/debug/kmemleak: Permission denied
[  247.844578]
[  248.305602] cat: /sys/kernel/debug/kmemleak: No such file or directory

I just tried a 5.7-rc7 kernel with lock torture enabled as in your config:

CONFIG_LOCK_TORTURE_TEST=m
CONFIG_TORTURE_TEST=y
CONFIG_RCU_TORTURE_TEST=y

And I didn't get any warnings or problems, I was able to boot and use
the vm.

I'm not familiar with lock torture internals, and I can't see why it
failed for you.

Are you able to boot on a 5.7-rc7?

Thanks.

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org
> 

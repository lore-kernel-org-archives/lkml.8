Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DC3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B561207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgE0FMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:12:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:53072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgE0FMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:12:52 -0400
IronPort-SDR: fqFF8+WQXDA5qrx+IMqrsi9grzd4i6xueuMSn4Aw9jMTIPA1H1xo3CYEFW/QZvLsGxljt2LUZj
 0yz7k74TrbFQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 22:12:24 -0700
IronPort-SDR: l6qMOQwT2KRr8RwlKB88+aZhjUpMdk7pE5+Iw4nXtqrQPq0WDLYyX7dh1RZEynv2beD5/Srg5R
 aPUEb/OQvuNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="xz'?gz'50?scan'50,208,50";a="468578416"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 26 May 2020 22:12:22 -0700
Date:   Wed, 27 May 2020 13:11:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        LKP <lkp@lists.01.org>
Subject: 3ba75830ce ("nfsd4: drc containerization"): [   51.013875] WARNING:
 possible circular locking dependency detected
Message-ID: <20200527051159.GR12456@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="N1feavoG/SlNLCrA"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N1feavoG/SlNLCrA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 3ba75830ce175550ef45c6524ec62faab8f62c1b
Author:     J. Bruce Fields <bfields@redhat.com>
AuthorDate: Fri May 17 09:03:38 2019 -0400
Commit:     J. Bruce Fields <bfields@redhat.com>
CommitDate: Wed Jul 3 17:52:08 2019 -0400

    nfsd4: drc containerization
    
    The nfsd duplicate reply cache should not be shared between network
    namespaces.
    
    The most straightforward way to fix this is just to move every global in
    the code to per-net-namespace memory, so that's what we do.
    
    Still todo: sort out which members of nfsd_stats should be global and
    which per-net-namespace.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

b401170f6d  nfsd: don't call nfsd_reply_cache_shutdown twice
3ba75830ce  nfsd4: drc containerization
444fc5cde6  Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
+----------------------------------------------------------------+------------+------------+------------+
|                                                                | b401170f6d | 3ba75830ce | 444fc5cde6 |
+----------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                 | 72         | 12         | 10         |
| boot_failures                                                  | 3          | 13         | 9          |
| BUG:kernel_hang_in_boot_stage                                  | 3          | 1          |            |
| WARNING:possible_circular_locking_dependency_detected          | 0          | 11         | 9          |
| BUG:kernel_hang_in_test_stage                                  | 0          | 1          |            |
| WARNING:stack_going_in_the_wrong_direction?ip=path_lookupat/0x | 0          | 1          |            |
+----------------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[   45.163710] Unable to find swap-space signature
[   45.375718] trinity-c1 (855): attempted to duplicate a private mapping with mremap.  This is not supported.
[   46.055744] futex_wake_op: trinity-c1 tries to shift op by -209; fix this program
[   51.011723] 
[   51.013378] ======================================================
[   51.013875] WARNING: possible circular locking dependency detected
[   51.014378] 5.2.0-rc2 #1 Not tainted
[   51.014672] ------------------------------------------------------
[   51.015182] trinity-c2/886 is trying to acquire lock:
[   51.015593] 000000005405f099 (slab_mutex){+.+.}, at: slab_attr_store+0xa2/0x130
[   51.016190] 
[   51.016190] but task is already holding lock:
[   51.016652] 00000000ac662005 (kn->count#43){++++}, at: kernfs_fop_write+0x286/0x500
[   51.017266] 
[   51.017266] which lock already depends on the new lock.
[   51.017266] 
[   51.017909] 
[   51.017909] the existing dependency chain (in reverse order) is:
[   51.018497] 
[   51.018497] -> #1 (kn->count#43){++++}:
[   51.018956]        __lock_acquire+0x7cf/0x1a20
[   51.019317]        lock_acquire+0x17d/0x390
[   51.019658]        __kernfs_remove+0x892/0xae0
[   51.020020]        kernfs_remove_by_name_ns+0x78/0x110
[   51.020435]        sysfs_remove_link+0x55/0xb0
[   51.020832]        sysfs_slab_add+0xc1/0x3e0
[   51.021332]        __kmem_cache_create+0x155/0x200
[   51.021720]        create_cache+0xf5/0x320
[   51.022054]        kmem_cache_create_usercopy+0x179/0x320
[   51.022486]        kmem_cache_create+0x1a/0x30
[   51.022867]        nfsd_reply_cache_init+0x278/0x560
[   51.023266]        nfsd_init_net+0x20f/0x5e0
[   51.023623]        ops_init+0xcb/0x4b0
[   51.023928]        setup_net+0x2fe/0x670
[   51.024315]        copy_net_ns+0x30a/0x3f0
[   51.024653]        create_new_namespaces+0x3c5/0x820
[   51.025257]        unshare_nsproxy_namespaces+0xd1/0x240
[   51.025881]        ksys_unshare+0x506/0x9c0
[   51.026381]        __x64_sys_unshare+0x3a/0x50
[   51.026937]        do_syscall_64+0x110/0x10b0
[   51.027509]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   51.028175] 
[   51.028175] -> #0 (slab_mutex){+.+.}:
[   51.028817]        validate_chain+0x1c51/0x2cc0
[   51.029422]        __lock_acquire+0x7cf/0x1a20
[   51.029947]        lock_acquire+0x17d/0x390
[   51.030438]        __mutex_lock+0x100/0xfa0
[   51.030995]        mutex_lock_nested+0x27/0x30
[   51.031516]        slab_attr_store+0xa2/0x130
[   51.032020]        sysfs_kf_write+0x11d/0x180
[   51.032529]        kernfs_fop_write+0x32a/0x500
[   51.033056]        do_loop_readv_writev+0x21d/0x310
[   51.033627]        do_iter_write+0x2e5/0x380
[   51.034148]        vfs_writev+0x170/0x310
[   51.034616]        do_pwritev+0x13e/0x160
[   51.035100]        __x64_sys_pwritev+0xa3/0x110
[   51.035633]        do_syscall_64+0x110/0x10b0
[   51.036200]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   51.036924] 
[   51.036924] other info that might help us debug this:
[   51.036924] 
[   51.037876]  Possible unsafe locking scenario:
[   51.037876] 
[   51.038556]        CPU0                    CPU1
[   51.039130]        ----                    ----
[   51.039676]   lock(kn->count#43);
[   51.040084]                                lock(slab_mutex);
[   51.040597]                                lock(kn->count#43);
[   51.041062]   lock(slab_mutex);
[   51.041320] 
[   51.041320]  *** DEADLOCK ***
[   51.041320] 
[   51.041793] 3 locks held by trinity-c2/886:
[   51.042128]  #0: 000000001f55e152 (sb_writers#5){.+.+}, at: vfs_writev+0x2b9/0x310
[   51.042739]  #1: 00000000c7d6c034 (&of->mutex){+.+.}, at: kernfs_fop_write+0x25b/0x500
[   51.043400]  #2: 00000000ac662005 (kn->count#43){++++}, at: kernfs_fop_write+0x286/0x500
[   51.044044] 
[   51.044044] stack backtrace:
[   51.044398] CPU: 0 PID: 886 Comm: trinity-c2 Not tainted 5.2.0-rc2 #1
[   51.044911] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   51.045569] Call Trace:
[   51.045807]  dump_stack+0x28/0x3d
[   51.046089]  print_circular_bug+0x455/0x730
[   51.046432]  check_prev_add+0x22db/0x4470
[   51.046764]  ? is_bpf_text_address+0xc2/0x1c0
[   51.047136]  ? check_irq_usage+0xbb0/0xbb0
[   51.047475]  ? reacquire_held_locks+0x5b0/0x5b0
[   51.047850]  ? kernfs_fop_write+0x1e2/0x500
[   51.048195]  ? validate_chain+0x1c51/0x2cc0
[   51.048591]  validate_chain+0x1c51/0x2cc0
[   51.048980]  ? check_prev_add+0x4470/0x4470
[   51.049324]  ? stack_trace_snprint+0x150/0x150
[   51.049690]  __lock_acquire+0x7cf/0x1a20
[   51.050018]  lock_acquire+0x17d/0x390
[   51.050322]  ? slab_attr_store+0xa2/0x130
[   51.050656]  __mutex_lock+0x100/0xfa0
[   51.050970]  ? slab_attr_store+0xa2/0x130
[   51.051299]  ? slab_attr_store+0xa2/0x130
[   51.051632]  ? __mutex_add_waiter+0x150/0x150
[   51.051987]  ? lock_acquire+0x17d/0x390
[   51.052302]  ? kernfs_fop_write+0x286/0x500
[   51.052650]  ? mutex_lock_nested+0x27/0x30
[   51.052987]  mutex_lock_nested+0x27/0x30
[   51.053311]  slab_attr_store+0xa2/0x130
[   51.053637]  ? print_tracking+0xb0/0xb0
[   51.053953]  sysfs_kf_write+0x11d/0x180
[   51.054274]  ? sysfs_file_ops+0x1f0/0x1f0
[   51.054608]  kernfs_fop_write+0x32a/0x500
[   51.054967]  do_loop_readv_writev+0x21d/0x310
[   51.055331]  ? rw_verify_area+0x11b/0x340
[   51.055663]  do_iter_write+0x2e5/0x380
[   51.055976]  vfs_writev+0x170/0x310
[   51.056267]  ? __x32_compat_sys_writev+0xc0/0xc0
[   51.056654]  ? tracer_preempt_on+0x15/0x2b0
[   51.056996]  ? check_prev_add+0x4470/0x4470
[   51.057339]  ? trace_preempt_on+0x69/0x240
[   51.057679]  ? preempt_count_sub+0x186/0x280
[   51.058031]  ? __task_pid_nr_ns+0x26f/0x560
[   51.058374]  ? find_held_lock+0x3a/0x210
[   51.058697]  ? perf_syscall_enter+0xd1/0x640
[   51.059069]  ? __task_pid_nr_ns+0x26f/0x560
[   51.059414]  ? perf_call_bpf_enter+0x1b0/0x1b0
[   51.059829]  ? do_pwritev+0x13e/0x160
[   51.060130]  do_pwritev+0x13e/0x160
[   51.060424]  __x64_sys_pwritev+0xa3/0x110
[   51.060754]  ? rcu_read_lock_sched_held+0x197/0x1e0
[   51.061151]  do_syscall_64+0x110/0x10b0
[   51.061468]  ? perf_call_bpf_enter+0x1b0/0x1b0
[   51.061881]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[   51.062305]  ? syscall_return_slowpath+0x570/0x570
[   51.062700]  ? trace_hardirqs_off_caller+0x43/0x290
[   51.063148]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   51.063535]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   51.063965] RIP: 0033:0x457729
[   51.064254] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b 84 00 00 c3 66 2e 0f 1f 84 00 00 00 00
[   51.065721] RSP: 002b:00007ffc65002668 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
[   51.066325] RAX: ffffffffffffffda RBX: 0000000000000128 RCX: 0000000000457729
[   51.066904] RDX: 0000000000000001 RSI: 00000000012be5a0 RDI: 000000000000010d
[   51.067478] RBP: 00007ffc65002710 R08: 0000000062626262 R09: 0000000000000016
[   51.068172] R10: 00000000c9c9c9c9 R11: 0000000000000246 R12: 0000000000000002
[   51.068789] R13: 00007fa1d2d6d058 R14: 0000000001057830 R15: 00007fa1d2d6d000
[   53.943382] scsi_nl_rcv_msg: discarding partial skb
[main] 10244 iterations. [F:7172 S:3031 HI:3142]
[main] 10229 iterations. [F:7108 S:3063 HI:2080]

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v5.3 v5.2 --
git bisect  bad 5168afe6ef596eaf2ff7a533b780c79ce14445e4  # 02:17  B      0     1   17   0  Merge tag 'for-linus-20190726-2' of git://git.kernel.dk/linux-block
git bisect  bad 1fa91854dcdf7829e2694873b19f96b65947112d  # 02:39  B      2     2    0   1  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
git bisect good 9d22167f34305280c5dd57a74c21651da3c23015  # 03:03  G     24     0    0   0  Merge branch 'next-lsm' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect  bad 4832a4dada1a2baefac76b70e4f3a78e71a7c35c  # 03:25  B      1     3    0   0  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
git bisect  bad 29cd581b59496c26334c910a8b848baa81a6becd  # 04:23  B      3     3    0   0  Merge tag 'm68k-for-v5.3-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
git bisect good a47f5c56b2eb55290e2a8668e9ca9c029990dbf6  # 05:07  G     24     0    0   0  Merge tag 'iomap-5.3-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect good 2e756758e5cb4ea29cba5865d00fad476ce94a93  # 06:05  G     23     0    0   0  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect  bad d2b6b4c832f7e3067709e8d4970b7b82b44419ac  # 06:46  B      1     2    0   0  Merge tag 'nfsd-5.3' of git://linux-nfs.org/~bfields/linux
git bisect good 0248a8be6d21dad72b9ce80a7565cf13c11509d8  # 07:19  G     25     0    0   0  Merge tag 'gfs2-for-5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect  bad 59f8e91b75ecf16f22d62eca0659c13901eff5f3  # 08:26  B      2     3    0   0  nfsd4: use reference count to free client
git bisect  bad f85d93385e9fe6886a751f647f6812a89bf6bee3  # 08:39  B      5     7    0   0  locks: Cleanup lm_compare_owner and lm_owner_key
git bisect  bad 9de3ec1d57113e270638254868675d9c048b071e  # 09:34  B      4     3    0   0  lockd: prepare nlm_lockowner for use by the server
git bisect  bad 3ba75830ce175550ef45c6524ec62faab8f62c1b  # 09:54  B      4     4    0   0  nfsd4: drc containerization
git bisect good b401170f6d9cd4270e0159d9b016f4ccb06caa85  # 10:37  G     23     0    0   0  nfsd: don't call nfsd_reply_cache_shutdown twice
# first bad commit: [3ba75830ce175550ef45c6524ec62faab8f62c1b] nfsd4: drc containerization
git bisect good b401170f6d9cd4270e0159d9b016f4ccb06caa85  # 10:45  G     70     0    1   1  nfsd: don't call nfsd_reply_cache_shutdown twice
# extra tests with debug options
git bisect  bad 3ba75830ce175550ef45c6524ec62faab8f62c1b  # 11:00  B      0     2   18   0  nfsd4: drc containerization
# extra tests on head commit of linus/master
git bisect  bad 444fc5cde64330661bf59944c43844e7d4c2ccd8  # 11:44  B      9     8    0   0  Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
# bad: [444fc5cde64330661bf59944c43844e7d4c2ccd8] Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
# extra tests on linus/master
# duplicated: [444fc5cde64330661bf59944c43844e7d4c2ccd8] Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
# extra tests on linux-next/master
# 119: [b0523c7b1c9d0edcd6c0fe6d2cb558a9ad5c60a8] Add linux-next specific files for 20200526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--N1feavoG/SlNLCrA
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-30:20200527095208:x86_64-randconfig-a001-20200521:5.2.0-rc2:1.gz"
Content-Transfer-Encoding: base64

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

--N1feavoG/SlNLCrA
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-23:20200527105003:x86_64-randconfig-a001-20200521:5.2.0-rc2-00004-gb401170f6d9cd4:1.gz"
Content-Transfer-Encoding: base64

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
7q+f//VKdHJOE/Rb/unuNf3c/jf+T0LoimgAAA==

--N1feavoG/SlNLCrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vm-yocto-30:20200527095208:x86_64-randconfig-a001-20200521:5.2.0-rc2:1"

#!/bin/bash

kernel=$1
initrd=yocto-x86_64-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd

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

--N1feavoG/SlNLCrA
Content-Type: application/x-xz
Content-Disposition: attachment; filename="7e03f161c41d2edff4b4895f4923ea0d514b203b:gcc-7:x86_64-randconfig-a001-20200521:WARNING:possible_circular_locking_dependency_detected.xz"
Content-Transfer-Encoding: base64

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
WVo=

--N1feavoG/SlNLCrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.2.0-rc2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.2.0-rc2 Kernel Configuration
#

#
# Compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
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
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
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
CONFIG_ARCH_CLOCKSOURCE_DATA=y
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
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
# CONFIG_RCU_NOCB_CPU is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS_PROC is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
# CONFIG_MEMCG_SWAP_ENABLED is not set
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_IPC_NS is not set
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
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
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
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
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=y
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
CONFIG_PMIC_OPREGION=y
# CONFIG_CRC_PMIC_OPREGION is not set
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=y
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
CONFIG_KVM_INTEL=y
CONFIG_KVM_AMD=y
# CONFIG_KVM_MMU_AUDIT is not set
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
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
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_ARCH_HAS_HMM_MIRROR=y
CONFIG_ARCH_HAS_HMM_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_INTERFACE=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
CONFIG_INET_DIAG_DESTROY=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_ESP_OFFLOAD=y
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
# CONFIG_IPV6_PIMSM_V2 is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
CONFIG_NETFILTER_NETLINK_LOG=y
# CONFIG_NETFILTER_NETLINK_OSF is not set
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
CONFIG_NF_CONNTRACK_FTP=m
# CONFIG_NF_CONNTRACK_H323 is not set
CONFIG_NF_CONNTRACK_IRC=m
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=m
# CONFIG_NF_CONNTRACK_TFTP is not set
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
# CONFIG_NFT_CT is not set
CONFIG_NFT_FLOW_OFFLOAD=m
# CONFIG_NFT_COUNTER is not set
# CONFIG_NFT_CONNLIMIT is not set
# CONFIG_NFT_LOG is not set
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
# CONFIG_NFT_COMPAT is not set
# CONFIG_NFT_HASH is not set
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
# CONFIG_NETFILTER_XT_CONNMARK is not set
# CONFIG_NETFILTER_XT_SET is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
# CONFIG_NETFILTER_XT_TARGET_CT is not set
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_NAT=m
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=y
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_HL is not set
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
CONFIG_NETFILTER_XT_MATCH_L2TP=y
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
CONFIG_NETFILTER_XT_MATCH_POLICY=y
# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
CONFIG_NETFILTER_XT_MATCH_SCTP=y
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
# CONFIG_IP_SET_BITMAP_IP is not set
# CONFIG_IP_SET_BITMAP_IPMAC is not set
CONFIG_IP_SET_BITMAP_PORT=y
# CONFIG_IP_SET_HASH_IP is not set
CONFIG_IP_SET_HASH_IPMARK=y
CONFIG_IP_SET_HASH_IPPORT=y
# CONFIG_IP_SET_HASH_IPPORTIP is not set
CONFIG_IP_SET_HASH_IPPORTNET=y
CONFIG_IP_SET_HASH_IPMAC=y
# CONFIG_IP_SET_HASH_MAC is not set
CONFIG_IP_SET_HASH_NETPORTNET=y
CONFIG_IP_SET_HASH_NET=y
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=y
CONFIG_IP_SET_HASH_NETIFACE=y
CONFIG_IP_SET_LIST_SET=y
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=y
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_FLOW_TABLE_IPV4=m
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_RPFILTER is not set
# CONFIG_IP_NF_MATCH_TTL is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_SYNPROXY is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_SECURITY is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=y
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_FLOW_TABLE_IPV6=m
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=m
# CONFIG_IP6_NF_MATCH_AH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_HL is not set
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
# CONFIG_IP6_NF_MATCH_MH is not set
# CONFIG_IP6_NF_MATCH_RPFILTER is not set
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_FILTER=m
# CONFIG_IP6_NF_TARGET_REJECT is not set
# CONFIG_IP6_NF_TARGET_SYNPROXY is not set
# CONFIG_IP6_NF_MANGLE is not set
CONFIG_IP6_NF_RAW=m
# CONFIG_IP6_NF_SECURITY is not set
CONFIG_IP6_NF_NAT=m
# CONFIG_IP6_NF_TARGET_MASQUERADE is not set
# CONFIG_IP6_NF_TARGET_NPT is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set
# end of DECnet: Netfilter Configuration

# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=y
# CONFIG_BRIDGE_EBT_BROUTE is not set
# CONFIG_BRIDGE_EBT_T_FILTER is not set
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_BRIDGE_EBT_802_3=y
# CONFIG_BRIDGE_EBT_AMONG is not set
# CONFIG_BRIDGE_EBT_ARP is not set
# CONFIG_BRIDGE_EBT_IP is not set
CONFIG_BRIDGE_EBT_IP6=y
CONFIG_BRIDGE_EBT_LIMIT=y
CONFIG_BRIDGE_EBT_MARK=y
CONFIG_BRIDGE_EBT_PKTTYPE=y
CONFIG_BRIDGE_EBT_STP=y
CONFIG_BRIDGE_EBT_VLAN=y
CONFIG_BRIDGE_EBT_ARPREPLY=y
# CONFIG_BRIDGE_EBT_DNAT is not set
CONFIG_BRIDGE_EBT_MARK_T=y
CONFIG_BRIDGE_EBT_REDIRECT=y
CONFIG_BRIDGE_EBT_SNAT=y
CONFIG_BRIDGE_EBT_LOG=y
CONFIG_BRIDGE_EBT_NFLOG=y
CONFIG_BPFILTER=y
# CONFIG_BPFILTER_UMH is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=y

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=y
CONFIG_L2TP_ETH=y
CONFIG_STP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=y
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=y
CONFIG_6LOWPAN_DEBUGFS=y
CONFIG_6LOWPAN_NHC=y
# CONFIG_6LOWPAN_NHC_DEST is not set
# CONFIG_6LOWPAN_NHC_FRAGMENT is not set
# CONFIG_6LOWPAN_NHC_HOP is not set
CONFIG_6LOWPAN_NHC_IPV6=y
CONFIG_6LOWPAN_NHC_MOBILITY=y
CONFIG_6LOWPAN_NHC_ROUTING=y
CONFIG_6LOWPAN_NHC_UDP=y
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=y
CONFIG_6LOWPAN_GHC_UDP=y
CONFIG_6LOWPAN_GHC_ICMPV6=y
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=y
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=y
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=m
# CONFIG_NET_SCH_MULTIQ is not set
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=y
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
# CONFIG_CAN_BCM is not set
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
# CONFIG_CAN_C_CAN is not set
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
CONFIG_CAN_SOFTING=m
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_IPV6=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
# CONFIG_FAILOVER is not set
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

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# end of Cadence PCIe controllers support

# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support
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

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# end of Bus devices

CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
CONFIG_GNSS_SIRF_SERIAL=y
# CONFIG_GNSS_UBX_SERIAL is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=y
CONFIG_NFTL=y
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=y
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_RAW_NAND=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_DENALI_DT=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
# CONFIG_MTD_UBI is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_DRBD=y
CONFIG_DRBD_FAULT_INJECTION=y
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
CONFIG_ATA_OVER_ETH=y
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=y

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_VOP=y
CONFIG_VHOST_RING=y
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=y
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_SCSI_BNX2X_FCOE is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=y
CONFIG_SCSI_UFS_CDNS_PLATFORM=y
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=y
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=y
CONFIG_LIBFC=y
CONFIG_LIBFCOE=y
# CONFIG_FCOE is not set
# CONFIG_FCOE_FNIC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_ATA_ACPI is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_CEVA=y
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BCACHE=y
CONFIG_BCACHE_DEBUG=y
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BLK_DEV_DM is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_TCM_FC=y
CONFIG_ISCSI_TARGET=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
# CONFIG_GTP is not set
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
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
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
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
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
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
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
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
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
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
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
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
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
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
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
# CONFIG_TOUCHSCREEN_DA9052 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_UCB1400=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM97XX=y
# CONFIG_TOUCHSCREEN_WM9705 is not set
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=y
CONFIG_TOUCHSCREEN_STMPE=y
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_ARIZONA_HAPTICS=y
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MAX77650_ONKEY is not set
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_PWRBUTTON=y
CONFIG_INPUT_TWL4030_VIBRA=y
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF50633_PMU=y
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=y
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA9052_ONKEY=y
# CONFIG_INPUT_DA9055_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=y
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_DRV260X_HAPTICS=y
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_HYPERV_KEYBOARD is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=y
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
CONFIG_SERIAL_SIFIVE_CONSOLE=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=y
# end of Serial drivers

CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_NVRAM is not set
# CONFIG_APPLICOM is not set
CONFIG_MWAVE=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

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
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_RK3X=y
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_FSI=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
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
CONFIG_HSI_CHAR=y
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MADERA is not set
# CONFIG_GPIO_MAX77650 is not set
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TC3589X is not set
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_UCB1400=y
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_MAX8925_POWER=y
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
# CONFIG_BATTERY_WM97XX is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
# CONFIG_BATTERY_TWL4030_MADC is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_BATTERY_RX51=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77650 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_UCS1002=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
CONFIG_UCB1400_CORE=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_AB3100 is not set
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8925=y
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8998 is not set
# CONFIG_REGULATOR_MAX77686 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS80031=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_RCMM_DECODER=m
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
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
CONFIG_IR_PWM_TX=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
CONFIG_VIDEO_CADENCE=y
# CONFIG_VIDEO_ASPEED is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
CONFIG_VIDEO_SH_VEU=y
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIVID is not set
CONFIG_VIDEO_VIM2M=y
CONFIG_VIDEO_VICODEC=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_CEC_PLATFORM_DRIVERS=y
# CONFIG_CEC_GPIO is not set
# CONFIG_VIDEO_SECO_CEC is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_RCAR_LVDS=y
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_CDNS_DSI=y
# CONFIG_DRM_DUMB_VGA_DAC is not set
# CONFIG_DRM_LVDS_ENCODER is not set
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358764=y
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_I2C_ADV7511=y
CONFIG_DRM_I2C_ADV7511_AUDIO=y
CONFIG_DRM_I2C_ADV7533=y
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_DW_HDMI=y
# CONFIG_DRM_DW_HDMI_AHB_AUDIO is not set
CONFIG_DRM_DW_HDMI_I2S_AUDIO=y
CONFIG_DRM_DW_HDMI_CEC=y
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=y
CONFIG_FB_VESA=y
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
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
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=2048
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=y
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=y
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_ATMEL_SOC=y
# CONFIG_SND_SOC_MIKROE_PROTO is not set
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
# CONFIG_SND_SOC_FSL_SPDIF is not set
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
CONFIG_SND_SOC_IMG_I2S_OUT=y
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=y
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
# CONFIG_SND_SOC_INTEL_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SOF_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_PCI is not set
CONFIG_SND_SOC_SOF_ACPI=y
CONFIG_SND_SOC_SOF_OPTIONS=y
# CONFIG_SND_SOC_SOF_NOCODEC is not set
# CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS is not set
# CONFIG_SND_SOC_SOF_DEBUG is not set
CONFIG_SND_SOC_SOF=y
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_ACPI=y
# CONFIG_SND_SOC_SOF_BAYTRAIL_SUPPORT is not set
# CONFIG_SND_SOC_SOF_BROADWELL_SUPPORT is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_ZX_TDM=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_AK4118=y
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=y
# CONFIG_SND_SOC_CS35L35 is not set
CONFIG_SND_SOC_CS35L36=y
CONFIG_SND_SOC_CS42L42=y
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
# CONFIG_SND_SOC_CS43130 is not set
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DA7219=y
# CONFIG_SND_SOC_DMIC is not set
CONFIG_SND_SOC_HDMI_CODEC=y
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
# CONFIG_SND_SOC_GTM601 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
# CONFIG_SND_SOC_MAX9860 is not set
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM512x_I2C is not set
CONFIG_SND_SOC_RK3328=y
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RT5616=y
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS5086=y
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=y
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=y
CONFIG_SND_SOC_WCD9335=y
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_NAU8540 is not set
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_TPA6130A2=y
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_X86 is not set
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_HYPERV_MOUSE is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
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
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AN30259A=y
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_MAX77693=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX77686=y
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_TWL4030 is not set
# CONFIG_RTC_DRV_TPS80031 is not set
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_AB3100=y
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_R7301=y

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=y
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=y
CONFIG_CHARLCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=y
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

CONFIG_STAGING=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
# CONFIG_COMEDI_PCL818 is not set
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=y
CONFIG_COMEDI_DT2814=y
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
# CONFIG_COMEDI_AIO_IIRO_16 is not set
# CONFIG_COMEDI_II_PCI20KC is not set
CONFIG_COMEDI_C6XDIGIO=y
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
# CONFIG_COMEDI_NI_ATMIO is not set
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
# CONFIG_COMEDI_S526 is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_I2C=y
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
# CONFIG_ADE7854_I2C is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# end of Speakup console speech

CONFIG_STAGING_MEDIA=y

#
# soc_camera sensor drivers
#

#
# Android
#
CONFIG_ASHMEM=y
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CARVEOUT_HEAP is not set
# CONFIG_ION_CHUNK_HEAP is not set
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
CONFIG_GS_FPGABOOT=y
# CONFIG_UNISYSSPAR is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
# CONFIG_MOST is not set
CONFIG_GREYBUS=y
CONFIG_GREYBUS_AUDIO=y
# CONFIG_GREYBUS_BOOTROM is not set
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=y
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=y
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
CONFIG_GREYBUS_I2C=y
CONFIG_GREYBUS_PWM=y
CONFIG_GREYBUS_UART=y

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
CONFIG_FIELDBUS_DEV=y
CONFIG_HMS_ANYBUSS_BUS=y
CONFIG_ARCX_ANYBUS_CONTROLLER=y
CONFIG_HMS_PROFINET=y
# CONFIG_KPC2000 is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WIRELESS=y
CONFIG_ACERHDF=y
CONFIG_ASUS_LAPTOP=y
CONFIG_DCDBAS=y
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=y
# CONFIG_DELL_SMO8800 is not set
CONFIG_DELL_RBTN=y
# CONFIG_DELL_RBU is not set
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=y
# CONFIG_AMILO_RFKILL is not set
CONFIG_GPD_POCKET_FAN=y
CONFIG_HP_ACCEL=y
CONFIG_HP_WIRELESS=y
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
CONFIG_SONY_LAPTOP=y
# CONFIG_SONYPI_COMPAT is not set
CONFIG_IDEAPAD_LAPTOP=y
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=y
# CONFIG_INTEL_MENLOW is not set
CONFIG_ASUS_WIRELESS=y
# CONFIG_ACPI_WMI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_VBTN=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_INTEL_OAKTRAIL=y
# CONFIG_APPLE_GMUX is not set
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_MLX_PLATFORM=y
CONFIG_TOUCHSCREEN_DMI=y
CONFIG_INTEL_CHTDC_TI_PWRBTN=y
CONFIG_I2C_MULTI_INSTANTIATE=y
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
# CONFIG_MLXREG_IO is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_FIXED_MMIO=y
# CONFIG_CLK_SIFIVE is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
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
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
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
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_ARIZONA=y
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_HID_SENSOR_ACCEL_3D is not set
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7291=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD799X is not set
# CONFIG_CC10001_ADC is not set
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=y
# CONFIG_NAU7802 is not set
CONFIG_SD_ADC_MODULATOR=y
CONFIG_STMPE_ADC=y
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TWL4030_MADC=y
CONFIG_TWL6030_GPADC=y
# CONFIG_VF610_ADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_PMS7003 is not set
CONFIG_SENSIRION_SGP30=y
# CONFIG_SPS30 is not set
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5380=y
CONFIG_AD5446=y
# CONFIG_AD5593R is not set
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=y
CONFIG_IIO_SIMPLE_DUMMY=y
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
# CONFIG_APDS9960 is not set
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
CONFIG_MAX44009=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
# CONFIG_MCP4018 is not set
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_CRC is not set
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_STMPE is not set
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_CADENCE_DP is not set
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_IDLE_INJECT=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# end of Android

CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
# CONFIG_ND_BLK is not set
CONFIG_ND_CLAIM=y
CONFIG_BTT=y
CONFIG_OF_PMEM=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_DEV_DAX_KMEM=y
CONFIG_NVMEM=y
# CONFIG_NVMEM_SYSFS is not set
CONFIG_RAVE_SP_EEPROM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_STM_SOURCE_FTRACE is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_SCOM=y
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=y
# CONFIG_OCFS2_FS_O2CB is not set
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=y
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
CONFIG_OCFS2_DEBUG_FS=y
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
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
# CONFIG_JFFS2_FS is not set
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
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
CONFIG_NFS_USE_LEGACY_DNS=y
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_V4 is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_CEPH_FS=y
CONFIG_CEPH_FSCACHE=y
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
CONFIG_CODA_FS=y
CONFIG_AFS_FS=y
# CONFIG_AFS_DEBUG is not set
# CONFIG_AFS_FSCACHE is not set
# CONFIG_AFS_DEBUG_CURSOR is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
CONFIG_DLM=y
# CONFIG_DLM_DEBUG is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_EVM is not set
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
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

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
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_CCREE=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_X509_CERTIFICATE_PARSER is not set
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
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
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=y
CONFIG_CLZ_TAB=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
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
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=1
# CONFIG_TEST_KASAN is not set
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_INSTRUMENT_ALL=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
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
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
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
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_CONNECTOR is not set
# CONFIG_SAMPLE_SECCOMP is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
CONFIG_SAMPLE_VFS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of Kernel hacking

--N1feavoG/SlNLCrA--

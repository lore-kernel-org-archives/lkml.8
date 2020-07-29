Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D72AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8585520672
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vfemail.net header.i=@vfemail.net header.b="Z/hRPECb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgG2Cmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:42:40 -0400
Received: from nl101-3.vfemail.net ([149.210.219.33]:12630 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbgG2Cmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=2018; bh=
        YhRUps5sIb02Nhe+B6k0SWnxo83bfXfOmgkrttQoDj8=; b=Z/hRPECbpHXgByu6
        KXhQTTF+FbChpyv5VuVUFszMI5IgYPoGf601iBx5sKC9Ws5SITUvPY3/0giDElUD
        9g/ST+yGkf3vGCQdyihjAjManiGMWBj4p0/75/FGxxD2kBx7NUG5ln3JbQTMFPLV
        7WYnr2ByK+rdPjDEcqHvcv9lXbE=
Received: (qmail 93180 invoked from network); 29 Jul 2020 02:35:41 -0000
Received: by simscan 1.4.0 ppid: 93122, pid: 93137, t: 3.1556s
         scanners:none
Received: from unknown (HELO d3d3MTkyLnZmZW1haWwubmV0) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 29 Jul 2020 02:35:38 -0000
Date:   Tue, 28 Jul 2020 22:34:50 -0400
From:   David Niklas <Hgntkwis@vfemail.net>
To:     reiserfs-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: PROBLEM: IO lockup on reiserfs FS.
Message-ID: <20200728223450.34509827@Phenom-II-x6.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/53xjX6hBXUYm/McFpUEy5VO"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/53xjX6hBXUYm/McFpUEy5VO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

When running rtorrent (in sync to file mode), my kernel eventually will
not write to the disk causing all access to md7 to hang and eventually the
kernel will become totally unresponsive.

EDIT: I have since gotten a response in the bug tracker and I am filing
thins to the reiserfs maintainers.

<strike> (I'd find the file and report to the
correct maintainer, but the docs are incomplete when it comes to
discovering the source of the hung tasks in my case. I have filed bugs to
correct this.) </strike>
I still have no clue how to get gdb to print out where exactly this is
happening. It can't find the __schedule function in the kernel or in the
reiserfs.ko object file. I'm not even sure __schedule is the problem as
it seems to be lock related which would point to __mutex_lock.isra.

EDIT: I've managed to verify that all disks are accessible (smartctl
-a /dev/sdX) and that the RAID array is working and accessible (mdadm
--detail and echo-ing check/idle to the array and seeing progress).

Keywords: Hung tasks, Lockup, reiserfs, RAID.

Linux version 4.14.184-nopreempt-AMDGPU-dav9 (root@Phenom-II-x6) (gcc
version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)) #1 SMP Fri Jun 19
17:02:34 UTC 2020

I didn't have Internet before 4.9.X so I can't say if any version of the
Linux kernel didn't have this problem.

[68812.480459]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9 #1
[68812.480464] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.480469] CacheThread_Blo D    0  9414   9082
0x00000080 [68812.480476] Call Trace:
[68812.480494]  __schedule+0x29e/0x6c0
[68812.480505]  schedule+0x32/0x80
[68812.480513]  schedule_preempt_disabled+0xa/0x10
[68812.480520]  __mutex_lock.isra.1+0x26b/0x4e0
[68812.480550]  ? do_journal_begin_r+0xbe/0x390 [reiserfs]
[68812.480570]  do_journal_begin_r+0xbe/0x390 [reiserfs]
[68812.480586]  ? __switch_to_asm+0x35/0x70
[68812.480588]  ? __switch_to_asm+0x41/0x70
[68812.480590]  ? __switch_to_asm+0x35/0x70
[68812.480592]  ? __switch_to_asm+0x41/0x70
[68812.480593]  ? __switch_to_asm+0x35/0x70
[68812.480595]  ? __switch_to_asm+0x41/0x70
[68812.480597]  ? __switch_to_asm+0x35/0x70
[68812.480601]  journal_begin+0x80/0x140 [reiserfs]
[68812.480606]  reiserfs_dirty_inode+0x3d/0xa0 [reiserfs]
[68812.480609]  ? __switch_to+0x1ee/0x3f0
[68812.480610]  ? __switch_to+0x1ee/0x3f0
[68812.480612]  __mark_inode_dirty+0x163/0x350
[68812.480615]  generic_update_time+0x79/0xc0
[68812.480617]  ? current_time+0x38/0x70
[68812.480619]  file_update_time+0xbe/0x110
[68812.480622]  __generic_file_write_iter+0x99/0x1b0
[68812.480624]  generic_file_write_iter+0xe2/0x1c0
[68812.480626]  __vfs_write+0x102/0x180
[68812.480628]  vfs_write+0xb0/0x190
[68812.480630]  SyS_pwrite64+0x90/0xb0
[68812.480632]  do_syscall_64+0x6e/0x110
[68812.480634]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[68812.480637] RIP: 0033:0x7f8a92976983
[68812.480638] RSP: 002b:00007f8a779e1630 EFLAGS: 00000293 ORIG_RAX:
0000000000000012 [68812.480640] RAX: ffffffffffffffda RBX:
00007f8a779e1640 RCX: 00007f8a92976983 [68812.480641] RDX:
0000000000000128 RSI: 000001790ddf3c00 RDI: 0000000000000040
[68812.480642] RBP: 00007f8a779e16f0 R08: 00007f8a779e1558 R09:
0000000000000001 [68812.480643] R10: 0000000000002000 R11:
0000000000000293 R12: 0000000000002000 [68812.480644] R13:
000001790a6b8dd0 R14: 000001790ddf3c00 R15: 0000000000000128
[68812.480647] INFO: task ThreadPoolSingl:9908 blocked for more than 480
seconds. [68812.480648]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.480649] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.480650] ThreadPoolSingl D    0  9908   9082
0x00000080 [68812.480651] Call Trace: [68812.480653]
__schedule+0x29e/0x6c0 [68812.480655]  schedule+0x32/0x80 [68812.480657]
schedule_preempt_disabled+0xa/0x10 [68812.480658]
__mutex_lock.isra.1+0x26b/0x4e0 [68812.480664]  ?
do_journal_begin_r+0xbe/0x390 [reiserfs] [68812.480668]
do_journal_begin_r+0xbe/0x390 [reiserfs] [68812.480672]  ?
reiserfs_lookup+0xb5/0x160 [reiserfs] [68812.480677]
journal_begin+0x80/0x140 [reiserfs] [68812.480681]
reiserfs_create+0xfc/0x210 [reiserfs] [68812.480685]
path_openat+0x1419/0x14d0 [68812.480687]  ? futex_wake+0x91/0x170
[68812.480689]  do_filp_open+0x99/0x110
[68812.480693]  ? __check_object_size+0xfa/0x1a0
[68812.480695]  ? __alloc_fd+0x3d/0x160
[68812.480696]  ? do_sys_open+0x12e/0x210
[68812.480698]  do_sys_open+0x12e/0x210
[68812.480700]  do_syscall_64+0x6e/0x110
[68812.480702]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[68812.480703] RIP: 0033:0x7f8a8c48770d
[68812.480704] RSP: 002b:00007f8a73eeb220 EFLAGS: 00000293 ORIG_RAX:
0000000000000002 [68812.480706] RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007f8a8c48770d [68812.480707] RDX:
0000000000000180 RSI: 00000000000000c2 RDI: 00000179286b1ae0
[68812.480708] RBP: 000000000003a2f8 R08: 000000000000c0c1 R09:
000001792b1b04e0 [68812.480709] R10: 0000000000000000 R11:
0000000000000293 R12: 00000179286b1b1a [68812.480710] R13:
8421084210842109 R14: 00000000000000c2 R15: 00007f8a8c515540
[68812.480713] INFO: task ThreadPoolForeg:24062 blocked for more than 480
seconds. [68812.480714]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.480715] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.480717] ThreadPoolForeg D    0 24062   9082
0x00000080 [68812.480718] Call Trace: [68812.480721]
__schedule+0x29e/0x6c0 [68812.480723]  ? __switch_to_asm+0x35/0x70
[68812.480724]  schedule+0x32/0x80 [68812.480726]
schedule_preempt_disabled+0xa/0x10 [68812.480727]
__mutex_lock.isra.1+0x26b/0x4e0 [68812.480729]  ?
__switch_to_asm+0x35/0x70 [68812.480734]  ? do_journal_begin_r+0xbe/0x390
[reiserfs] [68812.480739]  do_journal_begin_r+0xbe/0x390 [reiserfs]
[68812.480742]  ? __remove_hrtimer+0x35/0x70
[68812.480743]  ? hrtimer_try_to_cancel+0xbd/0x110
[68812.480748]  journal_begin+0x80/0x140 [reiserfs]
[68812.480752]  reiserfs_dirty_inode+0x3d/0xa0 [reiserfs]
[68812.480754]  ? get_futex_key+0x406/0x4b0
[68812.480756]  __mark_inode_dirty+0x163/0x350
[68812.480757]  generic_update_time+0x79/0xc0
[68812.480759]  ? current_time+0x38/0x70
[68812.480761]  file_update_time+0xbe/0x110
[68812.480763]  __generic_file_write_iter+0x99/0x1b0
[68812.480764]  generic_file_write_iter+0xe2/0x1c0
[68812.480766]  __vfs_write+0x102/0x180
[68812.480768]  vfs_write+0xb0/0x190
[68812.480769]  SyS_write+0x5a/0xd0
[68812.480771]  do_syscall_64+0x6e/0x110
[68812.480773]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[68812.480774] RIP: 0033:0x7f8a929761cd
[68812.480775] RSP: 002b:00007f8a6d2a4f30 EFLAGS: 00000293 ORIG_RAX:
0000000000000001 [68812.480777] RAX: ffffffffffffffda RBX:
00007f8a6d2a4f40 RCX: 00007f8a929761cd [68812.480778] RDX:
0000000000000007 RSI: 00007f8a6d2a52a8 RDI: 0000000000000155
[68812.480779] RBP: 00007f8a6d2a4fe0 R08: 0000000000000000 R09:
0000000000000001 [68812.480780] R10: 0000a89983efe451 R11:
0000000000000293 R12: 0000017919e27380 [68812.480781] R13:
00007f8a6d2a52a8 R14: 0000000000000007 R15: 0000000000000000
[68812.480790] INFO: task ThreadPoolForeg:26717 blocked for more than 480
seconds. [68812.480791]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.480792] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.480793] ThreadPoolForeg D    0 26717   9403
0x00000080 [68812.480794] Call Trace: [68812.480796]
__schedule+0x29e/0x6c0 [68812.480798]  schedule+0x32/0x80 [68812.480799]
schedule_preempt_disabled+0xa/0x10 [68812.480800]
__mutex_lock.isra.1+0x26b/0x4e0 [68812.480806]  ?
flush_commit_list+0x1fa/0x670 [reiserfs] [68812.480810]
flush_commit_list+0x1fa/0x670 [reiserfs] [68812.480815]
flush_commit_list+0x11f/0x670 [reiserfs] [68812.480820]
do_journal_end+0xc82/0xda0 [reiserfs] [68812.480825]
reiserfs_commit_for_inode+0x201/0x220 [reiserfs] [68812.480830]
reiserfs_sync_file+0x6b/0xe0 [reiserfs] [68812.480832]  do_fsync+0x38/0x60
[68812.480834]  SyS_fdatasync+0xf/0x20
[68812.480836]  do_syscall_64+0x6e/0x110
[68812.480838]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[68812.480839] RIP: 0033:0x7fe3c993384d
[68812.480840] RSP: 002b:00007fe3be489dd0 EFLAGS: 00000293 ORIG_RAX:
000000000000004b [68812.480842] RAX: ffffffffffffffda RBX:
000035c333be8500 RCX: 00007fe3c993384d [68812.480843] RDX:
0000000000000008 RSI: 0000000000000002 RDI: 000000000000003b
[68812.480844] RBP: 00007fe3be489e10 R08: 0000000000000001 R09:
0000000000000001 [68812.480845] R10: 000000000000c400 R11:
0000000000000293 R12: 0000000000000000 [68812.480846] R13:
d763a120f905d5d9 R14: 0000000000000000 R15: 0000000000001000
[68812.480848] INFO: task ThreadPoolForeg:27786 blocked for more than 480
seconds. [68812.480849]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.480850] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.480850] ThreadPoolForeg D    0 27786   9403
0x00000080 [68812.480851] Call Trace: [68812.480853]
__schedule+0x29e/0x6c0 [68812.480855]  schedule+0x32/0x80 [68812.480856]
schedule_preempt_disabled+0xa/0x10 [68812.480858]
__mutex_lock.isra.1+0x26b/0x4e0 [68812.480863]  ?
flush_commit_list+0x1fa/0x670 [reiserfs] [68812.480867]
flush_commit_list+0x1fa/0x670 [reiserfs] [68812.480872]
flush_commit_list+0x11f/0x670 [reiserfs] [68812.480877]
do_journal_end+0xc82/0xda0 [reiserfs] [68812.480882]
reiserfs_commit_for_inode+0x201/0x220 [reiserfs] [68812.480886]
reiserfs_sync_file+0x6b/0xe0 [reiserfs] [68812.480896]  do_fsync+0x38/0x60
[68812.480897]  SyS_fdatasync+0xf/0x20
[68812.480899]  do_syscall_64+0x6e/0x110
[68812.480900]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[68812.480901] RIP: 0033:0x7fe3c993384d
[68812.480902] RSP: 002b:00007fe3ba3163c0 EFLAGS: 00000293 ORIG_RAX:
000000000000004b [68812.480903] RAX: ffffffffffffffda RBX:
00007fe3ba3163d0 RCX: 00007fe3c993384d [68812.480904] RDX:
000035c3339eca28 RSI: 0000000000000000 RDI: 000000000000003c
[68812.480905] RBP: 00007fe3ba316440 R08: 0000000000000000 R09:
0000000000000001 [68812.480906] R10: 003582f4f668320e R11:
0000000000000293 R12: 0000000000000000 [68812.480907] R13:
000000000003bd88 R14: 00007fe3ba3164e0 R15: 0000000000000000
[68812.480909] INFO: task ThreadPoolForeg:28044 blocked for more than 480
seconds. [68812.480910]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.480911] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.480911] ThreadPoolForeg D    0 28044   9403
0x00000080 [68812.480912] Call Trace: [68812.480914]
__schedule+0x29e/0x6c0 [68812.480916]  schedule+0x32/0x80 [68812.480917]
schedule_preempt_disabled+0xa/0x10 [68812.480918]
__mutex_lock.isra.1+0x26b/0x4e0 [68812.480923]  ?
do_journal_begin_r+0xbe/0x390 [reiserfs] [68812.480927]
do_journal_begin_r+0xbe/0x390 [reiserfs] [68812.480930]  ?
reiserfs_lookup+0xb5/0x160 [reiserfs] [68812.480934]
journal_begin+0x80/0x140 [reiserfs] [68812.480938]
reiserfs_create+0xfc/0x210 [reiserfs] [68812.480940]
path_openat+0x1419/0x14d0 [68812.480942]  ?
account_entity_dequeue+0x30/0x90 [68812.480944]  ?
sched_clock_cpu+0xc/0xb0 [68812.480945]  ?
task_change_group_fair+0xda/0x140 [68812.480947]  do_filp_open+0x99/0x110
[68812.480949]  ? check_preempt_wakeup+0x144/0x230
[68812.480951]  ? __check_object_size+0xfa/0x1a0
[68812.480952]  ? __alloc_fd+0x3d/0x160
[68812.480953]  ? do_sys_open+0x12e/0x210
[68812.480955]  do_sys_open+0x12e/0x210
[68812.480956]  do_syscall_64+0x6e/0x110
[68812.480958]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[68812.480959] RIP: 0033:0x7fe3cfe1c85d
[68812.480960] RSP: 002b:00007fe3bcc87240 EFLAGS: 00000293 ORIG_RAX:
0000000000000002 [68812.480961] RAX: ffffffffffffffda RBX:
00007fe3bcc87250 RCX: 00007fe3cfe1c85d [68812.480962] RDX:
0000000000000180 RSI: 00000000000000c2 RDI: 000035c3367230c0
[68812.480963] RBP: 00007fe3bcc872e0 R08: 0000000000000000 R09:
0000000000000001 [68812.480964] R10: 00010c8f66b34755 R11:
0000000000000293 R12: 00000000000000c2 [68812.480965] R13:
00007fe3bcc87350 R14: 000035c335ebe9c0 R15: 0000000000008062
[68812.480967] INFO: task ThreadPoolForeg:28428 blocked for more than 480
seconds. [68812.480967]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.480968] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.480969] ThreadPoolForeg D    0 28428   9403
0x00000080 [68812.480970] Call Trace: [68812.480971]
__schedule+0x29e/0x6c0 [68812.480973]  schedule+0x32/0x80 [68812.480974]
schedule_preempt_disabled+0xa/0x10 [68812.480976]
__mutex_lock.isra.1+0x26b/0x4e0 [68812.480980]  ?
do_journal_begin_r+0xbe/0x390 [reiserfs] [68812.480984]
do_journal_begin_r+0xbe/0x390 [reiserfs] [68812.480988]  ?
reiserfs_lookup+0xb5/0x160 [reiserfs] [68812.480992]
journal_begin+0x80/0x140 [reiserfs] [68812.480995]
reiserfs_create+0xfc/0x210 [reiserfs] [68812.480997]
path_openat+0x1419/0x14d0 [68812.480999]  do_filp_open+0x99/0x110
[68812.481002]  ? __check_object_size+0xfa/0x1a0
[68812.481003]  ? __alloc_fd+0x3d/0x160
[68812.481004]  ? do_sys_open+0x12e/0x210
[68812.481005]  do_sys_open+0x12e/0x210
[68812.481007]  do_syscall_64+0x6e/0x110
[68812.481008]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[68812.481009] RIP: 0033:0x7fe3cfe1c85d
[68812.481010] RSP: 002b:00007fe3bd488340 EFLAGS: 00000293 ORIG_RAX:
0000000000000002 [68812.481012] RAX: ffffffffffffffda RBX:
00007fe3bd488350 RCX: 00007fe3cfe1c85d [68812.481013] RDX:
0000000000000180 RSI: 0000000000000241 RDI: 000035c338f629c0
[68812.481013] RBP: 00007fe3bd4883e0 R08: 0000000000000000 R09:
0000000000000001 [68812.481014] R10: 00013f185b0ec000 R11:
0000000000000293 R12: 0000000000000241 [68812.481015] R13:
000035c336840210 R14: 00007fe3bd488460 R15: 0000000000008048
[68812.481279] INFO: task rtorrent main:16442 blocked for more than 480
seconds. [68812.481280]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.481280] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.481281] rtorrent main   D    0 16442   9209
0x00000080 [68812.481282] Call Trace: [68812.481284]
__schedule+0x29e/0x6c0 [68812.481285]  schedule+0x32/0x80 [68812.481287]
schedule_preempt_disabled+0xa/0x10 [68812.481288]
__mutex_lock.isra.1+0x26b/0x4e0 [68812.481293]  ?
flush_commit_list+0x1fa/0x670 [reiserfs] [68812.481297]
flush_commit_list+0x1fa/0x670 [reiserfs] [68812.481301]
get_list_bitmap+0x81/0xd0 [reiserfs] [68812.481306]
do_journal_end+0xbcf/0xda0 [reiserfs] [68812.481310]
reiserfs_dirty_inode+0x97/0xa0 [reiserfs] [68812.481312]
__mark_inode_dirty+0x163/0x350 [68812.481314]
generic_update_time+0x79/0xc0 [68812.481316]  ? current_time+0x38/0x70
[68812.481317]  file_update_time+0xbe/0x110
[68812.481319]  filemap_page_mkwrite+0x41/0xb0
[68812.481322]  do_page_mkwrite+0x31/0x90
[68812.481323]  ? __do_fault+0x53/0x88
[68812.481325]  __handle_mm_fault+0x772/0xed0
[68812.481327]  handle_mm_fault+0xc6/0x1b0
[68812.481329]  __do_page_fault+0x23f/0x4c0
[68812.481331]  page_fault+0x25/0x50
[68812.481333] RIP: 0010:copy_user_generic_string+0x2c/0x40
[68812.481334] RSP: 0018:ffffb4b9837b3c48 EFLAGS: 00010206
[68812.481336] RAX: 00007f03dbfea164 RBX: 00000000000005a8 RCX:
0000000000000039 [68812.481337] RDX: 0000000000000005 RSI:
ffff9e7f649ae7dd RDI: 00007f03dbfea000 [68812.481338] RBP:
0000000000000000 R08: 00000000000005a8 R09: ffff9e7df8c568c8
[68812.481338] R10: ffff9e7f649ae402 R11: 00007ffffffff000 R12:
ffff9e7f649ae9aa [68812.481339] R13: ffffb4b9837b3e20 R14:
ffffb4b9837b3e40 R15: 00000000000005a8 [68812.481342]  ?
__switch_to_asm+0x35/0x70 [68812.481344]  copyout+0x22/0x30
[68812.481345]  _copy_to_iter+0x8d/0x3f0 [68812.481347]  ?
__switch_to_asm+0x41/0x70 [68812.481349]  ? __switch_to_asm+0x35/0x70
[68812.481350]  ? __switch_to_asm+0x41/0x70
[68812.481351]  ? __switch_to_asm+0x35/0x70
[68812.481353]  ? __switch_to_asm+0x41/0x70
[68812.481354]  ? __switch_to_asm+0x35/0x70
[68812.481355]  ? __switch_to_asm+0x41/0x70
[68812.481358]  skb_copy_datagram_iter+0x89/0x260
[68812.481360]  tcp_recvmsg+0x6bb/0xa10
[68812.481362]  ? ep_send_events_proc+0x19e/0x1f0
[68812.481363]  ? ep_read_events_proc+0xe0/0xe0
[68812.481365]  inet_recvmsg+0x50/0xc0
[68812.481367]  SYSC_recvfrom+0xc3/0x130
[68812.481369]  ? __audit_syscall_entry+0xae/0x100
[68812.481371]  ? syscall_trace_enter+0x1ca/0x2d0
[68812.481372]  ? __audit_syscall_exit+0x214/0x2a0
[68812.481374]  do_syscall_64+0x6e/0x110
[68812.481376]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[68812.481377] RIP: 0033:0x7f03e69b451f
[68812.481378] RSP: 002b:00007fff9b8841b0 EFLAGS: 00000246 ORIG_RAX:
000000000000002d [68812.481379] RAX: ffffffffffffffda RBX:
000000000000009b RCX: 00007f03e69b451f [68812.481380] RDX:
0000000000001709 RSI: 00007f03dbfe9c25 RDI: 000000000000009b
[68812.481381] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000 [68812.481382] R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000000 [68812.481383] R13:
0000000000001709 R14: 00007f03dbfe9c25 R15: 000055ec375e0300
[68812.481425] INFO: task kworker/3:4:19584 blocked for more than 480
seconds. [68812.481426]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.481427] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.481427] kworker/3:4     D    0 19584      2
0x80000080 [68812.481433] Workqueue: reiserfs/md7p1 flush_async_commits
[reiserfs] [68812.481434] Call Trace: [68812.481436]
__schedule+0x29e/0x6c0 [68812.481437]  schedule+0x32/0x80 [68812.481439]
schedule_preempt_disabled+0xa/0x10 [68812.481440]
__mutex_lock.isra.1+0x26b/0x4e0 [68812.481442]  ?
__switch_to_asm+0x41/0x70 [68812.481443]  ? __switch_to_asm+0x35/0x70
[68812.481445]  ? __switch_to_asm+0x35/0x70
[68812.481446]  ? __switch_to_asm+0x41/0x70
[68812.481450]  ? flush_commit_list+0x1fa/0x670 [reiserfs]
[68812.481454]  flush_commit_list+0x1fa/0x670 [reiserfs]
[68812.481468]  flush_async_commits+0x41/0x50 [reiserfs]
[68812.481470]  process_one_work+0x171/0x390
[68812.481472]  worker_thread+0x4d/0x3a0
[68812.481475]  kthread+0xff/0x130
[68812.481476]  ? process_one_work+0x390/0x390
[68812.481478]  ? kthread_create_on_node+0x70/0x70
[68812.481480]  ret_from_fork+0x22/0x40
[68812.481482] INFO: task kworker/3:1:21517 blocked for more than 480
seconds. [68812.481483]       Not tainted 4.14.184-nopreempt-AMDGPU-dav9
#1 [68812.481484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [68812.481484] kworker/3:1     D    0 21517      2
0x80000080 [68812.481489] Workqueue: events_long flush_old_commits
[reiserfs] [68812.481490] Call Trace:
[68812.481492]  __schedule+0x29e/0x6c0
[68812.481494]  schedule+0x32/0x80
[68812.481501]  raid5_make_request+0x1d3/0xb20 [raid456]
[68812.481503]  ? syscall_return_via_sysret+0x16/0x76
[68812.481505]  ? __switch_to_asm+0x41/0x70
[68812.481507]  ? __switch_to_asm+0x35/0x70
[68812.481509]  ? remove_wait_queue+0x60/0x60
[68812.481510]  ? __switch_to_asm+0x41/0x70
[68812.481512]  ? __switch_to_asm+0x35/0x70
[68812.481513]  ? __switch_to_asm+0x41/0x70
[68812.481515]  ? __switch_to_asm+0x35/0x70
[68812.481518]  md_handle_request+0x116/0x190
[68812.481520]  md_make_request+0x65/0x160
[68812.481523]  generic_make_request+0x123/0x2f0
[68812.481525]  ? submit_bio+0x6c/0x130
[68812.481527]  ? bio_alloc_bioset+0xcc/0x1d0
[68812.481529]  submit_bio+0x6c/0x130
[68812.481530]  ? guard_bio_eod+0x26/0xf0
[68812.481532]  submit_bh_wbc+0x163/0x190
[68812.481537]  write_ordered_buffers.isra.23+0x27c/0x3a0 [reiserfs]
[68812.481540]  ? radix_tree_lookup_slot+0x1e/0x50
[68812.481541]  ? find_get_entry+0x21/0x180
[68812.481543]  ? pagecache_get_page+0x184/0x320
[68812.481548]  flush_commit_list+0x28a/0x670 [reiserfs]
[68812.481553]  do_journal_end+0xc82/0xda0 [reiserfs]
[68812.481555]  ? __switch_to_asm+0x35/0x70
[68812.481559]  reiserfs_sync_fs+0x6b/0x80 [reiserfs]
[68812.481564]  flush_old_commits+0x5f/0x90 [reiserfs]
[68812.481566]  process_one_work+0x171/0x390
[68812.481568]  worker_thread+0x4d/0x3a0
[68812.481570]  kthread+0xff/0x130
[68812.481571]  ? process_one_work+0x390/0x390
[68812.481573]  ? kthread_create_on_node+0x70/0x70
[68812.481574]  ret_from_fork+0x22/0x40

I have a 100% reproducible environment. I will be happy to help you
debug. I know C. I don't have a shell script that can reproduce this.
The steps I take are:
1: Start rtorrent with a large torrent to DL.
2: Let it run over night (Tests indicate that it will not hang the kernel
during the day).

Linux Phenom-II-x6 4.14.184-nopreempt-AMDGPU-dav9 #1 SMP Fri Jun 19
17:02:34 UTC 2020 x86_64 GNU/Linux

GNU C               	6.3.0
GNU Make            	4.1
Binutils            	2.28
Util-linux          	2.29.2
Mount               	2.29.2
Module-init-tools   	23
E2fsprogs           	1.43.4
Jfsutils            	1.1.15
Reiserfsprogs       	3.6.25
Xfsprogs            	4.9.0
Quota-tools         	4.03
PPP                 	2.4.7
Isdn4k-utils        	3.25
Linux C Library     	2.24
Dynamic linker (ldd)	2.24
Linux C++ Library   	6.0.22
Procps              	3.3.12
Net-tools           	2.10
Kbd                 	2.0.3
Console-tools       	2.0.3
Sh-utils            	8.26
Udev                	220
Wireless-tools      	30
Modules Loaded      	ac97_bus async_memcpy async_pq
async_raid6_recov async_tx async_xor bluetooth bnep button cdrom
cpufreq_conservative cpufreq_ondemand cpufreq_powersave cpufreq_userspace
crc_itu_t dm_crypt dm_mod ecdh_generic ehci_hcd ehci_pci firewire_core
firewire_ohci fuse hid hid_generic hwmon_vid i2c_piix4 input_leds
ip6_tables ip6table_filter ip_tables iptable_filter irqbypass it87 joydev
k10temp kvm kvm_amd led_class lp mii ohci_pci parport parport_pc pcspkr
ppdev r8169 raid0 raid456 raid6_pq reiserfs sata_promise serio_raw shpchp
snd snd_ac97_codec snd_emu10k1 snd_emu10k1_synth snd_emux_synth
snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_mixer_oss
snd_pcm snd_pcm_oss snd_rawmidi snd_seq snd_seq_device snd_seq_dummy
snd_seq_midi snd_seq_midi_emul snd_seq_midi_event snd_seq_oss
snd_seq_virmidi snd_timer snd_util_mem soundcore sp5100_tco sr_mod uinput
usbhid x_tables xor

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 16
model		: 10
model name	: AMD Phenom(tm) II X6 1090T Processor
stepping	: 0
microcode	: 0x10000bf
cpu MHz		: 1879.281
cache size	: 512 KB
physical id	: 0
siblings	: 5
core id		: 0
cpu cores	: 5
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 6
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock
nrip_save pausefilter bugs		: tlb_mmatch apic_c1e
fxsave_leak sysret_ss_attrs null_seg amd_e400 spectre_v1 spectre_v2
bogomips	: 6432.42 TLB size	: 1024 4K pages clflush
size	: 64 cache_alignment	: 64 address sizes	: 48
bits physical, 48 bits virtual power management: ts ttp tm stc
100mhzsteps hwpstate cpb

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 16
model		: 10
model name	: AMD Phenom(tm) II X6 1090T Processor
stepping	: 0
microcode	: 0x10000bf
cpu MHz		: 2067.720
cache size	: 512 KB
physical id	: 0
siblings	: 5
core id		: 1
cpu cores	: 5
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 6
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock
nrip_save pausefilter bugs		: tlb_mmatch apic_c1e
fxsave_leak sysret_ss_attrs null_seg amd_e400 spectre_v1 spectre_v2
bogomips	: 6432.42 TLB size	: 1024 4K pages clflush
size	: 64 cache_alignment	: 64 address sizes	: 48
bits physical, 48 bits virtual power management: ts ttp tm stc
100mhzsteps hwpstate cpb

processor	: 2
vendor_id	: AuthenticAMD
cpu family	: 16
model		: 10
model name	: AMD Phenom(tm) II X6 1090T Processor
stepping	: 0
microcode	: 0x10000bf
cpu MHz		: 1515.344
cache size	: 512 KB
physical id	: 0
siblings	: 5
core id		: 2
cpu cores	: 5
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 6
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock
nrip_save pausefilter bugs		: tlb_mmatch apic_c1e
fxsave_leak sysret_ss_attrs null_seg amd_e400 spectre_v1 spectre_v2
bogomips	: 6432.42 TLB size	: 1024 4K pages clflush
size	: 64 cache_alignment	: 64 address sizes	: 48
bits physical, 48 bits virtual power management: ts ttp tm stc
100mhzsteps hwpstate cpb

processor	: 3
vendor_id	: AuthenticAMD
cpu family	: 16
model		: 10
model name	: AMD Phenom(tm) II X6 1090T Processor
stepping	: 0
microcode	: 0x10000bf
cpu MHz		: 1514.134
cache size	: 512 KB
physical id	: 0
siblings	: 5
core id		: 3
cpu cores	: 5
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 6
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock
nrip_save pausefilter bugs		: tlb_mmatch apic_c1e
fxsave_leak sysret_ss_attrs null_seg amd_e400 spectre_v1 spectre_v2
bogomips	: 6432.42 TLB size	: 1024 4K pages clflush
size	: 64 cache_alignment	: 64 address sizes	: 48
bits physical, 48 bits virtual power management: ts ttp tm stc
100mhzsteps hwpstate cpb

processor	: 4
vendor_id	: AuthenticAMD
cpu family	: 16
model		: 10
model name	: AMD Phenom(tm) II X6 1090T Processor
stepping	: 0
microcode	: 0x10000bf
cpu MHz		: 3089.003
cache size	: 512 KB
physical id	: 0
siblings	: 5
core id		: 4
cpu cores	: 5
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 6
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl
nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock
nrip_save pausefilter bugs		: tlb_mmatch apic_c1e
fxsave_leak sysret_ss_attrs null_seg amd_e400 spectre_v1 spectre_v2
bogomips	: 6432.42 TLB size	: 1024 4K pages clflush
size	: 64 cache_alignment	: 64 address sizes	: 48
bits physical, 48 bits virtual power management: ts ttp tm stc
100mhzsteps hwpstate cpb

configs 65536 0 - Live 0xffffffffc0ba3000
fuse 122880 3 - Live 0xffffffffc08d8000
snd_emu10k1_synth 16384 0 - Live 0xffffffffc08d3000
snd_emux_synth 53248 1 snd_emu10k1_synth, Live 0xffffffffc08c5000
snd_seq_midi_emul 16384 1 snd_emux_synth, Live 0xffffffffc08c0000
snd_seq_virmidi 16384 1 snd_emux_synth, Live 0xffffffffc089b000
snd_seq_dummy 16384 0 - Live 0xffffffffc08bb000
snd_seq_midi 16384 0 - Live 0xffffffffc08a6000
snd_seq_oss 45056 0 - Live 0xffffffffc08af000
snd_seq_midi_event 16384 3 snd_seq_virmidi,snd_seq_midi,snd_seq_oss, Live
0xffffffffc0775000 snd_seq 81920 12
snd_emux_synth,snd_seq_midi_emul,snd_seq_virmidi,snd_seq_dummy,snd_seq_midi,snd_seq_oss,snd_seq_midi_event,
Live 0xffffffffc0886000 ip6table_filter 16384 1 - Live 0xffffffffc0881000
ip6_tables 32768 1 ip6table_filter, Live 0xffffffffc0878000
iptable_filter 16384 1 - Live 0xffffffffc0867000 ip_tables 28672 1
iptable_filter, Live 0xffffffffc086d000 x_tables 45056 4
ip6table_filter,ip6_tables,iptable_filter,ip_tables, Live
0xffffffffc0851000 cpufreq_powersave 16384 0 - Live 0xffffffffc084c000
cpufreq_conservative 16384 0 - Live 0xffffffffc0847000 cpufreq_userspace
16384 0 - Live 0xffffffffc0842000 cpufreq_ondemand 16384 0 - Live
0xffffffffc0722000 bnep 24576 2 - Live 0xffffffffc0860000
bluetooth 602112 7 bnep, Live 0xffffffffc07ae000
ecdh_generic 24576 1 bluetooth, Live 0xffffffffc07a7000
uinput 20480 1 - Live 0xffffffffc076f000
it87 61440 0 - Live 0xffffffffc0797000
hwmon_vid 16384 1 it87, Live 0xffffffffc053e000
parport_pc 49152 0 - Live 0xffffffffc078a000
ppdev 20480 0 - Live 0xffffffffc070a000
lp 20480 0 - Live 0xffffffffc0710000
parport 57344 3 parport_pc,ppdev,lp, Live 0xffffffffc077b000
reiserfs 290816 1 - Live 0xffffffffc0727000
dm_crypt 40960 0 - Live 0xffffffffc0717000
dm_mod 143360 1 dm_crypt, Live 0xffffffffc06e6000
raid456 163840 1 - Live 0xffffffffc06bd000
async_raid6_recov 20480 1 raid456, Live 0xffffffffc06b7000
async_memcpy 16384 2 raid456,async_raid6_recov, Live 0xffffffffc0529000
async_pq 16384 2 raid456,async_raid6_recov, Live 0xffffffffc04df000
async_xor 16384 3 raid456,async_raid6_recov,async_pq, Live
0xffffffffc0455000 joydev 24576 0 - Live 0xffffffffc06b0000
xor 24576 1 async_xor, Live 0xffffffffc0667000
hid_generic 16384 0 - Live 0xffffffffc036d000
async_tx 16384 5
raid456,async_raid6_recov,async_memcpy,async_pq,async_xor, Live
0xffffffffc04c6000 usbhid 57344 0 - Live 0xffffffffc0658000 hid 126976 2
hid_generic,usbhid, Live 0xffffffffc0690000 raid6_pq 122880 3
raid456,async_raid6_recov,async_pq, Live 0xffffffffc0671000 sr_mod 28672
0 - Live 0xffffffffc04e5000 cdrom 65536 1 sr_mod, Live 0xffffffffc0647000
input_leds 16384 0 - Live 0xffffffffc0421000
led_class 16384 1 input_leds, Live 0xffffffffc03dc000
kvm_amd 94208 0 - Live 0xffffffffc062f000
snd_emu10k1 180224 1 snd_emu10k1_synth, Live 0xffffffffc09cb000
kvm 716800 1 kvm_amd, Live 0xffffffffc057f000
irqbypass 16384 1 kvm, Live 0xffffffffc03d7000
snd_util_mem 16384 2 snd_emux_synth,snd_emu10k1, Live 0xffffffffc03cd000
snd_ac97_codec 143360 1 snd_emu10k1, Live 0xffffffffc055b000
ac97_bus 16384 1 snd_ac97_codec, Live 0xffffffffc0392000
snd_hda_codec_realtek 110592 1 - Live 0xffffffffc050d000
snd_hda_codec_hdmi 57344 1 - Live 0xffffffffc04d0000
snd_rawmidi 40960 3 snd_seq_virmidi,snd_seq_midi,snd_emu10k1, Live
0xffffffffc0489000 snd_hda_codec_generic 86016 1 snd_hda_codec_realtek,
Live 0xffffffffc04a2000 snd_seq_device 16384 7
snd_emu10k1_synth,snd_emux_synth,snd_seq_midi,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi,
Live 0xffffffffc039f000 pcspkr 16384 0 - Live 0xffffffffc038d000
sata_promise 20480 0 - Live 0xffffffffc0367000 firewire_ohci 45056 0 -
Live 0xffffffffc047d000 serio_raw 16384 0 - Live 0xffffffffc0383000
snd_hda_intel 40960 2 - Live 0xffffffffc03f9000
raid0 20480 4 - Live 0xffffffffc03c7000
firewire_core 81920 1 firewire_ohci, Live 0xffffffffc0468000
k10temp 16384 0 - Live 0xffffffffc0388000
crc_itu_t 16384 1 firewire_core, Live 0xffffffffc0362000
snd_hda_codec 151552 4
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,
Live 0xffffffffc042f000 snd_hda_core 94208 5
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0xffffffffc0543000 r8169 94208 0 - Live 0xffffffffc03e1000 snd_hwdep
20480 3 snd_emux_synth,snd_emu10k1,snd_hda_codec, Live 0xffffffffc0399000
mii 16384 1 r8169, Live 0xffffffffc0373000 snd_pcm_oss 61440 0 - Live
0xffffffffc052e000 snd_mixer_oss 28672 1 snd_pcm_oss, Live
0xffffffffc037b000 snd_pcm 118784 8
snd_emu10k1,snd_ac97_codec,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core,snd_pcm_oss,
Live 0xffffffffc04ef000 ohci_pci 16384 0 - Live 0xffffffffc04cb000
snd_timer 36864 3 snd_seq,snd_emu10k1,snd_pcm, Live 0xffffffffc04bc000
sp5100_tco 16384 0 - Live 0xffffffffc0496000 button 16384 0 - Live
0xffffffffc042a000 snd 98304 22
snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq,snd_emu10k1,snd_ac97_codec,snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_rawmidi,snd_hda_codec_generic,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,
Live 0xffffffffc0408000 ehci_pci 16384 0 - Live 0xffffffffc03d2000
soundcore 16384 1 snd, Live 0xffffffffc049d000 shpchp 40960 0 - Live
0xffffffffc045d000 ehci_hcd 94208 1 ehci_pci, Live 0xffffffffc03af000
i2c_piix4 24576 0 - Live 0xffffffffc03a4000

0000-0000 : PCI Bus 0000:00
  0000-0000 : dma1
  0000-0000 : pic1
  0000-0000 : timer0
  0000-0000 : timer1
  0000-0000 : keyboard
  0000-0000 : PNP0800:00
  0000-0000 : keyboard
  0000-0000 : rtc0
  0000-0000 : dma page reg
  0000-0000 : pic2
  0000-0000 : dma2
  0000-0000 : PNP0C04:00
    0000-0000 : fpu
  0000-0000 : pnp 00:02
  0000-0000 : pnp 00:02
    0000-0000 : it87
      0000-0000 : it87
0000-0000 : PCI Bus 0000:00
  0000-0000 : vesafb
0000-0000 : PCI Bus 0000:00
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:05
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
    0000-0000 : ACPI PM1a_EVT_BLK
    0000-0000 : ACPI PM1a_CNT_BLK
    0000-0000 : ACPI PM_TMR
    0000-0000 : ACPI CPU throttle
    0000-0000 : ACPI GPE0_BLK
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:02
  0000-0000 : piix4_smbus
  0000-0000 : pnp 00:01
    0000-0000 : piix4_smbus
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
  0000-0000 : pnp 00:01
    0000-0000 : smba_idx
  0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
  0000-0000 : PCI Bus 0000:05
    0000-0000 : 0000:05:07.0
    0000-0000 : 0000:05:07.0
    0000-0000 : 0000:05:06.0
      0000-0000 : EMU10K1
  0000-0000 : PCI Bus 0000:04
    0000-0000 : 0000:04:00.0
      0000-0000 : ahci
    0000-0000 : 0000:04:00.0
      0000-0000 : ahci
    0000-0000 : 0000:04:00.0
      0000-0000 : ahci
    0000-0000 : 0000:04:00.0
      0000-0000 : ahci
    0000-0000 : 0000:04:00.0
      0000-0000 : ahci
  0000-0000 : PCI Bus 0000:03
    0000-0000 : 0000:03:00.0
      0000-0000 : r8169
  0000-0000 : PCI Bus 0000:01
    0000-0000 : 0000:01:00.0
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : 0000:00:11.0
    0000-0000 : ahci
  0000-0000 : pnp 00:01

00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : Video ROM
  00000000-00000000 : Adapter ROM
00000000-00000000 : Reserved
  00000000-00000000 : System ROM
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : ACPI Tables
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:01
    00000000-00000000 : 0000:01:00.0
  00000000-00000000 : PCI Bus 0000:03
    00000000-00000000 : 0000:03:00.0
      00000000-00000000 : r8169
  00000000-00000000 : PCI MMCONFIG 0000 [bus 00-ff]
    00000000-00000000 : pnp 00:00
  00000000-00000000 : Reserved
  00000000-00000000 : PCI Bus 0000:05
    00000000-00000000 : 0000:05:07.0
    00000000-00000000 : 0000:05:07.0
    00000000-00000000 : 0000:05:06.2
    00000000-00000000 : 0000:05:07.0
      00000000-00000000 : sata_promise
    00000000-00000000 : 0000:05:06.2
      00000000-00000000 : firewire_ohci
  00000000-00000000 : PCI Bus 0000:04
    00000000-00000000 : 0000:04:00.0
    00000000-00000000 : 0000:04:00.0
      00000000-00000000 : ahci
  00000000-00000000 : PCI Bus 0000:03
    00000000-00000000 : 0000:03:00.0
      00000000-00000000 : r8169
  00000000-00000000 : PCI Bus 0000:02
    00000000-00000000 : 0000:02:00.0
      00000000-00000000 : xhci-hcd
  00000000-00000000 : PCI Bus 0000:01
    00000000-00000000 : 0000:01:00.0
    00000000-00000000 : 0000:01:00.1
      00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:14.2
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:16.2
    00000000-00000000 : ehci_hcd
  00000000-00000000 : 0000:00:16.0
    00000000-00000000 : ohci_hcd
  00000000-00000000 : 0000:00:14.5
    00000000-00000000 : ohci_hcd
  00000000-00000000 : 0000:00:13.2
    00000000-00000000 : ehci_hcd
  00000000-00000000 : 0000:00:13.0
    00000000-00000000 : ohci_hcd
  00000000-00000000 : 0000:00:12.2
    00000000-00000000 : ehci_hcd
  00000000-00000000 : 0000:00:12.0
    00000000-00000000 : ohci_hcd
  00000000-00000000 : 0000:00:11.0
    00000000-00000000 : ahci
  00000000-00000000 : pnp 00:07
  00000000-00000000 : Reserved
    00000000-00000000 : IOAPIC 0
  00000000-00000000 : Reserved
    00000000-00000000 : pnp 00:01
  00000000-00000000 : Reserved
    00000000-00000000 : IOAPIC 1
  00000000-00000000 : Reserved
    00000000-00000000 : HPET 0
      00000000-00000000 : PNP0103:00
  00000000-00000000 : Reserved
    00000000-00000000 : pnp 00:01
  00000000-00000000 : Reserved
    00000000-00000000 : pnp 00:01
  00000000-00000000 : Local APIC
    00000000-00000000 : pnp 00:01
  00000000-00000000 : Reserved
    00000000-00000000 : pnp 00:01
00000000-00000000 : System RAM
  00000000-00000000 : Kernel code
  00000000-00000000 : Kernel data
  00000000-00000000 : Kernel bss

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Hitachi HUS72403 Rev: A5F0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Hitachi HUA72303 Rev: A840
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD60EDAZ-11B Rev: 0A80
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Hitachi HUA72302 Rev: A840
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD60EDAZ-11B Rev: 0A80
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST2000DM001-1ER1 Rev: CC26
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Hitachi HDS72202 Rev: A28A
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST2000DM001-1CH1 Rev: CC29
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: TOSHIBA DT01ABA2 Rev: ABB0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi9 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: TOSHIBA DT01ABA2 Rev: ABB0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi10 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: BD-RE  WH14NS40  Rev: 1.02
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi11 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Hitachi HUS72403 Rev: A5F0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi12 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVD-RAM GH22LP20 Rev: 1.04
  Type:   CD-ROM                           ANSI  SCSI revision: 05

<EDIT>
On the suggestion to not use reiserfs:

My interest in using reiserfs was so that I would have tail packing. I've
searched online and can't find another FS with this function for Linux.
The reason I need tail packing is because I keep a bunch of mostly git
repositories on my system. These contain a lot of files that are either
small or are empty. I could try to hardlink all the empty files and small
duplicate files, but git would complain. I could compress the source code
like I do with normal code bases, but then I'd need to decompress and
update them all. Writing a script to do that would be nothing, it's just
the time involved compressing/decompressing that would be a waist (which
is saying nothing compared to git's love for full histories instead of
up-to-the-last-4-versions or something).
</EDIT>


I'm in the process of upgrading my storage (backup, change HW, restore).
This means that my environment will change (RAID5->RAID6) and possibly
the bug will disappear or be hard to reproduce like it has been for over
a year now. I would therefor ask that you don't ignore this/delay so that
this long standing bug can be quashed.

Again, I'm happy to help you hunt down this bug!

https://bugzilla.kernel.org/show_bug.cgi?id=208719

Thanks,
David

--MP_/53xjX6hBXUYm/McFpUEy5VO
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.gz

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
+QnDBgMA

--MP_/53xjX6hBXUYm/McFpUEy5VO
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=lspci.txt.gz

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
Pd/ANjOrAAA=

--MP_/53xjX6hBXUYm/McFpUEy5VO--

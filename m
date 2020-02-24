Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C5C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D632084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582569388;
	bh=5ARKjkoLR54/jJyIzF78niKYOSs49QGXnjDBHhpH0vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vLJ++Cj3oFlgwAQkOEYw8gNASM5jjYn77LEyOqZcoZNcA23n03GpgTnqal6nQp2P+
	 eGrRqHY+wg9yWeZyzBlp1FZFmu9PX+O9tyqKwDcc+vYML7ZnKMGD3QHlHdQr8xGRR/
	 KRkg34xIZL5tjco7Q1hCnciQxpbYuM/3c9NUlyJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBXSg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBXSg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:36:26 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 862CB20838;
        Mon, 24 Feb 2020 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582569385;
        bh=5ARKjkoLR54/jJyIzF78niKYOSs49QGXnjDBHhpH0vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOef3zEjL2cKAv1uRycWcusFo0RN4QOfsflUwvfxzfqA1aDC2DPAHT4xgHk8VLs3F
         bLx66JxRrf6bJZez8XWmN+tbLLx4ds9OaDnQKF6kWM8RbLOMuXV+fb+OdRpKs7dfVf
         cnWuU8yG4R/eXMdR26VSdh11hi46fr/7/ZR2ZmQU=
Date:   Mon, 24 Feb 2020 10:36:24 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+6a7d71142d61b8c7c8d0@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in get_work_pool (2)
Message-ID: <20200224183624.GD109047@gmail.com>
References: <0000000000001783610599400420@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001783610599400420@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 11:05:09PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fa41dae00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3b8f5088d4043a
> dashboard link: https://syzkaller.appspot.com/bug?extid=6a7d71142d61b8c7c8d0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160007f2e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476e59ce00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6a7d71142d61b8c7c8d0@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in atomic64_read
> include/asm-generic/atomic-instrumented.h:836 [inline]
> BUG: KASAN: use-after-free in atomic_long_read
> include/asm-generic/atomic-long.h:28 [inline]
> BUG: KASAN: use-after-free in get_work_pool+0x1c/0x1b0
> kernel/workqueue.c:707
> Read of size 8 at addr ffff888093492008 by task syz-executor803/9732
> 
> CPU: 1 PID: 9732 Comm: syz-executor803 Not tainted 5.4.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x197/0x210 lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
>  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
>  kasan_report+0x12/0x20 mm/kasan/common.c:639
>  check_memory_region_inline mm/kasan/generic.c:185 [inline]
>  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
>  __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
>  atomic64_read include/asm-generic/atomic-instrumented.h:836 [inline]
>  atomic_long_read include/asm-generic/atomic-long.h:28 [inline]
>  get_work_pool+0x1c/0x1b0 kernel/workqueue.c:707
>  start_flush_work kernel/workqueue.c:2979 [inline]
>  __flush_work+0x153/0xa50 kernel/workqueue.c:3040
>  __cancel_work_timer+0x3d9/0x540 kernel/workqueue.c:3128
>  cancel_work_sync+0x18/0x20 kernel/workqueue.c:3164
>  tty_buffer_cancel_work+0x16/0x20 drivers/tty/tty_buffer.c:613
>  release_tty+0x261/0x470 drivers/tty/tty_io.c:1520
>  tty_release_struct+0x3c/0x50 drivers/tty/tty_io.c:1629
>  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1789
>  __fput+0x2ff/0x890 fs/file_table.c:280
>  ____fput+0x16/0x20 fs/file_table.c:313
>  task_work_run+0x145/0x1c0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x8e7/0x2ef0 kernel/exit.c:797
>  do_group_exit+0x135/0x360 kernel/exit.c:895
>  __do_sys_exit_group kernel/exit.c:906 [inline]
>  __se_sys_exit_group kernel/exit.c:904 [inline]
>  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:904
>  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43ff38
> Code: Bad RIP value.
> RSP: 002b:00007ffc3c6d7428 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ff38
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004bf950 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 9732:
>  save_stack+0x23/0x90 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  __kasan_kmalloc mm/kasan/common.c:513 [inline]
>  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
>  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
>  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
>  kmalloc include/linux/slab.h:556 [inline]
>  kzalloc include/linux/slab.h:670 [inline]
>  vc_allocate drivers/tty/vt/vt.c:1085 [inline]
>  vc_allocate+0x1fc/0x760 drivers/tty/vt/vt.c:1066
>  con_install+0x52/0x410 drivers/tty/vt/vt.c:3229
>  tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
>  tty_init_dev drivers/tty/tty_io.c:1341 [inline]
>  tty_init_dev+0xf9/0x470 drivers/tty/tty_io.c:1318
>  tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
>  tty_open+0x4a5/0xbb0 drivers/tty/tty_io.c:2035
>  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
>  do_dentry_open+0x4e6/0x1380 fs/open.c:797
>  vfs_open+0xa0/0xd0 fs/open.c:914
>  do_last fs/namei.c:3420 [inline]
>  path_openat+0x10df/0x4500 fs/namei.c:3537
>  do_filp_open+0x1a1/0x280 fs/namei.c:3567
>  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
>  __do_sys_open fs/open.c:1115 [inline]
>  __se_sys_open fs/open.c:1110 [inline]
>  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
>  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 9731:
>  save_stack+0x23/0x90 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  kasan_set_free_info mm/kasan/common.c:335 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
>  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
>  __cache_free mm/slab.c:3426 [inline]
>  kfree+0x10a/0x2c0 mm/slab.c:3757
>  vt_disallocate_all+0x2bd/0x3e0 drivers/tty/vt/vt_ioctl.c:323
>  vt_ioctl+0xc38/0x26d0 drivers/tty/vt/vt_ioctl.c:816
>  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
>  vfs_ioctl fs/ioctl.c:47 [inline]
>  file_ioctl fs/ioctl.c:545 [inline]
>  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
>  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
>  __do_sys_ioctl fs/ioctl.c:756 [inline]
>  __se_sys_ioctl fs/ioctl.c:754 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
>  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe

#syz dup: KASAN: use-after-free Write in release_tty

(Thread link: https://lkml.kernel.org/lkml/0000000000006663de0598d25ab1@google.com/)

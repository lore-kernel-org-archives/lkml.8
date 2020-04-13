Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848EC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A4E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586809941;
	bh=+mQbQlOhLguCM06H0KI6FH4Hkb+h5MuoB07rdeEjuVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Wyv8texDab5YR0XHg4ljrUX4w9xOdIxaK2dCPULtqZBbnWk8pRcpEKn3tRu7gmGwM
	 jBVFrnKQdq0Q1cCuW6dU3UNyhI7Dcvd4c9qqsWqLeDBKaGh3mlYLfvXjA/sb2/Qant
	 ULVTh1y27KbF97VvHpLaFQn8JP4buAmXOML/D5Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbgDMUcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgDMUcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:32:19 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6759320663;
        Mon, 13 Apr 2020 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586809937;
        bh=+mQbQlOhLguCM06H0KI6FH4Hkb+h5MuoB07rdeEjuVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JRwIbOGNGd8SeaX+wyxXDZubqAgLXv/8ybo1QArs9ziR+GHtb7zTJemIeScafcvWW
         LxmpdDhEj6KVjPXvAOVmlbMXDvdRReKcrM9cw4iY6uB9VjkpZlW/LqI/bRlcspqFnG
         YzPBIqi8dyJ7fIG41nnsDRzA4ozEIZL/oSod9Nig=
Date:   Mon, 13 Apr 2020 13:32:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+2854d22c7dd957a6519a@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Evan Green <evgreen@chromium.org>,
        Martijn Coenen <maco@android.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: WARNING in unaccount_page_cache_page (2)
Message-Id: <20200413133216.df03bc0a952276abdaa610cd@linux-foundation.org>
In-Reply-To: <0000000000002ce79705a3275559@google.com>
References: <0000000000002ce79705a3275559@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 00:50:11 -0700 syzbot <syzbot+2854d22c7dd957a6519a@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ae46d2aa mm/gup: Let __get_user_pages_locked() return -EIN..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b60343e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca75979eeebf06c2
> dashboard link: https://syzkaller.appspot.com/bug?extid=2854d22c7dd957a6519a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2854d22c7dd957a6519a@syzkaller.appspotmail.com

(cc's added)

Looks like the loop backing device's pagecache still has a dirty page,
despite us having just run sync_blockdev().  It may well be a race of
some form - do we have any description of what the test is doing?


> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 8402 at mm/filemap.c:222 unaccount_page_cache_page+0x631/0xd60 mm/filemap.c:222
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 8402 Comm: syz-executor.4 Not tainted 5.6.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  panic+0x2e3/0x75c kernel/panic.c:221
>  __warn.cold+0x2f/0x35 kernel/panic.c:582
>  report_bug+0x27b/0x2f0 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:175 [inline]
>  fixup_bug arch/x86/kernel/traps.c:170 [inline]
>  do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
>  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:unaccount_page_cache_page+0x631/0xd60 mm/filemap.c:222
> Code: 02 00 0f 85 3a 06 00 00 48 8b 1b 31 ff 48 c1 eb 03 83 e3 01 48 89 de e8 9d 01 e2 ff 48 85 db 0f 84 d9 fb ff ff e8 ff ff e1 ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02
> RSP: 0018:ffffc90001287688 EFLAGS: 00010012
> RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc90011a34000
> RDX: 000000000000ec1b RSI: ffffffff81913191 RDI: 0000000000000007
> RBP: ffffea0001165dc0 R08: ffff88804a3ce240 R09: fffff9400022cbb9
> R10: ffffea0001165dc7 R11: fffff9400022cbb8 R12: 0000000000000000
> R13: ffff8880a3f6bbe0 R14: ffffea0001165dc0 R15: ffffea00022cd088
>  delete_from_page_cache_batch+0x1a6/0xec0 mm/filemap.c:355
>  truncate_inode_pages_range+0x58b/0x1760 mm/truncate.c:366
>  kill_bdev+0xd1/0x100 fs/block_dev.c:87
>  loop_set_status+0x315/0x1370 drivers/block/loop.c:1272
>  loop_set_status_old+0x223/0x310 drivers/block/loop.c:1468
>  lo_ioctl+0x308/0x1410 drivers/block/loop.c:1612
>  __blkdev_driver_ioctl block/ioctl.c:322 [inline]
>  blkdev_ioctl+0x25b/0x660 block/ioctl.c:718
>  block_ioctl+0xf9/0x140 fs/block_dev.c:1996
>  vfs_ioctl fs/ioctl.c:47 [inline]
>  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
>  __do_sys_ioctl fs/ioctl.c:772 [inline]
>  __se_sys_ioctl fs/ioctl.c:770 [inline]
>  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x45c889
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f83d100ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f83d100b6d4 RCX: 000000000045c889
> RDX: 0000000020000440 RSI: 0000000000004c02 RDI: 0000000000000003
> RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000000003f4 R14: 00000000004c6902 R15: 000000000076bf0c
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

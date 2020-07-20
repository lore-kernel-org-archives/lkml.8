Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C95C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF3C20717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595289620;
	bh=7ruEEyKDUeYqw7QTMZfSVf0o3+tXFE6jymo2C5c1vDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FGU7D4xgX3cYNLXzAjubrn7uLtx+BWmkT9YbdbRIMBFSB7FXSqD1aond5YTnTuFix
	 bNPlzX6EtYrjS02EAR202GgurajPpUTqOv7xbH7ko9NekzQLo2vkWwTYwJHQ00ruT9
	 1mTrNfY93UHQrnalaxpRDVHivAR51l4OZQsRqABs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgGUAAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGUAAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:00:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7DA208E4;
        Mon, 20 Jul 2020 23:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595289105;
        bh=7ruEEyKDUeYqw7QTMZfSVf0o3+tXFE6jymo2C5c1vDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vigIZWauYeJjqcJLOmY21S4+ieHufF0KzoPQtCFsoYZikeJcCItEoqiDzxWfjzJ4L
         CCTGDKwWEXkIVnZ3ZjfFbI0ZMZk4NUYjPhYjJGyoEOqJA/+dDuZ4LHPZ/wycAjslmQ
         UUfxBqUqlaSpzZJ132C/8qiw5mg9Guv+GcWQFJZw=
Date:   Mon, 20 Jul 2020 16:51:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: kernel BUG at include/linux/swapops.h:LINE!
Message-Id: <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
In-Reply-To: <0000000000004c38cd05aad1d13f@google.com>
References: <000000000000bc4fd705a6e090e2@google.com>
        <0000000000004c38cd05aad1d13f@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 14:10:19 -0700 syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    4c43049f Add linux-next specific files for 20200716
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c56087100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
> dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1344abeb100000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com

Thanks.

__handle_mm_fault
  ->pmd_migration_entry_wait
    ->migration_entry_to_page

stumbled onto an unlocked page.

I don't immediately see a cause.  Perhaps Matthew's "THP prep patches",
perhaps something else.

Is it possible to perform a bisection?

> ------------[ cut here ]------------
> kernel BUG at include/linux/swapops.h:197!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 19938 Comm: syz-executor.2 Not tainted 5.8.0-rc5-next-20200716-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:migration_entry_to_page include/linux/swapops.h:197 [inline]
> RIP: 0010:migration_entry_to_page include/linux/swapops.h:190 [inline]
> RIP: 0010:pmd_migration_entry_wait+0x493/0x520 mm/migrate.c:368
> Code: 4d 8d 66 ff e9 1f fe ff ff e8 b9 c4 be ff 49 8d 5f ff e9 58 fe ff ff e8 ab c4 be ff 4d 8d 66 ff e9 a9 fe ff ff e8 9d c4 be ff <0f> 0b e8 96 c4 be ff 0f 0b e8 8f c4 be ff 4c 8d 65 ff eb a7 48 89
> RSP: 0018:ffffc9001095fb70 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81b56a24
> RDX: ffff888092022240 RSI: ffffffff81b56b43 RDI: 0000000000000001
> RBP: ffffea0008468080 R08: 0000000000000000 R09: ffffea0008468087
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0008468080
> R13: ffff888015d2e0c0 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f55eb477700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 000000021ad87000 CR4: 00000000001526e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __handle_mm_fault mm/memory.c:4349 [inline]
>  handle_mm_fault+0x23cf/0x45e0 mm/memory.c:4465
>  do_user_addr_fault+0x598/0xbf0 arch/x86/mm/fault.c:1294
>  handle_page_fault arch/x86/mm/fault.c:1351 [inline]
>  exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1404
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
> RIP: 0010:copy_user_generic_unrolled+0x89/0xc0 arch/x86/lib/copy_user_64.S:91
> Code: 38 4c 89 47 20 4c 89 4f 28 4c 89 57 30 4c 89 5f 38 48 8d 76 40 48 8d 7f 40 ff c9 75 b6 89 d1 83 e2 07 c1 e9 03 74 12 4c 8b 06 <4c> 89 07 48 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89 d1 8a
> RSP: 0018:ffffc9001095fe48 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000020000080 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: ffffc9001095fea8 RDI: 0000000020000080
> RBP: ffffc9001095fea8 R08: 0000000400000003 R09: ffffc9001095feaf
> R10: fffff5200212bfd5 R11: 0000000000000000 R12: 0000000000000008
> R13: 0000000020000088 R14: 00007ffffffff000 R15: 0000000000000000
>  copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
>  raw_copy_to_user arch/x86/include/asm/uaccess_64.h:74 [inline]
>  _copy_to_user+0x11e/0x160 lib/usercopy.c:30
>  copy_to_user include/linux/uaccess.h:168 [inline]
>  do_pipe2+0x128/0x1b0 fs/pipe.c:1014
>  __do_sys_pipe fs/pipe.c:1035 [inline]
>  __se_sys_pipe fs/pipe.c:1033 [inline]
>  __x64_sys_pipe+0x2f/0x40 fs/pipe.c:1033
>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45c1d9
> Code: Bad RIP value.
> RSP: 002b:00007f55eb476c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000016
> RAX: ffffffffffffffda RBX: 0000000000022ac0 RCX: 000000000045c1d9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
> RBP: 000000000078c070 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078c04c
> R13: 00007ffcfc120ecf R14: 00007f55eb4779c0 R15: 000000000078c04c
> Modules linked in:
> ---[ end trace ea73d933d66ff0d4 ]---
> RIP: 0010:migration_entry_to_page include/linux/swapops.h:197 [inline]
> RIP: 0010:migration_entry_to_page include/linux/swapops.h:190 [inline]
> RIP: 0010:pmd_migration_entry_wait+0x493/0x520 mm/migrate.c:368
> Code: 4d 8d 66 ff e9 1f fe ff ff e8 b9 c4 be ff 49 8d 5f ff e9 58 fe ff ff e8 ab c4 be ff 4d 8d 66 ff e9 a9 fe ff ff e8 9d c4 be ff <0f> 0b e8 96 c4 be ff 0f 0b e8 8f c4 be ff 4c 8d 65 ff eb a7 48 89
> RSP: 0018:ffffc9001095fb70 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81b56a24
> RDX: ffff888092022240 RSI: ffffffff81b56b43 RDI: 0000000000000001
> RBP: ffffea0008468080 R08: 0000000000000000 R09: ffffea0008468087
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0008468080
> R13: ffff888015d2e0c0 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f55eb477700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 000000021ad87000 CR4: 00000000001526e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 

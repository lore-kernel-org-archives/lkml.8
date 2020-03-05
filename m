Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21734C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A3A2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCEIHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:07:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgCEIHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:07:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27F32ACC3;
        Thu,  5 Mar 2020 08:07:22 +0000 (UTC)
Subject: Re: xen boot PVH guest with linux 5.6.0-rc4-ish kernel: general
 protection fault, RIP: 0010:__pv_queued_spin_lock_slowpath
To:     Sander Eikelenboom <linux@eikelenboom.it>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d323139d-97ef-0c76-8ec6-a669f5b0ba2d@eikelenboom.it>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <4fa2ddcd-f8ce-12a5-e82e-c28cc865fb86@suse.com>
Date:   Thu, 5 Mar 2020 09:07:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d323139d-97ef-0c76-8ec6-a669f5b0ba2d@eikelenboom.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.20 18:52, Sander Eikelenboom wrote:
> Hi Juergen,
> 
> Just tested a 5.6.0-rc4'ish kernel (8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238, so it includes the xen fixes from x86 trees).
> Xen is the latest xen-unstable, dom0 kernel is 5.5.7.
> 
> During boot of the PVH guest I got the splat below.
> With a 5.5.7 kernel the guest boots fine.

I think I have found the problem. Testing a patch now...


Juergen

> 
> --
> Sander
> 
> 
> [    1.921031] general protection fault, probably for non-canonical address 0x344a3feab7bf8: 0000 [#1] SMP NOPTI
> [    1.921090] CPU: 1 PID: 1686 Comm: systemd-udevd Tainted: G        W         5.6.0-rc4-20200304-doflr-mac80211debug+ #1
> [    1.921134] RIP: 0010:__pv_queued_spin_lock_slowpath+0x195/0x2a0
> [    1.921160] Code: c4 c1 ea 12 4c 8d 6d 14 41 be 01 00 00 00 41 83 e4 03 8d 42 ff 49 c1 e4 05 48 98 49 81 c4 80 c3 02 00 4c 03 24 c5 20 89 b7 82 <49> 89 2c 24 b8 00 80 00 00 eb 15 84 c0 75 0a 41 0f b6 54 24 14 84
> [    1.921229] RSP: 0018:ffffc90000213958 EFLAGS: 00010002
> [    1.921249] RAX: 000000000000327f RBX: ffff888005ce00e0 RCX: 0000000000000001
> [    1.921278] RDX: 0000000000003280 RSI: 0000000000000000 RDI: 0000000000000000
> [    1.921307] RBP: ffff88801f52c380 R08: 00000000fffea95e R09: ffff8880192d0c80
> [    1.921335] R10: ffff8880192d0cb8 R11: ffffc90000213b01 R12: 000344a3feab7bf8
> [    1.921365] R13: ffff88801f52c394 R14: 0000000000000001 R15: 0000000000080000
> [    1.921402] FS:  00007f771d762d40(0000) GS:ffff88801f500000(0000) knlGS:0000000000000000
> [    1.921438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.921461] CR2: 00007fffaae16ec8 CR3: 0000000004b04000 CR4: 00000000000006e0
> [    1.921608] Call Trace:
> [    1.921628]  ? ktime_get+0x31/0x90
> [    1.921646]  _raw_spin_lock_irqsave+0x2b/0x30
> [    1.921669]  blkif_queue_rq+0x6e/0x7c0
> [    1.921685]  ? wait_woken+0x80/0x80
> [    1.921701]  ? xen_clocksource_get_cycles+0x11/0x20
> [    1.921720]  ? ktime_get+0x31/0x90
> [    1.921737]  ? blk_mq_get_request+0x195/0x3b0
> [    1.921757]  ? blk_account_io_start+0xd4/0x150
> [    1.921776]  __blk_mq_try_issue_directly+0x10e/0x1c0
> [    1.921798]  blk_mq_request_issue_directly+0x43/0xe0
> [    1.921819]  blk_mq_try_issue_list_directly+0x3c/0xb0
> [    1.921840]  blk_mq_sched_insert_requests+0xa0/0xf0
> [    1.921860]  blk_mq_flush_plug_list+0x122/0x1e0
> [    1.921879]  blk_flush_plug_list+0xc1/0xf0
> [    1.921897]  blk_finish_plug+0x1c/0x29
> [    1.921914]  read_pages+0x7a/0x140
> [    1.921931]  __do_page_cache_readahead+0x188/0x1a0
> [    1.921952]  force_page_cache_readahead+0x8b/0xf0
> [    1.921972]  generic_file_read_iter+0x7e1/0xae0
> [    1.921993]  ? mem_cgroup_throttle_swaprate+0x1f/0x145
> [    1.922014]  ? _copy_to_user+0x26/0x30
> [    1.922031]  ? cp_new_stat+0x127/0x160
> [    1.922048]  new_sync_read+0x10f/0x1a0
> [    1.922064]  vfs_read+0x8c/0x140
> [    1.922081]  ksys_read+0x54/0xd0
> [    1.922098]  do_syscall_64+0x49/0x130
> [    1.922114]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    1.922138] RIP: 0033:0x7f771df43461
> [    1.922154] Code: fe ff ff 50 48 8d 3d fe d0 09 00 e8 e9 03 02 00 66 0f 1f 84 00 00 00 00 00 48 8d 05 99 62 0d 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
> [    1.922225] RSP: 002b:00007fffaae1a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [    1.922255] RAX: ffffffffffffffda RBX: 000055d4cca138f0 RCX: 00007f771df43461
> [    1.922284] RDX: 0000000000000040 RSI: 000055d4cca164f8 RDI: 000000000000000c
> [    1.922313] RBP: 000055d4cca13940 R08: 000055d4cca164d0 R09: 0000000000000005
> [    1.922342] R10: 000055d4cc9fe010 R11: 0000000000000246 R12: 000000013fff0000
> [    1.922370] R13: 0000000000000040 R14: 000055d4cca164e8 R15: 000055d4cca164d0
> [    1.922398] Modules linked in:
> [    1.922415] ---[ end trace baa27c3655b1ea59 ]---
> [    1.922435] RIP: 0010:__pv_queued_spin_lock_slowpath+0x195/0x2a0
> [    1.922459] Code: c4 c1 ea 12 4c 8d 6d 14 41 be 01 00 00 00 41 83 e4 03 8d 42 ff 49 c1 e4 05 48 98 49 81 c4 80 c3 02 00 4c 03 24 c5 20 89 b7 82 <49> 89 2c 24 b8 00 80 00 00 eb 15 84 c0 75 0a 41 0f b6 54 24 14 84
> [    1.922526] RSP: 0018:ffffc90000213958 EFLAGS: 00010002
> [    1.922545] RAX: 000000000000327f RBX: ffff888005ce00e0 RCX: 0000000000000001
> [    1.922574] RDX: 0000000000003280 RSI: 0000000000000000 RDI: 0000000000000000
> [    1.924268] RBP: ffff88801f52c380 R08: 00000000fffea95e R09: ffff8880192d0c80
> [    1.924302] R10: ffff8880192d0cb8 R11: ffffc90000213b01 R12: 000344a3feab7bf8
> [    1.924333] R13: ffff88801f52c394 R14: 0000000000000001 R15: 0000000000080000
> [    1.924377] FS:  00007f771d762d40(0000) GS:ffff88801f500000(0000) knlGS:0000000000000000
> [    1.924409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.924434] CR2: 00007fffaae16ec8 CR3: 0000000004b04000 CR4: 00000000000006e0
> [    1.924967] BUG: unable to handle page fault for address: 000000000013fff8
> [    1.924999] #PF: supervisor write access in kernel mode
> [    1.925020] #PF: error_code(0x0002) - not-present page
> [    1.925042] PGD 0 P4D 0
> [    1.925056] Oops: 0002 [#2] SMP NOPTI
> [    1.925073] CPU: 1 PID: 1686 Comm: systemd-udevd Tainted: G      D W         5.6.0-rc4-20200304-doflr-mac80211debug+ #1
> [    1.925128] RIP: 0010:blk_flush_plug_list+0x67/0xf0
> [    1.925149] Code: 48 89 e5 48 89 2c 24 48 89 6c 24 08 48 8b 43 10 49 39 c4 74 5c 48 8b 43 10 49 39 c4 74 23 48 8b 4b 10 48 8b 53 18 48 8b 04 24 <48> 89 69 08 48 89 0c 24 48 89 02 48 89 50 08 4c 89 63 10 4c 89 63
> [    2.013559] RSP: 0018:ffffc90000213b30 EFLAGS: 00010286
> [    2.013583] RAX: ffffc90000213b30 RBX: ffffc90000213c30 RCX: 000000000013fff0
> [    2.013615] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffc90000213c30
> [    2.013643] RBP: ffffc90000213b30 R08: 0000000000000000 R09: ffffc90000213ba0
> [    2.013673] R10: ffffffffffffffff R11: 000000000013ffff R12: ffffc90000213c40
> [    2.013701] R13: 0000000000000001 R14: dead000000000122 R15: dead000000000100
> [    2.013740] FS:  00007f771d762d40(0000) GS:ffff88801f500000(0000) knlGS:0000000000000000
> [    2.013771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.013794] CR2: 000000000013fff8 CR3: 0000000002c24000 CR4: 00000000000006e0
> [    2.013824] Call Trace:
> [    2.013844]  io_schedule_prepare+0x37/0x40
> [    2.013863]  io_schedule+0x6/0x30
> [    2.013880]  __lock_page+0x11d/0x1e0
> [    2.013898]  ? file_fdatawait_range+0x20/0x20
> [    2.013919]  truncate_inode_pages_range+0x412/0x750
> [    2.013939]  ? find_get_pages_range_tag+0x7d/0x2f0
> [    2.013960]  ? __switch_to_asm+0x34/0x70
> [    2.013975]  ? __switch_to_asm+0x40/0x70
> [    2.013994]  ? __switch_to_asm+0x34/0x70
> [    2.014013]  ? pagevec_lookup_range_tag+0x1f/0x30
> [    2.014086]  ? __filemap_fdatawait_range+0x68/0xe0
> [    2.014112]  ? locks_remove_flock+0xa7/0xb0
> [    2.014129]  ? __filemap_fdatawrite_range+0xdf/0x100
> [    2.014154]  ? cpumask_next_and+0x19/0x20
> [    2.014172]  ? smp_call_function_many_cond+0x24d/0x2a0
> [    2.014192]  ? __brelse+0x20/0x20
> [    2.014207]  ? __ia32_sys_fsconfig+0x430/0x430
> [    2.014226]  ? __brelse+0x20/0x20
> [    2.014243]  ? on_each_cpu_cond_mask+0x3e/0x80
> [    2.014263]  __blkdev_put+0x6f/0x1d0
> [    2.014280]  blkdev_close+0x1c/0x20
> [    2.014295]  __fput+0xb1/0x240
> [    2.014311]  task_work_run+0x85/0xa0
> [    2.014328]  do_exit+0x39b/0xa80
> [    2.014343]  ? ksys_read+0x54/0xd0
> [    2.014359]  rewind_stack_do_exit+0x17/0x20
> [    2.014375] Modules linked in:
> [    2.014391] CR2: 000000000013fff8
> [    2.014407] ---[ end trace baa27c3655b1ea5a ]---
> [    2.014430] RIP: 0010:__pv_queued_spin_lock_slowpath+0x195/0x2a0
> [    2.014458] Code: c4 c1 ea 12 4c 8d 6d 14 41 be 01 00 00 00 41 83 e4 03 8d 42 ff 49 c1 e4 05 48 98 49 81 c4 80 c3 02 00 4c 03 24 c5 20 89 b7 82 <49> 89 2c 24 b8 00 80 00 00 eb 15 84 c0 75 0a 41 0f b6 54 24 14 84
> [    2.014531] RSP: 0018:ffffc90000213958 EFLAGS: 00010002
> [    2.014550] RAX: 000000000000327f RBX: ffff888005ce00e0 RCX: 0000000000000001
> [    2.014578] RDX: 0000000000003280 RSI: 0000000000000000 RDI: 0000000000000000
> [    2.014605] RBP: ffff88801f52c380 R08: 00000000fffea95e R09: ffff8880192d0c80
> [    2.014632] R10: ffff8880192d0cb8 R11: ffffc90000213b01 R12: 000344a3feab7bf8
> [    2.014660] R13: ffff88801f52c394 R14: 0000000000000001 R15: 0000000000080000
> [    2.014700] FS:  00007f771d762d40(0000) GS:ffff88801f500000(0000) knlGS:0000000000000000
> [    2.014728] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.014751] CR2: 000000000013fff8 CR3: 0000000002c24000 CR4: 00000000000006e0
> [    2.014782] ------------[ cut here ]------------
> [    2.014802] WARNING: CPU: 1 PID: 1686 at kernel/exit.c:719 do_exit+0x4a/0xa80
> [    2.014830] Modules linked in:
> [    2.014854] CPU: 1 PID: 1686 Comm: systemd-udevd Tainted: G      D W         5.6.0-rc4-20200304-doflr-mac80211debug+ #1
> [    2.014888] RIP: 0010:do_exit+0x4a/0xa80
> [    2.014902] Code: 04 25 28 00 00 00 48 89 44 24 30 31 c0 e8 fe 3e 06 00 48 8b 83 a8 06 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 1c 02 00 00 <0f> 0b 65 44 8b 2d b4 03 f1 7e 41 81 e5 00 ff 1f 00 44 89 6c 24 0c
> [    2.215014] RSP: 0018:ffffc90000213ee8 EFLAGS: 00010086
> [    2.215041] RAX: ffffc90000213c30 RBX: ffff888005cdec00 RCX: 0000000000000000
> [    2.215071] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff82c72340
> [    2.215099] RBP: 0000000000000009 R08: 0000000000000228 R09: 0000000000000000
> [    2.215128] R10: 000000000000000a R11: ffffc90000213862 R12: 0000000000000009
> [    2.215158] R13: ffff888005cdec00 R14: 0000000000000046 R15: 0000000000000000
> [    2.215200] FS:  00007f771d762d40(0000) GS:ffff88801f500000(0000) knlGS:0000000000000000
> [    2.215230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.215273] CR2: 000000000013fff8 CR3: 0000000002c24000 CR4: 00000000000006e0
> [    2.215305] Call Trace:
> [    2.215326]  ? ksys_read+0x54/0xd0
> [    2.215348]  rewind_stack_do_exit+0x17/0x20
> [    2.215366] ---[ end trace baa27c3655b1ea5b ]---
> [    2.215386] Fixing recursive fault but reboot is needed!
> [    2.215414] BUG: unable to handle page fault for address: ffffffff82045e50
> 


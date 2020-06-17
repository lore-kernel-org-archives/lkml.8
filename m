Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5DBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18CC212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQUtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:49:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:49:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4B59AC2E;
        Wed, 17 Jun 2020 20:49:44 +0000 (UTC)
Date:   Wed, 17 Jun 2020 22:49:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com,
        syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com
Subject: Re: [PATCH] sched/deadline: Initialize dl_boosted
Message-ID: <20200617204939.2k7scf422tx2xvhe@beryllium.lan>
References: <20200617072919.818409-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617072919.818409-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Wed, Jun 17, 2020 at 09:29:19AM +0200, Juri Lelli wrote:
> This happens because dl_boosted flag is currently not initialized by
> __dl_clear_params() (unlike the other flags) and setup_new_dl_entity()
> finds complains about it.
> 
> Initialize dl_boosted to 0.
> 
> Reported-by: syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Tested-by: Daniel Wagner <dwagner@suse.de>

Well, as it turns I can't trigger a warning on mainline but pretty simple on
RT (5.6.14-rt7-rt):

 invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
 CPU: 1 PID: 317 Comm: 0d19f76ecda7c30 Not tainted 5.6.14-rt7-rt #2
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
 RIP: 0010:enqueue_task_dl+0x71/0x3b0
 Code: 74 28 41 83 fc 20 75 22 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4c 8d a8 b8 02 00 00 f6 c2 02 75 0c 8b 45 74 85 c0 78 2
 RSP: 0018:ffffc90000673ba8 EFLAGS: 00010002
 
 RAX: ffff88807e87a700 RBX: 00000000ffffffff RCX: 0000000000000078
 RDX: 0000000000000002 RSI: 0000000000000078 RDI: ffff88807c52bb80
 RBP: ffff88800feda700 R08: ffff88807e87a700 R09: ffffffff81e43ea0
 R10: 0000000000000000 R11: 000000000000006d R12: 000000000000002e
 R13: 0000000000000078 R14: ffff88807c52bb80 R15: ffff88800feda9b8
 FS:  000000000175c880(0000) GS:ffff88807c500000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fff9cbfa000 CR3: 000000007c4b2000 CR4: 00000000000006e0
 Call Trace:
  ? dequeue_task_fair+0x67/0x2b0
  rt_mutex_setprio+0x39f/0x510
  ? __switch_to_asm+0x34/0x70
  task_blocks_on_rt_mutex+0x2a4/0x390
  ? __switch_to_asm+0x40/0x70
  ? __switch_to_asm+0x34/0x70
  rt_spin_lock_slowlock_locked+0xb2/0x2c0
  ? _raw_spin_unlock_irq+0x1d/0x50
  ? finish_task_switch+0xa0/0x2e0
  rt_spin_lock_slowlock+0x51/0x80
  __local_bh_disable_ip+0x7f/0xa0
  hrtimer_cancel_wait_running+0x31/0x70
  hrtimer_cancel+0x1f/0x30
  futex_wait+0x1e9/0x240
  ? __hrtimer_init+0xe0/0xe0
  do_futex+0x10a/0x1d0
  __x64_sys_futex+0x134/0x162
  do_syscall_64+0x69/0x110
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x445b89
 Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 8
 RSP: 002b:00007fff9cbe2498 EFLAGS: 00000206
  ORIG_RAX: 00000000000000ca
 RAX: ffffffffffffffda RBX: 00000000004004e8 RCX: 0000000000445b89
 RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000004ca3ec
 RBP: 00007fff9cbe24e0 R08: 0000000000003fdc R09: 000000000000002d
 R10: 00007fff9cbe24b0 R11: 0000000000000206 R12: 0000000000408bb0
 R13: 0000000000000000 R14: 00000000004c8018 R15: 00000000004004e8
 Modules linked in:

This looks similar to the one reported here:

  [PATCH 0/2] Fix SCHED_DEADLINE nested priority inheritance
  https://lore.kernel.org/lkml/20191112075056.19971-1-juri.lelli@redhat.com/

Thanks,
Daniel

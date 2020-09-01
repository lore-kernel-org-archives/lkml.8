Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEB4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60178206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MASONXP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIAMKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727780AbgIAMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598961772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RDMstn0We51n8P5ZY4jtzM2xhfIApNFDF69Oa89Sftg=;
        b=MASONXP3AsrXYat6FQVRDZl73W73RZT7zBhFOoPU8+MDVKSJzX7U+1zH/D+3MjecGATHpt
        GiMLKI79Vrg2chacydSRuDQozV1lMsUL4QkrlWUv5HIRTrBF0RHUtW8qkn5SBDr6Gn6cX/
        5Q1Z9QS2c5ZxxkCPOCX6YNzF6x0bt7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-lPMu6XHCMoqVCMXDQGj-ww-1; Tue, 01 Sep 2020 08:02:38 -0400
X-MC-Unique: lPMu6XHCMoqVCMXDQGj-ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15FF98799EF;
        Tue,  1 Sep 2020 12:02:34 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45AC25DA74;
        Tue,  1 Sep 2020 12:02:18 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id E13591C02A4; Tue,  1 Sep 2020 14:02:16 +0200 (CEST)
From:   Artem Savkov <asavkov@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     threeearcat@gmail.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
Subject: [PATCH] pty: do tty_flip_buffer_push without port->lock in pty_write
Date:   Tue,  1 Sep 2020 14:01:57 +0200
Message-Id: <20200901120157.3412245-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

b6da31b2c07c "tty: Fix data race in tty_insert_flip_string_fixed_flag"
puts tty_flip_buffer_push under port->lock introducing the following
possible circular locking dependency:

[30129.876566] ======================================================
[30129.876566] WARNING: possible circular locking dependency detected
[30129.876567] 5.9.0-rc2+ #3 Tainted: G S      W
[30129.876568] ------------------------------------------------------
[30129.876568] sysrq.sh/1222 is trying to acquire lock:
[30129.876569] ffffffff92c39480 (console_owner){....}-{0:0}, at: console_unlock+0x3fe/0xa90

[30129.876572] but task is already holding lock:
[30129.876572] ffff888107cb9018 (&pool->lock/1){-.-.}-{2:2}, at: show_workqueue_state.cold.55+0x15b/0x6ca

[30129.876576] which lock already depends on the new lock.

[30129.876577] the existing dependency chain (in reverse order) is:

[30129.876578] -> #3 (&pool->lock/1){-.-.}-{2:2}:
[30129.876581]        _raw_spin_lock+0x30/0x70
[30129.876581]        __queue_work+0x1a3/0x10f0
[30129.876582]        queue_work_on+0x78/0x80
[30129.876582]        pty_write+0x165/0x1e0
[30129.876583]        n_tty_write+0x47f/0xf00
[30129.876583]        tty_write+0x3d6/0x8d0
[30129.876584]        vfs_write+0x1a8/0x650
[30129.876584]        redirected_tty_write+0x6b/0xb0
[30129.876585]        do_iter_write+0x38d/0x600
[30129.876586]        vfs_writev+0x172/0x2d0
[30129.876586]        do_writev+0x100/0x280
[30129.876587]        do_syscall_64+0x33/0x40
[30129.876587]        entry_SYSCALL_64_after_hwframe+0x44/0xa9

[30129.876588] -> #2 (&port->lock#2){-.-.}-{2:2}:
[30129.876590]        _raw_spin_lock_irqsave+0x3b/0x80
[30129.876591]        tty_port_tty_get+0x1d/0xb0
[30129.876592]        tty_port_default_wakeup+0xb/0x30
[30129.876592]        serial8250_tx_chars+0x3d6/0x970
[30129.876593]        serial8250_handle_irq.part.12+0x216/0x380
[30129.876593]        serial8250_default_handle_irq+0x82/0xe0
[30129.876594]        serial8250_interrupt+0xdd/0x1b0
[30129.876595]        __handle_irq_event_percpu+0xfc/0x850
[30129.876595]        handle_irq_event_percpu+0x73/0x150
[30129.876596]        handle_irq_event+0xa1/0x12d
[30129.876596]        handle_edge_irq+0x201/0xa30
[30129.876597]        asm_call_on_stack+0x12/0x20
[30129.876597]        common_interrupt+0x108/0x1d0
[30129.876598]        asm_common_interrupt+0x1e/0x40
[30129.876599]        cpuidle_enter_state+0x116/0xe90
[30129.876599]        cpuidle_enter+0x4a/0xa0
[30129.876600]        do_idle+0x4d6/0x610
[30129.876600]        cpu_startup_entry+0x19/0x1b
[30129.876601]        start_secondary+0x2c6/0x3a0
[30129.876602]        secondary_startup_64+0xb6/0xc0

[30129.876602] -> #1 (&port->lock){-.-.}-{2:2}:
[30129.876605]        _raw_spin_lock_irqsave+0x3b/0x80
[30129.876605]        serial8250_console_write+0x12d/0x900
[30129.876606]        console_unlock+0x679/0xa90
[30129.876606]        register_console+0x371/0x6e0
[30129.876607]        univ8250_console_init+0x24/0x27
[30129.876607]        console_init+0x2f9/0x45e
[30129.876608]        start_kernel+0x28a/0x3e9
[30129.876608]        secondary_startup_64+0xb6/0xc0

[30129.876609] -> #0 (console_owner){....}-{0:0}:
[30129.876611]        __lock_acquire+0x2f70/0x4e90
[30129.876612]        lock_acquire+0x1ac/0xad0
[30129.876612]        console_unlock+0x460/0xa90
[30129.876613]        vprintk_emit+0x130/0x420
[30129.876613]        printk+0x9f/0xc5
[30129.876614]        show_pwq+0x154/0x618
[30129.876615]        show_workqueue_state.cold.55+0x193/0x6ca
[30129.876615]        __handle_sysrq+0x244/0x460
[30129.876616]        write_sysrq_trigger+0x48/0x4a
[30129.876616]        proc_reg_write+0x1a6/0x240
[30129.876617]        vfs_write+0x1a8/0x650
[30129.876617]        ksys_write+0xf1/0x1c0
[30129.876618]        do_syscall_64+0x33/0x40
[30129.876619]        entry_SYSCALL_64_after_hwframe+0x44/0xa9

[30129.876619] other info that might help us debug this:

[30129.876620] Chain exists of:
[30129.876621]   console_owner --> &port->lock#2 --> &pool->lock/1

[30129.876625]  Possible unsafe locking scenario:

[30129.876626]        CPU0                    CPU1
[30129.876626]        ----                    ----
[30129.876627]   lock(&pool->lock/1);
[30129.876628]                                lock(&port->lock#2);
[30129.876630]                                lock(&pool->lock/1);
[30129.876631]   lock(console_owner);

[30129.876633]  *** DEADLOCK ***

[30129.876634] 5 locks held by sysrq.sh/1222:
[30129.876634]  #0: ffff8881d3ce0470 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x359/0x650
[30129.876637]  #1: ffffffff92c612c0 (rcu_read_lock){....}-{1:2}, at: __handle_sysrq+0x4d/0x460
[30129.876640]  #2: ffffffff92c612c0 (rcu_read_lock){....}-{1:2}, at: show_workqueue_state+0x5/0xf0
[30129.876642]  #3: ffff888107cb9018 (&pool->lock/1){-.-.}-{2:2}, at: show_workqueue_state.cold.55+0x15b/0x6ca
[30129.876645]  #4: ffffffff92c39980 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x123/0x420

[30129.876648] stack backtrace:
[30129.876649] CPU: 3 PID: 1222 Comm: sysrq.sh Tainted: G S      W         5.9.0-rc2+ #3
[30129.876649] Hardware name: Intel Corporation 2012 Client Platform/Emerald Lake 2, BIOS ACRVMBY1.86C.0078.P00.1201161002 01/16/2012
[30129.876650] Call Trace:
[30129.876650]  dump_stack+0x9d/0xe0
[30129.876651]  check_noncircular+0x34f/0x410
[30129.876652]  ? print_circular_bug+0x360/0x360
[30129.876652]  ? mark_lock+0x144/0x19e0
[30129.876653]  ? sched_clock+0x5/0x10
[30129.876653]  __lock_acquire+0x2f70/0x4e90
[30129.876654]  ? lockdep_hardirqs_on_prepare+0x4e0/0x4e0
[30129.876654]  ? sched_clock+0x5/0x10
[30129.876655]  ? sched_clock_cpu+0x18/0x1d0
[30129.876655]  ? find_held_lock+0x3a/0x1c0
[30129.876656]  lock_acquire+0x1ac/0xad0
[30129.876656]  ? console_unlock+0x3fe/0xa90
[30129.876657]  ? lock_downgrade+0x730/0x730
[30129.876657]  ? rcu_read_unlock+0x50/0x50
[30129.876658]  console_unlock+0x460/0xa90
[30129.876658]  ? console_unlock+0x3fe/0xa90
[30129.876659]  ? __down_trylock_console_sem+0x76/0x80
[30129.876660]  vprintk_emit+0x130/0x420
[30129.876660]  printk+0x9f/0xc5
[30129.876661]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
[30129.876661]  show_pwq+0x154/0x618
[30129.876662]  show_workqueue_state.cold.55+0x193/0x6ca
[30129.876662]  ? printk+0x9f/0xc5
[30129.876663]  ? print_worker_info+0x260/0x260
[30129.876663]  ? debug_show_all_locks+0x1f2/0x209
[30129.876664]  __handle_sysrq+0x244/0x460
[30129.876665]  write_sysrq_trigger+0x48/0x4a
[30129.876665]  proc_reg_write+0x1a6/0x240
[30129.876666]  vfs_write+0x1a8/0x650
[30129.876666]  ksys_write+0xf1/0x1c0
[30129.876667]  ? __ia32_sys_read+0xb0/0xb0
[30129.876667]  ? syscall_enter_from_user_mode+0x2a/0x2b0
[30129.876668]  do_syscall_64+0x33/0x40
[30129.876669]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[30129.876669] RIP: 0033:0x7f0446ab28a8
[30129.876671] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 b5 4c 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[30129.876671] RSP: 002b:00007fff991890c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[30129.876672] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0446ab28a8
[30129.876673] RDX: 0000000000000002 RSI: 000055887dae8e00 RDI: 0000000000000001
[30129.876674] RBP: 000055887dae8e00 R08: 000000000000000a R09: 00007f0446b42d40
[30129.876674] R10: 000000000000000a R11: 0000000000000246 R12: 00007f0446d836c0
[30129.876675] R13: 0000000000000002 R14: 00007f0446d7e880 R15: 0000000000000002

It looks like the commit was aimed to protect tty_insert_flip_string and
there is no need for tty_flip_buffer_push to be under this lock.

Fixes: b6da31b2c07c ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 drivers/tty/pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 00099a8439d2..c6a1d8c4e689 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -120,10 +120,10 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 		spin_lock_irqsave(&to->port->lock, flags);
 		/* Stuff the data into the input queue of the other end */
 		c = tty_insert_flip_string(to->port, buf, c);
+		spin_unlock_irqrestore(&to->port->lock, flags);
 		/* And shovel */
 		if (c)
 			tty_flip_buffer_push(to->port);
-		spin_unlock_irqrestore(&to->port->lock, flags);
 	}
 	return c;
 }
-- 
2.26.2


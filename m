Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E716BC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CC22078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBscqpYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIBMBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:01:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34249 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726323AbgIBMBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599048073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+i5zXtq4ux6xumm7neNL18B4gGaHkGZL55H7R7cdGek=;
        b=SBscqpYPxVxk5gmJDpEDU8K8RxfOIsvHXpoOWhE6jqlbVggMKPcDQaVAIUJEzxNX8YPUKS
        jY1LRAfACyRGvysX4txx44Xd8KUYiPvmOeXVf3lmmUmcO87yl+pyjRPbjhd02tsVva/nef
        HrOoyBSk4P5Ba126jg3bB2E71kuiZ9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-jysMdq6mOCSDLVMDbGC3kg-1; Wed, 02 Sep 2020 08:01:04 -0400
X-MC-Unique: jysMdq6mOCSDLVMDbGC3kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAFFD10ABDC7;
        Wed,  2 Sep 2020 12:01:02 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F61A7C609;
        Wed,  2 Sep 2020 12:01:02 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id 1DCA61C0276; Wed,  2 Sep 2020 14:01:01 +0200 (CEST)
From:   Artem Savkov <asavkov@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, threeearcat@gmail.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v2] pty: do tty_flip_buffer_push without port->lock in pty_write
Date:   Wed,  2 Sep 2020 14:00:45 +0200
Message-Id: <20200902120045.3693075-1-asavkov@redhat.com>
In-Reply-To: <f1d3a7a1-fd03-80a0-78fa-83e905e29337@kernel.org>
References: <f1d3a7a1-fd03-80a0-78fa-83e905e29337@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

[30129.876588] -> #2 (&port->lock#2){-.-.}-{2:2}:
[30129.876590]        _raw_spin_lock_irqsave+0x3b/0x80
[30129.876591]        tty_port_tty_get+0x1d/0xb0
[30129.876592]        tty_port_default_wakeup+0xb/0x30
[30129.876592]        serial8250_tx_chars+0x3d6/0x970
[30129.876593]        serial8250_handle_irq.part.12+0x216/0x380
[30129.876593]        serial8250_default_handle_irq+0x82/0xe0
[30129.876594]        serial8250_interrupt+0xdd/0x1b0
[30129.876595]        __handle_irq_event_percpu+0xfc/0x850

[30129.876602] -> #1 (&port->lock){-.-.}-{2:2}:
[30129.876605]        _raw_spin_lock_irqsave+0x3b/0x80
[30129.876605]        serial8250_console_write+0x12d/0x900
[30129.876606]        console_unlock+0x679/0xa90
[30129.876606]        register_console+0x371/0x6e0
[30129.876607]        univ8250_console_init+0x24/0x27
[30129.876607]        console_init+0x2f9/0x45e

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
[30129.876653]  __lock_acquire+0x2f70/0x4e90
[30129.876656]  lock_acquire+0x1ac/0xad0
[30129.876658]  console_unlock+0x460/0xa90
[30129.876660]  vprintk_emit+0x130/0x420
[30129.876660]  printk+0x9f/0xc5
[30129.876661]  show_pwq+0x154/0x618
[30129.876662]  show_workqueue_state.cold.55+0x193/0x6ca
[30129.876664]  __handle_sysrq+0x244/0x460
[30129.876665]  write_sysrq_trigger+0x48/0x4a
[30129.876665]  proc_reg_write+0x1a6/0x240
[30129.876666]  vfs_write+0x1a8/0x650

It looks like the commit was aimed to protect tty_insert_flip_string and
there is no need for tty_flip_buffer_push to be under this lock.

Fixes: b6da31b2c07c ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Acked-by: Jiri Slaby <jirislaby@kernel.org>
---

v2: trimmed stack traces in commit message.

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


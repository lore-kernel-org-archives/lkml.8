Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F52C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C147206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgFWHUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbgFWHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:19:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B7BC061573;
        Tue, 23 Jun 2020 00:19:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jndDb-0003Bz-Go; Tue, 23 Jun 2020 09:19:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E6C001C04E3;
        Tue, 23 Jun 2020 09:19:42 +0200 (CEST)
Date:   Tue, 23 Jun 2020 07:19:42 -0000
From:   "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Initialize dl_boosted
Cc:     syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com,
        Juri Lelli <juri.lelli@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200617072919.818409-1-juri.lelli@redhat.com>
References: <20200617072919.818409-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Message-ID: <159289678269.16989.6418331552606466271.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5bf857422d6b36b1edff43348054edd3379d069d
Gitweb:        https://git.kernel.org/tip/5bf857422d6b36b1edff43348054edd3379d069d
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Wed, 17 Jun 2020 09:29:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Jun 2020 20:51:05 +02:00

sched/deadline: Initialize dl_boosted

syzbot reported the following warning:

  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 setup_new_dl_entity /kernel/sched/deadline.c:594 [inline]
  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 enqueue_dl_entity /kernel/sched/deadline.c:1370 [inline]
  WARNING: CPU: 0 PID: 6973 at kernel/sched/deadline.c:593 enqueue_task_dl+0x1c17/0x2ba0 /kernel/sched/deadline.c:1441
  Kernel panic - not syncing: panic_on_warn set ...

  CPU: 0 PID: 6973 Comm: syz-executor366 Not tainted 4.14.133 #28
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  Call Trace:
   __dump_stack /lib/dump_stack.c:17 [inline]
   dump_stack+0x138/0x19c /lib/dump_stack.c:53
   panic+0x1f2/0x426 /kernel/panic.c:182
   __warn.cold+0x2f/0x36 /kernel/panic.c:546
   report_bug+0x216/0x254 /lib/bug.c:186
   fixup_bug /arch/x86/kernel/traps.c:177 [inline]
   fixup_bug /arch/x86/kernel/traps.c:172 [inline]
   do_error_trap+0x1bb/0x310 /arch/x86/kernel/traps.c:295
   do_invalid_op+0x1b/0x20 /arch/x86/kernel/traps.c:314
   invalid_op+0x1b/0x40 /arch/x86/entry/entry_64.S:960
  RIP: 0010:setup_new_dl_entity /kernel/sched/deadline.c:593 [inline]
  RIP: 0010:enqueue_dl_entity /kernel/sched/deadline.c:1370 [inline]
  RIP: 0010:enqueue_task_dl+0x1c17/0x2ba0 /kernel/sched/deadline.c:1441
  RSP: 0018:ffff888098a3fcd8 EFLAGS: 00010002
  RAX: 0000000000000000 RBX: ffffffff87ab2780 RCX: 1ffff1101041413a
  RDX: 0000000ad48fb497 RSI: ffff8880aee2c518 RDI: ffff8880820a09d0
  RBP: ffff888098a3fd48 R08: ffff8880820a09cc R09: ffff8880820a09c0
  R10: ffff8880820a073c R11: 0000000000000001 R12: ffff8880820a0700
  R13: ffff8880aee2c500 R14: ffff8880820a0978 R15: ffff8880aee2c500
   enqueue_task /kernel/sched/core.c:762 [inline]
   __sched_setscheduler+0xd17/0x2510 /kernel/sched/core.c:4227
   sched_setattr /kernel/sched/core.c:4285 [inline]
   SYSC_sched_setattr /kernel/sched/core.c:4456 [inline]
   SyS_sched_setattr+0x1f8/0x300 /kernel/sched/core.c:4435
   do_syscall_64+0x1e8/0x640 /arch/x86/entry/common.c:292
   entry_SYSCALL_64_after_hwframe+0x42/0xb7
  RIP: 0033:0x446749
  RSP: 002b:00007ff022092db8 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
  RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446749
  RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
  RBP: 00000000006dbc30 R08: 00007ff022093700 R09: 0000000000000000
  R10: 00007ff022093700 R11: 0000000000000246 R12: 00000000006dbc3c
  R13: 00007ffdbf86bf7f R14: 00007ff0220939c0 R15: 0000000000000000

This happens because dl_boosted flag is currently not initialized by
__dl_clear_params() (unlike the other flags) and setup_new_dl_entity()
finds complains about it.

Initialize dl_boosted to 0.

Fixes: 2d3d891d3344 ("sched/deadline: Add SCHED_DEADLINE inheritance logic")
Reported-by: syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Daniel Wagner <dwagner@suse.de>
Link: https://lkml.kernel.org/r/20200617072919.818409-1-juri.lelli@redhat.com
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f5..f63f337 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2692,6 +2692,7 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_bw			= 0;
 	dl_se->dl_density		= 0;
 
+	dl_se->dl_boosted		= 0;
 	dl_se->dl_throttled		= 0;
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;

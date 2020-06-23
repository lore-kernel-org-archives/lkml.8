Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78564C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6F5206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgFWHT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbgFWHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:19:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF8C061573;
        Tue, 23 Jun 2020 00:19:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jndDb-0003Bp-0J; Tue, 23 Jun 2020 09:19:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 94F241C0478;
        Tue, 23 Jun 2020 09:19:42 +0200 (CEST)
Date:   Tue, 23 Jun 2020 07:19:42 -0000
From:   "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix PI boosting between RT and DEADLINE
Cc:     syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com,
        Juri Lelli <juri.lelli@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20181119153201.GB2119@localhost.localdomain>
References: <20181119153201.GB2119@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <159289678229.16989.5920690414185562124.tip-bot2@tip-bot2>
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

Commit-ID:     195819207674143c790809f97f96102c7fada077
Gitweb:        https://git.kernel.org/tip/195819207674143c790809f97f96102c7fada077
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Mon, 19 Nov 2018 16:32:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Jun 2020 20:51:06 +02:00

sched/core: Fix PI boosting between RT and DEADLINE

syzbot reported the following warning:

 WARNING: CPU: 1 PID: 6351 at kernel/sched/deadline.c:628
 enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
 PM: Basic memory bitmaps freed
 Kernel panic - not syncing: panic_on_warn set ...
 CPU: 1 PID: 6351 Comm: syz-executor0 Not tainted 4.20.0-rc2+ #338
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
 Google 01/01/2011
 Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0x244/0x39d lib/dump_stack.c:113
   panic+0x2ad/0x55c kernel/panic.c:188
   __warn.cold.8+0x20/0x45 kernel/panic.c:540
   report_bug+0x254/0x2d0 lib/bug.c:186
   fixup_bug arch/x86/kernel/traps.c:178 [inline]
   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
   do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
 RIP: 0010:enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
 Code: ff 48 8b 8d c8 fe ff ff 48 c1 e6 2a 4c 8b 9d d0 fe ff ff 8b 95 d8 fe
 ff ff 48 8b 85 e0 fe ff ff e9 16 e4 ff ff e8 16 d0 ea ff <0f> 0b e9 17 f1
 ff ff 48 8b bd e8 fe ff ff 4c 89 95 c8 fe ff ff 48
 RSP: 0018:ffff8881ba39fa18 EFLAGS: 00010002
 RAX: 0000000000000000 RBX: ffff8881b9d6c000 RCX: ffff8881b9d6c278
 RDX: ffff8881b9d6c03c RSI: 0000000000000002 RDI: ffff8881daf2d710
 RBP: ffff8881ba39fb78 R08: 0000000000000001 R09: ffff8881daf00000
 R10: 0000001a4d4f1987 R11: ffff8881daf2db3b R12: 1ffff11037473f4e
 R13: ffff8881b9d6c2cc R14: ffff8881daf2ccc0 R15: ffff8881daf2ccc0
   enqueue_task+0x184/0x390 kernel/sched/core.c:730
   __sched_setscheduler+0xe99/0x2190 kernel/sched/core.c:4336
   sched_setattr kernel/sched/core.c:4394 [inline]
   __do_sys_sched_setattr kernel/sched/core.c:4570 [inline]
   __se_sys_sched_setattr kernel/sched/core.c:4549 [inline]
   __x64_sys_sched_setattr+0x1b2/0x2f0 kernel/sched/core.c:4549
   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x457569
 Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
 ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
 RSP: 002b:00007f05ce0a2c78 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
 RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
 RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 00007f05ce0a36d4
 R13: 00000000004c369f R14: 00000000004d5730 R15: 00000000ffffffff

At deadline.c:628 we have:

 623 static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 624 {
 625 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 626 	struct rq *rq = rq_of_dl_rq(dl_rq);
 627
 628 	WARN_ON(dl_se->dl_boosted);
 629 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
        [...]
     }

Which means that setup_new_dl_entity() has been called on a task
currently boosted. This shouldn't happen though, as setup_new_
dl_entity() is only called when the 'dynamic' deadline of the new entity
is in the past w.r.t. rq_clock and boosted tasks shouldn't verify this
condition.

Digging through PI code I noticed that what above might in fact happen
if an RT tasks blocks on an rt_mutex hold by a DEADLINE task. In the
first branch of boosting conditions we check only if a pi_task 'dynamic'
deadline is earlier than mutex holder's and in this case we set mutex
holder to be dl_boosted. However, since RT 'dynamic' deadlines are only
initialized if such tasks get boosted at some point (or if they become
DEADLINE of course), in general RT 'dynamic' deadlines are usually equal
to 0 and this verifies the aforementioned condition.

Fix it by checking that the potential donor task is actually (even if
temporary because in turn boosted) running at DEADLINE priority before
using its 'dynamic' deadline value.

Fixes: 2d3d891d3344 ("sched/deadline: Add SCHED_DEADLINE inheritance logic")
Reported-by: syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
Link: https://lkml.kernel.org/r/20181119153201.GB2119@localhost.localdomain
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9f8aa34..1f79d76 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4534,7 +4534,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 */
 	if (dl_prio(prio)) {
 		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
+		    (pi_task && dl_prio(pi_task->prio) &&
+		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
 			p->dl.dl_boosted = 1;
 			queue_flag |= ENQUEUE_REPLENISH;
 		} else

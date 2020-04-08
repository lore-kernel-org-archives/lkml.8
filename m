Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C46C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B8520820
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586364419;
	bh=ve52H2W5EPKeN82rxmcLrZY8qgzzE3IJXUwFp5JZpw0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sf0OMNlV7Rj/kd8pzyyns/TtHK5M31X95OvRQ7NFx1VvWgzls6ruwMbnoO+W1fUi2
	 AD6vDChB58aHkYF04YQPPGArW7bJKEbzZ8n9yvg7GCctgqjDAAQPGdImKTDdk/oULw
	 YS2dMhGlYZEufFJwTgFtVJYw8TbO6mqYtM0oFiTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgDHQq6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:46:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728525AbgDHQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:46:58 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-ahXLIbFJMi6Afe24VaB58g-1; Wed, 08 Apr 2020 12:46:50 -0400
X-MC-Unique: ahXLIbFJMi6Afe24VaB58g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A2BB2EE3;
        Wed,  8 Apr 2020 16:46:46 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.196.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EE2E5C3FA;
        Wed,  8 Apr 2020 16:46:44 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
Subject: [RFC] kretprobe: Prevent triggering kretprobe from within kprobe_flush_task
Date:   Wed,  8 Apr 2020 18:46:41 +0200
Message-Id: <20200408164641.3299633-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Ziqian reported lockup when adding retprobe on _raw_spin_lock_irqsave.
My test was also able to trigger lockdep output:

 ============================================
 WARNING: possible recursive locking detected
 5.6.0-rc6+ #6 Not tainted
 --------------------------------------------
 sched-messaging/2767 is trying to acquire lock:
 ffffffff9a492798 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_hash_lock+0x52/0xa0

 but task is already holding lock:
 ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&(kretprobe_table_locks[i].lock));
   lock(&(kretprobe_table_locks[i].lock));

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 1 lock held by sched-messaging/2767:
  #0: ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50

 stack backtrace:
 CPU: 3 PID: 2767 Comm: sched-messaging Not tainted 5.6.0-rc6+ #6
 Call Trace:
  dump_stack+0x96/0xe0
  __lock_acquire.cold.57+0x173/0x2b7
  ? native_queued_spin_lock_slowpath+0x42b/0x9e0
  ? lockdep_hardirqs_on+0x590/0x590
  ? __lock_acquire+0xf63/0x4030
  lock_acquire+0x15a/0x3d0
  ? kretprobe_hash_lock+0x52/0xa0
  _raw_spin_lock_irqsave+0x36/0x70
  ? kretprobe_hash_lock+0x52/0xa0
  kretprobe_hash_lock+0x52/0xa0
  trampoline_handler+0xf8/0x940
  ? kprobe_fault_handler+0x380/0x380
  ? find_held_lock+0x3a/0x1c0
  kretprobe_trampoline+0x25/0x50
  ? lock_acquired+0x392/0xbc0
  ? _raw_spin_lock_irqsave+0x50/0x70
  ? __get_valid_kprobe+0x1f0/0x1f0
  ? _raw_spin_unlock_irqrestore+0x3b/0x40
  ? finish_task_switch+0x4b9/0x6d0
  ? __switch_to_asm+0x34/0x70
  ? __switch_to_asm+0x40/0x70

The code within the kretprobe handler checks for probe reentrancy,
so we won't trigger any _raw_spin_lock_irqsave probe in there.

The problem is in outside kprobe_flush_task, where we call:

  kprobe_flush_task
    kretprobe_table_lock
      raw_spin_lock_irqsave
        _raw_spin_lock_irqsave

where _raw_spin_lock_irqsave triggers the kretprobe and installs
kretprobe_trampoline handler on _raw_spin_lock_irqsave return.

The kretprobe_trampoline handler is then executed with already
locked kretprobe_table_locks, and first thing it does is to
lock kretprobe_table_locks ;-) the whole lockup path like:

  kprobe_flush_task
    kretprobe_table_lock
      raw_spin_lock_irqsave
        _raw_spin_lock_irqsave ---> probe triggered, kretprobe_trampoline installed

        ---> kretprobe_table_locks locked

        kretprobe_trampoline
          trampoline_handler
            kretprobe_hash_lock(current, &head, &flags);  <--- deadlock

The change below sets current_kprobe in kprobe_flush_task, so the probe
recursion protection check is hit and the probe is never set. It seems
to fix the deadlock.

I'm not sure this is the best fix, any ideas are welcome ;-)

thanks,
jirka


---
 kernel/kprobes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00..b13247cae752 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1236,6 +1236,10 @@ __releases(hlist_lock)
 }
 NOKPROBE_SYMBOL(kretprobe_table_unlock);
 
+static struct kprobe kretprobe_dummy = {
+        .addr = (void *)kretprobe_trampoline,
+};
+
 /*
  * This function is called from finish_task_switch when task tk becomes dead,
  * so that we can recycle any function-return probe instances associated
@@ -1256,12 +1260,14 @@ void kprobe_flush_task(struct task_struct *tk)
 	INIT_HLIST_HEAD(&empty_rp);
 	hash = hash_ptr(tk, KPROBE_HASH_BITS);
 	head = &kretprobe_inst_table[hash];
+	__this_cpu_write(current_kprobe, &kretprobe_dummy);
 	kretprobe_table_lock(hash, &flags);
 	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
 		if (ri->task == tk)
 			recycle_rp_inst(ri, &empty_rp);
 	}
 	kretprobe_table_unlock(hash, &flags);
+	__this_cpu_write(current_kprobe, NULL);
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
-- 
2.25.2


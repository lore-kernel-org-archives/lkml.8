Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665FDC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3150C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="j2LjWR32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMTD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:03:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37770 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:03:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so10075424qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+inUt/WmmI597eh2nymbH3BOL/mA5fX+C9DAAZpCYV0=;
        b=j2LjWR32DU63CHYJd7xM+PPZB4i/BwEVYEHuSXMkO+GgS2Lyc4ydxUahqYnOQMsosc
         sfY/fzh8rDlPyRr8mwo3MTMeVEHYAQA7stHRIPsf0odNoeJf4V62f1ny3QdwgblF8BVJ
         gnksW2k1X05Kfg2jI8ME2pYxAzy5peK6/mibDSz2z9AWG5s6JoRlkNsrCD2LUa5RDBM0
         fUxCv/3kV96gIBgq63UomvYpMCWqcLY0rLq844aGwvpGAtWbSXqqGtKHSfrIKftbjAiX
         jMODc8sYxImHQIiFOxpCgrYI64VqMArYGRR8lCVtPX8GfkFgs5/2UZOsS2pkzh09onhY
         86Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+inUt/WmmI597eh2nymbH3BOL/mA5fX+C9DAAZpCYV0=;
        b=lKhVY2rAiln9+7pXkYwHcB3dVUS/lbAYPFA+oH7uzdO10wbCGIKOucl3k9Byq08FnE
         MvW2MumgJZXeU5XxGWFmyj1u0IUAI0P1JPJf2WsGY5bjv4qa/r8OFRFJkCkR9ixFTiC1
         bhWqnQ10UgHGuMwmTzMRTi3/aXZYqzg5vS2+yoKQBNSqClEdc8YUvF52GfNHyz9lY6C+
         ZnlaYlK5t1ohfj6rGgb2fPHuUAeg+HBy6NB8wMRIzn95bh55cdWVCTnQzTHjud33qlDb
         9NAL23hSFOxHY/lChpD6Smrp0Njbhluh/qHt4GpWUtLfahmiKEXl8GUGm37i//j08KOS
         7dtQ==
X-Gm-Message-State: APjAAAUkW3gWGycYH++fZxRMXN2WM5Bv/NmRdZs2TMxKJlFBkPnyVqy6
        YL+Y1kynxJW3AsSoTMaRrZc11w==
X-Google-Smtp-Source: APXvYqwzD68MzhfhsQmDyZdGGp10+0UPGB9aBZJ/wmrWgpbT9FsQopUFCl5/KI/PyEG/m6MUOVdvig==
X-Received: by 2002:ac8:1730:: with SMTP id w45mr9073qtj.297.1578942235143;
        Mon, 13 Jan 2020 11:03:55 -0800 (PST)
Received: from ovpn-120-31.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k29sm6154149qtu.54.2020.01.13.11.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 11:03:54 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Date:   Mon, 13 Jan 2020 14:03:31 -0500
Message-Id: <20200113190331.12788-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the CPU-offline process, it calls mmdrop() after idle entry and the
subsequent call to cpuhp_report_idle_dead(). Once execution passes the
call to rcu_report_dead(), RCU is ignoring the CPU, which results in
lockdep complaints when mmdrop() uses RCU from either memcg or
debugobjects, so it by scheduling mmdrop() on another online CPU.

According to the commit a79e53d85683 ("x86/mm: Fix pgd_lock deadlock"),
mmdrop() is not interrupt-safe, and called from
smp_call_function_single() could end up running mmdrop() from the IPI
interrupt handler.

 Call Trace:
  mmdrop+0x58/0x80
  flush_smp_call_function_queue+0x128/0x2e0
  smp_ipi_demux_relaxed+0x84/0xf0
  doorbell_exception+0x118/0x588
  h_doorbell_common+0x124/0x130
  --- interrupt: e81 at replay_interrupt_return+0x0/0x4
      LR = arch_local_irq_restore.part.8+0x78/0x90
  arch_local_irq_restore.part.8+0x34/0x90 (unreliable)
  _raw_spin_unlock_irq+0x50/0x80
  finish_task_switch+0xd8/0x340
  __schedule+0x4bc/0xba0
  schedule_idle+0x38/0x70
  do_idle+0x2a4/0x470
  cpu_startup_entry+0x3c/0x40
  start_secondary+0x7a8/0xa80
  start_secondary_resume+0x10/0x14

Therefore, use mmdrop_async() instead to run mmdrop() from a process
context similar to the commit 7283094ec3db ("kernel, oom: fix potential
pgd_lock deadlock from __mmdrop").

=============================
 WARNING: suspicious RCU usage
 -----------------------------
 kernel/workqueue.c:710 RCU or wq_pool_mutex should be held!

 other info that might help us debug this:

 RCU used illegally from offline CPU!
 rcu_scheduler_active = 2, debug_locks = 1
 2 locks held by swapper/37/0:
  #0: c0000000010af608 (rcu_read_lock){....}, at:
      percpu_ref_put_many+0x8/0x230
  #1: c0000000010af608 (rcu_read_lock){....}, at:
      __queue_work+0x7c/0xca0

 stack backtrace:
 Call Trace:
  dump_stack+0xf4/0x164 (unreliable)
  lockdep_rcu_suspicious+0x140/0x164
  get_work_pool+0x110/0x150
  __queue_work+0x1bc/0xca0
  queue_work_on+0x114/0x120
  css_release+0x9c/0xc0
  percpu_ref_put_many+0x204/0x230
  free_pcp_prepare+0x264/0x570
  free_unref_page+0x38/0xf0
  __mmdrop+0x21c/0x2c0
  idle_task_exit+0x170/0x1b0
  pnv_smp_cpu_kill_self+0x38/0x2e0
  cpu_die+0x48/0x64
  arch_cpu_idle_dead+0x30/0x50
  do_idle+0x2f4/0x470
  cpu_startup_entry+0x38/0x40
  start_secondary+0x7a8/0xa80
  start_secondary_resume+0x10/0x14

 =============================
 WARNING: suspicious RCU usage
 -----------------------------
 kernel/sched/core.c:562 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 RCU used illegally from offline CPU!
 rcu_scheduler_active = 2, debug_locks = 1
 2 locks held by swapper/94/0:
  #0: c000201cc77dc118 (&base->lock){-.-.}, at:
      lock_timer_base+0x114/0x1f0
  #1: c0000000010af608 (rcu_read_lock){....}, at:
      get_nohz_timer_target+0x3c/0x2d0

 stack backtrace:
 Call Trace:
  dump_stack+0xf4/0x164 (unreliable)
  lockdep_rcu_suspicious+0x140/0x164
  get_nohz_timer_target+0x248/0x2d0
  add_timer+0x24c/0x470
  __queue_delayed_work+0x8c/0x110
  queue_delayed_work_on+0x128/0x130
  __debug_check_no_obj_freed+0x2ec/0x320
  free_pcp_prepare+0x1b4/0x570
  free_unref_page+0x38/0xf0
  __mmdrop+0x21c/0x2c0
  idle_task_exit+0x170/0x1b0
  pnv_smp_cpu_kill_self+0x38/0x2e0
  cpu_die+0x48/0x64
  arch_cpu_idle_dead+0x30/0x50
  do_idle+0x2f4/0x470
  cpu_startup_entry+0x38/0x40
  start_secondary+0x7a8/0xa80
  start_secondary_prolog+0x10/0x14

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: use mmdrop_async() thanks to Tetsuo.

 include/linux/sched/mm.h | 2 ++
 kernel/fork.c            | 2 +-
 kernel/sched/core.c      | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c49257a3b510..205de134348c 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,8 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
+extern void mmdrop_async(struct mm_struct *mm);
+
 /*
  * This has to be called after a get_task_mm()/mmget_not_zero()
  * followed by taking the mmap_sem for writing before modifying the
diff --git a/kernel/fork.c b/kernel/fork.c
index 080809560072..9a823a955b7c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -707,7 +707,7 @@ static void mmdrop_async_fn(struct work_struct *work)
 	__mmdrop(mm);
 }
 
-static void mmdrop_async(struct mm_struct *mm)
+void mmdrop_async(struct mm_struct *mm)
 {
 	if (unlikely(atomic_dec_and_test(&mm->mm_count))) {
 		INIT_WORK(&mm->async_put_work, mmdrop_async_fn);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..1863a6fc4d82 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6194,7 +6194,8 @@ void idle_task_exit(void)
 		current->active_mm = &init_mm;
 		finish_arch_post_lock_switch();
 	}
-	mmdrop(mm);
+	smp_call_function_single(cpumask_first(cpu_online_mask),
+				 (void (*)(void *))mmdrop_async, mm, 0);
 }
 
 /*
-- 
2.21.0 (Apple Git-122.2)


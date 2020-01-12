Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF4EC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E90A21744
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NjMYJ+5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbgALQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:19:09 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32935 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733030AbgALQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:19:09 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so3028590qvn.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 08:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1b9sdYh4Lw8eu7CEGsOMiPqgRlac/bhpvMkql8QppKo=;
        b=NjMYJ+5KXZVfOYzkwc0Ze7WK6v5uFFvNyFeL+Vc3lb/Kh7MtuTU8YhfS/JyCvcpLDd
         o+LCBu7NXkvyz0NfB0nVuQGsRcWH3f6Q2VvXkF9PqnRsALvzDwXMKtzMqvsfKW9qvmjR
         NPWagWWJYjNn8ywAf/cd5zlUZN24pHRxtAEBzRyXrF6sGierWh1FI5XeKFK9sSbbyX+e
         A66dK/4f1yTvynF1NQnPTEP7d/NY9mxZlxd81cU020f7W3PpqA8iBV/1xkMTy/5LZVPh
         7GBOWn0SYVMjrjGVXbWmDhTet8yAhoAyiHbRCH/EqOY7rlRbzdkXYhTHb2SP5sDDzIPJ
         IWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1b9sdYh4Lw8eu7CEGsOMiPqgRlac/bhpvMkql8QppKo=;
        b=kO+wRKDD9VapNj9oHvf4gwFXHOVC40obpEE5I4HvXSI/xl2ioNAW46ffxqTiCR0lXY
         evE1agwPRiU1KzAeA3BV6sRLwthZAYHBivhdptkrtDylHXDFTSghHyNCNOoJ3caETPXK
         A4TYebcklVx8POjkK9BZmCTbDURh7Um5T4FdT7+IcWMIuGKJ9c25y12vxxZ+aai+uEij
         a3KvlyhNnmZgW68qs+bHHGie3vSpDan4p1pFULA6Sm3xJc7ZLHWsxPyeLTTBcTQQdt58
         k8NDVznDkx0erle7VvElJNFYki9LgHw6V+/ij/Tgp9dyqzeCRriIyGl5FMGeE7oQFPRc
         0DCw==
X-Gm-Message-State: APjAAAU37yrNRs0BLxOe6ibS0TBtbZ8hrUZW6chQ8pGwElArFTNu54MM
        o3THyNYQK3pvYKenhU0aVT6o9yRO/2TOnA==
X-Google-Smtp-Source: APXvYqw7j4sZp6njBZ/L3zU/S8gPzYfnVXBvSi07k26mwaM70PVxHhmKUaSdMeew2trIAPkPmcakVg==
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr11799658qvo.20.1578845947671;
        Sun, 12 Jan 2020 08:19:07 -0800 (PST)
Received: from ovpn-120-31.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s11sm3780302qkg.99.2020.01.12.08.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 08:19:07 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] sched/core: fix illegal RCU from offline CPUs
Date:   Sun, 12 Jan 2020 11:17:52 -0500
Message-Id: <20200112161752.10492-1-cai@lca.pw>
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
debugobjects. Fix it by scheduling mmdrop() on another online CPU.

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
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..41fb49f3dfce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6194,7 +6194,8 @@ void idle_task_exit(void)
 		current->active_mm = &init_mm;
 		finish_arch_post_lock_switch();
 	}
-	mmdrop(mm);
+	smp_call_function_single(cpumask_first(cpu_online_mask),
+				(void (*)(void *))mmdrop, mm, 0);
 }
 
 /*
-- 
2.21.0 (Apple Git-122.2)


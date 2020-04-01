Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4285BC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0917420772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="s8lq9KtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbgDAVlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:41:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33254 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbgDAVlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:41:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id v7so1840660qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0RdWMZB6RJn98FXdUSZnSjFG7Se9Mrq9epKZxJ4TlZU=;
        b=s8lq9KtNGitOmED9ThaQGTb5+/x0rpr3TJKyVHk/V41WssZvfEWTggpVH2Qs+oUCXQ
         3zhK1WERFaKh2wtJ8usMb18qkenhhMbR6eEUemwBPcyrjYt0sJ5KDo1VpH86xwfB7zid
         ugcuvNqf8khkGAEZ0WtHEHdhh0tN07ePRggoKzQa3bocnLkfVVfGKEt3fFN6lOSej2IT
         cIpt8G9f9DnV5fLPC5Ctvsc0/ghdGF018LKW6vNrTQALlHX5wZ6O+/E7rzWH7OIQ66w5
         /isdkpjq0WzlYNkOrWlcADEiGMujKBbHE+ByHfdaRm18AxBexuz/yBeUoOD1kdzWMDW9
         vabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0RdWMZB6RJn98FXdUSZnSjFG7Se9Mrq9epKZxJ4TlZU=;
        b=sBgvrFKkq45B4KGASqb0jy0otMvZRKZ6q8STNm2aTFg0BOQKTIvgHpeRGI6PZr6ugp
         YGLwNwerBNCVIfPOSA5ysxLufYM0du6W2Cc4pKly5ZSzsiR3hLzMi9aT8lqK6by/m5eV
         s7cSmslaH8DcB41kkrEwIgZ4m6if2Nc49EhMOuUgUq6Q1dkJ/1IvnM4Y5OtiQtNMac8I
         xaaeUTdJtB3e7U+J/IdMmWmi3KglR15JyHiP5X5NmaqivOg1sH1KXNTxinnIcqg2iu+d
         MU7ZFFoUZZ4tpz1GHKow58xAHpvddiGlGiZQLHZ0G26qMJCYEToDLb18eN1I9W+BtRyS
         ixpQ==
X-Gm-Message-State: AGi0Pub+85K84boB5Tlsd23p4zF+93dpPUTmtNqxoaB/muZrMrnxUczM
        lh1X5+LguJ48W2YZkAwht6fEeA==
X-Google-Smtp-Source: APiQypIxrxO6hwyk+9NdzKlR3uKKCXFELr9z5SQnOCvSSKC8X1SAAg+Q+tEpT2bf897wOLX9h+OxAg==
X-Received: by 2002:a37:87c7:: with SMTP id j190mr434836qkd.66.1585777261160;
        Wed, 01 Apr 2020 14:41:01 -0700 (PDT)
Received: from ovpn-113-105.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s56sm2456990qtk.9.2020.04.01.14.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 14:41:00 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, paulmck@kernel.org,
        tglx@linutronix.de, mpe@ellerman.id.au,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Date:   Wed,  1 Apr 2020 17:40:33 -0400
Message-Id: <20200401214033.8448-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In the CPU-offline process, it calls mmdrop() after idle entry and the
subsequent call to cpuhp_report_idle_dead(). Once execution passes the
call to rcu_report_dead(), RCU is ignoring the CPU, which results in
lockdep complaining when mmdrop() uses RCU from either memcg or
debugobjects below.

Fix it by cleaning up the active_mm state from BP instead. Every arch
which has CONFIG_HOTPLUG_CPU should have already called idle_task_exit()
from AP. The only exception is parisc because it switches them to
&init_mm unconditionally (see smp_boot_one_cpu() and smp_cpu_init()),
but the patch will still work there because it calls mmgrab(&init_mm) in
smp_cpu_init() and then should call mmdrop(&init_mm) in finish_cpu().

WARNING: suspicious RCU usage
-----------------------------
kernel/workqueue.c:710 RCU or wq_pool_mutex should be held!

other info that might help us debug this:

RCU used illegally from offline CPU!
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

<Peter to sign off here>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/powernv/smp.c |  1 -
 include/linux/sched/mm.h             |  2 ++
 kernel/cpu.c                         | 18 +++++++++++++++++-
 kernel/sched/core.c                  |  5 +++--
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 13e251699346..b2ba3e95bda7 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -167,7 +167,6 @@ static void pnv_smp_cpu_kill_self(void)
 	/* Standard hot unplug procedure */
 
 	idle_task_exit();
-	current->active_mm = NULL; /* for sanity */
 	cpu = smp_processor_id();
 	DBG("CPU%d offline\n", cpu);
 	generic_set_cpu_dead(cpu);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c49257a3b510..a132d875d351 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,8 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
+void mmdrop(struct mm_struct *mm);
+
 /*
  * This has to be called after a get_task_mm()/mmget_not_zero()
  * followed by taking the mmap_sem for writing before modifying the
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2371292f30b0..244d30544377 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3,6 +3,7 @@
  *
  * This code is licenced under the GPL.
  */
+#include <linux/sched/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/smp.h>
 #include <linux/init.h>
@@ -564,6 +565,21 @@ static int bringup_cpu(unsigned int cpu)
 	return bringup_wait_for_ap(cpu);
 }
 
+static int finish_cpu(unsigned int cpu)
+{
+	struct task_struct *idle = idle_thread_get(cpu);
+	struct mm_struct *mm = idle->active_mm;
+
+	/*
+	 * idle_task_exit() will have switched to &init_mm, now
+	 * clean up any remaining active_mm state.
+	 */
+	if (mm != &init_mm)
+		idle->active_mm = &init_mm;
+	mmdrop(mm);
+	return 0;
+}
+
 /*
  * Hotplug state machine related functions
  */
@@ -1549,7 +1565,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_BRINGUP_CPU] = {
 		.name			= "cpu:bringup",
 		.startup.single		= bringup_cpu,
-		.teardown.single	= NULL,
+		.teardown.single	= finish_cpu,
 		.cant_stop		= true,
 	},
 	/* Final state before CPU kills itself */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2694ba82874..8787958339d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6200,13 +6200,14 @@ void idle_task_exit(void)
 	struct mm_struct *mm = current->active_mm;
 
 	BUG_ON(cpu_online(smp_processor_id()));
+	BUG_ON(current != this_rq()->idle);
 
 	if (mm != &init_mm) {
 		switch_mm(mm, &init_mm, current);
-		current->active_mm = &init_mm;
 		finish_arch_post_lock_switch();
 	}
-	mmdrop(mm);
+
+	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
 /*
-- 
2.21.0 (Apple Git-122.2)


Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77AFC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939962084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCFOmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgCFOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB0-0006JX-7b; Fri, 06 Mar 2020 15:42:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 045ED1C21D6;
        Fri,  6 Mar 2020 15:42:07 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:06 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64: defconfig: enable CONFIG_SCHED_SMT
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200227191433.31994-3-valentin.schneider@arm.com>
References: <20200227191433.31994-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158350572670.28353.3510356909714591940.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6f693dd5be08237b337f557c510d99addb9eb9ec
Gitweb:        https://git.kernel.org/tip/6f693dd5be08237b337f557c510d99addb9eb9ec
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 27 Feb 2020 19:14:33 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:23 +01:00

arm64: defconfig: enable CONFIG_SCHED_SMT

The (CFS) scheduler has some extra logic catering to systems with SMT, but
that logic won't be compiled in unless the above config is set.

Note that the SMT-centric codepaths are gated by the sched_smt_present
static key, and the SMT sched_domains will only survive if the platform has
SMT. As such, the only impact on !SMT platforms should be a slightly
bigger kernel - no behavioural change.

Distro kernels already enable it, which makes sense since there already are
things like ThunderX2 out in the wild. Enable it for the defconfig.

Some deltas
===========

FWIW my ELF symbol table diff looks something like this:

  NAME                                BEFORE    AFTER     DELTA
  update_sd_lb_stats.constprop.135    0         1864      +1864
  find_idlest_group.isra.115          0         1808      +1808
  update_numa_stats.isra.121          0         628       +628
  select_task_rq_fair                 3236      3732      +496
  compute_energy.isra.112             0         420       +420
  score_nearby_nodes.part.120         0         380       +380
  __update_idle_core                  0         232       +232
  nohz_balance_exit_idle.part.127     0         216       +216
  sched_slice.isra.99                 0         172       +172
  update_load_avg.part.107            0         116       +116
  wakeup_preempt_entity.isra.101      0         92        +92
  sched_cpu_activate                  340       396       +56
  pick_next_task_idle                 8         56        +48
  sched_cpu_deactivate                252       292       +40
  show_smt_active                     44        80        +36
  cpu_smt_mask                        0         28        +28
  set_next_task_idle                  4         32        +28
  task_numa_work                      680       692       +12
  cpu_smt_flags                       0         8         +8
  enqueue_task_fair                   2608      2612      +4
  wakeup_preempt_entity.isra.104      92        0         -92
  update_load_avg                     1028      932       -96
  task_numa_migrate                   1824      1728      -96
  sched_slice.isra.102                172       0         -172
  nohz_balance_exit_idle.part.130     216       0         -216
  task_numa_find_cpu                  2116      1868      -248
  score_nearby_nodes.part.123         380       0         -380
  compute_energy.isra.115             420       0         -420
  update_numa_stats.isra.124          472       0         -472
  find_idlest_group.isra.118          1808      0         -1808
  update_sd_lb_stats.constprop.138    1864      0         -1864
  ------------------------------------------------------------------
  DELTA SUM                                               +820

As for the sched_domains, this is on a hikey960:

before:
  $ cat /proc/sys/kernel/sched_domain/cpu*/domain*/name | sort | uniq
  DIE
  MC

after:
  $ cat /proc/sys/kernel/sched_domain/cpu*/domain*/name | sort | uniq
  DIE
  MC

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200227191433.31994-3-valentin.schneider@arm.com
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 905109f..3e75007 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -62,6 +62,7 @@ CONFIG_ARCH_ZX=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
+CONFIG_SCHED_SMT=y
 CONFIG_NUMA=y
 CONFIG_SECCOMP=y
 CONFIG_KEXEC=y

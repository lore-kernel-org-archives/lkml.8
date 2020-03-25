Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC19AC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3717207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgCYMGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYMGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nJ-0000hp-8M; Wed, 25 Mar 2020 13:06:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CF5261C0470;
        Wed, 25 Mar 2020 13:06:00 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:00 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Move bringup of secondary CPUs out of smp_init()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-17-qais.yousef@arm.com>
References: <20200323135110.30522-17-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796050.28353.7961406059999182214.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     b99a26593b5190fac6b5c1f81a7f8cc128a25c98
Gitweb:        https://git.kernel.org/tip/b99a26593b5190fac6b5c1f81a7f8cc128a25c98
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:51:09 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:37 +01:00

cpu/hotplug: Move bringup of secondary CPUs out of smp_init()

This is the last direct user of cpu_up() before it can become an internal
implementation detail of the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323135110.30522-17-qais.yousef@arm.com

---
 include/linux/cpu.h |  1 +
 kernel/cpu.c        | 12 ++++++++++++
 kernel/smp.c        |  9 +--------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 9dc1e89..8b295f7 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -94,6 +94,7 @@ void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
 int bringup_hibernate_cpu(unsigned int sleep_cpu);
+void bringup_nonboot_cpus(unsigned int setup_max_cpus);
 
 #else	/* CONFIG_SMP */
 #define cpuhp_tasks_frozen	0
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f803678..4783d81 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1298,6 +1298,18 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 	return 0;
 }
 
+void bringup_nonboot_cpus(unsigned int setup_max_cpus)
+{
+	unsigned int cpu;
+
+	for_each_present_cpu(cpu) {
+		if (num_online_cpus() >= setup_max_cpus)
+			break;
+		if (!cpu_online(cpu))
+			cpu_up(cpu);
+	}
+}
+
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 97f1d97..786092a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -597,20 +597,13 @@ void __init setup_nr_cpu_ids(void)
 void __init smp_init(void)
 {
 	int num_nodes, num_cpus;
-	unsigned int cpu;
 
 	idle_threads_init();
 	cpuhp_threads_init();
 
 	pr_info("Bringing up secondary CPUs ...\n");
 
-	/* FIXME: This should be done in userspace --RR */
-	for_each_present_cpu(cpu) {
-		if (num_online_cpus() >= setup_max_cpus)
-			break;
-		if (!cpu_online(cpu))
-			cpu_up(cpu);
-	}
+	bringup_nonboot_cpus(setup_max_cpus);
 
 	num_nodes = num_online_nodes();
 	num_cpus  = num_online_cpus();

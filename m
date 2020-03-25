Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAE1C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC6D20771
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCYMGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47739 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgCYMGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nN-0000kc-21; Wed, 25 Mar 2020 13:06:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 906AE1C0450;
        Wed, 25 Mar 2020 13:06:04 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:04 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Provide bringup_hibernate_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-9-qais.yousef@arm.com>
References: <20200323135110.30522-9-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796426.28353.8056419656819969368.tip-bot2@tip-bot2>
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

Commit-ID:     d720f98604391dab6aa3cb4c1bc005ed1aba4703
Gitweb:        https://git.kernel.org/tip/d720f98604391dab6aa3cb4c1bc005ed1aba4703
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:51:01 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:34 +01:00

cpu/hotplug: Provide bringup_hibernate_cpu()

arm64 uses cpu_up() in the resume from hibernation code to ensure that the
CPU on which the system hibernated is online. Provide a core function for
this.

[ tglx: Split out from the combo arm64 patch ]

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200323135110.30522-9-qais.yousef@arm.com

---
 include/linux/cpu.h |  1 +
 kernel/cpu.c        | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 64a246e..9dc1e89 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -93,6 +93,7 @@ int add_cpu(unsigned int cpu);
 void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
+int bringup_hibernate_cpu(unsigned int sleep_cpu);
 
 #else	/* CONFIG_SMP */
 #define cpuhp_tasks_frozen	0
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 03c7271..f803678 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,6 +1275,29 @@ int add_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(add_cpu);
 
+/**
+ * bringup_hibernate_cpu - Bring up the CPU that we hibernated on
+ * @sleep_cpu: The cpu we hibernated on and should be brought up.
+ *
+ * On some architectures like arm64, we can hibernate on any CPU, but on
+ * wake up the CPU we hibernated on might be offline as a side effect of
+ * using maxcpus= for example.
+ */
+int bringup_hibernate_cpu(unsigned int sleep_cpu)
+{
+	int ret;
+
+	if (!cpu_online(sleep_cpu)) {
+		pr_info("Hibernated on a CPU that is offline! Bringing CPU up.\n");
+		ret = cpu_up(sleep_cpu);
+		if (ret) {
+			pr_err("Failed to bring hibernate-CPU up!\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 

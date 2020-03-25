Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0F5C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAF92077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgCYMGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47773 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgCYMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nS-0000n7-JN; Wed, 25 Mar 2020 13:06:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D6DFC1C0494;
        Wed, 25 Mar 2020 13:06:07 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:07 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Add new {add,remove}_cpu() functions
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-2-qais.yousef@arm.com>
References: <20200323135110.30522-2-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796741.28353.9870731979863465160.tip-bot2@tip-bot2>
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

Commit-ID:     93ef1429e556f739a208e3968883ed51480580e8
Gitweb:        https://git.kernel.org/tip/93ef1429e556f739a208e3968883ed51480580e8
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:50:54 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:31 +01:00

cpu/hotplug: Add new {add,remove}_cpu() functions

The new functions use device_{online,offline}() which are userspace safe.

This is in preparation to move cpu_{up, down} kernel users to use a safer
interface that is not racy with userspace.

Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20200323135110.30522-2-qais.yousef@arm.com

---
 include/linux/cpu.h |  2 ++
 kernel/cpu.c        | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 1ca2baf..cf8cf38 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -89,6 +89,7 @@ extern ssize_t arch_cpu_release(const char *, size_t);
 #ifdef CONFIG_SMP
 extern bool cpuhp_tasks_frozen;
 int cpu_up(unsigned int cpu);
+int add_cpu(unsigned int cpu);
 void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
@@ -118,6 +119,7 @@ extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int cpu_down(unsigned int cpu);
+int remove_cpu(unsigned int cpu);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af..069802f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1057,6 +1057,18 @@ int cpu_down(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpu_down);
 
+int remove_cpu(unsigned int cpu)
+{
+	int ret;
+
+	lock_device_hotplug();
+	ret = device_offline(get_cpu_device(cpu));
+	unlock_device_hotplug();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(remove_cpu);
+
 #else
 #define takedown_cpu		NULL
 #endif /*CONFIG_HOTPLUG_CPU*/
@@ -1209,6 +1221,18 @@ int cpu_up(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpu_up);
 
+int add_cpu(unsigned int cpu)
+{
+	int ret;
+
+	lock_device_hotplug();
+	ret = device_online(get_cpu_device(cpu));
+	unlock_device_hotplug();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(add_cpu);
+
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 

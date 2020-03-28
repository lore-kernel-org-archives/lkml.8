Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63D6C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80530206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgC1M0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:26:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55760 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1M0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:26:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIAXb-0004vL-Bk; Sat, 28 Mar 2020 13:26:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E0D691C0470;
        Sat, 28 Mar 2020 13:26:18 +0100 (CET)
Date:   Sat, 28 Mar 2020 12:26:18 -0000
From:   "tip-bot2 for Clark Williams" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] thermal/x86_pkg_temp: Make pkg_temp_lock a raw_spinlock_t
Cc:     Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191008110021.2j44ayunal7fkb7i@linutronix.de>
References: <20191008110021.2j44ayunal7fkb7i@linutronix.de>
MIME-Version: 1.0
Message-ID: <158539837851.28353.12926101418295280116.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fc32150e6f43d6cb93ea75937bb6a88a1764cc37
Gitweb:        https://git.kernel.org/tip/fc32150e6f43d6cb93ea75937bb6a88a1764cc37
Author:        Clark Williams <williams@redhat.com>
AuthorDate:    Tue, 08 Oct 2019 13:00:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Mar 2020 13:21:08 +01:00

thermal/x86_pkg_temp: Make pkg_temp_lock a raw_spinlock_t

The pkg_temp_lock spinlock is acquired in the thermal vector handler which
is truly atomic context even on PREEMPT_RT kernels.

The critical sections are tiny, so change it to a raw spinlock.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191008110021.2j44ayunal7fkb7i@linutronix.de
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index ddb4a97..e18758a 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -63,7 +63,7 @@ static int max_id __read_mostly;
 /* Array of zone pointers */
 static struct zone_device **zones;
 /* Serializes interrupt notification, work and hotplug */
-static DEFINE_SPINLOCK(pkg_temp_lock);
+static DEFINE_RAW_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
 static DEFINE_MUTEX(thermal_zone_mutex);
 
@@ -266,12 +266,12 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	u64 msr_val, wr_val;
 
 	mutex_lock(&thermal_zone_mutex);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	++pkg_work_cnt;
 
 	zonedev = pkg_temp_thermal_get_dev(cpu);
 	if (!zonedev) {
-		spin_unlock_irq(&pkg_temp_lock);
+		raw_spin_unlock_irq(&pkg_temp_lock);
 		mutex_unlock(&thermal_zone_mutex);
 		return;
 	}
@@ -285,7 +285,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 
 	enable_pkg_thres_interrupt();
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/*
 	 * If tzone is not NULL, then thermal_zone_mutex will prevent the
@@ -310,7 +310,7 @@ static int pkg_thermal_notify(u64 msr_val)
 	struct zone_device *zonedev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pkg_temp_lock, flags);
+	raw_spin_lock_irqsave(&pkg_temp_lock, flags);
 	++pkg_interrupt_cnt;
 
 	disable_pkg_thres_interrupt();
@@ -322,7 +322,7 @@ static int pkg_thermal_notify(u64 msr_val)
 		pkg_thermal_schedule_work(zonedev->cpu, &zonedev->work);
 	}
 
-	spin_unlock_irqrestore(&pkg_temp_lock, flags);
+	raw_spin_unlock_irqrestore(&pkg_temp_lock, flags);
 	return 0;
 }
 
@@ -368,9 +368,9 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	      zonedev->msr_pkg_therm_high);
 
 	cpumask_set_cpu(cpu, &zonedev->cpumask);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	zones[id] = zonedev;
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 	return 0;
 }
 
@@ -407,7 +407,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	}
 
 	/* Protect against work and interrupts */
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 
 	/*
 	 * Check whether this cpu was the current target and store the new
@@ -439,9 +439,9 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 		 * To cancel the work we need to drop the lock, otherwise
 		 * we might deadlock if the work needs to be flushed.
 		 */
-		spin_unlock_irq(&pkg_temp_lock);
+		raw_spin_unlock_irq(&pkg_temp_lock);
 		cancel_delayed_work_sync(&zonedev->work);
-		spin_lock_irq(&pkg_temp_lock);
+		raw_spin_lock_irq(&pkg_temp_lock);
 		/*
 		 * If this is not the last cpu in the package and the work
 		 * did not run after we dropped the lock above, then we
@@ -452,7 +452,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 			pkg_thermal_schedule_work(target, &zonedev->work);
 	}
 
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
 	if (lastcpu)

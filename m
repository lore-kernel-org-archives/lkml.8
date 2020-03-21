Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834BEC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59889208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgCUPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:53:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39020 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCUPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRY-0005Sr-TH; Sat, 21 Mar 2020 16:53:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7474C1C22EF;
        Sat, 21 Mar 2020 16:53:48 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:48 -0000
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] powerpc/ps3: Convert half completion to rcuwait
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113241.930037873@linutronix.de>
References: <20200321113241.930037873@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602810.28353.6194326413868575635.tip-bot2@tip-bot2>
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

Commit-ID:     e21fee5368f46e211bc1f3cf118f2b122d644132
Gitweb:        https://git.kernel.org/tip/e21fee5368f46e211bc1f3cf118f2b122d644132
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Sat, 21 Mar 2020 12:25:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:22 +01:00

powerpc/ps3: Convert half completion to rcuwait

The PS3 notification interrupt and kthread use a hacked up completion to
communicate. Since we're wanting to change the completion implementation and
this is abuse anyway, replace it with a simple rcuwait since there is only ever
the one waiter.

AFAICT the kthread uses TASK_INTERRUPTIBLE to not increase loadavg, kthreads
cannot receive signals by default and this one doesn't look different. Use
TASK_IDLE instead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113241.930037873@linutronix.de
---
 arch/powerpc/platforms/ps3/device-init.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 2735ec9..e87360a 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/reboot.h>
+#include <linux/rcuwait.h>
 
 #include <asm/firmware.h>
 #include <asm/lv1call.h>
@@ -670,7 +671,8 @@ struct ps3_notification_device {
 	spinlock_t lock;
 	u64 tag;
 	u64 lv1_status;
-	struct completion done;
+	struct rcuwait wait;
+	bool done;
 };
 
 enum ps3_notify_type {
@@ -712,7 +714,8 @@ static irqreturn_t ps3_notification_interrupt(int irq, void *data)
 		pr_debug("%s:%u: completed, status 0x%llx\n", __func__,
 			 __LINE__, status);
 		dev->lv1_status = status;
-		complete(&dev->done);
+		dev->done = true;
+		rcuwait_wake_up(&dev->wait);
 	}
 	spin_unlock(&dev->lock);
 	return IRQ_HANDLED;
@@ -725,12 +728,12 @@ static int ps3_notification_read_write(struct ps3_notification_device *dev,
 	unsigned long flags;
 	int res;
 
-	init_completion(&dev->done);
 	spin_lock_irqsave(&dev->lock, flags);
 	res = write ? lv1_storage_write(dev->sbd.dev_id, 0, 0, 1, 0, lpar,
 					&dev->tag)
 		    : lv1_storage_read(dev->sbd.dev_id, 0, 0, 1, 0, lpar,
 				       &dev->tag);
+	dev->done = false;
 	spin_unlock_irqrestore(&dev->lock, flags);
 	if (res) {
 		pr_err("%s:%u: %s failed %d\n", __func__, __LINE__, op, res);
@@ -738,14 +741,10 @@ static int ps3_notification_read_write(struct ps3_notification_device *dev,
 	}
 	pr_debug("%s:%u: notification %s issued\n", __func__, __LINE__, op);
 
-	res = wait_event_interruptible(dev->done.wait,
-				       dev->done.done || kthread_should_stop());
+	rcuwait_wait_event(&dev->wait, dev->done || kthread_should_stop(), TASK_IDLE);
+
 	if (kthread_should_stop())
 		res = -EINTR;
-	if (res) {
-		pr_debug("%s:%u: interrupted %s\n", __func__, __LINE__, op);
-		return res;
-	}
 
 	if (dev->lv1_status) {
 		pr_err("%s:%u: %s not completed, status 0x%llx\n", __func__,
@@ -810,6 +809,7 @@ static int ps3_probe_thread(void *data)
 	}
 
 	spin_lock_init(&dev.lock);
+	rcuwait_init(&dev.wait);
 
 	res = request_irq(irq, ps3_notification_interrupt, 0,
 			  "ps3_notification", &dev);

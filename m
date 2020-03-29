Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD314C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9652073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgC2QD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:03:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56667 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgC2QD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:03:56 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIaPh-0007ul-Cx; Sun, 29 Mar 2020 18:03:53 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A67C8FFAA7;
        Sun, 29 Mar 2020 18:03:52 +0200 (CEST)
Date:   Sun, 29 Mar 2020 16:03:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.6
Message-ID: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-03-29

up to:  df81dfcfd699: genirq: Fix reference leaks on irq affinity notifiers

A single bugfix to prevent reference leaks in irq affinity notifiers.

Thanks,

	tglx

------------------>
Edward Cree (1):
      genirq: Fix reference leaks on irq affinity notifiers


 kernel/irq/manage.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7eee98c38f25..fe40c658f86f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -323,7 +323,11 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 
 	if (desc->affinity_notify) {
 		kref_get(&desc->affinity_notify->kref);
-		schedule_work(&desc->affinity_notify->work);
+		if (!schedule_work(&desc->affinity_notify->work)) {
+			/* Work was already scheduled, drop our extra ref */
+			kref_put(&desc->affinity_notify->kref,
+				 desc->affinity_notify->release);
+		}
 	}
 	irqd_set(data, IRQD_AFFINITY_SET);
 
@@ -423,7 +427,10 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	if (old_notify) {
-		cancel_work_sync(&old_notify->work);
+		if (cancel_work_sync(&old_notify->work)) {
+			/* Pending work had a ref, put that one too */
+			kref_put(&old_notify->kref, old_notify->release);
+		}
 		kref_put(&old_notify->kref, old_notify->release);
 	}
 


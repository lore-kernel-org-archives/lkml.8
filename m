Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF778C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B371620732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCUQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:39:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39122 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCUQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:39:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFh9G-00069b-PB; Sat, 21 Mar 2020 17:38:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7E0EC1C22F0;
        Sat, 21 Mar 2020 17:38:57 +0100 (CET)
Date:   Sat, 21 Mar 2020 16:38:57 -0000
From:   "tip-bot2 for Edward Cree" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Fix reference leaks on irq affinity notifiers
Cc:     Edward Cree <ecree@solarflare.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Hutchings <ben@decadent.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com>
References: <24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com>
MIME-Version: 1.0
Message-ID: <158480873710.28353.16539727888576899465.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     df81dfcfd6991d547653d46c051bac195cd182c1
Gitweb:        https://git.kernel.org/tip/df81dfcfd6991d547653d46c051bac195cd182c1
Author:        Edward Cree <ecree@solarflare.com>
AuthorDate:    Fri, 13 Mar 2020 20:33:07 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 17:32:46 +01:00

genirq: Fix reference leaks on irq affinity notifiers

The handling of notify->work did not properly maintain notify->kref in two
 cases:
1) where the work was already scheduled, another irq_set_affinity_locked()
   would get the ref and (no-op-ly) schedule the work.  Thus when
   irq_affinity_notify() ran, it would drop the original ref but not the
   additional one.
2) when cancelling the (old) work in irq_set_affinity_notifier(), if there
   was outstanding work a ref had been got for it but was never put.
Fix both by checking the return values of the work handling functions
 (schedule_work() for (1) and cancel_work_sync() for (2)) and put the
 extra ref if the return value indicates preexisting work.

Fixes: cd7eab44e994 ("genirq: Add IRQ affinity notifiers")
Fixes: 59c39840f5ab ("genirq: Prevent use-after-free and work list corruption")
Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ben Hutchings <ben@decadent.org.uk>
Link: https://lkml.kernel.org/r/24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com

---
 kernel/irq/manage.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7eee98c..fe40c65 100644
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
 

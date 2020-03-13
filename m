Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFC4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1942073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCMUdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:33:19 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:41102 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgCMUdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:33:18 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C1B9ABC0067;
        Fri, 13 Mar 2020 20:33:16 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ukex01.SolarFlarecom.com
 (10.17.10.4) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Mar
 2020 20:33:10 +0000
From:   Edward Cree <ecree@solarflare.com>
Subject: [PATCH] genirq: fix reference leaks on irq affinity notifiers
To:     <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <ben@decadent.org.uk>,
        <psodagud@codeaurora.org>
Message-ID: <24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com>
Date:   Fri, 13 Mar 2020 20:33:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.203]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1020-25288.001
X-TM-AS-Result: No-4.513400-8.000000-10
X-TMASE-MatchedRID: zkqBtM+YTpwNvGXOmeXzxbdHEv7sR/Ow+Ln5aB/lEhkqAZlo5C3Li9xw
        X69jh9hhYle1ctMjSuwfWekSZjAGEYfQM/V9rvosbrJ9gVnOsZ1n8lEQGNBaxtSVUkz9BPXehp4
        SQh/ttLdmzI/Ui5zayWaZdF3A++/3UgWC6f7WjHED2WXLXdz+AZnaxzJFBx6vVj3J63pAR3yW1R
        oeNht4ReLzNWBegCW2RYvisGWbbS+No+PRbWqfRK6NVEWSRWybgsOxTmV7m9X/SXFxjWC0Qy2FC
        R9X31/66cPP3ofk5Hd1gqe814IbULtn8aI+WdhDEQBc3c/Nvs/7VchQhFJDnuTnUBvBY7m9kERy
        uRHFgnhSMqc7UpUorBKRsPC6bTvOqrQxXydIwG+QvGxhMZ/1zQ==
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.513400-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1020-25288.001
X-MDID: 1584131597-hbuiMMj_lOgn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/irq/manage.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7eee98c38f25..b3aa1db895e6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -323,7 +323,10 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 
 	if (desc->affinity_notify) {
 		kref_get(&desc->affinity_notify->kref);
-		schedule_work(&desc->affinity_notify->work);
+		if (!schedule_work(&desc->affinity_notify->work))
+			/* Work was already scheduled, drop our extra ref */
+			kref_put(&desc->affinity_notify->kref,
+				 desc->affinity_notify->release);
 	}
 	irqd_set(data, IRQD_AFFINITY_SET);
 
@@ -423,7 +426,9 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	if (old_notify) {
-		cancel_work_sync(&old_notify->work);
+		if (cancel_work_sync(&old_notify->work))
+			/* Pending work had a ref, put that one too */
+			kref_put(&old_notify->kref, old_notify->release);
 		kref_put(&old_notify->kref, old_notify->release);
 	}
 

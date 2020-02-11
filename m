Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DA3C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE14E20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="OagUjMkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgBKKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:35:19 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:39234 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgBKKfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:35:04 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48GzgB1Ct2zfJ;
        Tue, 11 Feb 2020 11:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581417302; bh=vJ8NUWITEPRXpkbxoGsrULQBqI+6p7Npd4ClhxGYj/Y=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=OagUjMkQfG5ZYGu77ODgUQyZtbdGkOXc/fjC4sC6MtxSDwdGw19s/NRUrAzkPM1Cp
         ROA40S2z9fowEyomLfG7EdyQxp77js26SH/69y911FaTyMuIsrtyuJYubUKmMBa6um
         p1N4PO0I67nfQ9RZVw33+AhfFkhCpyEuC/cZK15SoidZYowb4VAKhCOSvZCpLpX36w
         BO34mOHS4r++XtbCDr0aoUvmElVJizgD7ltpvpyD+DnjrWEresoXkKAC8/FxF6/9S+
         PDJ0PyrxpYhHGsraXzJ4kHqFktwWqAe54LTo+xof1TZd3ooA9QltnsIwggRPHNSSzJ
         XcGVscxrRaQFw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 11:35:01 +0100
Message-Id: <5e30397af95854b4a7deea073b730c00229f42ba.1581416843.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
References: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/6] staging: wfx: annotate nested gc_list vs tx queue
 locking
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep is complaining about recursive locking, because it can't make
a difference between locked skb_queues. Annotate nested locks and avoid
double bh_disable/enable.

[...]
insmod/815 is trying to acquire lock:
cb7d6418 (&(&list->lock)->rlock){+...}, at: wfx_tx_queues_clear+0xfc/0x198 [wfx]

but task is already holding lock:
cb7d61f4 (&(&list->lock)->rlock){+...}, at: wfx_tx_queues_clear+0xa0/0x198 [wfx]

[...]
Possible unsafe locking scenario:

      CPU0
      ----
 lock(&(&list->lock)->rlock);
 lock(&(&list->lock)->rlock);

Cc: stable@vger.kernel.org
Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/staging/wfx/queue.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
index 0bcc61feee1d..51d6c55ae91f 100644
--- a/drivers/staging/wfx/queue.c
+++ b/drivers/staging/wfx/queue.c
@@ -130,12 +130,12 @@ static void wfx_tx_queue_clear(struct wfx_dev *wdev, struct wfx_queue *queue,
 	spin_lock_bh(&queue->queue.lock);
 	while ((item = __skb_dequeue(&queue->queue)) != NULL)
 		skb_queue_head(gc_list, item);
-	spin_lock_bh(&stats->pending.lock);
+	spin_lock_nested(&stats->pending.lock, 1);
 	for (i = 0; i < ARRAY_SIZE(stats->link_map_cache); ++i) {
 		stats->link_map_cache[i] -= queue->link_map_cache[i];
 		queue->link_map_cache[i] = 0;
 	}
-	spin_unlock_bh(&stats->pending.lock);
+	spin_unlock(&stats->pending.lock);
 	spin_unlock_bh(&queue->queue.lock);
 }
 
@@ -207,9 +207,9 @@ void wfx_tx_queue_put(struct wfx_dev *wdev, struct wfx_queue *queue,
 
 	++queue->link_map_cache[tx_priv->link_id];
 
-	spin_lock_bh(&stats->pending.lock);
+	spin_lock_nested(&stats->pending.lock, 1);
 	++stats->link_map_cache[tx_priv->link_id];
-	spin_unlock_bh(&stats->pending.lock);
+	spin_unlock(&stats->pending.lock);
 	spin_unlock_bh(&queue->queue.lock);
 }
 
@@ -237,11 +237,11 @@ static struct sk_buff *wfx_tx_queue_get(struct wfx_dev *wdev,
 		__skb_unlink(skb, &queue->queue);
 		--queue->link_map_cache[tx_priv->link_id];
 
-		spin_lock_bh(&stats->pending.lock);
+		spin_lock_nested(&stats->pending.lock, 1);
 		__skb_queue_tail(&stats->pending, skb);
 		if (!--stats->link_map_cache[tx_priv->link_id])
 			wakeup_stats = true;
-		spin_unlock_bh(&stats->pending.lock);
+		spin_unlock(&stats->pending.lock);
 	}
 	spin_unlock_bh(&queue->queue.lock);
 	if (wakeup_stats)
@@ -259,10 +259,10 @@ int wfx_pending_requeue(struct wfx_dev *wdev, struct sk_buff *skb)
 	spin_lock_bh(&queue->queue.lock);
 	++queue->link_map_cache[tx_priv->link_id];
 
-	spin_lock_bh(&stats->pending.lock);
+	spin_lock_nested(&stats->pending.lock, 1);
 	++stats->link_map_cache[tx_priv->link_id];
 	__skb_unlink(skb, &stats->pending);
-	spin_unlock_bh(&stats->pending.lock);
+	spin_unlock(&stats->pending.lock);
 	__skb_queue_tail(&queue->queue, skb);
 	spin_unlock_bh(&queue->queue.lock);
 	return 0;
-- 
2.20.1


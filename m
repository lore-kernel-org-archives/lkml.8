Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A3E20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565868;
	bh=LV7P23B00+S8ImLTPp+ijLF3+cQPf7ovG23sO3ILZA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOpQVUHIPCBUI+tqYaObGW3ZbEUK/DEc5hUMMbey0RK//Y7JJGgAyKuBVYKUmoxtv
	 GEPJDloGUprxfD4pyOaANekxRj8+LwfJy/UKuVE7Q7zFEmibjjyW+F3xxAh/AhtOWN
	 owxDkQ//kvS8Kq1VrWv/Qjp5Z220+wtoiv+hc9vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgGABLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGABKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:46 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A47D20781;
        Wed,  1 Jul 2020 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565845;
        bh=LV7P23B00+S8ImLTPp+ijLF3+cQPf7ovG23sO3ILZA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jScekagbnRJlFZeSkgNby0+kJKvLj7lTuyCNCNQexmktTGPBvKSVygsaeUfC+Km18
         A6aOh3qo9M+7unA2dOm4u93xMqA0SG2GXFs9KNk5Tx2upNPjyAq8tGHFF/LJajwrA+
         2YhAK2J/5dI3jHybc3YVIhwmw0hVlZvAVLzU2SuE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 06/10] timer: Reuse next expiry cache after nohz exit
Date:   Wed,  1 Jul 2020 03:10:26 +0200
Message-Id: <20200701011030.14324-7-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we track the next expiry unconditionally when a timer is added,
we can reuse that information on a tick firing after exiting nohz.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 30f491ec875a..4612d26fd09a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1697,13 +1697,11 @@ static int collect_expired_timers(struct timer_base *base,
 	 * the next expiring timer.
 	 */
 	if ((long)(now - base->clk) > 2) {
-		unsigned long next = __next_timer_interrupt(base);
-
 		/*
 		 * If the next timer is ahead of time forward to current
 		 * jiffies, otherwise forward to the next expiry time:
 		 */
-		if (time_after(next, now)) {
+		if (time_after(base->next_expiry, now)) {
 			/*
 			 * The call site will increment base->clk and then
 			 * terminate the expiry loop immediately.
@@ -1711,7 +1709,7 @@ static int collect_expired_timers(struct timer_base *base,
 			base->clk = now;
 			return 0;
 		}
-		base->clk = next;
+		base->clk = base->next_expiry;
 	}
 	return __collect_expired_timers(base, heads);
 }
-- 
2.26.2


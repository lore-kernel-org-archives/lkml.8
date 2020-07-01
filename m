Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E93C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E242420771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565847;
	bh=mr+rQe0l8XSIekeEQFmG7I8vyIFw4b1KDVO2WDIE5lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0JIPYlCuvdmIN1hJiXSW5v2IwHynQ4qVowKSNbLiElKxc8p6pj2KiysO/AnS5MbiB
	 hY3Ex96ZetryKVtqZSDwEM9mplVSX9PyRhvPDhaqjY7qpicaViUYxo1g6M642ws+gC
	 gXt0aaLF4k5LSJcMSkauH5/7UyAstuonKg5nbsLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGABKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGABKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:43 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4516520780;
        Wed,  1 Jul 2020 01:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565842;
        bh=mr+rQe0l8XSIekeEQFmG7I8vyIFw4b1KDVO2WDIE5lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJZDTK6GDUNZbV4QtJGgNeRrtwxFjmld8mukrjb6nZXFlYINfDhiIvYgoSwlFJCgh
         y12cc4o2EEvmteqk9Gvm6QRBh6fq7s67WzXfketN+hfnObaCPvtJmO+StBEH/+So88
         E6jzhF6mJDuwDsgoE8EjPiDdXqZEAjj6h5MWBDSc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 04/10] timer: Optimize _next_timer_interrupt() level iteration
Date:   Wed,  1 Jul 2020 03:10:24 +0200
Message-Id: <20200701011030.14324-5-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a level has a timer that expires before we reach the next level,
there is no need to iterate further.

The next level is reached when the 3 lower bits of the current level are
cleared. If the next event happens before/during that, the next levels
won't give us an earlier expiration.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index b4838d63a016..4aa74aafdd33 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1515,6 +1515,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	clk = base->clk;
 	for (lvl = 0; lvl < LVL_DEPTH; lvl++, offset += LVL_SIZE) {
 		int pos = next_pending_bucket(base, offset, clk & LVL_MASK);
+		unsigned long lvl_clk = clk & LVL_CLK_MASK;
 
 		if (pos >= 0) {
 			unsigned long tmp = clk + (unsigned long) pos;
@@ -1522,6 +1523,13 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 			tmp <<= LVL_SHIFT(lvl);
 			if (time_before(tmp, next))
 				next = tmp;
+
+			/*
+			 * If the next expiration happens before we reach
+			 * the next level, no need to check further.
+			 */
+			if (pos <= ((LVL_CLK_DIV - lvl_clk) & LVL_CLK_MASK))
+				break;
 		}
 		/*
 		 * Clock for the next level. If the current level clock lower
@@ -1559,7 +1567,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 		 * So the simple check whether the lower bits of the current
 		 * level are 0 or not is sufficient for all cases.
 		 */
-		adj = clk & LVL_CLK_MASK ? 1 : 0;
+		adj = lvl_clk ? 1 : 0;
 		clk >>= LVL_CLK_SHIFT;
 		clk += adj;
 	}
-- 
2.26.2


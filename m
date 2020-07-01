Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1047DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E4C20781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565874;
	bh=19J8tsc4emiNRDndGS9y59YhYSV/+kq6icXBdrUsbsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ieeEV29jtOyz9mXLvy2IUMjE4WHVDiHyNGWgCtYFha28sGKDy/SPWhjwOxgLD3YnN
	 tboRTpnsCTl9CLQK+OmQJCXCfqIGOo6jTzx8bAXVRMuGGNgixw+nbTXITZB+PLnXti
	 CDtQyadvVeebS9JIiQBLUhcqP239R+klKEV/PTXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGABLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgGABKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:41 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3122078B;
        Wed,  1 Jul 2020 01:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565840;
        bh=19J8tsc4emiNRDndGS9y59YhYSV/+kq6icXBdrUsbsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTL8XgFEQe7/0kG8z4KVurk6QrgLv3b11/JF1rn5UMU9u2haISPMGq3zLYcaDo+z7
         EOgF8kJx7tLJEGwqofMWqsjdJ+FjxINYACcqivwXQjeJh1BmgVQMDOyQVdYYXXn0A8
         PLzI2wyKDmoIjj1D34vpM3Rbbamxs9A0dh4XpZEY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 03/10] timer: Simplify LVL_START() and calc_index()
Date:   Wed,  1 Jul 2020 03:10:23 +0200
Message-Id: <20200701011030.14324-4-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LVL_START() makes the first index of a level to start with what would be
the value of all bits set of the previous level.

For example level 1 starts at 63 instead of 64.

To cope with that, calc_index() always adds one offset for the level
granularity to the expiry passed in parameter.

Yet there is no apparent reason for such fixups so simplify the whole
thing.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4c977df3610b..b4838d63a016 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -158,7 +158,7 @@ EXPORT_SYMBOL(jiffies_64);
  * The time start value for each level to select the bucket at enqueue
  * time.
  */
-#define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
+#define LVL_START(n)	(LVL_SIZE << (((n) - 1) * LVL_CLK_SHIFT))
 
 /* Size of each clock level */
 #define LVL_BITS	6
@@ -489,7 +489,7 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
  */
 static inline unsigned calc_index(unsigned expires, unsigned lvl)
 {
-	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
+	expires >>= LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
 }
 
-- 
2.26.2


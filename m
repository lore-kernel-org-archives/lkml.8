Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CF3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DB4207D4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593738424;
	bh=k73IeEdgQUZj1/5rKGHi3+j/vUAAnWYfM2N+k8D5unE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vcGMffC0zv33XgUKiax1n8xLvSindsJ3v6577JoOx5uTl1mjnKjgd0GGgMLd8H77H
	 71YQePBFTM54twWxGO1jZJ2WRxRXWZAYhB7rpZTUHFAhynFfKpzVPBNyiTjUzqSfDu
	 DgdDjdNvyn+O1SXXWmwZ7hGfWeRdGx+vrun/P4lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgGCBHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGCBHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:07:02 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE8AF20781;
        Fri,  3 Jul 2020 01:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593738422;
        bh=k73IeEdgQUZj1/5rKGHi3+j/vUAAnWYfM2N+k8D5unE=;
        h=From:To:Cc:Subject:Date:From;
        b=GDnxLU2au+Cexq1VUINfJgjKmArvqILKPNTdsp6XGWdexOZ1T0iJNv7mrScoo+0dc
         bu8zOZTokXHjzZywKAXcXVlmrzrBVgkUP+p+JEbiV0hSyV2UMYtWI8SBL08s5gYjWC
         V16Cfg9bR7wLW/oVNU3UXVeoEY6mdcOYITlXcPNg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, Stable <stable@kernel.org>
Subject: [PATCH] timer: Prevent base->clk from moving backward
Date:   Fri,  3 Jul 2020 03:06:57 +0200
Message-Id: <20200703010657.2302-1-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a timer is enqueued with a negative delta (ie: expiry is below
base->clk), it gets added to the wheel as expiring now (base->clk).

Yet the value that gets stored in base->next_expiry, while calling
trigger_dyntick_cpu(), is the initial timer->expires value. The
resulting state becomes:

	base->next_expiry < base->clk

On the next timer enqueue, forward_timer_base() may accidentally
rewind base->clk. As a possible outcome, timers may expire way too
early, the worst case being that the highest wheel levels get spuriously
processed again.

To prevent from that, make sure that base->next_expiry doesn't get below
base->clk.

Fixes: a683f390b93f ("timers: Forward the wheel clock whenever possible")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 398e6eadb861..9a838d38dbe6 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -584,7 +584,15 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	 * Set the next expiry time and kick the CPU so it can reevaluate the
 	 * wheel:
 	 */
-	base->next_expiry = timer->expires;
+	if (time_before(timer->expires, base->clk)) {
+		/*
+		 * Prevent from forward_timer_base() moving the base->clk
+		 * backward
+		 */
+		base->next_expiry = base->clk;
+	} else {
+		base->next_expiry = timer->expires;
+	}
 	wake_up_nohz_cpu(base->cpu);
 }
 
@@ -896,10 +904,13 @@ static inline void forward_timer_base(struct timer_base *base)
 	 * If the next expiry value is > jiffies, then we fast forward to
 	 * jiffies otherwise we forward to the next expiry value.
 	 */
-	if (time_after(base->next_expiry, jnow))
+	if (time_after(base->next_expiry, jnow)) {
 		base->clk = jnow;
-	else
+	} else {
+		if (WARN_ON_ONCE(time_before(base->next_expiry, base->clk)))
+			return;
 		base->clk = base->next_expiry;
+	}
 #endif
 }
 
-- 
2.26.2


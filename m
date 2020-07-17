Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB1C433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B018C2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594994787;
	bh=KCcPPdKEH7TZv/b20jwChJ48+CoMV41+fAighwT9/FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTlGE3kabXe0O9Y1kUo3k7XBAV5XU7a9g3dyyvHAqywNY2FsMetmkhvyi4wLSSZGu
	 ygfznrlyN9r8jWET31f7gu4NZ6Jwy6lO3fMQdLll/uCSWx6E9TsyRkpxaPn4/G8C4y
	 82hRfx1MGUadI4rqZ+rtG3hMIWVy9Mc7jtWPJh98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGQOGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgGQOGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:10 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53952173E;
        Fri, 17 Jul 2020 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994769;
        bh=KCcPPdKEH7TZv/b20jwChJ48+CoMV41+fAighwT9/FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bffwOgcNPE1mh9UvYE6wjuqYPpwe1hL7v6mX6bxH62tA0Rnv2IleiswPpaXO+q9HV
         a3Vnef85Iu0rMiVlQ9S1JP1SbiwcwOrOunHsfN0nZxIO+0EIy7VZn3T2LnqKrPR8Wi
         tzvLA+dACQ5YILGJfyP0S9fIluHZgR8yOGik7IOk=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 08/12] timer: Reuse next expiry cache after nohz exit
Date:   Fri, 17 Jul 2020 16:05:47 +0200
Message-Id: <20200717140551.29076-9-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we track the next expiry unconditionally when a timer is added,
we can reuse that information on a tick firing after exiting nohz.

Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 76fd9644638b..13f48ee708aa 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1706,13 +1706,11 @@ static int collect_expired_timers(struct timer_base *base,
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
@@ -1720,7 +1718,7 @@ static int collect_expired_timers(struct timer_base *base,
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


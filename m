Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC91CC43445
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C832070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262260;
	bh=0S0MdIvexlqATgisYh+BVsnXvViVSBmHnw4wfvtKGwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rXS+qvWGN13wFM9D7MaT4TPp39BwJR+IhEJTTYhphdnuFm16OfCCLw+KobX+thveR
	 3xW/z2jE5BpL2w0h9T9EKRbVl41p6m7FBvqY/Q/F3qkzJH1Z16Q5U0zS1bs9so2CtU
	 kk6TE26KbgcOCeJgcuhRoLwwRdDuuTQfJsT9qJ+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbgGTQYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgGTQDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F252120773;
        Mon, 20 Jul 2020 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261029;
        bh=0S0MdIvexlqATgisYh+BVsnXvViVSBmHnw4wfvtKGwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUdL2IS7X4oUm+M3yGTC8UCfVMTcMLQVw0/mUz5TNEaoGkSHgFFkkuMRrEzzTxjXu
         CubO3lzT3GdwBQcR1GBFHhK0NfgUc5aHsCQhPpM3tdAsNbv0Be2TQ3hwJNQikR3cHS
         NYD7/12iCbNBmiLNSUd4kiJVAhTtNbldXnAZuJrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 5.4 183/215] timer: Prevent base->clk from moving backward
Date:   Mon, 20 Jul 2020 17:37:45 +0200
Message-Id: <20200720152828.877890659@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

commit 30c66fc30ee7a98c4f3adf5fb7e213b61884474f upstream.

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200703010657.2302-1-frederic@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/timer.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -585,7 +585,15 @@ trigger_dyntick_cpu(struct timer_base *b
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
 
@@ -897,10 +905,13 @@ static inline void forward_timer_base(st
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
 



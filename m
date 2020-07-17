Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142A2C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E788D20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R8Rs0UoD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GfFHJjk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgGQUAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgGQUAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459ACC0619D2;
        Fri, 17 Jul 2020 13:00:21 -0700 (PDT)
Date:   Fri, 17 Jul 2020 20:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhaBDAjPzAdD3mW8nMjPK4h7oSqD1yFlTs2c2SKwV9s=;
        b=R8Rs0UoDdN1xfDktaxrkb52BOQkW4lR5/V+yXEYIYoP5LRX/wW7Nn8bLDNUJobOZC+Qu5n
        D0Nvbe9WIlmHvAV0mNftdIE4EZRwQ6pJwsZBNffhAwEqGebRm/NBkWZ/cudFrIR+w0FmqD
        T0F8iaYieN8jxrngAJJMiqfOZv/FH4fK6uUHzFcLfLWSB1c6gNH42TN5wUzFe3cTlIwOjV
        Nzuxg754+SamdChjy/Sj179nVZ1qwbOx4fu+rUvoS76tk0GmmuQP4zhEduFlHWPqhpl/za
        0k7gV3NmKCAoMFuII1WyQXVEvH00vva+L2vVUI2AAoZ8PvyFy/CEADVD04ubeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhaBDAjPzAdD3mW8nMjPK4h7oSqD1yFlTs2c2SKwV9s=;
        b=GfFHJjk1347nBa7LfeXJaPsLeLAK52//sTM3lVKOJRnRWVmJdv9ofKcIk7J/joKzli4n4H
        jI7idDZu8KQG+JDQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Add comments about calc_index() ceiling work
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-6-frederic@kernel.org>
References: <20200717140551.29076-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601930.4006.7549756767804002018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4468897211628865ee2392acb5ad281f74176f63
Gitweb:        https://git.kernel.org/tip/4468897211628865ee2392acb5ad281f74176f63
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:22 +02:00

timers: Add comments about calc_index() ceiling work

calc_index() adds 1 unit of the level granularity to the expiry passed
in parameter to ensure that the timer doesn't expire too early. Add a
comment to explain that and the resulting layout in the wheel.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-6-frederic@kernel.org

---
 kernel/time/timer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2af08a1..af1c08b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -156,7 +156,8 @@ EXPORT_SYMBOL(jiffies_64);
 
 /*
  * The time start value for each level to select the bucket at enqueue
- * time.
+ * time. We start from the last possible delta of the previous level
+ * so that we can later add an extra LVL_GRAN(n) to n (see calc_index()).
  */
 #define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
 
@@ -490,6 +491,15 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
 static inline unsigned calc_index(unsigned long expires, unsigned lvl,
 				  unsigned long *bucket_expiry)
 {
+
+	/*
+	 * The timer wheel has to guarantee that a timer does not fire
+	 * early. Early expiry can happen due to:
+	 * - Timer is armed at the edge of a tick
+	 * - Truncation of the expiry time in the outer wheel levels
+	 *
+	 * Round up with level granularity to prevent this.
+	 */
 	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
 	*bucket_expiry = expires << LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);

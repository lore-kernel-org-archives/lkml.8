Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC53C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A592074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgkUTPzr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qP9gi512"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGXIdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgGXIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728A3C0619D3;
        Fri, 24 Jul 2020 01:33:43 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XIfdTQ0SH/I/FUZCCxK2Os2s0+nVpnC71kDMnXL/T7I=;
        b=xgkUTPzrASf8gLh+Xe2kiWFwWOQyr9Dq+NIdbXKy+5yiC53iNHg/94hTbc8bShylPf9IxV
        sRm4EiehIvwm/u409ch8XVqngr7TqkqXvk/nGR3hDtKif+wHTvdtAZ8g7PyHr/3LYVp6c6
        NYrvN7Us2sbsFvDyOx2cu8G0fHfw8U7W2HyDiACqRXmWQROWa8gdckNOhoegyYUi+L9QqB
        H8sU+L2HqM7xgKjhN7gpBjBDCsg0vM2GjcLEbU1lwg6Rn4veomH8q19i1h8bbk3wJf8Y+K
        EJ+jmJYnZ3bZbzzmUwHfFwCaeITNq4mcg4ADmR9ZXqnR8oFQd39MaKwcTuHhyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XIfdTQ0SH/I/FUZCCxK2Os2s0+nVpnC71kDMnXL/T7I=;
        b=qP9gi512JJL2d+EFgwqbd4Hf77GGRr41Xc3CB7KJBs6CbJBMcHjqtkAhj7U8nXLUZYZqh4
        iWFejFhI1tFfZGCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,locktorture: Convert to sched_set_fifo()
Cc:     paulmck@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962125.4006.13758962058893410842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     93db9129fa4beb78e2227554d237e8db04ca514c
Gitweb:        https://git.kernel.org/tip/93db9129fa4beb78e2227554d237e8db04ca514c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:24 +02:00

sched,locktorture: Convert to sched_set_fifo()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively changes prio from 99 to 50.

Cc: paulmck@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 5efbfc6..fca41a7 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -436,8 +436,6 @@ static int torture_rtmutex_lock(void) __acquires(torture_rtmutex)
 
 static void torture_rtmutex_boost(struct torture_random_state *trsp)
 {
-	int policy;
-	struct sched_param param;
 	const unsigned int factor = 50000; /* yes, quite arbitrary */
 
 	if (!rt_task(current)) {
@@ -448,8 +446,7 @@ static void torture_rtmutex_boost(struct torture_random_state *trsp)
 		 */
 		if (trsp && !(torture_random(trsp) %
 			      (cxt.nrealwriters_stress * factor))) {
-			policy = SCHED_FIFO;
-			param.sched_priority = MAX_RT_PRIO - 1;
+			sched_set_fifo(current);
 		} else /* common case, do nothing */
 			return;
 	} else {
@@ -462,13 +459,10 @@ static void torture_rtmutex_boost(struct torture_random_state *trsp)
 		 */
 		if (!trsp || !(torture_random(trsp) %
 			       (cxt.nrealwriters_stress * factor * 2))) {
-			policy = SCHED_NORMAL;
-			param.sched_priority = 0;
+			sched_set_normal(current, 0);
 		} else /* common case, do nothing */
 			return;
 	}
-
-	sched_setscheduler_nocheck(current, policy, &param);
 }
 
 static void torture_rtmutex_delay(struct torture_random_state *trsp)

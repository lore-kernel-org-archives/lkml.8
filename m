Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF11C433FB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B472074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DuY2uLa4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ARxA0luz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGXIec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgGXIdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:47 -0400
Date:   Fri, 24 Jul 2020 08:33:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sIbEIx8QJ1LxAgETgPtEtsQZ+fKwHuYAzwGNHuDcJwg=;
        b=DuY2uLa4nccWUPzF11A+vzlHfWS5JGidsoc6GtSX9ce/2dFX4Mw/jfh6NdFyxo7wEog2Z5
        360mYMxxC7fAg5nSsgPvAhO7kkDCcNMylnaiiNhTOwgRjK0Y1WgY/P6A3f7RbB2A2C6rst
        AARQSs5P1LVfnko5vZ46tHp6TueITO6lywsdaGG28KXTr7BA7n2LxcPHto86XBiWsmIOYU
        o5CBIF6EX8ubzunoqmCIYt2VCScnpCTsR3xuAOMpUtf4TMMEo+qzPi4s1FnByMXy34Czxx
        8GBwayM/7U4O1934ecEqSDXrA9g6ig0hxHimLBDTXVwHd6O7zNCZF7GZISzS1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sIbEIx8QJ1LxAgETgPtEtsQZ+fKwHuYAzwGNHuDcJwg=;
        b=ARxA0luzGp8qm7DwdN91G7GfqMmcaJHRf4iiULtcNH4KT8XhonyZ8RuRLcRaekVaAX5nk2
        s1CZM+VVYr3RmSBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,powercap: Convert to sched_set_fifo*()
Cc:     daniel.lezcano@linaro.org, rafael.j.wysocki@intel.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962519.4006.1088865081805684580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     c3f47cf940efacaa8fab50973dc98f369c2066ff
Gitweb:        https://git.kernel.org/tip/c3f47cf940efacaa8fab50973dc98f369c2066ff
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:22 +02:00

sched,powercap: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: daniel.lezcano@linaro.org
Cc: rafael.j.wysocki@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/powercap/idle_inject.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index c90f099..bc396a8 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -268,9 +268,7 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
  */
 static void idle_inject_setup(unsigned int cpu)
 {
-	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
-
-	sched_setscheduler(current, SCHED_FIFO, &param);
+	sched_set_fifo(current);
 }
 
 /**

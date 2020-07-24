Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4064C433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2142074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aeljRXo/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g0R7DkkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgGXIfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:35:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGXIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:41 -0400
Date:   Fri, 24 Jul 2020 08:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ta5CgQUNjiszs7rW0eoLafy4TgPq8fX+vdqFKaoo35A=;
        b=aeljRXo/iJfPoqVpxEaY9uo0eA92yBx/+TykMD5i20bOEFMQ0LLielkiBZwcnkKwkRQWBW
        dc4hPWaT8CvCJ44EwEU3FaENnOov0CqMWIgO5DRmqq2FLQV2JPUbB2KgBN8o83t+Bo7xut
        grKkMZWnex+kXpBMlMXlErU8XE6q33qvmmrCYA6UdrLTi+1cZHj0b80X6kxzj2wNEmGvOs
        CKuhfWDs6ZKo3Ful5uiYndU4nD/ljq9erQXK/Gt51fgxDWOrPS7y/YzZYVsKGTQ1fNQoLM
        SOyNvkGk87d/16Nx9cs+Xd9Fp8HsVTlF/SY3mFkVEkenUC2ek6tsbf0Hk6N9Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ta5CgQUNjiszs7rW0eoLafy4TgPq8fX+vdqFKaoo35A=;
        b=g0R7DkkSVZqvAE195LbedNkbaUEdHdl7VoDwfRibUBQtqBapsoiitURsfzGd/WuomG21/r
        HnRl24fKQcwjRaCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,psi: Convert to sched_set_fifo_low()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557961932.4006.9497014186016108711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     2cca5426b9c108998bc03230cd6ae440f3e205ed
Gitweb:        https://git.kernel.org/tip/2cca5426b9c108998bc03230cd6ae440f3e205ed
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:25 +02:00

sched,psi: Convert to sched_set_fifo_low()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e53b711..967732c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -616,11 +616,8 @@ out:
 static int psi_poll_worker(void *data)
 {
 	struct psi_group *group = (struct psi_group *)data;
-	struct sched_param param = {
-		.sched_priority = 1,
-	};
 
-	sched_setscheduler_nocheck(current, SCHED_FIFO, &param);
+	sched_set_fifo_low(current);
 
 	while (true) {
 		wait_event_interruptible(group->poll_wait,

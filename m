Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31388C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D312074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjFwFeFQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olyi00Vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgGXIe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgGXIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E114C0619D3;
        Fri, 24 Jul 2020 01:33:48 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y1U8S0e0VdwkpvQZzyQq4gAmgh1xIU2ArgV7LHjzVu8=;
        b=sjFwFeFQ0hID7WiUv6V0Q4lAhldpkhouTPndyv8DO64VuCwXEGdjmGSMoPdBFHydv80GpE
        ePtA+tuq+RK4aQpgUpM0cPeciTAPJZjqYig3EMk83goiApUsbaTNACgwNufomQZXZ4fujw
        I9e7Dad4UdbGFi0YVxH3Ftq7B/+O8gMbQ08zfZPnLK+iAp6r62uBk27ohqSdUA4z4HUWOM
        1S8vB/8CqH6zXyk8nhd0qHRixDkR5w/0kKiZOjV//SLZhr76C1mAfx95j+VlVOf6CRhvMS
        JsFOgB5qV3NtE6AHnsexQ27nW0zZyrlQT9g7bW/nNyh+vLoUNrVb9CO8UvyVbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y1U8S0e0VdwkpvQZzyQq4gAmgh1xIU2ArgV7LHjzVu8=;
        b=olyi00Vtf1X90kqjrE41PWhH8/Yy8RgQE8Y6OIXDMYSYi45NTMZIE1p4k4jm0/8Na8lES7
        Ul0yqlTpRkkpoXDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,mmc: Convert to sched_set_fifo*()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962652.4006.11649892529490594226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     f8ec806be101e9a6482532d19eca4c5be3535b74
Gitweb:        https://git.kernel.org/tip/f8ec806be101e9a6482532d19eca4c5be3535b74
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:22 +02:00

sched,mmc: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

In this case, use fifo_low, because it only cares about being above
SCHED_NORMAL. Effectively no change in behaviour.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 3ffe4ff..4b1f7c9 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -139,11 +139,10 @@ EXPORT_SYMBOL_GPL(sdio_signal_irq);
 static int sdio_irq_thread(void *_host)
 {
 	struct mmc_host *host = _host;
-	struct sched_param param = { .sched_priority = 1 };
 	unsigned long period, idle_period;
 	int ret;
 
-	sched_setscheduler(current, SCHED_FIFO, &param);
+	sched_set_fifo_low(current);
 
 	/*
 	 * We want to allow for SDIO cards to work even on non SDIO

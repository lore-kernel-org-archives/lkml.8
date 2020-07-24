Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4CFC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB8520674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DGiyO/K/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lgM+WjNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGXIeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36452 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgGXIdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:45 -0400
Date:   Fri, 24 Jul 2020 08:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wAp8GM3GN2zNhZJaPqmPT6M6yX6q0N0mVC5nZLd4J3U=;
        b=DGiyO/K/88ILXufWPVPjXkCrbAkRfcNZPX5tdJrnFwlqiA9AP3YHmLhYcUvQ+ODiIClcor
        b93mgI6SCUiLhA++Ym6UTO1oeCKbWJirgKZPoox34vUWl70W6w1ahNTEhV7U4bb7EhhPh4
        A0qOQ0lF4d7XH0CIxByqdP0a/ahX4YXObCzVmiOC6ciN0rfVYdF193WHCwT92DcGFK4sd7
        rcsjf6qTuh6QVLNF1ekePP2oDa+5X8OlQ8FGX5tfeU4HuPOXNpSEM+Xrz99pNHrsE4Vu2l
        fyWPBIcks6t1ZNT/hV6a99QpFI/Ax6bRlMbAV6HzRxBkX09BiOgTihxreZkszQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wAp8GM3GN2zNhZJaPqmPT6M6yX6q0N0mVC5nZLd4J3U=;
        b=lgM+WjNQ18P7vdPhcTh3qgmNyFtXRsJ93xKiqkWB6uvmRvvqpGgsnGSnSwS8Y/3fWgFs9V
        qyzE6fXHav4LbcBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,serial: Convert to sched_set_fifo()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962335.4006.11081661195852559579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     28d2f209cd1620afaca6d0a61d1e88a269e9e875
Gitweb:        https://git.kernel.org/tip/28d2f209cd1620afaca6d0a61d1e88a269e9e875
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:23 +02:00

sched,serial: Convert to sched_set_fifo()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index d2e5c6c..809610b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1179,7 +1179,6 @@ static int sc16is7xx_probe(struct device *dev,
 			   const struct sc16is7xx_devtype *devtype,
 			   struct regmap *regmap, int irq)
 {
-	struct sched_param sched_param = { .sched_priority = MAX_RT_PRIO / 2 };
 	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
 	unsigned int val;
 	u32 uartclk = 0;
@@ -1239,7 +1238,7 @@ static int sc16is7xx_probe(struct device *dev,
 		ret = PTR_ERR(s->kworker_task);
 		goto out_clk;
 	}
-	sched_setscheduler(s->kworker_task, SCHED_FIFO, &sched_param);
+	sched_set_fifo(s->kworker_task);
 
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio) {

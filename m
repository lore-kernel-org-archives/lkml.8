Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A06C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0802070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBpaSjti";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMB6S83+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgGQUAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:00:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgGQUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:18 -0400
Date:   Fri, 17 Jul 2020 20:00:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqGNrlxmh8sBy0JeDfvSgrqAbY3l+xwBTcymVKXFe3k=;
        b=OBpaSjti4KgaE6RTX/l2WEWSB+CeYRutjon2tk7rxptZ5hDZG7ihZh8jEnB+70neNFqq+j
        Wx9RzTyGD12CwfPewfgElYYFZDoCYxprYXc5FGSkR1PGpFPqDIzd4HmXEwLrF3TK07G1jc
        Zo+s+C1PGDeAxc6RQuAA3gDa2l8qqvWfC/KKS/yVMCw9PjtOcgV1gaj9+LQKKcCqQxAAQr
        kGuOzD+zsbQtamc2UihJ9oQ5aORBO4Po3xJQ3+jdljwR+ffKiuFekuyAF3X2om6VZTj/5m
        v9mWfyFCB9ULkpGfO38D/vCywf6/nIvSTvViXwuRhS9f+c9UkamDhlnJjKNeDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqGNrlxmh8sBy0JeDfvSgrqAbY3l+xwBTcymVKXFe3k=;
        b=JMB6S83+4SOJRsxZqT183hL7f1m305Gua2FudV/ikzeEiB4li3YF435ajJPhNcVJONbWE4
        ifTgzz8XNFHijfDw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Lower base clock forwarding threshold
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-13-frederic@kernel.org>
References: <20200717140551.29076-13-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601496.4006.3364928188883956885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     36cd28a4cdd05d47ccb62a2d86e8f37839cc879a
Gitweb:        https://git.kernel.org/tip/36cd28a4cdd05d47ccb62a2d86e8f37839cc879a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:25 +02:00

timers: Lower base clock forwarding threshold

There is nothing that prevents from forwarding the base clock if it's one
jiffy off. The reason for this arbitrary limit of two jiffies is historical
and does not longer exist.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-13-frederic@kernel.org

---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8b3fb52..77e21e9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -894,7 +894,7 @@ static inline void forward_timer_base(struct timer_base *base)
 	 * Also while executing timers, base->clk is 1 offset ahead
 	 * of jiffies to avoid endless requeuing to current jffies.
 	 */
-	if ((long)(jnow - base->clk) < 2)
+	if ((long)(jnow - base->clk) < 1)
 		return;
 
 	/*

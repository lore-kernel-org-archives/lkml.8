Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02735C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE79220709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="snX2KBo6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xxBgENrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgGWTJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60556 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgGWTJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:45 -0400
Date:   Thu, 23 Jul 2020 19:09:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjixXNfvSjC46JjOZdQ4IkLiaylNL51+RoH2JOQCLiI=;
        b=snX2KBo6f1GV3AsJPf/U1TJcSlDDV8/FJDAMTLx1PXM5J7jlFNexsdmocybzpR0JQpwA34
        Un0zJIhRa2BQDpPKykFth9/aBGphWnG7kCjMjXix6+GkRZ9stANgMiz3zmqze/QuPsNpYC
        joHg+VeZ3anOmBi+pidbvkxMgK2JiO6WCFmCEqqQ/cO3I7uQS9s8T4IsB3ddjj4EunTQz1
        u5paGI9D/MIfvPmRYtRcQhlm29ovgC8fzq6G/LrALfmROF1bqLrLpAN9r4BKUlY3K8uRbC
        waF5VpUSmDxzgMIV07CIXUNsJaaPJ6U02Lkd9hckPTYZsq2SVy/eRi2JnpZ44A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjixXNfvSjC46JjOZdQ4IkLiaylNL51+RoH2JOQCLiI=;
        b=xxBgENrpT+2QTamLBMoa1KliRWuL1ixvs/sNRQr9HMQBEG0j1mofEqwx1tXcKLJOKgHEIt
        j9FuSZhUmyZBejBQ==
From:   "tip-bot2 for Alexandre Belloni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-atmel-tcb: Allow
 selecting first divider
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200710230813.1005150-9-alexandre.belloni@bootlin.com>
References: <20200710230813.1005150-9-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Message-ID: <159553138254.4006.5886895176934132586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     501465d5d7af63af5942cf6af783952bdd757c52
Gitweb:        https://git.kernel.org/tip/501465d5d7af63af5942cf6af783952bdd757c52
Author:        Alexandre Belloni <alexandre.belloni@bootlin.com>
AuthorDate:    Sat, 11 Jul 2020 01:08:12 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 11 Jul 2020 18:58:18 +02:00

clocksource/drivers/timer-atmel-tcb: Allow selecting first divider

The divider selection algorithm never allowed to get index 0. It was also
continuing to look for dividers, trying to find the slow clock selection.
This is not necessary anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-9-alexandre.belloni@bootlin.com
---
 drivers/clocksource/timer-atmel-tcb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 7a6474a..7fea134 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -432,10 +432,8 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 		tmp = rate / divisor;
 		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
-		if (best_divisor_idx > 0) {
-			if (tmp < 5 * 1000 * 1000)
-				continue;
-		}
+		if ((best_divisor_idx >= 0) && (tmp < 5 * 1000 * 1000))
+			break;
 		divided_rate = tmp;
 		best_divisor_idx = i;
 	}

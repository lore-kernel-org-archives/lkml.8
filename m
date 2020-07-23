Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FB7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0090620709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vr6f3/bX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pLhjXMU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgGWTJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgGWTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:42 -0400
Date:   Thu, 23 Jul 2020 19:09:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOpsCe+bi6vV8+jAPqDgk29th7WfmTe9j2iURiMnsKs=;
        b=vr6f3/bX00TxU3NhXEZighrlCfFJklvgdlFqUGrDeWzdSF6y5OBnm7UnqGIYrSHhJTlrMq
        IaU6sDZt9gHvb5PgRXXrDR0QHLyqJqjZJvK0T4m1O147vtZynjmBbKDayzGE/jLDtA9mZQ
        9j1AUZ1DbONBIIipN/ClbgUJYXZUmOn/cUbpl6a9Ml55ul493y+eaqYy6TNms2obt5IWQv
        XVuwC/4SRjWu3ubzUm96xO6+baDwXW0PRdM6Lydwxq+VAGUgbc1L5/Sce4THhNFNd1Dj7w
        fPLeDy6WMbFuHIb4FpEv6tK6mqbYlFWzf5Ik4T76IT3xziYZlvxd/wCBgulcHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOpsCe+bi6vV8+jAPqDgk29th7WfmTe9j2iURiMnsKs=;
        b=pLhjXMU0MeJ0rn3J+SPi1badOBOM6TPnqomMfdko7JXwp0q1YkzTo9GyW/kit1Ix0SZq5e
        IQRzV/H0NbdECMAw==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_cmt: Use "kHz" for kilohertz
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200618080212.16560-1-geert+renesas@glider.be>
References: <20200618080212.16560-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <159553137978.4006.7240080497666806907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ad7794d4dd0c3f03a81a0dbec3e9e3906edb9893
Gitweb:        https://git.kernel.org/tip/ad7794d4dd0c3f03a81a0dbec3e9e3906edb9893
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Thu, 18 Jun 2020 10:02:12 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 23 Jul 2020 16:57:43 +02:00

clocksource/drivers/sh_cmt: Use "kHz" for kilohertz

"K" stands for "kelvin".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200618080212.16560-1-geert+renesas@glider.be
---
 drivers/clocksource/sh_cmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 12ac75f..7607774 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -349,7 +349,7 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch)
 
 	/*
 	 * According to the sh73a0 user's manual, as CMCNT can be operated
-	 * only by the RCLK (Pseudo 32 KHz), there's one restriction on
+	 * only by the RCLK (Pseudo 32 kHz), there's one restriction on
 	 * modifying CMCNT register; two RCLK cycles are necessary before
 	 * this register is either read or any modification of the value
 	 * it holds is reflected in the LSI's actual operation.

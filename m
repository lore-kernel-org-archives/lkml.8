Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96C5C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DE2207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgAPVb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:31:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53554 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbgAPVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjJ-0001Xb-0a; Thu, 16 Jan 2020 22:31:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8741F1C198A;
        Thu, 16 Jan 2020 22:31:01 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:31:01 -0000
From:   "tip-bot2 for Yangtao Li" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/em_sti: Convert to
 devm_platform_ioremap_resource
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221173027.30716-2-tiny.windzz@gmail.com>
References: <20191221173027.30716-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Message-ID: <157921026132.396.14041876817100272058.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9a97b2fb070d497c683aed9fb86b7ec5245cea86
Gitweb:        https://git.kernel.org/tip/9a97b2fb070d497c683aed9fb86b7ec5245cea86
Author:        Yangtao Li <tiny.windzz@gmail.com>
AuthorDate:    Sat, 21 Dec 2019 17:30:24 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:06:57 +01:00

clocksource/drivers/em_sti: Convert to devm_platform_ioremap_resource

Use devm_platform_ioremap_resource() to simplify code, which
wraps 'platform_get_resource' and 'devm_ioremap_resource' in a
single helper.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191221173027.30716-2-tiny.windzz@gmail.com
---
 drivers/clocksource/em_sti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 9039df4..086fd5d 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -279,7 +279,6 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 static int em_sti_probe(struct platform_device *pdev)
 {
 	struct em_sti_priv *p;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -295,8 +294,7 @@ static int em_sti_probe(struct platform_device *pdev)
 		return irq;
 
 	/* map memory, let base point to the STI instance */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(&pdev->dev, res);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 

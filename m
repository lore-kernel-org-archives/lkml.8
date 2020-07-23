Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458F7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C99520737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FrR1w8FE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lT+S+NUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgGWTKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:10:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgGWTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:43 -0400
Date:   Thu, 23 Jul 2020 19:09:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BShgL5G39O6CUxpP2ocDzHrkdprHQN9lG1WfKlMs0S8=;
        b=FrR1w8FEDk6MnZwczH2LDDUwaUKABvY/Uw5iuTvpqOFFNVi6TwEMZRhtBjWTAJiLOZ9tBa
        GInIrzJLEq8hElgxcLyWWMAYmDSV4R7IwHXWQ9O1mYuMpfFNIqllMCVn76VK+rF3RAE/7H
        4byk6w28Vk3VIrZBwxGgW90RoSibHkNVj2p0c2uVsh4Hg67pW4Hl4iCreNpWgQ33rNJnHk
        qb4PjPYymyF+U/ri6Yk046qgcNXLN+1BF2Ig/D4T9hW/D/SbcS/4rXaXdz/drIovP//yFd
        SIabnN4gEehM0/gdrtgFfEjnRfOd1lSYJewa8PO2YOH0ceiaNcPObaJKS6le/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BShgL5G39O6CUxpP2ocDzHrkdprHQN9lG1WfKlMs0S8=;
        b=lT+S+NUxF1Cu0zTLKz7m6JFSjTe2CmzVaPTpqkooKccIZKRhv9IsLV2p4HUkwBA4SPJePF
        iqMaMYc+CW+rNbCg==
From:   "tip-bot2 for Anson Huang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx: Add support for i.MX TPM
 driver with ARM64
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1594178168-13007-1-git-send-email-Anson.Huang@nxp.com>
References: <1594178168-13007-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Message-ID: <159553138045.4006.9281081871337111242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a6d0812a081defd8bef5453c7b69a1cb4735a170
Gitweb:        https://git.kernel.org/tip/a6d0812a081defd8bef5453c7b69a1cb4735a170
Author:        Anson Huang <Anson.Huang@nxp.com>
AuthorDate:    Wed, 08 Jul 2020 11:16:07 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 23 Jul 2020 16:57:34 +02:00

clocksource/drivers/imx: Add support for i.MX TPM driver with ARM64

Allows building and compile-testing the i.MX TPM driver for ARM64.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1594178168-13007-1-git-send-email-Anson.Huang@nxp.com
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9141838..9936d15 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -616,8 +616,9 @@ config CLKSRC_IMX_GPT
 
 config CLKSRC_IMX_TPM
 	bool "Clocksource using i.MX TPM" if COMPILE_TEST
-	depends on ARM && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
 	  clocksource.

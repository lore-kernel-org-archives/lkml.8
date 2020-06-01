Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EA4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0045F207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFANMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgFANL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:11:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F9AC08C5C0;
        Mon,  1 Jun 2020 06:11:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfkEJ-0007AU-JX; Mon, 01 Jun 2020 15:11:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B45AF1C0794;
        Mon,  1 Jun 2020 15:11:49 +0200 (CEST)
Date:   Mon, 01 Jun 2020 13:11:49 -0000
From:   "tip-bot2 for Anson Huang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-tpm: Add support for ARM64
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1585715222-24489-1-git-send-email-Anson.Huang@nxp.com>
References: <1585715222-24489-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Message-ID: <159101710955.17951.14810721083224334490.tip-bot2@tip-bot2>
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

Commit-ID:     ac161f57b66dcf14b3339b1c5857c08a9ad4d833
Gitweb:        https://git.kernel.org/tip/ac161f57b66dcf14b3339b1c5857c08a9ad4d833
Author:        Anson Huang <Anson.Huang@nxp.com>
AuthorDate:    Wed, 01 Apr 2020 12:27:02 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Apr 2020 16:24:50 +02:00

clocksource/drivers/imx-tpm: Add support for ARM64

Allows building and compile-testing the i.MX TPM driver also
for ARM64. The delay_timer is only supported on ARMv7.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1585715222-24489-1-git-send-email-Anson.Huang@nxp.com
---
 drivers/clocksource/timer-imx-tpm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 6334a35..2cdc077 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -61,17 +61,19 @@ static inline void tpm_irq_acknowledge(void)
 	writel(TPM_STATUS_CH0F, timer_base + TPM_STATUS);
 }
 
-static struct delay_timer tpm_delay_timer;
-
 static inline unsigned long tpm_read_counter(void)
 {
 	return readl(timer_base + TPM_CNT);
 }
 
+#if defined(CONFIG_ARM)
+static struct delay_timer tpm_delay_timer;
+
 static unsigned long tpm_read_current_timer(void)
 {
 	return tpm_read_counter();
 }
+#endif
 
 static u64 notrace tpm_read_sched_clock(void)
 {
@@ -144,9 +146,11 @@ static struct timer_of to_tpm = {
 
 static int __init tpm_clocksource_init(void)
 {
+#if defined(CONFIG_ARM)
 	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
 	tpm_delay_timer.freq = timer_of_rate(&to_tpm) >> 3;
 	register_current_timer_delay(&tpm_delay_timer);
+#endif
 
 	sched_clock_register(tpm_read_sched_clock, counter_width,
 			     timer_of_rate(&to_tpm) >> 3);

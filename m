Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC5EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 04:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2AF20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 04:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgDAEeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:34:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37018 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDAEeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 00:34:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D75D41A0C60;
        Wed,  1 Apr 2020 06:34:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0448E1A0C68;
        Wed,  1 Apr 2020 06:34:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B6DD74024E;
        Wed,  1 Apr 2020 12:34:21 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] clocksource/drivers/imx-tpm: Add support for ARM64
Date:   Wed,  1 Apr 2020 12:27:02 +0800
Message-Id: <1585715222-24489-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows building and compile-testing the i.MX TPM driver also
for ARM64. The delay_timer is only supported on ARMv7.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
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
-- 
2.7.4


Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE84C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B7B20732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCSIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59706 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:47:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqC-0002xS-M0; Thu, 19 Mar 2020 09:47:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4FCB31C2298;
        Thu, 19 Mar 2020 09:47:48 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:47 -0000
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Add support to
 get pwm current status
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgen <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200305082715.15861-6-lokeshvutla@ti.com>
References: <20200305082715.15861-6-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <158460766792.28353.14134380643914951850.tip-bot2@tip-bot2>
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

Commit-ID:     92fd86864ec4ac089de47f0f1f4c47418b343448
Gitweb:        https://git.kernel.org/tip/92fd86864ec4ac089de47f0f1f4c47418b343448
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 05 Mar 2020 13:57:14 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 16 Mar 2020 12:40:42 +01:00

clocksource/drivers/timer-ti-dm: Add support to get pwm current status

omap_dm_timer_ops provide support to configure the pwm but there is no
support to get the current status. For configuring pwm it is advised to
check the current hw status instead of relying on pwm framework. So
implement a new timer ops to get the current status of pwm.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Tony Lindgen <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200305082715.15861-6-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c          | 15 +++++++++++++++
 include/linux/platform_data/dmtimer-omap.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b565b84..73ac73e 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -627,6 +627,20 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	return 0;
 }
 
+static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
+{
+	u32 l;
+
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	omap_dm_timer_enable(timer);
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	omap_dm_timer_disable(timer);
+
+	return l;
+}
+
 static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 					int prescaler)
 {
@@ -927,6 +941,7 @@ static const struct omap_dm_timer_ops dmtimer_ops = {
 	.set_load = omap_dm_timer_set_load,
 	.set_match = omap_dm_timer_set_match,
 	.set_pwm = omap_dm_timer_set_pwm,
+	.get_pwm_status = omap_dm_timer_get_pwm_status,
 	.set_prescaler = omap_dm_timer_set_prescaler,
 	.read_counter = omap_dm_timer_read_counter,
 	.write_counter = omap_dm_timer_write_counter,
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
index bdaaf53..3173b7b 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -36,6 +36,7 @@ struct omap_dm_timer_ops {
 			     unsigned int match);
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger);
+	int	(*get_pwm_status)(struct omap_dm_timer *timer);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
 
 	unsigned int (*read_counter)(struct omap_dm_timer *timer);

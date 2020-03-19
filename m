Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15509C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD972076E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCSIrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:47:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:47:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqC-0002xG-5J; Thu, 19 Mar 2020 09:47:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A07521C2297;
        Thu, 19 Mar 2020 09:47:46 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:46 -0000
From:   "tip-bot2 for Saravana Kannan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-probe: Avoid creating
 dead devices
Cc:     Saravana Kannan <saravanak@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200111052125.238212-1-saravanak@google.com>
References: <20200111052125.238212-1-saravanak@google.com>
MIME-Version: 1.0
Message-ID: <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
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

Commit-ID:     4f41fe386a94639cd9a1831298d4f85db5662f1e
Gitweb:        https://git.kernel.org/tip/4f41fe386a94639cd9a1831298d4f85db5662f1e
Author:        Saravana Kannan <saravanak@google.com>
AuthorDate:    Fri, 10 Jan 2020 21:21:25 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 17 Mar 2020 13:10:07 +01:00

clocksource/drivers/timer-probe: Avoid creating dead devices

Timer initialization is done during early boot way before the driver
core starts processing devices and drivers. Timers initialized during
this early boot period don't really need or use a struct device.

However, for timers represented as device tree nodes, the struct devices
are still created and sit around unused and wasting memory. This change
avoid this by marking the device tree nodes as "populated" if the
corresponding timer is successfully initialized.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200111052125.238212-1-saravanak@google.com
---
 drivers/clocksource/timer-probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index ee9574d..a10f28d 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -27,8 +27,10 @@ void __init timer_probe(void)
 
 		init_func_ret = match->data;
 
+		of_node_set_flag(np, OF_POPULATED);
 		ret = init_func_ret(np);
 		if (ret) {
+			of_node_clear_flag(np, OF_POPULATED);
 			if (ret != -EPROBE_DEFER)
 				pr_err("Failed to initialize '%pOF': %d\n", np,
 				       ret);

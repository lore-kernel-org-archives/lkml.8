Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535F7C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30744206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgC1KbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:31:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55466 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1KbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:31:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI8jz-0003Ko-DT; Sat, 28 Mar 2020 11:30:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D665E1C03A9;
        Sat, 28 Mar 2020 11:30:58 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:30:58 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Revert "clocksource/drivers/timer-probe: Avoid
 creating dead devices"
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Saravana Kannan <saravanak@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324175955.GA16972@arm.com>
References: <20200324175955.GA16972@arm.com>
MIME-Version: 1.0
Message-ID: <158539145844.28353.14324600021087747539.tip-bot2@tip-bot2>
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

Commit-ID:     4479730e9263befbb9ce9563a09563db2acb8f7c
Gitweb:        https://git.kernel.org/tip/4479730e9263befbb9ce9563a09563db2acb8f7c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 28 Mar 2020 11:20:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Mar 2020 11:25:44 +01:00

Revert "clocksource/drivers/timer-probe: Avoid creating dead devices"

This reverts commit 4f41fe386a94639cd9a1831298d4f85db5662f1e.

The change breaks systems on which the DT node of a device is used by
multiple drivers. The proposed workaround to clear OF_POPULATED is just a
band aid and this needs to be cleaned up at the root of the problem.

Revert this for now.

Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Requested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200324175955.GA16972@arm.com
---
 drivers/clocksource/timer-probe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index a10f28d..ee9574d 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -27,10 +27,8 @@ void __init timer_probe(void)
 
 		init_func_ret = match->data;
 
-		of_node_set_flag(np, OF_POPULATED);
 		ret = init_func_ret(np);
 		if (ret) {
-			of_node_clear_flag(np, OF_POPULATED);
 			if (ret != -EPROBE_DEFER)
 				pr_err("Failed to initialize '%pOF': %d\n", np,
 				       ret);

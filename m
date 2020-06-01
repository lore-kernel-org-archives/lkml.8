Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ACFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88986207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgFANMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgFANLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:11:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B862AC061A0E;
        Mon,  1 Jun 2020 06:11:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfkEG-00078v-Iw; Mon, 01 Jun 2020 15:11:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 35C8E1C04CE;
        Mon,  1 Jun 2020 15:11:48 +0200 (CEST)
Date:   Mon, 01 Jun 2020 13:11:48 -0000
From:   "tip-bot2 for Rob Herring" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/versatile: Allow
 CONFIG_CLKSRC_VERSATILE to be disabled
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200417212045.16917-1-robh@kernel.org>
References: <20200417212045.16917-1-robh@kernel.org>
MIME-Version: 1.0
Message-ID: <159101710808.17951.219389445205607645.tip-bot2@tip-bot2>
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

Commit-ID:     bfed0eded1ce00bda5cc2d2939b017f88e6b1fd0
Gitweb:        https://git.kernel.org/tip/bfed0eded1ce00bda5cc2d2939b017f88e6b1fd0
Author:        Rob Herring <robh@kernel.org>
AuthorDate:    Fri, 17 Apr 2020 16:20:45 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 27 Apr 2020 11:33:44 +02:00

clocksource/drivers/versatile: Allow CONFIG_CLKSRC_VERSATILE to be disabled

The timer-versatile driver provides a sched_clock for certain Arm Ltd.
reference platforms. Specifically, it is used on Versatile and 32-bit
VExpress. It is not needed for those platforms with an arch timer (all
the 64-bit ones) yet CONFIG_MFD_VEXPRESS_SYSREG does still need to be
enabled. In that case, the timer-versatile can only be disabled when
COMPILE_TEST is enabled which is not desirable. Let's use the sub-arch
kconfig symbols instead.

Realview platforms don't have the sysregs that this driver uses so
correct the help text.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200417212045.16917-1-robh@kernel.org
---
 drivers/clocksource/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f225c27..9c2d72b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -562,12 +562,11 @@ config CLKSRC_VERSATILE
 	bool "ARM Versatile (Express) reference platforms clock source" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
 	select TIMER_OF
-	default y if MFD_VEXPRESS_SYSREG
+	default y if (ARCH_VEXPRESS || ARCH_VERSATILE) && ARM
 	help
 	  This option enables clock source based on free running
 	  counter available in the "System Registers" block of
-	  ARM Versatile, RealView and Versatile Express reference
-	  platforms.
+	  ARM Versatile and Versatile Express reference platforms.
 
 config CLKSRC_MIPS_GIC
 	bool

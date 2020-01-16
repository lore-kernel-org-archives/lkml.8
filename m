Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1EAC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780182075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbgAPVbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:31:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53582 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389037AbgAPVbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjL-0001ZU-Bk; Thu, 16 Jan 2020 22:31:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5A76A1C1996;
        Thu, 16 Jan 2020 22:31:03 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:31:03 -0000
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Fix Kconfig indentation
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191120134236.15959-1-krzk@kernel.org>
References: <20191120134236.15959-1-krzk@kernel.org>
MIME-Version: 1.0
Message-ID: <157921026318.396.3072238434185037949.tip-bot2@tip-bot2>
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

Commit-ID:     9ca9fe69eedb483c0811a4db7cb94942edfb1404
Gitweb:        https://git.kernel.org/tip/9ca9fe69eedb483c0811a4db7cb94942edfb1404
Author:        Krzysztof Kozlowski <krzk@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 21:42:36 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:06:57 +01:00

clocksource: Fix Kconfig indentation

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191120134236.15959-1-krzk@kernel.org
---
 drivers/clocksource/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fdd76c..c981ff6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -470,7 +470,7 @@ config OXNAS_RPS_TIMER
 	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
 
 config SYS_SUPPORTS_SH_CMT
-        bool
+	bool
 
 config MTK_TIMER
 	bool "Mediatek timer driver" if COMPILE_TEST
@@ -490,13 +490,13 @@ config SPRD_TIMER
 	  Enables support for the Spreadtrum timer driver.
 
 config SYS_SUPPORTS_SH_MTU2
-        bool
+	bool
 
 config SYS_SUPPORTS_SH_TMU
-        bool
+	bool
 
 config SYS_SUPPORTS_EM_STI
-        bool
+	bool
 
 config CLKSRC_JCORE_PIT
 	bool "J-Core PIT timer driver" if COMPILE_TEST
@@ -591,21 +591,21 @@ config CLKSRC_PXA
 	  platforms.
 
 config H8300_TMR8
-        bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 8 bits timer for the H8300 platform.
 
 config H8300_TMR16
-        bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the 16 bits timer for the H8300 platform with the
 	  H83069 cpu.
 
 config H8300_TPU
-        bool "Clocksource for the H8300 platform" if COMPILE_TEST
-        depends on HAS_IOMEM
+	bool "Clocksource for the H8300 platform" if COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables the clocksource for the H8300 platform with the
 	  H8S2678 cpu.

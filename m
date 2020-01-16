Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E405C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4602077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbgAPVby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:31:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53546 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388949AbgAPVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjD-0001Vr-PU; Thu, 16 Jan 2020 22:30:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 248441C1970;
        Thu, 16 Jan 2020 22:30:59 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:30:58 -0000
From:   "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/hyper-v: Set TSC clocksource
 as default w/ InvariantTSC
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109160650.16150-3-parri.andrea@gmail.com>
References: <20200109160650.16150-3-parri.andrea@gmail.com>
MIME-Version: 1.0
Message-ID: <157921025889.396.394289795605229140.tip-bot2@tip-bot2>
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

Commit-ID:     9e0333ae38eeb42249e10f95d209244a6e22ac9f
Gitweb:        https://git.kernel.org/tip/9e0333ae38eeb42249e10f95d209244a6e22ac9f
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Thu, 09 Jan 2020 17:06:50 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:09:02 +01:00

clocksource/drivers/hyper-v: Set TSC clocksource as default w/ InvariantTSC

Change the Hyper-V clocksource ratings to 250, below the TSC clocksource
rating of 300.  In configurations where Hyper-V offers an InvariantTSC,
the TSC is not marked "unstable", so the TSC clocksource is available
and preferred.  With the higher rating, it will be the default.  On
older hardware and Hyper-V versions, the TSC is marked "unstable", so no
TSC clocksource is created and the selected Hyper-V clocksource will be
the default.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200109160650.16150-3-parri.andrea@gmail.com
---
 drivers/clocksource/hyperv_timer.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 42748ad..9d808d5 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -302,6 +302,14 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
  * the other that uses the TSC reference page feature as defined in the
  * TLFS.  The MSR version is for compatibility with old versions of
  * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
+ *
+ * The Hyper-V clocksource ratings of 250 are chosen to be below the
+ * TSC clocksource rating of 300.  In configurations where Hyper-V offers
+ * an InvariantTSC, the TSC is not marked "unstable", so the TSC clocksource
+ * is available and preferred.  With the higher rating, it will be the
+ * default.  On older hardware and Hyper-V versions, the TSC is marked
+ * "unstable", so no TSC clocksource is created and the selected Hyper-V
+ * clocksource will be the default.
  */
 
 u64 (*hv_read_reference_counter)(void);
@@ -363,7 +371,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
-	.rating	= 400,
+	.rating	= 250,
 	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -395,7 +403,7 @@ static u64 read_hv_sched_clock_msr(void)
 
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
-	.rating	= 400,
+	.rating	= 250,
 	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,

Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A37FC35E0E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C212176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgBYVLb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:11:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYVLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:11:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6hUE-0002y5-DK; Tue, 25 Feb 2020 22:11:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0F93C1C2154;
        Tue, 25 Feb 2020 22:11:26 +0100 (CET)
Date:   Tue, 25 Feb 2020 21:11:25 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Fix vDSO
 clockmode when vDSO disabled
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224151552.57274-1-vincenzo.frascino@arm.com>
References: <20200224151552.57274-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158266508571.28353.6918690655943094425.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a67de48b3075cbb6ec030205d7b78981def6596d
Gitweb:        https://git.kernel.org/tip/a67de48b3075cbb6ec030205d7b78981def6596d
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Mon, 24 Feb 2020 15:15:52 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Feb 2020 22:08:39 +01:00

clocksource/drivers/arm_arch_timer: Fix vDSO clockmode when vDSO disabled

The arm_arch_timer requires VDSO_CLOCKMODE_ARCHTIMER to be defined to
compile correctly. On ARM the vDSO can be disabled and when this is the
case the compilation ends prematurely with an error:

 $ make ARCH=arm multi_v7_defconfig
 $ ./scripts/config -d VDSO
 $ make

drivers/clocksource/arm_arch_timer.c:73:44: error:
‘VDSO_CLOCKMODE_ARCHTIMER’ undeclared here (not in a function)
  static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;

Make the usage of VDSO_CLOCKMODE_ARCHTIMER depend on the VDSO enablement
and initialize the vdso clockmode variable with VDSO_CLOCKMODE_NONE
otherwise.

[ tglx: Match changelog and patch content. ]

Fixes: 5e3c6a312a09 ("ARM/arm64: vdso: Use common vdso clock mode storage")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200224151552.57274-1-vincenzo.frascino@arm.com

---
 drivers/clocksource/arm_arch_timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ee2420d..d53f4c7 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,7 +69,11 @@ static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
+#else
+static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);

Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA6FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0712077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCYMGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgCYMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nP-0000lj-0q; Wed, 25 Mar 2020 13:06:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4466E1C0493;
        Wed, 25 Mar 2020 13:06:06 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:05 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] ARM: Don't use disable_nonboot_cpus()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-5-qais.yousef@arm.com>
References: <20200323135110.30522-5-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796591.28353.16030659658757557287.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     dddf3578e0d497e66ebe654d0f3258ac20a07e27
Gitweb:        https://git.kernel.org/tip/dddf3578e0d497e66ebe654d0f3258ac20a07e27
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:50:57 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:32 +01:00

ARM: Don't use disable_nonboot_cpus()

disable_nonboot_cpus() is not safe to use when doing machine_down(),
because it relies on freeze_secondary_cpus() which in turn is
a suspend/resume related freeze and could abort if the logic detects any
pending activities that can prevent finishing the offlining process.

Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
is an othogonal config to rely on to ensure this function works
correctly.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Link: https://lkml.kernel.org/r/20200323135110.30522-5-qais.yousef@arm.com

---
 arch/arm/kernel/reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index bb18ed0..58ad1a7 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -88,11 +88,11 @@ void soft_restart(unsigned long addr)
  * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
  * kexec'd kernel to use any and all RAM as it sees fit, without having to
  * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
- * functionality embodied in disable_nonboot_cpus() to achieve this.
+ * functionality embodied in smp_shutdown_nonboot_cpus() to achieve this.
  */
 void machine_shutdown(void)
 {
-	disable_nonboot_cpus();
+	smp_shutdown_nonboot_cpus(0);
 }
 
 /*

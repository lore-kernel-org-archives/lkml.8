Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B6C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6874B20675
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgBYUgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:36:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54474 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbgBYUgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:36:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6gwd-0002P5-Bw; Tue, 25 Feb 2020 21:36:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C56181C2153;
        Tue, 25 Feb 2020 21:36:42 +0100 (CET)
Date:   Tue, 25 Feb 2020 20:36:42 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/urgent] x86/mce/therm_throt: Undo thermal polling properly
 on CPU offline
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <158120068234.18291.7938335950259651295@skylake-alporthouse-com>
References: <158120068234.18291.7938335950259651295@skylake-alporthouse-com>
MIME-Version: 1.0
Message-ID: <158266300251.28353.3340868799140664997.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/urgent branch of tip:

Commit-ID:     d364847eed890211444ad74496bb549f838c6018
Gitweb:        https://git.kernel.org/tip/d364847eed890211444ad74496bb549f838c6018
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 14:55:15 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 25 Feb 2020 21:21:44 +01:00

x86/mce/therm_throt: Undo thermal polling properly on CPU offline

Chris Wilson reported splats from running the thermal throttling
workqueue callback on offlined CPUs. The problem is that that callback
should not even run on offlined CPUs but it happens nevertheless because
the offlining callback thermal_throttle_offline() does not symmetrically
undo the setup work done in its onlining counterpart. IOW,

 1. The thermal interrupt vector should be masked out before ...

 2. ... cancelling any pending work synchronously so that no new work is
 enqueued anymore.

Do those things and fix the issue properly.

 [ bp: Write commit message. ]

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Tested-by: Pandruvada, Srinivas <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/158120068234.18291.7938335950259651295@skylake-alporthouse-com
---
 arch/x86/kernel/cpu/mce/therm_throt.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 58b4ee3..f36dc07 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -486,9 +486,14 @@ static int thermal_throttle_offline(unsigned int cpu)
 {
 	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
+	u32 l;
+
+	/* Mask the thermal vector before draining evtl. pending work */
+	l = apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
 
-	cancel_delayed_work(&state->package_throttle.therm_work);
-	cancel_delayed_work(&state->core_throttle.therm_work);
+	cancel_delayed_work_sync(&state->package_throttle.therm_work);
+	cancel_delayed_work_sync(&state->core_throttle.therm_work);
 
 	state->package_throttle.rate_control_active = false;
 	state->core_throttle.rate_control_active = false;

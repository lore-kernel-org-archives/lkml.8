Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F6C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065E6206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgCOPQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:16:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgCOPQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:16:12 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDUzq-0001iS-3F; Sun, 15 Mar 2020 16:16:10 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 124B81013B2;
        Sun, 15 Mar 2020 16:16:09 +0100 (CET)
Date:   Sun, 15 Mar 2020 15:14:38 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] ras/urgent for 5.6-rc6
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
Message-ID: <158428527863.14940.15328478809140163159.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest ras/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-2020-03-15

up to:  59b5809655bd: x86/mce: Fix logic and comments around MSR_PPIN_CTL


Two RAS related fixes:

  - Shut down the per CPU thermal throttling poll work properly when a CPU
    goes offline. The missing shutdown caused the poll work to be migrated
    to a unbound worker which triggered warnings about the usage of
    smp_processor_id() in preemptible context

  - Fix the PPIN feature initialization which missed to enable the
    functionality when PPIN_CTL was enabled but the MSR locked against
    updates.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      x86/mce/therm_throt: Undo thermal polling properly on CPU offline

Tony Luck (1):
      x86/mce: Fix logic and comments around MSR_PPIN_CTL


 arch/x86/kernel/cpu/mce/intel.c       | 9 +++++----
 arch/x86/kernel/cpu/mce/therm_throt.c | 9 +++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 5627b1091b85..f996ffb887bc 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -493,17 +493,18 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 			return;
 
 		if ((val & 3UL) == 1UL) {
-			/* PPIN available but disabled: */
+			/* PPIN locked in disabled mode */
 			return;
 		}
 
-		/* If PPIN is disabled, but not locked, try to enable: */
-		if (!(val & 3UL)) {
+		/* If PPIN is disabled, try to enable */
+		if (!(val & 2UL)) {
 			wrmsrl_safe(MSR_PPIN_CTL,  val | 2UL);
 			rdmsrl_safe(MSR_PPIN_CTL, &val);
 		}
 
-		if ((val & 3UL) == 2UL)
+		/* Is the enable bit set? */
+		if (val & 2UL)
 			set_cpu_cap(c, X86_FEATURE_INTEL_PPIN);
 	}
 }
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 58b4ee3cda77..f36dc0742085 100644
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


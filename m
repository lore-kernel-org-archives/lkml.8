Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F29C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 11:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC78A2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 11:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgAOLhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:37:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46866 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgAOLhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 06:37:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irgyx-0002fw-Ud; Wed, 15 Jan 2020 12:37:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8546E1C086F;
        Wed, 15 Jan 2020 12:37:07 +0100 (CET)
Date:   Wed, 15 Jan 2020 11:37:07 -0000
From:   "tip-bot2 for Chuansheng Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/urgent] x86/mce/therm_throt: Do not access uninitialized therm_work
Cc:     Chuansheng Liu <chuansheng.liu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200107004116.59353-1-chuansheng.liu@intel.com>
References: <20200107004116.59353-1-chuansheng.liu@intel.com>
MIME-Version: 1.0
Message-ID: <157908822728.396.5161866899997303064.tip-bot2@tip-bot2>
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

Commit-ID:     978370956d2046b19313659ce65ed12d5b996626
Gitweb:        https://git.kernel.org/tip/978370956d2046b19313659ce65ed12d5b996626
Author:        Chuansheng Liu <chuansheng.liu@intel.com>
AuthorDate:    Tue, 07 Jan 2020 00:41:16 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 15 Jan 2020 11:31:33 +01:00

x86/mce/therm_throt: Do not access uninitialized therm_work

It is relatively easy to trigger the following boot splat on an Ice Lake
client platform. The call stack is like:

  kernel BUG at kernel/timer/timer.c:1152!

  Call Trace:
  __queue_delayed_work
  queue_delayed_work_on
  therm_throt_process
  intel_thermal_interrupt
  ...

The reason is that a CPU's thermal interrupt is enabled prior to
executing its hotplug onlining callback which will initialize the
throttling workqueues.

Such a race can lead to therm_throt_process() accessing an uninitialized
therm_work, leading to the above BUG at a very early bootup stage.

Therefore, unmask the thermal interrupt vector only after having setup
the workqueues completely.

 [ bp: Heavily massage commit message and correct comment formatting. ]

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200107004116.59353-1-chuansheng.liu@intel.com
---
 arch/x86/kernel/cpu/mce/therm_throt.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index b38010b..6c3e1c9 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -467,6 +467,7 @@ static int thermal_throttle_online(unsigned int cpu)
 {
 	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
+	u32 l;
 
 	state->package_throttle.level = PACKAGE_LEVEL;
 	state->core_throttle.level = CORE_LEVEL;
@@ -474,6 +475,10 @@ static int thermal_throttle_online(unsigned int cpu)
 	INIT_DELAYED_WORK(&state->package_throttle.therm_work, throttle_active_work);
 	INIT_DELAYED_WORK(&state->core_throttle.therm_work, throttle_active_work);
 
+	/* Unmask the thermal vector after the above workqueues are initialized. */
+	l = apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
@@ -722,10 +727,6 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
 	wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
 
-	/* Unmask the thermal vector: */
-	l = apic_read(APIC_LVTTHMR);
-	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-
 	pr_info_once("CPU0: Thermal monitoring enabled (%s)\n",
 		      tm2 ? "TM2" : "TM1");
 

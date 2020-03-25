Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099DFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD7320771
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCYMG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47735 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nM-0000kA-4e; Wed, 25 Mar 2020 13:06:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C02251C0450;
        Wed, 25 Mar 2020 13:06:03 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:03 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smp: Replace cpu_up/down() with add/remove_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-10-qais.yousef@arm.com>
References: <20200323135110.30522-10-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796344.28353.14308383948160999670.tip-bot2@tip-bot2>
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

Commit-ID:     af7aa04683e85ccb9088e31fe67a0397167b7abd
Gitweb:        https://git.kernel.org/tip/af7aa04683e85ccb9088e31fe67a0397167b7abd
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:51:02 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:35 +01:00

x86/smp: Replace cpu_up/down() with add/remove_cpu()

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down().

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down() a private interface of the CPU
subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323135110.30522-10-qais.yousef@arm.com

---
 arch/x86/kernel/topology.c | 22 ++++++----------------
 arch/x86/mm/mmio-mod.c     |  4 ++--
 arch/x86/xen/smp.c         |  2 +-
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index be5bc2e..b8810eb 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -59,39 +59,29 @@ __setup("cpu0_hotplug", enable_cpu0_hotplug);
  */
 int _debug_hotplug_cpu(int cpu, int action)
 {
-	struct device *dev = get_cpu_device(cpu);
 	int ret;
 
 	if (!cpu_is_hotpluggable(cpu))
 		return -EINVAL;
 
-	lock_device_hotplug();
-
 	switch (action) {
 	case 0:
-		ret = cpu_down(cpu);
-		if (!ret) {
+		ret = remove_cpu(cpu);
+		if (!ret)
 			pr_info("DEBUG_HOTPLUG_CPU0: CPU %u is now offline\n", cpu);
-			dev->offline = true;
-			kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
-		} else
+		else
 			pr_debug("Can't offline CPU%d.\n", cpu);
 		break;
 	case 1:
-		ret = cpu_up(cpu);
-		if (!ret) {
-			dev->offline = false;
-			kobject_uevent(&dev->kobj, KOBJ_ONLINE);
-		} else {
+		ret = add_cpu(cpu);
+		if (ret)
 			pr_debug("Can't online CPU%d.\n", cpu);
-		}
+
 		break;
 	default:
 		ret = -EINVAL;
 	}
 
-	unlock_device_hotplug();
-
 	return ret;
 }
 
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index 673de60..109325d 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -386,7 +386,7 @@ static void enter_uniprocessor(void)
 	put_online_cpus();
 
 	for_each_cpu(cpu, downed_cpus) {
-		err = cpu_down(cpu);
+		err = remove_cpu(cpu);
 		if (!err)
 			pr_info("CPU%d is down.\n", cpu);
 		else
@@ -406,7 +406,7 @@ static void leave_uniprocessor(void)
 		return;
 	pr_notice("Re-enabling CPUs...\n");
 	for_each_cpu(cpu, downed_cpus) {
-		err = cpu_up(cpu);
+		err = add_cpu(cpu);
 		if (!err)
 			pr_info("enabled CPU%d.\n", cpu);
 		else
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 7a43b2a..2097fa0 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -132,7 +132,7 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 		if (xen_vcpu_nr(cpu) < MAX_VIRT_CPUS)
 			continue;
 
-		rc = cpu_down(cpu);
+		rc = remove_cpu(cpu);
 
 		if (rc == 0) {
 			/*

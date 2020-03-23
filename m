Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED63C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07AF2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgCWNwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:52:08 -0400
Received: from foss.arm.com ([217.140.110.172]:49566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgCWNvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:51:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D004113D5;
        Mon, 23 Mar 2020 06:51:37 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D14BA3F52E;
        Mon, 23 Mar 2020 06:51:36 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v4 09/17] x86: Replace cpu_up/down with add/remove_cpu
Date:   Mon, 23 Mar 2020 13:51:02 +0000
Message-Id: <20200323135110.30522-10-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323135110.30522-1-qais.yousef@arm.com>
References: <20200323135110.30522-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/topology.c | 22 ++++++----------------
 arch/x86/mm/mmio-mod.c     |  4 ++--
 arch/x86/xen/smp.c         |  2 +-
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index be5bc2e47c71..b8810ebbc8ae 100644
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
index 673de6063345..109325d77b3e 100644
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
index 7a43b2ae19f1..2097fa0ebdb5 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -132,7 +132,7 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 		if (xen_vcpu_nr(cpu) < MAX_VIRT_CPUS)
 			continue;
 
-		rc = cpu_down(cpu);
+		rc = remove_cpu(cpu);
 
 		if (rc == 0) {
 			/*
-- 
2.17.1


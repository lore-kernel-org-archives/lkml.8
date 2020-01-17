Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1BEC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB072072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgAQSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:41:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57330 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgAQSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:41:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isWYr-0006WV-N7; Fri, 17 Jan 2020 19:41:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 437AC1C19F0;
        Fri, 17 Jan 2020 19:41:37 +0100 (CET)
Date:   Fri, 17 Jan 2020 18:41:37 -0000
From:   "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Check monitoring static key in the MBM
 overflow handler
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1576094705-13660-1-git-send-email-xiaochen.shen@intel.com>
References: <1576094705-13660-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Message-ID: <157928649703.396.16058225567355678427.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     536a0d8e79fb928f2735db37dda95682b6754f9a
Gitweb:        https://git.kernel.org/tip/536a0d8e79fb928f2735db37dda95682b6754f9a
Author:        Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate:    Thu, 12 Dec 2019 04:05:05 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 17 Jan 2020 19:32:32 +01:00

x86/resctrl: Check monitoring static key in the MBM overflow handler

Currently, there are three static keys in the resctrl file system:
rdt_mon_enable_key and rdt_alloc_enable_key indicate if the monitoring
feature and the allocation feature are enabled, respectively. The
rdt_enable_key is enabled when either the monitoring feature or the
allocation feature is enabled.

If no monitoring feature is present (either hardware doesn't support a
monitoring feature or the feature is disabled by the kernel command line
option "rdt="), rdt_enable_key is still enabled but rdt_mon_enable_key
is disabled.

MBM is a monitoring feature. The MBM overflow handler intends to
check if the monitoring feature is not enabled for fast return.

So check the rdt_mon_enable_key in it instead of the rdt_enable_key as
former is the more accurate check.

 [ bp: Massage commit message. ]

Fixes: e33026831bdb ("x86/intel_rdt/mbm: Handle counter overflow")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1576094705-13660-1-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e49b772..181c992 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -57,6 +57,7 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
 }
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
+DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
 /**
  * struct mon_evt - Entry in the event list of a resource
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 397206f..773124b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -514,7 +514,7 @@ void mbm_handle_overflow(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	if (!static_branch_likely(&rdt_enable_key))
+	if (!static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
 	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3]);
@@ -543,7 +543,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	if (!static_branch_likely(&rdt_enable_key))
+	if (!static_branch_likely(&rdt_mon_enable_key))
 		return;
 	cpu = cpumask_any(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;

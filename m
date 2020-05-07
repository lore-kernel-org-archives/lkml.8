Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A50A2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgEGN0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgEGN0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:26:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA95C05BD43;
        Thu,  7 May 2020 06:26:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWgXc-0001F7-Qb; Thu, 07 May 2020 15:26:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DF7C31C001A;
        Thu,  7 May 2020 15:26:19 +0200 (CEST)
Date:   Thu, 07 May 2020 13:26:19 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Remove __freeze_secondary_cpus()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200430114004.17477-2-qais.yousef@arm.com>
References: <20200430114004.17477-2-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158885797977.8414.5020896178410312608.tip-bot2@tip-bot2>
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

Commit-ID:     fb7fb84a0c4e8021ddecb157802d58241a3f1a40
Gitweb:        https://git.kernel.org/tip/fb7fb84a0c4e8021ddecb157802d58241a3f1a40
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 30 Apr 2020 12:40:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:18:41 +02:00

cpu/hotplug: Remove __freeze_secondary_cpus()

The refactored function is no longer required as the codepaths that call
freeze_secondary_cpus() are all suspend/resume related now.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Link: https://lkml.kernel.org/r/20200430114004.17477-2-qais.yousef@arm.com

---
 include/linux/cpu.h | 7 +------
 kernel/cpu.c        | 4 ++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 9d34dc3..5269258 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -144,12 +144,7 @@ static inline void get_online_cpus(void) { cpus_read_lock(); }
 static inline void put_online_cpus(void) { cpus_read_unlock(); }
 
 #ifdef CONFIG_PM_SLEEP_SMP
-int __freeze_secondary_cpus(int primary, bool suspend);
-static inline int freeze_secondary_cpus(int primary)
-{
-	return __freeze_secondary_cpus(primary, true);
-}
-
+extern int freeze_secondary_cpus(int primary);
 extern void thaw_secondary_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d766929..9f89214 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1327,7 +1327,7 @@ void bringup_nonboot_cpus(unsigned int setup_max_cpus)
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
-int __freeze_secondary_cpus(int primary, bool suspend)
+int freeze_secondary_cpus(int primary)
 {
 	int cpu, error = 0;
 
@@ -1352,7 +1352,7 @@ int __freeze_secondary_cpus(int primary, bool suspend)
 		if (cpu == primary)
 			continue;
 
-		if (suspend && pm_wakeup_pending()) {
+		if (pm_wakeup_pending()) {
 			pr_info("Wakeup pending. Abort CPU freeze\n");
 			error = -EBUSY;
 			break;

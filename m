Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50668C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7D02080C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYMGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47722 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCYMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nJ-0000hs-Os; Wed, 25 Mar 2020 13:06:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4604A1C0450;
        Wed, 25 Mar 2020 13:06:01 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:00 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] torture: Replace cpu_up/down() with add/remove_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-16-qais.yousef@arm.com>
References: <20200323135110.30522-16-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796091.28353.8588545097621278073.tip-bot2@tip-bot2>
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

Commit-ID:     457bc8ed3ec7edc567200302d9312ac8bbc31316
Gitweb:        https://git.kernel.org/tip/457bc8ed3ec7edc567200302d9312ac8bbc31316
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:51:08 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:37 +01:00

torture: Replace cpu_up/down() with add/remove_cpu()

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down().

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down() a private interface of the CPU
subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: "Paul E. McKenney" <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20200323135110.30522-16-qais.yousef@arm.com

---
 kernel/torture.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 7c13f55..a479689 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -97,7 +97,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			 torture_type, cpu);
 	starttime = jiffies;
 	(*n_offl_attempts)++;
-	ret = cpu_down(cpu);
+	ret = remove_cpu(cpu);
 	if (ret) {
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
@@ -148,7 +148,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 			 torture_type, cpu);
 	starttime = jiffies;
 	(*n_onl_attempts)++;
-	ret = cpu_up(cpu);
+	ret = add_cpu(cpu);
 	if (ret) {
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
@@ -192,17 +192,18 @@ torture_onoff(void *arg)
 	for_each_online_cpu(cpu)
 		maxcpu = cpu;
 	WARN_ON(maxcpu < 0);
-	if (!IS_MODULE(CONFIG_TORTURE_TEST))
+	if (!IS_MODULE(CONFIG_TORTURE_TEST)) {
 		for_each_possible_cpu(cpu) {
 			if (cpu_online(cpu))
 				continue;
-			ret = cpu_up(cpu);
+			ret = add_cpu(cpu);
 			if (ret && verbose) {
 				pr_alert("%s" TORTURE_FLAG
 					 "%s: Initial online %d: errno %d\n",
 					 __func__, torture_type, cpu, ret);
 			}
 		}
+	}
 
 	if (maxcpu == 0) {
 		VERBOSE_TOROUT_STRING("Only one CPU, so CPU-hotplug testing is disabled");

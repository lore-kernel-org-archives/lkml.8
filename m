Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B997C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2913120658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgCXJTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:19:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43933 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbgCXJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfft-00080m-6P; Tue, 24 Mar 2020 10:16:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8767B1C04CF;
        Tue, 24 Mar 2020 10:16:36 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:36 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Forgive -EBUSY from boottime CPU-hotplug operations
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139618.28353.290010801254983981.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a59ee765a6890e7f4281070008a2654337458311
Gitweb:        https://git.kernel.org/tip/a59ee765a6890e7f4281070008a2654337458311
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 05 Dec 2019 10:49:11 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:30 -08:00

torture: Forgive -EBUSY from boottime CPU-hotplug operations

During boot, CPU hotplug is often disabled, for example by PCI probing.
On large systems that take substantial time to boot, this can result
in spurious RCU_HOTPLUG errors.  This commit therefore forgives any
boottime -EBUSY CPU-hotplug failures by adjusting counters to pretend
that the corresponding attempt never happened.  A non-splat record
of the failed attempt is emitted to the console with the added string
"(-EBUSY forgiven during boot)".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 7c13f55..e377b5b 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -84,6 +84,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 {
 	unsigned long delta;
 	int ret;
+	char *s;
 	unsigned long starttime;
 
 	if (!cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
@@ -99,10 +100,16 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 	(*n_offl_attempts)++;
 	ret = cpu_down(cpu);
 	if (ret) {
+		s = "";
+		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
+			// PCI probe frequently disables hotplug during boot.
+			(*n_offl_attempts)--;
+			s = " (-EBUSY forgiven during boot)";
+		}
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
-				 "torture_onoff task: offline %d failed: errno %d\n",
-				 torture_type, cpu, ret);
+				 "torture_onoff task: offline %d failed%s: errno %d\n",
+				 torture_type, cpu, s, ret);
 	} else {
 		if (verbose > 1)
 			pr_alert("%s" TORTURE_FLAG
@@ -137,6 +144,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 {
 	unsigned long delta;
 	int ret;
+	char *s;
 	unsigned long starttime;
 
 	if (cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
@@ -150,10 +158,16 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 	(*n_onl_attempts)++;
 	ret = cpu_up(cpu);
 	if (ret) {
+		s = "";
+		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
+			// PCI probe frequently disables hotplug during boot.
+			(*n_onl_attempts)--;
+			s = " (-EBUSY forgiven during boot)";
+		}
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
-				 "torture_onoff task: online %d failed: errno %d\n",
-				 torture_type, cpu, ret);
+				 "torture_onoff task: online %d failed%s: errno %d\n",
+				 torture_type, cpu, s, ret);
 	} else {
 		if (verbose > 1)
 			pr_alert("%s" TORTURE_FLAG

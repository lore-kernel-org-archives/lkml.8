Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42874C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2208D21707
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCXJT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:19:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbgCXJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffv-0007zt-Cw; Tue, 24 Mar 2020 10:16:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2D8BE1C0493;
        Tue, 24 Mar 2020 10:16:35 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:34 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Allow disabling of boottime CPU-hotplug
 torture operations
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139485.28353.5086985526657035319.tip-bot2@tip-bot2>
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

Commit-ID:     8171d3e0dafd37a9c833904e5a936f4154a1e95b
Gitweb:        https://git.kernel.org/tip/8171d3e0dafd37a9c833904e5a936f4154a1e95b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 06 Dec 2019 15:02:59 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:30 -08:00

torture: Allow disabling of boottime CPU-hotplug torture operations

In theory, RCU-hotplug operations are supposed to work as soon as there
is more than one CPU online.  However, in practice, in normal production
there is no way to make them happen until userspace is up and running.
Besides which, on smaller systems, rcutorture doesn't start doing hotplug
operations until 30 seconds after the start of boot, which on most
systems also means the better part of 30 seconds after the end of boot.
This commit therefore provides a new torture.disable_onoff_at_boot kernel
boot parameter that suppresses CPU-hotplug torture operations until
about the time that init is spawned.

Of course, if you know of a need for boottime CPU-hotplug operations,
then you should avoid passing this argument to any of the torture tests.
You might also want to look at the splats linked to below.

Link: https://lore.kernel.org/lkml/20191206185208.GA25636@paulmck-ThinkPad-P72/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 kernel/torture.c                                | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ee007b5..868f59a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4873,6 +4873,10 @@
 			topology updates sent by the hypervisor to this
 			LPAR.
 
+	torture.disable_onoff_at_boot= [KNL]
+			Prevent the CPU-hotplug component of torturing
+			until after init has spawned.
+
 	tp720=		[HW,PS2]
 
 	tpm_suspend_pcr=[HW,TPM]
diff --git a/kernel/torture.c b/kernel/torture.c
index e377b5b..8683375 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -42,6 +42,9 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
+static bool disable_onoff_at_boot;
+module_param(disable_onoff_at_boot, bool, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -229,6 +232,10 @@ torture_onoff(void *arg)
 		VERBOSE_TOROUT_STRING("torture_onoff end holdoff");
 	}
 	while (!torture_must_stop()) {
+		if (disable_onoff_at_boot && !rcu_inkernel_boot_has_ended()) {
+			schedule_timeout_interruptible(HZ / 10);
+			continue;
+		}
 		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
 		if (!torture_offline(cpu,
 				     &n_offline_attempts, &n_offline_successes,

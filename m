Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5434C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE3520836
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgBWTaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:30:18 -0500
Received: from foss.arm.com ([217.140.110.172]:51484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgBWTaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:30:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9F53FEC;
        Sun, 23 Feb 2020 11:30:12 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11AE13F6CF;
        Sun, 23 Feb 2020 11:30:11 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] torture: Replace cpu_up/down with add/remove_cpu
Date:   Sun, 23 Feb 2020 19:29:40 +0000
Message-Id: <20200223192942.18420-14-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223192942.18420-1-qais.yousef@arm.com>
References: <20200223192942.18420-1-qais.yousef@arm.com>
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
CC: Davidlohr Bueso <dave@stgolabs.net>
CC: "Paul E. McKenney" <paulmck@kernel.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: linux-kernel@vger.kernel.org
---
 kernel/torture.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 7c13f5558b71..a479689eac73 100644
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
-- 
2.17.1

